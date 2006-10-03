Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbWJCFWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbWJCFWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965250AbWJCFWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:22:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:489 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965245AbWJCFWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:22:21 -0400
Date: Tue, 3 Oct 2006 01:22:19 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: esandeen@redhat.com
Subject: Re: 2.6.18 ext3 panic.
Message-ID: <20061003052219.GA15563@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, esandeen@redhat.com
References: <20061002194711.GA1815@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002194711.GA1815@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<Cc'd Eric as he's been looking into this>

On Mon, Oct 02, 2006 at 03:47:11PM -0400, Dave Jones wrote:
 > Not sure what exactly happened here. Was running fsx on ext3 over 2 disk raid0,
 > and running a yum update. Box locked up solid after a few minutes..
 > http://www.codemonkey.org.uk/junk/DSC00747.JPG
 > 
 > The unwinder getting stuck meant I lost the top of the trace though.
 > (I have backporting the .19 fixes to .18 on my todo unless someone
 >  beats me to it and they end up in -stable).
 > 
 > Will try to reproduce with a serial console hooked up.

So I managed to reproduce it with an 'fsx foo' and a
'fsstress -d . -r -n 100000 -p 20 -r'. This time I grabbed it from
a vanilla 2.6.18 with none of the Fedora patches..

I'll give 2.6.18-git a try next.

		Dave

----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at fs/buffer.c:2791
invalid opcode: 0000 [1] SMP 
CPU 1 
Modules linked in: hidp l2cap bluetooth nfs lockd nfs_acl sunrpc ipv6 dm_mirror dm_mod video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq sr_mod snd_seq_device cdrom intel_rng snd_pcm_oss sg snd_mixer_oss snd_pcm shpchp floppy serio_raw pcspkr i2c_i801 ohci1394 ieee1394 snd_timer snd e1000 i2c_core soundcore snd_page_alloc sata_sil ahci libata sd_mod scsi_mod raid0 ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Pid: 408, comm: kjournald Not tainted 2.6.18 #1
RIP: 0010:[<ffffffff8021b425>]  [<ffffffff8021b425>] submit_bh+0x29/0x124
RSP: 0018:ffff81007ebcbd40  EFLAGS: 00010246
RAX: 0000000000000005 RBX: ffff810063dd0ec8 RCX: 8000000000000000
RDX: ffff81007f1f5430 RSI: ffff810063dd0ec8 RDI: 0000000000000001
RBP: ffff81007ebcbd60 R08: 0000000000800000 R09: 0000000000000003
R10: ffff810068621510 R11: 0000000000000400 R12: ffff81007f7f48c8
R13: 0000000000000001 R14: 0000000000000033 R15: 0000000000000080
FS:  0000000000000000(0000) GS:ffff810037ff1cc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b76d5365000 CR3: 00000000658e3000 CR4: 00000000000006e0
Process kjournald (pid: 408, threadinfo ffff81007ebca000, task ffff810037f52040)
Stack:  0000000000000003 ffff810063dd0ec8 ffff81007f7f48c8 0000000000000003
 ffff81007ebcbda0 ffffffff80217ca1 ffff81007aa572a0 ffff810063f8d400
 ffff810064145478 ffff81007f1ea208 ffff81007aa572a0 0000000000000080
Call Trace:
 [<ffffffff80217ca1>] ll_rw_block+0xa6/0xcd
 [<ffffffff88035991>] :jbd:journal_commit_transaction+0x40b/0x10ce
 [<ffffffff8803a033>] :jbd:kjournald+0xc7/0x222
 [<ffffffff80236089>] kthread+0x100/0x136
 [<ffffffff802624a0>] child_rip+0xa/0x12
DWARF2 unwinder stuck at child_rip+0xa/0x12
Leftover inexact backtrace:
 [<ffffffff80268c22>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff80261adc>] restore_args+0x0/0x30
 [<ffffffff80250ec3>] run_workqueue+0x19/0xfa
 [<ffffffff80250ec3>] run_workqueue+0x19/0xfa
 [<ffffffff80235f89>] kthread+0x0/0x136
 [<ffffffff80262496>] child_rip+0x0/0x12


Code: 0f 0b 68 c8 86 49 80 c2 e7 0a 48 83 7b 38 00 75 0a 0f 0b 68 
RIP  [<ffffffff8021b425>] submit_bh+0x29/0x124
 RSP <ffff81007ebcbd40>
 <0>general protection fault: 0000 [2] SMP 
CPU 1 
Modules linked in: hidp l2cap bluetooth nfs lockd nfs_acl sunrpc ipv6 dm_mirror dm_mod video sbs i2c_ec button battery asus_acpi ac parport_pc lp parport snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq sr_mod snd_seq_device cdrom intel_rng snd_pcm_oss sg snd_mixer_oss snd_pcm shpchp floppy serio_raw pcspkr i2c_i801 ohci1394 ieee1394 snd_timer snd e1000 i2c_core soundcore snd_page_alloc sata_sil ahci libata sd_mod scsi_mod raid0 ext3 jbd ehci_hcd ohci_hcd uhci_hcd
Pid: 0, comm: swapper Not tainted 2.6.18 #1
RIP: 0010:[<ffffffff8028e1a1>]  [<ffffffff8028e1a1>] task_rq_lock+0x2b/0x74
RSP: 0018:ffff810037e17df0  EFLAGS: 00010006
RAX: 6b6b6b6b6b6b6b6b RBX: ffffffff80aae480 RCX: ffff81007f1ea5a8
RDX: ffff81007ee71080 RSI: ffff810037e17e78 RDI: ffff810037f52040
RBP: ffff810037e17e10 R08: ffff810037e17eb0 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff8029995d R12: ffffffff80aae480
R13: ffff810037e17e78 R14: ffff810037f52040 R15: 0000000000000100
FS:  0000000000000000(0000) GS:ffff810037ff1cc0(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002b76d535d000 CR3: 000000007e290000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff810037e10000, task ffff81007ee71080)
Stack:  000000000000000f ffff810037e08000 ffff810037f52040 ffffffff880398d9
 ffff810037e17eb0 ffffffff80249e98 ffff810037e08000 000000007ee71080
 ffffffff80268c22 0000000200000001 0000000000000000 0000000100000000
