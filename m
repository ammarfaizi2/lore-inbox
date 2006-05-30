Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWE3VnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWE3VnH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWE3VnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:43:07 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:224 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932497AbWE3VnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:43:05 -0400
Date: Tue, 30 May 2006 22:43:00 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Arjan van de Ven <arjan@infradead.org>
Cc: Laurent Riffard <laurent.riffard@free.fr>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <1149024287.3636.121.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0605302236480.1247@skynet.skynet.ie>
References: <20060530022925.8a67b613.akpm@osdl.org>  <447CB42E.5060004@free.fr>
 <1149024287.3636.121.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="29444707-192468956-1149025380=:1247"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--29444707-192468956-1149025380=:1247
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 May 2006, Arjan van de Ven wrote:

> On Tue, 2006-05-30 at 23:07 +0200, Laurent Riffard wrote:
>> Le 30.05.2006 11:29, Andrew Morton a =C3=A9crit :
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc=
5/2.6.17-rc5-mm1/
>>> ...
>>>  Runtime locking validation.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>> [ BUG: illegal lock usage! ]
>> ----------------------------
>> illegal {hardirq-on-W} -> {in-hardirq-W} usage.
>> events/0/4 [HC1[1]:SC0[0]:HE0:SE1] takes:
>>  (&list->lock){+...}, at: [<c0247689>] skb_dequeue+0x12/0x43
>
> hmmm skb_dequeue is called in a hard irq...
>
>
>
>> {hardirq-on-W} state was registered at:
>>   [<c012d2a1>] lockdep_acquire+0x56/0x6f
>>   [<c029595b>] _spin_lock_bh+0x1c/0x29
>>   [<c02922e0>] unix_stream_connect+0x2d8/0x3a7
>
> .. yet it was taken only with spin_lock_bh() in unix_stream_connect,
> leaving interrupts enabled (and thus not allowing use inside a hard irq)
>
>>   [<c0243fb4>] sys_connect+0x54/0x71
>>   [<c0244c5c>] sys_socketcall+0x6f/0x166
>>   [<c0295afd>] sysenter_past_esp+0x56/0x8d
>> irq event stamp: 1886
>> hardirqs last  enabled at (1885): [<c0295a2b>] _spin_unlock_irqrestore+0=
x35/0x3b
>> hardirqs last disabled at (1886): [<c01032fb>] common_interrupt+0x1b/0x2=
c
>> softirqs last  enabled at (0): [<c0114af0>] copy_process+0x265/0x11dc
>> softirqs last disabled at (0): [<00000000>] init+0x3feffde0/0x1da
>>
>> other info that might help us debug this:
>> no locks held by events/0/4.
>>
>> stack backtrace:
>>  [<c0103810>] show_trace_log_lvl+0x4b/0xf4
>>  [<c0103e11>] show_trace+0xd/0x10
>>  [<c0103e58>] dump_stack+0x19/0x1b
>>  [<c012b8be>] print_usage_bug+0x1a4/0x1ae
>>  [<c012c3c6>] mark_lock+0x8a/0x411
>>  [<c012cc55>] __lockdep_acquire+0x302/0x8f8
>>  [<c012d2a1>] lockdep_acquire+0x56/0x6f
>>  [<c0295906>] _spin_lock_irqsave+0x20/0x2f
>>  [<c0247689>] skb_dequeue+0x12/0x43
>>  [<e0bdb7ac>] hpsb_bus_reset+0x55/0xa2 [ieee1394]
>
> yet hpsb_bus_reset() calls skb_dequeue (indirectly, via the inlined
> abort_requests() function) in a hard irq.
>

On x86_64, I'm seeing what may be flakiness related to skb_dequeue. I=20
haven't had a chance to look too closely, but the serial excerpt I have is=
=20
below. The real BUG of interest is near the end with

  BUG: sleeping function called from invalid context at include/linux/rwsem=
=2Eh:49

At the time of failure, a kernel compile was taking place. I've also seen=
=20
one ppc machine (not ppc64) lock up. There was no output to console so it=
=20
may or may not be related.

