Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132718AbRDIKlf>; Mon, 9 Apr 2001 06:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132717AbRDIKl0>; Mon, 9 Apr 2001 06:41:26 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:48146 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S132718AbRDIKlQ>; Mon, 9 Apr 2001 06:41:16 -0400
From: Daniel Phillips <phillips@nl.linux.org>
To: linux-kernel@vger.kernel.org
Subject: [RFC] Ext2 Directory Index - File Structure
Message-Id: <20010409104037Z92164-22358+7@humbolt.nl.linux.org>
Date: Mon, 9 Apr 2001 12:40:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the past several weeks I have been developing a directory index
facility for Ext2, with good results so far.  This note describes the
on-disk format of the new index.

The development work has reached the point where the format is nearly
ready to be frozen, so I hope that the material I have provided here is
sufficient to assess the suitability of this data design for long-term
use.  Here, I focus on the data structures themselves as opposed to
algorithms and implementation details. 

General Description
-------------------

The purpose of the directory index is to avoid time-consuming searches
through an entire directory file and instead, to determine directly
which directory block a given name should be found in, and search only
that block[1].  To this end, index blocks are added amongst the regular
directory index blocks.  Each index block contains some number of index
entries which are block number/hash key pairs.  The interpretation is
that the hash values of all names in a given directory block will be
greater or equal to the hash key of the corresponding index entry.  When
a directory grows so large that the required index entries will no
longer fit in a single filesystem block, the index blocks must
themselves be indexed, forming a tree structure.

This hash-keyed index tree is neither a hash table nor a btree, though
it has some characteristics of both.  We can say that the directory
entries are divided into hash buckets, but the number of such hash 
buckets is not fixed and their contents never need to be "rehashed" into
a larger number of buckets.  Instead new buckets are created as
required.  A bucket in this context encompasses a range of hash values,
rather than a single value.

As compared to a btree, we have a tree structure, but with constant
depth - all paths from the root to a leaf are the same length - and so
the tree never needs to be rebalanced.  The fixed depth also eliminates
the need to encode the distinction between a leaves and internal index
nodes.  I call this structure an "htree". 

Directory Index Flag
--------------------

