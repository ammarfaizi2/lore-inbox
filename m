Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130582AbRCIRKT>; Fri, 9 Mar 2001 12:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbRCIRKA>; Fri, 9 Mar 2001 12:10:00 -0500
Received: from hermes.mixx.net ([212.84.196.2]:41484 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130543AbRCIRJi>;
	Fri, 9 Mar 2001 12:09:38 -0500
From: Daniel Phillips <phillips@innominate.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Directory index for Ext2 - the pagecache version
Date: Fri, 9 Mar 2001 15:17:51 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Message-Id: <01030918083609.11151@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though the hash races aren't finished yet, I put them on hold for a
while to get the directory indexing converted from buffers to page
cache.  Al Viro had a patch to get me started at:

  ftp://ftp.math.psu.edu/pub/viro/ext2-dir-patch-S2.gz

Having last been worked on sometime last fall it had only a small
amount of bitrot.  After we cleaned that up it functioned pretty well
for normal ext2 directories, showing a doubling in performance but of
course continuing to suffer from n**2 behaviour on large directories.

Gory details of the page cache conversion
=========================================
Converting from buffers to pages took about five times as long as I
expected, and there is still work to do.  However, something workable
is now starting to emerge.  The main difficulty is fundamental to the
way the page cache works: when data divides nicely into pages
everything is fine but when it doesn't things can get complicated.

This *is* a case where the data doesn't always divide into 4K pages very
well.  To illustrate, consider a directory on a 1K filesystem.  Suppose
that some random leaf block has to be split.  The new block may or may
not end up on the same page.  If we lock the new block's page and it
happens to be the same as the old block's page we will deadlock
instantly.  We get the same problem with the index root and
intermediate index blocks.  Up to 4 blocks can be 'in play' at once
over different regions of the code and the combinatorics of this are
pretty bad.

Al and I discussed what to do about this at some length, then we
both went away and independently came up with the idea that the real
problem is the page locking, and we might not actually need it in this
context.  The page->count should take care of keeping the pages in
cache while we work on them, and i_sem takes care of the filesystem
locking.  If we don't have to worry about page-level locking it's a
lot less messy to operate on different parts of the same page - less
bookkeeping is required and the logic flow doesn't get obfuscated.

This patch tests that idea.  There is an #ifdef which, if true,
disables all the page lock/unlocking in the patch and otherwise does
normal page locking.  With the locking off the way is clear to handling
1K blocks reasonably elegantly.  Though I have not really stressed it
much, it does seem to work the same whichever way you set the #ifdef,
at least for 4K blocks.  This is good.  The next step is to add the 1K
block support.  It should now be just a few lines instead of the
horrible mess I originally imagined.

I've diverged pretty far from Al's original patch and the ext2/dir.c
part of it won't look very much like the original when done.  When
everything stabilizes I should probably sync up with Al and divide it
back up into two patchs - one to change the normal directory ops to the
page cache and a second to add the index.  For now it's all one patch,
because the factoring still has a long way to go before it's acceptably
orthogonal.  Whichever way it ends up, both Al and my patch replace
almost all of ext2/dir.c and ext2/namei.c.

Performance
===========
Performance is roughly doubled over the buffer cache version, needing
only 75 uSec to create each file in a directory of 90,000 files.  But
I'm not finished optimizing.  Binary-searching the index should speed
things up further.  An (optional) 'incompatible' directory block
format I'm working on will likely give another doubling in speed.  These
and other incremental improvements mean we'll eventually be seeing
Ext2 directory operations in the low 10's of microseconds.  That should
be fast enough. ;-)

Dumping the index
=================
There is a little hack in this patch for dumping the directory index
structure.  If you cat a directory you normally get an error, but I
piggyback an index dump via printk onto this before returning the
error code.  This gives a nice little interactive tool for checking the
index integrity and general niceness of the leaf block layout.

Hash races on hold
==================
I received a lot of email from hash function experts as a result of the
earlier thread.  I have to catch up with that email and I have about
half a dozen very interesting functions to test.  My dx_hack_hash now
gets within 6% of the ideal 75% per-leaf 'fullness', but it is most
definitely not perfect.  Larry Auton asked me how I came up with the
constants in my function and I told him 'by moving my fingers randomly
on the keyboard' until it looked about right.  He wasn't much surprised
by that and suggested some better constants that he'd come up with by
running an automatic hash function analyzer.  I'll see what happens.

Several other people sent me code and a lot of it looks good.  I'll
make time to test it all over the next couple of weeks.

A funny thing about the page cache
==================================
Why does read_cache_page unlock the page just before returning?  I'd
prefer that both return the page locked and let me drop the lock myself,
or have a read_page_locked and read_cache_page can be a wrapper for it. 
This would be consistent with grab_cache_page and in certain contexts
it might turn out to be essential to do things that way.

Benchmarking code
=================

Here is some c/bash for benchmarks and testing.  I'd very much
appreciate it if some brave people would try applying the patch and
exercising it now.  There are no doubt a few points I've forgotten,
which follows from the forest:trees principle.

------------
makefiles.c:
------------

int main (int argc, char *argv[])
{
	int n = (argc > 2)? strtol(argv[2], 0, 10): 0;
	int i, size = 50, show = argc > 3 && !strncmp(argv[3], "y", 1);
	char name[size];
	for (i = 0; i < n; i++)
	{
	        snprintf(name, size, "%s%i", argv[1], i);
	        if (show) printf("create %s\n", name);
        	close(open(name, 0100));
	}
	return 0;
}

-------------------
bash script 'test':
-------------------
umount $1
mount /dev/hda999 $1 -t ext2 -o index
cd $1 && time rm -rf $2
mkdir $2;
cd $2 && time makefiles $2 $3 $4
---------------------------------

Once you patch a 2.4.2 kernel you will essentially get Al's version of
pagecache directories, with some spelling changes by me.  If it
oopses or loses files, direct you complaints to Al. :-)  To enable the
indexed code path you have to mount an ext2 filesystem with -o index. 
Please use the option only on test partitions, and be prepared for
oopses.  I.E, please use a test machine, not your workstation.

This version is closer to the final directory file format but it isn't
quite there yet.  Using a suggestion from Adreas Dilger I got rid of
the giant-looking directory sizes, and ls now shows the real size of
the directory file.  I haven't got the full forward-compatibility
support in yet either (from 2.1.something on) but it is coming soon.

To run the 90,000 file create test (create files /x/foo0 through
/x/foo89999):

	sh test /x foo 90000 n

The 'n' supresses the file name listing.

To-do list
==========

  - Finish 1K page cache support
  - Stress test the page cache
  - Finalize the file format
  - Settle on a good hash function
  - Hash function upgrade support
  - Second tree level
  - Audit directory locking
  - COMPAT/INCOMPAT flags
  - Backport 2.2 version
  - Binary search index optmization
  - Leaf block 'incompat' optimization
  - Refactor page cache primitives
  - Clean up the source
  - Divide into two patches

The patch
=========
I cleaned up the obscure logic in the block splitting code by observing
that some of the cases I was trying to optmize are so rare that the code
complexity just isn't worth it.  On the other hand, there is a 'fancy
dance' section that got more complicated.  The intent is to reduce
stack usage, and contain it so it doesn't end up with recursive memory
allocation stack frames sitting on top of it.  The new code makes the
stack utilization much more predictable and should sit comfortably
within a normal kernel stack.

This patch *does not* support 1K blocksize.  It doesn't check for that
either - if you run it on a 1K blocksize filesystem it will fail
noisily and probably oops.  Otherwise things seem to be working pretty
well.  Benchmarks run smoothly up to the current limit around 90,000
files.

--- ../uml.2.4.2.clean/fs/ext2/dir.c	Sat Dec  9 02:35:54 2000
+++ ./fs/ext2/dir.c	Fri Mar  9 16:05:19 2001
@@ -16,167 +16,1056 @@
  *
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
+ *
+ * All code that works with directory layout had been switched to pagecache
+ * and moved here. WARNING: it's early beta.	 -- AV
  */
 
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
+#include <linux/pagemap.h>
 
