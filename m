Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285035AbRLLB0s>; Tue, 11 Dec 2001 20:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284968AbRLLB0i>; Tue, 11 Dec 2001 20:26:38 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:47376 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284933AbRLLB0c>; Tue, 11 Dec 2001 20:26:32 -0500
Message-ID: <3C16B206.A3E12398@zip.com.au>
Date: Tue, 11 Dec 2001 17:25:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Berend De Schouwer <bds@jhb.ucs.co.za>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel Oops on cat /proc/ioports
In-Reply-To: <1008073796.5535.5.camel@bds.ucs.co.za>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this fix it?

--- linux-2.4.17-pre8/include/linux/cyclades.h	Fri May 12 11:22:31 2000
+++ linux-akpm/include/linux/cyclades.h	Tue Dec 11 17:17:22 2001
@@ -503,6 +503,7 @@ struct ZFW_CTRL {
 #endif
 
 /* Per card data structure */
+struct resource;
 struct cyclades_card {
     unsigned long base_phys;
     unsigned long ctl_phys;
@@ -514,6 +515,8 @@ struct cyclades_card {
     int nports;		/* Number of ports in the card */
     int bus_index;	/* address shift - 0 for ISA, 1 for PCI */
     int	intr_enabled;	/* FW Interrupt flag - 0 disabled, 1 enabled */
+    struct resource *resource;
+    unsigned long res_start, res_len;
 #ifdef __KERNEL__
     spinlock_t card_lock;
 #else
--- linux-2.4.17-pre8/drivers/char/cyclades.c	Fri Sep 14 14:04:07 2001
+++ linux-akpm/drivers/char/cyclades.c	Tue Dec 11 17:23:42 2001
@@ -4965,6 +4965,8 @@ cy_detect_pci(void)
   uclong		Ze_addr0[NR_CARDS], Ze_addr2[NR_CARDS], ZeIndex = 0;
   uclong		Ze_phys0[NR_CARDS], Ze_phys2[NR_CARDS];
   unsigned char         Ze_irq[NR_CARDS];
+  struct resource *resource;
+  unsigned long res_start, res_len;
 
         for (i = 0; i < NR_CARDS; i++) {
                 /* look for a Cyclades card by vendor and device id */
@@ -5012,7 +5014,15 @@ cy_detect_pci(void)
 		/* Although we don't use this I/O region, we should
 		   request it from the kernel anyway, to avoid problems
 		   with other drivers accessing it. */
-		request_region(cy_pci_phys1, CyPCI_Yctl, "Cyclom-Y");
+		resource = request_region(cy_pci_phys1,
+					CyPCI_Yctl, "Cyclom-Y");
+		if (resource == NULL) {
+			printk(KERN_ERR "cyclades: failed to allocate IO "
+					"resource at 0x%lx\n", cy_pci_phys1);
+			continue;
+		}
+		res_start = cy_pci_phys1;
+		res_len = CyPCI_Yctl;
 
 #if defined(__alpha__)
                 if (device_id  == PCI_DEVICE_ID_CYCLOM_Y_Lo) { /* below 1M? */
@@ -5083,7 +5093,11 @@ cy_detect_pci(void)
                 cy_card[j].bus_index = 1;
                 cy_card[j].first_line = cy_next_channel;
                 cy_card[j].num_chips = cy_pci_nchan/4;
-
+		cy_card[j].resource = resource;
+		cy_card[j].res_start = res_start;
+		cy_card[j].res_len = res_len;
+		resource = NULL;	/* For next card */
+	
                 /* enable interrupts in the PCI interface */
 		plx_ver = cy_readb(cy_pci_addr2 + CyPLX_VER) & 0x0f;
 		switch (plx_ver) {
@@ -5162,8 +5176,16 @@ cy_detect_pci(void)
 		/* Although we don't use this I/O region, we should
 		   request it from the kernel anyway, to avoid problems
 		   with other drivers accessing it. */
-		request_region(cy_pci_phys1, CyPCI_Zctl, "Cyclades-Z");
-
+		resource = request_region(cy_pci_phys1,
+				CyPCI_Zctl, "Cyclades-Z");
+		if (resource == NULL) {
+			printk(KERN_ERR "cyclades: failed ot allocate IO resource "
+					"at 0x%lx\n", cy_pci_phys1);
+			continue;
+		}
+		res_start = cy_pci_phys1;
+		res_len = CyPCI_Zctl;
+	
 		if (mailbox == ZE_V1) {
 		    cy_pci_addr2 = (ulong)ioremap(cy_pci_phys2, CyPCI_Ze_win);
 		    if (ZeIndex == NR_CARDS) {
@@ -5261,6 +5283,10 @@ cy_detect_pci(void)
                 cy_card[j].bus_index = 1;
                 cy_card[j].first_line = cy_next_channel;
                 cy_card[j].num_chips = -1;
+		cy_card[j].resource = resource;
+		cy_card[j].res_start = res_start;
+		cy_card[j].res_len = res_len;
+		resource = NULL;	/* For next card */
 
                 /* print message */
 #ifdef CONFIG_CYZ_INTR
@@ -5279,7 +5305,7 @@ cy_detect_pci(void)
                 printk("%d channels starting from port %d.\n",
 		    cy_pci_nchan,cy_next_channel);
                 cy_next_channel += cy_pci_nchan;
-    }
+	    }
         }
 
         for (; ZeIndex != 0 && i < NR_CARDS; i++) {
@@ -5787,6 +5813,8 @@ cy_cleanup_module(void)
 #endif /* CONFIG_CYZ_INTR */
 	    )
 		free_irq(cy_card[i].irq, &cy_card[i]);
+		if (cy_card[i].resource)
+			release_region(cy_card[i].res_start, cy_card[i].res_len);
         }
     }
     if (tmp_buf) {
