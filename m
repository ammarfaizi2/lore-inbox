Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261811AbSJIQvZ>; Wed, 9 Oct 2002 12:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261826AbSJIQvZ>; Wed, 9 Oct 2002 12:51:25 -0400
Received: from verein.lst.de ([212.34.181.86]:7 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261811AbSJIQvN>;
	Wed, 9 Oct 2002 12:51:13 -0400
Date: Wed, 9 Oct 2002 18:56:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] initcalls for ATM
Message-ID: <20021009185653.A26567@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Switch over ATM code to initcalls and reorder the makefile so
that link order inside atm is the same.  I've also cleaned up
the makefile a bit while at it.   I didn't fix the existing
compilation problems in the drivers (cli & friends) and the
broken le/be firmware selection for the fore200e cards (kbuild
breakage) though.


--- 1.11/drivers/atm/Makefile	Wed Jun 19 04:52:38 2002
+++ edited/drivers/atm/Makefile	Wed Oct  9 18:42:58 2002
@@ -2,61 +2,50 @@
 # Makefile for the Linux network (ATM) device drivers.
 #
 
-export-objs := uPD98402.o suni.o idt77105.o
+EXTRA_CFLAGS := -g
+
+export-objs	:= uPD98402.o suni.o idt77105.o
+fore_200e-objs	:= fore200e.o
+host-progs	:= fore200e_mkfirm
 
-obj-y := atmdev_init.o
 
-obj-$(CONFIG_ATM_ENI) += eni.o suni.o
-obj-$(CONFIG_ATM_ZATM) += zatm.o uPD98402.o
-obj-$(CONFIG_ATM_NICSTAR) += nicstar.o
-obj-$(CONFIG_ATM_IDT77252) += idt77252.o
+obj-$(CONFIG_ATM_ZATM)		+= zatm.o uPD98402.o
+obj-$(CONFIG_ATM_NICSTAR)	+= nicstar.o
+obj-$(CONFIG_ATM_AMBASSADOR)	+= ambassador.o
+obj-$(CONFIG_ATM_HORIZON)	+= horizon.o
+obj-$(CONFIG_ATM_IA)		+= iphase.o suni.o
+obj-$(CONFIG_ATM_FORE200E)	+= fore_200e.o
+obj-$(CONFIG_ATM_ENI)		+= eni.o suni.o
+obj-$(CONFIG_ATM_IDT77252)	+= idt77252.o
 
 ifeq ($(CONFIG_ATM_NICSTAR_USE_SUNI),y)
-  obj-$(CONFIG_ATM_NICSTAR) += suni.o
+  obj-$(CONFIG_ATM_NICSTAR)	+= suni.o
 endif
-
 ifeq ($(CONFIG_ATM_NICSTAR_USE_IDT77105),y)
-  obj-$(CONFIG_ATM_NICSTAR) += idt77105.o
+  obj-$(CONFIG_ATM_NICSTAR)	+= idt77105.o
 endif
-
 ifeq ($(CONFIG_ATM_IDT77252_USE_SUNI),y)
-  obj-$(CONFIG_ATM_IDT77252) += suni.o
+  obj-$(CONFIG_ATM_IDT77252)	+= suni.o
 endif
 
-obj-$(CONFIG_ATM_HORIZON) += horizon.o
-obj-$(CONFIG_ATM_AMBASSADOR) += ambassador.o
-obj-$(CONFIG_ATM_TCP) += atmtcp.o
-obj-$(CONFIG_ATM_IA) += iphase.o suni.o
-obj-$(CONFIG_ATM_FIRESTREAM) += firestream.o
-obj-$(CONFIG_ATM_LANAI) += lanai.o
+obj-$(CONFIG_ATM_TCP)		+= atmtcp.o
+obj-$(CONFIG_ATM_FIRESTREAM)	+= firestream.o
+obj-$(CONFIG_ATM_LANAI)		+= lanai.o
 
 ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
