Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbUJ1MCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbUJ1MCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbUJ1MBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:01:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15058 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262999AbUJ1L4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:56:15 -0400
Date: Thu, 28 Oct 2004 13:57:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Karsten Wiese <annabellesgarden@yahoo.de>
Subject: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.5
Message-ID: <20041028115719.GA9563@elte.hu>
References: <20041020094508.GA29080@elte.hu> <20041021132717.GA29153@elte.hu> <20041022133551.GA6954@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <20041025104023.GA1960@elte.hu> <20041027001542.GA29295@elte.hu> <417F7D7D.5090205@stud.feec.vutbr.cz> <20041027134822.GA7980@elte.hu> <417FD9F2.8060002@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417FD9F2.8060002@stud.feec.vutbr.cz>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Schmidt <xschmi00@stud.feec.vutbr.cz> wrote:

> > i've uploaded -V0.4.1 with a fix that could fix this networking
> > deadlock. Does it work any better?
> 
> Unfortunately, no. It's only slightly different:

ok. I've uploaded -RT-V0.5 which includes a different approach to
solving these netfilter related deadlocks. It can be downloaded from the 
usual place:

	http://redhat.com/~mingo/realtime-preempt/

there's a fair chance that you will still see a deadlock, so in -V0.5
i've improved the deadlock-detection infrastructure with a number of new
debugging features:

 - track the code (by EIP) that acquired the semaphore

 - track the place (by file:line) where the locking object got defined
   or initialized. Print this symbolic info out when printing locking 
   objects - this is easier to read than the hexa address alone.

 - added a global registry for all mutexes, rwsems, spinlocks and
   rwlocks, which registry is printed during the deadlock-printout. 
   (including the current holder of the lock and the place where the
   lock was acquired.)

 - print out all the locks held by the task(s) involved in any deadlock
   scenario.

 - print out a summary of all tasks in the system, whether they are
   blocked on a locking object, and if they are, on which lock.

 - the 'all locks' and 'all tasks' printout can also be triggered via
   sysrq-d or 'echo d > /proc/sysrq-trigger'.

 - turn off deadlock tracing when the first deadlock has been detected. 
   This is to get a more robust printout of a stable locking state and
   usually it's the first deadlock that matters so there's no point in
   printing out more.

 - cleaned up formatting of various existing printouts like the 
   preemption backtrace and messages from the deadlock detector.

all this info will greatly simplify the tracking down of deadlocks. 
There is no additional configuration needed to active the above
features, other than to enable CONFIG_RWSEM_DEADLOCK_DETECT. Below i've
attached a sample printout.

	Ingo


down()-ing unlocked semaphore. should succeed.
good. now down()ing locked semaphore. should deadlock.

===============================================
[ BUG: semaphore recursion deadlock detected! ]
-----------------------------------------------
already locked:  [c065eee0] {r:0,a:-1,kernel/time.c:100}
.. held by:      gettimeofday/ 3008 [f1b374c0]
... acquired at:  sys_gettimeofday+0xfa/0x3f8

-{backtrace}--------------------------------->
 [<c0241d47>] __rwsem_deadlock+0xf9/0x188 (12)
 [<c011f1eb>] sys_gettimeofday+0xfa/0x3f8 (8)
 [<c058f68e>] _down_write+0xe/0x325 (16)
 [<c011f201>] sys_gettimeofday+0x110/0x3f8 (4)
 [<c011f201>] sys_gettimeofday+0x110/0x3f8 (20)
 [<c058f7e0>] _down_write+0x160/0x325 (8)
 [<c0130903>] __mcount+0x1d/0x1f (16)
 [<c0242561>] down+0x8/0x11 (4)
 [<c011f201>] sys_gettimeofday+0x110/0x3f8 (4)
 [<c011f201>] sys_gettimeofday+0x110/0x3f8 (36)
 [<c014d641>] sys_munmap+0x42/0x4b (12)
 [<c010601d>] sysenter_past_esp+0x52/0x71 (28)
---------------------------
| preempt count: 00000002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c058f8bd>] .... _down_write+0x23d/0x325
.....[<c011f201>] ..   ( <= sys_gettimeofday+0x110/0x3f8)
.. [<c0131be1>] .... print_traces+0x1b/0x5a
.....[<c0106608>] ..   ( <= dump_stack+0x23/0x25)


