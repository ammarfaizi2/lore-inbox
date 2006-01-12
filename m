Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWALCPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWALCPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWALCPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:15:07 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:10459 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964972AbWALCPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:15:05 -0500
Subject: Re: [ANNOUNCE] 2.6.15-rc5-hrt2 - hrtimers based high resolution
	patches
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: George Anzinger <george@mvista.com>, tglx@linutronix.de,
       john stultz <johnstul@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1136937547.6197.73.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1136937547.6197.73.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 21:14:32 -0500
Message-Id: <1137032072.6197.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finally!  I did it.  I have an updated timer_stress test at 
http://www.kihontech.com/tests/rt/timer_stress.c
that triggers the deadlock that I have been mentioning (and hit once in
my kernel).  But this time I hit it in 2.6.15-rt4-sr1 and got the
following output:

On my SMP machine I got this (this is even before I changed the test to
do intervals:

============================================
BUG: Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c0138ead
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: binfmt_misc nfsd exportfs lockd sunrpc lp capability commoncap sd_mod usb_storage scsi_mod usbhid usblp psmouse serio_raw snd_emu10k1_synth snd_emux_synth snd_seq_virmidi snd_seq_midi_emul snd_seq_dummy snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq 3c59x mii floppy snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm ohci_hcd snd_timer snd_ac97_bus snd_page_alloc snd_util_mem snd_hwdep parport_pc parport snd soundcore rtc
ide_cd cdrom pcspkr shpchp pci_hotplug hw_random joydev evdev mousedev unix
CPU:    1
EIP:    0060:[<c0138ead>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15-rt4-sr1)
EIP is at __remove_hrtimer+0x3d/0x70
eax: 00200200   ebx: f738a424   ecx: f738a44c   edx: 00100100
esi: c20201b4   edi: f738a424   ebp: f4d7deb0   esp: f4d7dea0
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process timer_stress (pid: 6035, threadinfo=f4d7c000 task=f6fa2070 stack_left=7788 worst_left=-1)
Stack: c0138775 00000000 00000000 c20201b4 f4d7ded8 c0138f0f f738a424 c20201b4
       00000286 00000000 00000286 00000000 3b9aca00 f4d7df98 f4d7def4 c013902e
       f738a424 0000c350 00000000 00000001 00000001 f4d7df74 c0123fd3 f738a424
Call Trace:
 [<c01040dc>] show_stack+0x9c/0xe0 (28)
 [<c01042c4>] show_registers+0x184/0x240 (60)
 [<c0104522>] die+0x102/0x190 (56)
 [<c0115e7b>] do_page_fault+0x20b/0x5a0 (76)
 [<c0103d5f>] error_code+0x4f/0x54 (76)
 [<c0138f0f>] __hrtimer_start+0x2f/0x120 (40)
 [<c013902e>] hrtimer_start+0x2e/0x30 (28)
 [<c0123fd3>] do_setitimer+0x573/0x5c0 (128)
 [<c0124062>] sys_setitimer+0x42/0xb0 (64)
 [<c01031e5>] syscall_call+0x7/0xb (-8116)
Code: 83 7b 18 03 74 1c 39 5e 10 74 3b 8d 46 0c 89 1c 24 89 44 24 04 e8 f4 fc 0b
00 8b 5d f8 8b 75 fc c9 c3 8d 4b 28 8b 53 28 8b 41 04 <89> 42 04 89 10 c7 41 04 00 02 20 00 c7 43 28 00 01 10 00 8b 5d
 NMI watchdog detected lockup on CPU#1 (50000/50000)

Pid: 6035, comm:         timer_stress
EIP: 0060:[<c02fbce4>] CPU: 1
EIP is at _raw_spin_lock+0x14/0x20
 EFLAGS: 00000082    Not tainted  (2.6.15-rt4-sr1)
EAX: c20201b8 EBX: 00000000 ECX: a7fb63da EDX: f4d7c000
ESI: c20201d4 EDI: c20201b4 EBP: f4d7dd34 DS: 007b ES: 007b
CR0: 8005003b CR2: 00100104 CR3: 34d33000 CR4: 000006d0
 [<c01012e2>] show_regs+0x162/0x190 (44)
=======================================

Notice the bad address: 00100104, that's a list poison. From hrtimers.


On my UP machine running with the following:

# ./timer_stress -t 30 -s -1 -P

I got this:

======================================
BUG: Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c0128519
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: ipv6 tsdev mousedev psmouse parport_pc parport floppy pcspkrxCPU:    0
EIP:    0060:[<c0128519>]    Not tainted VLI
EFLAGS: 00010046   (2.6.15-rt4-sr1)
EIP is at __remove_hrtimer+0x19/0x50
eax: 00200200   ebx: c99eb474   ecx: c99eb49c   edx: 00100100
esi: c02edaec   edi: 1cd4d17f   ebp: 0000005b   esp: c99a7e2c
ds: 007b   es: 007b   ss: 0068   preempt: 00000002
Process timer_stress (pid: 2627, threadinfo=c99a6000 task=c13276f0 stack_left=7)Stack: c02edaec c99a7e48 c0128582 c99eb474 c02edaec 00016406 ffff007b 00000282
       00000000 c99eb474 c99eb428 c1327b64 c0128651 c99eb474 1cd4d17f 0000005b
       00000000 00000001 c0124ba3 c99eb474 1cd4d17f 0000005b 00000000 c99eb474
Call Trace:
 [<c0128582>] __hrtimer_start+0x32/0xea (12)
 [<c0128651>] hrtimer_start+0x17/0x1b (40)
 [<c0124ba3>] schedule_next_timer+0x41/0x48 (24)
 [<c0124be0>] do_schedule_next_timer+0x36/0x4b (44)
 [<c011ddb9>] dequeue_signal+0x86/0xb0 (20)
 [<c011f4db>] get_signal_to_deliver+0xc3/0x2e9 (28)
 [<c0102b02>] do_signal+0x5f/0xe5 (40)
 [<c0128bc6>] hrtimer_nanosleep+0xa9/0xf1 (56)
 [<c0128c4b>] sys_nanosleep+0x3d/0x4f (104)
 [<c0102baf>] do_notify_resume+0x27/0x38 (24)
 [<c0102d90>] work_notifysig+0x13/0x1b (8)
Code: d2 c7 47 18 02 00 00 00 5f 5d 5e 89 d0 5b 5e 5f 5d c3 56 53 8b 5c 24 0c 8
 <6>note: timer_stress[2627] exited with preempt_count 1
BUG: scheduling while atomic: timer_stress/0x00000001/2627
caller is do_exit+0x39d/0x3db
 [<c02a0105>] __schedule+0x67/0x57d (8)
 [<c0117708>] do_exit+0x39d/0x3db (8)
 [<c01172eb>] exit_notify+0x6a6/0x726 (28)
 [<c0117708>] do_exit+0x39d/0x3db (48)
 [<c01035ec>] do_trap+0x0/0xce (24)
 [<c01103c9>] do_page_fault+0x368/0x477 (32)
 [<c0110061>] do_page_fault+0x0/0x477 (60)
 [<c0102f97>] error_code+0x4f/0x54 (8)
 [<c0128519>] __remove_hrtimer+0x19/0x50 (44)
 [<c0128582>] __hrtimer_start+0x32/0xea (20)
 [<c0128651>] hrtimer_start+0x17/0x1b (40)
 [<c0124ba3>] schedule_next_timer+0x41/0x48 (24)
 [<c0124be0>] do_schedule_next_timer+0x36/0x4b (44)
 [<c011ddb9>] dequeue_signal+0x86/0xb0 (20)
 [<c011f4db>] get_signal_to_deliver+0xc3/0x2e9 (28)
 [<c0102b02>] do_signal+0x5f/0xe5 (40)
 [<c0128bc6>] hrtimer_nanosleep+0xa9/0xf1 (56)
 [<c0128c4b>] sys_nanosleep+0x3d/0x4f (104)
 [<c0102baf>] do_notify_resume+0x27/0x38 (24)
 [<c0102d90>] work_notifysig+0x13/0x1b (8)
==============================

So that protection is not working here.

-- Steve


