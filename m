Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268837AbRHBHDz>; Thu, 2 Aug 2001 03:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268833AbRHBHDi>; Thu, 2 Aug 2001 03:03:38 -0400
Received: from 63-216-69-197.sdsl.cais.net ([63.216.69.197]:47110 "EHLO
	vyger.freesoft.org") by vger.kernel.org with ESMTP
	id <S268832AbRHBHCk>; Thu, 2 Aug 2001 03:02:40 -0400
Message-ID: <3B68FB0C.5BC83115@freesoft.org>
Date: Thu, 02 Aug 2001 03:02:36 -0400
From: Brent Baccala <baccala@freesoft.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Problem with usb-storage using HP 8200 external CD-ROM burner
Content-Type: multipart/mixed;
 boundary="------------AC12D36791113BB38F081CD1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AC12D36791113BB38F081CD1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi -

I've been having some problems with my USB CD-ROM burner (HP 8200) - it
locks up the machine occasionally.  This is with Linux 2.4.6.

I saw a posting to this list (linux-usb-devel) by Cody Pisto with some
HP
8200 patches (17 Jul 2001), but the geocrawler archive doesn't archive
the
attachments - or at least I couldn't figure out how to retrieve them.  I
wouldn't mind if somebody (Cody?) could send me a copy, but here's what
I've
found out...

Of course, first you have to patch drivers/usb/Config.in to add an
HP8200 option.

Next, the lockups.  They're caused by an attempt to lock the
io_request_lock spinlock while it's already locked.  I'm running on a
single processor machine.  I'm posting two patches to linux-kernel - one
is enhanced spinlock debugging code that reveals the problem, the other
is a remote debugger stub for intel so I can use gdb on the kernel like
sparc & ppc.

In, short, here's the problem:

The trouble starts when scsi_try_to_abort_command is called (for reasons
I'm still unclear on).  This function is in drivers/scsi/scsi_error.c:

     755 STATIC int scsi_try_to_abort_command(Scsi_Cmnd * SCpnt, int
timeout)
     756 {
     757         int rtn;
     758         unsigned long flags;
     759 
     760         SCpnt->eh_state = FAILED;   /* Until we come up with
something better */
     761 
     762         if (SCpnt->host->hostt->eh_abort_handler == NULL) {
     763                 return FAILED;
     764         }
     765         /* 
     766          * scsi_done was called just after the command timed
out and before
     767          * we had a chance to process it. (DB)
     768          */
     769         if (SCpnt->serial_number == 0)
     770                 return SUCCESS;
     771 
     772         SCpnt->owner = SCSI_OWNER_LOWLEVEL;
     773 
     774         spin_lock_irqsave(&io_request_lock, flags);
     775         rtn = SCpnt->host->hostt->eh_abort_handler(SCpnt);
     776         spin_unlock_irqrestore(&io_request_lock, flags);
     777         return rtn;
     778 }

Notice, at the end, the call to eh_abort_handler while the
io_request_lock is held (lines 774-777).

For the USB CD-ROM burner, eh_abort_handler is a pointer to
command_abort in drivers/usb/storage/scsiglue.c:

     173 static int command_abort( Scsi_Cmnd *srb )
     174 {
     175         struct us_data *us = (struct us_data
*)srb->host->hostdata[0];
     176 
     177         US_DEBUGP("command_abort() called\n");
     178 
     179         /* if we're stuck waiting for an IRQ, simulate it */
     180         if (atomic_read(us->ip_wanted)) {
     181                 US_DEBUGP("-- simulating missing IRQ\n");
     182                 up(&(us->ip_waitq));
     183         }
     184 
     185         /* if the device has been removed, this worked */
     186         if (!us->pusb_dev) {
     187                 US_DEBUGP("-- device removed already\n");
     188                 return SUCCESS;
     189         }
     190 
     191         /* if we have an urb pending, let's wake the control
thread up */
     192         if (us->current_urb->status == -EINPROGRESS) {
     193                 /* cancel the URB -- this will automatically
wake the thread */
     194                 usb_unlink_urb(us->current_urb);
     195 
     196                 /* wait for us to be done */
     197                 down(&(us->notify));
     198                 return SUCCESS;
     199         }
     200 
     201         US_DEBUGP ("-- nothing to abort\n");
     202         return FAILED;
     203 }

The problem is the down on line 197.  It causes the kernel to schedule
while the io_request_lock is held.  Now, if anything else comes along
that needs the io_request_lock, and runs before the down completes, the
kernel locks up.  Lots of stuff can actually trigger the lockup; I've
seen a page fault trying to read something in from disk cause it, as
well as just a normal disk read from user space.

I'm attaching a kernel gdb trace of one of these lockups.  It's a bit
cryptic, because the kernel gdb doesn't let me switch between tasks, so
I have to read back through a stack dump manually.  Basically, the trace
starts with a BUG() in my revised spinlock code that detects when the
same processor that holds the lock attempts to grab it again.  The
spinlock recorded the PC and task_struct when the lock was first
grabbed, so even though we're looking at the moment when the second task
came along and tried to grab it again, we can use the stored information
to find 1) which task grabbed the lock; 2) what it's PC counter was when
it grabbed it; and 3) (by reading the stack trace) what's it's doing
now.  In this trace, the answers to those questions are: 1) pid 1370
(comm = "scsi_eh"; unclear what that is); 2) the spinlock in
scsi_try_to_abort_command; and 3) scheduled from the down on line 197

Anyway, I don't know enough about this code to try and figure what the
fix should be, so maybe somebody on this list can suggest it.  Then
I'll need to figure out why scsi_try_to_abort_command() is being called
in the first place - any ideas?  It seems to be about a 50/50
proposition that during an entire CD burn, sometimes it locks up, and
sometimes it completes the whole thing.

And like I said, I'm attaching the kernel gdb trace... as an
attachment... so geocrawler can lose it too..

-- 
                                        -bwb

                                        Brent Baccala
                                        baccala@freesoft.org

==============================================================================
       For news from freesoft.org, subscribe to announce@freesoft.org:
   
mailto:announce-request@freesoft.org?subject=subscribe&body=subscribe
==============================================================================
--------------AC12D36791113BB38F081CD1
Content-Type: text/plain; charset=us-ascii;
 name="kgdb.trace"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kgdb.trace"

[baccala@y2k intel:linux-2.4.6-kgdb]$ gdb vmlinux
GNU gdb 19991004
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux"...
(gdb) target remote /dev/cua0
Remote debugging using /dev/cua0
breakpoint () at i386-stub.c:622
622	}
(gdb) cont
Continuing.

Program received signal SIGILL, Illegal instruction.
0xc01b76d9 in blk_get_queue (dev=769)
    at /home/baccala/src/linux-2.4.6-kgdb/include/asm/spinlock.h:103
103			BUG();
(gdb) print io_request_lock
$1 = {lock = 0, magic = 3735899821, last_lock_addr = 0xc01e9c60, 
  last_lock_current = 0xc135a000, last_lock_processor = 0}