-static unsigned char ext2_filetype_table[] = {
-	DT_UNKNOWN, DT_REG, DT_DIR, DT_CHR, DT_BLK, DT_FIFO, DT_SOCK, DT_LNK
+int waitfor_one_page(struct page *page);
+
+static inline unsigned get_blocksize(struct inode *inode)
+{
+	return inode->i_sb->s_blocksize;
+}
+
+static inline unsigned get_blockshift(struct inode *inode)
+{
+	return inode->i_sb->s_blocksize_bits;
+}
+
+static inline unsigned long dir_pages(struct inode *inode)
+{
+	return (inode->i_size+PAGE_CACHE_SIZE-1)>>PAGE_CACHE_SHIFT;
+}
+
+#define unlock_page(page) UnlockPage(page)
+
+#if 1
+#define maybe_lock_page(page)
+#define maybe_unlock_page(page)
+#else
+#define maybe_lock_page(page) lock_page(page)
+#define maybe_unlock_page(page) UnlockPage(page)
+#endif
+
+static inline void release_page(struct page *page)
+{
+//	printk("release %p count=%i locked=%i\n", page, atomic_read(&page->count), PageLocked(page));
+	maybe_unlock_page(page);
+	kunmap(page);
+	page_cache_release(page);
+}
+
+
+static int fixme_commit_chunk(struct page *page, unsigned from, unsigned to)
+{
+	struct inode *dir = page->mapping->host;
+	int err = 0;
+	dir->i_version = ++event;
+	page->mapping->a_ops->commit_write(NULL, page, from, to);
+	if (IS_SYNC(dir))
+		err = waitfor_one_page(page);
+	return err;
+}
+
+static void fixme_check_page(struct page *page)
+{
+	struct inode *dir = page->mapping->host;
+	struct super_block *sb = dir->i_sb;
+	unsigned chunk_size = get_blocksize(dir);
+	char *kaddr = (char*)page_address(page);
+	u32 max_inumber = le32_to_cpu(sb->u.ext2_sb.s_es->s_inodes_count);
+	unsigned offs, rec_len;
+	unsigned limit = PAGE_CACHE_SIZE;
+	ext2_dirent *p;
+	char *error;
+
+	if ((dir->i_size >> PAGE_CACHE_SHIFT) == page->index) {
+		limit = dir->i_size & ~PAGE_CACHE_MASK;
+		if (limit & (chunk_size - 1))
+			goto Ebadsize;
+		for (offs = limit; offs<PAGE_CACHE_SIZE; offs += chunk_size) {
+			ext2_dirent *p = (ext2_dirent*)(kaddr + offs);
+			p->rec_len = cpu_to_le16(chunk_size);
+		}
+		if (!limit)
+			goto out;
+	}
+	for (offs = 0; offs <= limit - EXT2_DIR_REC_LEN(1); offs += rec_len) {
+		p = (ext2_dirent *) (kaddr + offs);
+		rec_len = le16_to_cpu(p->rec_len);
+
+		if (rec_len < EXT2_DIR_REC_LEN(1))
+			goto Eshort;
+		if (rec_len & 3)
+			goto Ealign;
+		if (rec_len < EXT2_DIR_REC_LEN(p->name_len))
+			goto Enamelen;
+		if (((offs + rec_len - 1) ^ offs) & ~(chunk_size-1))
+			goto Espan;
+		if (le32_to_cpu(p->inode) > max_inumber)
+			goto Einumber;
+	}
+	if (offs != limit)
+		goto Eend;
+out:
+	SetPageChecked(page);
+	return;
+
+	/* Too bad, we had an error */
+
+Ebadsize:
+	ext2_error(sb, "fixme_check_page",
+		"size of directory #%lu is not a multiple of chunk size",
+		dir->i_ino
+	);
+	goto fail;
+Eshort:
+	error = "rec_len is smaller than minimal";
+	goto bad_entry;
+Ealign:
+	error = "unaligned directory entry";
+	goto bad_entry;
+Enamelen:
+	error = "rec_len is too small for name_len";
+	goto bad_entry;
+Espan:
+	error = "directory entry across blocks";
+	goto bad_entry;
+Einumber:
+	error = "inode out of bounds";
+bad_entry:
+	ext2_error (sb, "fixme_check_page", "bad entry in directory #%lu: %s - "
+		"offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
+		dir->i_ino, error, (page->index<<PAGE_CACHE_SHIFT)+offs,
+		(unsigned long) le32_to_cpu(p->inode),
+		rec_len, p->name_len);
+	goto fail;
+Eend:
+	p = (ext2_dirent *) (kaddr + offs);
+	ext2_error (sb, "fixme_check_page",
+		"entry in directory #%lu spans the page boundary"
+		"offset=%lu, inode=%lu",
+		dir->i_ino, (page->index<<PAGE_CACHE_SHIFT)+offs,
+		(unsigned long) le32_to_cpu(p->inode));
+fail:
+	SetPageChecked(page);
+	SetPageError(page);
+}
+
+static struct page * fixme_acquire_page(struct inode *dir, unsigned long n)
+{
+	struct address_space *mapping = dir->i_mapping;
+	struct page *page = read_cache_page (mapping, n, (filler_t*)mapping->a_ops->readpage, NULL);
+	// if read_cache_page didn't drop the lock we wouldn't have to reacquire it here...
+	if (!IS_ERR(page)) {
+		maybe_lock_page(page);
+		kmap(page);
+		if (!Page_Uptodate(page))
+			goto fail;
+		if (!PageChecked(page))
+			fixme_check_page(page);
+		if (PageError(page))
+			goto fail;
+	}
+	return page;
+
+fail:
+	release_page(page);
+	return ERR_PTR(-EIO);
+}
+
+/*
+ * p is at least 6 bytes before the end of page
+ */
+static inline ext2_dirent *ext2_next_entry(ext2_dirent *p)
+{
+	return (ext2_dirent *) ((char*)p + le16_to_cpu(p->rec_len));
+}
+
+/*
+ * Hash Tree Directory indexing
+ * (c) 2001, Daniel Phillips
+ */
+#ifdef CONFIG_EXT2_INDEX
+#define dxtrace_on(command) command
+#define dxtrace_off(command)
+#define dxtrace dxtrace_off
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
+static int prepare_chunk (struct page *page, char *chunk)
+{
+	unsigned offset = chunk - (char *) page_address(page);
+	unsigned size = page->mapping->host->i_sb->s_blocksize;
+	if (offset > PAGE_CACHE_SIZE || offset + size > PAGE_CACHE_SIZE) BUG();
+	return page->mapping->a_ops->prepare_write(NULL, page, offset, offset + size);
+}
+
+static int commit_chunk (struct page *page, char *chunk)
+{
+	unsigned offset = chunk - (char *) page_address(page);
+	unsigned size = page->mapping->host->i_sb->s_blocksize;
+	if (offset > PAGE_CACHE_SIZE || offset + size > PAGE_CACHE_SIZE) BUG();
+	return page->mapping->a_ops->commit_write(NULL, page, offset, offset + size);
+}
+
+char *acquire_block (struct inode *inode, u32 block, struct page **ppage)
+{
+	unsigned blockshift = get_blockshift(inode);
+	unsigned page2block = PAGE_CACHE_SHIFT - blockshift;
+	unsigned index = (block >> page2block) & ~PAGE_CACHE_MASK;
+	struct address_space *mapping = inode->i_mapping;
+	struct page *page = read_cache_page (mapping, index, (filler_t *) mapping->a_ops->readpage, NULL);
+	// if read_cache_page didn't drop the lock we wouldn't need to reacquire it here
+	if (!IS_ERR(page)) // can we please have just one way of passing back the error?
+	{
+		maybe_lock_page(page);
+		kmap(page);
+		if (!Page_Uptodate(page))
+			goto fail;
+		if (PageError(page))
+			goto fail;
+	}
+	return page_address(*ppage = page) + ((block & ~(-1<<page2block)) << blockshift);
+fail:
+	release_page(page);
+	return ERR_PTR(-EIO);
+}
+
+/*
+ * Structure of the directory root block
+ */
+
+struct dx_root
+{
+	ext2_dirent fake;
+	struct dx_root_info
+	{
+		u8 info_length;
+		u8 hash_version;
+		u8 indirect_levels;
+		u8 unused_flags;
+		u32 zero; // parent inode
+	}
+	info;
+	struct dx_entry
+	{
+		u32 hash;
+		u32 block;
+	} 
+	entries[0];
 };
 
-static int ext2_readdir(struct file *, void *, filldir_t);
+/*
+ * Bookkeeping for index traversal
+ */
 
-struct file_operations ext2_dir_operations = {
-	read:		generic_read_dir,
-	readdir:	ext2_readdir,
-	ioctl:		ext2_ioctl,
-	fsync:		ext2_sync_file,
+struct dx_frame
+{
+	char *data;
+	struct page *page;
+	struct dx_entry *entries;
+	struct dx_entry *at;
+	struct dx_root_info *info;
+	unsigned count;
+	unsigned limit;
 };
 
-int ext2_check_dir_entry (const char * function, struct inode * dir,
-			  struct ext2_dir_entry_2 * de,
-			  struct buffer_head * bh,
-			  unsigned long offset)
-{
-	const char * error_msg = NULL;
-
-	if (le16_to_cpu(de->rec_len) < EXT2_DIR_REC_LEN(1))
-		error_msg = "rec_len is smaller than minimal";
-	else if (le16_to_cpu(de->rec_len) % 4 != 0)
-		error_msg = "rec_len % 4 != 0";
-	else if (le16_to_cpu(de->rec_len) < EXT2_DIR_REC_LEN(de->name_len))
-		error_msg = "rec_len is too small for name_len";
-	else if (dir && ((char *) de - bh->b_data) + le16_to_cpu(de->rec_len) >
-		 dir->i_sb->s_blocksize)
-		error_msg = "directory entry across blocks";
-	else if (dir && le32_to_cpu(de->inode) > le32_to_cpu(dir->i_sb->u.ext2_sb.s_es->s_inodes_count))
-		error_msg = "inode out of bounds";
-
-	if (error_msg != NULL)
-		ext2_error (dir->i_sb, function, "bad entry in directory #%lu: %s - "
-			    "offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
-			    dir->i_ino, error_msg, offset,
-			    (unsigned long) le32_to_cpu(de->inode),
-			    le16_to_cpu(de->rec_len), de->name_len);
-	return error_msg == NULL ? 1 : 0;
-}
-
-static int ext2_readdir(struct file * filp,
-			 void * dirent, filldir_t filldir)
-{
-	int error = 0;
-	unsigned long offset, blk;
-	int i, num, stored;
-	struct buffer_head * bh, * tmp, * bha[16];
-	struct ext2_dir_entry_2 * de;
-	struct super_block * sb;
-	int err;
+unsigned dx_hack_hash (const char *name, int len)
+{
+	u32 hash0 = 0x12a3fe2d, hash1 = 0x37abe8f9;
+	while (len--)
+	{
+		u32 hash = hash1 + (hash0 ^ (*name++ * 71523));
+		if (hash & 0x80000000) hash -= 0x7fffffff;
+		hash1 = hash0;
+		hash0 = hash;
+	}
+	return hash0;
+}
+
+#define dx_hash(s,n) (dx_hack_hash(s,n) << 1)
+
+/*
+ * Probe for a directory leaf block to search
+ */
+
+int dx_probe (struct inode *dir, u32 hash, struct dx_frame *dxframe)
+{
+	int count, search;
+	struct dx_entry *at, *at0;
+	struct page *page;
+	struct dx_root *root = (struct dx_root *) acquire_block (dir, 0, &page);
+	dxtrace(printk("Look up %u", hash));
+	if (!root) return -EINVAL;
+
+	/* First hash field holds count of entries */
+	at = at0 = root->entries;
+	if (!(count = le32_to_cpu(at[0].hash))) BUG();
+	search = count - 1; // should use binary search
+
+	while (search--)
+	{
+		dxtrace(printk("."));
+		if (le32_to_cpu((++at)->hash) > hash)
+		{
+			at--;
+			break;
+		}
+	}
+	dxtrace(printk(" in %u:%u\n", at - at0, le32_to_cpu(at->block)));
+	dxframe->info = &(root->info);
+	dxframe->page = page;
+	dxframe->data = (char *) root;
+	dxframe->entries = at0;
+	dxframe->at = at;
+	dxframe->count = count;
+	dxframe->limit = (get_blocksize(dir) - sizeof(struct dx_root_info)) / sizeof(struct dx_entry);
+	return 0;
+}
+
+/*
+ * Prior to split, finds record offset, computes hash of each dir block record
+ */
+
+struct dx_map_entry
+{
+	u32 hash;
+	u32 offs;
+};
+
+#define MAX_DX_MAP (PAGE_SIZE/EXT2_DIR_REC_LEN(1) + 1)
+/* Assumes file blocksize <= PAGE_SIZE */                                                                                                     static int dx_make_map (ext2_dirent *de, int size, struct dx_map_entry map[])
+
+{
+	int count = 0;
+	char *base = (char *) de;
+	while ((char *) de < base + size)
+	{
+		map[count].hash = dx_hash (de->name, de->name_len);
+		map[count].offs = (u32) ((char *) de - base);
+		de = (ext2_dirent *) ((char *) de + le16_to_cpu(de->rec_len));
+		count++;
+	}
+	return count;
+}
+
+/*
+ * For dir block splitting and compacting
+ */
+
+ext2_dirent *dx_copy (
+	char *from, char *to, unsigned size, // should pass from, to as de's (uli)
+	struct dx_map_entry map[], int start, int count)
+{
+	ext2_dirent *de = NULL;
+	char *top = to + size;
+	unsigned rec_len = 0;
+	if (!count) BUG();
+	while (count--)
+	{
+		de = (ext2_dirent *) (from + map[start++].offs);
+		rec_len = EXT2_DIR_REC_LEN(de->name_len);
+		if (to + rec_len > top) BUG();
+		memcpy (to, de, rec_len);
+		((ext2_dirent *) to)->rec_len = cpu_to_le16(rec_len);
+		to += rec_len;
+	}
+	return (ext2_dirent *) (to - rec_len);
+}
+
+static inline void set_rec_len (ext2_dirent *de, unsigned len)
+{
+	de->rec_len = cpu_to_le16(len);
+}
+
+static inline void set_rec_full (ext2_dirent *de, char *limit)
+{
+	set_rec_len (de, limit - (char *) de); // need to clear top?
+}
+
+/*
+ * Debug
+ */
+
+#ifndef printks
+void kstring (char *name, unsigned len)
+{
+	while (len--) printk("%c", *name++);
+}
+#endif
+
+struct stats { unsigned names; unsigned used; }
+dx_show_leaf (ext2_dirent *de, int size, int names)
+{
+	unsigned count = 0, used = 0;
+	char *base = (char *) de;
+	printk("names: ");
+	while ((char *) de < base + size)
+	{
+		if (names)
+		{
+			kstring(de->name, de->name_len);
+			printk(":%u.%u ", dx_hash (de->name, de->name_len), (u32) ((char *) de - base));
+		}
+		used += EXT2_DIR_REC_LEN(de->name_len);
+		de = (ext2_dirent *) ((char *) de + le16_to_cpu(de->rec_len));
+ 		count++;
+	}
+	printk("(%i)\n", count);
+	return (struct stats) { count, used };
+}
+
+void dx_show_buckets (struct inode *dir)
+{
+	struct super_block *sb = dir->i_sb;
+	int blockshift = EXT2_BLOCK_SIZE_BITS (sb), blocksize = 1 << blockshift;
+	unsigned count, i, used = 0, names = 0;
+	struct dx_entry *at;
+	struct page *page, *page2;
+	struct dx_root *root = (struct dx_root *) acquire_block (dir, 0, &page);
+	if (!root) return;
+	at = root->entries;
+	count = *(u32 *) at;
+	printk("%i indexed blocks...\n", count);
+	for (i = 0; i < count; i++, at++)
+	{
+		u32 block = le32_to_cpu(at->block), h = le32_to_cpu(at->hash), hash = i? h: 0;
+		u32 range = i == count - 1? ~h: (le32_to_cpu((at + 1)->hash) - hash);
+		struct stats stats;
+		ext2_dirent *leaf = (ext2_dirent *) acquire_block (dir, block, &page2);
+		printk("%u:%u hash %u/%u ", i, block, hash, range);
+		if (!leaf) continue;
+		stats = dx_show_leaf (leaf, blocksize, 0);
+		names += stats.names;
+		used += stats.used;
+		release_page (page2);
+	}
+	release_page (page);
+	printk("names %u, fullness %u (%u%%)\n", names, used/count, (used/count)*100/blocksize);
+}
+
+static void dx_show_index (struct dx_frame *dxframe)
+{
+	struct dx_entry *entries = dxframe->entries;
+	int i = 0;
+	printk("Index: ");
+	for (; i < *(u32 *) entries; i++)
+	{
+		printk("%u@%u ", le32_to_cpu(entries[i].hash), le32_to_cpu(entries[i].block));
+	}
+	printk("\n");
+}
+#endif
+
+/*
+ * NOTE! unlike strncmp, ext2_match returns 1 for success, 0 for failure.
+ *
+ * len <= EXT2_NAME_LEN and de != NULL are guaranteed by caller.
+ */
+static inline int ext2_match (int len, const char *name, ext2_dirent *de)
+{
+	if (len != de->name_len)
+		return 0;
+	if (!de->inode)
+		return 0;
+	return !memcmp(name, de->name, len);
+}
+
+static inline unsigned 
+ext2_validate_entry(char *base, unsigned offset, unsigned mask)
+{
+	ext2_dirent *de = (ext2_dirent*)(base + offset);
+	ext2_dirent *p = (ext2_dirent*)(base + (offset&mask));
+	while ((char*)p < (char*)de)
+		p = ext2_next_entry(p);
+	return (char *)p - base;
+}
+
+static unsigned char ext2_filetype_table[EXT2_FT_MAX] = {
+	[EXT2_FT_UNKNOWN]	DT_UNKNOWN,
+	[EXT2_FT_REG_FILE]	DT_REG,
+	[EXT2_FT_DIR]		DT_DIR,
+	[EXT2_FT_CHRDEV]	DT_CHR,
+	[EXT2_FT_BLKDEV]	DT_BLK,
+	[EXT2_FT_FIFO]		DT_FIFO,
+	[EXT2_FT_SOCK]		DT_SOCK,
+	[EXT2_FT_SYMLINK]	DT_LNK,
+};
+
+#define S_SHIFT 12
+static unsigned char ext2_type_by_mode[S_IFMT >> S_SHIFT] = {
+	[S_IFREG >> S_SHIFT]	EXT2_FT_REG_FILE,
+	[S_IFDIR >> S_SHIFT]	EXT2_FT_DIR,
+	[S_IFCHR >> S_SHIFT]	EXT2_FT_CHRDEV,
+	[S_IFBLK >> S_SHIFT]	EXT2_FT_BLKDEV,
+	[S_IFIFO >> S_SHIFT]	EXT2_FT_FIFO,
+	[S_IFSOCK >> S_SHIFT]	EXT2_FT_SOCK,
+	[S_IFLNK >> S_SHIFT]	EXT2_FT_SYMLINK,
+};
+
+static inline void ext2_set_de_type (ext2_dirent *de, struct inode *inode)
+{
+	mode_t mode = inode->i_mode;
+	if (EXT2_HAS_INCOMPAT_FEATURE(inode->i_sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
+		de->file_type = ext2_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
+}
+
+static int ext2_readdir (struct file *filp, void *dirent, filldir_t filldir)
+{
+	loff_t pos = filp->f_pos;
 	struct inode *inode = filp->f_dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
+	unsigned offset = pos & ~PAGE_CACHE_MASK;
+	unsigned long n = pos >> PAGE_CACHE_SHIFT;
+#ifdef CONFIG_EXT2_INDEX
+	int start = is_dx(inode)? 1: 0;
+#else
+	int start = 0;
+#endif
+	unsigned long npages = dir_pages(inode) - start;
+	unsigned chunk_mask = ~(get_blocksize(inode)-1);
+	unsigned char *types = NULL;
+	int need_revalidate = (filp->f_version != inode->i_version);
 
-	sb = inode->i_sb;
+	if (pos > inode->i_size - EXT2_DIR_REC_LEN(1))
+		goto done;
 
-	stored = 0;
-	bh = NULL;
-	offset = filp->f_pos & (sb->s_blocksize - 1);
-
-	while (!error && !stored && filp->f_pos < inode->i_size) {
-		blk = (filp->f_pos) >> EXT2_BLOCK_SIZE_BITS(sb);
-		bh = ext2_bread (inode, blk, 0, &err);
-		if (!bh) {
-			ext2_error (sb, "ext2_readdir",
-				    "directory #%lu contains a hole at offset %lu",
-				    inode->i_ino, (unsigned long)filp->f_pos);
-			filp->f_pos += sb->s_blocksize - offset;
+	if (EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
+		types = ext2_filetype_table;
+
+	for (; n < npages; n++, offset = 0) {
+		char *kaddr, *limit;
+		ext2_dirent *de;
+		struct page *page = fixme_acquire_page(inode, n + start);
+
+		if (IS_ERR(page))
 			continue;
+		kaddr = (char *) page_address(page);
+		if (need_revalidate) {
+			offset = ext2_validate_entry(kaddr, offset, chunk_mask);
+			need_revalidate = 0;
 		}
+		de = (ext2_dirent *) (kaddr+offset);
+		limit = kaddr + PAGE_CACHE_SIZE - EXT2_DIR_REC_LEN(1);
+		for (; (char*) de <= limit; de = ext2_next_entry(de))
+			if (de->inode) {
+				int over;
+				unsigned char d_type = DT_UNKNOWN;
 
-		/*
-		 * Do the readahead
-		 */
-		if (!offset) {
-			for (i = 16 >> (EXT2_BLOCK_SIZE_BITS(sb) - 9), num = 0;
-			     i > 0; i--) {
-				tmp = ext2_getblk (inode, ++blk, 0, &err);
-				if (tmp && !buffer_uptodate(tmp) && !buffer_locked(tmp))
-					bha[num++] = tmp;
-				else
-					brelse (tmp);
-			}
-			if (num) {
-				ll_rw_block (READA, num, bha);
-				for (i = 0; i < num; i++)
-					brelse (bha[i]);
+				if (types && de->file_type < EXT2_FT_MAX)
+					d_type = types[de->file_type];
+
+				offset = (char *)de - kaddr;
+				over = filldir(dirent, de->name, de->name_len,
+						(n<<PAGE_CACHE_SHIFT) | offset,
+						le32_to_cpu(de->inode), d_type);
+				if (over) {
+					release_page(page);
+					goto done;
+				}
 			}
+		release_page(page);
+	}
+
+done:
+	filp->f_pos = (n << PAGE_CACHE_SHIFT) | offset;
+	filp->f_version = inode->i_version;
+	UPDATE_ATIME(inode);
+	return 0;
+}
+
+/*
+ * finds an entry in the specified directory with the wanted name. It
+ * returns the page in which the entry was found, and the entry itself
+ * (as a parameter - res_dir). Page is returned mapped and unlocked.
+ * Entry is guaranteed to be valid.
+ */
+ext2_dirent *ext2_find_entry (struct inode *dir, struct dentry *dentry, struct page **res_page)
+{
+	const char *name = dentry->d_name.name;
+	int namelen = dentry->d_name.len;
+	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
+	unsigned long n;
+	unsigned long npages = dir_pages(dir);
+	struct page *page = NULL;
+	ext2_dirent *de;
+
+	/* OFFSET_CACHE */
+	*res_page = NULL;
+
+#ifdef CONFIG_EXT2_INDEX
+	if (is_dx(dir))
+	{
+		u32 hash = dx_hash (name, namelen);
+		struct dx_frame dxframe;
+		char *data;
+		unsigned blocksize = get_blocksize (dir);
+		int err = dx_probe (dir, hash, &dxframe); // don't ignore the error!!
+
+		while (1)
+		{
+			if (!(data = acquire_block (dir, le32_to_cpu(dxframe.at->block), &page))) goto dxfail;
+			de = (ext2_dirent *) data;
+			for (; (char *) de <= data + blocksize - reclen; de = ext2_next_entry(de))
+				if (ext2_match (namelen, name, de))
+				{
+					dxtrace(printk("Found %s in %i:%i page %p\n", name, 
+						dxframe.at - dxframe.entries, le32_to_cpu(dxframe.at->block),
+						page));
+					release_page(dxframe.page);
+					goto found;
+				}
+			release_page(page);
+			/* Same hash continues in next block?  Search further. */
+			if (++(dxframe.at) - dxframe.entries == dxframe.count) break;
+			if ((le32_to_cpu(dxframe.at->hash) & -2) != hash) break;
+			dxtrace(printk("Try next, block %i\n", le32_to_cpu(dxframe.at->block)));
 		}
-		
-revalidate:
-		/* If the dir block has changed since the last call to
-		 * readdir(2), then we might be pointing to an invalid
-		 * dirent right now.  Scan from the start of the block
-		 * to make sure. */
-		if (filp->f_version != inode->i_version) {
-			for (i = 0; i < sb->s_blocksize && i < offset; ) {
-				de = (struct ext2_dir_entry_2 *) 
-					(bh->b_data + i);
-				/* It's too expensive to do a full
-				 * dirent test each time round this
-				 * loop, but we do have to test at
-				 * least that it is non-zero.  A
-				 * failure will be detected in the
-				 * dirent test below. */
-				if (le16_to_cpu(de->rec_len) < EXT2_DIR_REC_LEN(1))
-					break;
-				i += le16_to_cpu(de->rec_len);
-			}
-			offset = i;
-			filp->f_pos = (filp->f_pos & ~(sb->s_blocksize - 1))
-				| offset;
-			filp->f_version = inode->i_version;
-		}
-		
-		while (!error && filp->f_pos < inode->i_size 
-		       && offset < sb->s_blocksize) {
-			de = (struct ext2_dir_entry_2 *) (bh->b_data + offset);
-			if (!ext2_check_dir_entry ("ext2_readdir", inode, de,
-						   bh, offset)) {
-				/* On error, skip the f_pos to the
-                                   next block. */
-				filp->f_pos = (filp->f_pos | (sb->s_blocksize - 1))
-					      + 1;
-				brelse (bh);
-				return stored;
+dxfail:
+		release_page(dxframe.page);
+		return NULL;
+	}
+#endif
+
+	for (n = 0; n < npages; n++) {
+		char *kaddr;
+		page = fixme_acquire_page(dir, n);
+		if (IS_ERR(page))
+			continue;
+
+		kaddr = (char*)page_address(page);
+		de = (ext2_dirent *) kaddr;
+		kaddr += PAGE_CACHE_SIZE - reclen;
+		for (; (char *) de <= kaddr; de = ext2_next_entry(de))
+			if (ext2_match (namelen, name, de))
+				goto found;
+		release_page(page);
+	}
+	return NULL;
+found:
+	maybe_unlock_page(page);
+	*res_page = page;
+	return de;
+}
+
+ext2_dirent *ext2_parent (struct inode *dir, struct page **p)
+{
+	struct page *page = fixme_acquire_page(dir, 0);
+	ext2_dirent *de = NULL;
+
+	if (!IS_ERR(page)) {
+		de = ext2_next_entry((ext2_dirent *) page_address(page));
+		*p = page;
+		maybe_unlock_page(page);
+	}
+	return de;
+}
+
+ino_t ext2_find_inode (struct inode * dir, struct dentry *dentry)
+{
+	ino_t res = 0;
+	ext2_dirent *de;
+	struct page *page;
+	
+	de = ext2_find_entry (dir, dentry, &page);
+	if (de) {
+		res = le32_to_cpu(de->inode);
+		kunmap(page);
+		page_cache_release(page);
+	}
+	return res;
+}
+
+/* Releases the page */
+void ext2_set_entry (struct inode *dir, ext2_dirent *de, struct page *page, struct inode *inode)
+{
+	unsigned from = (char *)de-(char*)page_address(page);
+	unsigned to = from + le16_to_cpu(de->rec_len);
+	int err;
+
+	maybe_lock_page(page);
+	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (err)
+		BUG();
+	de->inode = cpu_to_le32(inode->i_ino);
+	ext2_set_de_type (de, inode);
+	err = fixme_commit_chunk(page, from, to);
+	release_page(page);
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(dir);
+}
+
+/*
+ *	Parent is locked.
+ */
+int ext2_add_entry (struct dentry *dentry, struct inode *inode)
+{
+	struct inode *dir = dentry->d_parent->d_inode;
+	const char *name = dentry->d_name.name;
+	int namelen = dentry->d_name.len;
+	unsigned reclen = EXT2_DIR_REC_LEN(namelen);
+	unsigned short rec_len, name_len;
+	struct page *page = NULL;
+	ext2_dirent *de;
+	unsigned long npages = dir_pages(dir);
+	unsigned long n;
+	char *kaddr;
+	unsigned from, to;
+	int err;
+
+#ifdef CONFIG_EXT2_INDEX
+	if (is_dx(dir))
+	{
+		struct dx_frame dxframe;
+		struct dx_entry *entries, *at;
+		u32 hash = dx_hash (name, namelen), hash2, block2;
+		unsigned blockshift = get_blockshift (dir), blocksize = 1 << blockshift;
+		unsigned count, split, continued;
+		struct page *page2;
+		ext2_dirent *de2;
+		char *b1, *b2;
+
+		if ((err = dx_probe (dir, hash, &dxframe))) return err;
+		entries = dxframe.entries;
+		at = dxframe.at;
+
+		if (!(b1 = acquire_block (dir, le32_to_cpu(dxframe.at->block), &page))) return err;
+		prepare_chunk (page, b1);
+		de = (ext2_dirent *) b1;
+
+		while ((char *) de < b1 + blocksize)
+		{
+			name_len = EXT2_DIR_REC_LEN(de->name_len);
+			rec_len = le16_to_cpu(de->rec_len);
+			if (!de->inode && rec_len >= reclen) goto dx_got_it;
+			if (rec_len >= name_len + reclen) goto dx_got_it;
+			de = (ext2_dirent *) ((char *) de + rec_len);
+		}
+
+		/* Could compress, but for now just split it */
+		dxtrace(printk("entry count %i, limit %i\n", dxframe.count, dxframe.limit));
+
+		if (dxframe.count == dxframe.limit)
+		{
+			release_page(page);
+			release_page(dxframe.page);
+			return -ENOENT;
+		}
+
+		if (!(b2 = acquire_block (dir, block2 = dir->i_size >> blockshift, &page2)))
+		{
+			BUG();
+			release_page(page);
+			release_page(dxframe.page);
+			return err;
+		}
+
+		prepare_chunk (page2, b2);
+		if (!page2->buffers) BUG();
+		if (!page->buffers) BUG();
+		{
+			char *b3;
+			struct dx_map_entry map[MAX_DX_MAP];
+			count = dx_make_map ((ext2_dirent *) b1, blocksize, map);
+			split = count/2; // need to adjust to actual middle
+			COMBSORT(count, i, j, map[i].hash < map[j].hash, exchange(map[i], map[j]));
+
+			hash2 = map[split].hash;
+			continued = hash2 == map[split - 1].hash;
+			dxtrace(printk("Split block %i at %u, %i/%i\n", dxframe.at->block, hash2, split, count-split));
+
+			/* Fancy dance to stay within two buffers */
+			de2 = dx_copy (b1, b2, blocksize, map, split, count - split);
+			b3 = (char *) de2 + de2->rec_len;
+			de = dx_copy (b1, b3, blocksize - (b3 - b2), map, 0, split);
+			memcpy(b1, b3, (char *) de + de->rec_len - b3);
+			de = (ext2_dirent *) ((char *) de - b3 + b1);
+			set_rec_full (de, b1 + blocksize);
+			set_rec_full (de2, b2 + blocksize);
+
+			dxtrace(dx_show_leaf ((ext2_dirent *) b1, blocksize, 1));
+			dxtrace(dx_show_leaf ((ext2_dirent *) b2, blocksize, 1));
+
+			/* Which block gets the new entry? */
+			dxtrace(printk("Insert %s/%u ", name, hash));
+			if (hash >= hash2)
+			{
+				dxtrace(printk("above"));
+				exchange(page, page2);
+				exchange(b1, b2);
+				exchange(de, de2);
 			}
-			offset += le16_to_cpu(de->rec_len);
-			if (le32_to_cpu(de->inode)) {
-				/* We might block in the next section
-				 * if the data destination is
-				 * currently swapped out.  So, use a
-				 * version stamp to detect whether or
-				 * not the directory has been modified
-				 * during the copy operation.
-				 */
-				unsigned long version = filp->f_version;
-				unsigned char d_type = DT_UNKNOWN;
+			dxtrace(printk("\n"));
+		}
+		commit_chunk (page2, b2);
+		release_page (page2);
+
+		prepare_chunk (dxframe.page, dxframe.data);
+		if (!dxframe.page->buffers) BUG();
+		memmove (at + 1, at, (char *) (entries + dxframe.count) - (char *) (at));
+		at++;
+		at->block = cpu_to_le32(block2);
+		at->hash = cpu_to_le32(hash2 + continued);
+		entries[0].hash = cpu_to_le32(++dxframe.count); /* first hash field is entry count */
+		dxtrace(dx_show_index (&dxframe));
+		commit_chunk (dxframe.page, dxframe.data);
+
+dx_got_it:
+		release_page (dxframe.page);
+		/* New dirent will be added at de in page */
+		// put this down there?
+		name_len = EXT2_DIR_REC_LEN(de->name_len);
+		rec_len = le16_to_cpu(de->rec_len);
+		from = (char *) de - (char *) page_address(page);
+		to = from + rec_len;
+		goto add_it;
+	}
+#endif
+
+	/* We take care of directory expansion in the same loop */
+	for (n = 0; n <= npages; n++) {
+		page = fixme_acquire_page(dir, n);
+		err = PTR_ERR(page);
+		if (IS_ERR(page))
+			goto out;
+		kaddr = (char*)page_address(page);
+		de = (ext2_dirent *)kaddr;
+		kaddr += PAGE_CACHE_SIZE - reclen;
+		while ((char *)de <= kaddr) {
+			err = -EEXIST;
+			if (ext2_match (namelen, name, de))
+				goto out_page;
+			name_len = EXT2_DIR_REC_LEN(de->name_len);
+			rec_len = le16_to_cpu(de->rec_len);
+			if (!de->inode && rec_len >= reclen)
+				goto got_it;
+			if (rec_len >= name_len + reclen)
+				goto got_it;
+			de = (ext2_dirent *) ((char *) de + rec_len);
+		}
+		release_page(page);
+	}
+	BUG();
+	return -EINVAL;
+
+got_it:
+	from = (char *) de - (char *) page_address(page);
+	to = from + rec_len;
+	err = page->mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (err)
+		goto out_page;
+add_it:
+	if (de->inode) {
+		ext2_dirent *de1 = (ext2_dirent *) ((char *) de + name_len);
+		de1->rec_len = cpu_to_le16(rec_len - name_len);
+		de->rec_len = cpu_to_le16(name_len);
+		de = de1;
+	}
+	de->name_len = namelen;
+	memcpy (de->name, name, namelen);
+	de->inode = cpu_to_le32(inode->i_ino);
+	ext2_set_de_type (de, inode);
+	err = fixme_commit_chunk(page, from, to);
+
+	dir->i_mtime = dir->i_ctime = CURRENT_TIME;
+	mark_inode_dirty(dir);
+out_page:
+	release_page(page);
+out:
+	return err;
+}
 
-				if (EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE)
-				    && de->file_type < EXT2_FT_MAX)
-					d_type = ext2_filetype_table[de->file_type];
-				error = filldir(dirent, de->name,
-						de->name_len,
-						filp->f_pos, le32_to_cpu(de->inode),
-						d_type);
-				if (error)
-					break;
-				if (version != filp->f_version)
-					goto revalidate;
-				stored ++;
+/*
+ * ext2_delete_entry deletes a directory entry by merging it with the
+ * previous entry. Page is up-to-date. Releases the page.
+ */
+int ext2_del_entry (ext2_dirent *dir, struct page * page )
+{
+	struct address_space *mapping = page->mapping;
+	struct inode *inode = (struct inode*) mapping->host;
+	char *kaddr = (char*) page_address(page);
+	unsigned from = ((char*) dir - kaddr) & ~(get_blocksize(inode)-1);
+	unsigned to = ((char*) dir - kaddr) + le16_to_cpu(dir->rec_len);
+	ext2_dirent *pde = NULL;
+	ext2_dirent *de = (ext2_dirent *) (kaddr + from);
+	int err;
+
+	maybe_lock_page(page);
+
+	while ((char*)de < (char*)dir) {
+		pde = de;
+		de = ext2_next_entry(de);
+	}
+	if (pde)
+		from = (char*)pde - (char*)page_address(page);
+	err = mapping->a_ops->prepare_write(NULL, page, from, to);
+	if (err)
+		BUG();
+	if (pde)
+		pde->rec_len = cpu_to_le16(to-from);
+	dir->inode = 0;
+	err = fixme_commit_chunk(page, from, to);
+	release_page(page);
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	mark_inode_dirty(inode);
+	return err;
+}
+
+/*
+ * Set the first fragment of directory.
+ */
+int ext2_make_empty (struct inode *dir, struct inode *parent)
+{
+	struct super_block *sb = dir->i_sb;
+	struct address_space *mapping = dir->i_mapping;
+	unsigned blocksize = get_blocksize(dir);
+	ext2_dirent *de;
+	char *base;
+	int err;
+#ifdef CONFIG_EXT2_INDEX
+	int make_dx = test_opt (sb, DXTREE);
+	int start = make_dx? 1: 0;
+#else
+	int start = 0;
+#endif
+	struct page *page = grab_cache_page(mapping, start);
+	unlock_page(page); maybe_lock_page(page);
+
+	if (!page)
+		return -ENOMEM;
+	err = mapping->a_ops->prepare_write(NULL, page, 0, blocksize);
+	if (err)
+		goto fail;
+
+	base = (char*)page_address(page);
+
+	de = (ext2_dirent *) base;
+	de->name_len = 1;
+	de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(1));
+	memcpy (de->name, ".\0\0", 4);
+	de->inode = cpu_to_le32(dir->i_ino);
+	ext2_set_de_type (de, dir);
+
+	de = (ext2_dirent *) (base + EXT2_DIR_REC_LEN(1));
+	de->name_len = 2;
+	de->inode = cpu_to_le32(parent->i_ino);
+	set_rec_len (de, blocksize - EXT2_DIR_REC_LEN(1));
+	memcpy (de->name, "..\0", 4);
+	ext2_set_de_type (de, dir);
+
+#ifdef CONFIG_EXT2_INDEX
+	if (make_dx)
+	{
+		struct page *rootpage = grab_cache_page (mapping, 0);
+		unlock_page(rootpage); maybe_lock_page(rootpage);
+		err = mapping->a_ops->prepare_write(NULL, rootpage, 0, blocksize); // must generalize this
+		if (rootpage)
+		{
+			struct dx_root *root = (struct dx_root *) page_address(rootpage);
+			struct dx_entry *entries = root->entries;
+			dxtrace_on(printk("Making indexed directory\n"));
+//			entries[0].block = le32_to_cpu(dx_dir_base(sb));
+			entries[0].block = le32_to_cpu(1);
+			entries[0].hash = le32_to_cpu(1); /* first hash field is entry count */
+			root->info.info_length = 8;
+			set_rec_len (&root->fake, blocksize);
+			err = fixme_commit_chunk (rootpage, 0, blocksize);
+			maybe_unlock_page(rootpage);
+			page_cache_release(rootpage);
+			dir->u.ext2_i.i_flags |= EXT2_INDEX_FL;
+			mark_inode_dirty(dir);
+		}
+	}
+#endif
+	err = fixme_commit_chunk(page, 0, blocksize);
+fail:
+	maybe_unlock_page(page);
+	page_cache_release(page);
+	return err;
+}
+
+/*
+ * routine to check that the specified directory is empty (for rmdir)
+ */
+int ext2_is_empty (struct inode *dir)
+{
+	struct page *page = NULL;
+	unsigned long i, npages = dir_pages(dir);
+#ifdef CONFIG_EXT2_INDEX
+	int start = is_dx(dir)? 1: 0;
+#else
+	int start = 0;
+#endif
+	
+	for (i = 0; i < npages - start; i++) {
+		char *kaddr;
+		ext2_dirent *de;
+		page = fixme_acquire_page(dir, i + start);
+
+		if (IS_ERR(page))
+			continue;
+
+		kaddr = (char *) page_address(page);
+		de = (ext2_dirent *) kaddr;
+		kaddr += PAGE_CACHE_SIZE-EXT2_DIR_REC_LEN(1);
+
+		while ((char *)de <= kaddr) {
+			if (de->inode != 0) {
+				/* check for . and .. */
+				if (de->name[0] != '.')
+					goto not_empty;
+				if (de->name_len > 2)
+					goto not_empty;
+				if (de->name_len < 2) {
+					if (de->inode !=
+					    cpu_to_le32(dir->i_ino))
+						goto not_empty;
+				} else if (de->name[1] != '.')
+					goto not_empty;
 			}
-			filp->f_pos += le16_to_cpu(de->rec_len);
+			de = ext2_next_entry(de);
 		}
-		offset = 0;
-		brelse (bh);
+		release_page(page);
 	}
-	UPDATE_ATIME(inode);
+	return 1;
+
+not_empty:
+	release_page(page);
 	return 0;
 }
+
+ssize_t hack_show_dir (struct file *filp, char *buf, size_t siz, loff_t *ppos)
+{
+	dx_show_buckets (filp->f_dentry->d_inode);
+	return -EISDIR;
+}
+
+struct file_operations ext2_dir_operations = {
+	read:		hack_show_dir,
+	readdir:	ext2_readdir,
+	fsync:		ext2_sync_file,
+};
--- ../uml.2.4.2.clean/fs/ext2/inode.c	Fri Dec 29 23:36:44 2000
+++ ./fs/ext2/inode.c	Thu Mar  8 23:17:59 2001
@@ -230,11 +230,11 @@
  *	or when it reads all @depth-1 indirect blocks successfully and finds
  *	the whole chain, all way to the data (returns %NULL, *err == 0).
  */
-static inline Indirect *ext2_get_branch(struct inode *inode,
-					int depth,
-					int *offsets,
-					Indirect chain[4],
-					int *err)
+static Indirect *ext2_get_branch(struct inode *inode,
+				 int depth,
+				 int *offsets,
+				 Indirect chain[4],
+				 int *err)
 {
 	kdev_t dev = inode->i_dev;
 	int size = inode->i_sb->s_blocksize;
@@ -574,82 +574,6 @@
 	goto reread;
 }
 
-struct buffer_head * ext2_getblk(struct inode * inode, long block, int create, int * err)
-{
-	struct buffer_head dummy;
-	int error;
-
-	dummy.b_state = 0;
-	dummy.b_blocknr = -1000;
-	error = ext2_get_block(inode, block, &dummy, create);
-	*err = error;
-	if (!error && buffer_mapped(&dummy)) {
-		struct buffer_head *bh;
-		bh = getblk(dummy.b_dev, dummy.b_blocknr, inode->i_sb->s_blocksize);
-		if (buffer_new(&dummy)) {
-			if (!buffer_uptodate(bh))
-				wait_on_buffer(bh);
-			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
-			mark_buffer_uptodate(bh, 1);
-			mark_buffer_dirty_inode(bh, inode);
-		}
-		return bh;
-	}
-	return NULL;
-}
-
-struct buffer_head * ext2_bread (struct inode * inode, int block, 
-				 int create, int *err)
-{
-	struct buffer_head * bh;
-	int prev_blocks;
-	
-	prev_blocks = inode->i_blocks;
-	
-	bh = ext2_getblk (inode, block, create, err);
-	if (!bh)
-		return bh;
-	
-	/*
-	 * If the inode has grown, and this is a directory, then perform
-	 * preallocation of a few more blocks to try to keep directory
-	 * fragmentation down.
-	 */
-	if (create && 
-	    S_ISDIR(inode->i_mode) && 
-	    inode->i_blocks > prev_blocks &&
-	    EXT2_HAS_COMPAT_FEATURE(inode->i_sb,
-				    EXT2_FEATURE_COMPAT_DIR_PREALLOC)) {
-		int i;
-		struct buffer_head *tmp_bh;
-		
-		for (i = 1;
-		     i < EXT2_SB(inode->i_sb)->s_es->s_prealloc_dir_blocks;
-		     i++) {
-			/* 
-			 * ext2_getblk will zero out the contents of the
-			 * directory for us
-			 */
-			tmp_bh = ext2_getblk(inode, block+i, create, err);
-			if (!tmp_bh) {
-				brelse (bh);
-				return 0;
-			}
-			brelse (tmp_bh);
-		}
-	}
-	
-	if (buffer_uptodate(bh))
-		return bh;
-	ll_rw_block (READ, 1, &bh);
-	wait_on_buffer (bh);
-	if (buffer_uptodate(bh))
-		return bh;
-	brelse (bh);
-	*err = -EIO;
-	return NULL;
-}
-
 static int ext2_writepage(struct page *page)
 {
 	return block_write_full_page(page,ext2_get_block);
@@ -1066,6 +990,7 @@
 	} else if (S_ISDIR(inode->i_mode)) {
 		inode->i_op = &ext2_dir_inode_operations;
 		inode->i_fop = &ext2_dir_operations;
+		inode->i_mapping->a_ops = &ext2_aops;
 	} else if (S_ISLNK(inode->i_mode)) {
 		if (!inode->i_blocks)
 			inode->i_op = &ext2_fast_symlink_inode_operations;
--- ../uml.2.4.2.clean/fs/ext2/namei.c	Thu Feb 15 21:32:21 2001
+++ ./fs/ext2/namei.c	Thu Mar  8 23:17:59 2001
@@ -1,5 +1,22 @@
 /*
- *  linux/fs/ext2/namei.c
+ * linux/fs/ext2/namei.c
+ *
+ * Rewrite to pagecache. Almost all code had been changed, so blame me
+ * if the things go wrong. Please, send bug reports to viro@math.psu.edu
+ * WARNING - rewrite is not complete yet, so don't trust your data to this
+ * code unless you have full backups and are ready to restore everything.
+ * I'm not kidding - it is an alpha code and should be treated as such.	-- AV
+ *
+ * Stuff here is basically a glue between the VFS and generic UNIXish
+ * filesystem that keeps everything in pagecache. All knowledge of the
+ * directory layout is in fs/ext2/dir.c - it turned out to be easily separatable
+ * and it's easier to debug that way. In principle we might want to
+ * generalize that a bit and turn it into a library. Or not.
+ *
+ * The only non-static object here is ext2_dir_inode_operations.
+ *
+ * TODO: get rid of kmap() use, add readahead. Right now I just want to get
+ * the code working and make it stop eating filesystems.
  *
  * Copyright (C) 1992, 1993, 1994, 1995
  * Remy Card (card@masi.ibp.fr)
@@ -14,344 +31,63 @@
  *
  *  Big-endian to little-endian byte-swapping/bitmaps by
  *        David S. Miller (davem@caip.rutgers.edu), 1995
- *  Directory entry file type support and forward compatibility hooks
- *  	for B-tree directories by Theodore Ts'o (tytso@mit.edu), 1998
  */
 
 #include <linux/fs.h>
 #include <linux/ext2_fs.h>
-#include <linux/locks.h>
-#include <linux/quotaops.h>
-
-
+#include <linux/pagemap.h>
 
 /*
- * define how far ahead to read directories while searching them.
+ * Couple of helper functions - make the code slightly cleaner.
  */
-#define NAMEI_RA_CHUNKS  2
-#define NAMEI_RA_BLOCKS  4
-#define NAMEI_RA_SIZE        (NAMEI_RA_CHUNKS * NAMEI_RA_BLOCKS)
-#define NAMEI_RA_INDEX(c,b)  (((c) * NAMEI_RA_BLOCKS) + (b))
 
-/*
- * NOTE! unlike strncmp, ext2_match returns 1 for success, 0 for failure.
- *
- * `len <= EXT2_NAME_LEN' is guaranteed by caller.
- * `de != NULL' is guaranteed by caller.
- */
-static inline int ext2_match (int len, const char * const name,
-		       struct ext2_dir_entry_2 * de)
+static inline void ext2_inc_count(struct inode *inode)
 {
-	if (len != de->name_len)
-		return 0;
-	if (!de->inode)
-		return 0;
-	return !memcmp(name, de->name, len);
+	inode->i_nlink++;
+	mark_inode_dirty(inode);
 }
 
-/*
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
-	unsigned long offset;
-	int block, toread, i, err;
-
-	*res_dir = NULL;
-	sb = dir->i_sb;
-
-	if (namelen > EXT2_NAME_LEN)
-		return NULL;
-
-	memset (bh_use, 0, sizeof (bh_use));
-	toread = 0;
-	for (block = 0; block < NAMEI_RA_SIZE; ++block) {
-		struct buffer_head * bh;
-
-		if ((block << EXT2_BLOCK_SIZE_BITS (sb)) >= dir->i_size)
-			break;
-		bh = ext2_getblk (dir, block, 0, &err);
-		bh_use[block] = bh;
-		if (bh && !buffer_uptodate(bh))
-			bh_read[toread++] = bh;
-	}
-
-	for (block = 0, offset = 0; offset < dir->i_size; block++) {
-		struct buffer_head * bh;
-		struct ext2_dir_entry_2 * de;
-		char * dlimit;
-
-		if ((block % NAMEI_RA_BLOCKS) == 0 && toread) {
-			ll_rw_block (READ, toread, bh_read);
-			toread = 0;
-		}
-		bh = bh_use[block % NAMEI_RA_SIZE];
-		if (!bh) {
-#if 0
-			ext2_error (sb, "ext2_find_entry",
-				    "directory #%lu contains a hole at offset %lu",
-				    dir->i_ino, offset);
-#endif
-			offset += sb->s_blocksize;
-			continue;
-		}
-		wait_on_buffer (bh);
-		if (!buffer_uptodate(bh)) {
-			/*
-			 * read error: all bets are off
-			 */
-			break;
-		}
-
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
-		}
+static inline void ext2_dec_count(struct inode *inode)
+{
+	inode->i_nlink--;
+	mark_inode_dirty(inode);
+}
 
-		brelse (bh);
-		if (((block + NAMEI_RA_SIZE) << EXT2_BLOCK_SIZE_BITS (sb)) >=
-		    dir->i_size)
-			bh = NULL;
-		else
-			bh = ext2_getblk (dir, block + NAMEI_RA_SIZE, 0, &err);
-		bh_use[block % NAMEI_RA_SIZE] = bh;
-		if (bh && !buffer_uptodate(bh))
-			bh_read[toread++] = bh;
+static inline int ext2_add_nondir(struct dentry *dentry, struct inode *inode)
+{
+	int err = ext2_add_entry(dentry, inode);
+	if (!err) {
+		d_instantiate(dentry, inode);
+		return 0;
 	}
-
-failure:
-	for (i = 0; i < NAMEI_RA_SIZE; ++i)
-		brelse (bh_use[i]);
-	return NULL;
+	ext2_dec_count(inode);
+	iput(inode);
+	return err;
 }
 
+/*
+ * Methods
+ */
+
 static struct dentry *ext2_lookup(struct inode * dir, struct dentry *dentry)
 {
 	struct inode * inode;
-	struct ext2_dir_entry_2 * de;
-	struct buffer_head * bh;
-
+	ino_t ino;
+	
 	if (dentry->d_name.len > EXT2_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	bh = ext2_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &de);
+	ino = ext2_find_inode(dir, dentry);
 	inode = NULL;
-	if (bh) {
-		unsigned long ino = le32_to_cpu(de->inode);
-		brelse (bh);
+	if (ino) {
 		inode = iget(dir->i_sb, ino);
-
-		if (!inode)
+		if (!inode) 
 			return ERR_PTR(-EACCES);
 	}
 	d_add(dentry, inode);
 	return NULL;
 }
 
-#define S_SHIFT 12
-static unsigned char ext2_type_by_mode[S_IFMT >> S_SHIFT] = {
-	[S_IFREG >> S_SHIFT]	EXT2_FT_REG_FILE,
-	[S_IFDIR >> S_SHIFT]	EXT2_FT_DIR,
-	[S_IFCHR >> S_SHIFT]	EXT2_FT_CHRDEV,
-	[S_IFBLK >> S_SHIFT]	EXT2_FT_BLKDEV,
-	[S_IFIFO >> S_SHIFT]	EXT2_FT_FIFO,
-	[S_IFSOCK >> S_SHIFT]	EXT2_FT_SOCK,
-	[S_IFLNK >> S_SHIFT]	EXT2_FT_SYMLINK,
-};
-
-static inline void ext2_set_de_type(struct super_block *sb,
-				struct ext2_dir_entry_2 *de,
-				umode_t mode) {
-	if (EXT2_HAS_INCOMPAT_FEATURE(sb, EXT2_FEATURE_INCOMPAT_FILETYPE))
-		de->file_type = ext2_type_by_mode[(mode & S_IFMT)>>S_SHIFT];
-}
-
-/*
- *	ext2_add_entry()
- *
- * adds a file entry to the specified directory.
- */
-int ext2_add_entry (struct inode * dir, const char * name, int namelen,
-		    struct inode *inode)
-{
-	unsigned long offset;
-	unsigned short rec_len;
-	struct buffer_head * bh;
-	struct ext2_dir_entry_2 * de, * de1;
-	struct super_block * sb;
-	int	retval;
-
-	sb = dir->i_sb;
-
-	if (!namelen)
-		return -EINVAL;
-	bh = ext2_bread (dir, 0, 0, &retval);
-	if (!bh)
-		return retval;
-	rec_len = EXT2_DIR_REC_LEN(namelen);
-	offset = 0;
-	de = (struct ext2_dir_entry_2 *) bh->b_data;
-	while (1) {
-		if ((char *)de >= sb->s_blocksize + bh->b_data) {
-			brelse (bh);
-			bh = NULL;
-			bh = ext2_bread (dir, offset >> EXT2_BLOCK_SIZE_BITS(sb), 1, &retval);
-			if (!bh)
-				return retval;
-			if (dir->i_size <= offset) {
-				if (dir->i_size == 0) {
-					brelse(bh);
-					return -ENOENT;
-				}
-
-				ext2_debug ("creating next block\n");
-
-				de = (struct ext2_dir_entry_2 *) bh->b_data;
-				de->inode = 0;
-				de->rec_len = le16_to_cpu(sb->s_blocksize);
-				dir->i_size = offset + sb->s_blocksize;
-				dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
-				mark_inode_dirty(dir);
-			} else {
-
-				ext2_debug ("skipping to next block\n");
-
-				de = (struct ext2_dir_entry_2 *) bh->b_data;
-			}
-		}
-		if (!ext2_check_dir_entry ("ext2_add_entry", dir, de, bh,
-					   offset)) {
-			brelse (bh);
-			return -ENOENT;
-		}
-		if (ext2_match (namelen, name, de)) {
-				brelse (bh);
-				return -EEXIST;
-		}
-		if ((le32_to_cpu(de->inode) == 0 && le16_to_cpu(de->rec_len) >= rec_len) ||
-		    (le16_to_cpu(de->rec_len) >= EXT2_DIR_REC_LEN(de->name_len) + rec_len)) {
-			offset += le16_to_cpu(de->rec_len);
-			if (le32_to_cpu(de->inode)) {
-				de1 = (struct ext2_dir_entry_2 *) ((char *) de +
-					EXT2_DIR_REC_LEN(de->name_len));
-				de1->rec_len = cpu_to_le16(le16_to_cpu(de->rec_len) -
-					EXT2_DIR_REC_LEN(de->name_len));
-				de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(de->name_len));
-				de = de1;
-			}
-			de->file_type = EXT2_FT_UNKNOWN;
-			if (inode) {
-				de->inode = cpu_to_le32(inode->i_ino);
-				ext2_set_de_type(dir->i_sb, de, inode->i_mode);
-			} else
-				de->inode = 0;
-			de->name_len = namelen;
-			memcpy (de->name, name, namelen);
-			/*
-			 * XXX shouldn't update any times until successful
-			 * completion of syscall, but too many callers depend
-			 * on this.
-			 *
-			 * XXX similarly, too many callers depend on
-			 * ext2_new_inode() setting the times, but error
-			 * recovery deletes the inode, so the worst that can
-			 * happen is that the times are slightly out of date
-			 * and/or different from the directory change time.
-			 */
-			dir->i_mtime = dir->i_ctime = CURRENT_TIME;
-			dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
-			mark_inode_dirty(dir);
-			dir->i_version = ++event;
-			mark_buffer_dirty_inode(bh, dir);
-			if (IS_SYNC(dir)) {
-				ll_rw_block (WRITE, 1, &bh);
-				wait_on_buffer (bh);
-			}
-			brelse(bh);
-			return 0;
-		}
-		offset += le16_to_cpu(de->rec_len);
-		de = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
-	}
-	brelse (bh);
-	return -ENOSPC;
-}
-
-/*
- * ext2_delete_entry deletes a directory entry by merging it with the
- * previous entry
- */
-static int ext2_delete_entry (struct inode * dir,
-			      struct ext2_dir_entry_2 * de_del,
-			      struct buffer_head * bh)
-{
-	struct ext2_dir_entry_2 * de, * pde;
-	int i;
-
-	i = 0;
-	pde = NULL;
-	de = (struct ext2_dir_entry_2 *) bh->b_data;
-	while (i < bh->b_size) {
-		if (!ext2_check_dir_entry ("ext2_delete_entry", NULL, 
-					   de, bh, i))
-			return -EIO;
-		if (de == de_del)  {
-			if (pde)
-				pde->rec_len =
-					cpu_to_le16(le16_to_cpu(pde->rec_len) +
-						    le16_to_cpu(de->rec_len));
-			else
-				de->inode = 0;
-			dir->i_version = ++event;
-			mark_buffer_dirty_inode(bh, dir);
-			if (IS_SYNC(dir)) {
-				ll_rw_block (WRITE, 1, &bh);
-				wait_on_buffer (bh);
-			}
-			return 0;
-		}
-		i += le16_to_cpu(de->rec_len);
-		pde = de;
-		de = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
-	}
-	return -ENOENT;
-}
-
 /*
  * By the time this is called, we already have created
  * the directory cache entry for the new file, but it
@@ -364,454 +100,245 @@
 {
 	struct inode * inode = ext2_new_inode (dir, mode);
 	int err = PTR_ERR(inode);
-	if (IS_ERR(inode))
-		return err;
-
-	inode->i_op = &ext2_file_inode_operations;
-	inode->i_fop = &ext2_file_operations;
-	inode->i_mapping->a_ops = &ext2_aops;
-	inode->i_mode = mode;
-	mark_inode_dirty(inode);
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
-	if (err) {
-		inode->i_nlink--;
+	if (!IS_ERR(inode)) {
+		inode->i_op = &ext2_file_inode_operations;
+		inode->i_fop = &ext2_file_operations;
+		inode->i_mapping->a_ops = &ext2_aops;
 		mark_inode_dirty(inode);
-		iput (inode);
-		return err;
+		err = ext2_add_nondir(dentry, inode);
 	}
-	d_instantiate(dentry, inode);
-	return 0;
+	return err;
 }
 
 static int ext2_mknod (struct inode * dir, struct dentry *dentry, int mode, int rdev)
 {
 	struct inode * inode = ext2_new_inode (dir, mode);
 	int err = PTR_ERR(inode);
-
-	if (IS_ERR(inode))
-		return err;
-
-	inode->i_uid = current->fsuid;
-	init_special_inode(inode, mode, rdev);
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
-	if (err)
-		goto out_no_entry;
-	mark_inode_dirty(inode);
-	d_instantiate(dentry, inode);
-	return 0;
-
-out_no_entry:
-	inode->i_nlink--;
-	mark_inode_dirty(inode);
-	iput(inode);
+	if (!IS_ERR(inode)) {
+		init_special_inode(inode, mode, rdev);
+		mark_inode_dirty(inode);
+		err = ext2_add_nondir(dentry, inode);
+	}
 	return err;
 }
 
-static int ext2_mkdir(struct inode * dir, struct dentry * dentry, int mode)
+static int ext2_symlink (struct inode * dir, struct dentry * dentry,
+	const char * symname)
 {
+	struct super_block * sb = dir->i_sb;
+	int err = -ENAMETOOLONG;
+	unsigned l = strlen(symname)+1;
 	struct inode * inode;
-	struct buffer_head * dir_block;
-	struct ext2_dir_entry_2 * de;
-	int err;
 
-	if (dir->i_nlink >= EXT2_LINK_MAX)
-		return -EMLINK;
+	if (l > sb->s_blocksize)
+		goto out;
 
-	inode = ext2_new_inode (dir, S_IFDIR);
+	inode = ext2_new_inode (dir, S_IFLNK | S_IRWXUGO);
 	err = PTR_ERR(inode);
 	if (IS_ERR(inode))
-		return err;
+		goto out;
 
-	inode->i_op = &ext2_dir_inode_operations;
-	inode->i_fop = &ext2_dir_operations;
-	inode->i_size = inode->i_sb->s_blocksize;
-	inode->i_blocks = 0;	
-	dir_block = ext2_bread (inode, 0, 1, &err);
-	if (!dir_block) {
-		inode->i_nlink--; /* is this nlink == 0? */
-		mark_inode_dirty(inode);
-		iput (inode);
-		return err;
+	if (l > sizeof (inode->u.ext2_i.i_data)) {
+		/* slow symlink */
+		inode->i_op = &page_symlink_inode_operations;
+		inode->i_mapping->a_ops = &ext2_aops;
+		err = block_symlink(inode, symname, l);
+		if (err)
+			goto out_fail;
+	} else {
+		/* fast symlink */
+		inode->i_op = &ext2_fast_symlink_inode_operations;
+		memcpy((char*)&inode->u.ext2_i.i_data,symname,l);
+		inode->i_size = l-1;
 	}
-	de = (struct ext2_dir_entry_2 *) dir_block->b_data;
-	de->inode = cpu_to_le32(inode->i_ino);
-	de->name_len = 1;
-	de->rec_len = cpu_to_le16(EXT2_DIR_REC_LEN(de->name_len));
-	strcpy (de->name, ".");
-	ext2_set_de_type(dir->i_sb, de, S_IFDIR);
-	de = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
-	de->inode = cpu_to_le32(dir->i_ino);
-	de->rec_len = cpu_to_le16(inode->i_sb->s_blocksize - EXT2_DIR_REC_LEN(1));
-	de->name_len = 2;
-	strcpy (de->name, "..");
-	ext2_set_de_type(dir->i_sb, de, S_IFDIR);
-	inode->i_nlink = 2;
-	mark_buffer_dirty_inode(dir_block, dir);
-	brelse (dir_block);
-	inode->i_mode = S_IFDIR | mode;
-	if (dir->i_mode & S_ISGID)
-		inode->i_mode |= S_ISGID;
 	mark_inode_dirty(inode);
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
-	if (err)
-		goto out_no_entry;
-	dir->i_nlink++;
-	dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
-	mark_inode_dirty(dir);
-	d_instantiate(dentry, inode);
-	return 0;
 
-out_no_entry:
-	inode->i_nlink = 0;
-	mark_inode_dirty(inode);
-	iput (inode);
+	err = ext2_add_nondir(dentry, inode);
+out:
 	return err;
-}
 
-/*
- * routine to check that the specified directory is empty (for rmdir)
- */
-static int empty_dir (struct inode * inode)
-{
-	unsigned long offset;
-	struct buffer_head * bh;
-	struct ext2_dir_entry_2 * de, * de1;
-	struct super_block * sb;
-	int err;
-
-	sb = inode->i_sb;
-	if (inode->i_size < EXT2_DIR_REC_LEN(1) + EXT2_DIR_REC_LEN(2) ||
-	    !(bh = ext2_bread (inode, 0, 0, &err))) {
-	    	ext2_warning (inode->i_sb, "empty_dir",
-			      "bad directory (dir #%lu) - no data block",
-			      inode->i_ino);
-		return 1;
-	}
-	de = (struct ext2_dir_entry_2 *) bh->b_data;
-	de1 = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
-	if (le32_to_cpu(de->inode) != inode->i_ino || !le32_to_cpu(de1->inode) || 
-	    strcmp (".", de->name) || strcmp ("..", de1->name)) {
-	    	ext2_warning (inode->i_sb, "empty_dir",
-			      "bad directory (dir #%lu) - no `.' or `..'",
-			      inode->i_ino);
-		brelse (bh);
-		return 1;
-	}
-	offset = le16_to_cpu(de->rec_len) + le16_to_cpu(de1->rec_len);
-	de = (struct ext2_dir_entry_2 *) ((char *) de1 + le16_to_cpu(de1->rec_len));
-	while (offset < inode->i_size ) {
-		if (!bh || (void *) de >= (void *) (bh->b_data + sb->s_blocksize)) {
-			brelse (bh);
-			bh = ext2_bread (inode, offset >> EXT2_BLOCK_SIZE_BITS(sb), 0, &err);
-			if (!bh) {
-#if 0
-				ext2_error (sb, "empty_dir",
-					    "directory #%lu contains a hole at offset %lu",
-					    inode->i_ino, offset);
-#endif
-				offset += sb->s_blocksize;
-				continue;
-			}
-			de = (struct ext2_dir_entry_2 *) bh->b_data;
-		}
-		if (!ext2_check_dir_entry ("empty_dir", inode, de, bh,
-					   offset)) {
-			brelse (bh);
-			return 1;
-		}
-		if (le32_to_cpu(de->inode)) {
-			brelse (bh);
-			return 0;
-		}
-		offset += le16_to_cpu(de->rec_len);
-		de = (struct ext2_dir_entry_2 *) ((char *) de + le16_to_cpu(de->rec_len));
-	}
-	brelse (bh);
-	return 1;
+out_fail:
+	ext2_dec_count(inode);
+	iput (inode);
+	goto out;
 }
 
-static int ext2_rmdir (struct inode * dir, struct dentry *dentry)
+static int ext2_link (struct dentry * old_dentry, struct inode * dir,
+	struct dentry *dentry)
 {
-	int retval;
-	struct inode * inode;
-	struct buffer_head * bh;
-	struct ext2_dir_entry_2 * de;
+	struct inode *inode = old_dentry->d_inode;
 
-	retval = -ENOENT;
-	bh = ext2_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &de);
-	if (!bh)
-		goto end_rmdir;
-
-	inode = dentry->d_inode;
-	DQUOT_INIT(inode);
-
-	retval = -EIO;
-	if (le32_to_cpu(de->inode) != inode->i_ino)
-		goto end_rmdir;
-
-	retval = -ENOTEMPTY;
-	if (!empty_dir (inode))
-		goto end_rmdir;
-
-	retval = ext2_delete_entry(dir, de, bh);
-	if (retval)
-		goto end_rmdir;
-	if (inode->i_nlink != 2)
-		ext2_warning (inode->i_sb, "ext2_rmdir",
-			      "empty directory has nlink!=2 (%d)",
-			      inode->i_nlink);
-	inode->i_version = ++event;
-	inode->i_nlink = 0;
-	inode->i_size = 0;
-	mark_inode_dirty(inode);
-	dir->i_nlink--;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
-	mark_inode_dirty(dir);
-
-end_rmdir:
-	brelse (bh);
-	return retval;
-}
+	if (S_ISDIR(inode->i_mode))
+		return -EPERM;
 
-static int ext2_unlink(struct inode * dir, struct dentry *dentry)
-{
-	int retval;
-	struct inode * inode;
-	struct buffer_head * bh;
-	struct ext2_dir_entry_2 * de;
+	if (inode->i_nlink >= EXT2_LINK_MAX)
+		return -EMLINK;
 
-	retval = -ENOENT;
-	bh = ext2_find_entry (dir, dentry->d_name.name, dentry->d_name.len, &de);
-	if (!bh)
-		goto end_unlink;
-
-	inode = dentry->d_inode;
-	DQUOT_INIT(inode);
-
-	retval = -EIO;
-	if (le32_to_cpu(de->inode) != inode->i_ino)
-		goto end_unlink;
-	
-	if (!inode->i_nlink) {
-		ext2_warning (inode->i_sb, "ext2_unlink",
-			      "Deleting nonexistent file (%lu), %d",
-			      inode->i_ino, inode->i_nlink);
-		inode->i_nlink = 1;
-	}
-	retval = ext2_delete_entry(dir, de, bh);
-	if (retval)
-		goto end_unlink;
-	dir->i_ctime = dir->i_mtime = CURRENT_TIME;
-	dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
-	mark_inode_dirty(dir);
-	inode->i_nlink--;
-	mark_inode_dirty(inode);
-	inode->i_ctime = dir->i_ctime;
-	retval = 0;
+	inode->i_ctime = CURRENT_TIME;
+	ext2_inc_count(inode);
+	atomic_inc(&inode->i_count);
 
-end_unlink:
-	brelse (bh);
-	return retval;
+	return ext2_add_nondir(dentry, inode);
 }
 
-static int ext2_symlink (struct inode * dir, struct dentry *dentry, const char * symname)
+static int ext2_mkdir(struct inode * dir, struct dentry * dentry, int mode)
 {
 	struct inode * inode;
-	int l, err;
+	int err = -EMLINK;
 
-	l = strlen(symname)+1;
-	if (l > dir->i_sb->s_blocksize)
-		return -ENAMETOOLONG;
+	if (dir->i_nlink >= EXT2_LINK_MAX)
+		goto out;
+
+	ext2_inc_count(dir);
 
-	inode = ext2_new_inode (dir, S_IFLNK);
+	inode = ext2_new_inode (dir, S_IFDIR | mode);
 	err = PTR_ERR(inode);
 	if (IS_ERR(inode))
-		return err;
+		goto out_dir;
 
-	inode->i_mode = S_IFLNK | S_IRWXUGO;
+	inode->i_op = &ext2_dir_inode_operations;
+	inode->i_fop = &ext2_dir_operations;
+	inode->i_mapping->a_ops = &ext2_aops;
 
-	if (l > sizeof (inode->u.ext2_i.i_data)) {
-		inode->i_op = &page_symlink_inode_operations;
-		inode->i_mapping->a_ops = &ext2_aops;
-		err = block_symlink(inode, symname, l);
-		if (err)
-			goto out_no_entry;
-	} else {
-		inode->i_op = &ext2_fast_symlink_inode_operations;
-		memcpy((char*)&inode->u.ext2_i.i_data,symname,l);
-		inode->i_size = l-1;
-	}
-	mark_inode_dirty(inode);
+	ext2_inc_count(inode);
 
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_make_empty(inode, dir);
 	if (err)
-		goto out_no_entry;
-	d_instantiate(dentry, inode);
-	return 0;
+		goto out_fail;
 
-out_no_entry:
-	inode->i_nlink--;
-	mark_inode_dirty(inode);
-	iput (inode);
+	err = ext2_add_entry(dentry, inode);
+	if (err)
+		goto out_fail;
+
+	d_instantiate(dentry, inode);
+out:
 	return err;
+
+out_fail:
+	ext2_dec_count(inode);
+	ext2_dec_count(inode);
+	iput(inode);
+out_dir:
+	ext2_dec_count(dir);
+	goto out;
 }
 
-static int ext2_link (struct dentry * old_dentry,
-		struct inode * dir, struct dentry *dentry)
+static int ext2_unlink(struct inode * dir, struct dentry *dentry)
 {
-	struct inode *inode = old_dentry->d_inode;
-	int err;
+	struct inode * inode = dentry->d_inode;
+	struct ext2_dir_entry_2 * de;
+	struct page * page;
+	int err = -ENOENT;
 
-	if (S_ISDIR(inode->i_mode))
-		return -EPERM;
+	de = ext2_find_entry (dir, dentry, &page);
+	if (!de)
+		goto out;
 
-	if (inode->i_nlink >= EXT2_LINK_MAX)
-		return -EMLINK;
-	
-	err = ext2_add_entry (dir, dentry->d_name.name, dentry->d_name.len, 
-			     inode);
+	err = ext2_del_entry (de, page);
 	if (err)
-		return err;
+		goto out;
 
-	inode->i_nlink++;
-	inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(inode);
-	atomic_inc(&inode->i_count);
-	d_instantiate(dentry, inode);
-	return 0;
+	inode->i_ctime = dir->i_ctime;
+	ext2_dec_count(inode);
+	err = 0;
+out:
+	return err;
 }
 
-#define PARENT_INO(buffer) \
-	((struct ext2_dir_entry_2 *) ((char *) buffer + \
-	le16_to_cpu(((struct ext2_dir_entry_2 *) buffer)->rec_len)))->inode
-
-/*
- * Anybody can rename anything with this: the permission checks are left to the
- * higher-level routines.
- */
-static int ext2_rename (struct inode * old_dir, struct dentry *old_dentry,
-			   struct inode * new_dir,struct dentry *new_dentry)
+static int ext2_rmdir (struct inode * dir, struct dentry *dentry)
 {
-	struct inode * old_inode, * new_inode;
-	struct buffer_head * old_bh, * new_bh, * dir_bh;
-	struct ext2_dir_entry_2 * old_de, * new_de;
-	int retval;
-
-	old_bh = new_bh = dir_bh = NULL;
-
-	old_bh = ext2_find_entry (old_dir, old_dentry->d_name.name, old_dentry->d_name.len, &old_de);
-	/*
-	 *  Check for inode number is _not_ due to possible IO errors.
-	 *  We might rmdir the source, keep it as pwd of some process
-	 *  and merrily kill the link to whatever was created under the
-	 *  same name. Goodbye sticky bit ;-<
-	 */
-	old_inode = old_dentry->d_inode;
-	retval = -ENOENT;
-	if (!old_bh || le32_to_cpu(old_de->inode) != old_inode->i_ino)
-		goto end_rename;
-
-	new_inode = new_dentry->d_inode;
-	new_bh = ext2_find_entry (new_dir, new_dentry->d_name.name,
-				new_dentry->d_name.len, &new_de);
-	if (new_bh) {
-		if (!new_inode) {
-			brelse (new_bh);
-			new_bh = NULL;
-		} else {
-			DQUOT_INIT(new_inode);
+	struct inode * inode = dentry->d_inode;
+	int err = -ENOTEMPTY;
+
+	if (ext2_is_empty(inode)) {
+		err = ext2_unlink(dir, dentry);
+		if (!err) {
+			inode->i_size = 0;
+			ext2_dec_count(inode);
+			ext2_dec_count(dir);
 		}
 	}
+	return err;
+}
+
+static int ext2_rename (struct inode * old_dir, struct dentry * old_dentry,
+	struct inode * new_dir,	struct dentry * new_dentry )
+{
+	struct inode * old_inode = old_dentry->d_inode;
+	struct inode * new_inode = new_dentry->d_inode;
+	struct page * dir_page = NULL;
+	struct ext2_dir_entry_2 * dir_de = NULL;
+	struct page * old_page;
+	struct ext2_dir_entry_2 * old_de;
+	int err = -ENOENT;
+
+	old_de = ext2_find_entry (old_dir, old_dentry, &old_page);
+	if (!old_de)
+		goto out;
+
 	if (S_ISDIR(old_inode->i_mode)) {
-		if (new_inode) {
-			retval = -ENOTEMPTY;
-			if (!empty_dir (new_inode))
-				goto end_rename;
-		}
-		retval = -EIO;
-		dir_bh = ext2_bread (old_inode, 0, 0, &retval);
-		if (!dir_bh)
-			goto end_rename;
-		if (le32_to_cpu(PARENT_INO(dir_bh->b_data)) != old_dir->i_ino)
-			goto end_rename;
-		retval = -EMLINK;
-		if (!new_inode && new_dir!=old_dir &&
-				new_dir->i_nlink >= EXT2_LINK_MAX)
-			goto end_rename;
+		err = -EIO;
+		dir_de = ext2_parent(old_inode, &dir_page);
+		if (!dir_de)
+			goto out_old;
 	}
-	if (!new_bh) {
-		retval = ext2_add_entry (new_dir, new_dentry->d_name.name,
-					 new_dentry->d_name.len,
-					 old_inode);
-		if (retval)
-			goto end_rename;
-	} else {
-		new_de->inode = le32_to_cpu(old_inode->i_ino);
-		if (EXT2_HAS_INCOMPAT_FEATURE(new_dir->i_sb,
-					      EXT2_FEATURE_INCOMPAT_FILETYPE))
-			new_de->file_type = old_de->file_type;
-		new_dir->i_version = ++event;
-		mark_buffer_dirty_inode(new_bh, new_dir);
-		if (IS_SYNC(new_dir)) {
-			ll_rw_block (WRITE, 1, &new_bh);
-			wait_on_buffer (new_bh);
-		}
-		brelse(new_bh);
-		new_bh = NULL;
-	}
-	
-	/*
-	 * Like most other Unix systems, set the ctime for inodes on a
-	 * rename.
-	 */
-	old_inode->i_ctime = CURRENT_TIME;
-	mark_inode_dirty(old_inode);
-
-	/*
-	 * ok, that's it
-	 */
-	ext2_delete_entry(old_dir, old_de, old_bh);
 
 	if (new_inode) {
-		new_inode->i_nlink--;
+		struct page *new_page;
+		struct ext2_dir_entry_2 *new_de;
+
+		err = -ENOTEMPTY;
+		if (dir_de && !ext2_is_empty (new_inode))
+			goto out_dir;
+
+		err = -ENOENT;
+		new_de = ext2_find_entry (new_dir, new_dentry, &new_page);
+		if (!new_de)
+			goto out_dir;
+		ext2_inc_count(old_inode);
+		ext2_set_entry(new_dir, new_de, new_page, old_inode);
 		new_inode->i_ctime = CURRENT_TIME;
-		mark_inode_dirty(new_inode);
-	}
-	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
-	old_dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
-	mark_inode_dirty(old_dir);
-	if (dir_bh) {
-		PARENT_INO(dir_bh->b_data) = le32_to_cpu(new_dir->i_ino);
-		mark_buffer_dirty_inode(dir_bh, old_inode);
-		old_dir->i_nlink--;
-		mark_inode_dirty(old_dir);
-		if (new_inode) {
+		if (dir_de)
 			new_inode->i_nlink--;
-			mark_inode_dirty(new_inode);
-		} else {
-			new_dir->i_nlink++;
-			new_dir->u.ext2_i.i_flags &= ~EXT2_BTREE_FL;
-			mark_inode_dirty(new_dir);
-		}
+		ext2_dec_count(new_inode);
+	} else {
+		if (dir_de) {
+			err = -EMLINK;
+			if (new_dir->i_nlink >= EXT2_LINK_MAX)
+				goto out_dir;
+		}
+		ext2_inc_count(old_inode);
+		err = ext2_add_entry(new_dentry, old_inode);
+		if (err) {
+			ext2_dec_count(old_inode);
+			goto out_dir;
+		}
+		if (dir_de)
+			ext2_inc_count(new_dir);
+	}
+
+	ext2_del_entry (old_de, old_page);
+	ext2_dec_count(old_inode);
+
+	if (dir_de) {
+		ext2_set_entry(old_inode, dir_de, dir_page, new_dir);
+		ext2_dec_count(old_dir);
 	}
+	return 0;
 
-	retval = 0;
 
-end_rename:
-	brelse (dir_bh);
-	brelse (old_bh);
-	brelse (new_bh);
-	return retval;
+out_dir:
+	if (dir_de) {
+		kunmap(dir_page);
+		page_cache_release(dir_page);
+	}
+out_old:
+	kunmap(old_page);
+	page_cache_release(old_page);
+out:
+	return err;
 }
 
-/*
- * directories can handle most operations...
- */
 struct inode_operations ext2_dir_inode_operations = {
 	create:		ext2_create,
 	lookup:		ext2_lookup,
--- ../uml.2.4.2.clean/fs/ext2/super.c	Fri Dec 29 23:36:44 2000
+++ ./fs/ext2/super.c	Thu Mar  8 23:17:59 2001
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
--- ../uml.2.4.2.clean/include/linux/ext2_fs.h	Thu Feb 22 01:09:57 2001
+++ ./include/linux/ext2_fs.h	Thu Mar  8 23:20:27 2001
@@ -40,6 +40,12 @@
 #define EXT2FS_VERSION		"0.5b"
 
 /*
+ * Hash Tree Directory indexing
+ * (c) 2001, Daniel Phillips
+ */
+#define CONFIG_EXT2_INDEX
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
@@ -498,16 +505,17 @@
  * Ext2 directory file types.  Only the low 3 bits are used.  The
  * other bits are reserved for now.
  */
-#define EXT2_FT_UNKNOWN		0
-#define EXT2_FT_REG_FILE	1
-#define EXT2_FT_DIR		2
-#define EXT2_FT_CHRDEV		3
-#define EXT2_FT_BLKDEV 		4
-#define EXT2_FT_FIFO		5
-#define EXT2_FT_SOCK		6
-#define EXT2_FT_SYMLINK		7
-
-#define EXT2_FT_MAX		8
+enum {
+	EXT2_FT_UNKNOWN,
+	EXT2_FT_REG_FILE,
+	EXT2_FT_DIR,
+	EXT2_FT_CHRDEV,
+	EXT2_FT_BLKDEV,
+	EXT2_FT_FIFO,
+	EXT2_FT_SOCK,
+	EXT2_FT_SYMLINK,
+	EXT2_FT_MAX
+};
 
 /*
  * EXT2_DIR_PAD defines the directory entries boundaries
@@ -519,6 +527,16 @@
 #define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
 					 ~EXT2_DIR_ROUND)
 
+/*
+ * Hash Tree Directory indexing
+ * (c) 2001, Daniel Phillips
+ */
+#ifdef CONFIG_EXT2_INDEX
+#define is_dx(dir) (dir->u.ext2_i.i_flags & EXT2_INDEX_FL)
+#define dx_entries_per_block(sb) (EXT2_BLOCK_SIZE(sb) >> 3)
+#define dx_dir_base(sb) (dx_entries_per_block(sb) - 1 + 1)
+#endif
+
 #ifdef __KERNEL__
 /*
  * Function prototypes
@@ -552,9 +570,6 @@
 extern unsigned long ext2_count_free (struct buffer_head *, unsigned);
 
 /* dir.c */
-extern int ext2_check_dir_entry (const char *, struct inode *,
-				 struct ext2_dir_entry_2 *, struct buffer_head *,
-				 unsigned long);
 
 /* file.c */
 extern int ext2_read (struct inode *, struct file *, char *, int);
@@ -612,7 +627,16 @@
  */
 
 /* dir.c */
+typedef struct ext2_dir_entry_2 ext2_dirent;
 extern struct file_operations ext2_dir_operations;
+extern int ext2_make_empty (struct inode *, struct inode *);
+extern ext2_dirent *ext2_find_entry (struct inode *,struct dentry *, struct page **);
+extern int ext2_add_entry (struct dentry *, struct inode *);
+extern int ext2_del_entry (ext2_dirent *, struct page *);
+extern void ext2_set_entry (struct inode *, ext2_dirent *, struct page *, struct inode *);
+extern ino_t ext2_find_inode (struct inode *, struct dentry *);
+extern int ext2_is_empty (struct inode *);
+extern ext2_dirent *ext2_parent (struct inode *, struct page **);
 
 /* file.c */
 extern struct inode_operations ext2_file_inode_operations;
--- ../uml.2.4.2.clean/include/linux/mm.h	Thu Feb 22 01:09:58 2001
+++ ./include/linux/mm.h	Thu Mar  8 23:19:57 2001
@@ -167,6 +167,7 @@
 #define PG_skip			10
 #define PG_inactive_clean	11
 #define PG_highmem		12
+#define PG_checked		13	/* kill me in 2.5.<early>. */
 				/* bits 21-29 unused */
 #define PG_arch_1		30
 #define PG_reserved		31
@@ -181,6 +182,8 @@
 #define PageLocked(page)	test_bit(PG_locked, &(page)->flags)
 #define LockPage(page)		set_bit(PG_locked, &(page)->flags)
 #define TryLockPage(page)	test_and_set_bit(PG_locked, &(page)->flags)
+#define PageChecked(page)	test_bit(PG_checked, &(page)->flags)
+#define SetPageChecked(page)	set_bit(PG_checked, &(page)->flags)
 
 extern void __set_page_dirty(struct page *);
 
--- ../uml.2.4.2.clean/mm/filemap.c	Sat Feb 17 01:06:17 2001
+++ ./mm/filemap.c	Thu Mar  8 23:17:59 2001
@@ -332,7 +332,7 @@
 	return 0;
 }
 
-static int waitfor_one_page(struct page *page)
+int waitfor_one_page(struct page *page)
 {
 	int error = 0;
 	struct buffer_head *bh, *head = page->buffers;
@@ -506,7 +506,7 @@
 	if (PageLocked(page))
 		BUG();
 
-	flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_dirty) | (1 << PG_referenced) | (1 << PG_arch_1));
+	flags = page->flags & ~((1 << PG_uptodate) | (1 << PG_error) | (1 << PG_dirty) | (1 << PG_referenced) | (1 << PG_arch_1)| (1 << PG_checked));
 	page->flags = flags | (1 << PG_locked);
 	page_cache_get(page);
 	page->index = offset;

-- 
Daniel
