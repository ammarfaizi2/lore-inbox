Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSEDNam>; Sat, 4 May 2002 09:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312791AbSEDNal>; Sat, 4 May 2002 09:30:41 -0400
Received: from iv.ro ([194.105.28.94]:28556 "HELO iv.ro") by vger.kernel.org
	with SMTP id <S312790AbSEDNai>; Sat, 4 May 2002 09:30:38 -0400
Date: Sat, 4 May 2002 16:31:59 +0300 (EEST)
From: Jani Monoses <jani@iv.ro>
X-X-Sender: <jani@cow>
To: <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>, <salvestrini@users.sourceforge.net>
Subject: tridentfb update
Message-ID: <Pine.LNX.4.33L2.0205041626080.377-100000@cow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marcelo

the following patch

- converts tridentfb to use the new PCI model
- adds acceleration to the BladeXP chips (work by Francesco Salvestrini)
- fixes a typo in frequency calculation.

please apply

Jani

diff -ur linux.orig/drivers/video/tridentfb.c linux/drivers/video/tridentfb.c
--- linux.orig/drivers/video/tridentfb.c	Sat May  4 15:25:34 2002
+++ linux/drivers/video/tridentfb.c	Sat May  4 14:49:28 2002
@@ -1,9 +1,9 @@
 /*
  * Frame buffer driver for Trident Blade and Image series
  *
- * Copyright 2001,2002 - Jani Monoses   <jani@astechnix.ro>
+ * Copyright 2001,2002 - Jani Monoses   <jani@iv.ro>
  *
- * $Id: tridentfb.c,v 1.3 2002/02/25 20:09:41 marcelo Exp $
+ * $Id: trident.c,v 1.72 2002/05/04 14:49:28 jani Exp $
  *
  * CREDITS:(in order of appearance)
  * 	skeletonfb.c by Geert Uytterhoeven and other fb code in drivers/video
@@ -35,7 +35,7 @@

 #include "tridentfb.h"

-#define VERSION		"0.6.9"
+#define VERSION		"0.7.2"

 struct tridentfb_par {
 	struct fb_var_screeninfo var;
@@ -69,6 +69,7 @@
 	unsigned int io_virt;		//iospace virtual memory address
 	unsigned int nativex;		//flat panel xres
 	struct tridentfb_par currentmode;
+	unsigned char eng_oper;		//engine operation...
 };

 static struct fb_ops tridentfb_ops;
@@ -82,7 +83,6 @@

 static char * tridentfb_name = "Trident";

-static int family;
 static int pci_id;

 static int defaultaccel;
@@ -90,7 +90,6 @@

 static int pseudo_pal[16];

-
 /* defaults which are normally overriden by user values */

 /* video mode */
@@ -150,9 +149,10 @@
 #define writemmr(r,v)	writel(v, fb_info.io_virt + r)
 #define readmmr(r)	readl(fb_info.io_virt + r)

+
+
 /*
- * Blade specific acceleration.Not XP's though those are
- * unaccelerated.
+ * Blade specific acceleration.
  */

 #define point(x,y) ((y)<<16|(x))
@@ -215,7 +215,7 @@
 	d1 = point(x2,y2);
 	d2 = point(x2+w-1,y2+h-1);

-	if ((y1 > y2) || ((y1 == y2) && (x1 >x2)))
+	if ((y1 > y2) || ((y1 == y2) && (x1 > x2)))
 			direction = 0;


@@ -235,6 +235,130 @@
 	blade_copy_rect,
 };