The Ext2-specific inode flag formerly named EXT2_BTREE_FL has been
renamed as EXT2_INDEX_FL in recognition of the fact that not all
directory indexes are btrees.  All versions of Linux from 2.1.93 and
2.2.0 on recognize and clear this flag during the course of directory
operations.  This outwardly curious behavior actually shows considerable
foresight on the part of the designer (Ted Ts'o) as this is the means by
which I was able to achieve not only backward compatibility but forward
compatibility as well, in the sense that versions of Ext2 from Linux 2.0
through 2.4 are able to interpret the new indexed directories as normal
Ext2 directories, seeing the index blocks as empty directory blocks
ready to be used for new entries.  In effect, the old code will
automatically convert an indexed directory back to a normal linear
directory the first time it creates a new entry.

Needless to say, the new code no longer clears this bit but uses it as
it was intended, to flag the presence of an index on a directory.  If a
partition has been mounted with the -o index[2] option enabled then each
new directory is created with the EXT2_INDEX_FL set.  In the current
version of the code the index is created at that time, so an empty
directory has two blocks: the index root and an empty directory entry 
block.

As a planned optimization, the index will not be created at the
directory creation time, but at the time the first directory entry block
fills up and needs to be split.  This is in recognition of the fact that
the index, which has a resolution of one block, is redundant when the
directory has only one block, and in this case, the old linear lookup
code path is faster[3].

The test for presence of the directory index thus involves both the
index bit and the directory size (greater than one block)[4].  The
current code implements this test and even though it does not implement
the optimization, it is forward-compatible with a future version that   
does.

Index Node Blocks
-----------------

The zeroth block of an indexed directory is the index root.  Initially
the index has only one block.  The following blocks are normal ext2
directory entry blocks.  When the directory grows large enough to fill
all the available entries in the root index block (around 80-90,000
entries on a 4K blocksize filesystem) a second level is added to the
index tree in the form of an internal index block appended to the
directory.  As the directory expands, new index blocks are appended as
needed so that the directory consists of normal directory blocks with
index nodes interspersed every 200 blocks or so.

The index root has the following structure:

    root: [fake dirents; header; index entries...]

The "fake dirents" are normal directory entries for "." and "..".  The
rec_len of the latter is the entire remainder of the block, so that the
root index block appears to older versions of Ext2 to have only the 
two entries in it.

The structure of an internal index node is similar:

    node: [fake dirent; index entries...]

In this case the "fake dirent" is an empty entry that appears to take up
the entire block.  In fact, in both the index root and nodes, this
apparently empty space is filled with index entries.  Each index entry
is 8 bytes long, and it happens that this is the same size as an empty
directory entry:

    entry: [hash, block]

Ext2 directory entries are always rounded up to a multiple of 4 bytes in
size (to accommodate architectures on which non-aligned multibyte object
access is not allowed) so each of the directory entries in the root
block uses 12 bytes.  An additional 8 bytes in the root is used for
header information (see below).  Thus, space equivalent to 4 index
entries in the root and one entry in each internal index node is used
for other purposes.

Here are the actual structure declarations:

	struct fake_dirent
	{
		le_u32 inode;
		le_u16 rec_len;
		u8 name_len;
		u8 file_type;
	};

	struct dx_countlimit
	{
		le_u16 limit;
		le_u16 count;
	};

	struct dx_entry
	{
		le_u32 hash;
		le_u32 block;
	};

	struct dx_root
	{
		struct dx_root_info
		{
			struct fake_dirent fake1;
			char dot1[4];
			struct fake_dirent fake2;
			char dot2[4];
			u8 info_length; /* 8 */
			u8 hash_version; /* 0 */
			u8 indirect_levels
			u8 unused_flags;
			le_u32 reserved_zero;
		}
		info;
		struct dx_entry	entries[0];
	};

	struct dx_node
	{
		struct fake_dirent fake;
		struct dx_entry	entries[0];
	};


These structures and the EXT_INDEX_FL flag comprise all the on-disk data
structures used by the new directory index.  The latter two structs  
describe entire blocks.  The dx_countlimit struct is overlaid on the
hash field of the zeroth directory entry (see below).

The current version of the indexing code implements index trees that are
at most two levels deep.  This is a limitation of the current
implementation, not of the data design, which is ready to accommodate
deeper trees.  Even a two-level index tree is sufficient to handle
millions of directory entries, something that is effectively impossible 
to do with normal Ext2 due to its n**2 entry creation performance.

Though the generalization to n-level trees is not difficult, it has been
deferred in accordance with the reasonable assumption that nobody will
create an Ext2 directory large enough to require more than two levels 
for quite some time.  As a forward compatibility consideration, the
initial, two-level indexing will fail gracefully if it encounters a
directory with three or more index levels.

Index Entries
-------------

The index tree records hashes of entry names rather than the names
themselves.  The compact 32 bit hash gives the index tree a high
branching  factor - 508 for the root, 511 for each node (4K block size)
- which allows the index tree to hold tens of thousands of entries with
a single level; millions with two levels.  The fact that index entries
are of fixed size permits the use of binary search in the internal index
nodes.

The structure and interpretation of index entries is the same regardless
of whether leaf blocks or lower level index blocks are being indexed. 
In each case the hash value is a lower bound on the range of hash values
of names that could be accessed through the indexed block.  The
distinction between directory leaf blocks and internal index blocks is
made by knowing the number of levels in the tree, which is recorded in
the header of the index root block.

Block Pointers
--------------

Block pointers in index entries are relative block numbers within the
directory file.  The logical file block number was used in preference to
absolute disk block number in order to avoid the need to implement a new
Ext2 block allocation class, and to permit both forward and backward
compatibility with older Ext2 filesystems.  The end result is that every
directory index block is actually indexed twice, once by the directory
file metadata and again by the directory index nodes.  This does not
seem to be a problem in practice, as evidenced by the satisfactory
results obtained in benchmarking.  In any event, use of the page cache
should largely eliminate the slight extra overhead which now exists due
to accessing logical directory data blocks through the directory file
metadata index blocks.

The high four bits of the block pointer field are reserved for use by
a coalesce-on-delete feature which may be implemented in the future. 
The remaining 28 bits are capable of indexing up to 1TB per directory
file.  (Perhaps I should coopt 8 bits instead of 4.)

Hash Values
-----------

The least significant bit of the hash is called the "continued" bit and
is used to flag the case where two entries with the same hash are in
different blocks[5].  This leaves 31 bits for the actual hash.

It is worth pointing out here that the hash value does not index a hash
table; instead it is a hash key and its range is the entire 31 bits
available to it.  This hash function is required to produce good
distributions without help from a relatively prime table modulus.

The hash function is related to the on-disk structure definition in the
sense that the exact hash value must be known in order to correctly
interpret the index structure[6].  The exact nature of the hash function
has a noticeable effect on performance.  A poor hash function tends to
prevent directory leaf blocks from becoming more than half full and
could cause severe fragmentation of the hash space over long term use. 
This is by way of saying that the hash function has not been finalized -
while the current hash function is pretty good, it is felt that some
improvement is still possible.  The results of this investigation will
be reported in a future note.

Until the hash function is finalized, this indexing code remains
pre-alpha, useful only for testing.

However good a hash function is developed for the initial release,
someone may later discover one with compellingly superior properties.
To address this possibility the index header has a hash_version field,
initially zero, which specifies the hash function in use when the index
was created.  New hash functions can be added to the code as desired but
not removed, otherwise the ability to access a directory created with
the removed hash function would be lost. 

Up to 256 different hash functions are possible.  This may be turn out
to be 255 more than are ever actually used. :-)