(gdb) print io_request_lock->last_lock_addr
$2 = (void *) 0xc01e9c60
(gdb) list *io_request_lock->last_lock_addr
0xc01e9c60 is in scsi_try_to_abort_command (/home/baccala/src/linux-2.4.6-kgdb/include/asm/spinlock.h:97).
92	static inline void spin_lock(spinlock_t *lock)
93	{
94	#if SPINLOCK_DEBUG
95		__label__ here;
96	here:
97		if (lock->magic != SPINLOCK_MAGIC) {
98	printk("eip: %p\n", &&here);
99			BUG();
100		}
101		if (spin_is_locked(lock)
(gdb) print io_request_lock->last_lock_current
$3 = (void *) 0xc135a000
(gdb) print (struct task_struct *)io_request_lock->last_lock_current
$4 = (struct task_struct *) 0xc135a000
(gdb) print ((struct task_struct *)io_request_lock->last_lock_current)->thread
$5 = {esp0 = 3241525248, eip = 3222356453, esp = 3241524852, fs = 24, gs = 24, 
  debugreg = {0, 0, 0, 0, 0, 0, 0, 0}, cr2 = 0, trap_no = 0, error_code = 0, 
  i387 = {fsave = {cwd = -64641, swd = -65536, twd = -1, fip = 0, fcs = 0, 
      foo = 0, fos = -65536, st_space = {0 <repeats 16 times>, -2146699776, 
        16405, 0, 0}, status = 0}, fxsave = {cwd = 895, swd = 65535, twd = 0, 
      fop = 65535, fip = -1, fcs = 0, foo = 0, fos = 0, mxcsr = -65536, 
      reserved = 0, st_space = {0 <repeats 15 times>, -2146699776, 16405, 
        0 <repeats 15 times>}, xmm_space = {0 <repeats 32 times>}, padding = {
        0 <repeats 56 times>}}, soft = {cwd = -64641, swd = -65536, twd = -1, 
      fip = 0, fcs = 0, foo = 0, fos = -65536, st_space = {
        0 <repeats 16 times>, -2146699776, 16405, 0, 0}, ftop = 0 '\000', 
      changed = 0 '\000', lookahead = 0 '\000', no_update = 0 '\000', 
      rm = 0 '\000', alimit = 0 '\000', info = 0x0, entry_eip = 0}}, 
  vm86_info = 0x0, screen_bitmap = 0, v86flags = 0, v86mask = 0, v86mode = 0, 
  saved_esp0 = 0, ioperm = 0, io_bitmap = {4294967295, 0 <repeats 32 times>}}
(gdb) print ((struct task_struct *)io_request_lock->last_lock_current)->thread->eip
$6 = 3222356453
(gdb) printf "%x\n", ((struct task_struct *)io_request_lock->last_lock_current)->thread->eip
c01141e5
(gdb) list *((struct task_struct *)io_request_lock->last_lock_current)->thread->eip
0xc01141e5 is in schedule (sched.c:669).
664	
665		/*
666		 * This just switches the register state and the
667		 * stack.
668		 */
669		switch_to(prev, next, prev);
670		__schedule_tail(prev);
671	
672	same_process:
673		reacquire_kernel_lock(current);
(gdb) printf "%x\n", ((struct task_struct *)io_request_lock->last_lock_current)->thread->esp
c135be74
(gdb) x/64x  ((struct task_struct *)io_request_lock->last_lock_current)->thread->esp
0xc135be74:	0xc135bef0	0xc24ed7a0	0x00000000	0xc135a000
0xc135be84:	0xc14469dc	0xc14469e4	0xc24ed7a0	0x44505c49
0xc135be94:	0x00000092	0xc1649ec0	0xc5f3bf78	0xc5f69000
0xc135bea4:	0x55665351	0x00000083	0xc1649ec0	0xc5f3bf78
0xc135beb4:	0xc5f69000	0xc5f69098	0xc0312000	0xc02fbb40
0xc135bec4:	0x00000083	0xc135be00	0xc135a000	0x00000000
0xc135bed4:	0xc135a000	0xc14469dc	0xc135a000	0xfffffc18
0xc135bee4:	0x00000000	0xc135a000	0xc0353040	0xc135bf1c
0xc135bef4:	0xc0105d1d	0xc1446800	0xc03071c8	0x00000206
0xc135bf04:	0xc14469e4	0xc135bf0c	0x00000001	0xc135a000
0xc135bf14:	0xc14469f8	0xc14469f8	0xc135bf3c	0xc01061e4
0xc135bf24:	0xc14469dc	0xc5f69000	0x00000000	0xc02848c3
0xc135bf34:	0xc1649ec0	0xc135a000	0xc135bf58	0xc01e9cf0
0xc135bf44:	0xc1975400	0xc4db74a0	0xc135bf84	0xc1975400
0xc135bf54:	0xc01060a1	0xc135bf88	0xc01ea614	0xc1975400
0xc135bf64:	0x000005dc	0xc4db74a0	0xc135a000	0xc02fb2a0
(gdb) print *((struct task_struct *)io_request_lock->last_lock_current)
$7 = {state = 2, flags = 64, sigpending = 0, addr_limit = {seg = 4294967295}, 
  exec_domain = 0xc02fbc60, need_resched = 0, ptrace = 0, lock_depth = -1, 
  counter = 11, nice = 0, policy = 0, mm = 0x0, has_cpu = 0, processor = 0, 
  cpus_allowed = 4294967295, run_list = {next = 0x0, prev = 0xc02fbb40}, 
  sleep_time = 12446, next_task = 0xc14dc000, prev_task = 0xc135c000, 
  active_mm = 0x0, binfmt = 0x0, exit_code = 0, exit_signal = 0, 
  pdeath_signal = 0, personality = 0, dumpable = 0, did_exec = 0, pid = 1370, 
  pgrp = 1, tty_old_pgrp = 0, session = 1, tgid = 1370, leader = 0, 
  p_opptr = 0xc5f52000, p_pptr = 0xc5f52000, p_cptr = 0x0, p_ysptr = 0x0, 
  p_osptr = 0xc135c000, thread_group = {next = 0xc135a098, prev = 0xc135a098}, 
  pidhash_next = 0x0, pidhash_pprev = 0xc037493c, wait_chldexit = {lock = {
      lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
      last_lock_current = 0x0, last_lock_processor = 0}, task_list = {
      next = 0xc135a0bc, prev = 0xc135a0bc}}, vfork_sem = 0x0, 
  rt_priority = 0, it_real_value = 0, it_prof_value = 0, it_virt_value = 0, 
  it_real_incr = 0, it_prof_incr = 0, it_virt_incr = 0, real_timer = {list = {
      next = 0x0, prev = 0x0}, expires = 0, data = 3241517056, 
    function = 0xc011d648 <it_real_fn>}, times = {tms_utime = 0, 
    tms_stime = 0, tms_cutime = 0, tms_cstime = 0}, start_time = 6420, 
  per_cpu_utime = {0 <repeats 32 times>}, per_cpu_stime = {
    0 <repeats 32 times>}, min_flt = 0, maj_flt = 0, nswap = 0, cmin_flt = 0, 
  cmaj_flt = 0, cnswap = 0, swappable = -1, uid = 0, euid = 0, suid = 0, 
  fsuid = 0, gid = 0, egid = 0, sgid = 0, fsgid = 0, ngroups = 0, groups = {
---Type <return> to continue, or q <return> to quit---
    0 <repeats 32 times>}, cap_effective = 4294967039, cap_inheritable = 0, 
  cap_permitted = 4294967295, keep_capabilities = 0, user = 0xc02fc9d4, 
  rlim = {{rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 8388608, rlim_max = 4294967295}, {
      rlim_cur = 0, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 3072, rlim_max = 3072}, {
      rlim_cur = 1024, rlim_max = 1024}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}}, used_math = 1, 
  comm = "scsi_eh_0\000\000\000\000\000\000", link_count = 0, tty = 0x0, 
  locks = 0, semundo = 0x0, semsleeping = 0x0, thread = {esp0 = 3241525248, 
    eip = 3222356453, esp = 3241524852, fs = 24, gs = 24, debugreg = {0, 0, 0, 
      0, 0, 0, 0, 0}, cr2 = 0, trap_no = 0, error_code = 0, i387 = {fsave = {
        cwd = -64641, swd = -65536, twd = -1, fip = 0, fcs = 0, foo = 0, 
        fos = -65536, st_space = {0 <repeats 16 times>, -2146699776, 16405, 0, 
          0}, status = 0}, fxsave = {cwd = 895, swd = 65535, twd = 0, 
        fop = 65535, fip = -1, fcs = 0, foo = 0, fos = 0, mxcsr = -65536, 
        reserved = 0, st_space = {0 <repeats 15 times>, -2146699776, 16405, 
          0 <repeats 15 times>}, xmm_space = {0 <repeats 32 times>}, 
        padding = {0 <repeats 56 times>}}, soft = {cwd = -64641, swd = -65536, 
        twd = -1, fip = 0, fcs = 0, foo = 0, fos = -65536, st_space = {
          0 <repeats 16 times>, -2146699776, 16405, 0, 0}, ftop = 0 '\000', 
---Type <return> to continue, or q <return> to quit---
        changed = 0 '\000', lookahead = 0 '\000', no_update = 0 '\000', 
        rm = 0 '\000', alimit = 0 '\000', info = 0x0, entry_eip = 0}}, 
    vm86_info = 0x0, screen_bitmap = 0, v86flags = 0, v86mask = 0, 
    v86mode = 0, saved_esp0 = 0, ioperm = 0, io_bitmap = {4294967295, 
      0 <repeats 32 times>}}, fs = 0xc02f9440, files = 0xc02f9480, 
  sigmask_lock = {lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
    last_lock_current = 0x0, last_lock_processor = 0}, sig = 0xc145a080, 
  blocked = {sig = {4294967294, 4294967295}}, pending = {head = 0x0, 
    tail = 0xc135a668, signal = {sig = {0, 0}}}, sas_ss_sp = 0, 
  sas_ss_size = 0, notifier = 0, notifier_data = 0x0, notifier_mask = 0x0, 
  parent_exec_id = 0, self_exec_id = 0, alloc_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0114200, 
    last_lock_current = 0xc0312000, last_lock_processor = 0}}