+
+/*
+ * BladeXP specific acceleration functions
+ */
+
+#define ROP_P 0xF0
+#define masked_point(x,y) ((y & 0xffff)<<16|(x & 0xffff))
+
+static void xp_init_accel(int pitch,int bpp)
+{
+	int tmp = 0,v1;
+	unsigned char x = 0;
+
+	switch (bpp) {
+		case 8:  x = 0; break;
+		case 16: x = 1; break;
+		case 24: x = 3; break;
+		case 32: x = 2; break;
+	}
+
+	switch (pitch << (bpp >> 3)) {
+		case 8192:
+		case 512:  x |= 0x00; break;
+		case 1024: x |= 0x04; break;
+		case 2048: x |= 0x08; break;
+		case 4096: x |= 0x0C; break;
+	}
+
+	t_outb(x,0x2125);
+
+	fb_info.eng_oper = x | 0x40;
+
+	switch (bpp) {
+		case 8:  tmp = 18; break;
+		case 15:
+		case 16: tmp = 19; break;
+		case 24:
+		case 32: tmp = 20; break;
+	}
+
+	v1 = pitch << tmp;
+
+	writemmr(0x2154,v1);
+	writemmr(0x2150,v1);
+	t_outb(3,0x2126);
+}
+
+static void xp_wait_engine(void)
+{
+	int busy;
+	int count, timeout;
+
+	count = 0;
+	timeout = 0;
+	for (;;) {
+		busy = t_inb(STA) & 0x80;
+		if (busy != 0x80)
+			return;
+		count++;
+		if (count == 10000000) {
+			/* Timeout */
+			count = 9990000;
+			timeout++;
+			if (timeout == 8) {
+				/* Reset engine */
+				t_outb(0x00, 0x2120);
+				return;
+			}
+		}
+	}
+}
+
+static void xp_fill_rect(int x,int y,int w,int h,int c)
+{
+	writemmr(0x2127,ROP_P);
+	writemmr(0x2158,c);
+	writemmr(0x2128,0x4000);
+	writemmr(0x2140,masked_point(h,w));
+	writemmr(0x2138,masked_point(y,x));
+	t_outb(0x01,0x2124);
+        t_outb(fb_info.eng_oper,0x2125);
+}
+
+static void xp_copy_rect(int x1,int y1,int x2,int y2,int w,int h)
+{
+	int direction;
+	int x1_tmp, x2_tmp, y1_tmp, y2_tmp;
+
+	direction = 0x0004;
+
+	if ((x1 < x2) && (y1 == y2)) {
+		direction |= 0x0200;
+		x1_tmp = x1 + w - 1;
+		x2_tmp = x2 + w - 1;
+	} else {
+		x1_tmp = x1;
+		x2_tmp = x2;
+	}
+
+	if (y1 < y2) {
+		direction |= 0x0100;
+		y1_tmp = y1 + h - 1;
+		y2_tmp = y2 + h - 1;
+  	} else {
+		y1_tmp = y1;
+		y2_tmp = y2;
+	}
+
+	writemmr(0x2128,direction);
+	t_outb(ROP_S,0x2127);
+	writemmr(0x213C,masked_point(y1_tmp,x1_tmp));
+	writemmr(0x2138,masked_point(y2_tmp,x2_tmp));
+	writemmr(0x2140,masked_point(h,w));
+	t_outb(0x01,0x2124);
+}
+
+static struct accel_switch accel_xp = {
+  	xp_init_accel,
+	xp_wait_engine,
+	xp_fill_rect,
+	xp_copy_rect,
+};
+
+
 /*
  * Image specific acceleration functions
  */
@@ -255,7 +379,7 @@
 	writemmr(0x2148, 0x00000000);
 	writemmr(0x2150, 0x00000000);
 	writemmr(0x2154, 0x00000000);
-	writemmr(0x2120, 0x60000000 |(pitch<<16) |pitch);
+	writemmr(0x2120, 0x60000000|(pitch<<16) |pitch);
 	writemmr(0x216C, 0x00000000);
 	writemmr(0x2170, 0x00000000);
 	writemmr(0x217C, 0x00000000);
@@ -521,7 +645,7 @@
 }

 /* Use 20.12 fixed-point for NTSC value and frequency calculation */
-#define calc_freq(n,m,k)  ( (unsigned long)0xE517 * (n+8) / (m+2)*(1<<k) )
+#define calc_freq(n,m,k)  ( (unsigned long)0xE517 * (n+8) / ((m+2)*(1<<k)) )

 /* Set dotclock frequency */
 static void set_vclk(int freq)
@@ -1035,8 +1159,8 @@
     	}

 	write3CE(PowerStatus,DPMSCont);
-    	t_outb(4,0x83C8);
-    	t_outb(PMCont,0x83C6);
+	t_outb(4,0x83C8);
+	t_outb(PMCont,0x83C6);

 	debug("exit\n");
 	return 0;
@@ -1097,73 +1221,40 @@
 	trident_set_disp
 };

