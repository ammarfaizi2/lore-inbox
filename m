Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbUJaKEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbUJaKEg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbUJaKEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:04:36 -0500
Received: from amsfep19-int.chello.nl ([213.46.243.20]:64827 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S261521AbUJaKCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:02:44 -0500
Date: Sun, 31 Oct 2004 11:02:40 +0100
Message-Id: <200410311002.i9VA2erw009490@anakin.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 474] HP300 DIO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HP300 DIO bus updates from Kars de Jong:
  - Removed kludges for internal HPIB, no need to handle it as a DIO device
  - Removed dio_scodetoviraddr() and introduced dio_scodetophysaddr() instead,
    to be able to support DIO-II
  - Removed trailing white space
  - Changed error return code of dio_find() from 0 to -1, since select code 0
    is a valid select code
  - Added support for DIO-II
  - Fixed problem with DIO_ENCODE_ID()

Signed-off-by: Kars de Jong <jongk@linux-m68k.org>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

--- linux-2.6.10-rc1/drivers/dio/dio.c	2002-07-24 23:43:15.000000000 +0200
+++ linux-m68k-2.6.10-rc1/drivers/dio/dio.c	2004-07-14 13:18:41.000000000 +0200
@@ -1,4 +1,4 @@
-/* Code to support devices on the DIO (and eventually DIO-II) bus
+/* Code to support devices on the DIO and DIO-II bus
  * Copyright (C) 05/1998 Peter Maydell <pmaydell@chiark.greenend.org.uk>
  * 
  * This code has basically these routines at the moment:
@@ -9,9 +9,8 @@
  *    This means that framebuffers should pass it as 
  *    DIO_ENCODE_ID(DIO_ID_FBUFFER,DIO_ID2_TOPCAT)
  *    (or whatever); everybody else just uses DIO_ID_FOOBAR.
- * void *dio_scodetoviraddr(int scode)
- *    Return the virtual address corresponding to the given select code.
- *    NB: DIO-II devices will have to be mapped in in this routine!
+ * unsigned long dio_scodetophysaddr(int scode)
+ *    Return the physical address corresponding to the given select code.
  * int dio_scodetoipl(int scode)
  *    Every DIO card has a fixed interrupt priority level. This function 
  *    returns it, whatever it is.
@@ -30,8 +29,9 @@
 #include <linux/dio.h>
 #include <linux/slab.h>                         /* kmalloc() */
 #include <linux/init.h>
-#include <asm/hwtest.h>                           /* hwreg_present() */
-#include <asm/io.h>                               /* readb() */
+#include <asm/uaccess.h>
+#include <asm/io.h>                             /* readb() */
+
 /* not a real config option yet! */
 #define CONFIG_DIO_CONSTANTS
 
@@ -59,7 +59,7 @@
         DIONAME(DCA0), DIONAME(DCA0REM), DIONAME(DCA1), DIONAME(DCA1REM),
         DIONAME(DCM), DIONAME(DCMREM),
         DIONAME(LAN),
-        DIONAME(FHPIB), DIONAME(NHPIB), DIONAME(IHPIB),
+        DIONAME(FHPIB), DIONAME(NHPIB),
         DIONAME(SCSI0), DIONAME(SCSI1), DIONAME(SCSI2), DIONAME(SCSI3),
         DIONAME(FBUFFER),
         DIONAME(PARALLEL), DIONAME(VME), DIONAME(DCL), DIONAME(DCLREM),
@@ -79,7 +79,7 @@
 #define NUMNAMES (sizeof(names) / sizeof(struct dioname))
 
 static const char *unknowndioname 
-        = "unknown DIO board -- please email <pmaydell@chiark.greenend.org.uk>!";
+        = "unknown DIO board -- please email <linux-m68k@lists.linux-m68k.org>!";
 
 static const char *dio_getname(int id)
 {
@@ -88,7 +88,7 @@
         for (i = 0; i < NUMNAMES; i++)
                 if (names[i].id == id) 
                         return names[i].name;
-        
+
         return unknowndioname;
 }
 
