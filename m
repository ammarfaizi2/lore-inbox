Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932699AbWCICTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932699AbWCICTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 21:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932706AbWCICTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 21:19:32 -0500
Received: from smtp3.Stanford.EDU ([171.67.16.138]:11969 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932699AbWCICTb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 21:19:31 -0500
Subject: Re: 2.6.15-rt20, "bad page state", jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>
Cc: carrlane@ccrma.Stanford.EDU, nando@ccrma.Stanford.EDU,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1141864232.5262.47.camel@cmn3.stanford.edu>
References: <1141846564.5262.20.camel@cmn3.stanford.edu>
	 <1141854504.5262.36.camel@cmn3.stanford.edu>
	 <1141864232.5262.47.camel@cmn3.stanford.edu>
Content-Type: multipart/mixed; boundary="=-5XQvD7tp3Bd9/zY1rucg"
Date: Wed, 08 Mar 2006 18:19:15 -0800
Message-Id: <1141870755.5262.61.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5XQvD7tp3Bd9/zY1rucg
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-03-08 at 16:30 -0800, Fernando Lopez-Lezcano wrote:
> On Wed, 2006-03-08 at 13:48 -0800, Fernando Lopez-Lezcano wrote:
> > On Wed, 2006-03-08 at 11:36 -0800, Fernando Lopez-Lezcano wrote:
> > > Hi all, I reported this in mid January (I thought I had sent to the list
> > > but the report went to Ingo and Steven off list)
> > > 
> > > I'm seeing the same problem in 2.6.15-rt21 in some of my machines. After
> > > a reboot into the kernel I just login as root in a terminal, start the
> > > jackd sound server ("jackd -d alsa -d hw") and when stopping it (just
> > > doing a <ctrl>c) I get a bunch of messages of this form:
> > > 
> > > > Trying to fix it up, but a reboot is needed
> > > > Bad page state at __free_pages_ok (in process 'jackd', page c10012fc)
> > > 
> > > Has anyone else seen this?
> > > 
> > > I'm in the process of building an -rt21 kernel before posting more
> > > detailed error messages (this kernel is patched with some additional
> > > stuff). 
> > 
> > This is what the errors look like (I'm attaching the whole dmesg output
> > and the .config file used to build the smp kernel):
> > 
> > Bad page state at __free_pages_ok (in process 'jackd', page c1013ce0)
> > flags:0x00000414 mapping:00000000 mapcount:0 count:0
> > Backtrace:
> >  [<c015947d>] bad_page+0x7d/0xc0 (8)
> >  [<c01598fd>] __free_pages_ok+0x9d/0x180 (36)
> >  [<c015a5ac>] __pagevec_free+0x3c/0x50 (40)
> >  [<c015db47>] release_pages+0x127/0x1a0 (16)
> >  [<c016c93d>] free_pages_and_swap_cache+0x7d/0xc0 (80)
> >  [<c01681ae>] unmap_region+0x13e/0x160 (28)
> >  [<c0168461>] do_munmap+0xe1/0x120 (48)
> >  [<c01684df>] sys_munmap+0x3f/0x60 (32)
> >  [<c01034a1>] syscall_call+0x7/0xb (16)
> > Trying to fix it up, but a reboot is needed
> 
> [MUNCH]
> 
> > I'm now building another -rt21 with DEBUG_PAGEALLOC and DEBUG_SLAB
> > enabled to see if I can pinpoint in more detail what's happening (if I
> > can get it to boot!). 
> 
> I'm not able to boot with those two options enabled. It looks like it is
> hanging after loading the sound drivers - this is on top of fc4. I can't
> even get to single user and I'm searching for a serial cable right now
> to see if I can get more information in a way that can be posted here. 
> Arghhh :-)

A kind soul (thanks Carr!) made the proper null modem cable for me...

So, I'm attaching the result of <ctrl><sys>T when the machine is hung.
This is when trying to boot single user into -rt21 with the previously
posted .config and DEBUG_PAGEALLOC and DEBUG_SLAB enabled. Without those
two options the kernel boots but I get the aforementioned errors when
stopping jackd.

Let me know if I could try something else. 
-- Fernando


--=-5XQvD7tp3Bd9/zY1rucg
Content-Disposition: attachment; filename=dump.txt
Content-Type: text/plain; name=dump.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

SysRq : Changing Loglevel
Loglevel set to 9
SysRq : Show State

                                               sibling
  task             PC      pid father child younger older
hm, tasklist_lock write-locked.
ignoring ...
init          [f7eb4a70]D 00000000  5896     1      0     2               (NOTLB)
f7eb7eec 00000000 00000000 00000000 c1c6d6bc f2c27c73 0000000d 00000642 
       f7eb4ba8 f7eb4a70 c03dfc40 c1f0f160 f2c986a3 0000000d 00000000 00000002 
       f7eb6000 00800100 ffffffff f7eb7f14 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0176cac>] kfree+0x2c/0x80 (80)
 [<c018efaf>] sys_select+0x2ff/0x3c0 (16)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (64)
migration/0   [f7e00a70]S F7E03F78  7676     2      1             3       (L-TLB)
f7e03f7c f757fa70 00000076 f7e03f78 c01211a1 2e251b80 0000000d 00001451 
       f7e00ba8 f7e00a70 f7544a70 c1f0f160 2e316fc5 0000000d f7e03f84 c011f473 
       f7e02000 c1f0f160 00000000 f7e03fa4 c037ffc5 f5301f4c f5301f48 f5301f4c 
Call Trace:
 [<c01211a1>] move_tasks+0x181/0x300 (20)
 [<c011f473>] activate_task+0xa3/0x100 (44)
 [<c037ffc5>] schedule+0xa5/0x120 (20)
 [<c01228ef>] complete+0x3f/0x70 (16)
 [<c0123f3c>] migration_thread+0x12c/0x1b0 (24)
 [<c01228ef>] complete+0x3f/0x70 (12)
 [<c0123e10>] migration_thread+0x0/0x1b0 (20)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-high/ [f7e06a70]S F7E06A70  7552     3      1             4     2 (L-TLB)
f7e09f6c ffffffff ffffffff f7e06a70 f7e09f50 51387f00 00000009 00001eaf 
       f7e06ba8 f7e06a70 f7e0ba70 c1f0f160 513c5d73 00000009 c1f0f1ac 0000007d 
       f7e08000 00000001 c1f0ffe0 f7e09f94 c037ffc5 00000246 00000003 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (24)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-timer [f7e0ba70]R 00000006 [on rq #0]  7560     4      1             5     3 (L-TLB)
f7e0df6c c010b5b0 00000001 00000006 c1f10224 be51147a 00000093 000008d0 
       f7e0bba8 f7e0ba70 c03dfc40 c1f0f160 be511fa6 00000093 00000518 00000002 
       f7e0c000 c0499380 c1f10018 f7e0df94 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c010b5b0>] tsc_update_callback+0x0/0xc0 (8)
 [<c037ffc5>] schedule+0xa5/0x120 (76)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (32)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-net-t [f7e10a70]S F7E10A70  7696     5      1             6     4 (L-TLB)
f7e13f6c ffffffff ffffffff f7e10a70 f7e13f50 513edda7 00000009 00000cc5 
       f7e10ba8 f7e10a70 f7e15a70 c1f0f160 513fdeb8 00000009 c1f0f1ac 0000007d 
       f7e12000 00000001 c1f10050 f7e13f94 c037ffc5 00000246 00000005 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (24)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-net-r [f7e15a70]S 00000383  7684     6      1             7     5 (L-TLB)
f7e17f6c f5a36380 00100100 00000383 f7e1007b 7fea7bed 00000034 00000daf 
       f7e15ba8 f7e15a70 f7e24a70 c1f0f160 7ff04a2a 00000034 f7e17f84 00000001 
       f7e16000 c0499380 c1f10088 f7e17f94 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (32)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-scsi/ [f7e1aa70]S F7E1AA70  7696     7      1             8     6 (L-TLB)
f7e1df6c ffffffff ffffffff f7e1aa70 f7e1df50 513edda7 00000009 00000a15 
       f7e1aba8 f7e1aa70 f7e1fa70 c1f0f160 513ff381 00000009 c1f0f1ac 0000007d 
       f7e1c000 00000001 c1f100c0 f7e1df94 c037ffc5 00000246 00000007 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (24)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-taskl [f7e1fa70]R F765EDA8 [on rq #0]  7400     8      1             9     7 (L-TLB)
f7e21f6c c1f115c0 00000001 f765eda8 f7e21f3c bd2fa196 00000093 00000952 
       f7e1fba8 f7e1fa70 f7e24a70 c1f0f160 bd383639 00000093 00000000 00000001 
       f7e20000 c0499380 c1f100f8 f7e21f94 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (32)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-hrtim [f7e24a70]D 00000001  7552     9      1            10     8 (L-TLB)
f7e27edc 01a74f60 c011f473 00000001 00000000 bd2fa196 00000093 00000ef8 
       f7e24ba8 f7e24a70 c03dfc40 c1f0f160 bd384531 00000093 f7c05a70 00000002 
       f7e26000 0100a140 ffffffff f7e27f04 c037ffc5 c0142fbe 00000004 00000000 
Call Trace:
 [<c011f473>] activate_task+0xa3/0x100 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (72)
 [<c0142fbe>] task_blocks_on_lock+0x11e/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c013527e>] send_group_sig_info+0x1e/0x50 (80)
 [<c012cce0>] it_real_fn+0x0/0x60 (8)
 [<c012ccfd>] it_real_fn+0x1d/0x60 (8)
 [<c012cce0>] it_real_fn+0x0/0x60 (8)
 [<c0142824>] run_hrtimer_softirq+0x84/0x110 (4)
 [<c012e8e7>] ksoftirqd+0x147/0x240 (36)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