Entry Count and Limit
---------------------

The hash field of the zero index entry in each index node (including the
root) holds the count and limit of entries for the block instead of a
hash value[7].  These are 16 bit quantities, which will suffice even for
large block sizes, up to 128KB.  The limit field is not strictly
necessary since the limit can be deduced from the block size but it was 
found to be more robust to compute it once at the time the index block
is created, and thereafter to use the computed value as a crosscheck on
the integrity of the index structure.

Leaf Blocks
-----------

Leaves of the directory index tree are normal Ext2 directory blocks.
Each directory leaf contains entries whose hash values lie within a
range specified by the index: greater than or equal to the hash value of
the corresponding index entry and less than the hash value of the
succeeding index entry.

Within a leaf, entries are unordered and are looked up via a normal
linear walk through the directory entries[8].  A side effect of leaf
splitting is that directory entries become temporarily ordered, but this
ordering is never relied upon and tends to dissipate quickly.

As directory entries are added, directory leaf blocks become full and are
split, and new blocks thus created are appended to the end of the
directory.  Newly split leaf blocks always start out half full.  Over 
time they will grow until they are nearly full before being split again.
Thus, directory leafs will average no more than 75% full and typically
a few points less than that since the hash function never produces a
perfectly uniform distribution.  (The better the hash function, the
closer we get to 75%; we are currently at 71%.) 

So an indexed directory will have about 30% more blocks than a
traditional Ext2 directory[9].  One might suspect that this would cost
some performance but this is not the case.  Even with the new indexing
code, directory operations still tend to be cpu bound, though much less
than they used to be.

We could avoid the slack space in the leaf blocks by indexing every
entry individually, but then the index would become far bulkier.  This
would impact performance severely while roughly negating the size
advantage. 

Planned Coalesce on Delete
--------------------------