------------------------------
| showing all locks held by: |  (gettimeofday/3008 [f1b374c0]):
------------------------------

#001:             [c065eee0] {r:0,a:-1,kernel/time.c:100}
... acquired at:  sys_gettimeofday+0xfa/0x3f8

showing all tasks:
s            init/    1 [c2a77080] (not blocked)
s     ksoftirqd/0/    2 [c2a76850] (not blocked)
s       desched/0/    3 [c2a76020] (not blocked)
s        events/0/    4 [c2a950c0] (not blocked)
s         khelper/    5 [c2a94890] (not blocked)
s         kthread/   10 [c2a94060] (not blocked)
s          kacpid/   18 [c2ab1100] (not blocked)
s           IRQ 9/   19 [c2ab08d0] (not blocked)
s       kblockd/0/   94 [c2ab00a0] (not blocked)
s           khubd/  107 [f7cf1140] (not blocked)
s         pdflush/  330 [f7cf0910] (not blocked)
s         pdflush/  331 [f7cf00e0] (not blocked)
s           aio/0/  333 [f7d56950] (not blocked)
s         kswapd0/  332 [f7d57180] (not blocked)
s           IRQ 8/  918 [f7d56120] (not blocked)
s          IRQ 12/  931 [f7eca990] (not blocked)
s         kseriod/  925 [f7ecb1c0] (not blocked)
s           IRQ 6/  946 [f7eca160] (not blocked)
s           IRQ 5/  978 [f7f01200] (not blocked)
s          IRQ 14/  997 [f7f009d0] (not blocked)
s          IRQ 15/  999 [f7f001a0] (not blocked)
s        khpsbpkt/ 1013 [f7f51240] (not blocked)
s          IRQ 11/ 1024 [f7f50a10] (not blocked)
s     knodemgrd_0/ 1025 [f7f501e0] (not blocked)
s           IRQ 1/ 1131 [f7f91280] (not blocked)
s          IRQ 10/ 1169 [f7f90a50] (not blocked)
D       kjournald/ 1180 [f7f90220] (not blocked)
s           udevd/ 1242 [f5ec76c0] (not blocked)
s           IRQ 4/ 1615 [f610c2e0] (not blocked)
s           IRQ 3/ 1616 [f59f0a50] (not blocked)
D         syslogd/ 2503 [f5d6ad90] (not blocked)
s           klogd/ 2507 [f610d340] (not blocked)
s         portmap/ 2526 [f5ae0120] (not blocked)
s   mDNSResponder/ 2559 [f63aa420] (not blocked)
s   mDNSResponder/ 2560 [f2bc6b90] (not blocked)
s           acpid/ 2580 [f2af9340] (not blocked)
s            sshd/ 2590 [f2af82e0] (not blocked)
s         distccd/ 2619 [f610cb10] (not blocked)
s         distccd/ 2620 [f59f0220] (not blocked)
s             gpm/ 2630 [f2b6cb50] (not blocked)
s           crond/ 2640 [f2af8b10] (not blocked)
s            sshd/ 2653 [f5a59100] (not blocked)
s         distccd/ 2656 [f5ae0950] (not blocked)
s            sshd/ 2667 [f5a580a0] (not blocked)
s             xfs/ 2670 [f5ec6660] (not blocked)
s            bash/ 2672 [f2bc73c0] (not blocked)
s         anacron/ 2704 [f5ec6e90] (not blocked)
s         distccd/ 2706 [f2b6c320] (not blocked)
s             atd/ 2714 [f59f1280] (not blocked)
s   dbus-daemon-1/ 2724 [f2bc6360] (not blocked)
s cups-config-dae/ 2734 [f63aac50] (not blocked)
s          agetty/ 2748 [f5a588d0] (not blocked)
s        mingetty/ 2749 [f5d6b5c0] (not blocked)
s        mingetty/ 2750 [f63ab480] (not blocked)
s        mingetty/ 2751 [f1a73400] (not blocked)
s        mingetty/ 2752 [f1a72bd0] (not blocked)
s        mingetty/ 2753 [f2b6d380] (not blocked)
s        mingetty/ 2754 [f1a723a0] (not blocked)
s         hotplug/ 2839 [f1b36460] (not blocked)
s         hotplug/ 2856 [f14e6d90] (not blocked)
s         hotplug/ 2857 [f155d600] (not blocked)
s 10-udev.hotplug/ 2916 [f1b36c90] (not blocked)
s 10-udev.hotplug/ 2917 [f14e75c0] (not blocked)
s 10-udev.hotplug/ 2918 [f14e6560] (not blocked)
s            udev/ 2959 [f1629680] (not blocked)
s            udev/ 2965 [f1702ed0] (not blocked)
s            udev/ 2981 [f17d5780] (not blocked)
s            udev/ 2987 [f11240a0] (not blocked)
D    gettimeofday/ 3008 [f1b374c0] (not blocked)