-  FORE200E_FW_OBJS += fore200e_pca_fw.o
-  ifeq ($(strip $(CONFIG_ATM_FORE200E_PCA_FW)),"")
-    CONFIG_ATM_FORE200E_PCA_DEFAULT_FW := y
-  endif
+  fore_200e-objs		+= fore200e_pca_fw.o
+  # guess the target endianess to choose the right PCA-200E firmware image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
-#   guess the target endianess to choose the right PCA-200E firmware image
-    CONFIG_ATM_FORE200E_PCA_FW := $(shell if test -n "`$(CC) -E -dM ../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo pca200e.bin; else echo pca200e_ecd.bin2; fi)
+    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM $(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then echo pca200e.bin; else echo pca200e_ecd.bin2; fi)
   endif
 endif
+
 ifeq ($(CONFIG_ATM_FORE200E_SBA),y)
-  FORE200E_FW_OBJS += fore200e_sba_fw.o
-  ifeq ($(strip $(CONFIG_ATM_FORE200E_SBA_FW)),"")
-    CONFIG_ATM_FORE200E_SBA_DEFAULT_FW := y
-  endif
+  fore_200e-objs		+= fore200e_sba_fw.o
   ifeq ($(CONFIG_ATM_FORE200E_SBA_DEFAULT_FW),y)
-    CONFIG_ATM_FORE200E_SBA_FW := sba200e_ecd.bin2
+    CONFIG_ATM_FORE200E_SBA_FW	:= sba200e_ecd.bin2
   endif
 endif
-
-obj-$(CONFIG_ATM_FORE200E) += fore_200e.o
-
-fore_200e-objs	:= fore200e.o $(FORE200E_FW_OBJS)
-
-host-progs := fore200e_mkfirm
-
-EXTRA_CFLAGS := -g
 
 include $(TOPDIR)/Rules.make
 
===== drivers/atm/ambassador.c 1.7 vs edited =====
--- 1.7/drivers/atm/ambassador.c	Tue Oct  1 18:32:15 2002
+++ edited/drivers/atm/ambassador.c	Wed Oct  9 17:43:49 2002
@@ -2576,7 +2576,6 @@
 
 /********** module stuff **********/
 
-#ifdef MODULE
 MODULE_AUTHOR(maintainer_string);
 MODULE_DESCRIPTION(description_string);
 MODULE_LICENSE("GPL");
@@ -2597,7 +2596,7 @@
 
 /********** module entry **********/
 
-int init_module (void) {
+static int __init amb_module_init (void) {
   int devs;
   
   PRINTD (DBG_FLOW|DBG_INIT, "init_module");
@@ -2631,7 +2630,7 @@
 
 /********** module exit **********/
 
-void cleanup_module (void) {
+static void __exit amb_module_exit (void) {
   amb_dev * dev;
   
   PRINTD (DBG_FLOW|DBG_INIT, "cleanup_module");
@@ -2659,38 +2658,5 @@
   return;
 }
 
-#else
-
-/********** monolithic entry **********/
-
-int __init amb_detect (void) {
-  int devs;
-  
-  // sanity check - cast needed as printk does not support %Zu
-  if (sizeof(amb_mem) != 4*16 + 4*12) {
-    PRINTK (KERN_ERR, "Fix amb_mem (is %lu words).",
-	    (unsigned long) sizeof(amb_mem));
-    return 0;
-  }
-  
-  show_version();
-  
-  amb_check_args();
-  
-  // get the juice
-  devs = amb_probe();
-  
-  if (devs) {
-    init_timer (&housekeeping);
-    housekeeping.function = do_housekeeping;
-    // paranoia
-    housekeeping.data = 1;
-    set_timer (&housekeeping, 0);
-  } else {
-    PRINTK (KERN_INFO, "no (usable) adapters found");
-  }
-  
-  return devs;
-}
-
-#endif
+module_init(amb_module_init);
+module_exit(amb_module_exit);
===== drivers/atm/fore200e.c 1.10 vs edited =====
--- 1.10/drivers/atm/fore200e.c	Mon Sep 30 03:56:40 2002
+++ edited/drivers/atm/fore200e.c	Wed Oct  9 18:23:40 2002
@@ -96,11 +96,9 @@
 static struct fore200e* fore200e_boards = NULL;
 
 
-#ifdef MODULE
 MODULE_AUTHOR("Christophe Lizzi - credits to Uwe Dannowski and Heikki Vatiainen");
 MODULE_DESCRIPTION("FORE Systems 200E-series ATM driver - version " FORE200E_VERSION);
 MODULE_SUPPORTED_DEVICE("PCA-200E, SBA-200E");
-#endif
 
 
 static const int fore200e_rx_buf_nbr[ BUFFER_SCHEME_NBR ][ BUFFER_MAGN_NBR ] = {
@@ -2583,9 +2581,8 @@
     return 0;
 }
 
-
-int __init
-fore200e_detect(void)
+static int __init
+fore200e_module_init(void)
 {
     const struct fore200e_bus* bus;
     struct       fore200e*     fore200e;
@@ -2618,23 +2615,24 @@
 	}
     }
 
-    return link;
+    if (link)
+        return 0;
+    return -ENODEV;
 }
 
 
-#ifdef MODULE
-static void
-fore200e_cleanup(struct fore200e** head)
+static void __exit
+fore200e_module_cleanup(void)
 {
-    struct fore200e* fore200e = *head;
-
-    fore200e_shutdown(fore200e);
-
-    *head = fore200e->next;
+    while (fore200e_boards) {
+        struct fore200e* fore200e = fore200e_boards;
 
-    kfree(fore200e);
+	fore200e_shutdown(fore200e);
+	fore200e_boards = fore200e->next;
+	kfree(fore200e);
+    }
+    DPRINTK(1, "module being removed\n");
 }
-#endif
 
 
 static int
@@ -2907,27 +2905,8 @@
     return 0;
 }
 
-
-#ifdef MODULE
-static int __init
-fore200e_module_init(void)
-{
-    DPRINTK(1, "module loaded\n");
-    return fore200e_detect() == 0;
-}
-
-static void __exit
-fore200e_module_cleanup(void)
-{
-    while (fore200e_boards) {
-	fore200e_cleanup(&fore200e_boards);
-    }
-    DPRINTK(1, "module being removed\n");
-}
-
 module_init(fore200e_module_init);
 module_exit(fore200e_module_cleanup);
-#endif
 
 
 static const struct atmdev_ops fore200e_ops =
===== drivers/atm/horizon.c 1.6 vs edited =====
--- 1.6/drivers/atm/horizon.c	Mon Sep 30 03:56:40 2002
+++ edited/drivers/atm/horizon.c	Wed Oct  9 17:45:47 2002
@@ -2927,7 +2927,6 @@
   return;
 }
 