@@ -115,54 +115,78 @@
 static int __init dio_find_slow(int deviceid)
 {
 	/* Called to find a DIO device before the full bus scan has run.  Basically
-         * only used by the console driver.
-         * We don't do the primary+secondary ID encoding thing here. Maybe we should.
-         * (that would break the topcat detection, though. I need to think about
-         * the whole primary/secondary ID thing.)
-         */
-	int scode;
-        u_char prid;
+	 * only used by the console driver.
+	 */
+	int scode, id;
+	u_char prid, secid, i;
+	mm_segment_t fs;
 
 	for (scode = 0; scode < DIO_SCMAX; scode++)
 	{
 		void *va;
+		unsigned long pa;
 
                 if (DIO_SCINHOLE(scode))
                         continue;
-                
-                va = dio_scodetoviraddr(scode);
-                if (!va || !hwreg_present(va + DIO_IDOFF))
+
+                pa = dio_scodetophysaddr(scode);
+
+		if (!pa)
+			continue;
+
+		if (scode < DIOII_SCBASE)
+			va = (void *)(pa + DIO_VIRADDRBASE);
+		else
+			va = ioremap(pa, PAGE_SIZE);
+
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+
+                if (get_user(i, (unsigned char *)va + DIO_IDOFF))
+		{
+			set_fs(fs);
+			if (scode >= DIOII_SCBASE)
+				iounmap(va);
                         continue;             /* no board present at that select code */
+		}
+
+		set_fs(fs);
+		prid = DIO_ID(va);
 
-                /* We aren't very likely to want to use this to get at the IHPIB,
-                 * but maybe it's returning the same ID as the card we do want...
-                 */
-                if (!DIO_ISIHPIB(scode))
-                        prid = DIO_ID(va);
+                if (DIO_NEEDSSECID(prid))
+                {
+                        secid = DIO_SECID(va);
+                        id = DIO_ENCODE_ID(prid, secid);
+                }
                 else
-                        prid = DIO_ID_IHPIB;
+			id = prid;
 
-		if (prid == deviceid)
+		if (id == deviceid)
+		{
+			if (scode >= DIOII_SCBASE)
+				iounmap(va);
 			return scode;
+		}
 	}
-	return 0;
+
+	return -1;
 }
 
-/* Aargh: we use 0 for an error return code, but select code 0 exists!
- * FIXME (trivial, use -1, but requires changes to all the drivers :-< )
- */
 int dio_find(int deviceid)
 {
-	if (blist) 
+	if (blist)
 	{
 		/* fast way */
 		struct dioboard *b;
 		for (b = blist; b; b = b->next)
 			if (b->id == deviceid && b->configured == 0)
 				return b->scode;
-		return 0;
+		return -1;
+	}
+	else
+	{
+		return dio_find_slow(deviceid);
 	}
-	return dio_find_slow(deviceid);
 }
 
 /* This is the function that scans the DIO space and works out what
@@ -170,34 +194,51 @@
  */
 static int __init dio_init(void)
 {
-        int scode;
-        struct dioboard *b, *bprev = NULL;
+	int scode;
+	struct dioboard *b, *bprev = NULL;
+	mm_segment_t fs;
+	char i;
    
-        printk("Scanning for DIO devices...\n");
+        printk(KERN_INFO "Scanning for DIO devices...\n");
         
         for (scode = 0; scode < DIO_SCMAX; ++scode)
         {
                 u_char prid, secid = 0;        /* primary, secondary ID bytes */
                 u_char *va;
+		unsigned long pa;
                 
                 if (DIO_SCINHOLE(scode))
                         continue;
-                
-                va = dio_scodetoviraddr(scode);
-                if (!va || !hwreg_present(va + DIO_IDOFF))
+
+		pa = dio_scodetophysaddr(scode);
+
+		if (!pa)
+			continue;
+
+		if (scode < DIOII_SCBASE)
+			va = (void *)(pa + DIO_VIRADDRBASE);
+		else
+			va = ioremap(pa, PAGE_SIZE);
+
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+
+                if (get_user(i, (unsigned char *)va + DIO_IDOFF))
+		{
+			set_fs(fs);
+			if (scode >= DIOII_SCBASE)
+				iounmap(va);
                         continue;              /* no board present at that select code */
+		}
+
+		set_fs(fs);
 
                 /* Found a board, allocate it an entry in the list */
                 b = kmalloc(sizeof(struct dioboard), GFP_KERNEL);
-                
-                /* read the ID byte(s) and encode if necessary. Note workaround 
-                 * for broken internal HPIB devices...
-                 */
-                if (!DIO_ISIHPIB(scode))
-                        prid = DIO_ID(va);
-                else 
-                        prid = DIO_ID_IHPIB;
-                
+
+                /* read the ID byte(s) and encode if necessary. */
+		prid = DIO_ID(va);
+
                 if (DIO_NEEDSSECID(prid))
                 {
                         secid = DIO_SECID(va);
@@ -205,16 +246,19 @@
                 }
                 else
                         b->id = prid;
-      
+
                 b->configured = 0;
                 b->scode = scode;
                 b->ipl = DIO_IPL(va);
                 b->name = dio_getname(b->id);
-                printk("select code %3d: ipl %d: ID %02X", scode, b->ipl, prid);
-                if (DIO_NEEDSSECID(b->id))
+                printk(KERN_INFO "select code %3d: ipl %d: ID %02X", b->scode, b->ipl, prid);
+                if (DIO_NEEDSSECID(prid))
                         printk(":%02X", secid);
                 printk(": %s\n", b->name);
-                
+
+		if (scode >= DIOII_SCBASE)
+			iounmap(va);
+
                 b->next = NULL;
 
                 if (bprev)
@@ -223,29 +267,27 @@
                         blist = b;
                 bprev = b;
         }
+
 	return 0;
 }
 
 subsys_initcall(dio_init);
 
 /* Bear in mind that this is called in the very early stages of initialisation
- * in order to get the virtual address of the serial port for the console...
+ * in order to get the address of the serial port for the console...
  */
