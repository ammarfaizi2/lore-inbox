Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVHWMwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVHWMwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 08:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVHWMwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 08:52:06 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:57480 "EHLO
	ogre.sisk.pl") by vger.kernel.org with ESMTP id S932067AbVHWMwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 08:52:04 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc6-mm2 (hangs on non-SMP x86-64 and oopses)
Date: Tue, 23 Aug 2005 14:51:51 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
       Greg KH <greg@kroah.com>
References: <20050822213021.1beda4d5.akpm@osdl.org>
In-Reply-To: <20050822213021.1beda4d5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231451.52521.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 23 of August 2005 06:30, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm2/
> 
> - Various updates.  Nothing terribly noteworthy.

It hangs solig during boot (after starting kjournald) on Asus L5D (non-SMP x86-64),
which is caused by this patch:

8250-serial-console-locking-bug-spelling-fix.patch

(from binary search).

If this patch is reverted, it oopses like in the following trace.

At the same time it works fine on an SMP box (dual-core Athlon 64).

Greetings,
Rafael


ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [LUS2] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:02.2: irq 5, io mem 0xfebfdc00
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: park 0
ehci_hcd 0000:00:02.2: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 3-0:1.0: USB hub found
usb 2-2: string descriptor 0 read error: -110
hub 3-0:1.0: 6 ports detected
usb 2-2: string descriptor 0 read error: -110
usb 2-2: can't set config #1, error -110
Unable to handle kernel NULL pointer dereference at 0000000000000004 RIP:
<ffffffff8024373b>{_raw_spin_lock+27}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [1] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8024373b>] <ffffffff8024373b>{_raw_spin_lock+27}
RSP: 0000:ffff81002fc7dcc8  EFLAGS: 00010282
RAX: ffff810001ce20d0 RBX: 0000000000000000 RCX: ffff81002d586530
RDX: 0000000000000000 RSI: ffff81002d586540 RDI: 0000000000000000
RBP: ffff81002fc7dce8 R08: 0000000000000000 R09: ffff81002d586410
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: ffffffff803f06a0 R14: ffff81002d5557f8 R15: 0000000000000002
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000004 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000000 ffffffff803f06a0 ffff81002d5557f8
       ffff81002fc7dd08 ffffffff8035612e ffff81002d555918 ffff81002d555870
       ffff81002fc7dd28 ffffffff80353b2f
Call Trace:<ffffffff8035612e>{_spin_lock+30} <ffffffff80353b2f>{klist_remove+31}
       <ffffffff802ad11d>{__device_release_driver+93} <ffffffff802ad254>{device_release_driver+52}
       <ffffffff802ac994>{bus_remove_device+180} <ffffffff802ab7f8>{device_del+56}
       <ffffffff802d657f>{usb_new_device+495} <ffffffff802d7419>{hub_thread+1961}
       <ffffffff80354b6f>{thread_return+187} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff802d6c70>{hub_thread+0}
       <ffffffff8014a583>{kthread+211} <ffffffff8010f5e6>{child_rip+8}
       <ffffffff8014a4b0>{kthread+0} <ffffffff8010f5de>{child_rip+0}

BUG: spinlock trylock failure on UP on CPU#0, khubd/108
 lock: ffffffff803bf020, .magic: dead4ead, .owner: khubd/108, .owner_cpu: 0

Call Trace:<ffffffff802439f9>{add_preempt_count+105} <ffffffff80243623>{spin_bug+211}
       <ffffffff8011004b>{show_trace+571} <ffffffff8024370e>{_raw_spin_trylock+62}
       <ffffffff80355e4e>{_spin_trylock+30} <ffffffff8010fc81>{oops_begin+17}
       <ffffffff8035702a>{do_page_fault+1722} <ffffffff8013452e>{vprintk+830}
       <ffffffff8013452e>{vprintk+830} <ffffffff80152296>{kallsyms_lookup+246}
       <ffffffff8010f431>{error_exit+0} <ffffffff8011004b>{show_trace+571}
       <ffffffff80110047>{show_trace+567} <ffffffff80110168>{show_stack+216}
       <ffffffff80110207>{show_registers+135} <ffffffff8011050e>{__die+142}
       <ffffffff80357098>{do_page_fault+1832} <ffffffff80355fa4>{_spin_unlock_irq+20}
       <ffffffff80354b6f>{thread_return+187} <ffffffff8010f431>{error_exit+0}
       <ffffffff8024373b>{_raw_spin_lock+27} <ffffffff802439f9>{add_preempt_count+105}
       <ffffffff8035612e>{_spin_lock+30} <ffffffff80353b2f>{klist_remove+31}
       <ffffffff802ad11d>{__device_release_driver+93} <ffffffff802ad254>{device_release_driver+52}
       <ffffffff802ac994>{bus_remove_device+180} <ffffffff802ab7f8>{device_del+56}
       <ffffffff802d657f>{usb_new_device+495} <ffffffff802d7419>{hub_thread+1961}
       <ffffffff80354b6f>{thread_return+187} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff802d6c70>{hub_thread+0}
       <ffffffff8014a583>{kthread+211} <ffffffff8010f5e6>{child_rip+8}
       <ffffffff8014a4b0>{kthread+0} <ffffffff8010f5de>{child_rip+0}

