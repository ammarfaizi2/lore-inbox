Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312556AbSCVOaZ>; Fri, 22 Mar 2002 09:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSCVOaS>; Fri, 22 Mar 2002 09:30:18 -0500
Received: from compsurg01.demon.co.uk ([158.152.83.11]:8702 "EHLO
	zuse.computer-surgery.co.uk") by vger.kernel.org with ESMTP
	id <S312540AbSCVO3u>; Fri, 22 Mar 2002 09:29:50 -0500
Date: Fri, 22 Mar 2002 14:34:45 +0000
To: akpm@zip.com.au, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, davej@suse.de, alan@lxorguk.ukuu.org.uk
Subject: Some JBD documenation
Message-ID: <20020322143444.A671@zuse.computer-surgery.co.uk>
Reply-To: roger@computer-surgery.co.uk
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Roger Gammans <roger@zuse.computer-surgery.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

I've included a new file of documentation on the journalling layer
I work on over xmas, and has been gathering dust in my home
directory.

This file is a first cut and is prolly got technical errors ,
so corrections would be greatly appreciated.

I've put it into Bk here, but didn't want to send a bk patch
unless I knew it was going to ok, since I note SubmitingPatches
hasn't been updated since Linus took bk on.

TTFN

    { the cc list is intented to be small stuff and ext3 people }
-- 
Roger.
Master of Peng Shui.  (Ancient oriental art of Penguin Arranging)

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="jbd-api.txt"

		     Journalling Subsystem API Reference
		     
                             Overview and Editting
			               by 
         	R G Gammmans  <rgammans@compuer-surgery.co.uk>
                 
		           Material from the sources 
	                               by
		     (C) Stephen C. Tweedie <sct@redhat.com>


Overview
========
The journalling layer is pretty ease to use. You need to 
first of all create a journal_t data-structure, there are
two calls to do this dependent on how use allocate the physical
media on which the journal resides.

Once you have done this you need to the appropriate call to load/
recover etc, the physical journal.

Once this is done you can go ahead and start modifying the underlying 
filesystem. Almost.

You wanted journalling right?, so before you actually modify any
blocks (actually buffers), you need a transaction (handle_t) to
group all your modifications into, and to inform the journal about
the type of changes you are about to make to each block. These are all
described under the transaction level functions. Once you have
told the journal layer about your intents you are free to go about
and modify buffer->b_data, and the block layer will take care of
writing it to disk for you at the end of the transaction 
You indicate this to the journal layer by calling
journal_stop(myHandle). Calls to journal_{start,stop} are nestable,
nothing commits to disk until you leave the outermost pair.

A journal_flush() may be called at any time to commit and checkpoint
all your transactions.
[is this right? - outside a transaction presumably? ]

Then at umount time (eg. in your put_super() ) you can call 
journal_destroy() to clean up your in core journal object.

Unfortunately this is not quite all there is to it, we need to aviod 
deadlocks. The first thing to note is that each task can only have
a single outstanding transaction at any one time, remember nothing
commits until the outermost journal_stop(). This means
you must complete the transaction at the end of each file/inode/address
etc. operation you perform, so that the journalling system isn't re-entered
on another journal. Since tranasctions can't be nested/batched 
across differing journals, and another filesystem other than
yours (say ext3) may be modified in a later syscall.

The second case to bear in mind is that journal_start() can 
block if there isn't enough space in the journal for your tranasction 
(based on the passed nblocks param) - when it blocks it merely(!) needs to
wait for transactions to complete and be commited from other tasks, 
so essentially we are waiting for journal_stop(). The practial
upshot of this is you must treat journal_start/stop() as if they
were semaphores and include them in your semaphore ordering rules to prevent 
deadlocks. Note that journal_extend() has similiar blocking behaviour to
journal_start() so you can deadlock here just as easily as on journal_start().

Try to reserve the right number of blocks the first time. ;-).

Another wriggle to watch out for is your on-disk block allocation strategy.
why? Because, if you undo a delete, you need to ensure you haven't reused any
of the freed blocks in a later transaction. One simple of of doing this
is make sure any blocks you allocate only have checkpointed transactions
list against them. Ext3 does this in ext3_test_allocatable(). 

This is also important as the 


FIXME:       Talk about undo_access / Transaction ordering

Datatypes
=========
handle_t
--------
The handle_t type represents a single atomic update being performed
by some process.  All filesystem modifications made by the process go
through this handle.  Recursive operations (such as quota operations)
are gathered into a single update.

The buffer credits field is used to account for journaled buffers
being modified by the running process.  To ensure that there is
enough log space for all outstanding operations, we need to limit the
number of outstanding buffers possible at any time.  When the
operation completes, any buffer credits not used are credited back to
the transaction, so that at all times we know how many buffers the
outstanding updates on a transaction might possibly touch. 