Historically, Ext2 directories have been "grow-only"; deleting files
never shortens the directory.  The current implementation of this
indexing system continues that tradition by not carrying out any form of
coalescing of directory blocks (though as with normal Ext2, individual
directory entries within a block will be coalesced on delete). 
Unfortunately, there is a problem with this lazy strategy beyond simple
wastage of space.  As names are added to a directory, splitting of leaf
blocks causes the 31 bit hash space to become partitioned in a
particular way.  If those names are deleted, the hash space remains
partitioned as it was.  When new names are added it is possible that
they may never fall into the hash partitions vacated by the deleted
names, and so the empty space in the associated directory block may
never be reused.

As a worst case example, suppose a poor or extremely unlucky hash
function causes the first 100 names to be assigned sequential hash
numbers starting from 0 to 99.  These names are all deleted and a second
group of names is added.  Even more unluckily, the hash function happens
to generate hashes from 100 to 199.  After several million repetitions
of this cycle with similar bad luck the directory will have grown very
large and be almost entirely empty.  Furthermore, each index bucket will
contain exactly one entry. 

In practice, with a good randomly distributed hash function I do not
think we will see any problem even if we continue to ignore coalescing. 
However, in case that turns out to be incorrect I have at least thought
about how coalescing could be done efficiently and provided for forward
compatibility with a future revision that does it.

The idea is to set aside some bits in the block field of each index
entry, these bits being updated after each deletion to indicate the
approximate fullness of the corresponding block.  Then when a block
becomes less than half full (say) the index block can be consulted to
see if its neighbors are candidates for merging.

A slight drawback to this approach is the need to scan for freespace
after each delete; the practical effect of this will be small and will
be a reasonable price to pay for proper coalescing[8].  Another
consideration is increase in code side - probably 1-2K of extra code, or
2-4% of the Ext2 code size.

For forward compatibility I simply mask off the bits that would be used
for the purpose described above.  Thus, if an earlier version of the
indexing code encounters a directory that has previously been maintained
by a later version that has the coalescing feature it will simply clear
the advisory bits and be unaffected by them.  Later when the new code
maintains the directory again it may miss a few opportunities for
coalescing, but the advisory bits will quickly be back in normal
operation.

Forward Compatibility Considerations
------------------------------------

Though forward compatibility can be difficult thing to achieve, if we do
not at least try we can be certain never to obtain it.  I have made a
number of design decisions with forward compatibility in mind, in some
case with features that are already planned and are alluded to
elsewhere.

There are two kinds of forward compatibility to consider: forward
compatibility with older versions of Ext2, and forward compatibility
with versions that have not yet been created.

The first kind of forward compatibility is addressed by hiding all the
new index structures inside what appears to earlier versions of Ext2 to
be free space.  This is accomplished by placing an empty Ext2 dirent
structure at the beginning of each index node which marks the entire
block as empty, from the point of view of non-index-aware versions of
Ext2.

Additionally, directory entries for "." and ".." are placed at the
beginning of the root index node in the zeroth block of the directory,
the second of which appears to take up the entire remainder of the
block.  These forward compatibility considerations slightly reduce the
space available in index blocks, but this reduction amounts to only
about .5% of the root index block and .2% of internal index blocks with
a 4K block size (2% and .8% for 1K block size) which is acceptable given
the high degree of forward compatibility afforded.  The practical result
is to slightly reduce the threshold at which a second level of the index
tree must be created.  

The second kind of forward compatibility attempts to anticipate the
needs of code that has not been written yet, and possibly not even
designed.  For example, though I have been very miserly about allocating
space for header information in the root index block I have made the
size of the root header variable just in case.

The current code relies on the length field encoded in the root header
structure to find the beginning of the root index entry table.  Thus any
new information in an expanded root header will be ignored.  However, if
any flag is set in the unused_flags header field then the directory
operation will fail gracefully, which gives a means of flagging an
incompatible modification.  In practice the header format is unlikely
ever to change, however the cost of providing for the possibility is
small, and perhaps one day someone will appreciate this foresight as I
appreciated the foresight shown in the handling of the directory index
flags, described above.