-/* List of boards that we are trying to support */
-static struct almost_supported_board {
-	int pci_id;
-	int family;
-	struct accel_switch * acc;
-	char* board_name;
-	int accel;
-} asb[] __initdata = {
-	{ BLADE3D,		BLADE,	&accel_blade, "Blade3D",	ACCEL	},
-	{ CYBERBLADEi7,	BLADE,	&accel_blade, "CyberBladei7",	ACCEL	},
-	{ CYBERBLADEi7D,	BLADE,	&accel_blade, "CyberBladei7D",	ACCEL	},
-	{ CYBERBLADEi1,	BLADE,	&accel_blade, "CyberBladei1",	ACCEL	},
-	{ CYBERBLADEi1D,	BLADE,	&accel_blade, "CyberBladei1D",	ACCEL	},
-	{ CYBERBLADEAi1,	BLADE,	&accel_blade, "CyberBladeAi1",	ACCEL	},
-	{ CYBERBLADEAi1D,	BLADE,	&accel_blade, "CyberBladeAi1D",	ACCEL	},
-	{ CYBERBLADEE4,	BLADE,	&accel_blade, "CyberBladeE4",	ACCEL	},
-
-	{ IMAGE975,	IMAGE,	&accel_image,	"IMAGE975",	NOACCEL	},
-	{ IMAGE985,	IMAGE,	&accel_image,	"IMAGE985",	NOACCEL	},
-	{ CYBER9320,	IMAGE,	&accel_image,	"Cyber9320",	NOACCEL	},
-	{ CYBER9388,	IMAGE,	&accel_image,	"Cyber9388",	NOACCEL	},
-	{ CYBER9520,	IMAGE,	&accel_image,	"Cyber9520",	NOACCEL	},
-	{ CYBER9525DVD,	IMAGE,	&accel_image,	"Cyber9525DVD",	NOACCEL	},
-	{ CYBER9397,	IMAGE,	&accel_image,	"Cyber9397",	NOACCEL	},
-	{ CYBER9397DVD,	IMAGE,	&accel_image,	"Cyber9397DVD",	NOACCEL	},
-
-	{ CYBERBLADEXPAi1,	XP,	&accel_blade,	"CyberBladeXPAi1",	NOACCEL },
-	{ CYBERBLADEXPm8,	XP,	&accel_blade,	"CyberBladeXPm8",	NOACCEL },
-	{ CYBERBLADEXPm16,	XP,	&accel_blade,	"CyberBladeXPm16",	NOACCEL },
-};
-
-static __init int trident_find_board(void)
+static int __devinit trident_pci_probe(struct pci_dev * dev, const struct pci_device_id * id)
 {
-	int i;
-	struct pci_dev * board;
+	int err;

-	for (i = 0;i < ARRAY_SIZE(asb);i++) {
-      		if ((board = pci_find_device(PCI_VENDOR_ID_TRIDENT,
-				   asb[i].pci_id,
-				   NULL))) {
-	 		family = asb[i].family;
-	 		acc = asb[i].acc;
-	 		pci_id = asb[i].pci_id;
-	 		defaultaccel = asb[i].accel;
-
-			fb_info.io = pci_resource_start(board,1);
-			fb_info.fbmem = pci_resource_start(board,0);
-	 		output("%s board found\n", asb[i].board_name);
-	 		return 1;
-      		}
-   	}
-	output("No Trident board found\n");
-	return 0;
-}
+	err = pci_enable_device(dev);
+	if (err)
+		return err;

-int __init tridentfb_init(void)
-{
+	pci_id = id->device;

-	output("Trident framebuffer  %s initializing\n", VERSION);
+	/* At this point this seems useless, we
+	 * could leave the default_accel variable
+	 * in the case that other boards (without
+	 * accel or buggy accel) will be added...
+	 */
+	if (is_xp(pci_id)) {
+		defaultaccel = ACCEL;
+		acc = &accel_xp;
+	} else
+	if (is_blade(pci_id)) {
+		defaultaccel = ACCEL;
+		acc = &accel_blade;
+	} else {
+		defaultaccel = ACCEL;
+		acc = &accel_image;
+	}

-	if (!trident_find_board())
-     		return -1;
+	fb_info.io = pci_resource_start(dev,1);
+	fb_info.fbmem = pci_resource_start(dev,0);

 	if (!request_mem_region(fb_info.io, TRIDENT_IOSIZE, "tridentfb")) {
 		debug("request_region failed!\n");
 		return -1;
-	};
+	}

 	fb_info.io_virt = (unsigned int)ioremap_nocache(fb_info.io, TRIDENT_IOSIZE);

@@ -1187,6 +1278,7 @@
 		return -1;
 	}

+	output("%s board found\n", dev->name);
 	debug("Trident board found : mem = %X,io = %X, mem_v = %X, io_v = %X\n",
 		fb_info.fbmem, fb_info.io, fb_info.fbmem_virt, fb_info.io_virt);

@@ -1195,8 +1287,10 @@

 	strcpy(fb_info.gen.info.modename, tridentfb_name);
 	displaytype = get_displaytype();
+
 	if(flatpanel)
 		fb_info.nativex = get_nativex();
+
 	fb_info.gen.info.changevar = NULL;
 	fb_info.gen.info.node = NODEV;
 	fb_info.gen.info.fbops = &tridentfb_ops;