-#ifdef MODULE
 MODULE_AUTHOR(maintainer_string);
 MODULE_DESCRIPTION(description_string);
 MODULE_LICENSE("GPL");
@@ -2944,7 +2943,7 @@
 
 /********** module entry **********/
 
-int init_module (void) {
+static int __init hrz_module_init (void) {
   int devs;
   
   // sanity check - cast is needed since printk does not support %Zu
@@ -2977,7 +2976,7 @@
 
 /********** module exit **********/
 
-void cleanup_module (void) {
+static void __exit hrz_module_exit (void) {
   hrz_dev * dev;
   PRINTD (DBG_FLOW, "cleanup_module");
   
@@ -3000,40 +2999,5 @@
   return;
 }
 
-#else
-
-/********** monolithic entry **********/
-
-int __init hrz_detect (void) {
-  int devs;
-  
-  // sanity check - cast is needed since printk does not support %Zu
-  if (sizeof(struct MEMMAP) != 128*1024/4) {
-    PRINTK (KERN_ERR, "Fix struct MEMMAP (is %lu fakewords).",
-	    (unsigned long) sizeof(struct MEMMAP));
-    return 0;
-  }
-  
-  show_version();
-  
-  // what about command line arguments?
-  // check arguments
-  hrz_check_args();
-  
-  // get the juice
-  devs = hrz_probe();
-  
-  if (devs) {
-    init_timer (&housekeeping);
-    housekeeping.function = do_housekeeping;
-    // paranoia
-    housekeeping.data = 1;
-    set_timer (&housekeeping, 0);
-  } else {
-    PRINTK (KERN_ERR, "no (usable) adapters found");
-  }
-
-  return devs;
-}
-
-#endif
+module_init(hrz_module_init);
+module_exit(hrz_module_exit);
===== drivers/atm/iphase.c 1.7 vs edited =====
--- 1.7/drivers/atm/iphase.c	Sat Aug  3 19:45:52 2002
+++ edited/drivers/atm/iphase.c	Wed Oct  9 18:23:06 2002
@@ -40,9 +40,6 @@
 
 *******************************************************************************/
 
-#ifdef IA_MODULE
-#define MODULE
-#endif
 #include <linux/version.h>
 #include <linux/module.h>  
 #include <linux/kernel.h>  
@@ -88,13 +85,11 @@
 static u32 IADebugFlag = /* IF_IADBG_ERR | IF_IADBG_CBR| IF_IADBG_INIT_ADAPTER
             |IF_IADBG_ABR | IF_IADBG_EVENT*/ 0; 
 
-#ifdef MODULE
 MODULE_PARM(IA_TX_BUF, "i");
 MODULE_PARM(IA_TX_BUF_SZ, "i");
 MODULE_PARM(IA_RX_BUF, "i");
 MODULE_PARM(IA_RX_BUF_SZ, "i");
 MODULE_PARM(IADebugFlag, "i");
-#endif
 
 MODULE_LICENSE("GPL");
 
@@ -1162,10 +1157,7 @@
 	   goto out_free_desc;
         }
 		  
-#if LINUX_VERSION_CODE >= 0x20312
         if (!(skb = atm_alloc_charge(vcc, len, GFP_ATOMIC))) {
-#else
-        if (atm_charge(vcc, atm_pdu2truesize(len))) {
 	   /* lets allocate an skb for now */  
 	   skb = alloc_skb(len, GFP_ATOMIC);  
 	   if (!skb)  
@@ -1178,7 +1170,6 @@
         }
         else {
            IF_EVENT(printk("IA: Rx over the rx_quota %ld\n", vcc->rx_quota);)
-#endif
            if (vcc->vci < 32)
               printk("Drop control packets\n");
 	      goto out_free_desc;
@@ -1323,11 +1314,7 @@
           {
              atomic_inc(&vcc->stats->rx_err);
              dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE >= 0x20312
              atm_return(vcc, atm_guess_pdu2truesize(len));
-#else
-             atm_return(vcc, atm_pdu2truesize(len));
-#endif
              goto INCR_DLE;
            }
           // get real pkt length  pwang_test
@@ -1341,11 +1328,7 @@
              IF_ERR(printk("rx_dle_intr: Bad  AAL5 trailer %d (skb len %d)", 
                                                             length, skb->len);)
              dev_kfree_skb_any(skb);
-#if LINUX_VERSION_CODE >= 0x20312
              atm_return(vcc, atm_guess_pdu2truesize(len));
-#else
-             atm_return(vcc, atm_pdu2truesize(len));
-#endif 
              goto INCR_DLE;
           }
           skb_trim(skb, length);
@@ -2164,13 +2147,8 @@
         writew(0xaa00, iadev->seg_reg+ABRUBR_ARB); 
 
         iadev->close_pending = 0;
-#if LINUX_VERSION_CODE >= 0x20303
         init_waitqueue_head(&iadev->close_wait);
         init_waitqueue_head(&iadev->timeout_wait);
-#else
-        iadev->close_wait = NULL;
-        iadev->timeout_wait = NULL;
-#endif 
 	skb_queue_head_init(&iadev->tx_dma_q);  
 	ia_init_rtn_q(&iadev->tx_return_q);  
 
@@ -2282,11 +2260,7 @@
 }  
 	  
 	  
-#if LINUX_VERSION_CODE >= 0x20312
 static int __init ia_init(struct atm_dev *dev)
-#else
-__initfunc(static int ia_init(struct atm_dev *dev))
-#endif  
 {  
 	IADEV *iadev;  
 	unsigned long real_base, base;  
@@ -2455,11 +2429,7 @@
 	return readl(INPH_IA_DEV(dev)->phy+addr);  
 }  
 
-#if LINUX_VERSION_CODE >= 0x20312
 static int __init ia_start(struct atm_dev *dev)
-#else
-__initfunc(static int ia_start(struct atm_dev *dev))
-#endif  
 {  
 	IADEV *iadev;  
 	int error = 1;  
@@ -2555,7 +2525,7 @@
            SUNI_RSOP_CIE_LOSE - 0x04
         */
         ia_phy_put(dev, ia_phy_get(dev,0x10) | 0x04, 0x10);         
-#ifndef MODULE
+#if 0
 	error = dev->phy->start(dev);  
 	if (error) {
           free_irq(iadev->irq, dev);
@@ -2705,7 +2675,7 @@
   
 	set_bit(ATM_VF_READY,&vcc->flags);
 
-#ifndef MODULE
+#if 0
         {
            static u8 first = 1; 
            if (first) {
@@ -3163,11 +3133,7 @@
 };  
 	  
   
-#if LINUX_VERSION_CODE >= 0x20312
-int __init ia_detect(void)
-#else
-__initfunc(int ia_detect(void)) 
-#endif 
+static int __init ia_detect(void)
 {  
 	struct atm_dev *dev;  
 	IADEV *iadev;  
@@ -3224,10 +3190,7 @@
 	return index;  
 }  
   
-
-#ifdef MODULE  
-  
-int init_module(void)  
+static int __init ia_module_init(void)
 {  
 	IF_EVENT(printk(">ia init_module\n");)  
 	if (!ia_detect()) {  
@@ -3241,7 +3204,7 @@
 }  
   
   
-void cleanup_module(void)  
+static void __exit ia_module_exit(void)
 {  
 	struct atm_dev *dev;  
 	IADEV *iadev;  
@@ -3291,7 +3254,7 @@
                ia_dev[i] =  NULL;
               _ia_dev[i] = NULL;
         }
-}  
-
-#endif  
+}
 
+module_init(ia_module_init);
+module_exit(ia_module_exit);
===== drivers/atm/lanai.c 1.4 vs edited =====
--- 1.4/drivers/atm/lanai.c	Mon Oct  7 20:39:20 2002
+++ edited/drivers/atm/lanai.c	Wed Oct  9 17:57:39 2002
@@ -2882,27 +2882,16 @@
 	return count;
 }
 
-#ifdef MODULE
-static
-#endif
-int __init lanai_detect(void)
+static int __init lanai_module_init(void)
 {
-	return lanai_detect_1(PCI_VENDOR_ID_EF, PCI_VENDOR_ID_EF_ATM_LANAI2) +
-	       lanai_detect_1(PCI_VENDOR_ID_EF, PCI_VENDOR_ID_EF_ATM_LANAIHB);
+	if (lanai_detect_1(PCI_VENDOR_ID_EF, PCI_VENDOR_ID_EF_ATM_LANAI2) +
+	    lanai_detect_1(PCI_VENDOR_ID_EF, PCI_VENDOR_ID_EF_ATM_LANAIHB))
+		return 0;
+	printk(KERN_ERR DEV_LABEL ": no adaptor found\n");
+	return -ENODEV;
 }
 
-#ifdef MODULE
-
-int init_module(void)
-{
-	if (lanai_detect() == 0) {
-		printk(KERN_ERR DEV_LABEL ": no adaptor found\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-void cleanup_module(void)
+static void __exit lanai_module_exit(void)
 {
 	/* We'll only get called when all the interfaces are already
 	 * gone, so there isn't much to do
@@ -2910,8 +2899,9 @@
 	DPRINTK("cleanup_module()\n");
 }
 
+module_init(lanai_module_init);
+module_exit(lanai_module_exit);
+
 MODULE_AUTHOR("Mitchell Blank Jr <mitch@sfgoth.com>");
 MODULE_DESCRIPTION("Efficient Networks Speedstream 3010 driver");
 MODULE_LICENSE("GPL");
-
-#endif /* MODULE */
===== drivers/atm/nicstar.c 1.9 vs edited =====
--- 1.9/drivers/atm/nicstar.c	Mon Sep 30 03:56:41 2002
+++ edited/drivers/atm/nicstar.c	Wed Oct  9 17:42:03 2002
@@ -276,15 +276,13 @@
 
 /* Functions*******************************************************************/
 
-#ifdef MODULE
-
-int __init init_module(void)
+static int __init nicstar_module_init(void)
 {
    int i;
    unsigned error = 0;	/* Initialized to remove compile warning */
    struct pci_dev *pcidev;
 
-   XPRINTK("nicstar: init_module() called.\n");
+   XPRINTK("nicstar: nicstar_module_init() called.\n");
    if(!pci_present())
    {
       printk("nicstar: no PCI subsystem found.\n");
@@ -323,7 +321,7 @@
 #ifdef PHY_LOOPBACK
    printk("nicstar: using PHY loopback.\n");
 #endif /* PHY_LOOPBACK */
-   XPRINTK("nicstar: init_module() returned.\n");
+   XPRINTK("nicstar: nicstar_module_init() returned.\n");
 
    init_timer(&ns_timer);
    ns_timer.expires = jiffies + NS_POLL_PERIOD;
@@ -335,7 +333,7 @@
 
 
 
-void cleanup_module(void)
+static void __exit nicstar_module_exit(void)
 {
    int i, j;
    unsigned short pci_command;
@@ -419,60 +417,6 @@
    XPRINTK("nicstar: cleanup_module() returned.\n");
 }
 
-
-#else
-
-int __init nicstar_detect(void)
-{
-   int i;
-   unsigned error = 0;	/* Initialized to remove compile warning */
-   struct pci_dev *pcidev;
-
-   if(!pci_present())
-   {
-      printk("nicstar: no PCI subsystem found.\n");
-      return -EIO;
-   }
-
-   for(i = 0; i < NS_MAX_CARDS; i++)
-      cards[i] = NULL;
-
-   pcidev = NULL;
-   for(i = 0; i < NS_MAX_CARDS; i++)
-   {
-      if ((pcidev = pci_find_device(PCI_VENDOR_ID_IDT,
-                                    PCI_DEVICE_ID_IDT_IDT77201,
-                                    pcidev)) == NULL)
-         break;
-
-      error = ns_init_card(i, pcidev);
-      if (error)
-         cards[i--] = NULL;	/* Try to find another card but don't increment index */
-   }
-
-   if (i == 0 && error)
-      return -EIO;
-
-   TXPRINTK("nicstar: TX debug enabled.\n");
-   RXPRINTK("nicstar: RX debug enabled.\n");
-   PRINTK("nicstar: General debug enabled.\n");
-#ifdef PHY_LOOPBACK
-   printk("nicstar: using PHY loopback.\n");
-#endif /* PHY_LOOPBACK */
-   XPRINTK("nicstar: init_module() returned.\n");
-
-   init_timer(&ns_timer);
-   ns_timer.expires = jiffies + NS_POLL_PERIOD;
-   ns_timer.data = 0UL;
-   ns_timer.function = ns_poll;
-   add_timer(&ns_timer);
-   return i;
-}
-
-
-#endif /* MODULE */
-
-
 static u32 ns_read_sram(ns_dev *card, u32 sram_address)
 {
    unsigned long flags;
@@ -3156,3 +3100,6 @@
    spin_unlock_irqrestore(&card->res_lock, flags);
    return (unsigned char) data;
 }
+
+module_init(nicstar_module_init);
+module_exit(nicstar_module_exit);
===== drivers/atm/zatm.c 1.7 vs edited =====
--- 1.7/drivers/atm/zatm.c	Mon Sep 30 03:56:41 2002
+++ edited/drivers/atm/zatm.c	Wed Oct  9 18:11:18 2002
@@ -1806,8 +1806,7 @@
 	.change_qos	= zatm_change_qos,
 };
 
-
-int __init zatm_detect(void)
+static int __init zatm_module_init(void)
 {
 	struct atm_dev *dev;
 	struct zatm_dev *zatm_dev;
@@ -1841,36 +1840,18 @@
 			    zatm_dev),GFP_KERNEL);
 			if (!zatm_dev) {
 				printk(KERN_EMERG "zatm.c: memory shortage\n");
-				return devs;
+				goto out;
 			}
 		}
 	}
+out:
 	kfree(zatm_dev);
-	return devs;
-}
-
 
-#ifdef MODULE
- 
-MODULE_LICENSE("GPL");
-
-int init_module(void)
-{
-	if (!zatm_detect()) {
-		printk(KERN_ERR DEV_LABEL ": no adapter found\n");
-		return -ENXIO;
-	}
+	/* XXX: currently the driver is not unloadable.. */
 	MOD_INC_USE_COUNT;
 	return 0;
 }
- 
- 
-void cleanup_module(void)
-{
-	/*
-	 * Well, there's no way to get rid of the driver yet, so we don't
-	 * have to clean up, right ? :-)
-	 */
-}
- 
-#endif
+
+MODULE_LICENSE("GPL");
+
+module_init(zatm_module_init);
===== drivers/block/genhd.c 1.43 vs edited =====
--- 1.43/drivers/block/genhd.c	Sun Oct  6 01:21:28 2002
+++ edited/drivers/block/genhd.c	Wed Oct  9 17:34:51 2002
@@ -217,14 +217,6 @@
 	for (i = 0; i < MAX_BLKDEV; i++)
 		INIT_LIST_HEAD(&gendisks[i].list);
 	blk_dev_init();
-#ifdef CONFIG_FC4_SOC
-	/* This has to be done before scsi_dev_init */
-	soc_probe();
-#endif
-#ifdef CONFIG_ATM
-	(void) atmdev_init();
-#endif
-
 	devclass_register(&disk_devclass);
 	return 0;
 }