(gdb) list *0xc0105d1c
0xc0105d1c is in __down (semaphore.c:80).
75				break;
76			}
77			sem->sleepers = 1;	/* us - see -1 above */
78			spin_unlock_irq(&semaphore_lock);
79	
80			schedule();
81			tsk->state = TASK_UNINTERRUPTIBLE;
82			spin_lock_irq(&semaphore_lock);
83		}
84		spin_unlock_irq(&semaphore_lock);
(gdb) list *0xc01061e4
0xc01061e4 is at af_packet.c:1878.
1873	{
1874		remove_proc_entry("net/packet", 0);
1875		unregister_netdevice_notifier(&packet_netdev_notifier);
1876		sock_unregister(PF_PACKET);
1877		return;
1878	}
1879	
1880	static int __init packet_init(void)
1881	{
1882		sock_register(&packet_family_ops);
(gdb) list *0xc01e9cf0
0xc01e9cf0 is in scsi_try_to_abort_command (scsi_error.c:775).
770			return SUCCESS;
771	
772		SCpnt->owner = SCSI_OWNER_LOWLEVEL;
773	
774		spin_lock_irqsave(&io_request_lock, flags);
775		rtn = SCpnt->host->hostt->eh_abort_handler(SCpnt);
776		spin_unlock_irqrestore(&io_request_lock, flags);
777		return rtn;
778	}
779	
(gdb) list *0xc0219f29
0xc0219f29 is in command_abort (scsiglue.c:198).
193			/* cancel the URB -- this will automatically wake the thread */
194			usb_unlink_urb(us->current_urb);
195	
196			/* wait for us to be done */
197			down(&(us->notify));
198			return SUCCESS;
199		}
200	
201		US_DEBUGP ("-- nothing to abort\n");
202		return FAILED;
(gdb) print $esp
$8 = -1067844024
(gdb) printf "%x\n", $esp
c059fe48
(gdb) printf "%x\n", $esp&(~8191)
c059e000
(gdb) set $current =$esp&(~8191)
(gdb) set $current =(struct task_struct *)$esp&(~8191)
Argument to arithmetic operation not a number or boolean.
(gdb) print (struct task_struct *)$current
$9 = (struct task_struct *) 0xc059e000
(gdb) print *(struct task_struct *)$current
$10 = {state = 0, flags = 1048576, sigpending = 0, addr_limit = {
    seg = 3221225472}, exec_domain = 0xc02fbc60, need_resched = 1, ptrace = 0, 
  lock_depth = -1, counter = 6, nice = 0, policy = 0, mm = 0xc24ed3e0, 
  has_cpu = 1, processor = 0, cpus_allowed = 4294967295, run_list = {
    next = 0xc02fbb40, prev = 0xc234003c}, sleep_time = 12739, 
  next_task = 0xc13bc000, prev_task = 0xc060c000, active_mm = 0xc24ed3e0, 
  binfmt = 0xc02fe0a4, exit_code = 0, exit_signal = 17, pdeath_signal = 0, 
  personality = 0, dumpable = -1, did_exec = -1, pid = 1411, pgrp = 1411, 
  tty_old_pgrp = 0, session = 1403, tgid = 1411, leader = 0, 
  p_opptr = 0xc060c000, p_pptr = 0xc060c000, p_cptr = 0xc13bc000, 
  p_ysptr = 0x0, p_osptr = 0x0, thread_group = {next = 0xc059e098, 
    prev = 0xc059e098}, pidhash_next = 0x0, pidhash_pprev = 0xc03749d8, 
  wait_chldexit = {lock = {lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
      last_lock_current = 0x0, last_lock_processor = 0}, task_list = {
      next = 0xc059e0bc, prev = 0xc059e0bc}}, vfork_sem = 0xc059ff80, 
  rt_priority = 0, it_real_value = 0, it_prof_value = 0, it_virt_value = 0, 
  it_real_incr = 0, it_prof_incr = 0, it_virt_incr = 0, real_timer = {list = {
      next = 0x0, prev = 0x0}, expires = 7151, data = 3227115520, 
    function = 0xc011d648 <it_real_fn>}, times = {tms_utime = 76, 
    tms_stime = 17, tms_cutime = 0, tms_cstime = 0}, start_time = 12261, 
  per_cpu_utime = {76, 0 <repeats 31 times>}, per_cpu_stime = {17, 
    0 <repeats 31 times>}, min_flt = 662, maj_flt = 1053, nswap = 0, 
  cmin_flt = 0, cmaj_flt = 0, cnswap = 0, swappable = -1, uid = 500, 
---Type <return> to continue, or q <return> to quit---
  euid = 500, suid = 500, fsuid = 500, gid = 500, egid = 500, sgid = 500, 
  fsgid = 500, ngroups = 2, groups = {500, 300, 0 <repeats 30 times>}, 
  cap_effective = 0, cap_inheritable = 0, cap_permitted = 0, 
  keep_capabilities = 0, user = 0xc4dc8f20, rlim = {{rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 8388608, 
      rlim_max = 4294967295}, {rlim_cur = 1024000000, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 3072, 
      rlim_max = 3072}, {rlim_cur = 1024, rlim_max = 1024}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}}, 
  used_math = 1, comm = "sol\000\000-terminal\000", link_count = 0, 
  tty = 0xc0613000, locks = 0, semundo = 0x0, semsleeping = 0x0, thread = {
    esp0 = 3227123712, eip = 3222356453, esp = 3227123520, fs = 0, gs = 0, 
    debugreg = {0, 0, 0, 0, 0, 0, 0, 0}, cr2 = 0, trap_no = 0, error_code = 0, 
    i387 = {fsave = {cwd = -64641, swd = -65248, twd = -1, fip = 1078387819, 
        fcs = 98041891, foo = 0, fos = -65493, st_space = {0, 0, 0, 0, 0, 0, 
          0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, status = 0}, 
      fxsave = {cwd = 895, swd = 65535, twd = 288, fop = 65535, fip = -1, 
        fcs = 1078387819, foo = 98041891, fos = 0, mxcsr = -65493, 
        reserved = 0, st_space = {0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 
          0 <repeats 23 times>}, xmm_space = {0 <repeats 32 times>}, 
        padding = {0 <repeats 56 times>}}, soft = {cwd = -64641, swd = -65248, 
---Type <return> to continue, or q <return> to quit---
        twd = -1, fip = 1078387819, fcs = 98041891, foo = 0, fos = -65493, 
        st_space = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0}, ftop = 0 '\000', changed = 0 '\000', 
        lookahead = 0 '\000', no_update = 0 '\000', rm = 0 '\000', 
        alimit = 0 '\000', info = 0x0, entry_eip = 0}}, vm86_info = 0x0, 
    screen_bitmap = 0, v86flags = 0, v86mask = 0, v86mode = 0, saved_esp0 = 0, 
    ioperm = 0, io_bitmap = {4294967295, 0 <repeats 32 times>}}, 
  fs = 0xc1318e20, files = 0xc060eac0, sigmask_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0124760, 
    last_lock_current = 0xc059e000, last_lock_processor = 0}, 
  sig = 0xc069f5a0, blocked = {sig = {0, 0}}, pending = {head = 0x0, 
    tail = 0xc059e668, signal = {sig = {0, 0}}}, sas_ss_sp = 0, 
  sas_ss_size = 0, notifier = 0, notifier_data = 0x0, notifier_mask = 0x0, 
  parent_exec_id = 10, self_exec_id = 11, alloc_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0114200, 
    last_lock_current = 0xc0d90000, last_lock_processor = 0}}
