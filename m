Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288611AbSATOAE>; Sun, 20 Jan 2002 09:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288606AbSATN7z>; Sun, 20 Jan 2002 08:59:55 -0500
Received: from [217.9.226.246] ([217.9.226.246]:63619 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S288597AbSATN7p>; Sun, 20 Jan 2002 08:59:45 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] __linux__ and cross-compile
From: Momchil Velikov <velco@fadata.bg>
Date: 20 Jan 2002 15:59:30 +0200
Message-ID: <874rlhazst.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

The following patch fixes compilation/miscompilation problems, which
may happend iwtg variuos cross compile configuration, wherte the
compiler used to compile the kernel does not necessarily define
__linux__. The patch replaces __linux__ with __KERNEL__, using
__KERNEL_ as an indication that the source is compiled as a part of
linux.  Sources, which can be compiled in userspace as well, are
changed to use #if defined(__linux__) || defined(__KERNEL__).

Regards,
-velco

===== arch/alpha/kernel/entry.S 1.1 vs edited =====
--- 1.1/arch/alpha/kernel/entry.S	Sat Dec  8 02:15:19 2001
+++ edited/arch/alpha/kernel/entry.S	Sun Jan 20 15:26:53 2002
@@ -121,9 +121,6 @@
 
 .text
 .set noat
-#if defined(__linux__) && !defined(__ELF__)
-  .set singlegp
-#endif
 
 .align 3
 .globl	entInt
===== drivers/char/drm/drm.h 1.2 vs edited =====
--- 1.2/drivers/char/drm/drm.h	Sat Dec  8 02:36:06 2001
+++ edited/drivers/char/drm/drm.h	Sun Jan 20 15:29:13 2002
@@ -35,7 +35,7 @@
 #ifndef _DRM_H_
 #define _DRM_H_
 
-#if defined(__linux__)
+#if defined(__linux__) || defined(__KERNEL__)
 #include <linux/config.h>
 #include <asm/ioctl.h>		/* For _IO* macros */
 #define DRM_IOCTL_NR(n)	     _IOC_NR(n)
===== drivers/char/drm-4.0/drm.h 1.1 vs edited =====
--- 1.1/drivers/char/drm-4.0/drm.h	Thu Jan 10 15:28:33 2002
+++ edited/drivers/char/drm-4.0/drm.h	Sun Jan 20 15:29:57 2002
@@ -36,7 +36,7 @@
 #define _DRM_H_
 
 #include <linux/config.h>
-#if defined(__linux__)
+#if defined(__linux__) || defined(__KERNEL__)
 #include <asm/ioctl.h>		/* For _IO* macros */
 #define DRM_IOCTL_NR(n)	     _IOC_NR(n)
 #elif defined(__FreeBSD__)
===== drivers/scsi/aic7xxx/aic7xxx.c 1.1 vs edited =====
--- 1.1/drivers/scsi/aic7xxx/aic7xxx.c	Sat Dec  8 02:14:28 2001
+++ edited/drivers/scsi/aic7xxx/aic7xxx.c	Sun Jan 20 15:49:03 2002
@@ -3653,7 +3653,7 @@
 	case 2:
 		ahc_dma_tag_destroy(ahc, ahc->shared_data_dmat);
 	case 1:
-#ifndef __linux__
+#ifndef __KERNEL__
 		ahc_dma_tag_destroy(ahc, ahc->buffer_dmat);
 #endif
 		break;
@@ -3661,7 +3661,7 @@
 		break;
 	}
 
-#ifndef __linux__
+#ifndef __KERNEL__
 	ahc_dma_tag_destroy(ahc, ahc->parent_dmat);
 #endif
 	ahc_platform_free(ahc);
