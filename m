Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbRBTTC6>; Tue, 20 Feb 2001 14:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130145AbRBTTCk>; Tue, 20 Feb 2001 14:02:40 -0500
Received: from hermes.mixx.net ([212.84.196.2]:62736 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130339AbRBTTCf>;
	Tue, 20 Feb 2001 14:02:35 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Linux-kernel@vger.kernel.org
Subject: [rfc] Near-constant time directory index for Ext2
Date: Tue, 20 Feb 2001 16:04:50 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: tytso@valinux.com, Andreas Dilger <adilger@turbolinux.com>,
        hch@ns.caldera.de, ext2-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-Id: <01022020011905.18944@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier this month a runaway installation script decided to mail all its
problems to root.  After a couple of hours the script aborted, having
created 65535 entries in Postfix's maildrop directory.  Removing those
files took an awfully long time.  The problem is that Ext2 does each
directory access using a simple, linear search though the entire
directory file, resulting in n**2 behaviour to create/delete n files. 
It's about time we fixed that.

Last fall in Miami, Ted Ts'o mentioned some ideas he was playing with
for an Ext2 directory index, including the following points:

  - Fixed-size hash keys instead of names in the index
  - Leaf blocks are normal ext2 directory blocks
  - Leaf blocks are sequental, so readdir doesn't have to be changed

Having thought about it on and off since then, I came up with the
following additional design elements:

  - Logical addressing
    The cost of logical addressing of disk blocks is scarcely higher
    than physical addressing, and logical access through the page cache
    is actually faster than physical addressing because you don't have
    to traverse a tree: you can go straight to the logical block you are
    interested in and only traverse the tree if it's not there.  The
    payoff in terms of not breaking Ext2's existing allocation strategy
    is huge, not to mention friendliness to tools such as e2fsck and
    e2resize.  Finally, logical addressing means Tux2 will support
    this feature without modification. :-)

  - 8 bytes is sufficient for an index entry
    This gives a branching factor of 512 for 4K filesystem blocks
    resulting in log512(n) access time, performance that is almost
    indistinguishable from constant-time.  The 8 bytes allows for a 32
    bit hash key (31 bits actually used, see below) and a 4 byte
    logical block number, both sufficient for handling billions of
    directory entries.

  - Uniform-depth tree
    Usually, some form of balanced tree is used for a directory index. 
    I found that a simple, uniform-depth tree provides equivalent
    performance with far simpler code.  Just two tree levels can handle
    millions of directory entries, and for all practical purposes,
    such a tree is never out of balance.