(gdb) where
#0  0xc01b76d9 in blk_get_queue (dev=769)
    at /home/baccala/src/linux-2.4.6-kgdb/include/asm/spinlock.h:103
#1  0xc01b8a3c in generic_make_request (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:904
#2  0xc01b8ae9 in submit_bh (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:946
#3  0xc01460be in block_read_full_page (page=0xc1158840, 
    get_block=0xc016f884 <ext2_get_block>) at buffer.c:1737
#4  0xc016fd65 in ext2_readpage (file=0xc05b1180, page=0xc1158840)
    at inode.c:583
#5  0xc012f078 in do_generic_file_read (filp=0xc05b1180, ppos=0xc05b11a0, 
    desc=0xc059ff88, actor=0xc012f324 <file_read_actor>) at filemap.c:1207
#6  0xc012f3ed in generic_file_read (filp=0xc05b1180, buf=0x8123438 "", 
    count=4096, ppos=0xc05b11a0) at filemap.c:1310
#7  0xc0141005 in sys_read (fd=8, buf=0x8123438 "", count=4096)
    at read_write.c:133
#8  0xc01077d7 in system_call () at af_packet.c:1878
#9  0x40474fef in ?? () at af_packet.c:1878
#10 0x4047505e in ?? () at af_packet.c:1878
#11 0x40482c89 in ?? () at af_packet.c:1878
#12 0x40482bd2 in ?? () at af_packet.c:1878
#13 0x40468a05 in ?? () at af_packet.c:1878
#14 0x4044cb4b in ?? () at af_packet.c:1878
#15 0x40468b04 in ?? () at af_packet.c:1878
#16 0x40462f63 in ?? () at af_packet.c:1878
---Type <return> to continue, or q <return> to quit---q
Quit
(gdb) print io_request_lock
$11 = {lock = 0, magic = 3735899821, last_lock_addr = 0xc01e9c60, 
  last_lock_current = 0xc135a000, last_lock_processor = 0}
(gdb) set io_request_lock->lock=1
(gdb) x/2i $pc
0xc01b76d9 <blk_get_queue+121>:	ud2a   
0xc01b76db <blk_get_queue+123>:	add    $0xc,%esp
(gdb) set $pc=$pc+2
(gdb) cont
Continuing.