watchdog/0    [f7e29a70]S 00000200  7760    10      1            11     9 (L-TLB)
f7e2bf94 00000001 c01e037a 00000200 f7e2bf64 513edda7 00000009 000009b5 
       f7e29ba8 f7e29a70 f7e2ea70 c1f0f160 514152e6 00000009 00000001 c1f0f160 
       f7e2a000 f7eb7f18 00000000 f7e2bfbc c037ffc5 0000007d ffffffff c1f0f1ac 
Call Trace:
 [<c01e037a>] avc_has_perm+0x5a/0x70 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (72)
 [<c0152bc0>] watchdog+0x0/0x60 (36)
 [<c0152c03>] watchdog+0x43/0x60 (4)
 [<c013e78c>] kthread+0xac/0xb0 (12)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
desched/0     [f7e2ea70]S F71C0000  7436    11      1            12    10 (L-TLB)
f7e31f94 00000000 00000000 f71c0000 c0175f95 32d892f3 0000000d 000011da 
       f7e2eba8 f7e2ea70 f754ea70 c1f0f160 32e167b6 0000000d f7e31fa0 c21df300 
       f7e30000 f7e30000 00000000 f7e31fbc c037ffc5 c0176c63 00000000 f7e30000 
Call Trace:
 [<c0175f95>] cache_free_debugcheck+0x245/0x2b0 (20)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c0176c63>] kmem_cache_free+0x53/0x70 (4)
 [<c01277b0>] desched_thread+0x0/0x80 (32)
 [<c01277fe>] desched_thread+0x4e/0x80 (4)
 [<c013e78c>] kthread+0xac/0xb0 (12)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
migration/1   [f7e33a70]S 00000004  7688    12      1            13    11 (L-TLB)
f7e35f7c 00000001 00000293 00000004 c1f1fae0 2babe609 0000000d 000012f0 
       f7e33ba8 f7e33a70 f764da70 c1f1f160 2bb15780 0000000d f7e35f84 c011f473 
       f7e34000 c1f1f160 00000001 f7e35fa4 c037ffc5 f5153f4c f5153f48 f5153f4c 
Call Trace:
 [<c011f473>] activate_task+0xa3/0x100 (64)
 [<c037ffc5>] schedule+0xa5/0x120 (20)
 [<c01228ef>] complete+0x3f/0x70 (16)
 [<c0123f3c>] migration_thread+0x12c/0x1b0 (24)
 [<c01228ef>] complete+0x3f/0x70 (12)
 [<c0123e10>] migration_thread+0x0/0x1b0 (20)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-high/ [f7e67a70]S F7E67A70  7696    13      1            14    12 (L-TLB)
f7e69f6c ffffffff ffffffff f7e67a70 f7e69f50 00000000 00000000 0000025d 
       f7e67ba8 f7e67a70 f7e6ca70 c1f1f160 51646848 00000009 c1f1f1ac 00000073 
       f7e68000 00000001 c1f1ffe0 f7e69f94 c037ffc5 00000246 0000000d 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (24)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-timer [f7e6ca70]S 00000006  7576    14      1            15    13 (L-TLB)
f7e6ff6c f7ee3f28 00000001 00000006 c1f20224 594d805b 00000094 00000169 
       f7e6cba8 f7e6ca70 f7eb9a70 c1f1f160 5a8d7ad7 00000094 00000750 00000001 
       f7e6e000 c0499380 c1f20018 f7e6ff94 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (32)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-net-t [f7e71a70]S F7E71A70  7696    15      1            16    14 (L-TLB)
f7e73f6c ffffffff ffffffff f7e71a70 f7e73f50 00000000 00000000 0000015b 
       f7e71ba8 f7e71a70 f7e76a70 c1f1f160 5164840f 00000009 c1f1f1ac 00000073 
       f7e72000 00000001 c1f20050 f7e73f94 c037ffc5 00000246 0000000f 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (24)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-net-r [f7e76a70]S F7E76A70  7696    16      1            17    15 (L-TLB)
f7e79f6c ffffffff ffffffff f7e76a70 f7e79f50 00000000 00000000 00000105 
       f7e76ba8 f7e76a70 f7e7ba70 c1f1f160 51648e46 00000009 c1f1f1ac 00000073 
       f7e78000 00000001 c1f20088 f7e79f94 c037ffc5 00000246 00000010 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (24)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-scsi/ [f7e7ba70]S F7E7BA70  7696    17      1            18    16 (L-TLB)
f7e7df6c ffffffff ffffffff f7e7ba70 f7e7df50 00000000 00000000 00000102 
       f7e7bba8 f7e7ba70 f7c00a70 c1f1f160 51649860 00000009 c1f1f1ac 00000073 
       f7e7c000 00000001 c1f200c0 f7e7df94 c037ffc5 00000246 00000011 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c012e975>] ksoftirqd+0x1d5/0x240 (24)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-taskl [f7c00a70]D 00000001  7488    18      1            19    17 (L-TLB)
f7c03ed8 376fd163 00000000 00000001 00000001 33a54edb 0000000d 0000024c 
       f7c00ba8 f7c00a70 f757fa70 c1f1f160 33a576b8 0000000d f757fa70 f757ff8c 
       f7c02000 0100a140 ffffffff f7c03f00 c037ffc5 c0142fbe 00000004 f5109e80 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142fbe>] task_blocks_on_lock+0x11e/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0176c49>] kmem_cache_free+0x39/0x70 (80)
 [<c013bdd7>] rcu_process_callbacks+0x57/0x80 (24)
 [<c012e619>] __tasklet_action+0x79/0x110 (12)
 [<c012e8e7>] ksoftirqd+0x147/0x240 (32)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
softirq-hrtim [f7c05a70]D 00000000  7416    19      1            20    18 (L-TLB)
f7c07e68 00000000 00000000 00000000 00000000 bd365ef6 00000093 00000167 
       f7c05ba8 f7c05a70 f7eb9a70 c1f1f160 bd385455 00000093 f7c05a70 00000001 
       f7c06000 0100a140 ffffffff f7c07e90 c037ffc5 c0142f53 00000004 f7c03f14 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0133b60>] __sigqueue_alloc+0x20/0x70 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0133b60>] __sigqueue_alloc+0x20/0x70 (28)
 [<c01346bb>] send_signal+0xab/0x140 (12)
 [<c0134bdc>] __group_send_sig_info+0x6c/0xe0 (20)
 [<c01343c1>] check_kill_permission+0x61/0x110 (8)
 [<c0134d95>] group_send_sig_info+0xb5/0x100 (20)
 [<c0135289>] send_group_sig_info+0x29/0x50 (28)
 [<c012cce0>] it_real_fn+0x0/0x60 (8)
 [<c012ccfd>] it_real_fn+0x1d/0x60 (8)
 [<c012cce0>] it_real_fn+0x0/0x60 (8)
 [<c0142824>] run_hrtimer_softirq+0x84/0x110 (4)
 [<c012e8e7>] ksoftirqd+0x147/0x240 (36)
 [<c012e7a0>] ksoftirqd+0x0/0x240 (48)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
watchdog/1    [f7c0aa70]S 00000200  7760    20      1            21    19 (L-TLB)
f7c0df94 00000001 c01e037a 00000200 f7c0df64 00000000 00000000 000000b5 
       f7c0aba8 f7c0aa70 f7c0fa70 c1f1f160 5164b2e1 00000009 c1f1f1ac c1f1f160 
       f7c0c000 f7eb7eec 00000001 f7c0dfbc c037ffc5 00000073 ffffffff c1f1f1ac 
Call Trace:
 [<c01e037a>] avc_has_perm+0x5a/0x70 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (72)
 [<c0152bc0>] watchdog+0x0/0x60 (36)
 [<c0152c03>] watchdog+0x43/0x60 (4)
 [<c013e78c>] kthread+0xac/0xb0 (12)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
desched/1     [f7c0fa70]S F75A2000  7392    21      1            22    20 (L-TLB)
f7c11f94 00000000 00000000 f75a2000 c0175f95 3349e830 0000000d 00000c33 
       f7c0fba8 f7c0fa70 f7206a70 c1f1f160 334c49c7 0000000d f7c11fa0 c21df300 
       f7c10000 f7c10000 00000001 f7c11fbc c037ffc5 c0176c63 00000001 f7c10000 
