Return-Path: <linux-kernel-owner+w=401wt.eu-S1750916AbXAHQ4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbXAHQ4I (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 11:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXAHQ4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 11:56:08 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52853 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750917AbXAHQ4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 11:56:07 -0500
Date: Mon, 8 Jan 2007 17:06:54 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Hiroshi Miura <miura@da-cha.org>
Cc: TAKADA <takada@mbf.nifty.com>, linux-kernel@vger.kernel.org
Subject: Re: i386,2.6 cyrix.c cann't found companion chip
Message-ID: <20070108170654.77dd811a@localhost.localdomain>
In-Reply-To: <45A11900.3020302@da-cha.org>
References: <20070107094738.21919.qmail@smb516.nifty.com>
	<45A11900.3020302@da-cha.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jan 2007 01:00:00 +0900
Hiroshi Miura <miura@da-cha.org> wrote:

> Hi Takada-san,
> 
> It is  obviously bad.
> These part is added several years ago by my post.
> A cyrix.c try to find chip because of chip hardware bug affected
> to timer which has started early.
> 
> Now, these chips have already been obsolete.
> There are 2 options. One is simply remove these functionality.
> The other is to move it to compile time ifdef that is off by default.
> 
> For user who use in embbeded environment,
> I wanna change it to ifdef.
> 
> Thank you for report!
> 
> Hiroshi

What do the you think of this as a solution ?

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux.vanilla-2.6.20-rc4/arch/i386/kernel/cpu/cyrix.c	2007-01-01 21:40:52.000000000 +0000
+++ linux-2.6.20-rc4/arch/i386/kernel/cpu/cyrix.c	2007-01-08 16:36:31.762654720 +0000
@@ -196,6 +196,7 @@
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
 	const char *p = NULL;
+	u16 vendor, device;
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -257,7 +258,6 @@
 		break;
 
 	case 4: /* MediaGX/GXm or Geode GXM/GXLV/GX1 */
-#ifdef CONFIG_PCI
 		/* It isn't really a PCI quirk directly, but the cure is the
 		   same. The MediaGX has deep magic SMM stuff that handles the
 		   SB emulation. It thows away the fifo on disable_dma() which
@@ -265,22 +265,26 @@
 
 		   Bug2: VSA1 has a wrap bug so that using maximum sized DMA 
 		   causes bad things. According to NatSemi VSA2 has another
-		   bug to do with 'hlt'. I've not seen any boards using VSA2
-		   and X doesn't seem to support it either so who cares 8).
-		   VSA1 we work around however.
+		   bug to do with 'hlt'.
 		*/
 
 		printk(KERN_INFO "Working around Cyrix MediaGX virtual DMA bugs.\n");
 		isa_dma_bridge_buggy = 2;
-
+		
+		/* We do this before the PCI layer is running. However we 
+		   are safe here as we know the bridge must be a Cyrix 
+		   companion and must be present */
+		   
+		pci_conf1_read(0, 0, PCI_DEVFN(0x12, 0), 0, 4, &vendor);
+		pci_conf1_read(0, 0, PCI_DEVFN(0x12, 0), 4, 4, &device);
 
 		/*
 		 *  The 5510/5520 companion chips have a funky PIT.
 		 */  
-		if (pci_dev_present(cyrix_55x0))
+		if (vendor == PCI_VENDOR_ID_CYRIX && (device == PCI_DEVICE_ID_CYRIX_5510 || device == PCI_DEVICE_ID_CYRIX_5520))
 			pit_latch_buggy = 1;
-#endif
-		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it */
+
+		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it (12K in X) */
 
 		/* GXm supports extended cpuid levels 'ala' AMD */
 		if (c->cpuid_level == 2) {