0xc135bf14:	0xc14469f8	0xc14469f8	0xc135bf3c	0xc01061e4
0xc135bf24:	0xc14469dc	0xc5f69000	0x00000000	0xc02848c3
0xc135bf34:	0xc1649ec0	0xc135a000	0xc135bf58	0xc01e9cf0
0xc135bf44:	0xc1975400	0xc4db74a0	0xc135bf84	0xc1975400
0xc135bf54:	0xc01060a1	0xc135bf88	0xc01ea614	0xc1975400
0xc135bf64:	0x000005dc	0xc4db74a0	0xc135a000	0xc02fb2a0
(gdb) print *((struct task_struct *)io_request_lock->last_lock_current)
$7 = {state = 2, flags = 64, sigpending = 0, addr_limit = {seg = 4294967295}, 
  exec_domain = 0xc02fbc60, need_resched = 0, ptrace = 0, lock_depth = -1, 
  counter = 11, nice = 0, policy = 0, mm = 0x0, has_cpu = 0, processor = 0, 
  cpus_allowed = 4294967295, run_list = {next = 0x0, prev = 0xc02fbb40}, 
  sleep_time = 12446, next_task = 0xc14dc000, prev_task = 0xc135c000, 
  active_mm = 0x0, binfmt = 0x0, exit_code = 0, exit_signal = 0, 
  pdeath_signal = 0, personality = 0, dumpable = 0, did_exec = 0, pid = 1370, 
  pgrp = 1, tty_old_pgrp = 0, session = 1, tgid = 1370, leader = 0, 
  p_opptr = 0xc5f52000, p_pptr = 0xc5f52000, p_cptr = 0x0, p_ysptr = 0x0, 
  p_osptr = 0xc135c000, thread_group = {next = 0xc135a098, prev = 0xc135a098}, 
  pidhash_next = 0x0, pidhash_pprev = 0xc037493c, wait_chldexit = {lock = {
      lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
      last_lock_current = 0x0, last_lock_processor = 0}, task_list = {
      next = 0xc135a0bc, prev = 0xc135a0bc}}, vfork_sem = 0x0, 
  rt_priority = 0, it_real_value = 0, it_prof_value = 0, it_virt_value = 0, 
  it_real_incr = 0, it_prof_incr = 0, it_virt_incr = 0, real_timer = {list = {
      next = 0x0, prev = 0x0}, expires = 0, data = 3241517056, 
    function = 0xc011d648 <it_real_fn>}, times = {tms_utime = 0, 
    tms_stime = 0, tms_cutime = 0, tms_cstime = 0}, start_time = 6420, 
  per_cpu_utime = {0 <repeats 32 times>}, per_cpu_stime = {
    0 <repeats 32 times>}, min_flt = 0, maj_flt = 0, nswap = 0, cmin_flt = 0, 
  cmaj_flt = 0, cnswap = 0, swappable = -1, uid = 0, euid = 0, suid = 0, 
  fsuid = 0, gid = 0, egid = 0, sgid = 0, fsgid = 0, ngroups = 0, groups = {
---Type <return> to continue, or q <return> to quit---
    0 <repeats 32 times>}, cap_effective = 4294967039, cap_inheritable = 0, 
  cap_permitted = 4294967295, keep_capabilities = 0, user = 0xc02fc9d4, 
  rlim = {{rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 8388608, rlim_max = 4294967295}, {
      rlim_cur = 0, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 3072, rlim_max = 3072}, {
      rlim_cur = 1024, rlim_max = 1024}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}}, used_math = 1, 
  comm = "scsi_eh_0\000\000\000\000\000\000", link_count = 0, tty = 0x0, 
  locks = 0, semundo = 0x0, semsleeping = 0x0, thread = {esp0 = 3241525248, 
    eip = 3222356453, esp = 3241524852, fs = 24, gs = 24, debugreg = {0, 0, 0, 
      0, 0, 0, 0, 0}, cr2 = 0, trap_no = 0, error_code = 0, i387 = {fsave = {
        cwd = -64641, swd = -65536, twd = -1, fip = 0, fcs = 0, foo = 0, 
        fos = -65536, st_space = {0 <repeats 16 times>, -2146699776, 16405, 0, 
          0}, status = 0}, fxsave = {cwd = 895, swd = 65535, twd = 0, 
        fop = 65535, fip = -1, fcs = 0, foo = 0, fos = 0, mxcsr = -65536, 
        reserved = 0, st_space = {0 <repeats 15 times>, -2146699776, 16405, 
          0 <repeats 15 times>}, xmm_space = {0 <repeats 32 times>}, 
        padding = {0 <repeats 56 times>}}, soft = {cwd = -64641, swd = -65536, 
        twd = -1, fip = 0, fcs = 0, foo = 0, fos = -65536, st_space = {
          0 <repeats 16 times>, -2146699776, 16405, 0, 0}, ftop = 0 '\000', 
---Type <return> to continue, or q <return> to quit---
        changed = 0 '\000', lookahead = 0 '\000', no_update = 0 '\000', 
        rm = 0 '\000', alimit = 0 '\000', info = 0x0, entry_eip = 0}}, 
    vm86_info = 0x0, screen_bitmap = 0, v86flags = 0, v86mask = 0, 
    v86mode = 0, saved_esp0 = 0, ioperm = 0, io_bitmap = {4294967295, 
      0 <repeats 32 times>}}, fs = 0xc02f9440, files = 0xc02f9480, 
  sigmask_lock = {lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
    last_lock_current = 0x0, last_lock_processor = 0}, sig = 0xc145a080, 
  blocked = {sig = {4294967294, 4294967295}}, pending = {head = 0x0, 
    tail = 0xc135a668, signal = {sig = {0, 0}}}, sas_ss_sp = 0, 
  sas_ss_size = 0, notifier = 0, notifier_data = 0x0, notifier_mask = 0x0, 
  parent_exec_id = 0, self_exec_id = 0, alloc_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0114200, 
    last_lock_current = 0xc0312000, last_lock_processor = 0}}
(gdb) list *0xc0105d1c
0xc0105d1c is in __down (semaphore.c:80).
75				break;
76			}
77			sem->sleepers = 1;	/* us - see -1 above */
78			spin_unlock_irq(&semaphore_lock);
79	
80			schedule();
81			tsk->state = TASK_UNINTERRUPTIBLE;
82			spin_lock_irq(&semaphore_lock);
83		}
84		spin_unlock_irq(&semaphore_lock);
(gdb) list *0xc01061e4
0xc01061e4 is at af_packet.c:1878.
1873	{
1874		remove_proc_entry("net/packet", 0);
1875		unregister_netdevice_notifier(&packet_netdev_notifier);
1876		sock_unregister(PF_PACKET);
1877		return;
1878	}
1879	
1880	static int __init packet_init(void)
1881	{
1882		sock_register(&packet_family_ops);
(gdb) list *0xc01e9cf0
0xc01e9cf0 is in scsi_try_to_abort_command (scsi_error.c:775).
770			return SUCCESS;
771	
772		SCpnt->owner = SCSI_OWNER_LOWLEVEL;
773	
774		spin_lock_irqsave(&io_request_lock, flags);
775		rtn = SCpnt->host->hostt->eh_abort_handler(SCpnt);
776		spin_unlock_irqrestore(&io_request_lock, flags);
777		return rtn;
778	}
779	
(gdb) list *0xc0219f29
0xc0219f29 is in command_abort (scsiglue.c:198).
193			/* cancel the URB -- this will automatically wake the thread */
194			usb_unlink_urb(us->current_urb);
195	
196			/* wait for us to be done */
197			down(&(us->notify));
198			return SUCCESS;
199		}
200	
201		US_DEBUGP ("-- nothing to abort\n");
202		return FAILED;
(gdb) print $esp
$8 = -1067844024
(gdb) printf "%x\n", $esp
c059fe48
(gdb) printf "%x\n", $esp&(~8191)
c059e000
(gdb) set $current =$esp&(~8191)
(gdb) set $current =(struct task_struct *)$esp&(~8191)
Argument to arithmetic operation not a number or boolean.
(gdb) print (struct task_struct *)$current
$9 = (struct task_struct *) 0xc059e000
(gdb) print *(struct task_struct *)$current
$10 = {state = 0, flags = 1048576, sigpending = 0, addr_limit = {
    seg = 3221225472}, exec_domain = 0xc02fbc60, need_resched = 1, ptrace = 0, 
  lock_depth = -1, counter = 6, nice = 0, policy = 0, mm = 0xc24ed3e0, 
  has_cpu = 1, processor = 0, cpus_allowed = 4294967295, run_list = {
    next = 0xc02fbb40, prev = 0xc234003c}, sleep_time = 12739, 
  next_task = 0xc13bc000, prev_task = 0xc060c000, active_mm = 0xc24ed3e0, 
  binfmt = 0xc02fe0a4, exit_code = 0, exit_signal = 17, pdeath_signal = 0, 
  personality = 0, dumpable = -1, did_exec = -1, pid = 1411, pgrp = 1411, 
  tty_old_pgrp = 0, session = 1403, tgid = 1411, leader = 0, 
  p_opptr = 0xc060c000, p_pptr = 0xc060c000, p_cptr = 0xc13bc000, 
  p_ysptr = 0x0, p_osptr = 0x0, thread_group = {next = 0xc059e098, 
    prev = 0xc059e098}, pidhash_next = 0x0, pidhash_pprev = 0xc03749d8, 
  wait_chldexit = {lock = {lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
      last_lock_current = 0x0, last_lock_processor = 0}, task_list = {
      next = 0xc059e0bc, prev = 0xc059e0bc}}, vfork_sem = 0xc059ff80, 
  rt_priority = 0, it_real_value = 0, it_prof_value = 0, it_virt_value = 0, 
  it_real_incr = 0, it_prof_incr = 0, it_virt_incr = 0, real_timer = {list = {
      next = 0x0, prev = 0x0}, expires = 7151, data = 3227115520, 
    function = 0xc011d648 <it_real_fn>}, times = {tms_utime = 76, 
    tms_stime = 17, tms_cutime = 0, tms_cstime = 0}, start_time = 12261, 
  per_cpu_utime = {76, 0 <repeats 31 times>}, per_cpu_stime = {17, 
    0 <repeats 31 times>}, min_flt = 662, maj_flt = 1053, nswap = 0, 
  cmin_flt = 0, cmaj_flt = 0, cnswap = 0, swappable = -1, uid = 500, 
---Type <return> to continue, or q <return> to quit---
  euid = 500, suid = 500, fsuid = 500, gid = 500, egid = 500, sgid = 500, 
  fsgid = 500, ngroups = 2, groups = {500, 300, 0 <repeats 30 times>}, 
  cap_effective = 0, cap_inheritable = 0, cap_permitted = 0, 
  keep_capabilities = 0, user = 0xc4dc8f20, rlim = {{rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 8388608, 
      rlim_max = 4294967295}, {rlim_cur = 1024000000, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 3072, 
      rlim_max = 3072}, {rlim_cur = 1024, rlim_max = 1024}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}}, 
  used_math = 1, comm = "sol\000\000-terminal\000", link_count = 0, 
  tty = 0xc0613000, locks = 0, semundo = 0x0, semsleeping = 0x0, thread = {
    esp0 = 3227123712, eip = 3222356453, esp = 3227123520, fs = 0, gs = 0, 
    debugreg = {0, 0, 0, 0, 0, 0, 0, 0}, cr2 = 0, trap_no = 0, error_code = 0, 
    i387 = {fsave = {cwd = -64641, swd = -65248, twd = -1, fip = 1078387819, 
        fcs = 98041891, foo = 0, fos = -65493, st_space = {0, 0, 0, 0, 0, 0, 
          0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, status = 0}, 
      fxsave = {cwd = 895, swd = 65535, twd = 288, fop = 65535, fip = -1, 
        fcs = 1078387819, foo = 98041891, fos = 0, mxcsr = -65493, 
        reserved = 0, st_space = {0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 
          0 <repeats 23 times>}, xmm_space = {0 <repeats 32 times>}, 
        padding = {0 <repeats 56 times>}}, soft = {cwd = -64641, swd = -65248, 
---Type <return> to continue, or q <return> to quit---
        twd = -1, fip = 1078387819, fcs = 98041891, foo = 0, fos = -65493, 
        st_space = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0}, ftop = 0 '\000', changed = 0 '\000', 
        lookahead = 0 '\000', no_update = 0 '\000', rm = 0 '\000', 
        alimit = 0 '\000', info = 0x0, entry_eip = 0}}, vm86_info = 0x0, 
    screen_bitmap = 0, v86flags = 0, v86mask = 0, v86mode = 0, saved_esp0 = 0, 
    ioperm = 0, io_bitmap = {4294967295, 0 <repeats 32 times>}}, 
  fs = 0xc1318e20, files = 0xc060eac0, sigmask_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0124760, 
    last_lock_current = 0xc059e000, last_lock_processor = 0}, 
  sig = 0xc069f5a0, blocked = {sig = {0, 0}}, pending = {head = 0x0, 
    tail = 0xc059e668, signal = {sig = {0, 0}}}, sas_ss_sp = 0, 
  sas_ss_size = 0, notifier = 0, notifier_data = 0x0, notifier_mask = 0x0, 
  parent_exec_id = 10, self_exec_id = 11, alloc_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0114200, 
    last_lock_current = 0xc0d90000, last_lock_processor = 0}}