INIT: version 2.86 booting
                 Welcome to Fedora Core
                 Press 'I' to enter interactive startup.
Setting clock  (localtime): Tue May 30 11:04:10 CDT 2006 [  OK  ]
Starting udev: [  OK  ]
Setting hostname bl6-13.ltc.austin.ibm.com:  [  OK  ]
Setting up Logical Volume Management:   2 logical volume(s) in volume group=
 "VolGroup00" now active
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/VolGroup00/LogVol00=20
/dev/VolGroup00/LogVol00: clean, 275453/7929856 files, 2546251/7929856 bloc=
ks
[/sbin/fsck.ext3 (1) -- /boot] fsck.ext3 -a /dev/sda1=20
/boot: clean, 62/512512 files, 43374/512064 blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling swap space:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Starting readahead_early:  Starting background readahead: [  OK  ]
[  OK  ]
FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.17-rc5-mm1-autokern1/=
kernel/arch/x86_64/kernel/cpufreq/acpi-cpufreq.ko): No such device
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth1:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting irqbalance: [  OK  ]
Starting portmap: [  OK  ]
Starting NFS statd: [  OK  ]
Starting RPC idmapd: FATAL: Module sunrpc not found.
FATAL: Error running install command for sunrpc
Starting system message bus: [  OK  ]
Starting Bluetooth services:[  OK  ][  OK  ]
Mounting other filesystems:  [  OK  ]
Starting hidd: [  OK  ]
Starting automount: [  OK  ]
Starting smartd: [  OK  ]
Starting acpi daemon: [  OK  ]
Starting hpiod: [  OK  ]
Starting hpssd: [  OK  ]
Starting cups: [  OK  ]
Starting sshd: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting anacron: [  OK  ]
Starting atd: [  OK  ]
Starting Avahi daemon: [  OK  ]
Starting cups-config-daemon: [  OK  ]
Starting HAL daemon: [  OK  ]

Fedora Core release 5 (Bordeaux)
Kernel 2.6.17-rc5-mm1-autokern1 on an x86_64

bl6-13.ltc.austin.ibm.com login: -- 0:conmux-control -- time-stamp -- May/3=
0/06  9:04:37 --
-- 0:conmux-control -- time-stamp -- May/30/06  9:08:26 --
NMI Watchdog detected LOCKUP on CPU 2
CPU 2=20
Modules linked in: ipv6 ppdev hidp rfcomm l2cap bluetooth video sony_acpi b=
utton battery asus_acpi ac lp parport_pc parport nvram
Pid: 25254, comm: cc1 Not tainted 2.6.17-rc5-mm1-autokern1 #1
RIP: 0010:[<ffffffff810814de>]  [<ffffffff810814de>] cache_alloc_refill+0x1=
6a/0x200
RSP: 0018:ffff81001d9edb88  EFLAGS: 00000097
RAX: 00000000ffffffff RBX: 000000000000000f RCX: ffff81001d9edcd4
RDX: ffff8100016df440 RSI: ffff81003c0cc000 RDI: ffff810037fd9400
RBP: ffff81003c0cc000 R08: ffff810037fda000 R09: ffff810037fd7000
R10: ffff81001d9ec000 R11: 0000000000000246 R12: ffff8100016df440
R13: ffff810037fda000 R14: 000000000000002c R15: ffff810037fd9400
FS:  00002b18bc9bcd30(0000) GS:ffff810037e09bc0(0063) knlGS:00000000f7f9e6b=
0
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 00000000f665c000 CR3: 000000001af2d000 CR4: 00000000000006e0
Process cc1 (pid: 25254, threadinfo ffff81001d9ec000, task ffff81003e048050=
)
Stack: 000000d000000246 0000000000000246 00000000000000d0 ffff810037fd9400
        ffff810037fd9400 ffff81001d9edd68 0000000000000000 ffffffff81082a00
        ffff81003b7b14c0 00000000000000d0=20