Call Trace:
 [<c0175f95>] cache_free_debugcheck+0x245/0x2b0 (20)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c0176c63>] kmem_cache_free+0x53/0x70 (4)
 [<c01277b0>] desched_thread+0x0/0x80 (32)
 [<c01277fe>] desched_thread+0x4e/0x80 (4)
 [<c013e78c>] kthread+0xac/0xb0 (12)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
events/0      [f7fe5a70]D F7768000  7456    22      1            23    21 (L-TLB)
f7c19eb4 00000000 c062ab40 f7768000 c1cffc9c 8515fce4 0000000d 00001524 
       f7fe5ba8 f7fe5a70 c03dfc40 c1f0f160 85162901 0000000d c03e8880 00000002 
       f7c18000 0000a040 ffffffff f7c19edc c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c01773e2>] cache_reap+0x92/0x260 (80)
 [<c01227fc>] __wake_up+0x3c/0x70 (24)
 [<c0177350>] cache_reap+0x0/0x260 (16)
 [<c013a74a>] worker_thread+0x17a/0x250 (16)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
events/1      [f7fe8a70]S 94FE8088  7200    23      1            24    22 (L-TLB)
f7febf3c 76786e43 1e3e7ae3 94fe8088 069edbdb c8d241ff 00000094 000001b0 
       f7fe8ba8 f7fe8a70 f7eb9a70 c1f1f160 c8d26335 00000094 c0177350 00000001 
       f7fea000 f7ee3f20 f7ee3ef8 f7febf64 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c0177350>] cache_reap+0x0/0x260 (60)
 [<c037ffc5>] schedule+0xa5/0x120 (24)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c0177350>] cache_reap+0x0/0x260 (16)
 [<c013a7e5>] worker_thread+0x215/0x250 (16)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
khelper       [f7c7ea70]S 00000004  6944    24      1            25    23 (L-TLB)
f7c2bf3c 00000001 00000246 00000004 c1f1fae0 0dcc685e 0000000d 00000321 
       f7c7eba8 f7c7ea70 f760ea70 c1f1f160 0dce7680 0000000d f7c2bf4c 00000001 
       f7c2a000 f7feef20 f7feeef8 f7c2bf64 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c013a1e0>] __call_usermodehelper+0x0/0x50 (16)
 [<c013a7e5>] worker_thread+0x215/0x250 (16)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
kthread       [f7fa5a70]S F7FA6000  7188    25      1    32     366    24 (L-TLB)
f7fa7f3c 00800711 00000286 f7fa6000 f50e3dc0 20d734ee 0000000d 00000122 
       f7fa5ba8 f7fa5a70 f7068a70 c1f1f160 20e408d9 0000000d f50e3dc0 00000001 
       f7fa6000 f7f84f20 f7f84ef8 f7fa7f64 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c013e790>] keventd_create_kthread+0x0/0x70 (16)
 [<c013a7e5>] worker_thread+0x215/0x250 (16)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
kblockd/0     [f7f1ba70]S C04E8A14  7576    32     25            33       (L-TLB)
f7f1df3c c8408800 c04e8980 c04e8a14 0082fddf 328c679e 0000000d 00000da1 
       f7f1bba8 f7f1ba70 f764da70 c1f0f160 328d38ff 0000000d 00000000 00000001 
       f7f1c000 c2388f20 c2388ef8 f7f1df64 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c01ffb70>] blk_unplug_work+0x0/0x10 (16)
 [<c013a7e5>] worker_thread+0x215/0x250 (16)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
kblockd/1     [f7f45a70]S C0206A09  7576    33     25            34    32 (L-TLB)
f7f47f3c 00000000 f7846180 c0206a09 c8408800 d1eec07a 0000000c 00000dd1 
       f7f45ba8 f7f45a70 f74f9a70 c1f1f160 d1ef70dc 0000000c f7f47f28 00000001 
       f7f46000 c2389f20 c2389ef8 f7f47f64 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c0206a09>] as_dispatch_request+0x129/0x410 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<c02076e0>] as_work_handler+0x0/0x30 (16)
 [<c013a7e5>] worker_thread+0x215/0x250 (16)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
kacpid        [f7f20a70]S 00000080  7716    34     25            35    33 (L-TLB)
f7f23f3c 00000080 00000100 00000080 00000100 5d3af66f 00000009 000003e9 
       f7f20ba8 f7f20a70 f7eb9a70 c1f1f160 5d475150 00000009 f7f23f3c 00000001 
       f7f22000 f7f22000 c23b7ef8 f7f23f64 c037ffc5 c0136d8a f7f24c24 f7f22000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0136d8a>] do_sigaction+0x1ca/0x210 (4)
 [<c013a7e5>] worker_thread+0x215/0x250 (36)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 9         [f7f4aa70]S F7F4AA70  7712    35     25           306    34 (L-TLB)
f7f4df7c ffffffff ffffffff f7f4aa70 f7f4df60 5d52b46c 00000009 000003ac 
       f7f4aba8 f7f4aa70 c03dfc40 c1f0f160 5d5cb452 00000009 f7f4df94 00000002 
       f7f4c000 00000009 c03e5e84 f7f4dfa4 c037ffc5 00000246 00000023 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c0154203>] do_irqd+0x113/0x1b0 (24)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
khubd         [f78bea70]S 00000000  7780   306     25           364    35 (L-TLB)
f7b29f7c f7b28000 f7b29fac 00000000 00000002 7ec25516 00000009 000001cf 
       f78beba8 f78bea70 c03dfc40 c1f0f160 7ecb87b8 00000009 f7b28000 00000002 
       f7b28000 f7b28000 c013ec80 f7b29fa4 c037ffc5 7ecb43c1 f7b29fac c040a800 
Call Trace:
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (76)
 [<c037ffc5>] schedule+0xa5/0x120 (8)
 [<c02d5e30>] hub_thread+0x0/0xe0 (20)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (12)
 [<c02d5e30>] hub_thread+0x0/0xe0 (4)
 [<c02d5edf>] hub_thread+0xaf/0xe0 (4)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (12)
 [<c013e78c>] kthread+0xac/0xb0 (24)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
pdflush       [f7bc6a70]S F7BC9F80  7764   364     25           365   306 (L-TLB)
f7bc9f6c 0003fff0 c015bc39 f7bc9f80 00000000 e4a4f6ed 00000017 00000158 
       f7bc6ba8 f7bc6a70 c03dfc40 c1f0f160 e4a6550a 00000017 00000000 00000002 
       f7bc8000 f7bc9fbc f7bc9fb0 f7bc9f94 c037ffc5 00000000 00001363 00000000 
Call Trace:
 [<c015bc39>] get_dirty_limits+0x29/0x120 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (72)
 [<c015cb60>] pdflush+0x0/0x30 (36)
 [<c015ca41>] __pdflush+0x81/0x1a0 (4)
 [<c015cb88>] pdflush+0x28/0x30 (20)
 [<c013e78c>] kthread+0xac/0xb0 (32)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
pdflush       [f7850a70]S 00000282  7556   365     25           367   364 (L-TLB)
f7b83f6c c03eaf68 c0132527 00000282 c014382d d678ea85 00000092 00000268 
       f7850ba8 f7850a70 c03dfc40 c1f0f160 d67fd305 00000092 f7b83f88 00000002 
       f7b82000 f7b83fbc f7b83fb0 f7b83f94 c037ffc5 00000005 00000000 00000000 
Call Trace:
 [<c0132527>] __mod_timer+0x97/0xe0 (12)
 [<c014382d>] rt_up_read+0x2d/0x80 (8)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c015cb60>] pdflush+0x0/0x30 (36)
 [<c015ca41>] __pdflush+0x81/0x1a0 (4)
 [<c015cb88>] pdflush+0x28/0x30 (20)
 [<c013e78c>] kthread+0xac/0xb0 (32)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
kswapd0       [f7bbba70]S C02115A2  7792   366      1           556    25 (L-TLB)
f7bbdf88 f7bbbc33 f7bbdfc0 c02115a2 00000000 9046fbbe 00000009 000004d7 
       f7bbbba8 f7bbba70 f7eb9a70 c1f1f160 9049e422 00000009 00000000 00000001 
       f7bbc000 c03e6380 c03eae04 f7bbdfb0 c037ffc5 f7bbc000 c012a530 f7bbdfc0 
Call Trace:
 [<c02115a2>] vsnprintf+0x352/0x610 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c012a530>] daemonize+0x1c0/0x230 (8)
 [<c01602b5>] kswapd+0x105/0x120 (32)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (20)
 [<c01601b0>] kswapd+0x0/0x120 (16)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