(gdb) where
#0  0xc01b76d9 in blk_get_queue (dev=769)
    at /home/baccala/src/linux-2.4.6-kgdb/include/asm/spinlock.h:103
#1  0xc01b8a3c in generic_make_request (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:904
#2  0xc01b8ae9 in submit_bh (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:946
#3  0xc01460be in block_read_full_page (page=0xc1158840, 
    get_block=0xc016f884 <ext2_get_block>) at buffer.c:1737
#4  0xc016fd65 in ext2_readpage (file=0xc05b1180, page=0xc1158840)
    at inode.c:583
#5  0xc012f078 in do_generic_file_read (filp=0xc05b1180, ppos=0xc05b11a0, 
    desc=0xc059ff88, actor=0xc012f324 <file_read_actor>) at filemap.c:1207
#6  0xc012f3ed in generic_file_read (filp=0xc05b1180, buf=0x8123438 "", 
    count=4096, ppos=0xc05b11a0) at filemap.c:1310
#7  0xc0141005 in sys_read (fd=8, buf=0x8123438 "", count=4096)
    at read_write.c:133
#8  0xc01077d7 in system_call () at af_packet.c:1878
#9  0x40474fef in ?? () at af_packet.c:1878
#10 0x4047505e in ?? () at af_packet.c:1878
#11 0x40482c89 in ?? () at af_packet.c:1878
#12 0x40482bd2 in ?? () at af_packet.c:1878
#13 0x40468a05 in ?? () at af_packet.c:1878
#14 0x4044cb4b in ?? () at af_packet.c:1878
#15 0x40468b04 in ?? () at af_packet.c:1878
#16 0x40462f63 in ?? () at af_packet.c:1878
---Type <return> to continue, or q <return> to quit---q
Quit
(gdb) print io_request_lock
$11 = {lock = 0, magic = 3735899821, last_lock_addr = 0xc01e9c60, 
  last_lock_current = 0xc135a000, last_lock_processor = 0}
(gdb) set io_request_lock->lock=1
(gdb) x/2i $pc
0xc01b76d9 <blk_get_queue+121>:	ud2a   
0xc01b76db <blk_get_queue+123>:	add    $0xc,%esp
(gdb) set $pc=$pc+2
(gdb) cont
Continuing.
86_info = 0x0, screen_bitmap = 0, v86flags = 0, v86mask = 0, 
    v86mode = 0, saved_esp0 = 0, ioperm = 0, io_bitmap = {4294967295, 
      0 <repeats 32 times>}}, fs = 0xc02f9440, files = 0xc02f9480, 
  sigmask_lock = {lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
    last_lock_current = 0x0, last_lock_processor = 0}, sig = 0xc145a080, 
  blocked = {sig = {4294967294, 4294967295}}, pending = {head = 0x0, 
    tail = 0xc135a668, signal = {sig = {0, 0}}}, sas_ss_sp = 0, 
  sas_ss_size = 0, notifier = 0, notifier_data = 0x0, notifier_mask = 0x0, 
  parent_exec_id = 0, self_exec_id = 0, alloc_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0114200, 
    last_lock_current = 0xc0312000, last_lock_processor = 0}}