Call Trace:
  [<ffffffff81082a00>] kmem_cache_alloc+0x7c/0x86
  [<ffffffff8122e081>] __alloc_skb+0x30/0x11d
  [<ffffffff8122c6e8>] sock_alloc_send_skb+0x6d/0x1ea
  [<ffffffff8102c0d5>] __wake_up+0x36/0x4d
  [<ffffffff8128949d>] unix_stream_sendmsg+0x14d/0x2ff
  [<ffffffff81229fad>] do_sock_write+0xc7/0xd2
  [<ffffffff8122a0fd>] sock_aio_write+0x4f/0x5e
  [<ffffffff81086f28>] do_sync_write+0xc9/0x106
  [<ffffffff812924f2>] do_page_fault+0x46f/0x7b0
  [<ffffffff81046b6c>] autoremove_wake_function+0x0/0x2e
  [<ffffffff810731f4>] do_mmap_pgoff+0x673/0x774
  [<ffffffff8108704c>] vfs_write+0xe7/0x175
  [<ffffffff8108718d>] sys_write+0x45/0x6e
  [<ffffffff81022994>] cstar_do_call+0x1b/0x65


Code: 49 8b 04 24 48 89 68 08 48 89 45 00 4c 89 65 08 49 89 2c 24=20
console shuts up ...
  NMI Watchdog detected LOCKUP on CPU 1
CPU 1=20
Modules linked in: ipv6 ppdev hidp rfcomm l2cap bluetooth video sony_acpi b=
utton battery asus_acpi ac lp parport_pc parport nvram
Pid: 15, comm: events/1 Not tainted 2.6.17-rc5-mm1-autokern1 #1
RIP: 0010:[<ffffffff81135167>]  [<ffffffff81135167>] __delay+0xa/0x10
RSP: 0018:ffff810037f43d80  EFLAGS: 00000012
RAX: 0000000000000008 RBX: ffff8100016df480 RCX: 00000000a155bf6d
RDX: 0000000000000101 RSI: ffff8100016df440 RDI: 0000000000000001
RBP: 000000002e69b72b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffff8100016dfc40 R12: 0000000000000001
R13: 0000000000000000 R14: ffff8100016df440 R15: ffff810037fd9400
FS:  00002b99ea9c72d0(0000) GS:ffff81003efb98c0(0000) knlGS:00000000f7fdb6b=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00000000009afb30 CR3: 000000003ebc6000 CR4: 00000000000006e0
Process events/1 (pid: 15, threadinfo ffff810037f42000, task ffff810037fef0=
50)
Stack: ffffffff81140cfc 0000000000000000 ffff8100016df440 ffff810037fda400
        ffffffff81081c7a ffff8100016df440 0000000000000000 ffff8100016df440
        ffff81003ebd7880 ffff810037fd9400=20
Call Trace:
  [<ffffffff81140cfc>] _raw_spin_lock+0x8b/0xf1
  [<ffffffff81081c7a>] drain_array+0x51/0xd3
  [<ffffffff810837af>] cache_reap+0x0/0x2ce
  [<ffffffff8108389b>] cache_reap+0xec/0x2ce
  [<ffffffff810837af>] cache_reap+0x0/0x2ce
  [<ffffffff81043354>] run_workqueue+0xa1/0xeb
  [<ffffffff8104339e>] worker_thread+0x0/0x137
  [<ffffffff810434a3>] worker_thread+0x105/0x137
  [<ffffffff8102c02e>] default_wake_function+0x0/0xe
  [<ffffffff8102c02e>] default_wake_function+0x0/0xe
  [<ffffffff81046652>] kthread+0x107/0x133
  [<ffffffff8104339e>] worker_thread+0x0/0x137
  [<ffffffff8100a146>] child_rip+0x8/0x12
  [<ffffffff8104339e>] worker_thread+0x0/0x137
  [<ffffffff8104654b>] kthread+0x0/0x133
  [<ffffffff8100a13e>] child_rip+0x0/0x12


Code: 48 39 f8 72 f5 c3 65 8b 04 25 24 00 00 00 48 98 48 69 c0 c0=20
console shuts up ...
  <1>Unable to handle kernel NULL pointer dereference at 0000000000000008 R=