journal_t
---------
The journal_t maintains all of the journaling state information for a
single filesystem.  It is linked to from the fs superblock structure.
 
We use the journal_t to keep track of all outstanding transaction
activity on the filesystem, and to manage the state of the log
writing process.

Functions
=========

JOURNAL LEVEL
-------------

journal_t * journal_init_dev(kdev_t dev, kdev_t fs_dev, int start, int len, int bsize);
journal_t * journal_init_inode (struct inode *)
------------------------------------------------
Create a journal structure assigned some fixed set of disk blocks to
the journal.  We don't actually touch those disk blocks yet, but we
need to set up all of the mapping information to tell the journaling
system where the journal blocks are.

journal_init_dev creates a journal which maps a fixed contiguous
range of blocks on an arbitrary block device.

journal_init_inode creates a journal which maps an on-disk inode as
the journal.  The inode must exist already, must support bmap() and
must have all data blocks preallocated.


int journal_flush (journal_t *)
------------------------------------
Flush all data for a given journal to disk and empty the journal.
Filesystems can use this when remounting readonly to ensure that
recovery does not need to happen on remount.

void journal_lock_updates (journal_t *)
---------------------------------------
Barrier operation: establish a transaction barrier. 

This locks out any further updates from being started, and blocks
until all existing updates have completed, returning only once the
journal is in a quiescent state with no updates running.

The journal lock should not be held on entry.

void journal_unlock_updates (journal_t *)
-----------------------------------------
Release a transaction barrier obtained with journal_lock_updates().

Should be called without the journal lock held.

int journal_update_format (journal_t *)
---------------------------------------
Given an initialised but unloaded journal struct, poke about in the
on-disk structure to update it to the most recent supported version.

int journal_check_used_features (journal_t *, unsigned long, unsigned long, unsigned long);
----------------------------------------------------------------------------------------------
Check whether the journal uses all of a given set of
features.  Return true (non-zero) if it does.

int journal_check_available_features(journal_t *, unsigned long, unsigned long, unsigned long)
----------------------------------------------------------------------------------------------
Check whether the journaling code supports the use of
all of a given set of features on this journal.  Return true
(non-zero) if it can.

int journal_set_features (journal_t *, unsigned long, unsigned long, unsigned long)
-----------------------------------------------------------------------------------
Mark a given journal feature as present on the
superblock.  Returns true if the requested features could be set

int journal_create(journal_t *)
-------------------------------
Given a journal_t structure which tells us which disk blocks we can
use, create a new journal superblock and initialise all of the
journal fields from scratch.

int journal_load(journal_t *journal)
------------------------------------
Given a journal_t structure which tells us which disk blocks contain
journal, read the journal from disk to initialise the in-memory
structures

void journal_destroy(journal_t *)
---------------------------------
Release a journal_t structure once it is no longer in use by the
journaled object.

int  journal_recover(journal_t *journal)
--------------------------------------------
The primary function for recovering the log contents when mounting a
journaled device.  

Recovery is done in three passes.  In the first pass, we look for the
end of the log.  In the second, we assemble the list of revoke
blocks.  In the third and final pass, we replay any un-revoked blocks
in the log.  

int journal_wipe(journal_t *, int)
----------------------------------
Wipe out all of the contents of a journal, safely.  This will produce
a warning if the journal contains any valid recovery information.
Must be called between journal_init_*() and journal_load().

If (write) is non-zero, then we wipe out the journal on disk; otherwise
we merely suppress recovery.

int journal_skip_recovery (journal_t *)
---------------------------------------
Locate any valid recovery information from the journal and set up the
journal structures in memory to ignore it (presumably because the
caller has evidence that it is out of date).  

We perform one pass over the journal to allow us to tell the user how
much recovery information is being erased, and to let us initialise
the journal transaction sequence numbers to the next unused ID.

void journal_update_superblock (journal_t *, int)
-------------------------------------------------
Update a journal's dynamic superblock fields and write it to disk,
optionally waiting for the IO to complete.

void journal_abort(journal_t *, int)
------------------------------------
Perform a complete, immediate shutdown of the ENTIRE
journal (not of a single transaction).  This operation cannot be
undone without closing and reopening the journal.

The journal_abort function is intended to support higher level error
recovery mechanisms such as the ext2/ext3 remount-readonly error
mode.

Journal abort has very specific semantics.  Any existing dirty,
unjournaled buffers in the main filesystem will still be written to
disk by bdflush, but the journaling mechanism will be suspended
immediately and no further transaction commits will be honoured.

