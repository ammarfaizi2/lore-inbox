Return-Path: <linux-kernel-owner+w=401wt.eu-S932152AbXAIPSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbXAIPSy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 10:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbXAIPSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 10:18:54 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:18304 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932152AbXAIPSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 10:18:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=mbf.nifty.com;
  b=L9eWeq2n/pELtOj/ZoFaZCVznhN52JnWtQPHaD+u+nIdJ0+KzuCML2Na3Cj+wslZP+qYN2RjXM46Pu2XdFzlaA==  ;
Date: Wed, 10 Jan 2007 00:19:14 +0900 (JST)
Message-Id: <20070110.001914.205303383.takada@mbf.nifty.com>
To: alan@lxorguk.ukuu.org.uk
Cc: miura@da-cha.org, linux-kernel@vger.kernel.org
Subject: Re: i386,2.6 cyrix.c cann't found companion chip
From: takada <takada@mbf.nifty.com>
In-Reply-To: <20070108170654.77dd811a@localhost.localdomain>
References: <20070107094738.21919.qmail@smb516.nifty.com>
	<45A11900.3020302@da-cha.org>
	<20070108170654.77dd811a@localhost.localdomain>
X-Mailer: Mew version 5.1 on Emacs 22.0.92 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.
Your patch dosen't work on 2.6.19.1.
pci_conf1_read() requires u32 pointer for a value of a register.
I replaced u16 to u32.
The vendor-ID and dvice ID that pci_conf1_read() got were:
  vender: 0x00021078
  device: 0x0280000f.

My result of lcpci -vn is follow:

00:12.0 0601: 1078:0002
	Flags: bus master, medium devsel, latency 64
	I/O ports at 3000 [size=128]
	I/O ports at 4000 [size=32]
	I/O ports at 5000 [size=16]
	Memory at 40010000 (32-bit, non-prefetchable) [size=4K]

The low word in vender-id that pci_conf1_reqd() store to u32 is correct. But, device-id is wrong.
I attach modified patch. It just work on my machine.
BTW, This patch is assuming that the PCI slot number is 0x12, Is it by Cyrix's spec?

--- linux-2.6.19/arch/i386/kernel/cpu/cyrix.c.orig	2007-01-09 16:45:21.000000000 +0900
+++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-09 16:50:57.000000000 +0900
@@ -8,6 +8,7 @@
 #include <asm/timer.h>
 
 #include "cpu.h"
+#include "../../pci/pci.h"
 
 /*
  * Read NSC/Cyrix DEVID registers (DIR) to get more detailed info. about the CPU
@@ -183,19 +184,12 @@ static void __cpuinit geode_configure(vo
 }
 
 
-#ifdef CONFIG_PCI
-static struct pci_device_id __cpuinitdata cyrix_55x0[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5510) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520) },
-	{ },
-};
-#endif
-
 static void __cpuinit init_cyrix(struct cpuinfo_x86 *c)
 {
 	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
 	char *buf = c->x86_model_id;
 	const char *p = NULL;
+	u32 vendor, device;
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -273,11 +267,16 @@ static void __cpuinit init_cyrix(struct 
 		printk(KERN_INFO "Working around Cyrix MediaGX virtual DMA bugs.\n");
 		isa_dma_bridge_buggy = 2;
 
+		/* We do this before the PCI layer is running. However we 
+		   are safe here as we know the bridge must be a Cyrix 
+		   companion and must be present */
+		pci_conf1_read(0, 0, PCI_DEVFN(0x12, 0), PCI_VENDOR_ID, 2, &vendor);
+		pci_conf1_read(0, 0, PCI_DEVFN(0x12, 0), PCI_DEVICE_ID, 2, &device);
 
 		/*
 		 *  The 5510/5520 companion chips have a funky PIT.
 		 */  
-		if (pci_dev_present(cyrix_55x0))
+		if (vendor == PCI_VENDOR_ID_CYRIX && (device == PCI_DEVICE_ID_CYRIX_5510 || device == PCI_DEVICE_ID_CYRIX_5520))
 			pit_latch_buggy = 1;
 #endif
 		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it */


From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: i386,2.6 cyrix.c cann't found companion chip
Date: Mon, 8 Jan 2007 17:06:54 +0000

> On Mon, 08 Jan 2007 01:00:00 +0900
> Hiroshi Miura <miura@da-cha.org> wrote:
> 
> > Hi Takada-san,
> > 
> > It is  obviously bad.
> > These part is added several years ago by my post.
> > A cyrix.c try to find chip because of chip hardware bug affected
> > to timer which has started early.
> > 
> > Now, these chips have already been obsolete.
> > There are 2 options. One is simply remove these functionality.
> > The other is to move it to compile time ifdef that is off by default.
> > 
> > For user who use in embbeded environment,
> > I wanna change it to ifdef.
> > 
> > Thank you for report!
> > 
> > Hiroshi
> 
> What do the you think of this as a solution ?
> 
> Signed-off-by: Alan Cox <alan@redhat.com>
> 
> --- linux.vanilla-2.6.20-rc4/arch/i386/kernel/cpu/cyrix.c	2007-01-01 21:40:52.000000000 +0000
> +++ linux-2.6.20-rc4/arch/i386/kernel/cpu/cyrix.c	2007-01-08 16:36:31.762654720 +0000
> @@ -196,6 +196,7 @@
>  	unsigned char dir0, dir0_msn, dir0_lsn, dir1 = 0;
>  	char *buf = c->x86_model_id;
>  	const char *p = NULL;
> +	u16 vendor, device;
>  
>  	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
>  	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
> @@ -257,7 +258,6 @@
>  		break;
>  
>  	case 4: /* MediaGX/GXm or Geode GXM/GXLV/GX1 */
> -#ifdef CONFIG_PCI
>  		/* It isn't really a PCI quirk directly, but the cure is the
>  		   same. The MediaGX has deep magic SMM stuff that handles the
>  		   SB emulation. It thows away the fifo on disable_dma() which
> @@ -265,22 +265,26 @@
>  
>  		   Bug2: VSA1 has a wrap bug so that using maximum sized DMA 
>  		   causes bad things. According to NatSemi VSA2 has another
> -		   bug to do with 'hlt'. I've not seen any boards using VSA2
> -		   and X doesn't seem to support it either so who cares 8).
> -		   VSA1 we work around however.
> +		   bug to do with 'hlt'.
>  		*/
>  
>  		printk(KERN_INFO "Working around Cyrix MediaGX virtual DMA bugs.\n");
>  		isa_dma_bridge_buggy = 2;
> -
> +		
> +		/* We do this before the PCI layer is running. However we 
> +		   are safe here as we know the bridge must be a Cyrix 
> +		   companion and must be present */
> +		   
> +		pci_conf1_read(0, 0, PCI_DEVFN(0x12, 0), 0, 4, &vendor);
> +		pci_conf1_read(0, 0, PCI_DEVFN(0x12, 0), 4, 4, &device);
>  
>  		/*
>  		 *  The 5510/5520 companion chips have a funky PIT.
>  		 */  
> -		if (pci_dev_present(cyrix_55x0))
> +		if (vendor == PCI_VENDOR_ID_CYRIX && (device == PCI_DEVICE_ID_CYRIX_5510 || device == PCI_DEVICE_ID_CYRIX_5520))
>  			pit_latch_buggy = 1;
> -#endif
> -		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it */
> +
> +		c->x86_cache_size=16;	/* Yep 16K integrated cache thats it (12K in X) */
>  
>  		/* GXm supports extended cpuid levels 'ala' AMD */
>  		if (c->cpuid_level == 2) {
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> 
