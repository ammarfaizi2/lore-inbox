Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264299AbTCXQeh>; Mon, 24 Mar 2003 11:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264297AbTCXQbH>; Mon, 24 Mar 2003 11:31:07 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:29418 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264243AbTCXQar>; Mon, 24 Mar 2003 11:30:47 -0500
Message-Id: <200303241641.h2OGft35008188@deviant.impure.org.uk>
Date: Mon, 24 Mar 2003 16:41:43 +0000
To: torvalds@transmeta.com
From: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: cyclades region handling updates from 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/char/cyclades.c linux-2.5/drivers/char/cyclades.c
--- bk-linus/drivers/char/cyclades.c	2003-03-08 09:56:57.000000000 +0000
+++ linux-2.5/drivers/char/cyclades.c	2003-03-17 23:42:15.000000000 +0000
@@ -12,7 +12,7 @@ static char rcsid[] =
  *
  * Initially written by Randolph Bentson <bentson@grieg.seaslug.org>.
  * Modified and maintained by Marcio Saito <marcio@cyclades.com>.
- * Currently maintained by Henrique Gobbi <henrique.gobbi@cyclades.com>.
+ * Currently maintained by Ivan Passos <ivan@cyclades.com>.
  *
  * For Technical support and installation problems, please send e-mail
  * to support@cyclades.com.
@@ -883,7 +883,9 @@ static void cyz_poll(unsigned long);
 static long cyz_polling_cycle = CZ_DEF_POLL;
 
 static int cyz_timeron = 0;
-static struct timer_list cyz_timerlist = TIMER_INITIALIZER(cyz_poll, 0, 0);
+static struct timer_list cyz_timerlist = {
+	.function = cyz_poll
+};
 
 #else /* CONFIG_CYZ_INTR */
 static void cyz_rx_restart(unsigned long);
@@ -4944,17 +4946,16 @@ cy_detect_pci(void)
 
   struct pci_dev	*pdev = NULL;
   unsigned char		cyy_rev_id;
-  unsigned char         cy_pci_irq = 0;
-  uclong		cy_pci_phys0, cy_pci_phys1, cy_pci_phys2;
+  unsigned char		cy_pci_irq = 0;
+  uclong		cy_pci_phys0, cy_pci_phys2;
   uclong		cy_pci_addr0, cy_pci_addr2;
-  unsigned short        i,j,cy_pci_nchan, plx_ver;
-  unsigned short        device_id,dev_index = 0;
+  unsigned short	i,j,cy_pci_nchan, plx_ver;
+  unsigned short	device_id,dev_index = 0;
   uclong		mailbox;
   uclong		Ze_addr0[NR_CARDS], Ze_addr2[NR_CARDS], ZeIndex = 0;
   uclong		Ze_phys0[NR_CARDS], Ze_phys2[NR_CARDS];
