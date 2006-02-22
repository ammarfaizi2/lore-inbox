Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbWBVJJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbWBVJJA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 04:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbWBVJJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 04:09:00 -0500
Received: from odin2.bull.net ([192.90.70.84]:41897 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S932546AbWBVJI7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 04:08:59 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: tglx@linutronix.de
Subject: Re: RT and pci_lock while reading or writing pci bus configuration.
Date: Wed, 22 Feb 2006 10:16:15 +0100
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <200602201542.19857.Serge.Noiraud@bull.net> <1140464706.2480.762.camel@localhost.localdomain>
In-Reply-To: <1140464706.2480.762.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602221016.18405.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lundi 20 Février 2006 20:45, Thomas Gleixner wrote/a écrit :
> On Mon, 2006-02-20 at 15:42 +0100, Serge Noiraud wrote:
> > Hi,
> > I have one question :
> > In drivers/pci/access.c we have a global lock for pci configuration access.
> > In pci_bus_read_config_* or pci_bus_write_config_* functions, we acquire a lock.
> > When we call spin_lock_irqsave, we obtain the following message :
> > BUG: scheduling while atomic: IRQ 137/0x00000001/6431
> > caller is schedule+0x43/0x120
> >  [<c01050ec>] dump_stack+0x1c/0x20 (20)
> >  [<c03e7144>] __schedule+0xf44/0x1240 (236)
> >  [<c03e7483>] schedule+0x43/0x120 (12)
> >  [<c03e855b>] __down_mutex+0x2bb/0x5f0 (112)
> >  [<c03ea08c>] _spin_lock_irqsave+0x1c/0x40 (24)
> >  [<c023670d>] pci_bus_read_config_word+0x2d/0x70 (24)
> >  
> > Do I miss something or is it a BUG ?
> 
> Yeah, you missed to paste the full backtrace :)
OK! OK! don't flame me ! 
The process causing this is X when I switch from VT7 to VT1
and the driver is nvidia. I have some trouble with this driver with the RT patch.
and I need it for GL because the nv GPL driver don't do that.
nvidia version : 8178

here is the complete trace :

nvidia: module license 'NVIDIA' taints kernel.
PCI: Setting latency timer of device 0000:40:00.0 to 64
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-8178  Wed Dec 14 16:22:51 PST 2005
BUG: scheduling while atomic: IRQ 137/0x00000001/6431
caller is schedule+0x43/0x120
 [<c01050ec>] dump_stack+0x1c/0x20 (20)
 [<c03e7144>] __schedule+0xf44/0x1240 (236)
 [<c03e7483>] schedule+0x43/0x120 (12)
 [<c03e855b>] __down_mutex+0x2bb/0x5f0 (112)
 [<c03ea08c>] _spin_lock_irqsave+0x1c/0x40 (24)
 [<c023670d>] pci_bus_read_config_word+0x2d/0x70 (24)
 [<f91cd909>] nv_verify_pci_config+0x3a/0xd2 [nvidia] (40)
 [<f8fae32c>] rm_set_interrupts+0x114/0x144 [nvidia] (48)
 [<f91d1dc3>] os_cond_acquire_sema+0x3a/0x5b [nvidia] (24)
 [<f8fa68ea>] _nv002338rm+0x12/0x18 [nvidia] (32)
 [<f8faa355>] _nv001650rm+0x18d/0x250 [nvidia] (80)
 [<f8faa101>] _nv001647rm+0x51/0x70 [nvidia] (48)
 [<f8fae5c7>] rm_isr+0x3b/0x4c [nvidia] (48)
 [<f91cf726>] nv_kern_isr+0x29/0x65 [nvidia] (36)
 [<c015dcb3>] handle_IRQ_event+0x73/0x110 (52)
 [<c015eb49>] thread_edge_irq+0x59/0xf0 (24)
 [<c015ec16>] do_hardirq+0x36/0x80 (20)
 [<c015ed58>] do_irqd+0xf8/0x1b0 (28)
 [<c0142c48>] kthread+0x98/0xd0 (40)
 [<c0101335>] kernel_thread_helper+0x5/0x10 (164118556)
------------------------------
| showing all locks held by: |  (IRQ 137/6431 [f7e471a0,  61]):
------------------------------

#001:             [c04d3f60] {pci_lock}
... acquired at:               pci_bus_read_config_word+0x2d/0x70

softirq-tasklet/8[CPU#0]: BUG in ____up_mutex at kernel/rt.c:1592
 [<c01050ec>] dump_stack+0x1c/0x20 (20)
 [<c012a7c8>] __WARN_ON+0x48/0x60 (40)
 [<c014a8c8>] rt_up+0x298/0x2f0 (40)
 [<f91d1e1f>] os_release_sema+0x3b/0x47 [nvidia] (16)
 [<f8fa6902>] _nv002251rm+0x12/0x18 [nvidia] (32)
 [<f8faa1bc>] _nv001646rm+0x9c/0xa8 [nvidia] (64)
 [<f8fae63a>] rm_isr_bh+0x62/0x74 [nvidia] (48)
 [<f91cf77c>] nv_kern_isr_bh+0x1a/0x1f [nvidia] (24)
 [<c01320bd>] tasklet_action+0x5d/0x110 (28)
 [<c0132453>] ksoftirqd+0x133/0x1e0 (48)
 [<c0142c48>] kthread+0x98/0xd0 (40)
 [<c0101335>] kernel_thread_helper+0x5/0x10 (1003331612)
BUG: scheduling while atomic: X/0x00000001/6390
caller is schedule+0x43/0x120
 [<c01050ec>] dump_stack+0x1c/0x20 (20)
 [<c03e7144>] __schedule+0xf44/0x1240 (236)
 [<c03e7483>] schedule+0x43/0x120 (12)
 [<c03e855b>] __down_mutex+0x2bb/0x5f0 (112)
 [<c03ea08c>] _spin_lock_irqsave+0x1c/0x40 (24)
 [<c023670d>] pci_bus_read_config_word+0x2d/0x70 (24)
 [<f91cd909>] nv_verify_pci_config+0x3a/0xd2 [nvidia] (40)
 [<f8fae32c>] rm_set_interrupts+0x114/0x144 [nvidia] (48)
 [<f91d1d68>] os_acquire_sema+0x3f/0x60 [nvidia] (24)
 [<f8fa68d2>] _nv002346rm+0x12/0x18 [nvidia] (32)
 [<f8f8b1d9>] _nv003158rm+0x4d/0xc8 [nvidia] (64)
 [<f8faf90b>] _nv001649rm+0x30b/0x5d0 [nvidia] (64)
 [<f8fae66f>] rm_ioctl+0x23/0x38 [nvidia] (48)
 [<f91cf696>] nv_kern_ioctl+0x2a7/0x2ef [nvidia] (48)
 [<c019cf8d>] do_ioctl+0x4d/0x80 (36)
 [<c019d138>] vfs_ioctl+0x58/0x1c0 (40)
 [<c019d342>] sys_ioctl+0xa2/0x900 (208)
 [<c0103aa8>] sysenter_past_esp+0x61/0x89 (-8116)

<- Here, the system is frozen.

I'll try -rt17.

> 
> Preempt count is 1, so you are calling pci_bus_read_config_word() from a
> non preemptible context.
> 
> 	tglx

-- 
Serge Noiraud
