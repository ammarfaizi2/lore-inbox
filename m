Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280727AbRKGChZ>; Tue, 6 Nov 2001 21:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280738AbRKGChR>; Tue, 6 Nov 2001 21:37:17 -0500
Received: from tully.CS.Berkeley.EDU ([128.32.46.229]:62873 "EHLO
	tully.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S280727AbRKGChH>; Tue, 6 Nov 2001 21:37:07 -0500
Message-ID: <20011106183435.13939@tully.CS.Berkeley.EDU>
Date: Tue, 6 Nov 2001 18:34:35 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Reiser4 Transaction Design Document
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.89.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We are pleased to make the design document for transactions in
Reiser4 public.  This is directed to file system developers and
anyone with an interest in improved atomicity primitives for 
file system applications with serious consistency requirements.


		 Reiser4 Transaction Design Document

			     Nov. 7, 2001

			   Joshua MacDonald
			     Hans Reiser


			  EXECUTIVE SUMMARY


A "transcrash" is a set of operations, of which all or none must
survive a crash.  A "particle" is the minimum amount of data whose
modification will be individually tracked, which can be larger than
the unit of modification itself.  An "atom" is the collection of
particles a transcrash has attempted to modify, plus all particles
that are part of atoms that have "fused" with this atom.  Two atoms
fuse when one transcrash attempts to modify particles that are part of
another atom.

In traditional Unix semantics, a sequence of write() system calls are
not expected to be atomic, meaning that an in-progress write could be
interrupted by a crash and leave part new, part old data behind.
Writes are not even guaranteed to be ordered in the traditional
semantics, meaning that newer data could survive a crash while older
data does not.  File systems with atomic writes are called
"data-journaling".  The straight-forward way to add data-journaling to
a file system is to log the contents of every modified block before
overwriting its real location.  This technique doubles the amount of
data written to the disk, which is significant when disk transfer rate
is the limiting performance factor.

Something more clever is possible.  Instead of writing every modified
block twice, we can write the block once to a new location and then
update the pointer in its parent.  However, the parent modification
must be included in the transaction too.  The WAFL (Write Anywhere
File Layout) technique [Hitz94] handles this by propagating file
modifications all the way to the root node, which is then updated
atomically.  In Reiser4 whether we log and overwrite, or relocate,
depends on what the block allocation plugin determines is optimal for
the blocks in question based on the current layout.


		       DEFINITION OF ATOMICITY


Most file systems perform write caching, meaning that modified data
are not immediately written to the disk.  Writes are deferred for a
period of time, which allows the system greater control over disk
scheduling.  A system crash can happen at any time, and some recent
modifications will be lost.  This can be a serious problem if an
application has made several interdependent modifications, some of
which are lost while others are not.  Such an application is said to
require atomicity--a guarantee that all or none of a sequence of
interdependent operations will survive a crash.  Without atomicity, a
system crash can leave the file system in an inconsistent state.

Dependent modifications may also arise when an application reads
modified data and then produces further output.  Consider the
following sequence of events:

1  Process P_a writes file F_a
2  Process P_b reads file F_a
3  Process P_b writes file F_b

At this point, the file F_b might be dependent on F_a.  If the
write-caching strategy allows F_b to be written before a F_a and a
crash occurs, the file system may again be left in an inconsistent
state.

Our definition of atomicity is based on the notion of a "sphere of
influence" which encompasses a set of modifications that must commit
atomically.  In our implementation, an atom maintains a sphere of
influence.  We offer transcrashes with two degrees of fusion,
"explicit dependence" and "assumed dependence".  A transcrash with
explicit dependence is allowed to read the modified data of other
atoms without causing the atoms to fuse except when it explicitly
specifies that a particular read is a dependent read.  A transcrash
with assumed dependence causes atoms to fuse whenever there might be a
dependency, whether it is real or not.

There are several rules the atom uses to maintain its sphere of
influence.  In the statements that follow, a "non-dependent read" is a
read performed by an explicit dependence transcrash that does not
explicitly specify read dependence.  A "dependent read" is any other
read (i.e., assumed or explicit).

- Initially a transcrash is not bound to any atom.

- An transcrash is bound to an atom whenever it makes a dependent read
  of modified data.

- Any read of clean, committed data does not add that data to the
  atom.

- A non-dependent read of modified data does not add that data to the
  atom.

- An unbound transcrash that writes data belonging to another atom is
  bound to that atom.

- An unbound transcrash that writes data not belonging to another atom
  is bound to a newly created atom containing that data.

- A transcrash bound to an atom that writes data not belonging to any
  atom adds that data to its own atom.

- When a transcrash bound to an atom writes to. or performs a dependent
  read of, data belonging to another atom, its atom is fused with the
  other atom.

Persons familiar with the database literature will note that these
definitions do not imply "isolation" or "serializability" between
processes.  Isolation requires the ability to undo a sequence of
operations when lock conflicts cause a deadlock to occur.

Rollback is the ability to abort and undo the effects of the
operations in an uncommitted transcrash.  Transcrashes do not provide
isolation, which is needed to support separate rollback of separate
transcrashes.  However, our architecture is designed to support
separate, concurrent atoms so that it can be expanded to implement
isolated transcrashes in the future.

Currently, the only reason a transcrash will be aborted is due to a
system crash.  The system cannot individually abort a transcrash, and
this means that transcrashes are only made available to trusted
plugins inside the kernel.  Once we have implemented isolation it will
be possible for untrusted applications to access the transcrash
interface for creating (only) isolated transcrashes.


		 STAGE ONE: "Capturing" and "Fusing"


The initial stage starts when an atom "begins".  The beginning of an
atom is controlled by the transaction manager itself, but the event is
always triggered when a transcrash requests to "capture" a block.
The transcrash requests to capture a block with a mode flag stating its
intention to read or write that block.  For a write-capture request,
the outcome ensures that the block and transcrash belong to the same
atom (i.e., the same sphere of influence).

Note that a write-captured block is not automatically modified
(labeled "dirty"), and in this sense it can be considered an
"intention lock" because it grants the right but not the obligation to
modify that block.  A system without isolation support has no need for
the separation between capturing and modification, but when isolation
is added the ability to declare write intentions is an important way
to prevent deadlock in read-modify-write cycles.  At present, however,
we will only consider the possibility that captured blocks are not
necessarily modified.

Each atom maintains a list of its currently captured blocks and
assigned transcrashes.  When fusion occurs, the smaller of the two
atoms is chosen to have its members reassigned.  Atoms in stage one
continue in this state, capturing blocks as requests are issued and
fusing whenever a transcrash reads or writes blocks assigned to
another atom.

A transaction preserves the previous contents of all modified blocks
in their original location on disk.  The dirty blocks of an atom
(which were captured and subsequently modified) are divided into two
sets, "relocate" and "overwrite", each of which is preserved in a
different manner.

- The "relocate" set may contain blocks that have a dirty parent block
  in the atom, subject to a policy decision.  These blocks are written
  to a new location.  By writing the relocate set to different
  locations we avoid writing a second copy of each block to the log.
  When the current location of a block is its optimal location,
  relocation is a possible cause of file system fragmentation.  We
  discuss relocation policies in a later section.

- The "overwrite" set contains all dirty blocks not in the relocate
  set (i.e., those which do not have a dirty parent and those for
  which overwrite is the better policy).  A "wandered" copy of each
  overwrite block is written as part of the log before the atom
  commits and a second write replaces the original contents after the
  atom commits.  Note that the superblock is the parent of the root
  node and the free space bitmap blocks have no parent.  By these
  definitions, the superblock and modified bitmap blocks are always
  part of the overwrite set.

  (An alternative definition is the "minimum overwrite" set which uses
  the same definition as above with the following modification.  If at
  least three dirty blocks have a common parent that is clean then its
  parent is added to the minimum overwrite set.  The parent's dirty
  children are removed from the overwrite set and placed in the
  relocate set.  This optimization will be saved for a later version.)

The system responds to memory pressure by selecting dirty blocks to be
flushed.  When dirty blocks are written during stage one it is called
"early flushing" because the atom remains uncommitted.  When early
flushing is needed we only select blocks from the relocate set because
their buffers can be released, whereas the overwrite set remain pinned
in memory until after the atom commits.

We must enforce that atoms make progress so they can eventually
commit.  An atom can only commit when it has no open transcrashes, but
allowing atoms to fuse allows open transcrashes to join an existing
atom which may be trying to commit.

For this reason, an age is associated with each atom and when an atom
reaches expiration it begins actively flushing to disk.  An expired
atom takes steps to avoid new transcrashes prolonging its lifetime:
(1) an expired atom will not accept any new transcrashes and (2)
non-expired atoms will block rather than fuse with another expired
atom.  An expired atom is still allowed to fuse with any other
stage-one atom.

Once an expired atom has no open transcrashes it is ready to close,
meaning that it is ready to begin commit processing.  All repacking,
balancing, and allocation tasks have been performed by this point.

Applications that are required to wait for synchronous commit (e.g.,
using fsync()) may have to wait for a lot of unrelated blocks to flush
since a large atom may be have captured the bitmaps.  To address this,
we will provide an interface for "lazy transcrash commit" that closes
a transcrash and waits for it to commit.  On the other hand, an
application that would like to synchronize its data as early as
possible would perhaps benefit from logical logging, which is not
currently supported by our architecture, or NVRAM.

To finish stage one we have:

- The in-memory free space bitmaps have been updated such that the new
  relocate block locations are now allocated.

- The old locations of the relocate set, and any blocks deleted by
  this atom, are not immediately deallocated as they cannot be reused
  until this atom commits.  We must maintain two bitmaps: (1) one is
  logged to disk as part of the overwrite set prior to commit, and (2)
  one that is the working in-memory copy.  The in-memory bitmaps do
  not have old locations of the relocate set and deleted blocks
  deallocated until after commit.

  Each atom collects a data structure representing its "deallocate
  set", the blocks it must deallocate once it commits.  The deallocate
  set can be represented in a number of ways, as a list of block
  locations, a set of bitmaps, or using extent-compression.  We expect
  to use a bitmap representation in our first implementation.
  Regardless of the representation, the deallocate set data structure
  is included in the commit record of this atom where it will be used
  during crash recovery.  The deallocate set is also used after the
  atom commits to update the in-memory bitmaps.

- Wandered locations are allocated for the overwrite set and a list of
  the association between wandered and real overwrite block locations
  for this atom is included in the commit record.

- The final commit record is formatted now, although it is not needed
  until stage three.


		    STAGE TWO: "Completing writes"


At this stage we begin to write the remaining dirty blocks of the
atom.  Any blocks that were write-captured and never modified can be
released immediately, since they do not take part in the commit
operation.  To "release" a block means to allow another atom to
capture it freely.  Relocate blocks and overwrite blocks are treated
separately at this point.

RELOCATE BLOCKS

A relocate block can be released once it has been flushed to disk.
All relocate blocks that were early-flushed in stage one are
considered clean at this point, so they are released immediately.

The remaining non-flushed relocate blocks are written at this point.
Now we consider what happens if another atom requests to capture the
block while the write request is being serviced.

A read-capture request is granted just as if the block did not belong
to any atom at this point--it is considered clean despite belonging to
a not-yet-committed atom.  The only requirement on this interaction is
that no atom can "jump ahead" in the commit ordering.  Atoms must
commit in the order that they reach stage two or else read-capture
from a non-committed atom must explicitly construct and maintain this
dependency.

A write-capture request can be granted by copying the block.  This
introduces the first major optimization called "copy-on-capture".  The
capturing process assumes control of the block, and the committing
atom retains an anonymous copy.  When the write request completes, the
anonymous copy is released (freed).  Copy-on-capture is an
optimization not performed in ReiserFS version 3 (which creates a copy
of each dirty page at commit), but in that version the optimization is
less important because the copying does not apply to unformatted
nodes.

If a relocate block-write finishes before the block is captured it is
released without further processing.  Despite releasing relocate
blocks in stage two, the atom still requires a list of old relocate
block locations for deallocation purposes.


OVERWRITE BLOCKS

The overwrite blocks (including modified bitmaps and the superblock)
are written at this point to their wandered locations as part of the
log.  Unlike relocate blocks, overwrite blocks are still needed after
these writes complete as they must also be written back to their real
location.

Similar to relocate blocks, a read-capture request is granted as if
the block did not belong to any atom.

A write-capture request is granted by copying the block using the
copy-on-capture method described above.

ISSUES

One issue with the copy-on-capture approach is that it does not
address the use of memory-mapped files, which can have their contents
modified at any point by a process.  One answer to this is to exclude
mmap() writers from any atomicity guarantees.  A second alternative is
to use hardware-level copy-on-write protection.  A third alternative
is to unmap the mapped blocks and allow ordinary page faults to
capture them back again.


			STAGE THREE: "Commit"


When all of the outstanding stage two disk writes have completed, the
atom reaches stage three, at which time it finally commits by writing
its commit record to the log.  Once this record reaches the disk,
crash recovery will replay the transaction.


		STAGE FOUR: "Post-commit disk writes"


The fourth stage begins when the commit record has been forced to the
log.

OVERWRITE BLOCK WRITES

Overwrite blocks need to be written to their real locations at this
point, but there is also an ordering constraint.  If a number of atoms
commit in sequence that involve the same overwrite blocks, they must
be sure to overwrite them in the proper order.  This requires
synchronization for atoms that have reached stage four and are writing
overwrite blocks back to their real locations.  This also suggests the
second major optimization potential which is labeled steal-on-capture.

The steal-on-capture optimization is an extension of the
copy-on-capture optimization that applies only to the overwrite set.
The idea is that only the last transaction to modify an overwrite
block actually needs to write that block.  This optimization, which is
also present in ReiserFS version 3, means that frequently modified
overwrite blocks will be written less than two times per transaction.

With this optimization a frequently modified overwrite block may avoid
being overwritten by a series of atoms; as a result crash recovery
must replay more atoms than without the optimization.  If an atom has
overwrite blocks stolen, the atom must be replayed during crash
recovery until every stealing-atom commits.

When an overwrite block-write finishes the block is released without
further processing.

DEALLOCATE SET PROCESSING

The deallocate set can be deallocated in the in-memory bitmap blocks
at this point.  The bitmap modifications are not considered part of
this atom (since it has committed).  Instead, the deallocations are
performed in the context of a different stage-one atom (or atoms).  We
call this process "repossession", whereby a stage-one atom assumes
responsibility for committing bitmap modifications on behalf of
another atom in time.

For each bitmap block with pending deallocations in this stage, a
separate stage-one atom may be chosen to repossess and deallocate
blocks in that bitmap.  This avoids the need to fuse atoms as a result
of deallocation.  A stage-one atom that has already captured a
particular bitmap block will repossess for that block, otherwise a new
atom can be selected.

For crash recovery purposes, each atom must maintain a list of atoms
for which it repossesses bitmap blocks.  This "repossesses for" list
is included in the commit record for each atom.  The issue of crash
recovery and deallocation will be treated in the next section.


		   STAGE FIVE: "Commit completion"


When all of the outstanding stage four disk writes are complete and
all of the atoms that stole from this atom commit, the atom no longer
needs to be replayed during crash recovery--the overwrite set is
either completely written or will be completely written by replaying
later atoms.  Before the log space occupied by this atom can be
reclaimed, however, another topic must be discussed.

WANDERED OVERWRITE BLOCK ALLOCATION

Overwrite blocks were written to wandered locations during stage two.
Wandered block locations are considered part of the log in most
respects--they are only needed for crash recovery of an atom that
completes stage three but does not complete stage five.  In the
simplest approach, wandered blocks are not allocated or deallocated in
the ordinary sense, instead they are appended to a cyclical log area.
There are some problems with this approach, especially when
considering LVM configurations: (1) the overwrite set can be a
bottleneck because it is entirely written to the same region of the
logical disk and (2) it places limits on the size of the overwrite
set.

For these reasons, we allow wandered blocks to be written anywhere in
the disk, and as a consequence we allocate wandered blocks in stage
one similarly to the relocate set.  For maximum performance, the
wandered set should be written using a sequential write.  To achieve
sequential writes in the common case, we allow the system to be
configured with an optional number of areas specially reserved for
wandered block allocation.  In an LVM configuration, for example,
reserved wandered block areas can be spread throughout the logical
disk space to avoid any single disk being a bottleneck for the
wandered set.

Wandered block locations still need to be deallocated with this
approach, but we must prevent replay of the atom's overwrites before
these blocks can be deallocated.  At this point (stage five), a log
record is written signifying that the atom should not have overwrites
be replayed.


	 STAGE SIX: "Deallocating wandered blocks"


Once the do-not-replay-overwrites record for this atom has been forced
to the log, the wandered block locations are deallocated using
repossession, the same process used for the deallocate set.

At this point, a number of atoms may have repossessed bitmap blocks on
behalf of this atom, for both the deallocate set and the wandered set.
This atom must wait for all of those atoms to commit (i.e., reach
stage four) before the log can wrap around and destroy this atom's
commit record.  Until such point, the atom is still needed during
crash recovery because its deallocations may be incomplete.

This completes the life of an atom.  Now we must discuss how the
recovery algorithm handles deallocation in case of a crash.


		       CRASH RECOVERY ALGORITHM


Some atoms may not be completely processed at the time of a crash.
The crash recovery algorithm is responsible for determining what steps
must be taken to make the file system consistent again.  This includes
making sure that: (1) all overwrites are complete and (2) all blocks
have been deallocated.

We avoid discussing potential optimizations of the algorithm at
present, to reduce complexity.  Assume that after a crash occurs, the
recovery manager has a way to detect the active log "fragment", which
contains the relevant set of log records that must be reprocessed.
Also assume that each step can be performed using separate forward
and/or reverse passes through the log.  Later on we may choose to
optimize these points.

Overwrite set processing is relatively simple.  Every atom with a
commit record found in the active log fragment, but without a
corresponding do-not-replay record, has its overwrite set copied from
wandered to real block locations.  Overwrite recovery processing
should be complete before of deallocation processing begins.

Deallocation processing must deal separately with deallocation of the
deallocate set (from stage four--deleted blocks and the old relocate
set) and the wandered set (from stage six).  The procedure is the same
in each case, but since each atom performs two deallocation steps the
recovery algorithm must treat them separately as well.

The deallocation of an atom may be found in three possible states
depending on whether none, some, or all of the deallocate blocks were
repossessed and later committed.  For each bitmap that would be
modified by an atom's deallocation, the recovery algorithm must
determine whether a repossessing atom later commits the same bitmap
block.

For each atom with a commit record in the active log fragment, the
recovery algorithm determines: (1) which bitmap blocks are committed
as part of its overwrite set and (2) which bitmap blocks are affected
by its deallocation.  For every committed atom that repossesses for
another atom, the committed bitmap blocks are subtracted from the
deallocate-affected bitmap blocks of the repossessed-for atom.  After
performing this computation, we know the set of deallocate-affected
blocks that were not committed by any repossessing atoms; these
deallocations are then reapplied to the on-disk bitmap blocks.  This
completes the crash recovery algorithm.


		     RELOCATION AND FRAGMENTATION


As previously discussed, the choice of which blocks to relocate
(instead of overwrite) is a policy decision and, as such, not directly
related to transaction management.  However, this issue affects
fragmentation in the file system and therefore influences performance
of the transaction system in general.  The basic tradeoff here is
between optimizing read and write performance.

The relocate policy optimizes write performance because it allows the
system to write blocks without costly seeks whenever possible.  This
can adversely affect read performance, since blocks that were once
adjacent may become scattered throughout the disk.

The overwrite policy optimizes read performance because it attempts to
maintain on-disk locality by preserving the location of existing
blocks.  This comes at the cost of write performance, since each block
must be written twice per transaction.

Since system and application workloads vary, we will support several
relocation policies:

- Always Relocate: This policy includes a block in the relocate set
  whenever it will reduce the number of blocks written to the disk.

- Never Relocate: This policy disables relocation.  Blocks are always
  written to their original location using overwrite logging.

- Left Neighbor: This policy puts the block in the nearest available
  location to its left neighbor in the tree ordering.  If that
  location is occupied by some member of the atom being written it
  makes it a member of the overwrite set, otherwise the policy makes
  the block a member of the relocate set.  This policy is simple to
  code, effective in the absence of a repacker, and will integrate
  well with an online repacker once that is coded.  It will be the
  default policy initially.

  Much more complex optimizations are possible, but deferred for a
  later release.

Unlike WAFL, we expect the use of a repacker to play an important
role.


			 META-DATA JOURNALING


Meta-data journaling is a restricted operating mode in which only file
system meta-data are subject to atomicity constraints.  In meta-data
journaling mode, file data blocks (unformatted nodes) are not captured
and therefore need not be flushed as the result of transaction commit.
In this case, file data blocks are not considered members of the
either relocate or the overwrite set because they do not participate
in the atomic update protocol--memory pressure and age are the only
factors that cause unformatted nodes to be written to disk in the
meta-data journaling mode.


			      REFERENCES


[Hitz94] Dave Hitz, James Lau, and Michael Malcolm, "File System
	 Design for an NFS File Server Appliance", Proceedings of the
	 Winter 1994 USENIX Conference, San Francisco, CA, January
	 1994, 235-246.



----------------------------------------------------------------------

P.S. I am posting this just as I am boarding a plane home from Moscow,
so it will be a little while before I can respond to any of your 
feedback. 

Thanks,

Josh

--
http://sourceforge.net/projects/prcs     PRCS version control system
http://sourceforge.net/projects/xdelta   Xdelta transport & storage
http://sourceforge.net/projects/skiplist Need a concurrent skip list?
