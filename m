Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269715AbRHCXpE>; Fri, 3 Aug 2001 19:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269713AbRHCXos>; Fri, 3 Aug 2001 19:44:48 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:34607 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S269708AbRHCXof>; Fri, 3 Aug 2001 19:44:35 -0400
Date: Fri, 3 Aug 2001 19:44:43 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [RFC][DATA] re "ongoing vm suckage"
Message-ID: <Pine.LNX.4.33.0108031812120.23074-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks,

I've been doing a bunch of analysis this week as to what exactly is going
wrong with the "vm system" that causes interactive performance to suffer,
especially on larger systems.  IMO, far too much tinkering of code is
going on currently without hard data (other than "it looks good"), and
this is exacerbating the problems.  Towards this end, here is some hard
data, some analysis, a small patch and a BUG report (I'm about to leave
the office today, so I wanted to send out a status-thus-far).

The data below [see bottom] comes from some Ugly Hacks (tm) to measure how
long the kernel is sleeping in a schedule on a particular event.  All
times are in jiffies following the HERE symbol which comes from inserting
the line into System.map and doing a grep -1 HERE.

The workload consists of using dd if=/dev/zero of=/tmp/foo bs=1M and then
attempting to perform some interactive work on the machine while dd is
running.  I'm working on a 2.4.7 kernel, but this should apply equally
well to other kernels nearby.  The machine being used is a 4way x86 with
4GB of memory.


On to some analysis:  the first thing that should stick out below is that
an awefully large amount of time is spent waiting in bread and
read_cache_page.  The time looks to roughly correspond to that spent
waiting for the various interactive tasks to repsond to input during a
stall.  Most of the interactive tasks consisted of poking around the
filesystem and loading programs like grep and datafiles that weren't in
the cache since the system was freshly booted.

(Side note here: vmstat/sshd didn't get kicked out of memory until a
minute or two *after* all io throughput broke down chaotically.  Sorry, I
don't have the vmstat output, but run it for yourself: it's reproducible.)

In any case, the fact that the io system is saturated with write requests
means that reads are going to take longer.  The current code in
ll_rw_blk.c sets the maximum amount of memory in the io queue to 2/3 of
ram, which on a 4GB box is more io than the machine can do in 30s.  With
that line of reasoning, I applied the following patch:

--- v2.4.7/drivers/block/ll_rw_blk.c	Sun Jul 22 19:17:15 2001
+++ vm-2.4.7/drivers/block/ll_rw_blk.c	Fri Aug  3 17:52:39 2001
@@ -1176,9 +1176,11 @@
 	 * use half of RAM
 	 */
 	high_queued_sectors = (total_ram * 2) / 3;
+	if (high_queued_sectors > MB(4))
+		high_queued_sectors = MB(4);
 	low_queued_sectors = high_queued_sectors / 3;
-	if (high_queued_sectors - low_queued_sectors > MB(128))
-		low_queued_sectors = high_queued_sectors - MB(128);
+	if (high_queued_sectors - low_queued_sectors > MB(1))
+		low_queued_sectors = high_queued_sectors - MB(1);


 	/*


Seems like it would help, eh?  Indeed, it did help a little bit.  That is,
until dd ground to a complete halt.  That said, the rest of the system did
not.  In fact, running programs that triggered disk io resulted in writes
being flushed to disk.  [at this point I'm refering to the second data set
below]  Interesting: the bulk of the waits are once more are in bread,
with block_prepare_write, do_generic_file_read and ll_rw_block in at
1/3-1/5 the time spent waiting.  Hypothesis: one of the block writeout
paths is missing a run_task_queue(&tq_disk);.  [off to read code and try a
patch]  bread spends most of its time in wait_on_buffer, which runs
tq_disk.  Uninteresting.  __block_prepare_write calls wait_on_buffer.
Uninteresting.  do_generic_file_read calls lock_page and wait_on_page.
They both play by the rules and run tq_disk.  Let's look at ll_rw_block():
ah, we have a wait_event call...

Okay, let's try the following patch:

--- vm-2.4.7/drivers/block/ll_rw_blk.c.2	Fri Aug  3 19:06:46 2001
+++ vm-2.4.7/drivers/block/ll_rw_blk.c	Fri Aug  3 19:32:46 2001
@@ -1037,9 +1037,16 @@
 		 * water mark. instead start I/O on the queued stuff.
 		 */
 		if (atomic_read(&queued_sectors) >= high_queued_sectors) {
-			run_task_queue(&tq_disk);
-			wait_event(blk_buffers_wait,
-			 atomic_read(&queued_sectors) < low_queued_sectors);
+			DECLARE_WAITQUEUE(wait, current);
+
+			add_wait_queue(&blk_buffers_wait, &wait);
+			do {
+				run_task_queue(&tq_disk);
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				if (atomic_read(&queued_sectors) >= low_queued_sectors)
+					schedule();
+			} while (atomic_read(&queued_sectors) >= low_queued_sectors);
+			remove_wait_queue(&blk_buffers_wait, &wait);
 		}

 		/* Only one thread can actually submit the I/O. */


Compiles fine, let's see what effect it has on io...

bah.  Doesn't fix it.  Still waiting indefinately in ll_rw_blk().  At
least this is a bit of a narrower scope for the problem.  More later,
unless someone else wants to debug it before tomorrow ;-)

		-ben



==================first data set==================
c01a8590 t wait_til_done
c01a8612 HERE			2
c01a86d0 t generic_done

c0122820 t context_thread
c0122927 HERE			80213
c0122a20 T flush_scheduled_tasks