aio/0         [f7a66a70]S 00000100  7764   367     25           368   365 (L-TLB)
f7babf3c 00000080 00000180 00000100 00000100 91801607 00000009 00000185 
       f7a66ba8 f7a66a70 f7eb4a70 c1f0f160 9185a0b7 00000009 f7babf3c 00000001 
       f7baa000 f7baa000 f7453ef8 f7babf64 c037ffc5 c0136d8a f798dc24 f7baa000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0136d8a>] do_sigaction+0x1ca/0x210 (4)
 [<c013a7e5>] worker_thread+0x215/0x250 (36)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
aio/1         [f7a02a70]S 00000100  7764   368     25           445   367 (L-TLB)
f7b8df3c 00000080 00000180 00000100 00000100 91778bde 00000009 0000014b 
       f7a02ba8 f7a02a70 f7eb4a70 c1f1f160 918678ff 00000009 f7b8df3c 00000001 
       f7b8c000 f7b8c000 f7454ef8 f7b8df64 c037ffc5 c0136d8a f7988c24 f7b8c000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0136d8a>] do_sigaction+0x1ca/0x210 (4)
 [<c013a7e5>] worker_thread+0x215/0x250 (36)
 [<c0122730>] default_wake_function+0x0/0x20 (64)
 [<c013a5d0>] worker_thread+0x0/0x250 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 8         [f7027a70]S 00000000  7712   445     25           458   368 (L-TLB)
f7029f7c 00000001 c1f0f160 00000000 00000180 bde245a7 00000009 00000e5c 
       f7027ba8 f7027a70 f7e0ba70 c1f0f160 bde24bee 00000009 c0450a00 00000000 
       f7028000 00000008 c03e5e80 f7029fa4 c037ffc5 0000007b 0000007b ffffffef 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01540c1>] do_hardirq+0x61/0x90 (16)
 [<c0154203>] do_irqd+0x113/0x1b0 (24)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
kseriod       [f705ba70]S F7786DA4  7004   458     25           463   445 (L-TLB)
f705df78 6b17333f 00008080 f7786da4 00000000 8b58afcf 0000000a 0000095f 
       f705bba8 f705ba70 f7eb9a70 c1f1f160 8b5a421a 0000000a f7786000 00000001 
       f705c000 f705c000 f705dfac f705dfa0 c037ffc5 f7786da4 c1f215c0 01a84f60 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0176cee>] kfree+0x6e/0x80 (16)
 [<c028d730>] serio_thread+0x0/0xf0 (20)
 [<c028d7ef>] serio_thread+0xbf/0xf0 (4)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (16)
 [<c013e78c>] kthread+0xac/0xb0 (24)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 12        [f7045a70]S FA355A70  7612   463     25           496   458 (L-TLB)
f7047f7c 00000000 0000000c fa355a70 f755655c 8b51f1d6 0000000a 0000073a 
       f7045ba8 f7045a70 f7eb4a70 c1f0f160 8b59ecb6 0000000a 0000000c 0000000c 
       f7046000 0000000c c03e5e90 f7047fa4 c037ffc5 00000000 c0450c00 c0450c4c 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0154203>] do_irqd+0x113/0x1b0 (40)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 14        [f78cea70]S C02C0360  7188   496     25           498   463 (L-TLB)
f78d1f7c bca963ab 00000001 c02c0360 f714b854 328c679e 0000000d 00000eb3 
       f78ceba8 f78cea70 f764da70 c1f0f160 3293ef0e 0000000d 0000000e 0000000e 
       f78d0000 0000000e c03e5e98 f78d1fa4 c037ffc5 00000000 c0450d00 c0450d4c 
Call Trace:
 [<c02c0360>] ide_dma_intr+0x0/0xc0 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c0154203>] do_irqd+0x113/0x1b0 (40)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 15        [f7bdaa70]S C02C64B0  7608   498     25           537   496 (L-TLB)
f7bddf7c f7bddf64 f714b770 c02c64b0 f714b770 43623c17 0000000c 000005b9 
       f7bdaba8 f7bdaa70 c03dfc40 c1f0f160 4363d168 0000000c 0000000f 00000002 
       f7bdc000 0000000f c03e5e9c f7bddfa4 c037ffc5 00000000 c0450d80 c0450dcc 
Call Trace:
 [<c02c64b0>] cdrom_pc_intr+0x0/0x290 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c0154203>] do_irqd+0x113/0x1b0 (40)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 1         [f77daa70]S 14150180 [curr]  6628   537     25           545   498 (L-TLB)
c037f881 00000000 00000001 14150180 f7628394 00000000 f77dc000 c04506cc 
       c0153030 c03dfc40 f7e1fa70 c1f0f160 00000000 00000001 00000000 00000000 
       c0450680 f7628394 00000001 c04506cc c0153fd2 00000007 c0450680 c04506cc 
Call Trace:
 [<c037f881>] __schedule+0x331/0x9d0 (4)
 [<c0153030>] handle_IRQ_event+0x60/0xe0 (32)
 [<c0153fd2>] thread_edge_irq+0x62/0xf0 (48)
 [<c0154097>] do_hardirq+0x37/0x90 (24)
 [<c01541b0>] do_irqd+0xc0/0x1b0 (16)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 4         [f70c6a70]S 00000060  7644   545     25           956   537 (L-TLB)
f70c9f7c 00000002 00000001 00000060 f5828724 9c595d2c 0000000c 00000b61 
       f70c6ba8 f70c6a70 f7e1fa70 c1f0f160 9c5bd9d3 0000000c 00000004 00000004 
       f70c8000 00000004 c03e5e70 f70c9fa4 c037ffc5 00000000 c0450800 c045084c 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0154203>] do_irqd+0x113/0x1b0 (40)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
kjournald     [f77cfa70]S 00000000  7528   556      1           561   366 (L-TLB)
f77d1f6c f77d1fa0 00000000 00000000 00000000 a5e3047c 0000000a 00006cfc 
       f77cfba8 f77cfa70 f7eb9a70 c1f1f160 a5e59c75 0000000a 00000000 00000001 
       f77d0000 f7373c0c f7373bf8 f77d1f94 c037ffc5 00000000 c01227fc 00000001 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01227fc>] __wake_up+0x3c/0x70 (8)
 [<f8867735>] kjournald+0x215/0x230 [jbd] (32)
 [<c010336e>] ret_from_fork+0x6/0x14 (28)
 [<f8867510>] commit_timeout+0x0/0x10 [jbd] (4)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (20)
 [<f8867520>] kjournald+0x0/0x230 [jbd] (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
init          [f7001a70]S FFFFFFFF  7296   561      1   562     703   556 (NOTLB)
f7179f1c ffffffff 00000000 ffffffff 00000001 2c871bd5 0000000b 0000065e 
       f7001ba8 f7001a70 c03dfc40 c1f0f160 2c943a52 0000000b 00000000 00000002 
       f7178000 00000001 00000004 f7179f44 c037ffc5 00000004 00000004 f7001a70 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01e152a>] task_has_perm+0x2a/0x30 (16)
 [<c012c66c>] do_wait+0x2ac/0x420 (24)
 [<c0122730>] default_wake_function+0x0/0x20 (52)
 [<c012c895>] sys_wait4+0x35/0x40 (28)
 [<c012c8c5>] sys_waitpid+0x25/0x30 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
rc.sysinit    [f7176a70]S 00000000  6300   562    561  1210               (NOTLB)
f719bf1c c01644cf 3d96e065 00000000 ffc31000 2fa1c9ae 0000000d 0000055e 
       f7176ba8 f7176a70 f7a96a70 c1f0f160 2fad6483 0000000d 00000000 fd7ffffd 
       f719a000 00000001 00000004 f719bf44 c037ffc5 00000004 00000004 f7176a70 
Call Trace:
 [<c01644cf>] do_wp_page+0x18f/0x350 (8)
 [<c037ffc5>] schedule+0xa5/0x120 (76)
 [<c01e152a>] task_has_perm+0x2a/0x30 (16)
 [<c012c66c>] do_wait+0x2ac/0x420 (24)
 [<c0122730>] default_wake_function+0x0/0x20 (52)
 [<c012c895>] sys_wait4+0x35/0x40 (28)
 [<c012c8c5>] sys_waitpid+0x25/0x30 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udevd         [f7206a70]S 00000002  6736   703      1  1065     947   561 (NOTLB)
f599dea0 00000002 00000044 00000002 000200d0 3386f79e 0000000d 00001245 
       f7206ba8 f7206a70 f7603a70 c1f1f160 338b78ae 0000000d f5249e78 c03ead80 
       f599c000 00000080 00000007 f599dec8 c037ffc5 00000000 00000000 000000d0 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c015a555>] __get_free_pages+0x35/0x90 (20)
 [<c03809b5>] schedule_timeout+0x75/0xc0 (20)
 [<c018e7f0>] __pollwait+0x80/0xd0 (8)
 [<c013ea86>] add_wait_queue+0x16/0x40 (8)
 [<c030f014>] datagram_poll+0x14/0xd0 (12)
 [<c018ec3f>] do_select+0x2ef/0x330 (20)
 [<c018e770>] __pollwait+0x0/0xd0 (96)
 [<c018eece>] sys_select+0x21e/0x3c0 (28)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (64)