-void *dio_scodetoviraddr(int scode)
+unsigned long dio_scodetophysaddr(int scode)
 {
-        if (scode > DIOII_SCBASE)
+        if (scode >= DIOII_SCBASE)
         {
-                printk("dio_scodetoviraddr: don't support DIO-II yet!\n");
-                return 0;
+                return (DIOII_BASE + (scode - 132) * DIOII_DEVSIZE);
         }
         else if (scode > DIO_SCMAX || scode < 0)
                 return 0;
         else if (DIO_SCINHOLE(scode))
                 return 0;
-        else if (DIO_ISIHPIB(scode))
-                return (void*)DIO_IHPIBADDR;
 
-        return (void*)(DIO_VIRADDRBASE + DIO_BASE + scode * 0x10000);
+        return (DIO_BASE + scode * DIO_DEVSIZE);
 }
 
 int dio_scodetoipl(int scode)
@@ -254,10 +296,10 @@
         for (b = blist; b; b = b->next)
                 if (b->scode == scode) 
                         break;
-        
+
         if (!b)
         {
-                printk("dio_scodetoipl: bad select code %d\n", scode);
+                printk(KERN_ERR "dio_scodetoipl: bad select code %d\n", scode);
                 return 0;
         }
         else
@@ -270,10 +312,10 @@
         for (b = blist; b; b = b->next)
                 if (b->scode == scode) 
                         break;
-        
+
         if (!b)
         {
-                printk("dio_scodetoname: bad select code %d\n", scode);
+                printk(KERN_ERR "dio_scodetoname: bad select code %d\n", scode);
                 return NULL;
         }
         else
@@ -286,11 +328,11 @@
         for (b = blist; b; b = b->next)
                 if (b->scode == scode)
                         break;
-   
+
         if (!b) 
-                printk("dio_config_board: bad select code %d\n", scode);
+                printk(KERN_ERR "dio_config_board: bad select code %d\n", scode);
         else if (b->configured)
-                printk("dio_config_board: board at select code %d already configured\n", scode);
+                printk(KERN_WARNING "dio_config_board: board at select code %d already configured\n", scode);
         else
                 b->configured = 1;
 }
@@ -301,11 +343,11 @@
         for (b = blist; b; b = b->next)
                 if (b->scode == scode) 
                         break;
-   
+
         if (!b) 
-                printk("dio_unconfig_board: bad select code %d\n", scode);
+                printk(KERN_ERR "dio_unconfig_board: bad select code %d\n", scode);
         else if (!b->configured)