c01384d0 T bread
c0138515 HERE			143815
c0138540 t get_unused_buffer_head

c0229190 t write_disk_sb
c0229343 HERE			2
c0229370 t set_this_disk

c0129a50 T read_cache_page
c0129b2b HERE			44123
c0129c10 T grab_cache_page

c0128510 T filemap_nopage
c012887b HERE			3157
c0128a90 T filemap_sync

c0190030 T tty_wait_until_sent
c0190092 HERE			0
c0190100 t unset_locked_termios

c01273e0 T ___wait_on_page
c0127418 HERE			2075
c0127490 t __lock_page

c01194e0 T sys_wait4
c011954d HERE			1394
c01198c0 T sys_waitpid

c0140c90 t pipe_poll
c0140cba HERE			81513
c0140d00 t pipe_release

c01406c0 T pipe_wait
c0140720 HERE			156
c0140770 t pipe_read

c013d830 T block_read
c013dd36 HERE			232
c013ddf0 t block_llseek

c0105b30 T __down
c0105b6b HERE			0
c0105c00 T __down_interruptible

c0265d90 t unix_poll
c0265db6 HERE			73989
c0265e30 t unix_read_proc

c0136ee0 t write_locked_buffers
c0136f27 HERE			1056
c0136f40 t write_unlocked_buffers

c0137090 t wait_for_locked_buffers
c0137119 HERE			5
c0137140 t sync_buffers

c0127a20 T do_generic_file_read
c0127c98 HERE			802
c0127f20 T file_read_actor

c0138ba0 t __block_prepare_write
c0138df7 HERE			132392
c0138e20 t __block_commit_write

c025f2e0 t inet_wait_for_connect
c025f33e HERE			1
c025f4a0 T inet_stream_connect

c0233720 T datagram_poll
c0233747 HERE			154105
c0233810 t scm_fp_copy

c0122a20 T flush_scheduled_tasks
c0122a7e HERE			0
c0122ab0 T start_context_thread

c0243a30 T tcp_poll
c0243a5e HERE			76841
c0243b80 T tcp_write_space

c026d4e0 t rpciod
c026d66c HERE			77064
c026d760 t rpciod_killall

c026c720 t __rpc_execute
c026c90a HERE			1
c026ca50 T rpc_execute

c018fce0 t write_chan
c018fda2 HERE			2857
c018fef0 t normal_poll

c0246800 t tcp_data_wait
c024685b HERE			60957
c0246990 t tcp_prequeue_process

c015ad30 t ext2_update_inode
c015b0f4 HERE			1
c015b150 T ext2_write_inode

c013a210 t sync_page_buffers
c013a251 HERE			6372
c013a280 T try_to_free_buffers


========================second data set==========================
c01a8590 t wait_til_done
c01a8612 HERE			2
c01a86d0 t generic_done

c0122820 t context_thread
c0122927 HERE			3439
c0122a20 T flush_scheduled_tasks

c01384d0 T bread
c0138515 HERE			1401380
c0138540 t get_unused_buffer_head

c0229190 t write_disk_sb
c0229343 HERE			1
c0229370 t set_this_disk

c0129a50 T read_cache_page
c0129b2b HERE			327
c0129c10 T grab_cache_page

c0128510 T filemap_nopage
c012887b HERE			23650
c0128a90 T filemap_sync

c0190030 T tty_wait_until_sent
c0190092 HERE			0
c0190100 t unset_locked_termios

c01273e0 T ___wait_on_page
c0127418 HERE			291
c0127490 t __lock_page

c01194e0 T sys_wait4
c011954d HERE			1335
c01198c0 T sys_waitpid

c0140c90 t pipe_poll
c0140cba HERE			244933
c0140d00 t pipe_release

c01406c0 T pipe_wait
c0140720 HERE			166
c0140770 t pipe_read

c013d830 T block_read
c013dd36 HERE			236
c013ddf0 t block_llseek

c0105b30 T __down
c0105b6b HERE			0
c0105c00 T __down_interruptible

c0265d90 t unix_poll
c0265db6 HERE			244143
c0265e30 t unix_read_proc

c0136ee0 t write_locked_buffers
c0136f27 HERE			38
c0136f40 t write_unlocked_buffers

c0137090 t wait_for_locked_buffers
c0137119 HERE			5
c0137140 t sync_buffers

c0127a20 T do_generic_file_read
c0127c98 HERE			244722
c0127f20 T file_read_actor

c0138ba0 t __block_prepare_write
c0138df7 HERE			485918
c0138e20 t __block_commit_write

c025f2e0 t inet_wait_for_connect
c025f33e HERE			1
c025f4a0 T inet_stream_connect

c0233720 T datagram_poll
c0233747 HERE			276902
c0233810 t scm_fp_copy

c0122a20 T flush_scheduled_tasks
c0122a7e HERE			0
c0122ab0 T start_context_thread

c0243a30 T tcp_poll
c0243a5e HERE			3735
c0243b80 T tcp_write_space

c0246800 t tcp_data_wait
c024685b HERE			240523
c0246990 t tcp_prequeue_process

c026d4e0 t rpciod
c026d66c HERE			2143
c026d760 t rpciod_killall

c026c720 t __rpc_execute
c026c90a HERE			19
c026ca50 T rpc_execute

c018fce0 t write_chan
c018fda2 HERE			580
c018fef0 t normal_poll

c01a47f0 T ll_rw_block
c01a492a HERE			233343
c01a4a40 T end_that_request_first