kmodule       [f71b4a70]S 00000282  7296   947      1                 703 (NOTLB)
f5a9de18 00000246 00000017 00000282 00000017 62a6eed1 0000000c 0000b552 
       f71b4ba8 f71b4a70 f7eb9a70 c1f1f160 62b1c24e 0000000c 00000000 00000001 
       f5a9c000 f5b7cd64 f5a9dea4 f5a9de40 c037ffc5 c0174089 c017333f 00000017 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0174089>] poison_obj+0x29/0x60 (4)
 [<c017333f>] dbg_redzone1+0x1f/0x60 (4)
 [<c03809b5>] schedule_timeout+0x75/0xc0 (32)
 [<c013ebbc>] prepare_to_wait_exclusive+0x1c/0x70 (32)
 [<c030e773>] wait_for_packet+0x113/0x150 (16)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (12)
 [<c030e82f>] skb_recv_datagram+0x7f/0xd0 (28)
 [<c037a29c>] unix_accept+0x7c/0x110 (28)
 [<c0307ae5>] sys_accept+0x105/0x1e0 (28)
 [<c01e037a>] avc_has_perm+0x5a/0x70 (12)
 [<c01e4dec>] socket_has_perm+0x5c/0x70 (56)
 [<c0212a6e>] copy_from_user+0x4e/0xc0 (72)
 [<c0308923>] sys_socketcall+0xf3/0x2a0 (28)
 [<c01797f7>] filp_close+0x47/0x90 (40)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
IRQ 6         [f76e4a70]S 00000006  7640   956     25          1059   545 (L-TLB)
f5a2bf7c 00000000 f888b7a3 00000006 f5789c30 6be8b03a 0000000c 00008cb1 
       f76e4ba8 f76e4a70 f7e0ba70 c1f0f160 6bea6486 0000000c 00000006 00000006 
       f5a2a000 00000006 c03e5e78 f5a2bfa4 c037ffc5 00000000 c0450900 c045094c 
Call Trace:
 [<f888b7a3>] floppy_interrupt+0x143/0x1d0 [floppy] (12)
 [<c037ffc5>] schedule+0xa5/0x120 (72)
 [<c0154203>] do_irqd+0x113/0x1b0 (40)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
IRQ 177       [f76c6a70]S F76C6A70  7712  1059     25          1095   956 (L-TLB)
f5a01f7c ffffffff ffffffff f76c6a70 f5a01f60 bd7edfa0 0000000c 00000446 
       f76c6ba8 f76c6a70 f76fda70 c1f0f160 bd8335c7 0000000c f5a01f94 00000072 
       f5a00000 000000b1 c03e6124 f5a01fa4 c037ffc5 00000246 00000423 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c0154203>] do_irqd+0x113/0x1b0 (24)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
udev          [f7681a70]S 00000000  6816  1065    703  1096    1098       (NOTLB)
f59b5f1c c01644cf 3dc64065 00000000 c01610bd c825dc82 0000000c 00002047 
       f7681ba8 f7681a70 f7206a70 c1f0f160 c82de35d 0000000c 00000000 ffffffff 
       f59b4000 00000001 00000004 f59b5f44 c037ffc5 00000004 00000004 f7681a70 
Call Trace:
 [<c01644cf>] do_wp_page+0x18f/0x350 (8)
 [<c01610bd>] kmap_high+0x12d/0x200 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c01e152a>] task_has_perm+0x2a/0x30 (16)
 [<c012c66c>] do_wait+0x2ac/0x420 (24)
 [<c0153514>] __do_IRQ+0x104/0x150 (4)
 [<c0122730>] default_wake_function+0x0/0x20 (48)
 [<c012c895>] sys_wait4+0x35/0x40 (28)
 [<c012c8c5>] sys_waitpid+0x25/0x30 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
kgameportd    [f751ea70]S 00000000  7824  1095     25          1105  1059 (L-TLB)
f5121f78 00000000 f5121fac 00000000 00000002 c741385d 0000000c 000002dd 
       f751eba8 f751ea70 f754ea70 c1f0f160 c74f4da7 0000000c 0000a040 c741385d 
       f5120000 f5120000 f5121fac f5121fa0 c037ffc5 f8981bc0 f5121fac f8981de0 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<f897e800>] gameport_thread+0x0/0xf0 [gameport] (20)
 [<f897e800>] gameport_thread+0x0/0xf0 [gameport] (16)
 [<f897e8bf>] gameport_thread+0xbf/0xf0 [gameport] (4)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (16)
 [<c013e78c>] kthread+0xac/0xb0 (24)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
udev_run_hotp [f755da70]S 00000000  6684  1096   1065  1108               (NOTLB)
f5117f1c c01644cf 3f581065 00000000 ffc54000 ca601bdd 0000000c 00000eb9 
       f755dba8 f755da70 f71cea70 c1f1f160 ca6a4117 0000000c 00000000 ffffffff 
       f5116000 00000001 00000004 f5117f44 c037ffc5 00000004 00000004 f755da70 
Call Trace:
 [<c01644cf>] do_wp_page+0x18f/0x350 (8)
 [<c037ffc5>] schedule+0xa5/0x120 (76)
 [<c01e152a>] task_has_perm+0x2a/0x30 (16)
 [<c012c66c>] do_wait+0x2ac/0x420 (24)
 [<c0122730>] default_wake_function+0x0/0x20 (52)
 [<c012c895>] sys_wait4+0x35/0x40 (28)
 [<c012c8c5>] sys_waitpid+0x25/0x30 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f70bea70]S 00000000  6724  1098    703  1176    1099  1065 (NOTLB)
f50f1f1c c01644cf 3f007065 00000000 c01610bd 05db8b57 0000000d 00003f78 
       f70beba8 f70bea70 f772da70 c1f0f160 05e2c919 0000000d 00000000 ffffffff 
       f50f0000 00000001 00000004 f50f1f44 c037ffc5 00000004 00000004 f70bea70 
Call Trace:
 [<c01644cf>] do_wp_page+0x18f/0x350 (8)
 [<c01610bd>] kmap_high+0x12d/0x200 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c01e152a>] task_has_perm+0x2a/0x30 (16)
 [<c012c66c>] do_wait+0x2ac/0x420 (24)
 [<c0122730>] default_wake_function+0x0/0x20 (52)
 [<c012c895>] sys_wait4+0x35/0x40 (28)
 [<c012c8c5>] sys_waitpid+0x25/0x30 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f7161a70]D 32F5936E  6728  1099    703          1118  1098 (NOTLB)
f5139ef4 f76fda70 c1f1f160 32f5936e 0000000d 33a54edb 0000000d 00002ec9 
       f7161ba8 f7161a70 f7845a70 c1f1f160 33a6a429 0000000d ffffffff c1f115c8 
       f5138000 00800000 ffffffff f5139f1c c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0176cac>] kfree+0x2c/0x80 (80)
 [<c017b15e>] __fput+0xbe/0x1b0 (16)
 [<c01797f7>] filp_close+0x47/0x90 (36)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
IRQ 185       [f704ca70]S F704CA70  7660  1105     25          1199  1095 (L-TLB)
f5145f7c ffffffff ffffffff f704ca70 f5145f60 c95650c2 0000000c 00000941 
       f704cba8 f704ca70 f70bea70 c1f0f160 c95c347a 0000000c f5145f94 00000072 
       f5144000 000000b9 c03e6144 f5145fa4 c037ffc5 00000246 00000451 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0123045>] do_sched_setscheduler+0x75/0xc0 (16)
 [<c0154203>] do_irqd+0x113/0x1b0 (24)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
ifup-eth      [f71cea70]S FFFFFFFF  6384  1108   1096  1200               (NOTLB)
f5155f1c ffffffff 00000000 ffffffff 00000001 217ee5a8 0000000d 000006fa 
       f71ceba8 f71cea70 f782aa70 c1f1f160 21873016 0000000d 00000000 00000004 
       f5154000 00000001 00000004 f5155f44 c037ffc5 00000004 00000004 f71cea70 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c01e152a>] task_has_perm+0x2a/0x30 (16)
 [<c012c66c>] do_wait+0x2ac/0x420 (24)
 [<c0122730>] default_wake_function+0x0/0x20 (52)
 [<c012c895>] sys_wait4+0x35/0x40 (28)
 [<c012c8c5>] sys_waitpid+0x25/0x30 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f7845a70]D 32283ED5  6816  1118    703          1121  1099 (NOTLB)
