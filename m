Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUKSKye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUKSKye (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 05:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUKSKye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 05:54:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:55485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261207AbUKSKyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 05:54:12 -0500
Date: Fri, 19 Nov 2004 02:53:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2: spinlock problem in arch/i386/kernel/time.c on
 resume
Message-Id: <20041119025357.4b6ca9f7.akpm@osdl.org>
In-Reply-To: <1100855456.22588.9.camel@outer-dhcp-100.goop.org>
References: <1100855456.22588.9.camel@outer-dhcp-100.goop.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> When I resume my laptop (ThinkPad X31) from a APM sleep, it crashes on
> resume.
> 
> On resume, it prints on the console:
>         
>         arch/i396/kernel/time.c:178: spin_lock(arch/i386/kernel/time.c:c0347f28) is already locked by arch/i386/kernel/time.c/310
>         arch/i386/kernel/time.c:317 spin_unlock(arch/i386/kernel/time.c:c0347f28) is not locked
>         PCI: Enabling device 0000:00:1f.5 (0000 -> 0003)
>         
> and is then completely locked up. c0347f28 maps to rtc_lock.

I can't imagine how that could happen.  I wonder if the spinlock debugging
could be making a mistake.

> .config & lspci attached

I have but a lowly A21P.  With my .config it APM resumes happily.  With
yours it refuses to even suspend.  And:



hdc: DMA disabled
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 11 for device 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:03.1
irq 11: nobody cared!
 [<c010393d>] dump_stack+0x19/0x20
 [<c013cb73>] __report_bad_irq+0x33/0x9c
 [<c013cc58>] note_interrupt+0x50/0x7c
 [<c013c2c2>] __do_IRQ+0x226/0x2c3
 [<c0104bd7>] do_IRQ+0x67/0x90
 =======================
 [<c0103416>] common_interrupt+0x1a/0x20
 [<c0104ce6>] do_softirq+0x3a/0x4c
 =======================
 [<c012114a>] irq_exit+0x2a/0x34
 [<c0104bef>] do_IRQ+0x7f/0x90
 [<c0103416>] common_interrupt+0x1a/0x20
 [<c0156e4b>] get_vm_area+0x2b/0x30
 [<c0114ff7>] __ioremap+0xa3/0xe0
 [<d082073f>] e100_probe+0x257/0x620 [e100]
 [<c01e2899>] pci_device_probe_static+0x2d/0x48
 [<c01e28d4>] __pci_device_probe+0x20/0x3c
 [<c01e290e>] pci_device_probe+0x1e/0x3c
 [<c021fb7d>] driver_probe_device+0x3d/0x64
 [<c021fc60>] driver_attach+0x3c/0x74
 [<c02200ce>] bus_add_driver+0x82/0xc0
 [<c022064f>] driver_register+0x43/0x50
 [<c01e2b4b>] pci_register_driver+0x8f/0xb0
 [<d0826044>] e100_init_module+0x44/0x48 [e100]
 [<c013a047>] sys_init_module+0x1d3/0x2ac
 [<c0102aa7>] syscall_call+0x7/0xb
handlers:
[<c025eea0>] (yenta_interrupt+0x0/0x30)
[<c025eea0>] (yenta_interrupt+0x0/0x30)
Disabling IRQ #11
e100: eth0: e100_probe: addr 0xf0120000, irq 11, MAC addr 00:10:A4:92:1E:06
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x3b8-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 11 for device 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:03.1
e100: eth0: e100_probe: addr 0xf0120000, irq 11, MAC addr 00:10:A4:92:1E:06
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
localhost:/home/akpm> cat /proc/interrupts
           CPU0       
  0:     237701          XT-PIC  timer
  1:         92          XT-PIC  i8042
  2:          0          XT-PIC  cascade
 11:     100633          XT-PIC  yenta, yenta, eth0
 12:        198          XT-PIC  i8042
 14:       2750          XT-PIC  ide0
 15:         25          XT-PIC  ide1
NMI:          0 
LOC:          0 
ERR:          0
MIS:          0

Yet the ethernet still works.  Presumably the e100 initialisation went and
reenabled it.   Let me try reverting your e100 patch...