It is quite likely that the hash function will be improved in the
future, therefore a hash function version field is included in the root
header.  If the current code sees a nonzero hash function version it
will fail the directory operation gracefully.  Thus, the worst possible
effect of adding a new hash function in the future is that old versions
of ext2 will not be able to access a directory created with the new hash
function.  (Alternatively, we could arrange a fallback to a linear
search.) 

A few other forward compatibility hooks are describe elsewhere: masking
of the block pointers in anticipation of a coalesce-on-delete feature;
including directory size in the test for index presence; and graceful
failure if an index having more than two levels is detected. 

If I've forgotten something, please let me know. :-)

Status
------

Subject to no objections to the above, I would like to declare the
on-disk format finalized, with the single exception of the hash
function, which must be considered part of the disk format.  The code
linked below has been tested up to 1,000,000 directory entries without
problems, but I would not describe that as stress testing - this needs
to be done.  If you have time, please get a copy of the patch and let me
know how things work out.  The patch is still pre-alpha so you should
limit testing to a partition reserved for the purpose.  Personally I
have encountered no difficulties running the patch on my personal
machine, but please do not construe this as a warrantee :-).  Unless you
mount a partition with the -o index option the indexed code path is not
activated and the code behaves as normal Ext2. 

To Do
-----

  - Finalize hash function
  - Test/debug big endian
  - Convert to page cache

Future Work
-----------

  - Fail gracefully on random data
  - Defer index creation until 1st block full
  - Generalize to n level index
  - Coalesce on delete

The Patch is Available At
-------------------------

    http://kernelnewbies.org/~phillips/htree/dx.testme.2.4.3

To apply:

    cd /your/kernel/source
    patch -p0 </the/patch

To create an indexed directory:

    mount /dev/hdxxx /test -o index
    mkdir /test/foo

Please download and test.

[1] The index tree could have been made finer-grained than one block,
but not without sacrificing the desireable property of forward
compatibility with older Linux versions (because the directory block
format would have had to have been changed) and it is not clear that a
finer-grained index would perform better.

[2] It is possible that at some point the -o index option will become
the default; a -o noindex option will be provided as an override.

[3] As soon as a directory grows past one block the indexed lookup is
faster than the linear lookup in most contexts.  This is due to the
number of directory entries in each block being cut in half by the split
operation, shortening the search time and more than compensating for the
fact that two blocks will always be accessed by the indexed lookup vs an
average of just more that one for the linear lookup.  Since all blocks
involved tend to be cached it is cpu time that dominates, not disk
accesses.

[4] The test for directory size could be eliminated if we are willing to
accept that indexing be used on all new directories.  In that case the
index flag would be set on any directory larger than a block.  A
decision was made to err on the side of more control by the
administrator, who can now be offered the option of specifying which 
directories should be indexed and which not.

[5] One nice detail that is sure to be overlooked if I don't point it
out is the way that the continuation bit in the low-order bit of the
hash field constitutes a sort of "hash.5" value, so that the index
probing code, for example, does not need to know anything about the
details of hash bucket continuation.

[6] A hash function that returns the constant zero effectively gives us
the old linear search behavior; this fact is useful for testing corner
cases in the index code.

[7] Using the zeroth hash value for the entries count is a slightly
questionable thing that I did because I enjoyed the feeling of having no
slack space left in the block.  I suspected that in normal operation
this hash field would never need to be accessed anyway, and that turned
out to be true.  The only slight code complexity resulting from this
hack is in the debug output functions, normally not compiled in a 
production system. 

[8] At some point I intend to investigate the possible benefits of a
redesigned, incompatible directory block format.  This would include
such improvements as maintaining the directory entries in a structure
more suitable for fast insertion and deletion, and keeping a freespace
count within the block.

[9] One can imagine a directory-compacting utility but in practice it
would probably be seldom used and not worth the effort, a possible
exception being embedded applications.  Even in that case, what we
probably want is a compressed filesystem.

--
Daniel