f51afc98 f7158a70 c1f1f160 32283ed5 0000000d 33a54edb 0000000d 0000214a 
       f7845ba8 f7845a70 f79a1a70 c1f1f160 33a6c573 0000000d ffffffff c1f115c8 
       f51ae000 00800000 ffffffff f51afcc0 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c01b1ed5>] proc_alloc_inode+0x15/0x70 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c01b1ed5>] proc_alloc_inode+0x15/0x70 (24)
 [<c0194ce5>] alloc_inode+0x25/0x1b0 (16)
 [<c0195824>] new_inode+0x14/0x90 (20)
 [<c01b3bdc>] proc_pid_make_inode+0x1c/0xf0 (12)
 [<c01b435e>] proc_pident_lookup+0xae/0x350 (28)
 [<c01939d9>] d_alloc+0x149/0x1c0 (16)
 [<c01887d8>] real_lookup+0xc8/0x100 (36)
 [<c0188b4b>] do_lookup+0x8b/0xa0 (32)
 [<c0188cbb>] __link_path_walk+0x15b/0x1010 (24)
 [<c011feaa>] wake_idle+0x9a/0xb0 (4)
 [<c0189bc3>] link_path_walk+0x53/0x130 (96)
 [<c014325b>] release_lock+0x5b/0x80 (28)
 [<c0179574>] get_unused_fd+0xb4/0xe0 (32)
 [<c0189fca>] path_lookup+0xaa/0x210 (44)
 [<c018a178>] __path_lookup_intent_open+0x48/0xa0 (36)
 [<c018a1e6>] path_lookup_open+0x16/0x20 (20)
 [<c018a990>] open_namei+0x70/0x630 (16)
 [<c011e400>] change_page_attr+0x30/0x70 (20)
 [<c011e5a4>] kernel_map_pages+0x54/0xe0 (20)
 [<c0174089>] poison_obj+0x29/0x60 (8)
 [<c0179312>] filp_open+0x22/0x50 (28)
 [<c014325b>] release_lock+0x5b/0x80 (16)
 [<c0179574>] get_unused_fd+0xb4/0xe0 (32)
 [<c01796cd>] do_sys_open+0x3d/0xd0 (36)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
udev          [f770ea70]D C011E028  6816  1121    703          1137  1118 (NOTLB)
f519de58 00000000 00000000 c011e028 00000004 339e924e 0000000d 00001d1d 
       f770eba8 f770ea70 f7574a70 c1f0f160 33a6d2cf 0000000d 00000000 c1f115c8 
       f519c000 00800000 ffffffff f519de80 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c011e028>] __change_page_attr+0x58/0x400 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c03800a9>] preempt_schedule+0x69/0x80 (4)
 [<c0188258>] getname+0x28/0xf0 (24)
 [<c018a3fb>] __user_walk+0x1b/0x50 (20)
 [<c018410a>] vfs_lstat+0x1a/0x50 (20)
 [<c037f881>] __schedule+0x331/0x9d0 (44)
 [<c018476f>] sys_lstat64+0xf/0x30 (40)
 [<c0380117>] preempt_schedule_irq+0x57/0x80 (40)
 [<c01033e8>] need_resched+0x20/0x24 (20)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (16)
udev          [f71e1a70]D 32F60F7E  6804  1137    703          1138  1121 (NOTLB)
f5107e58 f76fda70 c1f1f160 32f60f7e 0000000d 339e924e 0000000d 00002832 
       f71e1ba8 f71e1a70 f770ea70 c1f0f160 33a6b5b2 0000000d ffffffff c1f115c8 
       f5106000 00800000 ffffffff f5107e80 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c03800a9>] preempt_schedule+0x69/0x80 (4)
 [<c0188258>] getname+0x28/0xf0 (24)
 [<c018a3fb>] __user_walk+0x1b/0x50 (20)
 [<c018410a>] vfs_lstat+0x1a/0x50 (20)
 [<c0175e9e>] cache_free_debugcheck+0x14e/0x2b0 (20)
 [<c0176cdb>] kfree+0x5b/0x80 (24)
 [<c018476f>] sys_lstat64+0xf/0x30 (40)
 [<c017b1e4>] __fput+0x144/0x1b0 (20)
 [<c0143c8f>] atomic_dec_and_spin_lock+0x3f/0x60 (12)
 [<c01983f3>] mntput_no_expire+0x13/0x70 (12)
 [<c01797f7>] filp_close+0x47/0x90 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f7a96a70]D 00000001  6816  1138    703          1142  1137 (NOTLB)
f5109e44 f5109e50 c01223d9 00000001 00000001 3396197a 0000000d 0000059c 
       f7a96ba8 f7a96a70 f757fa70 c1f1f160 33a4bd76 0000000d f757fa70 f757ff8c 
       f5108000 00800000 ffffffff f5109e6c c037ffc5 c0142fbe 00000004 00000000 
Call Trace:
 [<c01223d9>] dependent_sleeper+0x109/0x460 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (72)
 [<c0142fbe>] task_blocks_on_lock+0x11e/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c01ee623>] security_sid_to_context+0xa3/0x100 (76)
 [<c0176a6b>] __kmalloc_track_caller+0x8b/0x140 (4)
 [<c01ee495>] context_struct_to_string+0x95/0x180 (36)
 [<c01ee623>] security_sid_to_context+0xa3/0x100 (56)
 [<c01e7234>] sel_write_context+0x64/0xd0 (32)
 [<c01e7438>] selinux_transaction_write+0x68/0xb0 (40)
 [<c01e73d0>] selinux_transaction_write+0x0/0xb0 (28)
 [<c017a37b>] vfs_write+0xbb/0x180 (4)
 [<c017a4f1>] sys_write+0x41/0x70 (24)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
udev          [f70cea70]D 32F73ED4  6816  1142    703          1150  1138 (NOTLB)
f59a9e58 f76fda70 c1f1f160 32f73ed4 0000000d 339e924e 0000000d 00001364 
       f70ceba8 f70cea70 f71e1a70 c1f0f160 33a68d80 0000000d ffffffff c1f115c8 
       f59a8000 00800000 ffffffff f59a9e80 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0188258>] getname+0x28/0xf0 (28)
 [<c018a3fb>] __user_walk+0x1b/0x50 (20)
 [<c018410a>] vfs_lstat+0x1a/0x50 (20)
 [<c0156860>] filemap_nopage+0x0/0x3c0 (4)
 [<c0165771>] __handle_mm_fault+0x141/0x380 (4)
 [<c014382d>] rt_up_read+0x2d/0x80 (56)
 [<c018476f>] sys_lstat64+0xf/0x30 (20)
 [<c014382d>] rt_up_read+0x2d/0x80 (56)
 [<c011d130>] do_page_fault+0x0/0x680 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (8)
udev          [f7753a70]D 32F7C907  6804  1150    703          1152  1142 (NOTLB)
f514be58 f76fda70 c1f1f160 32f7c907 0000000d 339e924e 0000000d 0000116f 
       f7753ba8 f7753a70 f70cea70 c1f0f160 33a67a1c 0000000d ffffffff c1f115c8 
       f514a000 00800000 ffffffff f514be80 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0188258>] getname+0x28/0xf0 (28)
 [<c018a3fb>] __user_walk+0x1b/0x50 (20)
 [<c018410a>] vfs_lstat+0x1a/0x50 (20)
 [<c0156860>] filemap_nopage+0x0/0x3c0 (4)
 [<c0165771>] __handle_mm_fault+0x141/0x380 (4)
 [<c014382d>] rt_up_read+0x2d/0x80 (56)
 [<c018476f>] sys_lstat64+0xf/0x30 (20)
 [<c01797f7>] filp_close+0x47/0x90 (56)
 [<c011d130>] do_page_fault+0x0/0x680 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (8)
udev          [f79a1a70]D 00000000  6816  1152    703          1158  1150 (L-TLB)
f5b2de9c 3196467d 0000000d 00000000 00000000 33a54edb 0000000d 00001472 
       f79a1ba8 f79a1a70 f7eb9a70 c1f1f160 33a6d9e5 0000000d f770ea70 00000001 
       f5b2c000 00800004 ffffffff f5b2dec4 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0176c49>] kmem_cache_free+0x39/0x70 (80)
 [<c0166701>] remove_vma+0x41/0x50 (24)
 [<c0168937>] exit_mmap+0xe7/0x150 (12)
 [<c01257c3>] mmput+0x33/0xa0 (40)
 [<c012b418>] do_exit+0x118/0x4b0 (12)
 [<c012b828>] do_group_exit+0x38/0xc0 (40)
 [<c01797f7>] filp_close+0x47/0x90 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f7574a70]D 00000000  6744  1158    703          1174  1152 (NOTLB)
f59bdef0 c016190f c1ea02b8 00000000 ffd02038 339e924e 0000000d 0000127f 
       f7574ba8 f7574a70 c03dfc40 c1f0f160 33a6e54e 0000000d 35a3a000 00000002 
       f59bc000 00800000 ffffffff f59bdf18 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c016190f>] page_address+0xaf/0xc0 (8)
 [<c037ffc5>] schedule+0xa5/0x120 (76)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0176894>] __cache_free+0x64/0x70 (4)
 [<c0188258>] getname+0x28/0xf0 (24)
 [<c01796ac>] do_sys_open+0x1c/0xd0 (20)
 [<c01797f7>] filp_close+0x47/0x90 (8)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f757fa70]D C01E1617  6716  1174    703          1178  1158 (NOTLB)