---------------------------
| showing all locks held: |
---------------------------

#001:             [c07f809c] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#002:             [c07f7bb4] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#003:             [c07f7e0c] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#004:             [c07f8890] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#005:             [c07f83a8] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#006:             [c07f8600] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#007:             [c07f9084] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#008:             [c07f8b9c] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#009:             [c07f8df4] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#010:             [c07f9878] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#011:             [c07f9390] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#012:             [c07f95e8] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#013:             [c07fa06c] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#014:             [c07f9b84] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#015:             [c07f9ddc] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#016:             [c07fa860] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#017:             [c07fa378] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#018:             [c07fa5d0] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#019:             [c07fb054] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#020:             [c07fab6c] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#021:             [c07fadc4] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#022:             [c07fb848] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#023:             [c07fb360] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#024:             [c07fb5b8] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#025:             [c07fc03c] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#026:             [c07fbb54] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#027:             [c07fbdac] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#028:             [c07fc830] {r:0,a:-1,drivers/ide/ide.c:228}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x8b/0x15c

#029:             [c07fc348] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#030:             [c07fc5a0] {r:0,a:-1,drivers/ide/ide.c:252}
.. held by:              init/    1 [c2a77080]
... acquired at:  init_hwif_data+0x14b/0x15c

#031:             [c06a8f40] {r:0,a:-1,drivers/ieee1394/nodemgr.c:111}
.. held by:       knodemgrd_0/ 1025 [f7f501e0]
... acquired at:  nodemgr_host_thread+0x89/0x186

#032:             [f2b7cfcc] {r:0,a:-1,drivers/char/tty_io.c:2641}
.. held by:          mingetty/ 2749 [f5d6b5c0]
... acquired at:  read_chan+0x471/0x7a2

#033:             [f1ba4fcc] {r:0,a:-1,drivers/char/tty_io.c:2641}
.. held by:          mingetty/ 2751 [f1a73400]
... acquired at:  read_chan+0x471/0x7a2

#034:             [f157efcc] {r:0,a:-1,drivers/char/tty_io.c:2641}
.. held by:          mingetty/ 2754 [f1a723a0]
... acquired at:  read_chan+0x471/0x7a2

#035:             [f1722fcc] {r:0,a:-1,drivers/char/tty_io.c:2641}
.. held by:          mingetty/ 2752 [f1a72bd0]
... acquired at:  read_chan+0x471/0x7a2

#036:             [f10dafcc] {r:0,a:-1,drivers/char/tty_io.c:2641}
.. held by:          mingetty/ 2753 [f2b6d380]
... acquired at:  read_chan+0x471/0x7a2

#037:             [f150efcc] {r:0,a:-1,drivers/char/tty_io.c:2641}
.. held by:          mingetty/ 2750 [f63ab480]
... acquired at:  read_chan+0x471/0x7a2

#038:             [f1a92fcc] {r:0,a:-1,drivers/char/tty_io.c:2641}
.. held by:            agetty/ 2748 [f5a588d0]
... acquired at:  read_chan+0x471/0x7a2

#039:             [f2a11ba4] {r:0,a:-1,fs/inode.c:198}
.. held by:           syslogd/ 2503 [f5d6ad90]
... acquired at:  sys_fsync+0x56/0xb7

#040:             [c065eee0] {r:0,a:-1,kernel/time.c:100}
.. held by:      gettimeofday/ 3008 [f1b374c0]
... acquired at:  sys_gettimeofday+0xfa/0x3f8

#041:             [c0748a00] {r:0,a:-1,kernel/fork.c:64}
.. held by:      gettimeofday/ 3008 [f1b374c0]
... acquired at:  show_all_locks+0x30/0x148
=============================================