IP:
  [<ffffffff8122f9aa>] skb_dequeue+0x2c/0x50
PGD 330cf067 PUD 0=20
Oops: 0002 [1] SMP=20
last sysfs file: /block/sda/sda1/size
CPU 0=20
Modules linked in: ipv6 ppdev hidp rfcomm l2cap bluetooth video sony_acpi b=
utton battery asus_acpi ac lp parport_pc parport nvram
Pid: 1871, comm: sshd Not tainted 2.6.17-rc5-mm1-autokern1 #1
RIP: 0010:[<ffffffff8122f9aa>]  [<ffffffff8122f9aa>] skb_dequeue+0x2c/0x50
RSP: 0018:ffff810032c81c28  EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff810032a96510 RCX: 000000000000003f
RDX: 000000000000001f RSI: 0000000000000246 RDI: ffff810032a96528
RBP: ffff81003c0cc2c0 R08: 0000000100000000 R09: 0000000000000246
R10: 0000000000000246 R11: 000000000000001a R12: ffff810032a96528
R13: ffff810032c81da0 R14: ffff810032c81d68 R15: 0000000000000000
FS:  00002ac772097be0(0000) GS:ffffffff8146e000(0000) knlGS:00000000f7fad6b=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000003d28b000 CR4: 00000000000006e0
Process sshd (pid: 1871, threadinfo ffff810032c80000, task ffff810037f4c7d0=
)
Stack: ffff810032a96510 ffff81003c0cc2c0 ffff810032a96440 ffffffff812899a6
        ffffffa100000001 0000001a00000001 0000000000000000 00000040000000d0
        0000000000003fe6 ffff81003280c180=20
Call Trace:
  [<ffffffff812899a6>] unix_stream_recvmsg+0x101/0x4bf
  [<ffffffff8122c946>] release_sock+0x10/0xae
  [<ffffffff81258520>] tcp_sendmsg+0x9b0/0xa82
  [<ffffffff81229d87>] do_sock_read+0xc6/0xd1
  [<ffffffff81229ed7>] sock_aio_read+0x4f/0x5e
  [<ffffffff81086cb0>] do_sync_read+0xc9/0x106
  [<ffffffff81046b6c>] autoremove_wake_function+0x0/0x2e
  [<ffffffff812905e8>] _spin_unlock_irq+0x6/0xa
  [<ffffffff8128e4e5>] thread_return+0x64/0xec
  [<ffffffff81086dd1>] vfs_read+0xe4/0x172
  [<ffffffff8108711f>] sys_read+0x45/0x6e
  [<ffffffff810092be>] system_call+0x7e/0x83


Code: 48 89 58 08 48 c7 45 00 00 00 00 00 48 c7 45 08 00 00 00 00=20
RIP  [<ffffffff8122f9aa>] skb_dequeue+0x2c/0x50 RSP <ffff810032c81c28>
CR2: 0000000000000008
  <3>BUG: sleeping function called from invalid context at include/linux/rw=
sem.h:49
in_atomic():0, irqs_disabled():1

Call Trace:
  [<ffffffff81029ba0>] __might_sleep+0xc0/0xc2
  [<ffffffff810403ed>] blocking_notifier_call_chain+0x1f/0x4e
  [<ffffffff81035a8a>] do_exit+0x22/0x8ce
  [<ffffffff81184817>] do_unblank_screen+0x29/0x121
  [<ffffffff812927c5>] do_page_fault+0x742/0x7b0
  [<ffffffff81029f49>] activate_task+0x4b/0x99
  [<ffffffff81098aad>] __pollwait+0x0/0xdd
  [<ffffffff81009f8d>] error_exit+0x0/0x84
  [<ffffffff8122f9aa>] skb_dequeue+0x2c/0x50
  [<ffffffff8122f993>] skb_dequeue+0x15/0x50
  [<ffffffff812899a6>] unix_stream_recvmsg+0x101/0x4bf
  [<ffffffff8122c946>] release_sock+0x10/0xae
  [<ffffffff81258520>] tcp_sendmsg+0x9b0/0xa82
  [<ffffffff81229d87>] do_sock_read+0xc6/0xd1
  [<ffffffff81229ed7>] sock_aio_read+0x4f/0x5e
  [<ffffffff81086cb0>] do_sync_read+0xc9/0x106
  [<ffffffff81046b6c>] autoremove_wake_function+0x0/0x2e
  [<ffffffff812905e8>] _spin_unlock_irq+0x6/0xa
  [<ffffffff8128e4e5>] thread_return+0x64/0xec
  [<ffffffff81086dd1>] vfs_read+0xe4/0x172
  [<ffffffff8108711f>] sys_read+0x45/0x6e
  [<ffffffff810092be>] system_call+0x7e/0x83