f51a1e9c f51a1ea4 00000006 c01e1617 00000006 33a54edb 0000000d 00000395 
       f757fba8 f757fa70 f7603a70 c1f1f160 33a58fcb 0000000d 00000062 00000093 
       f51a0000 00800000 ffffffff f51a1ec4 c037ffc5 c0142fbe 00000004 f524ded8 
Call Trace:
 [<c01e1617>] inode_has_perm+0x47/0x80 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c0142fbe>] task_blocks_on_lock+0x11e/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c014b9fd>] module_text_address+0xd/0x30 (80)
 [<c013c70c>] kernel_text_address+0x1c/0x30 (8)
 [<c017402a>] store_stackinfo+0x5a/0x90 (8)
 [<c0176c54>] kmem_cache_free+0x44/0x70 (4)
 [<c0175f79>] cache_free_debugcheck+0x229/0x2b0 (20)
 [<c017932b>] filp_open+0x3b/0x50 (8)
 [<c0176c54>] kmem_cache_free+0x44/0x70 (16)
 [<c0176856>] __cache_free+0x26/0x70 (24)
 [<c0176c54>] kmem_cache_free+0x44/0x70 (20)
 [<c0179732>] do_sys_open+0xa2/0xd0 (24)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
udev_run_hotp [f76f6a70]S 00000000  6816  1176   1098  1189               (NOTLB)
f5ac3f1c c01644cf 3e6a6065 00000000 ffc8b000 10a7a70c 0000000d 000075f6 
       f76f6ba8 f76f6a70 f7644a70 c1f1f160 10b3f11c 0000000d 00000000 ffffffff 
       f5ac2000 00000001 00000004 f5ac3f44 c037ffc5 00000004 00000004 f76f6a70 
Call Trace:
 [<c01644cf>] do_wp_page+0x18f/0x350 (8)
 [<c037ffc5>] schedule+0xa5/0x120 (76)
 [<c01e152a>] task_has_perm+0x2a/0x30 (16)
 [<c012c66c>] do_wait+0x2ac/0x420 (24)
 [<c0122730>] default_wake_function+0x0/0x20 (52)
 [<c012c895>] sys_wait4+0x35/0x40 (28)
 [<c012c8c5>] sys_waitpid+0x25/0x30 (12)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f71a6a70]D C0142F53  6788  1178    703          1179  1174 (NOTLB)
f5a55ea0 00000006 c011ff47 c0142f53 c0174089 3396197a 0000000d 00000661 
       f71a6ba8 f71a6a70 f757fa70 c1f1f160 33a3181a 0000000d 00000000 c0459408 
       f5a54000 00800000 ffffffff f5a55ec8 c037ffc5 c0142f53 00000004 f5109edc 
Call Trace:
 [<c011ff47>] try_to_wake_up+0x87/0x4f0 (12)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0174089>] poison_obj+0x29/0x60 (4)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c01ee60a>] security_sid_to_context+0x8a/0x100 (80)
 [<c01e7234>] sel_write_context+0x64/0xd0 (32)
 [<c019f316>] simple_transaction_get+0xb6/0xd0 (16)
 [<c01e7438>] selinux_transaction_write+0x68/0xb0 (24)
 [<c01e73d0>] selinux_transaction_write+0x0/0xb0 (28)
 [<c017a37b>] vfs_write+0xbb/0x180 (4)
 [<c017a4f1>] sys_write+0x41/0x70 (24)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
udev          [f7947a70]D 00000004  6608  1179    703          1190  1178 (NOTLB)
f50dbea0 00000000 0000001f 00000004 c0174089 3396197a 0000000d 0000040d 
       f7947ba8 f7947a70 f772da70 c1f1f160 33a2a331 0000000d f50da000 c0459408 
       f50da000 00800000 ffffffff f50dbec8 c037ffc5 c0142f53 00000004 f50d9e94 
Call Trace:
 [<c0174089>] poison_obj+0x29/0x60 (20)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c01ee60a>] security_sid_to_context+0x8a/0x100 (80)
 [<c01e7234>] sel_write_context+0x64/0xd0 (32)
 [<c019f316>] simple_transaction_get+0xb6/0xd0 (16)
 [<c01e7438>] selinux_transaction_write+0x68/0xb0 (24)
 [<c01e73d0>] selinux_transaction_write+0x0/0xb0 (28)
 [<c017a37b>] vfs_write+0xbb/0x180 (4)
 [<c017a4f1>] sys_write+0x41/0x70 (24)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
20-hal.hotplu [f7644a70]D 00000000  6880  1189   1176                     (NOTLB)
f5247e4c 00000000 00000202 00000000 c1f0f160 339e924e 0000000d 00001402 
       f7644ba8 f7644a70 f7753a70 c1f0f160 33a668ad 0000000d c0159faf c1f115c8 
       f5246000 00800000 ffffffff f5247e74 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c0159faf>] buffered_rmqueue+0x9f/0x180 (60)
 [<c037ffc5>] schedule+0xa5/0x120 (24)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c016a26a>] anon_vma_prepare+0xca/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c016a26a>] anon_vma_prepare+0xca/0xf0 (28)
 [<c016122b>] kunmap_high+0x9b/0xf0 (4)
 [<c01650d4>] do_anonymous_page+0x124/0x240 (20)
 [<c01658ff>] __handle_mm_fault+0x2cf/0x380 (36)
 [<c011d550>] do_page_fault+0x420/0x680 (68)
 [<c0166701>] remove_vma+0x41/0x50 (8)
 [<c016857a>] do_munmap+0xea/0x120 (28)
 [<c011d130>] do_page_fault+0x0/0x680 (40)
 [<c010403f>] error_code+0x4f/0x54 (8)
udev          [f772da70]D 00000004  6816  1190    703          1191  1179 (NOTLB)
f5a35ea0 f51a1e84 f5a35e9c 00000004 c0174089 3396197a 0000000d 00000351 
       f772dba8 f772da70 f7111a70 c1f1f160 33a2ba6d 0000000d f5a35e8c c0459408 
       f5a34000 00800000 ffffffff f5a35ec8 c037ffc5 c0142f53 00000004 f5a55e94 
Call Trace:
 [<c0174089>] poison_obj+0x29/0x60 (20)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c01ee60a>] security_sid_to_context+0x8a/0x100 (80)
 [<c01e7234>] sel_write_context+0x64/0xd0 (32)
 [<c019f316>] simple_transaction_get+0xb6/0xd0 (16)
 [<c01e7438>] selinux_transaction_write+0x68/0xb0 (24)
 [<c01e73d0>] selinux_transaction_write+0x0/0xb0 (28)
 [<c017a37b>] vfs_write+0xbb/0x180 (4)
 [<c017a4f1>] sys_write+0x41/0x70 (24)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
udev          [f7158a70]D C01E1617  6816  1191    703          1192  1190 (NOTLB)
f524de9c f524dea4 00000006 c01e1617 00000006 33a54edb 0000000d 0000042e 
       f7158ba8 f7158a70 f7603a70 c1f1f160 33a62bcd 0000000d 00000000 c0450288 
       f524c000 00800000 ffffffff f524dec4 c037ffc5 c0142f53 00000004 f51a1ed8 
Call Trace:
 [<c01e1617>] inode_has_perm+0x47/0x80 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c014b9fd>] module_text_address+0xd/0x30 (80)
 [<c013c70c>] kernel_text_address+0x1c/0x30 (8)
 [<c017402a>] store_stackinfo+0x5a/0x90 (8)
 [<c0176c54>] kmem_cache_free+0x44/0x70 (4)
 [<c0175f79>] cache_free_debugcheck+0x229/0x2b0 (20)
 [<c017932b>] filp_open+0x3b/0x50 (8)
 [<c0176c54>] kmem_cache_free+0x44/0x70 (16)
 [<c0176856>] __cache_free+0x26/0x70 (24)
 [<c0176c54>] kmem_cache_free+0x44/0x70 (20)
 [<c0179732>] do_sys_open+0xa2/0xd0 (24)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
udev          [f7111a70]D C0142F53  6788  1192    703          1193  1191 (NOTLB)
f50d9ea0 00000006 c011ff47 c0142f53 c0174089 3396197a 0000000d 00000700 
       f7111ba8 f7111a70 f71a6a70 c1f1f160 33a2eb73 0000000d 00000000 c0459408 
       f50d8000 00800000 ffffffff f50d9ec8 c037ffc5 c0142f53 00000004 f51a1edc 
