Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWJFWge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWJFWge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWJFWge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:36:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11501 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422703AbWJFWgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:36:33 -0400
Date: Fri, 6 Oct 2006 15:36:22 -0700
From: Bryce Harrington <bryce@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: hotplug_sig@osdl.org, lhcs-devel@lists.sourceforge.net
Subject: [Oops] _cpu_up NULL ptr deref on x86_64 w/ 2.6.19-rc1-git2
Message-ID: <20061006223622.GG22139@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is a new Oops found on x86_64 (both AMD64 and EM64t), but
not on x86_32 or ia64.  It occurs during boot.  I'm wondering if perhaps
it is a cpu hotplug related issue since it occurs on both architectures
right after switching to SMP, and due to the reference to _cpu_up in the
call traces?

2.6.19-rc1 booted without this issue, so I'm guessing it is due to a
change within the past couple days.  (I wasn't able to get
2.6.19-rc1-git1 to boot on any architecture, but assume this is already
known and fixed, since it works now on some arch's.)

The .configs and console logs are here:

   AMD64:  http://crucible.osdl.org/runs/2456/sysinfo/amd01.config
           http://crucible.osdl.org/runs/2456/sysinfo/amd01.console
   EM64t:  http://crucible.osdl.org/runs/2459/sysinfo/nfs12.config
           http://crucible.osdl.org/runs/2459/sysinfo/nfs12.console

Here's a snippet from the AMD log (the EM64T log is similar):

Linux version 2.6.19-rc1-git2 (root@amd01) (gcc version 3.4.6 (Gentoo 3.4.6-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP PREEMPT Fri Oct 6 20:03:57 GMT 2006
Command line: root=/dev/sda3 profile=2 console=tty0 console=ttyS0,115200
BIOS-provided physical RAM map:
BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
BIOS-e820: 00000000000e0000 - 00000000001000000: 000000007fff0000 - 000000007ffff000 (ACPI data)
BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
end_pfn_map = 1048576
DMI 2.3 present.
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-40000000
SRAT: Node 1 PXM 1 40000000-80000000
SRAT: Node 0 PXM 0 0-40000000
Boong to SMP code
Unable to handle kernel NULL pointer dereference at 0000000000000088 RIP: 
[<ffffffff80231b1a>] profile_tick+0x30/0x65
PGD 0 
Oops: 0000 [1] PREEMPT SMP 
CPU 0 
Modules linked in:
Pid: 1, comm: swapper Not tainted 2.6.19-rc1-git2 #1
RIP: 0010:[<ffffffff80231b1a>]  [<ffffffff80231b1a>] profile_tick+0x30/0x65
RSP: 0000:ffffffff8074cf78  EFLAGS: 00010046
RAX: 00000000000000 RCX: ffffffff806fd658
RDX: ffff8100808c6f40 RSI: 0000000000000213 RDI: 0000000000000001
RBP: 0000000000000001 R08: 0000000000000017 R09: 0000000000000001
R10: 0000000000000001 R11: ffffffff803e1f93 R12: 0000000000000001
R13: 0000000000000001 R14: ffffffff806e3080 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffffffff806e3000(0000) knlGS:0000000000000000
CS:  000016e1d20 ffffffff8021898e
ffff8100016e1fd8 ffffffff802189fd ffff81007f1b8b40 ffffffff8020a256
ffff8100016e1d20 <EOI>  0000000000000001 ffffffff803e1f93 0000000000000001
Call Trace:
<IRQ>  [<ffffffff8021898e>] smp_local_timer_interrupt+0xb/0x51
[<ffffffff802189fd>] smp_apic_timer_interrupt+0x29/0x2f
[<ffffffff8020a256>] apic_timer_interrupt+0x66/0x70
<EOI>  [<ffffffff803e1f93>] vgacon_cursor+0x0/0x1a7
[<ffffffff80561901>] __lock_text_start+0x9/0x2e
[<ffffffff80217bbb>] __cpu_up+0x235/0x726
[<ffffffff8026e56a>] __cache_alloc_node+0x11c/0x12b
[<ffffffff8021796a>] do_fork_idle+0x0/0x1c
[<ffffffff802491cc>] _cpu_up+0x79/0xc7
[<ffffffff80249240>] cpu_up+0x26/0x3a
[<ffffffff802070ee>] init+0x96/0x30c
[<ffffffff80561d51>] _spin_unlock_irq+0x12/0x2d
[<fffffff80228868>] schedule_tail+0x36/0x9a
[<ffffffff803e1f93>] vgacon_cursor+0x0/0x1a7
[<ffffffff8020a445>] child_rip+0xa/0x15
[<ffffffff803e1f93>] vgacon_cursor+0x0/0x1a7
[<ffffffff803e1f93>] vgacon_cursor+0x0/0x1a7
[<ffffffff80207058>] init+0x0/0x30c
[<ffffffff8020a43b>] child_rip+0x0/0x15


For comparison with other architectures and previous kernels:

    http://crucible.osdl.org/runs/hotplug_report.html

Bryce

