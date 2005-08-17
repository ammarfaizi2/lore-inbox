Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbVHQQOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbVHQQOP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 12:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbVHQQOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 12:14:15 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:18934 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751156AbVHQQOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 12:14:14 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1124288677.5764.154.camel@localhost.localdomain>
References: <1124208507.5764.20.camel@localhost.localdomain>
	 <20050816163202.GA5288@elte.hu> <20050816163730.GA7879@elte.hu>
	 <20050816165247.GA10386@elte.hu> <20050816170805.GA12959@elte.hu>
	 <1124214647.5764.40.camel@localhost.localdomain>
	 <1124215631.5764.43.camel@localhost.localdomain>
	 <1124218245.5764.52.camel@localhost.localdomain>
	 <1124252419.5764.83.camel@localhost.localdomain>
	 <1124257580.5764.105.camel@localhost.localdomain>
	 <20050817064750.GA8395@elte.hu>
	 <1124287505.5764.141.camel@localhost.localdomain>
	 <1124288677.5764.154.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 12:13:34 -0400
Message-Id: <1124295214.5764.163.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 10:24 -0400, Steven Rostedt wrote:

> OK the output from netconsole still seems like netconsole itself is
> causing some problems.  But I think it is also showing this lockup. I'll
> recompile my kernel as UP and see if netconsole works fine.

Well, the UP kernel boots on my laptop, but netconsole gives strange
warnings. 

OK, what's the scoop with the illegal_API_call?  What is it about, and
what is the expected work around?

I'm also getting the following output on shutdown:

NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.7
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM ver 1.5
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
BUG: nonzero lock count 1 at exit time?
            nfsd: 4696 [f7183830, 115]
 [<c0136922>] check_no_held_locks+0x62/0x330 (8)
 [<c011df67>] do_exit+0x257/0x480 (32)
 [<c013d052>] __module_put_and_exit+0x52/0x70 (40)
 [<f8d54583>] nfsd+0x2b3/0x340 [nfsd] (12)
 [<f8d542d0>] nfsd+0x0/0x340 [nfsd] (48)
 [<c010140d>] kernel_thread_helper+0x5/0x18 (16)
---------------------------
| preempt count: 00000000 ]
| 0-level deep critical section nesting:
----------------------------------------

------------------------------
| showing all locks held by: |  (nfsd/4696 [f7183830, 116]):
------------------------------

#001:             [c038e184] {kernel_sem.lock}
... acquired at:               lock_kernel+0x21/0x40

BUG: nfsd/4696, BKL held at task exit time!


And it goes on and on. This happens everytime. Without netconsole, I
only get the nonzero lock count error. Also, one of my lockups on SMP
had to do with the kernel_thread_helper:

Using IPI Shortcut mode
khelper/794[CPU#0]: BUG in set_new_owner at kernel/rt.c:916
NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 24, comm:              khelper
EIP: 0060:[<c0140368>] CPU: 1
EIP is at up_mutex+0x98/0x440
 EFLAGS: 00000082    Not tainted  (2.6.13-rc6-rt6)
EAX: c04278a4 EBX: cf68feec ECX: 00000206 EDX: c0396b8c
ESI: cf68fec8 EDI: 00000246 EBP: c011c191 DS: 007b ES: 007b
CR0: 8005003b CR2: 00000000 CR3: 00478000 CR4: 000006d0
 [<c011c191>] complete+0x51/0x80 (40)
 [<c0133fef>] worker_thread+0x1cf/0x290 (40)
 [<c0133a60>] __call_usermodehelper+0x0/0x70 (24)
 [<c011bf70>] default_wake_function+0x0/0x30 (28)
 [<c011bf70>] default_wake_function+0x0/0x30 (32)
 [<c032fc6b>] schedule+0x4b/0x120 (12)
 [<c0133e20>] worker_thread+0x0/0x290 (24)
 [<c0139c5a>] kthread+0xba/0xc0 (4)
 [<c0139ba0>] kthread+0x0/0xc0 (28)
 [<c0101385>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c014201a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (khelper/24 [c19df120, 111]):
------------------------------

NMI watchdog detected lockup on CPU#0 (50000/50000)

Pid: 794, comm:              khelper
EIP: 0060:[<c013ef1f>] CPU: 0
EIP is at __down_trylock+0x9f/0x330
 EFLAGS: 00000082    Not tainted  (2.6.13-rc6-rt6)
EAX: c0395238 EBX: 00000000 ECX: 00008000 EDX: 000043b0
ESI: c0395224 EDI: cf4d2000 EBP: 00000086 DS: 007b ES: 007b
CR0: 8005003b CR2: fff3f000 CR3: 00478000 CR4: 000006d0
 [<c0141033>] rt_down_trylock+0x33/0x480 (44)
 [<c0121db2>] vprintk+0x162/0x240 (8)
 [<c020986b>] vscnprintf+0x2b/0x40 (8)
 [<c0121db2>] vprintk+0x162/0x240 (24)
 [<c014201a>] add_preempt_count+0x1a/0x20 (36)
 [<c0333059>] _raw_spin_lock+0x19/0xa0 (12)
 [<c01420ca>] sub_preempt_count+0x1a/0x20 (12)
 [<c0141f27>] add_preempt_count_ti+0x27/0x100 (4)
 [<c014201a>] add_preempt_count+0x1a/0x20 (28)
 [<c0121c47>] printk+0x17/0x20 (20)
 [<c0122587>] __WARN_ON+0x67/0x90 (12)
 [<c033100a>] __down_mutex+0x2fa/0x5d0 (48)
 [<c01247f0>] do_exit+0x170/0x490 (112)
 [<c01419cd>] atomic_dec_and_spin_lock+0x2d/0x80 (8)
 [<c01247f0>] do_exit+0x170/0x490 (8)
 [<c01247f0>] do_exit+0x170/0x490 (20)
 [<c01339a8>] ____call_usermodehelper+0xe8/0xf0 (40)
 [<c01338c0>] ____call_usermodehelper+0x0/0xf0 (12)
 [<c0101385>] kernel_thread_helper+0x5/0x10 (12)
---------------------------
| preempt count: 00000003 ]
| 3-level deep critical section nesting:
----------------------------------------
.. [<c014201a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)
.. [<c014201a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)
.. [<c014201a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

------------------------------
| showing all locks held by: |  (khelper/794 [cf4f3740, 112]):
------------------------------


-- Steve