NMI Watchdog detected LOCKUP on CPU 3
CPU 3=20
Modules linked in: ipv6 ppdev hidp rfcomm l2cap bluetooth video sony_acpi b=
utton battery asus_acpi ac lp parport_pc parport nvram
Pid: 1710, comm: sshd Not tainted 2.6.17-rc5-mm1-autokern1 #1
RIP: 0010:[<ffffffff81140cfc>]  [<ffffffff81140cfc>] _raw_spin_lock+0x8b/0x=
f1
RSP: 0018:ffff81003319db68  EFLAGS: 00000002
RAX: 0000000000000008 RBX: ffff8100016df480 RCX: 00000000b3e3ec80
RDX: 0000000000000105 RSI: 00000000000000d0 RDI: 0000000000000001
RBP: 000000001713db5d R08: ffff81003c0d0440 R09: ffff81003d177340
R10: 00005555556bf377 R11: 0000000000000246 R12: 0000000000000001
R13: ffff810037fd8c00 R14: 000000000000003c R15: ffff810037fd9400
FS:  00002b2015099be0(0000) GS:ffff8100016dfec0(0000) knlGS:00000000f7fb26b=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00005555556bf168 CR3: 00000000348c8000 CR4: 00000000000006e0
Process sshd (pid: 1710, threadinfo ffff81003319c000, task ffff810037f57810=
)
Stack: 0000000000000246 00000000000000d0 ffff8100016df440 ffffffff810813ef
        000000d000000246 0000000000000246 00000000000000d0 ffff810037fd9400
        ffff810037fd9400 ffff81003319dd68=20
Call Trace:
  [<ffffffff810813ef>] cache_alloc_refill+0x7b/0x200
  [<ffffffff81082a00>] kmem_cache_alloc+0x7c/0x86
  [<ffffffff8122e081>] __alloc_skb+0x30/0x11d
  [<ffffffff8122c6e8>] sock_alloc_send_skb+0x6d/0x1ea
  [<ffffffff810381e0>] current_fs_time+0x4d/0x52
  [<ffffffff8128949d>] unix_stream_sendmsg+0x14d/0x2ff
  [<ffffffff81229fad>] do_sock_write+0xc7/0xd2
  [<ffffffff8122a0fd>] sock_aio_write+0x4f/0x5e
  [<ffffffff8106f6e8>] do_wp_page+0x38e/0x3c1
  [<ffffffff81086f28>] do_sync_write+0xc9/0x106
  [<ffffffff812924f2>] do_page_fault+0x46f/0x7b0
  [<ffffffff81046b6c>] autoremove_wake_function+0x0/0x2e
  [<ffffffff812905e8>] _spin_unlock_irq+0x6/0xa
  [<ffffffff8128e4e5>] thread_return+0x64/0xec
  [<ffffffff81032628>] do_fork+0x138/0x1b0
  [<ffffffff8108704c>] vfs_write+0xe7/0x175
  [<ffffffff8108718(bot:conmon-payload) disconnected
d>] sys_write+0x45/0x6e
  [<ffffffff810092be>] system_call+0x7e/0x83


Code: eb d9 45 85 e4 74 d2 45 31 e4 65 48 8b 04 25 00 00 00 00 65=20
console shuts up ...

--=20
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
--29444707-192468956-1149025380=:1247--