@@ -4121,7 +4121,7 @@
 	newcount = MIN(newcount, (AHC_SCB_MAX_ALLOC - scb_data->numscbs));
 	for (i = 0; i < newcount; i++) {
 		struct scb_platform_data *pdata;
-#ifndef __linux__
+#ifndef __KERNEL__
 		int error;
 #endif
 		pdata = (struct scb_platform_data *)malloc(sizeof(*pdata),
@@ -4138,7 +4138,7 @@
 		next_scb->sg_list_phys = physaddr + sizeof(struct ahc_dma_seg);
 		next_scb->ahc_softc = ahc;
 		next_scb->flags = SCB_FREE;
-#ifndef __linux__
+#ifndef __KERNEL__
 		error = ahc_dmamap_create(ahc, ahc->buffer_dmat, /*flags*/0,
 					  &next_scb->dmamap);
 		if (error != 0)
@@ -4254,7 +4254,7 @@
 	if ((AHC_TMODE_ENABLE & (0x1 << ahc->unit)) == 0)
 		ahc->features &= ~AHC_TARGETMODE;
 
-#ifndef __linux__
+#ifndef __KERNEL__
 	/* DMA tag for mapping buffers into device visible space. */
 	if (ahc_dma_tag_create(ahc, ahc->parent_dmat, /*alignment*/1,
 			       /*boundary*/BUS_SPACE_MAXADDR_32BIT + 1,
===== drivers/scsi/aic7xxx/aic7xxx.h 1.1 vs edited =====
--- 1.1/drivers/scsi/aic7xxx/aic7xxx.h	Sat Dec  8 02:14:28 2001
+++ edited/drivers/scsi/aic7xxx/aic7xxx.h	Sun Jan 20 15:49:00 2002
@@ -547,7 +547,7 @@
 	ahc_io_ctx_t		  io_ctx;
 	struct ahc_softc	 *ahc_softc;
 	scb_flag		  flags;
-#ifndef __linux__
+#ifndef __KERNEL__
 	bus_dmamap_t		  dmamap;
 #endif
 	struct scb_platform_data *platform_data;
@@ -870,7 +870,7 @@
 struct ahc_softc {
 	bus_space_tag_t           tag;
 	bus_space_handle_t        bsh;
-#ifndef __linux__
+#ifndef __KERNEL__
 	bus_dma_tag_t		  buffer_dmat;   /* dmat for buffer I/O */
 #endif
 	struct scb_data		 *scb_data;
===== drivers/scsi/dpt/osd_defs.h 1.1 vs edited =====
--- 1.1/drivers/scsi/dpt/osd_defs.h	Sat Dec  8 02:14:34 2001
+++ edited/drivers/scsi/dpt/osd_defs.h	Sun Jan 20 15:45:09 2002
@@ -52,7 +52,7 @@
 /*Definitions - Defines & Constants ----------------------------------------- */
 
   /* Define the operating system */
-#if (defined(__linux__))
+#if defined(__linux__) || defined(__KERNEL__)
 # define _DPT_LINUX
 #elif (defined(__bsdi__))
 # define _DPT_BSDI
===== include/asm-mips/sgidefs.h 1.1 vs edited =====
--- 1.1/include/asm-mips/sgidefs.h	Sat Dec  8 02:13:26 2001
+++ edited/include/asm-mips/sgidefs.h	Sun Jan 20 15:48:28 2002
@@ -11,14 +11,6 @@
 #define __ASM_SGIDEFS_H
 
 /*
- * Using a Linux compiler for building Linux seems logic but not to
- * everybody.
- */
-#ifndef __linux__
-#error Use a Linux compiler or give up.
-#endif
-
-/*
  * Definitions for the ISA levels
  *
  * With the introduction of MIPS32 / MIPS64 instruction sets definitions
===== include/asm-mips64/sgidefs.h 1.1 vs edited =====
--- 1.1/include/asm-mips64/sgidefs.h	Sat Dec  8 02:13:55 2001
+++ edited/include/asm-mips64/sgidefs.h	Sun Jan 20 15:48:55 2002
@@ -11,14 +11,6 @@
 #define __ASM_SGIDEFS_H
 
 /*
- * Using a Linux compiler for building Linux seems logic but not to
- * everybody.
- */
-#ifndef __linux__
-#error Use a Linux compiler or give up.
-#endif
-
-/*
  * Definitions for the ISA levels
  *
  * With the introduction of MIPS32 / MIPS64 instruction sets definitions
===== include/linux/coda.h 1.1 vs edited =====
--- 1.1/include/linux/coda.h	Sat Dec  8 02:13:14 2001
+++ edited/include/linux/coda.h	Sun Jan 20 15:16:58 2002
@@ -98,7 +98,7 @@
 #endif /* !DJGPP */
 
 
-#if defined(__linux__)
+#if defined(__linux__) || defined(__KERNEL__)
 #define cdev_t u_quad_t
 #ifndef __KERNEL__
 #if !defined(_UQUAD_T_) && (!defined(__GLIBC__) || __GLIBC__ < 2)
@@ -211,8 +211,8 @@
 #endif	/* VICEFID */
 
 
-#ifdef __linux__
+#if defined(__linux__) || defined(__KERNEL__)
 static __inline__ ino_t  coda_f2i(struct ViceFid *fid)
 {
 	if ( ! fid ) 

