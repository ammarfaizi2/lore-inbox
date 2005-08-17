Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbVHQOYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbVHQOYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbVHQOYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:24:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:10459 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751141AbVHQOYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:24:53 -0400
Subject: Re: 2.6.13-rc6-rt6
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1124287505.5764.141.camel@localhost.localdomain>
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
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 17 Aug 2005 10:24:37 -0400
Message-Id: <1124288677.5764.154.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 10:05 -0400, Steven Rostedt wrote:
> On Wed, 2005-08-17 at 08:47 +0200, Ingo Molnar wrote:
> 
> > 
> > unfortunately the space of "patches that break the kernel" is infinitely 
> > larger (and infinitely easier to generate) than the space of "patches 
> > that improve the kernel" - so i'll skip your patch for now ;-)
> 
> Yeah, I took out my "bad" fix and it still locks up. Since I got the NMI
> working I was able to get output. Unfortunately, the laptop doesn't have
> a serial (damn vendors getting rid of the very useful _for us_ uart).
> And so far the netconsole doesn't seem to be working yet. 
> 

Silly me, I never compiled netconsole into the kernel for my laptop
(I've done it on all my other machines that happen to have a serial!).

OK the output from netconsole still seems like netconsole itself is
causing some problems.  But I think it is also showing this lockup. I'll
recompile my kernel as UP and see if netconsole works fine.

Here's what netconsole shows:

netconsole: device eth0 not up yet, forcing it
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
softirq-net-rx//6[CPU#0]: BUG in up_mutex at kernel/rt.c:1945
 [<c012258c>] __WARN_ON+0x6c/0x90 (8)
 [<c02d3c4a>] net_rx_action+0x15a/0x1e0 (44)
 [<c01406e0>] up_mutex+0x410/0x440 (4)
 [<c02d3c4a>] net_rx_action+0x15a/0x1e0 (40)
 [<c0127b40>] ksoftirqd+0xf0/0x170 (40)
 [<c0127a50>] ksoftirqd+0x0/0x170 (32)
 [<c0139c5a>] kthread+0xba/0xc0 (4)
 [<c0139ba0>] kthread+0x0/0xc0 (28)
 [<c0101385>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c014201a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

[... a bunch more dumps ...]

netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1

[... normal output ...]

Freeing unused kernel memory: 296k freed
BUG: using smp_processor_id() in preemptible [00000000] code:
kjournald/795
caller is netpoll_send_skb+0x38/0x100
 [<c020bb74>] debug_smp_processor_id+0xb4/0xc0 (8)
 [<c02e1e48>] netpoll_send_skb+0x38/0x100 (8)
 [<c02e1e48>] netpoll_send_skb+0x38/0x100 (20)
 [<c02ad327>] write_msg+0x67/0xd0 (24)
 [<c0121962>] __call_console_drivers+0x62/0x70 (32)
 [<c0121ab3>] call_console_drivers+0xb3/0x150 (28)
 [<c0121f81>] release_console_sem+0x51/0xf0 (36)
 [<c0121dda>] vprintk+0x18a/0x240 (28)
 [<c011c05b>] __wake_up+0x4b/0x80 (76)
 [<c0121c47>] printk+0x17/0x20 (36)
 [<c01d4e01>] kjournald+0x91/0x250 (12)
 [<c01420ca>] sub_preempt_count+0x1a/0x20 (28)
 [<c0333502>] _raw_spin_unlock+0x12/0x30 (12)
 [<c01420ca>] sub_preempt_count+0x1a/0x20 (20)
 [<c011a507>] schedule_tail+0x87/0x110 (12)
 [<c01d4d50>] commit_timeout+0x0/0x10 (32)
 [<c01d4d70>] kjournald+0x0/0x250 (32)
 [<c0101385>] kernel_thread_helper+0x5/0x10 (16)
---------------------------
| preempt count: 00000001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<c014201a>] .... add_preempt_count+0x1a/0x20
.....[<00000000>] ..   ( <= stext+0x3feffd68/0x8)

[ looks like the above is the NMI going off and netconsole screaming ]

[... a bunch more smp_processor_id() bug outputs ...]
[ then ...]
Hotplug/796[CPU#1]: BUG in set_new_owner at kernel/rt.c:916
NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 796, comm:              hotplug

----

Then no more output.  So netconsole sort of works, but seems to croak on
a NMI. It may be best if I keep netconsole off. Or do you have any
better ideas?

> Here's the output (typed from screen).
> 
> Freeing unused kernel memory: 296k freed
> NMI watchdog detected lockup on CPU#1 (50000/50000)
> 
> Pid: 796, comm:  hotplug
> EIP: 0060:[<c0331662>] CPU: 1
> EIP is at _raw_spin_lock+0x72/0xa0
> EFLAGS: 00000002 Not tainted (2.6.13-rc6-rt6)
> EXI: 00000001 EBX: .... (I'm not about to type all the registers out).
> [...]
> try_to_wake_up+0x4e
> __reacquire_kernel_lock+0x2d
> pick_new_owner+0x6b
> wake_up_process+0x30
> rt_up+0x290
> chrdev_open+0xfd
> lock_kernel+0x28
> chrdev_open+0xfd
> tty_open+0x0
> chrdev_open+0xfd
> file_move+0x20
> dentry_open+0x17a
> filp_open+0x68
> _spin_lock+0x23
> get_unused_fd+0xa2
> sys_open+0x4f
> syscall_call+0x7
> ----
> preempt count: 3
> 3-level deep critical section nesting:
> ----
> rt_up+0x2c
> add_preempt_count+0x1a
> add_preempt_count+0x1a
> ----
> showing all locks held by: (hotplug/796 [...]) 
> 
> - No locks where shown.
> 

I kept the above just to see what is shown without netconsole, but I
only get a screen shot with it.

If worse comes to worse, I'll switch the testing to my main machine (AMD
SMP) and see if it crashes. It's just that this is the machine that I do
my email with. But at least it has a serial.

-- Steve


