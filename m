Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbUKBPw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbUKBPw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUKBPtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:49:01 -0500
Received: from lax-gate1.raytheon.com ([199.46.200.230]:32111 "EHLO
	lax-gate1.raytheon.com") by vger.kernel.org with ESMTP
	id S261376AbUKBPq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:46:26 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Lee Revell <rlrevell@joe-job.com>,
       Paul Davis <paul@linuxaudiosystems.com>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>, "K.R. Foley" <kr@cybsft.com>
From: Mark_H_Johnson@raytheon.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.6.8
Date: Tue, 2 Nov 2004 09:44:25 -0600
Message-ID: <OF7B340ED3.3EE1B145-ON86256F40.005675F6-86256F40.005676E0@raytheon.com>
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 11/02/2004 09:44:31 AM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>i've uploaded a fixed kernel (-V0.6.8) to:
>
>  http://redhat.com/~mingo/realtime-preempt/

OK. Will step up shortly but have some test results from -V0.6.7
that I just collected. The system crashed with LOCKUP messages during
both runs but I did get some real time tests run. No build problems.

First run

[1] boot to single user was uneventful.

[2] telinit 5 was also OK, no atomic underflow warnings.

[3] Logged in, set up my RT settings (udma2, IRQ priorities) and
did a quick sample of wakeup timing. Still appear to have the false
positives, even on an otherwise idle system. For example:

(get_ltrace.sh/3502/CPU#0): new 936 us maximum-latency wakeup.
(kdeinit/3198/CPU#0): new 971 us maximum-latency wakeup.
(cat/3504/CPU#0): new 1776 us maximum-latency wakeup.
(cat/3504/CPU#0): new 5286 us maximum-latency wakeup.
(cat/3504/CPU#0): new 71828 us maximum-latency wakeup.
(cupsd/2061/CPU#1): new 341 us maximum-latency wakeup.
(ksoftirqd/0/3/CPU#0): new 64940 us maximum-latency wakeup.
(get_ltrace.sh/3554/CPU#1): new 1299 us maximum-latency wakeup.
(cat/3556/CPU#1): new 4361 us maximum-latency wakeup.
(cat/3556/CPU#1): new 68847 us maximum-latency wakeup.
(get_ltrace.sh/3582/CPU#1): new 963 us maximum-latency wakeup.
(cat/3584/CPU#1): new 2273 us maximum-latency wakeup.
(cat/3584/CPU#1): new 66211 us maximum-latency wakeup.

At this point, the system locked up and a little bit later dumped
a LOCKUP on the serial console (at end of message).

Second run.

[1] Booting to single user and telinit 5 was uneventful.

[2] Logged in and used
  echo 0 > /proc/sys/kernel/preempt_wakeup_timing
to go back to tracking the long latency locks. Set up RT environment
as well.

[3] Started to collect latency timing data; no false positives during
a few minutes of "idle" time.

[4] Started the real time stress test.
 - X - data looks generally OK with huge (max 13 msec) spikes near
the start and end.
 - top - data is noisy; had a number of periods (up to 1 second) where
the CPU loop was delayed up to a millisecond or so (about 100% overhead)
and some spikes even longer than above (max 22 msec).
 - network output - machine crashed again, a similar lockup problem
to the first run. (dump at end of message)

Something I noticed during these runs. If I moved the mouse up / down, the
audio seemed to change (slightly lower tone). Mouse movements left / right
did not seem to cause such a noticeable change. This may be related to the
spikes in the measured top stress test.

  --Mark

First LOCKUP

NMI Watchdog detected LOCKUP
Pid: 3933, comm:             cpu_burn
EIP: 0073:[<08048340>] CPU: 0
EIP is at 0x8048340
 ESP: 007b:bffffa40 EFLAGS: 00200282    Not tainted  (2.6.9-mm1-RT-V0.6.7)
EAX: 00000000 EBX: 00711ffc ECX: bffffadc EDX: bffffad4
ESI: 00000001 EDI: 007140fc EBP: bffffa48 DS: 007b ES: 007b
CR0: 8005003b CR2: 00681400 CR3: 015735e0 CR4: 000006f0
 [<c0105bec>] show_regs+0x14c/0x174 (36)
 [<c0115f4f>] nmi_watchdog_tick+0x12f/0x140 (28)
 [<c0109c0c>] default_do_nmi+0x6c/0x110 (96)
 [<c0109d2d>] do_nmi+0x6d/0x70 (24)
 [<c0108735>] nmi_stack_correct+0x1e/0x2e (-196314476)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0326a8f>] .... _spin_lock+0x1f/0x70
.....[<c0115f47>] ..   ( <= nmi_watchdog_tick+0x127/0x140)
.. [<c013d7dd>] .... print_traces+0x1d/0x60
.....[<c0105bec>] ..   ( <= show_regs+0x14c/0x174)

 on CPU1, eip c013be90, registers:
Modules linked in: snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi
snd_seq_d
evice snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd
soundcore ipv
6 parport_pc lp parport autofs4 sunrpc 8139too mii floppy sg scsi_mod
microcode
dm_mod uhci_hcd ext3 jbd
CPU:    1
EIP:    0060:[<c013be90>]    Not tainted VLI
EFLAGS: 00200002   (2.6.9-mm1-RT-V0.6.7)
EIP is at ___trace+0x40/0x170
eax: 00017780   ebx: c0445180   ecx: c01e24ea   edx: c0326a81
esi: 00000001   edi: 00200002   ebp: cad35d48   esp: cad35d18
ds: 007b   es: 007b   ss: 0068   preempt: 00010004
Process sleep (pid: 4185, threadinfo=cad34000 task=cb3c2a90)
Stack: c0109cc0 00200002 cad35d54 c0372424 00200002 cad35d44 c0109d2d
cad34000

       c0372420 c0372424 cb3c2a90 00200046 cad35d58 c013bfed c0326a81
c01e2308
       cad35d6c c0114fd8 00000003 c01e24ea c0372428 cad35d80 c0326a81
00000001

Call Trace:
 [<c0108a1f>] show_stack+0x8f/0xb0 (28)
 [<c0108bdf>] show_registers+0x16f/0x1e0 (56)
 [<c0109b5f>] die_nmi+0x5f/0xa0 (24)
 [<c0115f0f>] nmi_watchdog_tick+0xef/0x140 (28)
 [<c0109c0c>] default_do_nmi+0x6c/0x110 (96)
 [<c0109d2d>] do_nmi+0x6d/0x70 (24)
 [<c0108735>] nmi_stack_correct+0x1e/0x2e (116)
 [<c013bfed>] __mcount+0x1d/0x30 (16)
 [<c0114fd8>] mcount+0x14/0x18 (20)
 [<c0326a81>] _spin_lock+0x11/0x70 (20)
 [<c01e2308>] _down_write_trylock+0x58/0x290 (52)
 [<c01e3325>] down_trylock+0x45/0x180 (52)
 [<c0123f95>] vprintk+0xf5/0x170 (36)
 [<c0123e8d>] printk+0x1d/0x30 (16)
 [<c0108945>] show_trace+0x95/0xe0 (32)
 [<c0108a63>] dump_stack+0x23/0x30 (20)
 [<c013c98e>] check_preempt_timing+0x16e/0x300 (76)
 [<c013ce7f>] sub_preempt_count+0x7f/0xf0 (32)
 [<c01147ba>] flush_tlb_mm+0x5a/0x110 (36)
 [<c015965e>] unmap_vmas+0x10e/0x1c0 (56)
 [<c015e60c>] exit_mmap+0x5c/0x130 (56)
 [<c0120c39>] mmput+0x49/0x160 (28)
 [<c0126bf3>] do_exit+0x183/0x5c0 (40)
 [<c0127170>] do_group_exit+0x40/0xe0 (40)
 [<c0107b89>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00010005 ]
| 5-level deep critical section nesting:
----------------------------------------
.. [<c0114783>] .... flush_tlb_mm+0x23/0x110
.....[<c015965e>] ..   ( <= unmap_vmas+0x10e/0x1c0)
.. [<c0326aff>] .... _spin_lock_irqsave+0x1f/0x80
.....[<c0123ecb>] ..   ( <= vprintk+0x2b/0x170)
.. [<c0326a8f>] .... _spin_lock+0x1f/0x70
.....[<c01e24ea>] ..   ( <= _down_write_trylock+0x23a/0x290)
.. [<c0326a8f>] .... _spin_lock+0x1f/0x70
.....[<c0109b22>] ..   ( <= die_nmi+0x22/0xa0)
.. [<c013d7dd>] .... print_traces+0x1d/0x60
.....[<c0108a1f>] ..   ( <= show_stack+0x8f/0xb0)

Code: b8 00 e0 ff ff 89 fe c1 ee 09 21 e0 89 45 ec 83 f6 01 8b 40 10 83 e6
01
69 c0 80 77 01 00 8d 98 00 da 42 c0 f0 ff 80 00 da 42 c0 <8b> 80 00 da 42
c0 48
74 0d f0 ff 0b 57 9d 83 c4 24 5b 5e 5f 5d
console shuts up ...


Second LOCKUP

NMI Watchdog detected LOCKUP
Pid: 3933, comm:             cpu_burn
EIP: 0073:[<08048340>] CPU: 0
EIP is at 0x8048340
 ESP: 007b:bffffa40 EFLAGS: 00200282    Not tainted  (2.6.9-mm1-RT-V0.6.7)
EAX: 00000000 EBX: 00711ffc ECX: bffffadc EDX: bffffad4
ESI: 00000001 EDI: 007140fc EBP: bffffa48 DS: 007b ES: 007b
CR0: 8005003b CR2: 00681400 CR3: 015735e0 CR4: 000006f0
 [<c0105bec>] show_regs+0x14c/0x174 (36)
 [<c0115f4f>] nmi_watchdog_tick+0x12f/0x140 (28)
 [<c0109c0c>] default_do_nmi+0x6c/0x110 (96)
 [<c0109d2d>] do_nmi+0x6d/0x70 (24)
 [<c0108735>] nmi_stack_correct+0x1e/0x2e (-196314476)
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<c0326a8f>] .... _spin_lock+0x1f/0x70
.....[<c0115f47>] ..   ( <= nmi_watchdog_tick+0x127/0x140)
.. [<c013d7dd>] .... print_traces+0x1d/0x60
.....[<c0105bec>] ..   ( <= show_regs+0x14c/0x174)

 on CPU1, eip c013be90, registers:
Modules linked in: snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi
snd_seq_d
evice snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd
soundcore ipv
6 parport_pc lp parport autofs4 sunrpc 8139too mii floppy sg scsi_mod
microcode
dm_mod uhci_hcd ext3 jbd
CPU:    1
EIP:    0060:[<c013be90>]    Not tainted VLI
EFLAGS: 00200002   (2.6.9-mm1-RT-V0.6.7)
EIP is at ___trace+0x40/0x170
eax: 00017780   ebx: c0445180   ecx: c01e24ea   edx: c0326a81
esi: 00000001   edi: 00200002   ebp: cad35d48   esp: cad35d18
ds: 007b   es: 007b   ss: 0068   preempt: 00010004
Process sleep (pid: 4185, threadinfo=cad34000 task=cb3c2a90)
Stack: c0109cc0 00200002 cad35d54 c0372424 00200002 cad35d44 c0109d2d
cad34000

       c0372420 c0372424 cb3c2a90 00200046 cad35d58 c013bfed c0326a81
c01e2308

       cad35d6c c0114fd8 00000003 c01e24ea c0372428 cad35d80 c0326a81
00000001

Call Trace:
 [<c0108a1f>] show_stack+0x8f/0xb0 (28)
 [<c0108bdf>] show_registers+0x16f/0x1e0 (56)
 [<c0109b5f>] die_nmi+0x5f/0xa0 (24)
 [<c0115f0f>] nmi_watchdog_tick+0xef/0x140 (28)
 [<c0109c0c>] default_do_nmi+0x6c/0x110 (96)
 [<c0109d2d>] do_nmi+0x6d/0x70 (24)
 [<c0108735>] nmi_stack_correct+0x1e/0x2e (116)
 [<c013bfed>] __mcount+0x1d/0x30 (16)
 [<c0114fd8>] mcount+0x14/0x18 (20)
 [<c0326a81>] _spin_lock+0x11/0x70 (20)
 [<c01e2308>] _down_write_trylock+0x58/0x290 (52)
 [<c01e3325>] down_trylock+0x45/0x180 (52)
 [<c0123f95>] vprintk+0xf5/0x170 (36)
 [<c0123e8d>] printk+0x1d/0x30 (16)
 [<c0108945>] show_trace+0x95/0xe0 (32)
 [<c0108a63>] dump_stack+0x23/0x30 (20)
 [<c013c98e>] check_preempt_timing+0x16e/0x300 (76)
 [<c013ce7f>] sub_preempt_count+0x7f/0xf0 (32)
 [<c01147ba>] flush_tlb_mm+0x5a/0x110 (36)
 [<c015965e>] unmap_vmas+0x10e/0x1c0 (56)
 [<c015e60c>] exit_mmap+0x5c/0x130 (56)
 [<c0120c39>] mmput+0x49/0x160 (28)
 [<c0126bf3>] do_exit+0x183/0x5c0 (40)
 [<c0127170>] do_group_exit+0x40/0xe0 (40)
 [<c0107b89>] sysenter_past_esp+0x52/0x71 (-8124)
---------------------------
| preempt count: 00010005 ]
| 5-level deep critical section nesting:
----------------------------------------
.. [<c0114783>] .... flush_tlb_mm+0x23/0x110
.....[<c015965e>] ..   ( <= unmap_vmas+0x10e/0x1c0)
.. [<c0326aff>] .... _spin_lock_irqsave+0x1f/0x80
.....[<c0123ecb>] ..   ( <= vprintk+0x2b/0x170)
.. [<c0326a8f>] .... _spin_lock+0x1f/0x70
.....[<c01e24ea>] ..   ( <= _down_write_trylock+0x23a/0x290)
.. [<c0326a8f>] .... _spin_lock+0x1f/0x70
.....[<c0109b22>] ..   ( <= die_nmi+0x22/0xa0)
.. [<c013d7dd>] .... print_traces+0x1d/0x60
.....[<c0108a1f>] ..   ( <= show_stack+0x8f/0xb0)

Code: b8 00 e0 ff ff 89 fe c1 ee 09 21 e0 89 45 ec 83 f6 01 8b 40 10 83 e6
01
69 c0 80 77 01 00 8d 98 00 da 42 c0 f0 ff 80 00 da 42 c0 <8b> 80 00 da 42
c0 48
74 0d f0 ff 0b 57 9d 83 c4 24 5b 5e 5f 5d
console shuts up ...

