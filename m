Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbTIEUxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265700AbTIEUxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 16:53:38 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:17469 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265692AbTIEUxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 16:53:15 -0400
Date: Fri, 5 Sep 2003 22:48:27 +0200
Message-Id: <200309052048.h85KmRTX000880@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] dmasound kill MOD_{IN,DE}C_USE_COUNT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmasound: Use try_module_get()/module_put() instead of methods calling
MOD_{IN,DE}C_USE_COUNT (from Christoph Hellwig)

--- linux-2.6.0-test4/sound/oss/dmasound/dmasound.h	Tue May 27 19:04:17 2003
+++ linux-m68k-2.6.0-test4/sound/oss/dmasound/dmasound.h	Thu Sep  4 13:21:03 2003
@@ -115,8 +115,7 @@
 typedef struct {
     const char *name;
     const char *name2;
-    void (*open)(void);
-    void (*release)(void);
+    struct module *owner;
     void *(*dma_alloc)(unsigned int, int);
     void (*dma_free)(void *, unsigned int);
     int (*irqinit)(void);
--- linux-2.6.0-test4/sound/oss/dmasound/dmasound_atari.c	Sun Aug 24 09:50:28 2003
+++ linux-m68k-2.6.0-test4/sound/oss/dmasound/dmasound_atari.c	Thu Sep  4 13:21:04 2003
@@ -115,8 +115,6 @@
 /*** Low level stuff *********************************************************/
 
 
-static void AtaOpen(void);
-static void AtaRelease(void);
 static void *AtaAlloc(unsigned int size, int flags);
 static void AtaFree(void *, unsigned int size);
 static int AtaIrqInit(void);
@@ -813,16 +811,6 @@
  * Atari (TT/Falcon)
  */
 
-static void AtaOpen(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void AtaRelease(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static void *AtaAlloc(unsigned int size, int flags)
 {
 	return atari_stram_alloc(size, "dmasound");
@@ -1521,8 +1509,7 @@
 static MACHINE machTT = {
 	.name		= "Atari",
 	.name2		= "TT",
-	.open		= AtaOpen,
-	.release	= AtaRelease,
+	.owner		= THIS_MODULE,
 	.dma_alloc	= AtaAlloc,
 	.dma_free	= AtaFree,
 	.irqinit	= AtaIrqInit,
--- linux-2.6.0-test4/sound/oss/dmasound/dmasound_awacs.c	Sun Aug 24 09:50:28 2003
+++ linux-m68k-2.6.0-test4/sound/oss/dmasound/dmasound_awacs.c	Thu Sep  4 13:21:04 2003
@@ -252,8 +252,6 @@
 
 /*** Low level stuff *********************************************************/
 
-static void PMacOpen(void);
-static void PMacRelease(void);
 static void *PMacAlloc(unsigned int size, int flags);
 static void PMacFree(void *ptr, unsigned int size);
 static int PMacIrqInit(void);
@@ -493,17 +491,6 @@
 /*
  * PCI PowerMac, with AWACS, Screamer, Burgundy, DACA or Tumbler and DBDMA.
  */
-
-static void PMacOpen(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void PMacRelease(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static void *PMacAlloc(unsigned int size, int flags)
 {
 	return kmalloc(size, flags);
@@ -2428,8 +2415,7 @@
 static MACHINE machPMac = {
 	.name		= awacs_name,
 	.name2		= "PowerMac Built-in Sound",
-	.open		= PMacOpen,
-	.release	= PMacRelease,
+	.owner		= THIS_MODULE,
 	.dma_alloc	= PMacAlloc,
 	.dma_free	= PMacFree,
 	.irqinit	= PMacIrqInit,
--- linux-2.6.0-test4/sound/oss/dmasound/dmasound_core.c	Wed Aug 27 18:43:50 2003
+++ linux-m68k-2.6.0-test4/sound/oss/dmasound/dmasound_core.c	Thu Sep  4 13:21:04 2003
@@ -327,7 +327,8 @@
 
 static int mixer_open(struct inode *inode, struct file *file)
 {
-	dmasound.mach.open();
+	if (!try_module_get(dmasound.mach.owner))
+		return -ENODEV;
 	mixer.busy = 1;
 	return 0;
 }
@@ -336,7 +337,7 @@
 {
 	lock_kernel();
 	mixer.busy = 0;
-	dmasound.mach.release();
+	module_put(dmasound.mach.owner);
 	unlock_kernel();
 	return 0;
 }
@@ -869,31 +870,29 @@
 {
 	int rc;
 
-	dmasound.mach.open();
+	if (!try_module_get(dmasound.mach.owner))
+		return -ENODEV;
 
-	if ((rc = write_sq_open(file))) { /* checks the f_mode */
-		dmasound.mach.release();
-		return rc;
-	}
+	rc = write_sq_open(file); /* checks the f_mode */
+	if (rc)
+		goto out;
 #ifdef HAS_RECORD
 	if (dmasound.mach.record) {
-		if ((rc = read_sq_open(file))) { /* checks the f_mode */
-			dmasound.mach.release();
-			return rc;
-		}
+		rc = read_sq_open(file); /* checks the f_mode */
+		if (rc)
+			goto out;
 	} else { /* no record function installed; in compat mode */
 		if (file->f_mode & FMODE_READ) {
 			/* TODO: if O_RDWR, release any resources grabbed by write part */
-			dmasound.mach.release() ;
-			/* I think this is what is required by open(2) */
-			return -ENXIO ;
+			rc = -ENXIO;
+			goto out;
 		}
 	}
 #else /* !HAS_RECORD */
 	if (file->f_mode & FMODE_READ) {
 		/* TODO: if O_RDWR, release any resources grabbed by write part */
-		dmasound.mach.release() ;
-		return -ENXIO ; /* I think this is what is required by open(2) */
+		rc = -ENXIO ; /* I think this is what is required by open(2) */
+		goto out;
 	}
 #endif /* HAS_RECORD */
 
@@ -931,6 +930,9 @@
 #endif
 
 	return 0;
+ out:
+	module_put(dmasound.mach.owner);
+	return rc;
 }
 
 static void sq_reset_output(void)
@@ -1050,7 +1052,7 @@
 		dmasound.hard = dmasound.mach.default_hard ;
 	}
 
-	dmasound.mach.release();
+	module_put(dmasound.mach.owner);
 
 #if 0 /* blocking open() */
 	/* Wake up a process waiting for the queue being released.
@@ -1447,7 +1449,8 @@
 	if (state.busy)
 		return -EBUSY;
 
-	dmasound.mach.open();
+	if (!try_module_get(dmasound.mach.owner))
+		return -ENODEV;
 	state.ptr = 0;
 	state.busy = 1;
 
@@ -1529,7 +1532,7 @@
 {
 	lock_kernel();
 	state.busy = 0;
-	dmasound.mach.release();
+	module_put(dmasound.mach.owner);
 	unlock_kernel();
 	return 0;
 }
--- linux-2.6.0-test4/sound/oss/dmasound/dmasound_paula.c	Tue May 27 19:04:17 2003
+++ linux-m68k-2.6.0-test4/sound/oss/dmasound/dmasound_paula.c	Thu Sep  4 13:21:04 2003
@@ -69,8 +69,6 @@
 /*** Low level stuff *********************************************************/
 
 
-static void AmiOpen(void);
-static void AmiRelease(void);
 static void *AmiAlloc(unsigned int size, int flags);
 static void AmiFree(void *obj, unsigned int size);
 static int AmiIrqInit(void);
@@ -311,17 +309,6 @@
 
 /*** Low level stuff *********************************************************/
 
-
-static void AmiOpen(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void AmiRelease(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
 static inline void StopDMA(void)
 {
 	custom.aud[0].audvol = custom.aud[1].audvol = 0;
@@ -699,8 +686,7 @@
 static MACHINE machAmiga = {
 	.name		= "Amiga",
 	.name2		= "AMIGA",
-	.open		= AmiOpen,
-	.release	= AmiRelease,
+	.owner		= THIS_MODULE,
 	.dma_alloc	= AmiAlloc,
 	.dma_free	= AmiFree,
 	.irqinit	= AmiIrqInit,
--- linux-2.6.0-test4/sound/oss/dmasound/dmasound_q40.c	Sun Aug 24 09:50:28 2003
+++ linux-m68k-2.6.0-test4/sound/oss/dmasound/dmasound_q40.c	Thu Sep  4 13:21:04 2003
@@ -36,8 +36,6 @@
 /*** Low level stuff *********************************************************/
 
 
-static void Q40Open(void);
-static void Q40Release(void);
 static void *Q40Alloc(unsigned int size, int flags);
 static void Q40Free(void *, unsigned int);
 static int Q40IrqInit(void);
@@ -360,18 +358,6 @@
 
 /*** Low level stuff *********************************************************/
 
-
-static void Q40Open(void)
-{
-	MOD_INC_USE_COUNT;
-}
-
-static void Q40Release(void)
-{
-	MOD_DEC_USE_COUNT;
-}
-
-
 static void *Q40Alloc(unsigned int size, int flags)
 {
          return kmalloc(size, flags); /* change to vmalloc */
@@ -603,8 +589,7 @@
 static MACHINE machQ40 = {
 	.name		= "Q40",
 	.name2		= "Q40",
-	.open		= Q40Open,
-	.release	= Q40Release,
+	.owner		= THIS_MODULE,
 	.dma_alloc	= Q40Alloc,
 	.dma_free	= Q40Free,
 	.irqinit	= Q40IrqInit,

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