@@ -1212,6 +1306,7 @@

 	/* This should give a reasonable default video mode */
 	fb_find_mode(&default_var,&fb_info.gen.info,mode,NULL,0,NULL,bpp);
+
 	/*
 	 * Unless user explicitly requires accel/noaccel use
 	 * per chip defaults.Accel has priority over noaccel.
@@ -1221,7 +1316,7 @@
 	else if (noaccel)
 		defaultaccel = NOACCEL;

-	if (defaultaccel == ACCEL)
+	if (defaultaccel == ACCEL && acc)
 		default_var.accel_flags |= FB_ACCELF_TEXT;
 	else
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
@@ -1242,13 +1337,60 @@
 	return 0;
 }

-void __exit tridentfb_exit(void)
+static void __devexit trident_pci_remove(struct pci_dev * dev)
 {
 	unregister_framebuffer(&fb_info.gen.info);
 	iounmap((void *)fb_info.io_virt);
 	iounmap((void *)fb_info.fbmem_virt);
+	release_mem_region(fb_info.fbmem, fb_info.memsize);
+	release_region(fb_info.io, TRIDENT_IOSIZE);
 }

+/* List of boards that we are trying to support */
+static struct pci_device_id trident_devices[] __devinitdata = {
+	{PCI_VENDOR_ID_TRIDENT,	BLADE3D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi7D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi1, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEi1D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEAi1D, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEE4, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	IMAGE975, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	IMAGE985, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBER9320, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBER9388, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBER9520, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBER9525DVD, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBER9397, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBER9397DVD, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEXPAi1, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEXPm8, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{PCI_VENDOR_ID_TRIDENT,	CYBERBLADEXPm16, PCI_ANY_ID,PCI_ANY_ID,0,0,0},
+	{0,}
+};
+
+MODULE_DEVICE_TABLE(pci,trident_devices);
+
+static struct pci_driver tridentfb_pci_driver = {
+	name:"tridentfb",
+	id_table:trident_devices,
+	probe:trident_pci_probe,
+	remove:__devexit_p(trident_pci_remove),
+};
+
+int __init tridentfb_init(void)
+{
+	output("Trident framebuffer  %s initializing\n", VERSION);
+	return pci_module_init(&tridentfb_pci_driver);
+}
+
+void __exit tridentfb_exit(void)
+{
+	pci_unregister_driver(&tridentfb_pci_driver);
+}
+
+
 /*
  * Parse user specified options (`video=trident:')
  * example:
@@ -1301,6 +1443,7 @@
 #endif
 module_exit(tridentfb_exit);

-MODULE_AUTHOR("Jani Monoses <jani@astechnix.ro>");
+MODULE_AUTHOR("Jani Monoses <jani@iv.ro>");
 MODULE_DESCRIPTION("Framebuffer driver for Trident cards");
 MODULE_LICENSE("GPL");
+
diff -ur linux.orig/drivers/video/tridentfb.h linux/drivers/video/tridentfb.h
--- linux.orig/drivers/video/tridentfb.h	Sat May  4 15:19:52 2002
+++ linux/drivers/video/tridentfb.h	Sat May  4 14:43:19 2002
@@ -41,9 +41,19 @@
 #define BLADE	1
 #define XP	2

-#define is_image()	(family == IMAGE)
-#define is_blade()	(family == BLADE)
-#define is_xp()		(family == XP)
+#define is_image(id)
+#define is_xp(id)	((id == CYBERBLADEXPAi1) ||\
+			 (id == CYBERBLADEXPm8) ||\
+			 (id == CYBERBLADEXPm16))
+
+#define is_blade(id)	((id == BLADE3D) ||\
+			 (id == CYBERBLADEE4) ||\
+			 (id == CYBERBLADEi7) ||\
+			 (id == CYBERBLADEi7D) ||\
+			 (id == CYBERBLADEi1) ||\
+			 (id == CYBERBLADEi1D) ||\
+			 (id ==	CYBERBLADEAi1) ||\
+			 (id ==	CYBERBLADEAi1D))

 /* these defines are for 'lcd' variable */
 #define LCD_STRETCH	0
@@ -60,15 +70,13 @@
 #define NOACCEL	0

 #define TRIDENT_IOSIZE	0x20000
-#define NTSC 14.31818
-#define PAL  17.73448

 /* General Registers */
 #define SPR	0x1F		/* Software Programming Register (videoram) */

 /* 3C4 */
 #define RevisionID 0x09
-#define OldOrNew 0x0B
+#define OldOrNew 0x0B
 #define ConfPort1 0x0C
 #define ConfPort2 0x0C
 #define NewMode2 0x0D