-                printk("dio_unconfig_board: board at select code %d not configured\n", 
+                printk(KERN_WARNING "dio_unconfig_board: board at select code %d not configured\n", 
 		       scode);
         else 
                 b->configured = 0;
--- linux-2.6.10-rc1/include/linux/dio.h	2002-07-24 23:46:36.000000000 +0200
+++ linux-m68k-2.6.10-rc1/include/linux/dio.h	2004-07-14 13:20:06.000000000 +0200
@@ -28,6 +28,9 @@
  * do with ioremap() though.
  */
 #ifdef __KERNEL__
+
+#include <asm/hp300hw.h>
+
 /* DIO/DIO-II boards all have the following 8bit registers.
  * These are offsets from the base of the device.
  */
@@ -35,26 +38,7 @@
 #define DIO_IPLOFF    0x03                        /* interrupt priority level */
 #define DIO_SECIDOFF  0x15                        /* secondary device ID */
 #define DIOII_SIZEOFF 0x101                       /* device size, DIO-II only */
-
-/* The internal HPIB device is special; this is its physaddr; its select code is 7. 
- * The reason why we have to treat it specially is because apparently it's broken:
- * the device ID isn't consistent/reliable. *sigh*
- */
-#define DIO_IHPIBADDR 0x47800
-#define DIO_IHPIBSCODE 7
-
-/* If we don't have the internal HPIB defined, then treat select code 7 like
- * any other. If we *do* have internal HPIB, then we just have to assume that
- * select code 7 is the internal HPIB regardless of the ID register :-<
- */
-#define CONFIG_IHPIB /* hack hack : not yet a proper config option */
-#ifdef CONFIG_IHPIB
-#define DIO_ISIHPIB(scode) ((scode) == DIO_IHPIBSCODE)
-#else
-#define DIO_ISIHPIB(scode) 0
-#endif
-
-#define DIO_VIRADDRBASE 0xf0000000                /* vir addr where IOspace is mapped */
+#define DIO_VIRADDRBASE 0xf0000000UL              /* vir addr where IOspace is mapped */
 
 #define DIO_BASE                0x600000        /* start of DIO space */
 #define DIO_END                 0x1000000       /* end of DIO space */
@@ -67,9 +51,10 @@
 /* Highest valid select code. If we add DIO-II support this should become
  * 256 for everything except HP320, which only has DIO.
  */
-#define DIO_SCMAX 32                             
+#define DIO_SCMAX (hp300_model == HP_320 ? 32 : 256)
 #define DIOII_SCBASE 132 /* lowest DIO-II select code */
 #define DIO_SCINHOLE(scode) (((scode) >= 32) && ((scode) < DIOII_SCBASE))
+#define DIO_ISDIOII(scode) ((scode) >= 132 && (scode) < 256)
 
 /* macros to read device IDs, given base address */
 #define DIO_ID(baseaddr) in_8((baseaddr) + DIO_IDOFF)
@@ -91,7 +76,7 @@
  * In practice this is only important for framebuffers,
  * and everybody else just sets ID fields equal to the DIO_ID_FOO value.
  */
-#define DIO_ENCODE_ID(pr,sec) ((((int)sec & 0xff) << 8) & ((int)pr & 0xff))
+#define DIO_ENCODE_ID(pr,sec) ((((int)sec & 0xff) << 8) | ((int)pr & 0xff))
 /* macro to determine whether a given primary ID requires a secondary ID byte */
 #define DIO_NEEDSSECID(id) ((id) == DIO_ID_FBUFFER)
 
@@ -112,10 +97,8 @@
 #define DIO_DESC_LAN "98643A LANCE ethernet"
 #define DIO_ID_FHPIB    0x08 /* 98625A/98625B fast HP-IB */
 #define DIO_DESC_FHPIB "98625A/98625B fast HPIB"
-#define DIO_ID_NHPIB    0x80 /* 98624A HP-IB (normal ie slow) */
+#define DIO_ID_NHPIB    0x01 /* 98624A HP-IB (normal ie slow) */
 #define DIO_DESC_NHPIB "98624A HPIB"
-#define DIO_ID_IHPIB    0x00 /* internal HPIB (not its real ID, it hasn't got one! */
-#define DIO_DESC_IHPIB "internal HPIB"
 #define DIO_ID_SCSI0    0x07 /* 98625A SCSI */
 #define DIO_DESC_SCSI0 "98625A SCSI0"
 #define DIO_ID_SCSI1    0x27 /* ditto */
@@ -193,7 +176,7 @@
  */
 
 extern int dio_find(int deviceid);
-extern void *dio_scodetoviraddr(int scode);
+extern unsigned long dio_scodetophysaddr(int scode);
 extern int dio_scodetoipl(int scode);
 extern const char *dio_scodetoname(int scode);
 extern void dio_config_board(int scode);

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
