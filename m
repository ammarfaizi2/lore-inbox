Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTFJXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTFJXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 19:41:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:22142 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261861AbTFJXlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 19:41:22 -0400
Date: Tue, 10 Jun 2003 16:51:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: boris@macbeth.rhoen.de, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: oops while booting : 2.5.70-bk1[4,5] - Process swapper
Message-Id: <20030610165111.7911b7cb.akpm@digeo.com>
In-Reply-To: <20030610143018.025d318c.akpm@digeo.com>
References: <20030610202947.GA752@macbeth.rhoen.de>
	<20030610143018.025d318c.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 23:55:04.0744 (UTC) FILETIME=[B6B08280:01C32FAB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> boris mogwitz <boris@macbeth.rhoen.de> wrote:
> >
> > Unable to handle kernel NULL pointer dereference at virtual address 00000000
> > ...
> > 
> > Trace; c0254888 <pcibios_enable_device+28/30>
> > Trace; c01c4f7b <pci_enable_device_bars+2b/40>
> > Trace; c01c4fa7 <pci_enable_device+17/20>
> > Trace; c02466e9 <matroxfb_probe+d9/2d0>
> > Trace; c01c6222 <pci_device_probe_static+52/70>
> > Trace; c01c63bc <__pci_device_probe+3c/50>
> > Trace; c01c63ff <pci_device_probe+2f/50>
> > Trace; c01ee395 <bus_match+45/80>
> > Trace; c01ee41f <device_attach+4f/90>
> > Trace; c01ee5d5 <bus_add_device+65/b0>
> > Trace; c01ed661 <device_add+d1/100>
> > Trace; c032632c <pci_bus_add_devices+ac/e0>
> > Trace; c0326315 <pci_bus_add_devices+95/e0>
> > Trace; c0326e22 <pci_scan_bus_parented+42/50>
> > Trace; c0330cbb <pcibios_scan_root+6b/80>
> > Trace; c0330648 <pci_legacy_init+38/60>
> > Trace; c031694b <do_initcalls+2b/a0>
> > Trace; c012f27f <init_workqueues+f/24>
> > Trace; c01050d8 <init+58/200>
> > Trace; c0105080 <init+0/200>
> > Trace; c0107229 <kernel_thread_helper+5/c>
> 
> pcibios_irq_init() _must_ run before pcibios_enable_device().  But they are
> both at subsys_initcall(), so we are at the mercy of link order, which 
> appears to be incorrect.

It's worse than that.

> Does this fix it?

It won't.

Look,

    pci_legacy_init() sets pci_root_bus
    pcibios_irq_init() calls pirq_peer_trick(), which uses pci_root_bus

Hence: pci_legacy_init() must come before pcibios_irq_init()

    pcibios_irq_init() sets pcibios_enable_irq
    pci_legacy_init() calls into drivers, which call pcibios_enable_device(),
                      which uses pcibios_enable_irq

Hence: pci_legacy_init() must come _after_ pcibios_irq_init()

uh-oh.

(and pci_direct_init() and pci_pcbios_init() need to come before
pci_legacy_init(), because pci_legacy_init() needs pci_root_ops)

For some reason, the below patch stops the oopses.  Not sure why.


Greg, do you have time/inclination to untangle (and preferably document)
this mess?



diff -puN arch/i386/pci/irq.c~pci-init-ordering-fix arch/i386/pci/irq.c
--- 25/arch/i386/pci/irq.c~pci-init-ordering-fix	Tue Jun 10 15:40:19 2003
+++ 25-akpm/arch/i386/pci/irq.c	Tue Jun 10 15:40:19 2003
@@ -791,7 +791,7 @@ static int __init pcibios_irq_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_irq_init);
+arch_initcall(pcibios_irq_init);
 
 
 void pcibios_penalize_isa_irq(int irq)
diff -puN arch/i386/pci/legacy.c~pci-init-ordering-fix arch/i386/pci/legacy.c
--- 25/arch/i386/pci/legacy.c~pci-init-ordering-fix	Tue Jun 10 15:46:35 2003
+++ 25-akpm/arch/i386/pci/legacy.c	Tue Jun 10 15:46:47 2003
@@ -65,4 +65,4 @@ static int __init pci_legacy_init(void)
 	return 0;
 }
 
-subsys_initcall(pci_legacy_init);
+arch_initcall(pci_legacy_init);

_