---------------------------
| preempt count: 00000003 ]
| 3 level deep critical section nesting:
----------------------------------------
.. [<ffffffff80356126>] .... _spin_lock+0x16/0x30
.....[<ffffffff80353b2f>] ..   ( <= klist_remove+0x1f/0x50)
.. [<ffffffff80355e46>] .... _spin_trylock+0x16/0x60
.....[<ffffffff8010fc81>] ..   ( <= oops_begin+0x11/0x60)
.. [<ffffffff80355e46>] .... _spin_trylock+0x16/0x60
.....[<ffffffff8010fc81>] ..   ( <= oops_begin+0x11/0x60)

Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [2] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0000:ffff81002fc7da08  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
RBP: ffff81002fc7da48 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc7e000
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff80469fc0
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000096 000000002fc7da48 ffff81002fc7dd18
       000000000000000a ffffffff80469fc0 ffffffff80465fc0 0000000000000000
       ffff81002fc7da88 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff80355fa4>{_spin_unlock_irq+20} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8010f431>{error_exit+0} <ffffffff8024373b>{_raw_spin_lock+27}
       <ffffffff802439f9>{add_preempt_count+105} <ffffffff8035612e>{_spin_lock+30}
       <ffffffff80353b2f>{klist_remove+31} <ffffffff802ad11d>{__device_release_driver+93}
       <ffffffff802ad254>{device_release_driver+52} <ffffffff802ac994>{bus_remove_device+180}
       <ffffffff802ab7f8>{device_del+56} <ffffffff802d657f>{usb_new_device+495}
       <ffffffff802d7419>{hub_thread+1961} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff802d6c70>{hub_thread+0} <ffffffff8014a583>{kthread+211}
       <ffffffff8010f5e6>{child_rip+8} <ffffffff8014a4b0>{kthread+0}
       <ffffffff8010f5de>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [3] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0000:ffff81002fc7d748  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81002fc7d788 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc7e000
R13: 0000000000000000 R14: 0000000000000020 R15: ffffffff80469fc0
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000096 000000002fc7d788 ffff81002fc7da58
       000000000000000a ffffffff80469fc0 ffffffff80465fc0 0000000000000000
       ffff81002fc7d7c8 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff80355fa4>{_spin_unlock_irq+20} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8010f431>{error_exit+0} <ffffffff8024373b>{_raw_spin_lock+27}
       <ffffffff802439f9>{add_preempt_count+105} <ffffffff8035612e>{_spin_lock+30}
       <ffffffff80353b2f>{klist_remove+31} <ffffffff802ad11d>{__device_release_driver+93}
       <ffffffff802ad254>{device_release_driver+52} <ffffffff802ac994>{bus_remove_device+180}
       <ffffffff802ab7f8>{device_del+56} <ffffffff802d657f>{usb_new_device+495}
       <ffffffff802d7419>{hub_thread+1961} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff802d6c70>{hub_thread+0} <ffffffff8014a583>{kthread+211}
       <ffffffff8010f5e6>{child_rip+8} <ffffffff8014a4b0>{kthread+0}
       <ffffffff8010f5de>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [4] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0000:ffff81002fc7d488  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81002fc7d4c8 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc7e000
