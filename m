Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266349AbUH0Ptt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266349AbUH0Ptt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 11:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266308AbUH0Ptn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 11:49:43 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:2235 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266256AbUH0PnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 11:43:15 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: e1000 driver failed to call pci_enable_device
Date: Fri, 27 Aug 2004 09:42:57 -0600
User-Agent: KMail/1.6.2
References: <20040827114408.GA6490@frec.bull.fr>
In-Reply-To: <20040827114408.GA6490@frec.bull.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux.nics@intel.com,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408270942.57621.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 August 2004 5:44 am, you wrote:
>  I tried to boot the linux-2.6.9-rc1-mm1 kernel and it generates an oops
> because the e1000 driver failed to call pci_enable_device(). The kernel
> boots normally with "pci=routeirq" argument sets. I copy the output of
> "lspci" and also the oops message generated during the boot.
> ...
> ----[the oops message]----
> Bringing up interface eth0:  Unable to handle kernel paging request at virtual
> ddress c0500eb0
>  printing eip:
> *pde = 00582027
> Oops: 0000 [#1]
> PREEMPT SMP DEBUG_PAGEALLOC
> Modules linked in: e1000
> CPU:    0
> EIP:    0060:[<c0500eb0>]    Not tainted VLI
> EFLAGS: 00010282   (2.6.9-rc1-mm1)
> EIP is at assign_irq_vector+0x0/0x87
> eax: 00000004   ebx: 00000034   ecx: 00000080   edx: c0545a70
> esi: 00000004   edi: 00000002   ebp: 00000001   esp: f7f0dda4
> ds: 007b   es: 007b   ss: 0068
> Process modprobe (pid: 1760, threadinfo=f7f0c000 task=f7faeb70)
> Stack: c011751e 00000034 00000002 00000004 00000008 0000000c 00000097 f7f0c000
>        00000286 c2223480 00000001 0001a900 03000000 00000004 00000034 00000002
>        00000010 c0114d43 00000002 00000004 00000034 00000001 00000001 00000001
> Call Trace:
>  [<c011751e>] io_apic_set_pci_routing+0x7f/0x222
> ...

Thanks very much for your testing and detailed problem report.  This
problem actually isn't in e1000.  Can you try the attached patch,
please?  I thought I'd seen this patch before, but it doesn't seem to
be in -mm yet.


Make assign_irq_vector() non-__init always (it's called from
io_apic_set_pci_routing(), which is used in the pci_enable_device()
path).

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== arch/i386/kernel/io_apic.c 1.109 vs edited =====
--- 1.109/arch/i386/kernel/io_apic.c	2004-08-24 03:08:37 -06:00
+++ edited/arch/i386/kernel/io_apic.c	2004-08-27 09:30:37 -06:00
@@ -1120,11 +1120,7 @@
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifdef CONFIG_PCI_MSI
 int assign_irq_vector(int irq)
-#else
-int __init assign_irq_vector(int irq)
-#endif
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 