Any dirty, journaled buffers will be written back to disk without
hitting the journal.  Atomicity cannot be guaranteed on an aborted
filesystem, but we _do_ attempt to leave as much data as possible
behind for fsck to use for cleanup.

Any attempt to get a new transaction handle on a journal which is in
ABORT state will just result in an -EROFS error return.  A
journal_stop on an existing handle will return -EIO if we have
entered abort state during the update.

Recursive transactions are not disturbed by journal abort until the
final journal_stop, which will receive the -EIO error.

Finally, the journal_abort call allows the caller to supply an errno
which will be recored (if possible) in the journal superblock.  This
allows a client to record failure conditions in the middle of a
transaction without having to complete the transaction to record the
failure to disk.  ext3_error, for example, now uses this
functionality.

Errors which originate from within the journaling layer will NOT
supply an errno; a null errno implies that absolutely no further
writes are done to the journal (unless there are any already in
progress).


TRANSACTION LEVEL
-----------------

handle_t *journal_start(journal_t *, int nblocks)
-------------------------------------------------
Obtain a new handle.  

We make sure that the transaction can guarantee at least nblocks of
modified buffers in the log.  We block until the log can guarantee
that much space.  

This function is visible to journal users (like ext2fs), so is not
called with the journal already locked.

Return a pointer to a newly allocated handle, or NULL on failure.


handle_t *journal_try_start(journal_t *, int nblocks)
-----------------------------------------------------
Try to start a handle, but non-blockingly.  If we weren't able
to, return an ERR_PTR value.

int journal_restart (handle_t *, int nblocks)
--------------------------------------------
Restarts a handle for a multi-transaction filesystem operation.

If the journal_extend() call above fails to grant new buffer credits
to a running handle, a call to journal_restart will commit the
handle's transaction so far and reattach the handle to a new
transaction capable of guaranteeing the requested number of
credits.

int journal_extend (handle_t *, int nblocks)
--------------------------------------------
Extends buffer credits.

Some transactions, such as large extends and truncates, can be done
atomically all at once or in several stages.  The operation requests
a credit for a number of buffer modifications in advance, but can
extend its credit if it needs more.  

journal_extend tries to give the running handle more buffer credits.
It does not guarantee that allocation: this is a best-effort only.
The calling process MUST be able to deal cleanly with a failure to
extend here.

Return 0 on success, non-zero on failure.
 
return code < 0 implies an error
return code > 0 implies normal transaction-full status.


int journal_get_write_access (handle_t *, struct buffer_head *)
---------------------------------------------------------------
Notify intent to modify a buffer for metadata (not data) update.
 
If the buffer is already part of the current transaction, then there
is nothing we need to do.  If it is already part of a prior
transaction which we are still committing to disk, then we need to
make sure that we do not overwrite the old copy: we do copy-out to
preserve the copy going to disk.  We also account the buffer against
the handle's metadata buffer credits (unless the buffer is already
part of the transaction, that is).

Returns an error code or 0 on success.

In full data journalling mode the buffer may be of type BJ_AsyncData,
because we're write()ing a buffer which is also part of a shared mapping.

int journal_get_create_access (handle_t *, struct buffer_head *)
----------------------------------------------------------------
When the user wants to journal a newly created buffer_head
(ie. getblk() returned a new buffer and we are going to populate it
manually rather than reading off disk), then we need to keep the
buffer_head locked until it has been completely filled with new
data.  In this case, we should be able to make the assertion that
the bh is not already part of an existing transaction.  

The buffer should already be locked by the caller by this point.
There is no lock ranking violation: it was a newly created,
unlocked buffer beforehand.

int journal_get_undo_access (handle_t *, struct buffer_head *)
--------------------------------------------------------------
Notify intent to modify metadata with non-rewindable consequences

Sometimes there is a need to distinguish between metadata which has
been committed to disk and that which has not.  The ext3fs code uses
this for freeing and allocating space: we have to make sure that we
do not reuse freed space until the deallocation has been committed,
since if we overwrote that space we would make the delete
un-rewindable in case of a crash.

To deal with that, journal_get_undo_access requests write access to a
buffer for parts of non-rewindable operations such as delete
operations on the bitmaps.  The journaling code must keep a copy of
the buffer's contents prior to the undo_access call until such time
as we know that the buffer has definitely been committed to disk.

We never need to know which transaction the committed data is part
of: buffers touched here are guaranteed to be dirtied later and so
will be committed to a new transaction in due course, at which point
we can discard the old committed data pointer.

Returns error number or 0 on success.  

int journal_dirty_data (handle_t *, struct buffer_head *, int async)
--------------------------------------------------------------------
Marks a buffer as containing dirty data which
needs to be flushed before we can commit the current transaction.  