(gdb) list *0xc0105d1c
0xc0105d1c is in __down (semaphore.c:80).
75				break;
76			}
77			sem->sleepers = 1;	/* us - see -1 above */
78			spin_unlock_irq(&semaphore_lock);
79	
80			schedule();
81			tsk->state = TASK_UNINTERRUPTIBLE;
82			spin_lock_irq(&semaphore_lock);
83		}
84		spin_unlock_irq(&semaphore_lock);
(gdb) list *0xc01061e4
0xc01061e4 is at af_packet.c:1878.
1873	{
1874		remove_proc_entry("net/packet", 0);
1875		unregister_netdevice_notifier(&packet_netdev_notifier);
1876		sock_unregister(PF_PACKET);
1877		return;
1878	}
1879	
1880	static int __init packet_init(void)
1881	{
1882		sock_register(&packet_family_ops);
(gdb) list *0xc01e9cf0
0xc01e9cf0 is in scsi_try_to_abort_command (scsi_error.c:775).
770			return SUCCESS;
771	
772		SCpnt->owner = SCSI_OWNER_LOWLEVEL;
773	
774		spin_lock_irqsave(&io_request_lock, flags);
775		rtn = SCpnt->host->hostt->eh_abort_handler(SCpnt);
776		spin_unlock_irqrestore(&io_request_lock, flags);
777		return rtn;
778	}
779	
(gdb) list *0xc0219f29
0xc0219f29 is in command_abort (scsiglue.c:198).
193			/* cancel the URB -- this will automatically wake the thread */
194			usb_unlink_urb(us->current_urb);
195	
196			/* wait for us to be done */
197			down(&(us->notify));
198			return SUCCESS;
199		}
200	
201		US_DEBUGP ("-- nothing to abort\n");
202		return FAILED;
(gdb) print $esp
$8 = -1067844024
(gdb) printf "%x\n", $esp
c059fe48
(gdb) printf "%x\n", $esp&(~8191)
c059e000
(gdb) set $current =$esp&(~8191)
(gdb) set $current =(struct task_struct *)$esp&(~8191)
Argument to arithmetic operation not a number or boolean.
(gdb) print (struct task_struct *)$current
$9 = (struct task_struct *) 0xc059e000
(gdb) print *(struct task_struct *)$current
$10 = {state = 0, flags = 1048576, sigpending = 0, addr_limit = {
    seg = 3221225472}, exec_domain = 0xc02fbc60, need_resched = 1, ptrace = 0, 
  lock_depth = -1, counter = 6, nice = 0, policy = 0, mm = 0xc24ed3e0, 
  has_cpu = 1, processor = 0, cpus_allowed = 4294967295, run_list = {
    next = 0xc02fbb40, prev = 0xc234003c}, sleep_time = 12739, 
  next_task = 0xc13bc000, prev_task = 0xc060c000, active_mm = 0xc24ed3e0, 
  binfmt = 0xc02fe0a4, exit_code = 0, exit_signal = 17, pdeath_signal = 0, 
  personality = 0, dumpable = -1, did_exec = -1, pid = 1411, pgrp = 1411, 
  tty_old_pgrp = 0, session = 1403, tgid = 1411, leader = 0, 
  p_opptr = 0xc060c000, p_pptr = 0xc060c000, p_cptr = 0xc13bc000, 
  p_ysptr = 0x0, p_osptr = 0x0, thread_group = {next = 0xc059e098, 
    prev = 0xc059e098}, pidhash_next = 0x0, pidhash_pprev = 0xc03749d8, 
  wait_chldexit = {lock = {lock = 1, magic = 3735899821, last_lock_addr = 0x0, 
      last_lock_current = 0x0, last_lock_processor = 0}, task_list = {
      next = 0xc059e0bc, prev = 0xc059e0bc}}, vfork_sem = 0xc059ff80, 
  rt_priority = 0, it_real_value = 0, it_prof_value = 0, it_virt_value = 0, 
  it_real_incr = 0, it_prof_incr = 0, it_virt_incr = 0, real_timer = {list = {
      next = 0x0, prev = 0x0}, expires = 7151, data = 3227115520, 
    function = 0xc011d648 <it_real_fn>}, times = {tms_utime = 76, 
    tms_stime = 17, tms_cutime = 0, tms_cstime = 0}, start_time = 12261, 
  per_cpu_utime = {76, 0 <repeats 31 times>}, per_cpu_stime = {17, 
    0 <repeats 31 times>}, min_flt = 662, maj_flt = 1053, nswap = 0, 
  cmin_flt = 0, cmaj_flt = 0, cnswap = 0, swappable = -1, uid = 500, 
---Type <return> to continue, or q <return> to quit---
  euid = 500, suid = 500, fsuid = 500, gid = 500, egid = 500, sgid = 500, 
  fsgid = 500, ngroups = 2, groups = {500, 300, 0 <repeats 30 times>}, 
  cap_effective = 0, cap_inheritable = 0, cap_permitted = 0, 
  keep_capabilities = 0, user = 0xc4dc8f20, rlim = {{rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 8388608, 
      rlim_max = 4294967295}, {rlim_cur = 1024000000, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 3072, 
      rlim_max = 3072}, {rlim_cur = 1024, rlim_max = 1024}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}}, 
  used_math = 1, comm = "sol\000\000-terminal\000", link_count = 0, 
  tty = 0xc0613000, locks = 0, semundo = 0x0, semsleeping = 0x0, thread = {
    esp0 = 3227123712, eip = 3222356453, esp = 3227123520, fs = 0, gs = 0, 
    debugreg = {0, 0, 0, 0, 0, 0, 0, 0}, cr2 = 0, trap_no = 0, error_code = 0, 
    i387 = {fsave = {cwd = -64641, swd = -65248, twd = -1, fip = 1078387819, 
        fcs = 98041891, foo = 0, fos = -65493, st_space = {0, 0, 0, 0, 0, 0, 
          0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, status = 0}, 
      fxsave = {cwd = 895, swd = 65535, twd = 288, fop = 65535, fip = -1, 
        fcs = 1078387819, foo = 98041891, fos = 0, mxcsr = -65493, 
        reserved = 0, st_space = {0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 
          0 <repeats 23 times>}, xmm_space = {0 <repeats 32 times>}, 
        padding = {0 <repeats 56 times>}}, soft = {cwd = -64641, swd = -65248, 
---Type <return> to continue, or q <return> to quit---
        twd = -1, fip = 1078387819, fcs = 98041891, foo = 0, fos = -65493, 
        st_space = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0}, ftop = 0 '\000', changed = 0 '\000', 
        lookahead = 0 '\000', no_update = 0 '\000', rm = 0 '\000', 
        alimit = 0 '\000', info = 0x0, entry_eip = 0}}, vm86_info = 0x0, 
    screen_bitmap = 0, v86flags = 0, v86mask = 0, v86mode = 0, saved_esp0 = 0, 
    ioperm = 0, io_bitmap = {4294967295, 0 <repeats 32 times>}}, 
  fs = 0xc1318e20, files = 0xc060eac0, sigmask_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0124760, 
    last_lock_current = 0xc059e000, last_lock_processor = 0}, 
  sig = 0xc069f5a0, blocked = {sig = {0, 0}}, pending = {head = 0x0, 
    tail = 0xc059e668, signal = {sig = {0, 0}}}, sas_ss_sp = 0, 
  sas_ss_size = 0, notifier = 0, notifier_data = 0x0, notifier_mask = 0x0, 
  parent_exec_id = 10, self_exec_id = 11, alloc_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0114200, 
    last_lock_current = 0xc0d90000, last_lock_processor = 0}}
(gdb) where
#0  0xc01b76d9 in blk_get_queue (dev=769)
    at /home/baccala/src/linux-2.4.6-kgdb/include/asm/spinlock.h:103
#1  0xc01b8a3c in generic_make_request (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:904
#2  0xc01b8ae9 in submit_bh (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:946
#3  0xc01460be in block_read_full_page (page=0xc1158840, 
    get_block=0xc016f884 <ext2_get_block>) at buffer.c:1737
#4  0xc016fd65 in ext2_readpage (file=0xc05b1180, page=0xc1158840)
    at inode.c:583
#5  0xc012f078 in do_generic_file_read (filp=0xc05b1180, ppos=0xc05b11a0, 
    desc=0xc059ff88, actor=0xc012f324 <file_read_actor>) at filemap.c:1207
