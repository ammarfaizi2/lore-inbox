Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262367AbRENS1M>; Mon, 14 May 2001 14:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262369AbRENS1C>; Mon, 14 May 2001 14:27:02 -0400
Received: from pak218.pakuni.net ([207.91.34.218]:62474 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S262367AbRENS0y>;
	Mon, 14 May 2001 14:26:54 -0400
Date: Mon, 14 May 2001 14:25:59 -0500 (CDT)
From: Mike Phillips <mikep@linuxtr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ibmtr fixes for 2.4.4-ac9
Message-ID: <Pine.LNX.4.10.10105141421470.17762-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple of bugs in the updated driver that stopped it
from working with the isa/isapnp adapters and fixes the compile time
error when compiled into the kernel. 

The patch is against 2.4.4-ac9 (i.e. after Andrzej's updates)

Thanks
Mike Phillips
http://www.linuxtr.net

diff -urN --exclude-from=dontdiff linux-2.4.4-ac9.clean/drivers/net/tokenring/ibmtr.c linux-2.4.4-ac9/drivers/net/tokenring/ibmtr.c
--- linux-2.4.4-ac9.clean/drivers/net/tokenring/ibmtr.c	Mon May 14 11:31:35 2001
+++ linux-2.4.4-ac9/drivers/net/tokenring/ibmtr.c	Mon May 14 12:01:34 2001
@@ -271,7 +271,7 @@
 		for(i=jiffies+TR_BUSY_INTERVAL; time_before_eq(jiffies,i););
 		intf_tbl=ntohs(isa_readw(ram_addr+ACA_OFFSET+ACA_RW+WRBR_EVEN));
 		if (intf_tbl) {
-#if !TR_NEWFORMAT
+#if IBMTR_DEBUG_MESSAGES
 			printk("ibmtr::find_turbo_adapters, Turbo found at "
 				"ram_addr %x\n",ram_addr);
 			printk("ibmtr::find_turbo_adapters, interface_table ");
@@ -288,7 +288,7 @@
 			index++;
 			continue;
 		}
-#if !TR_NEWFORMAT
+#if IBMTR_DEBUG_MESSAGES 
 		printk("ibmtr::find_turbo_adapters, ibmtr card found at"
 			" %x but not a Turbo model\n",ram_addr);
 #endif
@@ -324,11 +324,6 @@
 		return -ENXIO;
 	if (base_addr > 0x1ff) { /* Check a single specified location.  */
 		if (!ibmtr_probe1(dev, base_addr)) return 0;
-#ifndef MODULE
-#ifndef PCMCIA
-		tr_freedev(dev);
-#endif
-#endif
 		return -ENODEV;
 	}
 	find_turbo_adapters(ibmtr_portlist);
@@ -337,11 +332,6 @@
 
 		if (check_region(ioaddr, IBMTR_IO_EXTENT)) continue;
 		if (!ibmtr_probe1(dev, ioaddr)) return 0;
-#ifndef MODULE
-#ifndef PCMCIA
-		tr_freedev(dev);
-#endif
-#endif
 	}
 	return -ENODEV;
 }
@@ -374,16 +364,24 @@
 	 */
 	segment = inb(PIOaddr);
 	if (segment < 0x40 || segment > 0xe0) {
-		/* Out of range values so we'll assume non-existent IO device */
+		/* Out of range values so we'll assume non-existent IO device
+		 * but this is not necessarily a problem, esp if a turbo
+		 * adapter is being used.  */
+#if IBMTR_DEBUG_MESSAGES
 		DPRINTK("ibmtr_probe1(): unhappy that inb(0x%X) == 0x%X, "
 			"Hardware Problem?\n",PIOaddr,segment);
+#endif
 		return -ENODEV;
 	}
 	/*
 	 *    Compute the linear base address of the MMIO area
 	 *    as LINUX doesn't care about segments
 	 */
