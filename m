Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264427AbTDXEff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbTDXEfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:35:34 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:159 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264420AbTDXEfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:35:23 -0400
Date: Thu, 24 Apr 2003 10:22:22 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: bcrl@redhat.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Filesystem AIO read-write patches
Message-ID: <20030424102221.A2166@in.ibm.com>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a revised version of the filesystem AIO patches
for 2.5.68.

It is built on a variation of the simple retry based 
scheme originally suggested by Ben LaHaise. 

Why ?
------
Because 2.5 is still missing real support for regular 
filesystem AIO (but for O_DIRECT). 

ext2, jfs and nfs define the fops aio interfaces aio_read 
and aio_write to default to generic_file_aio_read/write.
However these routines show fully synchronous behaviour
unless the file was opened with O_DIRECT. This means that 
an io_submit could merrily block for regular aio read/write
operations, while an application thinks its doing async 
i/o.

How ?
------
The approach we took was to identify and focus on
the most significant blocking points (seconded by 
observations from initial experimentation and profiling 
results), and convert them to retry exit points. 

Retries start at a very high level, driven directly by 
the aio infrastructure (In future if the in-kernel fs
apis change, then retries could be modified to happen  
one level below, i.e. at the api level). They are kicked 
off via async wait queue functions. In synchronous i/o 
context the default wait queue entries are synchronous 
hence don't cause an exit at a retry point.

One of the considerations was to try to take a careful
and less intrusive route with minimal changes to existing
synchronous i/o paths. The intent was to achieve a 
reasonable level of asynchrony in a way that could then
be further optimized and tuned for workloads of relevance.

The Patches:
-----------
(which I'll be mailing out as responses to this note)
01aioretry.patch 	: Base aio retry infrastructure 
02aiord.patch	 	: Filesystem aio read 
03aiowr.patch	 	: Minimal filesystem aio write 
			(for all archs and all filesystems 
			 using generic_file_aio_write)
04down_wq-86.patch 	: An asynchronous semaphore down
		     	implementation (currently x86 
			only)
05aiowrdown_wq.patch 	: Uses async down for aio write
06bread_wq.patch	: Async bread implementation
07ext2getblk_wq.patch	: Async get block support for 
			  the ext2 filesystem

Observations
--------------
As a quick check to find out if this really works, I could
observe a decent reduction in the time spent in io_submit 
(especially for large reads) when the file is not already 
cached (e.g. first time access). For the write case, I 
found that I had to add the async get block support 
to get a perceptable benefit. For the cached case, there
wasn't any observable difference, which is expected.
The patch didn't seem to be hurting synchronous read/
write performance for a simple test.

Another thing I tried out was to temporarily move the 
retries into io_getevents rather than worker threads
just as a sanity check for any gross impact on cpu 
utilization. That seemed OK too. 

Of course thorough performance testing is needed and
would show up places where there is scope for 
tuning, and how it affects overall system performance
numbers.

I have been playing with it for a while now, and so 
far its been running OK for me. 

I would welcome feedback, bug reports, test results etc.

Full diffstat:

aiordwr-rollup.patch:
......................
 arch/i386/kernel/i386_ksyms.c |    2 
 arch/i386/kernel/semaphore.c  |   30 ++-
 drivers/block/ll_rw_blk.c     |   21 +-
 fs/aio.c                      |  371 +++++++++++++++++++++++++++++++++---------
 fs/buffer.c                   |   54 +++++-
 fs/ext2/inode.c               |   44 +++-
 include/asm-i386/semaphore.h  |   27 ++-
 include/linux/aio.h           |   32 +++
 include/linux/blkdev.h        |    1 
 include/linux/buffer_head.h   |   30 +++
 include/linux/errno.h         |    1 
 include/linux/init_task.h     |    1 
 include/linux/pagemap.h       |   19 ++
 include/linux/sched.h         |    2 
 include/linux/wait.h          |    2 
 include/linux/writeback.h     |    4 
 kernel/fork.c                 |    9 -
 mm/filemap.c                  |   97 +++++++++-
 mm/page-writeback.c           |   17 +
 19 files changed, 616 insertions(+), 148 deletions(-)

[The patches are also available for download on the
 Linux Scalability Effort project site
(http://sourceforge.net/projects/lse)
Categorized under the "aio" release in IO Scalability 
section
http://sourceforge.net/project/showfiles.php?group_id=8875]

A rollup version containing all the 7 patches 
(aiordwr-rollup.patch) would be made available as well

Major additions/changes since previous versions posted:
------------------------------------------------------
- Introduced _wq versions of low level routines like
  lock_page_wq, wait_on_page_bit_wq etc, which take the 
  wait_queue entry as a parameter (Thanks to Christoph
  Hellwig for suggesting the new and much better 
  names :)). 
- Reorganized code to avoid having to use the do_sync_op() 
  wrapper (because the forced emulation of the i/o wait 
  context seemed an overhead and not very elegant).
- (New)Implementation of asynchronous semaphore down 
  operation for x86 (down_wq).
- Have dropped the async block allocation portions from the
  async ext2_get_block patch after a discussion with Stephen
  Tweedie (the i/o patterns we anticipate are less likely
  to extend file sizes)
- Fixes use_mm() to clear lazy tlb setting (I traced some 
  of the strange hangs I was seeing for large reads to this)
- Removed the aio_run_iocbs() acceleration from io_getevents,
  now that the above problem is gone.

Todos/TBDs:
----------
- Support for down_wq on other archs or provide compatibility 
  definitions for archs where it is not implemented
  (Need feedback on this)
- Should the cond_resched() calls in read/write be 
  converted to retry points (would need ctx specific worker 
  threads) ?
- Look at async get block implementations for other 
  filesystems (e.g. jfs) ?
- Optional: Check if it makes sense to use retry model for 
  o_direct (or change sync o_direct to wait for completion 
  of async o_direct) ? 
- Upgrade to Ben's aio api changes (collapse of api parameters
  into an rw_iocb) if and when it gets merged

A few comments on low level implementation details:
--------------------------------------------------
io_wait context
-------------------
The task->io_wait field reflects the wait context in which
a task is executing its i/o operations. For synchronous i/o
task->io_wait is NULL, and the wait context is local on
stack; for threads doing io submits or retries on behalf 
of async i/o callers, tsk->io_wait is the wait queue 
function entry to be notified on completion of a condition 
required for i/o to progress. 

Low level _wq routines take a wait queue parameter, so
they can be invoked in either async or sync mode, even
if running in async context (e.g servicing a page fault
during an async retry). 

Routines which are expected to be async whenever they are 
running in async context and sync when running in sync 
context do not need to provide a wait queue parameter.

do_sync_op()
---------------
The do_sync_op() wrappers are not typically needed anymore
for sync versions of the operations; passing NULL to the
corresponding _wq functions suffices. 

However, there may be weird cases where we may have several 
levels of nesting like:
A()->B()->C()->D()->F()->iowait() 
It may seem unnatural to pass a wait queue argument all 
the way through, but if we need to force sync behaviour 
in a certain case even if it is called under async context, 
and have async behaviour in another, then we may need to 
resort to using do_sync_op() (e.g if we had kept the 
ext2 async block allocation modifications). 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

