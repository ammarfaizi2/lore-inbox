Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271421AbRIJRXy>; Mon, 10 Sep 2001 13:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271431AbRIJRXp>; Mon, 10 Sep 2001 13:23:45 -0400
Received: from mx7.port.ru ([194.67.57.17]:2786 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S271421AbRIJRXe>;
	Mon, 10 Sep 2001 13:23:34 -0400
Date: Mon, 10 Sep 2001 21:27:30 +0400
From: Nick Kurshev <nickols_k@mail.ru>
To: linux-kernel@vger.kernel.org
Cc: ajoshi@unixbox.com
Subject: [linux-2.4.9-ac10 PATCH] ATI Radeon VE QZ framebuffer support
Message-Id: <20010910212730.6604296f.nickols_k@mail.ru>
X-Mailer: Sylpheed version 0.6.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I want suggest still one a little fix for radeonfb.c driver
for latest Alan's Linux distribution.
After study of XFree86-CVS code I've found that Xfree86 doesn't
differ VE QY and VE QZ chips from driver point. So I guess
that my code will work correctly with VE QZ chip. Finely -
in the same way as with Radeon VE QY chip.
Also I've added Radeon Mobility identificators but these chips
require volunteers for testing and improvements.

Best regards! Nick

--- linux/drivers/video/radeonfb.c.old	Mon Sep 10 11:23:56 2001
+++ linux/drivers/video/radeonfb.c	Mon Sep 10 21:10:05 2001
@@ -13,13 +13,21 @@
  *			and minor mode tweaking, 0.0.9
  *
  *	2001-09-07	Radeon VE support
- *
+ *	2001-09-10	Radeon VE QZ support by Nick Kurshev <nickols_k@mail.ru>
+ *			(limitations: on dualhead Radeons (VE, M6, M7)
+ *			 driver works only on second head (DVI port).
+ *			 TVout is not supported too. M6 & M7 chips
+ *			 currently are not supported. Driver has a lot
+ *			 of other bugs. Probably they can be solved by
+ *			 importing XFree86 code, which has ATI's support).,
+ *			 0.0.11
+ *			
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
  */
 
 
-#define RADEON_VERSION	"0.0.10"
+#define RADEON_VERSION	"0.0.11"
 
 
 #include <linux/config.h>
@@ -64,7 +72,8 @@
 	RADEON_QE,
 	RADEON_QF,
 	RADEON_QG,
-	RADEON_VE
+	RADEON_QY,
+	RADEON_QZ
 };
 
 
@@ -73,7 +82,8 @@
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QE},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QF},
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QG, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QG},
-	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_VE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_VE},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QY, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QY},
+	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_RADEON_QZ, PCI_ANY_ID, PCI_ANY_ID, 0, 0, RADEON_QZ},
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
@@ -176,7 +186,7 @@
 	struct radeon_regs state;
 	struct radeon_regs init_state;
 
-	char name[10];
+	char name[14];
 	char ram_type[12];
 
 	u32 mmio_base_phys;
@@ -642,8 +652,11 @@
 		case PCI_DEVICE_ID_RADEON_QG:
 			strcpy(rinfo->name, "Radeon QG ");
 			break;
-		case PCI_DEVICE_ID_RADEON_VE:
-			strcpy(rinfo->name, "Radeon VE ");
+		case PCI_DEVICE_ID_RADEON_QY:
+			strcpy(rinfo->name, "Radeon VE QY ");
+			break;
+		case PCI_DEVICE_ID_RADEON_QZ:
+			strcpy(rinfo->name, "Radeon VE QZ ");
 			break;
 		default:
 			return -ENODEV;
@@ -760,7 +773,7 @@
 		radeon_engine_init (rinfo);
 	}
 
-	printk ("radeonfb: ATI %s %d MB\n",rinfo->name,
+	printk ("radeonfb: ATI %s %s %d MB\n",rinfo->name,rinfo->ram_type,
 		(rinfo->video_ram/(1024*1024)));
 
 	return 0;

--- linux/drivers/video/radeon.h.old	Mon Sep 10 11:23:56 2001
+++ linux/drivers/video/radeon.h	Mon Sep 10 20:37:16 2001
@@ -7,8 +7,15 @@
 #define PCI_DEVICE_ID_RADEON_QE		0x5145
 #define PCI_DEVICE_ID_RADEON_QF		0x5146
 #define PCI_DEVICE_ID_RADEON_QG		0x5147
-#define PCI_DEVICE_ID_RADEON_VE		0x5159
+#define PCI_DEVICE_ID_RADEON_QY		0x5159
+#define PCI_DEVICE_ID_RADEON_QZ		0x515A
 
+#if 0
+/* known but untested chips */
+#define PCI_DEVICE_ID_RADEON_LW		0x4C57 /* "M7" */
+#define PCI_DEVICE_ID_RADEON_LY		0x4C59 /* "Radeon Mobility M6 LY" */
+#define PCI_DEVICE_ID_RADEON_LZ		0x4C5A /* "Radeon Mobility M6 LZ" */
+#endif
 #define RADEON_REGSIZE			0x4000
 
 

--- linux/include/linux/pci_ids.h.old	Mon Sep 10 11:24:03 2001
+++ linux/include/linux/pci_ids.h	Mon Sep 10 20:59:33 2001
@@ -264,6 +264,14 @@
 #define PCI_DEVICE_ID_ATI_RADEON_RB	0x5145
 #define PCI_DEVICE_ID_ATI_RADEON_RC	0x5146
 #define PCI_DEVICE_ID_ATI_RADEON_RD	0x5147
+/* Radeon VE */
+#define PCI_DEVICE_ID_ATI_RADEON_QY	0x5159
+#define PCI_DEVICE_ID_ATI_RADEON_QZ	0x515A
+/* Radeon M6 */
+#define PCI_DEVICE_ID_ATI_RADEON_LY	0x4C59
+#define PCI_DEVICE_ID_ATI_RADEON_LZ	0x4C5A
+/* Radeon M7 */
+#define PCI_DEVICE_ID_ATI_RADEON_LW	0x4C57
 
 #define PCI_VENDOR_ID_VLSI		0x1004
 #define PCI_DEVICE_ID_VLSI_82C592	0x0005