#6  0xc012f3ed in generic_file_read (filp=0xc05b1180, buf=0x8123438 "", 
    count=4096, ppos=0xc05b11a0) at filemap.c:1310
#7  0xc0141005 in sys_read (fd=8, buf=0x8123438 "", count=4096)
    at read_write.c:133
#8  0xc01077d7 in system_call () at af_packet.c:1878
#9  0x40474fef in ?? () at af_packet.c:1878
#10 0x4047505e in ?? () at af_packet.c:1878
#11 0x40482c89 in ?? () at af_packet.c:1878
#12 0x40482bd2 in ?? () at af_packet.c:1878
#13 0x40468a05 in ?? () at af_packet.c:1878
#14 0x4044cb4b in ?? () at af_packet.c:1878
#15 0x40468b04 in ?? () at af_packet.c:1878
#16 0x40462f63 in ?? () at af_packet.c:1878
---Type <return> to continue, or q <return> to quit---q
Quit
(gdb) print io_request_lock
$11 = {lock = 0, magic = 3735899821, last_lock_addr = 0xc01e9c60, 
  last_lock_current = 0xc135a000, last_lock_processor = 0}
(gdb) set io_request_lock->lock=1
(gdb) x/2i $pc
0xc01b76d9 <blk_get_queue+121>:	ud2a   
0xc01b76db <blk_get_queue+123>:	add    $0xc,%esp
(gdb) set $pc=$pc+2
(gdb) cont
Continuing.
, nswap = 0, 
  cmin_flt = 0, cmaj_flt = 0, cnswap = 0, swappable = -1, uid = 500, 
---Type <return> to continue, or q <return> to quit---
  euid = 500, suid = 500, fsuid = 500, gid = 500, egid = 500, sgid = 500, 
  fsgid = 500, ngroups = 2, groups = {500, 300, 0 <repeats 30 times>}, 
  cap_effective = 0, cap_inheritable = 0, cap_permitted = 0, 
  keep_capabilities = 0, user = 0xc4dc8f20, rlim = {{rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 8388608, 
      rlim_max = 4294967295}, {rlim_cur = 1024000000, rlim_max = 4294967295}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 3072, 
      rlim_max = 3072}, {rlim_cur = 1024, rlim_max = 1024}, {
      rlim_cur = 4294967295, rlim_max = 4294967295}, {rlim_cur = 4294967295, 
      rlim_max = 4294967295}, {rlim_cur = 4294967295, rlim_max = 4294967295}}, 
  used_math = 1, comm = "sol\000\000-terminal\000", link_count = 0, 
  tty = 0xc0613000, locks = 0, semundo = 0x0, semsleeping = 0x0, thread = {
    esp0 = 3227123712, eip = 3222356453, esp = 3227123520, fs = 0, gs = 0, 
    debugreg = {0, 0, 0, 0, 0, 0, 0, 0}, cr2 = 0, trap_no = 0, error_code = 0, 
    i387 = {fsave = {cwd = -64641, swd = -65248, twd = -1, fip = 1078387819, 
        fcs = 98041891, foo = 0, fos = -65493, st_space = {0, 0, 0, 0, 0, 0, 
          0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, status = 0}, 
      fxsave = {cwd = 895, swd = 65535, twd = 288, fop = 65535, fip = -1, 
        fcs = 1078387819, foo = 98041891, fos = 0, mxcsr = -65493, 
        reserved = 0, st_space = {0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 
          0 <repeats 23 times>}, xmm_space = {0 <repeats 32 times>}, 
        padding = {0 <repeats 56 times>}}, soft = {cwd = -64641, swd = -65248, 
---Type <return> to continue, or q <return> to quit---
        twd = -1, fip = 1078387819, fcs = 98041891, foo = 0, fos = -65493, 
        st_space = {0, 0, 0, 0, 0, 0, 0, 0, 0, 1073709056, 0, 0, 0, 0, 0, 0, 
          0, 0, 0, 0}, ftop = 0 '\000', changed = 0 '\000', 
        lookahead = 0 '\000', no_update = 0 '\000', rm = 0 '\000', 
        alimit = 0 '\000', info = 0x0, entry_eip = 0}}, vm86_info = 0x0, 
    screen_bitmap = 0, v86flags = 0, v86mask = 0, v86mode = 0, saved_esp0 = 0, 
    ioperm = 0, io_bitmap = {4294967295, 0 <repeats 32 times>}}, 
  fs = 0xc1318e20, files = 0xc060eac0, sigmask_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0124760, 
    last_lock_current = 0xc059e000, last_lock_processor = 0}, 
  sig = 0xc069f5a0, blocked = {sig = {0, 0}}, pending = {head = 0x0, 
    tail = 0xc059e668, signal = {sig = {0, 0}}}, sas_ss_sp = 0, 
  sas_ss_size = 0, notifier = 0, notifier_data = 0x0, notifier_mask = 0x0, 
  parent_exec_id = 10, self_exec_id = 11, alloc_lock = {lock = 1, 
    magic = 3735899821, last_lock_addr = 0xc0114200, 
    last_lock_current = 0xc0d90000, last_lock_processor = 0}}
(gdb) where
#0  0xc01b76d9 in blk_get_queue (dev=769)
    at /home/baccala/src/linux-2.4.6-kgdb/include/asm/spinlock.h:103
#1  0xc01b8a3c in generic_make_request (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:904
#2  0xc01b8ae9 in submit_bh (rw=0, bh=0xc3e38d40) at ll_rw_blk.c:946
#3  0xc01460be in block_read_full_page (page=0xc1158840, 
    get_block=0xc016f884 <ext2_get_block>) at buffer.c:1737
#4  0xc016fd65 in ext2_readpage (file=0xc05b1180, page=0xc1158840)
    at inode.c:583
#5  0xc012f078 in do_generic_file_read (filp=0xc05b1180, ppos=0xc05b11a0, 
    desc=0xc059ff88, actor=0xc012f324 <file_read_actor>) at filemap.c:1207
#6  0xc012f3ed in generic_file_read (filp=0xc05b1180, buf=0x8123438 "", 
    count=4096, ppos=0xc05b11a0) at filemap.c:1310
#7  0xc0141005 in sys_read (fd=8, buf=0x8123438 "", count=4096)
    at read_write.c:133
#8  0xc01077d7 in system_call () at af_packet.c:1878
#9  0x40474fef in ?? () at af_packet.c:1878
#10 0x4047505e in ?? () at af_packet.c:1878
#11 0x40482c89 in ?? () at af_packet.c:1878
#12 0x40482bd2 in ?? () at af_packet.c:1878
#13 0x40468a05 in ?? () at af_packet.c:1878
#14 0x4044cb4b in ?? () at af_packet.c:1878
#15 0x40468b04 in ?? () at af_packet.c:1878
#16 0x40462f63 in ?? () at af_packet.c:1878
---Type <return> to continue, or q <return> to quit---q
Quit
(gdb) print io_request_lock
$11 = {lock = 0, magic = 3735899821, last_lock_addr = 0xc01e9c60, 
  last_lock_current = 0xc135a000, last_lock_processor = 0}
(gdb) set io_request_lock->lock=1
(gdb) x/2i $pc
0xc01b76d9 <blk_get_queue+121>:	ud2a   
0xc01b76db <blk_get_queue+123>:	add    $0xc,%esp
(gdb) set $pc=$pc+2
(gdb) cont
Continuing.


--------------AC12D36791113BB38F081CD1--