-  unsigned char         Ze_irq[NR_CARDS];
-  struct resource *resource;
-  unsigned long res_start, res_len;
+  unsigned char		Ze_irq[NR_CARDS];
+  struct pci_dev	*Ze_pdev[NR_CARDS];
 
         for (i = 0; i < NR_CARDS; i++) {
                 /* look for a Cyclades card by vendor and device id */
@@ -4976,7 +4977,6 @@ cy_detect_pci(void)
                 /* read PCI configuration area */
 		cy_pci_irq = pdev->irq;
 		cy_pci_phys0 = pci_resource_start(pdev, 0);
-		cy_pci_phys1 = pci_resource_start(pdev, 1);
 		cy_pci_phys2 = pci_resource_start(pdev, 2);
 		pci_read_config_byte(pdev, PCI_REVISION_ID, &cyy_rev_id);
 
@@ -5002,15 +5002,10 @@ cy_detect_pci(void)
 		/* Although we don't use this I/O region, we should
 		   request it from the kernel anyway, to avoid problems
 		   with other drivers accessing it. */
-		resource = request_region(cy_pci_phys1,
-					CyPCI_Yctl, "Cyclom-Y");
-		if (resource == NULL) {
-			printk(KERN_ERR "cyclades: failed to allocate IO "
-					"resource at 0x%lx\n", cy_pci_phys1);
+		if (pci_request_regions(pdev, "Cyclom-Y") != 0) {
+			printk(KERN_ERR "cyclades: failed to reserve PCI resources\n");
 			continue;
 		}
-		res_start = cy_pci_phys1;
-		res_len = CyPCI_Yctl;
 
 #if defined(__alpha__)
                 if (device_id  == PCI_DEVICE_ID_CYCLOM_Y_Lo) { /* below 1M? */
@@ -5081,10 +5076,7 @@ cy_detect_pci(void)
                 cy_card[j].bus_index = 1;
                 cy_card[j].first_line = cy_next_channel;
                 cy_card[j].num_chips = cy_pci_nchan/4;
-		cy_card[j].resource = resource;
-		cy_card[j].res_start = res_start;
-		cy_card[j].res_len = res_len;
-		resource = NULL;	/* For next card */
+		cy_card[j].pdev = pdev;
 	
                 /* enable interrupts in the PCI interface */
 		plx_ver = cy_readb(cy_pci_addr2 + CyPLX_VER) & 0x0f;
@@ -5164,15 +5156,10 @@ cy_detect_pci(void)
 		/* Although we don't use this I/O region, we should
 		   request it from the kernel anyway, to avoid problems
 		   with other drivers accessing it. */
-		resource = request_region(cy_pci_phys1,
-				CyPCI_Zctl, "Cyclades-Z");
-		if (resource == NULL) {
-			printk(KERN_ERR "cyclades: failed ot allocate IO resource "
-					"at 0x%lx\n", cy_pci_phys1);
+		if (pci_request_regions(pdev, "Cyclades-Z") != 0) {
+			printk(KERN_ERR "cyclades: failed to reserve PCI resources\n");
 			continue;
 		}
-		res_start = cy_pci_phys1;
-		res_len = CyPCI_Zctl;
 	
 		if (mailbox == ZE_V1) {
 		    cy_pci_addr2 = (ulong)ioremap(cy_pci_phys2, CyPCI_Ze_win);
@@ -5187,6 +5174,7 @@ cy_detect_pci(void)
 			Ze_addr0[ZeIndex] = cy_pci_addr0;
 			Ze_addr2[ZeIndex] = cy_pci_addr2;
 			Ze_irq[ZeIndex] = cy_pci_irq;
+			Ze_pdev[ZeIndex] = pdev;
 			ZeIndex++;
 		    }
 		    i--;
@@ -5271,10 +5259,7 @@ cy_detect_pci(void)
                 cy_card[j].bus_index = 1;
                 cy_card[j].first_line = cy_next_channel;
                 cy_card[j].num_chips = -1;
-		cy_card[j].resource = resource;
-		cy_card[j].res_start = res_start;
-		cy_card[j].res_len = res_len;
-		resource = NULL;	/* For next card */
+		cy_card[j].pdev = pdev;
 
                 /* print message */
 #ifdef CONFIG_CYZ_INTR
@@ -5302,12 +5287,14 @@ cy_detect_pci(void)
 	    cy_pci_addr0 = Ze_addr0[0];
 	    cy_pci_addr2 = Ze_addr2[0];
 	    cy_pci_irq = Ze_irq[0];
+	    pdev = Ze_pdev[0];
 	    for (j = 0 ; j < ZeIndex-1 ; j++) {
 		Ze_phys0[j] = Ze_phys0[j+1];
 		Ze_phys2[j] = Ze_phys2[j+1];
 		Ze_addr0[j] = Ze_addr0[j+1];
 		Ze_addr2[j] = Ze_addr2[j+1];
 		Ze_irq[j] = Ze_irq[j+1];
+		Ze_pdev[j] = Ze_pdev[j+1];
 	    }
 	    ZeIndex--;
 		mailbox = (uclong)cy_readl(&((struct RUNTIME_9060 *) 
@@ -5365,6 +5352,7 @@ cy_detect_pci(void)
                 cy_card[j].bus_index = 1;
                 cy_card[j].first_line = cy_next_channel;
                 cy_card[j].num_chips = -1;
+		cy_card[j].pdev = pdev;
 
                 /* print message */
 #ifdef CONFIG_CYZ_INTR
@@ -5797,8 +5785,8 @@ cy_cleanup_module(void)
 #endif /* CONFIG_CYZ_INTR */
 	    )
 		free_irq(cy_card[i].irq, &cy_card[i]);
-		if (cy_card[i].resource)
-			release_region(cy_card[i].res_start, cy_card[i].res_len);
+		if (cy_card[i].pdev)
+			pci_release_regions(cy_card[i].pdev);
         }
     }
     if (tmp_buf) {
diff -urpN --exclude-from=/home/davej/.exclude bk-linus/include/linux/cyclades.h linux-2.5/include/linux/cyclades.h
--- bk-linus/include/linux/cyclades.h	2003-03-08 09:57:57.000000000 +0000
+++ linux-2.5/include/linux/cyclades.h	2003-03-08 07:24:39.000000000 +0000
@@ -515,9 +515,7 @@ struct cyclades_card {
     int nports;		/* Number of ports in the card */
     int bus_index;	/* address shift - 0 for ISA, 1 for PCI */
     int	intr_enabled;	/* FW Interrupt flag - 0 disabled, 1 enabled */
-    struct resource *resource;
-    unsigned long res_start;
-	unsigned long res_len;
+    struct pci_dev *pdev;
 #ifdef __KERNEL__
     spinlock_t card_lock;
 #else