So to give this a name, it's a "uniform-depth hash tree", or htree for
short.  (It's not a btree.)  Such a structure inherits properties of
both trees and hash tables.  From the hash table side, the htree
inherits the advantage of compact, fixed-size keys  which gives a high
branching factor and enables the use of binary search in interior index
nodes.

It also inherits a big disadvantage of hash tables: key collisions. 
Though rare, collisions give rise to a number of corner cases that
are not particularly easy to deal with.  (see below)

Index Structure
---------------

The root of the index tree is in the 0th block of the file.  Space is
reserved for a second level of the index tree in blocks 1 though 511
(for 4K filesystem blocks).  Directory leaf blocks are appended
starting at block 512, thus the tail of the directory file looks like a
normal Ext2 directory and can be processed directly by ext2_readdir. 
For directories with less than about 90K files there is a hole running
from block 1 to block 511, so an empty directory has just two blocks in
it, though its size appears to be about 2 Meg in a directory listing.

So a directory file looks like:

	0: Root index block
	1: Index block/0
	2: Index block/0
	...
	511: Index block/0
	512: Dirent block
	513: Dirent block
	...

Each index block consists of 512 index entries of the form:

	hash, block

where hash is a 32 bit hash with a collision flag in its least
significant bit, and block is the logical block number of an index of
leaf block, depending on the tree level.

The hash value of the 0th index entry isn't needed because it can
always be obtained from the level about, so it is used to record the
count of index entries in an index block.  This gives a nice round
branching factor of 512, the evenness being a nicety that mainly
satisfies my need to seek regularity, rather than winning any real
performance.  (On the other hand, the largeness of the branching factor
matters a great deal.)

The root index block has the same format as the other index blocks,
with its first 8 bytes reserved for a small header:

	1 byte header length (default: 8)
	1 byte index type (default: 0)
	1 byte hash version (default:0)
	1 byte tree depth (default: 1)

The treatment of the header differs slightly in the attached patch.  In
particular, only a single level of the index tree (the root) is
implemented here.  This turns out to be sufficient to handle more than
90,000 entries, so it is enough for today.  When a second level is
added to the tree, capacity will incease to somewhere around 50
million entries, and there is nothing preventing the use of n levels,
should there ever be a reason.  It's doubtfull that a third level
will ever be required, but if it is, the design provides for it.

Lookup Algorithm
----------------

Lookup is straightforword:

  - Compute a hash of the name
  - Read the index root
  - Use binary search (linear in the current code) to find the
    first index or leaf block that could contain the target hash
    (in tree order)
  - Repeat the above until the lowest tree level is reached
  - Read the leaf directory entry block and do a normal Ext2
    directory block search in it.
  - If the name is found, return its directory entry and buffer
  - Otherwise, if the collision bit of the next directory entry is
    set, continue searching in the successor block

Normally, two logical blocks of the file will need to be accessed, and
one or two metadata index blocks.  The effect of the metadata index
blocks can largely be ignored in terms of disk access time since these
blocks are unlikely to be evicted from cache.  There is some small CPU
cost that can be addressed by moving the whole directory into the page
cache.

Insert Algorithm
----------------

Insertion of new entries into the directory is considerably more
complex than lookup, due to the need to split leaf blocks when they
become full, and to satisfy the conditions that allow hash key
collisions to be handled reliably and efficiently.  I'll just summarize
here:

  - Probe the index as for lookup
  - If the target leaf block is full, split it and note the block
    that will receive the new entry
  - Insert the new entry in the leaf block using the normal Ext2
    directory entry insertion code.

The details of splitting and hash collision handling are somewhat
messy, but I will be happy to dwell on them at length if anyone is
interested.

Splitting
---------

In brief, when a leaf node fills up and we want to put a new entry into
it the leaf has to be split, and its share of the hash space has to
be partitioned.  The most straightforward way to do this is to sort the
entrys by hash value and split somewhere in the middle of the sorted
list.  This operation is log(number_of_entries_in_leaf) and is not a
great cost so long as an efficient sorter is used.  I used Combsort
for this, although Quicksort would have been just as good in this
case since average case performance is more important than worst case. 

An alternative approach would be just to guess a median value for the
hash key, and the partition could be done in linear time, but the
resulting poorer partitioning of hash key space outweighs the small
advantage of the linear partition algorithm.  In any event, the number
of entries needing sorting is bounded by the number that fit in a leaf.

Key Collisions
--------------

Some complexity is introduced by the need to handle sequences of hash
key collisions.  It is desireable to avoid splitting such sequences
between blocks, so the split point of a block is adjusted with this in
mind.  But the possibility still remains that if the block fills up
with identically-hashed entries, the sequence may still have to be
split.  This situation is flagged by placing a 1 in the low bit of the
index entry that points at the sucessor block, which is naturally
interpreted by the index probe as an intermediate value without any
special coding.  Thus, handling the collision problem imposes no real
processing overhead, just come extra code and a slight reduction in the
hash key space.  The hash key space remains  sufficient for any
conceivable number of directory entries, up into the billions.

Hash Function
-------------

The exact properties of the hash function critically affect the
performance of this indexing strategy, as I learned by trying a number
of poor hash functions, at times intentionally.  A poor hash function
will result in many collisions or poor partitioning of the hash space. 
To illustrate why the latter is a problem, consider what happens when a
block is split such that it covers just a few distinct hash values. 
The probability of later index entries hashing into the same, small
hash space is very small.  In practice, once a block is split, if its
hash space is too small it tends to stay half full forever, an effect I
observed in practice.

After some experimentation I came up with a hash function that gives
reasonably good dispersal of hash keys across the entire 31 bit key
space.  This improved the average fullness of leaf blocks considerably,
getting much closer to the theoretical average of 3/4 full.

But the current hash function is just a place holder, waiting for
an better version based on some solid theory.  I currently favor the
idea of using crc32 as the default hash function, but I welcome
suggestions.

Inevitably, no matter how good a hash function I come up with, somebody
will come up with a better one later.  For this reason the design
allows for additional hash functiones to be added, with backward
compatibility.  This is accomplished simply, by including a hash
function number in the index root.  If a new, improved hash function is
added, all the previous versions remain available, and previously
created indexes remain readable.

Of course, the best strategy is to have a good hash function right from
the beginning.  The initial, quick hack has produced results that
certainly have not been disappointing.

Performance
-----------

OK, if you have read this far then this is no doubt the part you've
been waiting for.  In short, the performance improvement over normal
Ext2 has been stunning.  With very small directories performance is
similar to standard Ext2, but as directory size increases standard
Ext2 quickly blows up quadratically, while htree-enhanced Ext2
continues to scale linearly.

Uli Luckas ran benchmarks for file creation in various sizes of
directories ranging from 10,000 to 90,000 files.  The results are
pleasing: total file creation time stays very close to linear, versus
quadratic increase with normal Ext2.

Time to create:

		Indexed		Normal
		=======		======
10000 Files:	0m1.350s	0m23.670s
20000 Files:	0m2.720s	1m20.470s
30000 Files:	0m4.330s	3m9.320s
40000 Files:	0m5.890s	5m48.750s
50000 Files:	0m7.040s	9m31.270s
60000 Files:	0m8.610s	13m52.250s
70000 Files:	0m9.980s	19m24.070s
80000 Files:	0m12.060s	25m36.730s
90000 Files:	0m13.400s	33m18.550s

A graph is posted at:

   http://www.innominate.org/~phillips/htree/performance.png

All of these tests are CPU-bound, which may come as a surprise.  The
directories fit easily in cache, and the limiting factor in the case of
standard Ext2 is the looking up of directory blocks in buffer cache,
and the low level scan of directory entries.  In the case of htree
indexing there are a number of costs to be considered, all of them
pretty well bounded.  Notwithstanding, there are a few obvious
optimizations to be done:

  - Use binary search instead of linear search in the interior index
    nodes.

  - If there is only one leaf block in a directory, bypass the index
    probe, go straight to the block.

  - Map the directory into the page cache instead of the buffer cache.

Each of these optimizations will produce a noticeable improvement in
performance, but naturally it will never be anything like the big jump
going from N**2 to Log512(N), ~= N.  In time the optimizations will be
applied and we can expect to see another doubling or so in performance.

There will be a very slight performance hit when the directory gets big
enough to need a second level.  Because of caching this will be very
small.  Traversing the directories metadata index blocks will be a
bigger cost, and once again, this cost can be reduced by moving the
directory blocks into the page cache.

Typically, we will traverse 3 blocks to read or write a directory
entry, and that number increases to 4-5 with really huge directories. 
But this is really nothing compared to normal Ext2, which traverses
several hundred blocks in the same situation.

Current Implementation
----------------------

The current implementation has only a single level of the htree (the
root) and is sufficient to handle a little more than 90,000 files. 
This good enough for benchmarking.  There has not been a lot of
stability testing yet and indeed there are a number of unhandled error
conditions in the code, and possibly some buffer leaks as well.

This patch is for kernel 2.4.1, but it should be entirely applicable
to the 2.2 series as well.  There it should find a friend: Stephen
Tweedie's Ext3 journalling extension.

To-do List
----------

There is still a fair amount of work remaining before this patch is
ready for regular use.  Here is the to-do list as of today:

  - finalize the file format
  - endianness
  - improve the hash function
  - INCOMPAT flag handling
  - second tree level
  - bullet proofing
  - testing under load

Additionally, some (small) changes will be required in ext2utils.  The
ETA for completion of the items on the to-do list is... pretty soon.

Credits
-------

Thanks to Ted Ts'o for providing the inspiration and essential design
elements.  Many thanks to Uli Luckas for spending large number of
hours drinking beer^H^H^H^H^H^H^H^H^H^H walking through the code with
me, suggesting a number of design improvements and understanding and
fixing at least one part of the code which remains, quite frankly,
beyond me. :-)

Applying and Running the patch
------------------------------

The patch adds a symbol to ext2_fs.h, CONFIG_EXT2_INDEX, which
controls whether the htree index feature is enabled or not - it
defaults to on.

  - Use a test machine, not your workstation :-)
  - cd to the 2.4.1 source root
  - patch -p0 <this.email
  - build and install - should have no effect on normal operation
  - mount /dev/hdxxx /test -t ext2 -o index

All new directories in the mounted partition will be created indexed.

Here is the patch:

