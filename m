Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTFJVWF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTFJVUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 17:20:44 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:48224 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264026AbTFJVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 17:20:30 -0400
Date: Tue, 10 Jun 2003 14:30:18 -0700
From: Andrew Morton <akpm@digeo.com>
To: boris mogwitz <boris@macbeth.rhoen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: oops while booting : 2.5.70-bk1[4,5] - Process swapper
Message-Id: <20030610143018.025d318c.akpm@digeo.com>
In-Reply-To: <20030610202947.GA752@macbeth.rhoen.de>
References: <20030610202947.GA752@macbeth.rhoen.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 21:34:10.0864 (UTC) FILETIME=[07C8CB00:01C32F98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

boris mogwitz <boris@macbeth.rhoen.de> wrote:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ...
> 
> Trace; c0254888 <pcibios_enable_device+28/30>
> Trace; c01c4f7b <pci_enable_device_bars+2b/40>
> Trace; c01c4fa7 <pci_enable_device+17/20>
> Trace; c02466e9 <matroxfb_probe+d9/2d0>
> Trace; c01c6222 <pci_device_probe_static+52/70>
> Trace; c01c63bc <__pci_device_probe+3c/50>
> Trace; c01c63ff <pci_device_probe+2f/50>
> Trace; c01ee395 <bus_match+45/80>
> Trace; c01ee41f <device_attach+4f/90>
> Trace; c01ee5d5 <bus_add_device+65/b0>
> Trace; c01ed661 <device_add+d1/100>
> Trace; c032632c <pci_bus_add_devices+ac/e0>
> Trace; c0326315 <pci_bus_add_devices+95/e0>
> Trace; c0326e22 <pci_scan_bus_parented+42/50>
> Trace; c0330cbb <pcibios_scan_root+6b/80>
> Trace; c0330648 <pci_legacy_init+38/60>
> Trace; c031694b <do_initcalls+2b/a0>
> Trace; c012f27f <init_workqueues+f/24>
> Trace; c01050d8 <init+58/200>
> Trace; c0105080 <init+0/200>
> Trace; c0107229 <kernel_thread_helper+5/c>

pcibios_irq_init() _must_ run before pcibios_enable_device().  But they are
both at subsys_initcall(), so we are at the mercy of link order, which 
appears to be incorrect.

Does this fix it?


diff -puN arch/i386/pci/irq.c~pci-init-ordering-fix arch/i386/pci/irq.c
--- 25/arch/i386/pci/irq.c~pci-init-ordering-fix	Tue Jun 10 14:29:40 2003
+++ 25-akpm/arch/i386/pci/irq.c	Tue Jun 10 14:29:40 2003
@@ -791,7 +791,7 @@ static int __init pcibios_irq_init(void)
 	return 0;
 }
 
-subsys_initcall(pcibios_irq_init);
+arch_initcall(pcibios_irq_init);
 
 
 void pcibios_penalize_isa_irq(int irq)

_