R13: 0000000000000000 R14: 0000000000000020 R15: ffffffff80469fc0
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000092 000000002fc7d4c8 ffff81002fc7d798
       000000000000000a ffffffff80469fc0 ffffffff80465fc0 0000000000000000
       ffff81002fc7d508 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff80355fa4>{_spin_unlock_irq+20} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8010f431>{error_exit+0} <ffffffff8024373b>{_raw_spin_lock+27}
       <ffffffff802439f9>{add_preempt_count+105} <ffffffff8035612e>{_spin_lock+30}
       <ffffffff80353b2f>{klist_remove+31} <ffffffff802ad11d>{__device_release_driver+93}
       <ffffffff802ad254>{device_release_driver+52} <ffffffff802ac994>{bus_remove_device+180}
       <ffffffff802ab7f8>{device_del+56} <ffffffff802d657f>{usb_new_device+495}
       <ffffffff802d7419>{hub_thread+1961} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff802d6c70>{hub_thread+0} <ffffffff8014a583>{kthread+211}
       <ffffffff8010f5e6>{child_rip+8} <ffffffff8014a4b0>{kthread+0}
       <ffffffff8010f5de>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [5] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0000:ffff81002fc7d1c8  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
RBP: ffff81002fc7d208 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc7e000
R13: 0000000000000000 R14: 0000000000000020 R15: ffffffff80469fc0
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000092 000000002fc7d208 ffff81002fc7d4d8
       000000000000000a ffffffff80469fc0 ffffffff80465fc0 0000000000000000
       ffff81002fc7d248 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff80355fa4>{_spin_unlock_irq+20} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8010f431>{error_exit+0} <ffffffff8024373b>{_raw_spin_lock+27}
       <ffffffff802439f9>{add_preempt_count+105} <ffffffff8035612e>{_spin_lock+30}
       <ffffffff80353b2f>{klist_remove+31} <ffffffff802ad11d>{__device_release_driver+93}
       <ffffffff802ad254>{device_release_driver+52} <ffffffff802ac994>{bus_remove_device+180}
       <ffffffff802ab7f8>{device_del+56} <ffffffff802d657f>{usb_new_device+495}
       <ffffffff802d7419>{hub_thread+1961} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff802d6c70>{hub_thread+0} <ffffffff8014a583>{kthread+211}
       <ffffffff8010f5e6>{child_rip+8} <ffffffff8014a4b0>{kthread+0}
       <ffffffff8010f5de>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [6] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0000:ffff81002fc7cf08  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000096 RDI: 0000000000000001
RBP: ffff81002fc7cf48 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc7e000
R13: 0000000000000000 R14: 0000000000000020 R15: ffffffff80469fc0
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000096 000000002fc7cf48 ffff81002fc7d218
       000000000000000a ffffffff80469fc0 ffffffff80465fc0 0000000000000000
       ffff81002fc7cf88 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff80355fa4>{_spin_unlock_irq+20} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8010f431>{error_exit+0} <ffffffff8024373b>{_raw_spin_lock+27}
       <ffffffff802439f9>{add_preempt_count+105} <ffffffff8035612e>{_spin_lock+30}
       <ffffffff80353b2f>{klist_remove+31} <ffffffff802ad11d>{__device_release_driver+93}
       <ffffffff802ad254>{device_release_driver+52} <ffffffff802ac994>{bus_remove_device+180}
       <ffffffff802ab7f8>{device_del+56} <ffffffff802d657f>{usb_new_device+495}
       <ffffffff802d7419>{hub_thread+1961} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff802d6c70>{hub_thread+0} <ffffffff8014a583>{kthread+211}
       <ffffffff8010f5e6>{child_rip+8} <ffffffff8014a4b0>{kthread+0}
       <ffffffff8010f5de>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [7] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0000:ffff81002fc7cc48  EFLAGS: 00010096
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81002fc7cc88 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc7e000
R13: 0000000000000000 R14: 0000000000000020 R15: ffffffff80469fc0
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000096 000000002fc7cc88 ffff81002fc7cf58
       000000000000000a ffffffff80469fc0 ffffffff80465fc0 0000000000000000
       ffff81002fc7ccc8 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff80355fa4>{_spin_unlock_irq+20} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8010f431>{error_exit+0} <ffffffff8024373b>{_raw_spin_lock+27}
       <ffffffff802439f9>{add_preempt_count+105} <ffffffff8035612e>{_spin_lock+30}
       <ffffffff80353b2f>{klist_remove+31} <ffffffff802ad11d>{__device_release_driver+93}
       <ffffffff802ad254>{device_release_driver+52} <ffffffff802ac994>{bus_remove_device+180}
       <ffffffff802ab7f8>{device_del+56} <ffffffff802d657f>{usb_new_device+495}
       <ffffffff802d7419>{hub_thread+1961} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff802d6c70>{hub_thread+0} <ffffffff8014a583>{kthread+211}
       <ffffffff8010f5e6>{child_rip+8} <ffffffff8014a4b0>{kthread+0}
       <ffffffff8010f5de>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}