--- ../2.4.1.uml.clean/fs/ext2/dir.c	Sat Dec  9 02:35:54 2000
+++ ./fs/ext2/dir.c	Tue Feb 20 04:21:25 2001
@@ -67,22 +67,24 @@
 {
 	int error = 0;
 	unsigned long offset, blk;
-	int i, num, stored;
-	struct buffer_head * bh, * tmp, * bha[16];
-	struct ext2_dir_entry_2 * de;
-	struct super_block * sb;
-	int err;
+	int i, num, stored = 0, err;
+	struct buffer_head *bh = NULL, *tmp, *bha[16];
+	struct ext2_dir_entry_2 *de;
 	struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
+	unsigned blockshift = EXT2_BLOCK_SIZE_BITS(sb);
+#ifdef CONFIG_EXT2_INDEX
+	int dir_base = is_dx(inode)? dx_dir_base(sb): 0;
+#else
+	int dir_base = 0;
+#endif
 
-	sb = inode->i_sb;
-
-	stored = 0;
-	bh = NULL;
 	offset = filp->f_pos & (sb->s_blocksize - 1);
 
-	while (!error && !stored && filp->f_pos < inode->i_size) {
-		blk = (filp->f_pos) >> EXT2_BLOCK_SIZE_BITS(sb);
-		bh = ext2_bread (inode, blk, 0, &err);
+	while (!error && !stored && filp->f_pos < inode->i_size - (dir_base << blockshift))
+	{
+		blk = (filp->f_pos) >> blockshift;
+		bh = ext2_bread (inode, dir_base + blk, 0, &err);
 		if (!bh) {
 			ext2_error (sb, "ext2_readdir",
 				    "directory #%lu contains a hole at offset %lu",
@@ -95,9 +97,9 @@
 		 * Do the readahead
 		 */
 		if (!offset) {
-			for (i = 16 >> (EXT2_BLOCK_SIZE_BITS(sb) - 9), num = 0;
-			     i > 0; i--) {
-				tmp = ext2_getblk (inode, ++blk, 0, &err);
+			for (i = 16 >> (blockshift - 9), num = 0; i > 0; i--)
+			{
+				tmp = ext2_getblk (inode, dir_base + ++blk, 0, &err);
 				if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
 					bha[num++] = tmp;
 				else
@@ -140,8 +142,7 @@
 			de = (struct ext2_dir_entry_2 *) (bh->b_data + offset);
 			if (!ext2_check_dir_entry ("ext2_readdir", inode, de,
 						   bh, offset)) {
-				/* On error, skip the f_pos to the
-                                   next block. */
+				/* On error, skip the f_pos to the next block. */
 				filp->f_pos = (filp->f_pos | (sb->s_blocksize - 1))
 					      + 1;
 				brelse (bh);
--- ../2.4.1.uml.clean/fs/ext2/namei.c	Sat Dec  9 02:35:54 2000
+++ ./fs/ext2/namei.c	Tue Feb 20 16:00:53 2001
@@ -18,13 +18,13 @@
  *  	for B-tree directories by Theodore Ts'o (tytso@mit.edu), 1998
  */
 
+#define CONFIG_EXT2_INDEX
+
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
 #include <linux/locks.h>
 #include <linux/quotaops.h>
 
-
-
 /*
  * define how far ahead to read directories while searching them.
  */
@@ -33,6 +33,250 @@
 #define NAMEI_RA_SIZE        (NAMEI_RA_CHUNKS * NAMEI_RA_BLOCKS)
 #define NAMEI_RA_INDEX(c,b)  (((c) * NAMEI_RA_BLOCKS) + (b))
 
+#ifdef CONFIG_EXT2_INDEX
+#define dxtrace(command)
+#define dxtrace_on(command) command
+#define dxtrace_off(command)
+
+/*
+ * Order n log(n) sort utility with n log(n) worst case
+ */
+
+#ifndef COMBSORT
+#define COMBSORT(size, i, j, COMPARE, EXCHANGE) { \
+	unsigned gap = size, more, i; \
+	do { \
+		if (gap > 1) gap = gap*10/13; \
+		if (gap - 9 < 2) gap = 11; \
+		for (i = size - 1, more = gap > 1; i >= gap; i--) { \
+			int j = i - gap; \
+			if (COMPARE) { EXCHANGE; more = 1; } } \
+	} while (more); }
+#endif
+
+#ifndef exchange
+#define exchange(x, y) do { typeof(x) z = x; x = y; y = z; } while (0)
+#endif
+
+/*
+ * Structure of the directory root block
+ */
+
+struct dx_root
+{
+	struct dx_root_info
+	{
+		u32 total_entries;
+		u32 reserved_zero;
+	}
+	info;
+	struct dx_entry
+	{
+		u32 hash;
+		u32 block;
+	} 
+	entries[0];
+};
+
+/*
+ * Bookkeeping for index traversal
+ */
+
+struct dx_frame
+{
+	struct buffer_head *bh;
+	struct dx_entry *entries;
+	struct dx_entry *at;
+	struct dx_root_info *info;
+	unsigned count;
+	unsigned limit;
+};
+
+/*
+ * Sort map for splitting leaf
+ */
+
+struct dx_map_entry
+{
+	u32 hash;
+	u32 offs;
+};
+
+#define MAX_DX_MAP (PAGE_SIZE/EXT2_DIR_REC_LEN(1) + 1)
+/* Assumes file blocksize <= PAGE_SIZE */
+
+#if 1
+unsigned dx_hash (const char *name, int namelen)
+{
+	u32 hash0 = 0x12a3fe2d, hash1 = 0x37abe8f9;
+	if (!namelen) return 0;
+	while (namelen--)
+	{
+		u32 hash = hash1 + (hash0 ^ (*name++ * 71523));
+		if (hash < 0) hash -= 0x7fffffff;
+		hash1 = hash0;
+		hash0 = hash;
+	}
+	return ((hash0 & -1) << 1);
+}
+#else
+/*
+ * A simple hash // need hash function upgrade support
+ */
+
+int dx_hash (const char *name, int namelen)
+{
+	u32 hash = 0;
+	if (!namelen) BUG();
+	while (namelen--) hash = *(name++) + (hash << 6);
+	return hash << 1;
+}
+#endif
+
+/*
+ * Probe to find a directory leaf block to search
+ */
+
+int dx_probe (struct inode *dir, u32 hash, struct dx_frame *dxframe)
+{
+	int count, search, err;
+	struct buffer_head *bh;
+	struct dx_entry *at, *at0;
+
+	dxtrace(printk("Look up %u.", hash));
+	if (!(bh = ext2_bread (dir, 0, 0, &err)))
+	{
+		dxframe->bh = NULL;
+		return -1;
+	}
+
+	/* First hash field holds count of entries */
+	at = at0 = ((struct dx_root *) (bh->b_data))->entries;
+	if (!(count = *(u32 *) at)) BUG();
+	search = count - 1; // should use binary search
+
+	while (search--)
+	{
+		dxtrace(printk("."));
+		if ((++at)->hash > hash)
+		{
+			at--;
+			break;
+		}
+	}
+	dxtrace(printk(" in %u:%u\n", at - at0, at->block));
+	dxframe->info = (struct dx_root_info *) bh->b_data;
+	dxframe->bh = bh;
+	dxframe->entries = at0;
+	dxframe->at = at;
+	dxframe->count = count;
+	dxframe->limit = (bh->b_size - sizeof(struct dx_root_info)) / sizeof(struct dx_entry);
+	return 0;
+}
+
+/*
+ * Prior to split, finds record offset, computes hash of each dir block record
+ */
+
+static int dx_make_map (struct ext2_dir_entry_2 *de, int size, struct dx_map_entry map[])
+{
+	int count = 0;
+	char *base = (char *) de;
+	while ((char *) de < base + size)
+	{
+		map[count].hash = dx_hash (de->name, de->name_len);
+		map[count].offs = (u32) ((char *) de - base);
+		de = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
+		count++;
+	}
+	return count;
+}
+
+/*
+ * For dir block splitting and compacting
+ */
+
+struct ext2_dir_entry_2 *dx_copy (
+	char *from, char *to, unsigned size, // should pass from, to as de's (uli)
+	struct dx_map_entry map[], int start, int count)
+{
+	struct ext2_dir_entry_2 *de = NULL;
+	char *top = to + size;
+	unsigned rec_len = 0;
+	if (!count) BUG();
+	while (count--)
+	{
+		de = (struct ext2_dir_entry_2 *) (from + map[start++].offs);
+		rec_len = EXT2_DIR_REC_LEN(de->name_len);
+		if (to + rec_len > top) BUG();
+		memcpy (to, de, rec_len);
+		((struct ext2_dir_entry_2 *) to)->rec_len = rec_len;
+		to += rec_len;
+	}
+	return (struct ext2_dir_entry_2 *) (to - rec_len);
+}
+
+void dx_adjust (struct ext2_dir_entry_2 *de, char *limit)
+{
+	de->rec_len = limit - (char *) de; // need to clear top?
+}
+
+/*
+ * Debug
+ */
+
+void dx_show_index (struct dx_frame *dxframe)
+{
+	struct dx_entry *entries = dxframe->entries;
+	int i = 0;
+	printk("Index: ");
+	for (;i < *(u32 *) entries; i++)
+	{
+		printk("%u@%u ", entries[i].hash, entries[i].block);
+	}
+	printk("\n");
+}
+
+void dx_show_leaf (struct ext2_dir_entry_2 *de, int size)
+{
+	int count = 0;
+	char *base = (char *) de;
+	printk("dirblock: ");
+	while ((char *) de < base + size)
+	{
+		{ int n = de->name_len; char *s = de->name; while (n--) printk("%c", *s++); }
+		printk(":%u.%u ", dx_hash (de->name, de->name_len), (u32) ((char *) de - base));
+		de = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
+		count++;
+	}
+	printk("(%i)\n", count);
+}
+
+void dx_show_buckets (struct inode *dir)
+{
+	struct super_block *sb = dir->i_sb;
+	int blockshift = EXT2_BLOCK_SIZE_BITS (sb), blocksize = 1 << blockshift;
+	int count, i, err;
+	struct dx_entry *at;
+	struct buffer_head *bh, *dbh;
+	if (!(dbh = ext2_bread (dir, 0, 0, &err))) return;
+	at = ((struct dx_root *) (dbh->b_data))->entries;
+	count = *(u32 *) at;
+	printk("%i indexed blocks...\n", count);
+	for (i = 0; i < count; i++, at++)
+	{
+		u32 hash = i? at->hash: 0;
+		u32 range = i == count - 1? ~at->hash: ((at + 1)->hash - hash);
+		printk("%i:%u hash %u/%u", i, at->block, hash, range);
+		if (!(bh = ext2_bread (dir, at->block, 0, &err))) continue;
+		dx_show_leaf ((struct ext2_dir_entry_2 *) bh->b_data, blocksize);
+		brelse (bh);
+	}
+	brelse(dbh);
+	printk("\n");
+}
+#endif
+
 /*
  * NOTE! unlike strncmp, ext2_match returns 1 for success, 0 for failure.
  *
@@ -49,36 +293,94 @@
 	return !memcmp(name, de->name, len);
 }
 
+struct ext2_dir_entry_2 *ext2_find_de (struct buffer_head *bh,
+	const char *const name, int namelen,
+	int *err, struct inode *dir, u32 offset)
+	/* dir, offset used only in error report */
+{
+	struct ext2_dir_entry_2 *de = (struct ext2_dir_entry_2 *) bh->b_data;
+	char *top = (char *) de + bh->b_size;
+	while ((char *) de < top) {
+		/* this code may be executed quadratically often */
+		/* do minimal checking `by hand' */
+		int de_len;
+		if ((char *) de + namelen <= top && ext2_match (namelen, name, de)) // is the compare to top really needed??
+		{
+			/* found a match - just to be sure, do a full check */
+			if (!ext2_check_dir_entry("ext2_find_entry", dir, de, bh, offset))
+				goto error;
+			*err = 0;
+			return de;
+		}
+		de_len = le16_to_cpu(de->rec_len);
+		/* prevent looping on a bad block */
+		if (de_len <= 0)
+			goto error;
+		de = (struct ext2_dir_entry_2 *) ((char *) de + de_len);
+		offset += de_len;
+	}
+	*err = 0;
+	return NULL;
+error:
+	*err = 1;
+	return NULL;
+}
+
 /*
- *	ext2_find_entry()
- *
- * finds an entry in the specified directory with the wanted name. It
- * returns the cache buffer in which the entry was found, and the entry
- * itself (as a parameter - res_dir). It does NOT read the inode of the
- * entry - you'll have to do that yourself if you want to.
- */
-static struct buffer_head * ext2_find_entry (struct inode * dir,
-					     const char * const name, int namelen,
-					     struct ext2_dir_entry_2 ** res_dir)
-{
-	struct super_block * sb;
-	struct buffer_head * bh_use[NAMEI_RA_SIZE];
-	struct buffer_head * bh_read[NAMEI_RA_SIZE];
+ * Find an entry in the specified directory with the wanted name.  Return 
+ * the buffer the entry was found in, and set the entry through a pointer.
+ */
+static struct buffer_head *ext2_find_entry (
+	struct inode *dir, 
+	const char *name, int namelen,
+	struct ext2_dir_entry_2 **res_dir)
+{
+	struct super_block *sb = dir->i_sb;
+	struct buffer_head *bh_use[NAMEI_RA_SIZE];
+	struct buffer_head *bh_read[NAMEI_RA_SIZE];
 	unsigned long offset;
 	int block, toread, i, err;
+	int blockshift = EXT2_BLOCK_SIZE_BITS (sb);
 
 	*res_dir = NULL;
-	sb = dir->i_sb;
+	if (namelen > EXT2_NAME_LEN) return NULL;
+#ifdef CONFIG_EXT2_INDEX
+	if (is_dx(dir))
+	{
+		u32 hash = dx_hash (name, namelen);
+		struct ext2_dir_entry_2 *de;
+		struct dx_frame dxframe;
+		struct buffer_head *bh;
+		int err = dx_probe (dir, hash, &dxframe); // don't ignore the error!!
+
+		while (1)
+		{
+			bh = ext2_bread (dir, dxframe.at->block, 0, &err); // don't ignore the error!!
+			de = ext2_find_de (bh, name, namelen, &err, dir, 666); // don't ignore the error!!
+			if (de)
+			{
+				dxtrace(printk("Found %s in %i:%i\n", name, 
+					dxframe.at - dxframe.entries, dxframe.at->block));
+				brelse(dxframe.bh);
+				*res_dir = de;
+				return bh;
+			}
 
-	if (namelen > EXT2_NAME_LEN)
+			brelse(bh);
+			/* Same hash continues in next block?  Search further. */
+			if (++(dxframe.at) - dxframe.entries == dxframe.count) break;
+			if ((dxframe.at->hash & -2) != hash) break;
+			dxtrace(printk("Try next, block %i\n", dxframe.at->block));
+		}
+		brelse(dxframe.bh);
 		return NULL;
-
+	}
+#endif
 	memset (bh_use, 0, sizeof (bh_use));
 	toread = 0;
 	for (block = 0; block < NAMEI_RA_SIZE; ++block) {
 		struct buffer_head * bh;
-
-		if ((block << EXT2_BLOCK_SIZE_BITS (sb)) >= dir->i_size)
+			if ((block << blockshift) >= dir->i_size)
 			break;
 		bh = ext2_getblk (dir, block, 0, &err);
 		bh_use[block] = bh;
@@ -86,75 +388,54 @@
 			bh_read[toread++] = bh;
 	}
 
-	for (block = 0, offset = 0; offset < dir->i_size; block++) {
+	for (block = 0, offset = 0; offset < dir->i_size; offset += sb->s_blocksize, block++)
+	{
 		struct buffer_head * bh;
-		struct ext2_dir_entry_2 * de;
-		char * dlimit;
-
-		if ((block % NAMEI_RA_BLOCKS) == 0 && toread) {
+		struct ext2_dir_entry_2 *de;
+		if ((block % NAMEI_RA_BLOCKS) == 0 && toread)
+		{
 			ll_rw_block (READ, toread, bh_read);
 			toread = 0;
 		}
 		bh = bh_use[block % NAMEI_RA_SIZE];
-		if (!bh) {
+		if (!bh)
+		{
 #if 0
 			ext2_error (sb, "ext2_find_entry",
 				    "directory #%lu contains a hole at offset %lu",
 				    dir->i_ino, offset);
 #endif
-			offset += sb->s_blocksize;
 			continue;
 		}
+
 		wait_on_buffer (bh);
-		if (!buffer_uptodate(bh)) {
-			/*
-			 * read error: all bets are off
-			 */
+
+		/* handle read error */
+		if (!buffer_uptodate(bh))
 			break;
-		}
 
-		de = (struct ext2_dir_entry_2 *) bh->b_data;
-		dlimit = bh->b_data + sb->s_blocksize;
-		while ((char *) de < dlimit) {
-			/* this code is executed quadratically often */
-			/* do minimal checking `by hand' */
-			int de_len;
-
-			if ((char *) de + namelen <= dlimit &&
-			    ext2_match (namelen, name, de)) {
-				/* found a match -
-				   just to be sure, do a full check */
-				if (!ext2_check_dir_entry("ext2_find_entry",
-							  dir, de, bh, offset))
-					goto failure;
-				for (i = 0; i < NAMEI_RA_SIZE; ++i) {
-					if (bh_use[i] != bh)
-						brelse (bh_use[i]);
-				}
-				*res_dir = de;
-				return bh;
-			}
-			/* prevent looping on a bad block */
-			de_len = le16_to_cpu(de->rec_len);
-			if (de_len <= 0)
-				goto failure;
-			offset += de_len;
-			de = (struct ext2_dir_entry_2 *)
-				((char *) de + de_len);
+		de = ext2_find_de (bh, name, namelen, &err, dir, offset);
+		if (de)
+		{
+			for (i = 0; i < NAMEI_RA_SIZE; ++i)
+				if (bh_use[i] != bh)
+					brelse (bh_use[i]);
+			*res_dir = de;
+			return bh;
 		}
-
+		if (err)
+			goto fail;
 		brelse (bh);
-		if (((block + NAMEI_RA_SIZE) << EXT2_BLOCK_SIZE_BITS (sb)) >=
-		    dir->i_size)
-			bh = NULL;
-		else
+		if (((block + NAMEI_RA_SIZE) << blockshift) < dir->i_size)
 			bh = ext2_getblk (dir, block + NAMEI_RA_SIZE, 0, &err);
+		else
+			bh = NULL;
+
 		bh_use[block % NAMEI_RA_SIZE] = bh;
 		if (bh && !buffer_uptodate(bh))
 			bh_read[toread++] = bh;
 	}
-
-failure:
+fail:
 	for (i = 0; i < NAMEI_RA_SIZE; ++i)
 		brelse (bh_use[i]);
 	return NULL;
@@ -171,7 +452,8 @@
 
 	bh = ext2_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &de);
 	inode = NULL;
-	if (bh) {
+	if (bh)
+	{
 		unsigned long ino = le32_to_cpu(de->inode);
 		brelse (bh);
 		inode = iget(dir->i_sb, ino);
@@ -202,37 +484,151 @@
 }
 
 /*
- *	ext2_add_entry()
- *
  * adds a file entry to the specified directory.
  */
+
 int ext2_add_entry (struct inode * dir, const char * name, int namelen,
 		    struct inode *inode)
 {
 	unsigned long offset;
-	unsigned short rec_len;
+	unsigned short rec_len = EXT2_DIR_REC_LEN(namelen);
 	struct buffer_head * bh;
-	struct ext2_dir_entry_2 * de, * de1;
-	struct super_block * sb;
-	int	retval;
-
-	sb = dir->i_sb;
+	struct ext2_dir_entry_2 * de, * de2;
+	struct super_block * sb = dir->i_sb;
+	unsigned blockshift = EXT2_BLOCK_SIZE_BITS(sb);
+	unsigned blocksize = 1 << blockshift;
+	int err;
+#ifdef CONFIG_EXT2_INDEX
+	struct dx_frame dxframe;
+	u32 hash;
+#endif
 
-	if (!namelen)
-		return -EINVAL;
-	bh = ext2_bread (dir, 0, 0, &retval);
-	if (!bh)
-		return retval;
-	rec_len = EXT2_DIR_REC_LEN(namelen);
+	if (!namelen) return -EINVAL;
+#ifdef CONFIG_EXT2_INDEX
+	if (is_dx(dir))
+	{
+		hash = dx_hash (name, namelen);
+		dx_probe (dir, hash, &dxframe); // don't ignore the error!!
+		if (!dxframe.bh) return EINVAL;
+		if (!(bh = ext2_bread (dir, dxframe.at->block, 0, &err))) return err;
+	}
+	else
+#endif
+	{
+		if (!(bh = ext2_bread (dir, 0, 0, &err))) return err;
+	}
 	offset = 0;
 	de = (struct ext2_dir_entry_2 *) bh->b_data;
-	while (1) {
-		if ((char *)de >= sb->s_blocksize + bh->b_data) {
+	while (1) 
+	{
+		if ((char *) de >= bh->b_data + blocksize)
+		{
+#ifdef CONFIG_EXT2_INDEX
+		if (is_dx(dir))
+		{
+			u32 block2 = dir->i_size >> blockshift;
+			struct dx_entry *entries = dxframe.entries, *at = dxframe.at;
+			struct buffer_head *bh2;
+			int count, split;
+			int continued; /* true if identical hashes split between two blocks */
+			u32 hash2;
+			dxtrace_off(printk("entry count %i, limit %i\n", dxframe.count, dxframe.limit));
+
+			if (dxframe.count == dxframe.limit)
+			{
+				brelse(bh);
+				brelse (dxframe.bh);
+				return -ENOENT;
+			}
+
+			if (!(bh2 = ext2_getblk (dir, block2, 1, &err)))
+			{
+				brelse(bh);
+				brelse (dxframe.bh);
+				return err;
+			}
+
+			{
+				char *b1 = bh->b_data, *b2, *b3;
+				struct dx_map_entry map[MAX_DX_MAP];
+				count = dx_make_map ((struct ext2_dir_entry_2 *) b1, blocksize, map);
+				split = count/2; // need to adjust to actual middle
+				COMBSORT(count, i, j, map[i].hash < map[j].hash, exchange(map[i], map[j]));
+
+				/* Don't split between duplicate hashes */
+				if (hash <= map[split].hash)
+					while (split && map[split].hash == map[split-1].hash)
+						split--;
+				else
+					while (split < count && map[split].hash == map[split-1].hash)
+						split++;
+				hash2 = map[split].hash;
+				continued = hash == hash2; // this happens to be valid for now
+				dxtrace(printk("Split block %i at %u, %i/%i\n", dxframe.at->block, hash2, split, count-split));
+
+				b2 = bh2->b_data;
+				dir->i_size = dir->i_size += blocksize;
+
+				if (!split || split == count)
+				{
+					// just create an empty dirblock for now
+					de2 = (struct ext2_dir_entry_2 *) b2;
+					de2->inode = 0;
+					de2->rec_len = le16_to_cpu(blocksize);
+				} else {
+					/* Fancy dance to stay within two buffers */
+					de2 = dx_copy (b1, b2, blocksize, map, split, count - split);
+					b3 = (char *) de2 + de2->rec_len;
+					de = dx_copy (b1, b3, blocksize - (b3 - b2), map, 0, split);
+					memcpy(b1, b3, (char *) de + de->rec_len - b3);
+					de = (struct ext2_dir_entry_2 *) ((char *) de - b3 + b1);
+					dx_adjust (de, b1 + blocksize);
+					dx_adjust (de2, b2 + blocksize);
+				}
+
+				dxtrace(dx_show_leaf ((struct ext2_dir_entry_2 *) b1, blocksize));
+				dxtrace(dx_show_leaf ((struct ext2_dir_entry_2 *) b2, blocksize));
+
+				/* Which block gets the new entry? */
+				dxtrace(printk("Insert %s/%u ", name, hash));
+				if (hash >= hash2 || !split || split == count)
+				{
+					dxtrace(printk("above"));
+					exchange(bh, bh2);
+					de = de2;
+				}
+				dxtrace(printk("\n"));
+			}
+
+			memmove (at + 1, at, (char *) (entries + dxframe.count) - (char *) (at));
+			if (continued && (!split || split == count))
+			{
+				/* assuming we put new identical hash into lower entry's block */
+				(at+1)->hash = hash + 1;
+				if (at != dxframe.entries) at->hash = hash;
+				at->block = block2;
+			} else {
+				at++;
+				at->block = block2;
+				at->hash = hash2;
+			}
+			dxframe.count = entries[0].hash++; /* first hash field is entry count */
+
+			/* Clean up and continue with scan for available space */
+			/* New dirent will be added at de in bh */
+			if (!continued) mark_buffer_dirty (bh2);
+			mark_buffer_dirty (dxframe.bh);
+			brelse (dxframe.bh);
+			brelse (bh2);
+			dxframe.bh = NULL; // oops if come here again
+			dxtrace(dx_show_index (&dxframe));
+		} else {
+#endif
 			brelse (bh);
 			bh = NULL;
-			bh = ext2_bread (dir, offset >> EXT2_BLOCK_SIZE_BITS(sb), 1, &retval);
+			bh = ext2_bread (dir, offset >> EXT2_BLOCK_SIZE_BITS(sb), 1, &err);
 			if (!bh)
-				return retval;
+				return err;
 			if (dir->i_size <= offset) {
 				if (dir->i_size == 0) {
 					return -ENOENT;
@@ -244,7 +640,6 @@
 				de->inode = 0;
 				de->rec_len = le16_to_cpu(sb->s_blocksize);
 				dir->i_size = offset + sb->s_blocksize;
-				dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 				mark_inode_dirty(dir);
 			} else {
 
@@ -252,6 +647,9 @@
 
 				de = (struct ext2_dir_entry_2 *) bh->b_data;
 			}
+#ifdef CONFIG_EXT2_INDEX
+		}
+#endif
 		}
 		if (!ext2_check_dir_entry ("ext2_add_entry", dir, de, bh,
 					   offset)) {
@@ -266,12 +664,12 @@
 		    (le16_to_cpu(de->rec_len) >= EXT2_DIR_REC_LEN(de->name_len) + rec_len)) {
 			offset += le16_to_cpu(de->rec_len);
 			if (le32_to_cpu(de->inode)) {
-				de1 = (struct ext2_dir_entry_2 *) ((char *) de +
+				de2 = (struct ext2_dir_entry_2 *) ((char *) de +
 					EXT2_DIR_REC_LEN(de->name_len));
-				de1->rec_len = cpu_to_le16(le16_to_cpu(de->rec_len) -
+				de2->rec_len = cpu_to_le16(le16_to_cpu(de->rec_len) -
 					EXT2_DIR_REC_LEN(de->name_len));
 				de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(de->name_len));
-				de = de1;
+				de = de2;
 			}
 			de->file_type = EXT2_FT_UNKNOWN;
 			if (inode) {
@@ -293,7 +691,6 @@
 			 * and/or different from the directory change time.
 			 */
 			dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-			dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 			mark_inode_dirty(dir);
 			dir->i_version = ++event;
 			mark_buffer_dirty_inode(bh, dir);
@@ -380,6 +777,7 @@
 		return err;
 	}
 	d_instantiate(dentry, inode);
+//	dx_show_buckets (dir);
 	return 0;
 }
 
@@ -408,12 +806,19 @@
 	return err;
 }
 
-static int ext2_mkdir(struct inode * dir, struct dentry * dentry, int mode)
+static int ext2_mkdir (struct inode *dir, struct dentry *dentry, int mode)
 {
-	struct inode * inode;
-	struct buffer_head * dir_block;
-	struct ext2_dir_entry_2 * de;
+	struct super_block *sb = dir->i_sb;
+	struct inode *inode;
+	struct buffer_head *bh;
+	struct ext2_dir_entry_2 *de;
 	int err;
+#ifdef CONFIG_EXT2_INDEX
+	int make_dx = test_opt (sb, DXTREE);
+	int dir_blk = make_dx? dx_dir_base(sb): 0;
+#else
+	int dir_blk = 0;
+#endif
 
 	if (dir->i_nlink >= EXT2_LINK_MAX)
 		return -EMLINK;
@@ -425,40 +830,61 @@
 
 	inode->i_op = &ext2_dir_inode_operations;
 	inode->i_fop = &ext2_dir_operations;
-	inode->i_size = inode->i_sb->s_blocksize;
+	inode->i_size = sb->s_blocksize;
 	inode->i_blocks = 0;	
-	dir_block = ext2_bread (inode, 0, 1, &err);
-	if (!dir_block) {
+	bh = ext2_bread (inode, dir_blk, 1, &err);
+	if (!bh)
+	{
 		inode->i_nlink--; /* is this nlink == 0? */
 		mark_inode_dirty(inode);
 		iput (inode);
 		return err;
 	}
-	de = (struct ext2_dir_entry_2 *) dir_block->b_data;
+	de = (struct ext2_dir_entry_2 *) bh->b_data;
+#ifdef CONFIG_EXT2_INDEX
 	de->inode = cpu_to_le32(inode->i_ino);
 	de->name_len = 1;
 	de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(de->name_len));
 	strcpy (de->name, ".");
-	ext2_set_de_type(dir->i_sb, de, S_IFDIR);
+	ext2_set_de_type(sb, de, S_IFDIR);
 	de = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
 	de->inode = cpu_to_le32(dir->i_ino);
-	de->rec_len = cpu_to_le16(inode->i_sb->s_blocksize - EXT2_DIR_REC_LEN(1));
+	de->rec_len = cpu_to_le16(sb->s_blocksize - EXT2_DIR_REC_LEN(1));
 	de->name_len = 2;
 	strcpy (de->name, "..");
-	ext2_set_de_type(dir->i_sb, de, S_IFDIR);
+	ext2_set_de_type (sb, de, S_IFDIR);
+#else
+	de->rec_len = cpu_to_le16(sb->s_blocksize);
+#endif
 	inode->i_nlink = 2;
-	mark_buffer_dirty_inode(dir_block, dir);
-	brelse (dir_block);
+	mark_buffer_dirty_inode(bh, dir);
+	brelse (bh);
 	inode->i_mode = S_IFDIR | mode;
 	if (dir->i_mode & S_ISGID)
 		inode->i_mode |= S_ISGID;
 	mark_inode_dirty(inode);
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, inode);
 	if (err)
 		goto out_no_entry;
 	dir->i_nlink++;
-	dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
+#ifdef CONFIG_EXT2_INDEX
+	if (make_dx)
+	{
+		struct buffer_head *bh = ext2_bread (inode, 0, 1, &err);
+		if (bh)
+		{
+			struct dx_entry *entries = ((struct dx_root *) bh->b_data)->entries;
+			dxtrace_on(printk("Making dx indexed directory\n"));
+			inode->i_size = (dx_dir_base(sb) + 1) << sb->s_blocksize_bits;
+			entries[0].block = dx_dir_base(sb);
+			entries[0].hash = 1; /* first hash field is entry count */
+			mark_buffer_dirty(bh);
+			brelse(bh);
+			inode->u.ext2_i.i_flags |= EXT2_INDEX_FL;
+
+		}
+	}
+#endif
 	mark_inode_dirty(dir);
 	d_instantiate(dentry, inode);
 	return 0;
@@ -473,23 +899,27 @@
 /*
  * routine to check that the specified directory is empty (for rmdir)
  */
-static int empty_dir (struct inode * inode)
+static int ext2_is_empty_dir (struct inode *inode)
 {
 	unsigned long offset;
 	struct buffer_head * bh;
 	struct ext2_dir_entry_2 * de, * de1;
-	struct super_block * sb;
+	struct super_block * sb = inode->i_sb;
 	int err;
-
-	sb = inode->i_sb;
+#ifdef CONFIG_EXT2_INDEX
+	int start = is_dx(inode)? dx_dir_base(sb): 0;
+#else
+	int start = 0;
+#endif
 	if (inode->i_size < EXT2_DIR_REC_LEN(1) + EXT2_DIR_REC_LEN(2) ||
-	    !(bh = ext2_bread (inode, 0, 0, &err))) {
+	    !(bh = ext2_bread (inode, start, 0, &err))) {
 	    	ext2_warning (inode->i_sb, "empty_dir",
 			      "bad directory (dir #%lu) - no data block",
 			      inode->i_ino);
 		return 1;
 	}
 	de = (struct ext2_dir_entry_2 *) bh->b_data;
+#ifdef CONFIG_EXT2_INDEX
 	de1 = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
 	if (le32_to_cpu(de->inode) != inode->i_ino || !le32_to_cpu(de1->inode) || 
 	    strcmp (".", de->name) || strcmp ("..", de1->name)) {
@@ -501,6 +931,7 @@
 	}
 	offset = le16_to_cpu(de->rec_len) + le16_to_cpu(de1->rec_len);
 	de = (struct ext2_dir_entry_2 *) ((char *) de1 + le16_to_cpu(de1->rec_len));
+#endif
 	while (offset < inode->i_size ) {
 		if (!bh || (void *) de >= (void *) (bh->b_data + sb->s_blocksize)) {
 			brelse (bh);
@@ -552,7 +983,7 @@
 		goto end_rmdir;
 
 	retval = -ENOTEMPTY;
-	if (!empty_dir (inode))
+	if (!ext2_is_empty_dir (inode))
 		goto end_rmdir;
 
 	retval = ext2_delete_entry(dir, de, bh);
@@ -568,7 +999,6 @@
 	mark_inode_dirty(inode);
 	dir->i_nlink--;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 
 end_rmdir:
@@ -605,7 +1035,6 @@
 	if (retval)
 		goto end_unlink;
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(dir);
 	inode->i_nlink--;
 	mark_inode_dirty(inode);
@@ -729,7 +1158,7 @@
 	if (S_ISDIR(old_inode->i_mode)) {
 		if (new_inode) {
 			retval = -ENOTEMPTY;
-			if (!empty_dir (new_inode))
+			if (!ext2_is_empty_dir (new_inode))
 				goto end_rename;
 		}
 		retval = -EIO;
@@ -782,7 +1211,6 @@
 		mark_inode_dirty(new_inode);
 	}
 	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
-	old_dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(old_dir);
 	if (dir_bh) {
 		PARENT_INO(dir_bh->b_data) = le32_to_cpu(new_dir->i_ino);
@@ -794,7 +1222,6 @@
 			mark_inode_dirty(new_inode);
 		} else {
 			new_dir->i_nlink++;
-			new_dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
 			mark_inode_dirty(new_dir);
 		}
 	}
--- ../2.4.1.uml.clean/fs/ext2/super.c	Fri Dec 29 23:36:44 2000
+++ ./fs/ext2/super.c	Tue Feb 20 04:56:43 2001
@@ -188,6 +188,12 @@
 				printk("EXT2 Check option not supported\n");
 #endif
 		}
+		else if (!strcmp (this_char, "index"))
+#ifdef CONFIG_EXT2_INDEX
+			set_opt (*mount_options, DXTREE);
+#else
+			printk("EXT2 Index option not supported\n");
+#endif
 		else if (!strcmp (this_char, "debug"))
 			set_opt (*mount_options, DEBUG);
 		else if (!strcmp (this_char, "errors")) {
--- ../2.4.1.uml.clean/include/linux/ext2_fs.h	Tue Jan 30 08:24:55 2001
+++ ./include/linux/ext2_fs.h	Tue Feb 20 15:52:54 2001
@@ -40,6 +40,12 @@
 #define EXT2FS_VERSION		"0.5b"
 
 /*
+ * Hash Tree Directory indexing
+ * (c) Daniel Phillips, 2001
+ */
+#undef CONFIG_EXT2_INDEX
+
+/*
  * Debug code
  */
 #ifdef EXT2FS_DEBUG
@@ -53,7 +59,7 @@
 #endif
 
 /*
- * Special inodes numbers
+ * Special inode numbers
  */
 #define	EXT2_BAD_INO		 1	/* Bad blocks inode */
 #define EXT2_ROOT_INO		 2	/* Root inode */
@@ -197,7 +203,7 @@
 #define EXT2_NOCOMP_FL			0x00000400 /* Don't compress */
 #define EXT2_ECOMPR_FL			0x00000800 /* Compression error */
 /* End compression flags --- maybe not all used */	
-#define EXT2_BTREE_FL			0x00001000 /* btree format dir */
+#define EXT2_INDEX_FL			0x00001000 /* btree format dir */
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
 #define EXT2_FL_USER_VISIBLE		0x00001FFF /* User visible flags */
@@ -314,6 +320,7 @@
 #define EXT2_MOUNT_ERRORS_PANIC		0x0040	/* Panic on errors */
 #define EXT2_MOUNT_MINIX_DF		0x0080	/* Mimics the Minix statfs */
 #define EXT2_MOUNT_NO_UID32		0x0200  /* Disable 32-bit UIDs */
+#define EXT2_MOUNT_DXTREE		0x0400  /* Enable dx trees */
 
 #define clear_opt(o, opt)		o &= ~EXT2_MOUNT_##opt
 #define set_opt(o, opt)			o |= EXT2_MOUNT_##opt
@@ -518,6 +525,16 @@
 #define EXT2_DIR_ROUND 			(EXT2_DIR_PAD - 1)
 #define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
 					 ~EXT2_DIR_ROUND)
+
+/*
+ * Hash Tree Directory indexing
+ * (c) Daniel Phillips, 2001
+ */
+#ifdef CONFIG_EXT2_INDEX
+#define is_dx(dir) (dir->u.ext2_i.i_flags & EXT2_INDEX_FL)
+#define dx_entries_per_block(sb) (EXT2_BLOCK_SIZE(sb) >> 3)
+#define dx_dir_base(sb) (dx_entries_per_block(sb) - 1 + 1)
+#endif
 
 #ifdef __KERNEL__
 /*


-- 
Daniel