Call Trace:
 [<ffffffff80249e98>] try_to_wake_up+0x27/0x421
 [<ffffffff8028e3ce>] wake_up_process+0x10/0x12
 [<ffffffff880398e2>] :jbd:commit_timeout+0x9/0xb
 [<ffffffff80299a67>] run_timer_softirq+0x14c/0x1d5
 [<ffffffff80212724>] __do_softirq+0x68/0xf5
 [<ffffffff802627f8>] call_softirq+0x1c/0x28
DWARF2 unwinder stuck at call_softirq+0x1c/0x28
Leftover inexact backtrace:
 <IRQ> [<ffffffff80270c65>] do_softirq+0x39/0x9f
 [<ffffffff802962a3>] irq_exit+0x57/0x59
 [<ffffffff8027b063>] smp_apic_timer_interrupt+0x5d/0x62
 [<ffffffff8025b784>] mwait_idle+0x0/0x54
 [<ffffffff8026216f>] apic_timer_interrupt+0x6b/0x70
 <EOI> [<ffffffff80266026>] __sched_text_start+0xaa6/0xadd
 [<ffffffff8025b7c3>] mwait_idle+0x3f/0x54
 [<ffffffff8025b78d>] mwait_idle+0x9/0x54
 [<ffffffff8024c916>] cpu_idle+0xa2/0xc5
 [<ffffffff8027a674>] start_secondary+0x468/0x477


Code: 8b 40 18 48 8b 04 c5 c0 59 a6 80 4c 03 60 08 4c 89 e7 e8 5e 
RIP  [<ffffffff8028e1a1>] task_rq_lock+0x2b/0x74
 RSP <ffff810037e17df0>
 <3>BUG: sleeping function called from invalid context at kernel/rwsem.c:20
in_atomic():1, irqs_disabled():1

Call Trace:
 [<ffffffff8026f956>] show_trace+0xae/0x336
 [<ffffffff8026fbf3>] dump_stack+0x15/0x17
 [<ffffffff8020bb01>] __might_sleep+0xb2/0xb4
 [<ffffffff802a5160>] down_read+0x1d/0x4a
 [<ffffffff8029cf62>] blocking_notifier_call_chain+0x1b/0x41
 [<ffffffff80293e10>] profile_task_exit+0x15/0x17
 [<ffffffff80215a74>] do_exit+0x25/0x96a
 [<ffffffff8026fe21>] kernel_math_error+0x0/0x96
 [<ffff810037e17d48>]
DWARF2 unwinder stuck at 0xffff810037e17d48
Leftover inexact backtrace:
 <IRQ> [<ffffffff8026993f>] do_general_protection+0x10a/0x115
 [<ffffffff8808bab2>] :scsi_mod:scsi_run_queue+0x1ab/0x1ba
 [<ffffffff802622d1>] error_exit+0x0/0x96
 [<ffffffff8029995d>] run_timer_softirq+0x42/0x1d5
 [<ffffffff8028e1a1>] task_rq_lock+0x2b/0x74
 [<ffffffff880398d9>] :jbd:commit_timeout+0x0/0xb
 [<ffffffff80249e98>] try_to_wake_up+0x27/0x421
 [<ffffffff80268c22>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff80268c22>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff880398d9>] :jbd:commit_timeout+0x0/0xb
 [<ffffffff880398d9>] :jbd:commit_timeout+0x0/0xb
 [<ffffffff8028e3ce>] wake_up_process+0x10/0x12
 [<ffffffff880398e2>] :jbd:commit_timeout+0x9/0xb
 [<ffffffff80299a67>] run_timer_softirq+0x14c/0x1d5
 [<ffffffff80212724>] __do_softirq+0x68/0xf5
 [<ffffffff802627f8>] call_softirq+0x1c/0x28
 [<ffffffff80270c65>] do_softirq+0x39/0x9f
 [<ffffffff802962a3>] irq_exit+0x57/0x59
 [<ffffffff8027b063>] smp_apic_timer_interrupt+0x5d/0x62
 [<ffffffff8025b784>] mwait_idle+0x0/0x54
 [<ffffffff8026216f>] apic_timer_interrupt+0x6b/0x70
 <EOI> [<ffffffff80266026>] __sched_text_start+0xaa6/0xadd
 [<ffffffff8025b7c3>] mwait_idle+0x3f/0x54
 [<ffffffff8025b78d>] mwait_idle+0x9/0x54
 [<ffffffff8024c916>] cpu_idle+0xa2/0xc5
 [<ffffffff8027a674>] start_secondary+0x468/0x477

Kernel panic - not syncing: Aiee, killing interrupt handler!
 

-- 
http://www.codemonkey.org.uk