The buffer is placed on the transaction's data list and is marked as
belonging to the transaction.

If `async' is set then the writeback will be initiated by the caller
using submit_bh -> end_buffer_io_async.  We put the buffer onto
t_async_datalist.
 
Returns error number or 0 on success.  

journal_dirty_data() can be called via page_launder->ext3_writepage
by kswapd.  So it cannot block.  Happily, there's nothing here
which needs lock_journal if `async' is set.

When the buffer is on the current transaction we freely move it
between BJ_AsyncData and BJ_SyncData according to who tried to
change its state last.

int journal_dirty_metadata (handle_t *, struct buffer_head *)
-------------------------------------------------------------
Marks a buffer as containing dirty metadata
which needs to be journaled as part of the current transaction.

The buffer is placed on the transaction's metadata list and is marked
as belonging to the transaction.  

Special care needs to be taken if the buffer already belongs to the
current committing transaction (in which case we should have frozen
data present for that commit).  In that case, we don't relink the
buffer: that only gets done when the old transaction finally
completes its commit.

Returns error number or 0 on success.  

void journal_release_buffer (handle_t *, struct buffer_head *)
-----------------------------------------------------------------
This function is disabled. Um?

void journal_forget (handle_t *, struct buffer_head *)
------------------------------------------------------
bforget() for potentially-journaled buffers.  We can
only do the bforget if there are no commits pending against the
buffer.  If the buffer is dirty in the current running transaction we
can safely unlink it. 

bh may not be a journalled buffer at all - it may be a non-JBD
buffer which came off the hashtable.  Check for this.

Decrements bh->b_count by one.

Allow this call even if the handle has aborted --- it may be part of
the caller's cleanup after an abort.

void journal_sync_buffer (struct buffer_head *);
-----------------------------------------------------------------
This function is disabled, as unused by ext3. (is this right?).

int journal_flushpage(journal_t *, struct page *, unsigned long)
----------------------------------------------------------------
Return non-zero if the page's buffers were successfully reaped

int journal_try_to_free_buffers(journal_t *, struct page *, int)
----------------------------------------------------------------
journal_try_to_free_buffers().  For all the buffers on this page,
if they are fully written out ordered data, move them onto BUF_CLEAN
so try_to_free_buffers() can reap them.  Called with lru_list_lock
not held.  Does its own locking.

This complicates JBD locking somewhat.  We aren't protected by the
BKL here.  We wish to remove the buffer from its committing or
running transaction's ->t_datalist via __journal_unfile_buffer.

This may *change* the value of transaction_t->t_datalist, so anyone
who looks at t_datalist needs to lock against this function.

Even worse, someone may be doing a journal_dirty_data on this
buffer.  So we need to lock against that.  journal_dirty_data()
will come out of the lock with the buffer dirty, which makes it
ineligible for release here.

Who else is affected by this?  hmm...  Really the only contender
is do_get_write_access() - it could be looking at the buffer while
journal_try_to_free_buffer() is changing its state.  But that
cannot happen because we never reallocate freed data as metadata
while the data is part of a transaction.  Yes?

This function returns non-zero if we wish try_to_free_buffers()
to be called. We do this is the page is releasable by try_to_free_buffers().
We also do it if the page has locked or dirty buffers and the caller wants
us to perform sync or async writeout.

int	 journal_stop(handle_t *)
---------------------------------
All done for a particular handle.

There is not much action needed here.  We just return any remaining
buffer credits to the transaction and remove the handle.  The only
complication is that we need to start a commit operation if the
filesystem is marked for synchronous update.

journal_stop itself will not usually return an error, but it may
do so in unusual circumstances.  In particular, expect it to 
return -EIO if a journal_abort has been executed since the
transaction began.

MISC - JOURNAL LEVEL
-------------------
Are these exported to clients?

int journal_errno(journal_t *)
------------------------------
Returns the error from the sb.

void journal_ack_err(journal_t *)
---------------------------------
Acks the error from the sb.

int  journal_clear_err(journal_t *)
-------------------------------------------
Clears the err in the sb

unsigned long journal_bmap(journal_t *journal, unsigned long blocknr)
---------------------------------------------------------------------
Conversion of logical to physical block numbers for the journal

On external journals the journal blocks are identity-mapped, so
this is a no-op.  If needed, we can use j_blk_offset - everything is
ready.

int journal_force_commit(journal_t *journal)
-------------------------------------------
For synchronous operations: force any uncommitted transactions
to disk.  May seem kludgy, but it reuses all the handle batching
code in a very simple manner.

See Also
--------
Stephen Tweedie's Journalling Paper to OLS2000

--TB36FDmn/VVEgNH/--
