Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVFHGjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVFHGjX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbVFHGjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:39:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50671 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262119AbVFHGiu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:38:50 -0400
Date: Wed, 8 Jun 2005 12:08:40 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Morton Andrew Morton <akpm@osdl.org>, Bodo Eggert <7eggert@gmx.de>,
       stern@rowland.harvard.edu, awilliam@fc.hp.com, greg@kroah.com,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       bjorn.helgaas@hp.com
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050608063840.GA4082@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1118113637.42a50f65773eb@imap.linux.ibm.com> <20050607050727.GB12781@colo.lackof.org> <m1slzuwkqx.fsf@ebiederm.dsl.xmission.com> <20050607162143.GE29220@colo.lackof.org> <m1acm2vwil.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acm2vwil.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2005 at 12:42:42PM -0600, Eric W. Biederman wrote:
> Grant Grundler <grundler@parisc-linux.org> writes:
> 
> > On Tue, Jun 07, 2005 at 03:59:18AM -0600, Eric W. Biederman wrote:
> > > > *lots* of PCI devices predate PCI2.3. Possibly even the majority.
> > > 
> > > In general generic hardware bits for disabling DMA, disabling interrupts
> > > and the like are all advisory.  With the current architecture things
> > > will work properly even if you don't manage to disable DMA (assuming
> > > you don't reassign IOMMU entries at least).
> > 
> > ISTR, pSeries (IBM), some alpha, some sparc64, and parisc (64-bit) require
> > use of the IOMMU for *any* DMA. ie IOMMU entries need to be programmed.
> > Probably want to make a choice to ignore those arches for now
> > or sort out how to deal with an IOMMU.
> 
> The howto deal with an IOMMU has been sorted out but so far no one 
> has actually done it.  What has been discussed previously is simply
> reserving a handful of IOMMU entries, and then only using those
> in the crash recover kernel.  This is essentially what we do with DMA
> on architectures that don't have an IOMMU and it seems quite safe
> enough there.
> 
> > > Shared interrupts are an interesting case.  The simplest solution I can
> > > think of for a crash dump capture kernel is to periodically poll
> > > the hardware, as if all interrupts are shared.  At that level
> > > I think we could get away with ignoring all hardware interrupt sources.
> > 
> > Yes, that's perfectly ok. We are no longer in a multitasking env.
> 
> Well we are at least capable of multitasking but that is no longer the
> primary focus.  Having polling as at least an option should make
> debugging easier.  Last I looked Andrews kernel hand an irqpoll option
> to do something very like this.
> 

If I understand this right, the idea is that let all irqs be masked (except
timer one) and invoke all the irq handlers whenever a timer interrupt occurs.
This will automatcally be equivalent to drivers polling their devices for
any interrupt.

As you mentioned that irqpoll option comes close. If enabled, it invokes
all the irq handlers on every timer interrupt (IRQ0). The only difference is 
that irqs are not masked (until and unless kernel masks these due to excessive
unhandled interrupts). 

I tried booting kdump kernel with irqpoll option. It seems to be going 
little bit ahead than previous point of failure (boot without irqpoll) but
panics later. Following is the stack trace.

mptbase: Initiating ioc0 bringup
Unable to handle kernel NULL pointer dereference at virtual address 00000608
 printing eip:
c11e1b73
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c11e1b73>]    Not tainted VLI
EFLAGS: 00010006   (2.6.12-rc6-mm1-16M)
EIP is at mptscsih_io_done+0x23/0x350
eax: c1778400   ebx: 00000000   ecx: 00000600   edx: 00000250
esi: 00000000   edi: 0000000e   ebp: 00000001   esp: c15efcbc
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=c15ee000 task=c147fa00)
Stack: c15f02d1 c1116cfd c1116d60 c15df660 00000000 0000006c 00000250 00000000
       00000000 0000000e 00000001 c11db9ea c1778400 00000600 00000000 00000000
       00000600 c1788aa0 c1410e80 00000009 00000001 c1039e7c 00000009 c1778400
Call Trace:
 [<c1116cfd>] acpi_ev_gpe_detect+0x83/0x10f
 [<c1116d60>] acpi_ev_gpe_detect+0xe6/0x10f
 [<c11db9ea>] mpt_interrupt+0xfa/0x1e0
 [<c1039e7c>] misrouted_irq+0xec/0x100
 [<c103a007>] note_interrupt+0xb7/0xf0
 [<c10399c4>] __do_IRQ+0xe4/0xf0
 [<c1004e09>] do_IRQ+0x19/0x30
 [<c1003246>] common_interrupt+0x1a/0x20
 [<c1018d8f>] release_console_sem+0x3f/0xa0
 [<c1018c27>] vprintk+0x177/0x220
 [<c126ecbd>] pci_read+0x3d/0x50
 [<c1101a0a>] kobject_get+0x1a/0x30
 [<c116b676>] get_device+0x16/0x30
 [<c110b95a>] pci_dev_get+0x1a/0x30
 [<c1018aa7>] printk+0x17/0x20
 [<c11dcbeb>] mpt_do_ioc_recovery+0x4b/0x540
 [<c11dc4ff>] mpt_attach+0x2ef/0x690
 [<c11e6e03>] mptspi_probe+0x23/0x3e0
 [<c110b4f2>] pci_device_probe_static+0x52/0x70
 [<c110b54c>] __pci_device_probe+0x3c/0x50
 [<c110b58f>] pci_device_probe+0x2f/0x50
 [<c116cb68>] driver_probe_device+0x38/0xb0
 [<c116cc60>] __driver_attach+0x0/0x50
 [<c116cca7>] __driver_attach+0x47/0x50
 [<c116c229>] bus_for_each_dev+0x69/0x80
 [<c116ccd6>] driver_attach+0x26/0x30
 [<c116cc60>] __driver_attach+0x0/0x50
 [<c116c6d8>] bus_add_driver+0x88/0xc0
 [<c110b6d0>] pci_device_shutdown+0x0/0x30
 [<c110b857>] pci_register_driver+0x67/0x90
 [<c142a890>] mptspi_init+0xa0/0xb0
 [<c11e37a0>] mptscsih_ioc_reset+0x0/0x170
 [<c141483c>] do_initcalls+0x2c/0xc0
 [<c142d5fa>] sock_init+0x2a/0x40
 [<c1000290>] init+0x0/0x100
 [<c10002b5>] init+0x25/0x100
 [<c10013a0>] kernel_thread_helper+0x0/0x10
 [<c10013a5>] kernel_thread_helper+0x5/0x10
Code: 00 8d bc 27 00 00 00 00 55 57 56 53 83 ec 1c 8b 44 24 30 8b 4c 24 34 8b 7
 <0>Kernel panic - not syncing: Fatal exception in interrupt


Thanks
Vivek