Call Trace:
 [<c011ff47>] try_to_wake_up+0x87/0x4f0 (12)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0174089>] poison_obj+0x29/0x60 (4)
 [<c037ffc5>] schedule+0xa5/0x120 (64)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c01ee60a>] security_sid_to_context+0x8a/0x100 (80)
 [<c01e7234>] sel_write_context+0x64/0xd0 (32)
 [<c019f316>] simple_transaction_get+0xb6/0xd0 (16)
 [<c01e7438>] selinux_transaction_write+0x68/0xb0 (24)
 [<c01e73d0>] selinux_transaction_write+0x0/0xb0 (28)
 [<c017a37b>] vfs_write+0xbb/0x180 (4)
 [<c017a4f1>] sys_write+0x41/0x70 (24)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (28)
udev          [f760ea70]D 33A62097  6816  1193    703          1196  1192 (NOTLB)
f5a1fd20 c03dfc40 c1f0f160 33a62097 0000000d 339e924e 0000000d 000002e0 
       f760eba8 f760ea70 f7123a70 c1f0f160 33a64232 0000000d ffffffff f5a1e000 
       f5a1e000 00800000 ffffffff f5a1fd48 c037ffc5 ffffffff 00000000 f760ea70 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0143343>] ____down_mutex+0x93/0x190 (40)
 [<c01938ac>] d_alloc+0x1c/0x1c0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c01938ac>] d_alloc+0x1c/0x1c0 (28)
 [<c01887c0>] real_lookup+0xb0/0x100 (36)
 [<c0188b4b>] do_lookup+0x8b/0xa0 (32)
 [<c01892da>] __link_path_walk+0x77a/0x1010 (24)
 [<c011e028>] __change_page_attr+0x58/0x400 (12)
 [<c0189bc3>] link_path_walk+0x53/0x130 (88)
 [<c0175e9e>] cache_free_debugcheck+0x14e/0x2b0 (36)
 [<c0189fca>] path_lookup+0xaa/0x210 (68)
 [<c018a40f>] __user_walk+0x2f/0x50 (36)
 [<c018410a>] vfs_lstat+0x1a/0x50 (20)
 [<c0175e9e>] cache_free_debugcheck+0x14e/0x2b0 (20)
 [<c018476f>] sys_lstat64+0xf/0x30 (64)
 [<c01797f7>] filp_close+0x47/0x90 (56)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udev          [f7123a70]D 32F4655D  6800  1196    703          1212  1193 (NOTLB)
f511fe58 f76fda70 c1f1f160 32f4655d 0000000d 339e924e 0000000d 00000628 
       f7123ba8 f7123a70 f7644a70 c1f0f160 33a654ab 0000000d ffffffff c1f115c8 
       f511e000 00800000 ffffffff f511fe80 c037ffc5 c0142f53 00000004 f5153e44 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0188258>] getname+0x28/0xf0 (28)
 [<c018a3fb>] __user_walk+0x1b/0x50 (20)
 [<c01840bd>] vfs_stat+0x1d/0x50 (20)
 [<c0156860>] filemap_nopage+0x0/0x3c0 (4)
 [<c0165771>] __handle_mm_fault+0x141/0x380 (4)
 [<c014382d>] rt_up_read+0x2d/0x80 (56)
 [<c018473f>] sys_stat64+0xf/0x30 (20)
 [<c011d130>] do_page_fault+0x0/0x680 (68)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (8)
IRQ 169       [f7068a70]S C0455ACC  7660  1199     25                1105 (L-TLB)
f510df7c 00000297 c011ff66 c0455acc 00000246 7fea7bed 00000034 00000453 
       f7068ba8 f7068a70 f7e15a70 c1f0f160 7ff03c7b 00000034 00000010 000000a9 
       f510c000 000000a9 c03e6104 f510dfa4 c037ffc5 00000007 c03e6104 f510df98 
Call Trace:
 [<c011ff66>] try_to_wake_up+0xa6/0x4f0 (12)
 [<c037ffc5>] schedule+0xa5/0x120 (72)
 [<c01203c9>] wake_up_process+0x19/0x20 (16)
 [<c0154203>] do_irqd+0x113/0x1b0 (24)
 [<c01540f0>] do_irqd+0x0/0x1b0 (32)
 [<c013e78c>] kthread+0xac/0xb0 (4)
 [<c013e6e0>] kthread+0x0/0xb0 (12)
 [<c0101555>] kernel_thread_helper+0x5/0x10 (16)
arping        [f782aa70]S 0000000D  6684  1200   1108                     (NOTLB)
f50e3d0c 00000000 21cb14e7 0000000d 00002ed7 21cb14e7 0000000d 00000a8a 
       f782aba8 f782aa70 f757fa70 c1f1f160 21d497c7 0000000d 00000015 f524150c 
       f50e2000 f5a7dbf8 f50e3d98 f50e3d34 c037ffc5 00000015 000001f0 000001f0 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c03809b5>] schedule_timeout+0x75/0xc0 (40)
 [<c01e037a>] avc_has_perm+0x5a/0x70 (28)
 [<c013ebbc>] prepare_to_wait_exclusive+0x1c/0x70 (4)
 [<c030e773>] wait_for_packet+0x113/0x150 (16)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (12)
 [<c030e82f>] skb_recv_datagram+0x7f/0xd0 (28)
 [<c037dfdb>] packet_recvmsg+0x6b/0x1b0 (28)
 [<c0306942>] sock_recvmsg+0x122/0x160 (52)
 [<c013ec80>] autoremove_wake_function+0x0/0x50 (104)
 [<c01223d9>] dependent_sleeper+0x109/0x460 (20)
 [<c017b2c5>] fget+0x75/0xa0 (64)
 [<c03080ae>] sys_recvfrom+0xce/0x140 (32)
 [<c0142317>] hrtimer_start+0xa7/0x100 (40)
 [<c012ce9a>] do_setitimer+0x15a/0x570 (40)
 [<c0156860>] filemap_nopage+0x0/0x3c0 (16)
 [<c0308a28>] sys_socketcall+0x1f8/0x2a0 (96)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (60)
modprobe      [f75f2a70]D 00000001  6060  1210    562                     (NOTLB)
f5153e08 00000019 00000048 00000001 00000000 339e924e 0000000d 0000115d 
       f75f2ba8 f75f2a70 f760ea70 c1f0f160 33a60bb8 0000000d f7158a70 f7158f8c 
       f5152000 00800100 ffffffff f5153e30 c037ffc5 c0142fbe 00000004 00000000 
Call Trace:
 [<c037ffc5>] schedule+0xa5/0x120 (84)
 [<c0142fbe>] task_blocks_on_lock+0x11e/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0148bef>] use_module+0xaf/0x150 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0148bef>] use_module+0xaf/0x150 (28)
 [<f88e5d7c>] snd_pcm_new+0x0/0x15c [snd_pcm] (12)
 [<c01497a0>] resolve_symbol+0xb0/0xc0 (16)
 [<c0149cd7>] simplify_symbols+0x77/0x140 (40)
 [<c0148a2f>] setup_modinfo_srcversion+0xf/0x20 (8)
 [<c0148a20>] setup_modinfo_srcversion+0x0/0x20 (4)
 [<c014ac34>] load_module+0x6e4/0xb00 (28)
 [<c014b0c8>] sys_init_module+0x58/0x200 (148)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (24)
udevd         [f76fda70]D C016122B  7460  1212    703          1213  1196 (NOTLB)
f5305ef8 00000000 ffc2fd98 c016122b c1e59860 3396197a 0000000d 000009ea 
       f76fdba8 f76fda70 f7603a70 c1f1f160 33a50006 0000000d 0000000d c1f215c8 
       f5304000 00800040 ffffffff f5305f20 c037ffc5 c0142f53 00000004 f5109e80 
Call Trace:
 [<c016122b>] kunmap_high+0x9b/0xf0 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0188258>] getname+0x28/0xf0 (28)
 [<c0101f58>] sys_execve+0x18/0x90 (20)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)
udevd         [f7603a70]D C016122B  7384  1213    703                1212 (NOTLB)
f5249ef8 00000000 ffc47d98 c016122b c1e885e8 33a54edb 0000000d 00001264 
       f7603ba8 f7603a70 f7161a70 c1f1f160 33a67560 0000000d 800099c4 c1f215c8 
       f5248000 00800040 ffffffff f5249f20 c037ffc5 c0142f53 00000004 f7c03f14 
Call Trace:
 [<c016122b>] kunmap_high+0x9b/0xf0 (16)
 [<c037ffc5>] schedule+0xa5/0x120 (68)
 [<c0142f53>] task_blocks_on_lock+0xb3/0x150 (4)
 [<c0143343>] ____down_mutex+0x93/0x190 (36)
 [<c0188258>] getname+0x28/0xf0 (76)
 [<c01768ee>] kmem_cache_alloc+0x4e/0xe0 (4)
 [<c0188258>] getname+0x28/0xf0 (28)
 [<c0101f58>] sys_execve+0x18/0x90 (20)
 [<c0103447>] sysenter_past_esp+0x54/0x75 (20)

--=-5XQvD7tp3Bd9/zY1rucg--