PGD 2ca73067 PUD 2ca46067 PMD 0
Oops: 0000 [8] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff8011004b>] <ffffffff8011004b>{show_trace+571}
RSP: 0000:ffff81002fc7c988  EFLAGS: 00010092
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81002fc7c9c8 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffff81002fc7e000
R13: 0000000000000000 R14: 0000000000000020 R15: ffffffff80469fc0
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000008 CR3: 000000002ca61000 CR4: 00000000000006e0
Process khubd (pid: 108, threadinfo ffff81002fc7c000, task ffff810001ce20d0)
Stack: 0000000000000000 0000000000000092 000000002fc7c9c8 ffff81002fc7cc98
       000000000000000a ffffffff80469fc0 ffffffff80465fc0 0000000000000000
       ffff81002fc7ca08 ffffffff80110168
Call Trace:<ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff8013452e>{vprintk+830} <ffffffff8013452e>{vprintk+830}
       <ffffffff80152296>{kallsyms_lookup+246} <ffffffff8010f431>{error_exit+0}
       <ffffffff8011004b>{show_trace+571} <ffffffff80110047>{show_trace+567}
       <ffffffff80110168>{show_stack+216} <ffffffff80110207>{show_registers+135}
       <ffffffff8011050e>{__die+142} <ffffffff80357098>{do_page_fault+1832}
       <ffffffff80355fa4>{_spin_unlock_irq+20} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8010f431>{error_exit+0} <ffffffff8024373b>{_raw_spin_lock+27}
       <ffffffff802439f9>{add_preempt_count+105} <ffffffff8035612e>{_spin_lock+30}
       <ffffffff80353b2f>{klist_remove+31} <ffffffff802ad11d>{__device_release_driver+93}
       <ffffffff802ad254>{device_release_driver+52} <ffffffff802ac994>{bus_remove_device+180}
       <ffffffff802ab7f8>{device_del+56} <ffffffff802d657f>{usb_new_device+495}
       <ffffffff802d7419>{hub_thread+1961} <ffffffff80354b6f>{thread_return+187}
       <ffffffff8014a710>{autoremove_wake_function+0} <ffffffff8014a710>{autoremove_wake_function+0}
       <ffffffff802d6c70>{hub_thread+0} <ffffffff8014a583>{kthread+211}
       <ffffffff8010f5e6>{child_rip+8} <ffffffff8014a4b0>{kthread+0}
       <ffffffff8010f5de>{child_rip+0}
Unable to handle kernel NULL pointer dereference at 0000000000000008 RIP:
<ffffffff8011004b>{show_trace+571}----------- [cut here ] --------- [please bite here ] ---------
Kernel BUG at "lib/preempt.c":64
invalid operand: 0000 [9] PREEMPT
CPU 0
Modules linked in: ehci_hcd ohci_hcd sk98lin evdev joydev sg st sr_mod sd_mod scsi_mod ide_cd cdrom dm_mod parport_pc lp parport
Pid: 108, comm: khubd Not tainted 2.6.13-rc6-mm2
RIP: 0010:[<ffffffff80243947>] <ffffffff80243947>{sub_preempt_count+23}
RSP: 0000:ffff81002fc7c298  EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff81002fc7c368 RCX: 0000000000000000
RDX: 0000000000000001 RSI: 0000000000000092 RDI: 0000000000000001
RBP: ffff81002fc7c298 R08: 0000000000000000 R09: ffff81002d558c50
R10: 00000000ffffffff R11: 0000000000000000 R12: ffffffff8036fe93
R13: ffffffff8047cb62 R14: 0000000000000008 R15: 0000000000000022
FS:  00002aaaab28fe80(0000) GS:ffffffff804f8840(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