-	t_mmio = (((__u32) (segment & 0xfc) << 11) + 0x80000);
+	t_mmio = (u32)ioremap(((__u32) (segment & 0xfc) << 11) + 0x80000,2048);
+	if (!t_mmio) { 
+		DPRINTK("Cannot remap mmiobase memory area") ; 
+		return -ENODEV ; 
+	} 
 	intr = segment & 0x03;	/* low bits is coded interrupt # */
 	if (ibmtr_debug_trace & TRC_INIT)
 		DPRINTK("PIOaddr: %4hx seg/intr: %2x mmio base: %08X intr: %d\n"
@@ -454,7 +452,7 @@
 				   adapter support as well /dwm   */
         for(i=0; i<IBMTR_MAX_ADAPTERS; i++) {
                 if (turbo_io[i] != PIOaddr) continue;
-#if !TR_NEWFORMAT
+#if IBMTR_DEBUG_MESSAGES 
 		printk("ibmtr::tr_probe1, setting PIOaddr %x to Turbo\n" ,
 							PIOaddr);
 #endif
@@ -902,6 +900,7 @@
 	int i;
 
 	ti = (struct tok_info *) dev->priv;
+	SET_PAGE(ti->init_srb_page); 
 	writeb(~SRB_RESP_INT, ti->mmio + ACA_OFFSET + ACA_RESET + ISRP_ODD);
 	for (i = 0; i < sizeof(struct dir_open_adapter); i++)
 		writeb(0, ti->init_srb + i);
@@ -1304,7 +1303,7 @@
 				netif_wake_queue(dev);
 				break;
 			}
-#ifdef IBMTR_DEBUG_MESSAGES
+#if IBMTR_DEBUG_MESSAGES
 
 #define LINE_ERRORS_OFST                 0
 #define INTERNAL_ERRORS_OFST             1
@@ -1478,7 +1477,7 @@
 	/* we assign the shared-ram address for ISA devices */
 	writeb(ti->sram_base, ti->mmio + ACA_OFFSET + ACA_RW + RRR_EVEN);
 #ifndef PCMCIA
-        ti->sram_virt=((__u32)ti->sram_base << 12);
+        ti->sram_virt = (u32)ioremap(((__u32)ti->sram_base << 12), ti->avail_shared_ram);
 #endif
 	ti->init_srb = ntohs(readw(ti->mmio + ACA_OFFSET + WRBR_EVEN));
 	if (ti->page_mask) {
@@ -1955,6 +1954,13 @@
 		unregister_trdev(dev_ibmtr[i]);
 		free_irq(dev_ibmtr[i]->irq, dev_ibmtr[i]);
 		release_region(dev_ibmtr[i]->base_addr, IBMTR_IO_EXTENT);
+#ifndef PCMCIA
+		{ 
+		struct tok_info *ti = (struct tok_info *)dev_ibmtr[i]->priv ; 
+		iounmap((u32 *)ti->mmio) ; 
+		iounmap((u32 *)ti->sram_virt) ; 
+		}
+#endif		
 		kfree(dev_ibmtr[i]->priv);
 		kfree(dev_ibmtr[i]);
 		dev_ibmtr[i] = NULL;
diff -urN --exclude-from=dontdiff linux-2.4.4-ac9.clean/include/linux/ibmtr.h linux-2.4.4-ac9/include/linux/ibmtr.h
--- linux-2.4.4-ac9.clean/include/linux/ibmtr.h	Mon May 14 11:31:53 2001
+++ linux-2.4.4-ac9/include/linux/ibmtr.h	Mon May 14 12:02:04 2001
@@ -152,7 +152,7 @@
 #define ACA_RW 0x00
 
 #ifdef ENABLE_PAGING
-#define SET_PAGE(x) (isa_writeb((x), ti->mmio + ACA_OFFSET+ ACA_RW + SRPR_EVEN))
+#define SET_PAGE(x) (writeb((x), ti->mmio + ACA_OFFSET+ ACA_RW + SRPR_EVEN))
 #else
 #define SET_PAGE(x)
 #endif


