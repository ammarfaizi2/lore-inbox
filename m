Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267620AbTAHAT4>; Tue, 7 Jan 2003 19:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTAHAT4>; Tue, 7 Jan 2003 19:19:56 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:17902 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267614AbTAHAS5>; Tue, 7 Jan 2003 19:18:57 -0500
Date: Wed, 8 Jan 2003 01:27:35 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@transmeta.com>, claus@momo.math.rwth-aachen.de,
       linux-tape@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: [2.5 patch] remove code for 2.0 kernels from drivers/char/ftape/*
Message-ID: <20030108002734.GS6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below is large but trivial:
It removes #if'd compatiblity code for 2.0 kernels from 
drivers/char/ftape/* (this includes the removal of two header files 
including only compatibility code and the #include's of these files).

I've tested the compilation with 2.5.54.

Please apply
Adrian


--- linux-2.5.54/drivers/char/ftape/lowlevel/ftape-setup.c.old	2003-01-08 00:50:19.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/lowlevel/ftape-setup.c	2003-01-08 00:51:10.000000000 +0100
@@ -31,12 +31,7 @@
 #include <linux/mm.h>
 
 #include <linux/ftape.h>
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,16)
 #include <linux/init.h>
-#else
-#define __initdata
-#define __initfunc(__arg) __arg
-#endif
 #include "../lowlevel/ftape-tracing.h"
 #include "../lowlevel/fdc-io.h"
 
--- linux-2.5.54/drivers/char/ftape/lowlevel/ftape_syms.h	2003-01-02 04:21:12.000000000 +0100
+++ /dev/null	2002-12-14 00:15:53.000000000 +0100
@@ -1,39 +0,0 @@
-#ifndef _FTAPE_SYMS_H
-#define _FTAPE_SYMS_H
-
-/*
- * Copyright (C) 1996-1997 Claus-Justus Heine
-
- This program is free software; you can redistribute it and/or modify
- it under the terms of the GNU General Public License as published by
- the Free Software Foundation; either version 2, or (at your option)
- any later version.
-
- This program is distributed in the hope that it will be useful,
- but WITHOUT ANY WARRANTY; without even the implied warranty of
- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- GNU General Public License for more details.
-
- You should have received a copy of the GNU General Public License
- along with this program; see the file COPYING.  If not, write to
- the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
-
- *
- * $Source: /homes/cvs/ftape-stacked/ftape/lowlevel/ftape_syms.h,v $
- * $Revision: 1.2 $
- * $Date: 1997/10/05 19:18:32 $
- *
- *      This file contains the definitions needed to export symbols
- *      from the QIC-40/80/3010/3020 floppy-tape driver "ftape" for
- *      Linux.
- */
-
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-#include <linux/module.h>
-/*      ftape-vfs.c defined global vars.
- */
-
-extern struct symbol_table ftape_symbol_table;
-#endif
-
-#endif
--- linux-2.5.54/drivers/char/ftape/lowlevel/fdc-io.c.old	2003-01-08 00:54:29.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/lowlevel/fdc-io.c	2003-01-08 00:55:15.000000000 +0100
@@ -196,11 +196,7 @@
 	fdc_usec_wait(FT_RQM_DELAY);	/* wait for valid RQM status */
 	save_flags(flags);
 	cli();
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,30)
 	if (!in_interrupt())
-#else
-	if (!intr_count)
-#endif
 		/* Yes, I know, too much comments inside this function
 		 * ...
 		 * 
@@ -264,19 +260,11 @@
 		}
 	}
 #endif
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,30)
 	if (!in_interrupt()) {
 		/* shouldn't be cleared if called from isr
 		 */
 		ft_interrupt_seen = 0;
 	}
-#else
-	if (!intr_count) {
-		/* shouldn't be cleared if called from isr
-		 */
-		ft_interrupt_seen = 0;
-	}
-#endif
 	while (count) {
 		result = fdc_write(*cmd_data);
 		if (result < 0) {
@@ -392,15 +380,9 @@
 
 	TRACE_FUN(ft_t_fdc_dma);
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,0,16)
  	if (waitqueue_active(&ftape_wait_intr)) {
 		TRACE_ABORT(-EIO, ft_t_err, "error: nested call");
 	}
-#else
-	if (ftape_wait_intr) {
-		TRACE_ABORT(-EIO, ft_t_err, "error: nested call");
-	}
-#endif
 	/* timeout time will be up to USPT microseconds too long ! */
 	timeout = (1000 * time + FT_USPT - 1) / FT_USPT;
 
--- linux-2.5.54/drivers/char/ftape/lowlevel/fdc-isr.c.old	2003-01-08 00:55:49.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/lowlevel/fdc-isr.c	2003-01-08 00:57:37.000000000 +0100
@@ -1119,11 +1119,7 @@
 			}
 			ft_seek_completed = 1;
 			fdc_mode = fdc_idle;
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,0,16)
 		} else if (!waitqueue_active(&ftape_wait_intr)) {
-#else
-		} else if (!ftape_wait_intr) {
-#endif
 			if (ft_expected_stray_interrupts == 0) {
 				TRACE(ft_t_warn, "unexpected stray interrupt");
 			} else {
@@ -1154,23 +1150,12 @@
 	 */
 	if (!ft_hide_interrupt) {
 		ft_interrupt_seen ++;
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,0,16)
 		if (waitqueue_active(&ftape_wait_intr)) {
 			wake_up_interruptible(&ftape_wait_intr);
 		}
-#else
-		if (ftape_wait_intr) {
-			wake_up_interruptible(&ftape_wait_intr);
-		}
-#endif
 	} else {
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,0,16)
 		TRACE(ft_t_flow, "hiding interrupt while %s", 
 		      waitqueue_active(&ftape_wait_intr) ? "waiting":"active");
-#else
-		TRACE(ft_t_flow, "hiding interrupt while %s", 
-		      ftape_wait_intr ? "waiting" : "active");
-#endif
 	}
 #ifdef TESTING
 	t0 = ftape_timediff(t0, ftape_timestamp());
--- linux-2.5.54/drivers/char/ftape/lowlevel/ftape-init.c.old	2003-01-08 00:58:07.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/lowlevel/ftape-init.c	2003-01-08 00:59:24.000000000 +0100
@@ -31,19 +31,13 @@
 #include <linux/major.h>
 
 #include <linux/ftape.h>
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,16)
 #include <linux/init.h>
-#else
-#define __initdata
-#define __initfunc(__arg) __arg
-#endif
 #include <linux/qic117.h>
 #ifdef CONFIG_ZFTAPE
 #include <linux/zftape.h>
 #endif
 
 #include "../lowlevel/ftape-init.h"
-#include "../lowlevel/ftape_syms.h"
 #include "../lowlevel/ftape-io.h"
 #include "../lowlevel/ftape-read.h"
 #include "../lowlevel/ftape-write.h"
@@ -114,9 +108,6 @@
 	ft_failure   = 1;         /* inhibit any operation but open */
 	ftape_udelay_calibrate(); /* must be before fdc_wait_calibrate ! */
 	fdc_wait_calibrate();
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-	register_symtab(&ftape_symbol_table); /* add global ftape symbols */
-#endif
 #if defined(CONFIG_PROC_FS) && defined(CONFIG_FT_PROC_FS)
 	(void)ftape_proc_init();
 #endif
@@ -132,7 +123,6 @@
 static int ft_tracing = -1;
 #endif
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,18)
 #define FT_MOD_PARM(var,type,desc) \
 	MODULE_PARM(var,type); MODULE_PARM_DESC(var,desc)
 
@@ -154,7 +144,6 @@
 MODULE_DESCRIPTION(
 	"QIC-117 driver for QIC-40/80/3010/3020 floppy tape drives.");
 MODULE_LICENSE("GPL");
-#endif
 
 /*  Called by modules package when installing the driver
  */
--- linux-2.5.54/drivers/char/ftape/lowlevel/ftape-ctl.c.old	2003-01-08 01:00:04.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/lowlevel/ftape-ctl.c	2003-01-08 01:00:25.000000000 +0100
@@ -33,11 +33,7 @@
 
 #include <linux/ftape.h>
 #include <linux/qic117.h>
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
-#else
-#include <asm/segment.h>
-#endif
 #include <asm/io.h>
 
 /* ease porting between pre-2.4.x and later kernels */
--- linux-2.5.54/drivers/char/ftape/zftape/zftape-buffers.c.old	2003-01-08 01:00:50.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/zftape/zftape-buffers.c	2003-01-08 01:01:17.000000000 +0100
@@ -30,9 +30,7 @@
 
 #include <linux/zftape.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,0)
 #include <linux/vmalloc.h>
-#endif
 
 #include "../zftape/zftape-init.h"
 #include "../zftape/zftape-eof.h"
--- linux-2.5.54/drivers/char/ftape/zftape/zftape-ctl.c.old	2003-01-08 01:01:45.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/zftape/zftape-ctl.c	2003-01-08 01:03:55.000000000 +0100
@@ -33,11 +33,7 @@
 
 #include <linux/zftape.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
-#else
-#include <asm/segment.h>
-#endif
 
 #include "../zftape/zftape-init.h"
 #include "../zftape/zftape-eof.h"
@@ -957,18 +953,11 @@
 		 */
 		TRACE_EXIT 0;
 	}
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 	if (copy_to_user(mtftseg->mt_data,
 			 zft_deblock_buf,
 			 mtftseg->mt_result) != 0) {
 		TRACE_EXIT -EFAULT;
 	}
-#else
-	TRACE_CATCH(verify_area(VERIFY_WRITE, mtftseg->mt_data,
-				mtftseg->mt_result),);
-	memcpy_tofs(mtftseg->mt_data, zft_deblock_buf, 
-		    mtftseg->mt_result);
-#endif
 	TRACE_EXIT 0;
 }
 #endif
@@ -1016,19 +1005,11 @@
 		TRACE_EXIT -ENXIO;
 	}
 	if (mtftseg->mt_mode != FT_WR_DELETE) {
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 		if (copy_from_user(zft_deblock_buf, 
 				   mtftseg->mt_data,
 				   FT_SEGMENT_SIZE) != 0) {
 			TRACE_EXIT -EFAULT;
 		}
-#else
-		TRACE_CATCH(verify_area(VERIFY_READ, 
-					mtftseg->mt_data, 
-					FT_SEGMENT_SIZE),);
-		memcpy_fromfs(zft_deblock_buf, mtftseg->mt_data,
-			      FT_SEGMENT_SIZE);
-#endif
 	}
 	mtftseg->mt_result = ftape_write_segment(mtftseg->mt_segno, 
 						 zft_deblock_buf,
@@ -1375,14 +1356,9 @@
 			    ft_t_info, "bad argument size: %d", arg_size);
 	}
 	if (dir & _IOC_WRITE) {
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 		if (copy_from_user(&krnl_arg, arg, arg_size) != 0) {
 			TRACE_EXIT -EFAULT;
 		}
-#else
-		TRACE_CATCH(verify_area(VERIFY_READ, arg, arg_size),);
-		memcpy_fromfs(&krnl_arg, arg, arg_size);
-#endif
 	}
 	TRACE(ft_t_flow, "called with ioctl command: 0x%08x", command);
 	switch (command) {
@@ -1435,14 +1411,9 @@
 		break;
 	}
 	if ((result >= 0) && (dir & _IOC_READ)) {
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 		if (copy_to_user(arg, &krnl_arg, arg_size) != 0) {
 			TRACE_EXIT -EFAULT;
 		}
-#else
-		TRACE_CATCH(verify_area(VERIFY_WRITE, arg, arg_size),);
-		memcpy_tofs(arg, &krnl_arg, arg_size);
-#endif
 	}
 	TRACE_EXIT result;
 }
--- linux-2.5.54/drivers/char/ftape/zftape/zftape-write.c.old	2003-01-08 01:05:13.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/zftape/zftape-write.c	2003-01-08 01:05:39.000000000 +0100
@@ -29,11 +29,7 @@
 
 #include <linux/zftape.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
-#else
-#include <asm/segment.h>
-#endif
 
 #include "../zftape/zftape-init.h"
 #include "../zftape/zftape-eof.h"
@@ -321,14 +317,9 @@
 	 */
 	space_left = seg_sz - pos->seg_byte_pos;
 	*cnt = req_len < space_left ? req_len : space_left;
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 	if (copy_from_user(dst_buf + pos->seg_byte_pos, src_buf, *cnt) != 0) {
 		TRACE_EXIT -EFAULT;
 	}
-#else
-	TRACE_CATCH(verify_area(VERIFY_READ, src_buf, *cnt),);
-	memcpy_fromfs(dst_buf + pos->seg_byte_pos, src_buf, *cnt);
-#endif
 	TRACE_EXIT *cnt;
 }
 
--- linux-2.5.54/drivers/char/ftape/zftape/zftape_syms.h	2003-01-02 04:22:30.000000000 +0100
+++ /dev/null	2002-12-14 00:15:53.000000000 +0100
@@ -1,39 +0,0 @@
-#ifndef _ZFTAPE_SYMS_H
-#define _ZFTAPE_SYMS_H
-
-/*
- * Copyright (C) 1996, 1997 Claus-Justus Heine
-
- This program is free software; you can redistribute it and/or modify
- it under the terms of the GNU General Public License as published by
- the Free Software Foundation; either version 2, or (at your option)
- any later version.
-
- This program is distributed in the hope that it will be useful,
- but WITHOUT ANY WARRANTY; without even the implied warranty of
- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- GNU General Public License for more details.
-
- You should have received a copy of the GNU General Public License
- along with this program; see the file COPYING.  If not, write to
- the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
-
- *
- * $Source: /homes/cvs/ftape-stacked/ftape/zftape/zftape_syms.h,v $
- * $Revision: 1.2 $
- * $Date: 1997/10/05 19:19:14 $
- *
- *      This file contains the definitions needed for the symbols
- *      ftape exports
- * 
- */
-
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-#include <linux/module.h>
-/*      ftape-vfs.c defined global vars.
- */
-
-extern struct symbol_table zft_symbol_table;
-#endif
-
-#endif
--- linux-2.5.54/drivers/char/ftape/zftape/zftape-init.c.old	2003-01-08 01:08:37.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/zftape/zftape-init.c	2003-01-08 01:08:49.000000000 +0100
@@ -45,7 +45,6 @@
 #include "../zftape/zftape-write.h"
 #include "../zftape/zftape-ctl.h"
 #include "../zftape/zftape-buffers.h"
-#include "../zftape/zftape_syms.h"
 
 char zft_src[] __initdata = "$Source: /homes/cvs/ftape-stacked/ftape/zftape/zftape-init.c,v $";
 char zft_rev[] __initdata = "$Revision: 1.8 $";
--- linux-2.5.54/drivers/char/ftape/zftape/zftape-read.c.old	2003-01-08 01:09:12.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/zftape/zftape-read.c	2003-01-08 01:09:33.000000000 +0100
@@ -29,11 +29,7 @@
 
 #include <linux/zftape.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
-#else
-#include <asm/segment.h>
-#endif
 
 #include "../zftape/zftape-init.h"
 #include "../zftape/zftape-eof.h"
@@ -172,15 +168,10 @@
 	} else {
 		*read_cnt = to_do;
 	}
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 	if (copy_to_user(dst_buf, 
 			 src_buf + pos->seg_byte_pos, *read_cnt) != 0) {
 		TRACE_EXIT -EFAULT;
 	}
-#else
-	TRACE_CATCH(verify_area(VERIFY_WRITE, dst_buf, *read_cnt),);
-	memcpy_tofs(dst_buf, src_buf +  pos->seg_byte_pos, *read_cnt);
-#endif
 	TRACE(ft_t_noise, "nr bytes just read: %d", *read_cnt);
 	TRACE_EXIT *read_cnt;
 }
--- linux-2.5.54/drivers/char/ftape/compressor/zftape-compress.c.old	2003-01-08 01:11:51.000000000 +0100
+++ linux-2.5.54/drivers/char/ftape/compressor/zftape-compress.c	2003-01-08 01:13:32.000000000 +0100
@@ -37,11 +37,7 @@
 
 #include <linux/zftape.h>
 
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,6)
 #include <asm/uaccess.h>
-#else
-#include <asm/segment.h>
-#endif
 
 #include "../zftape/zftape-init.h"
 #include "../zftape/zftape-eof.h"
@@ -271,15 +267,9 @@
 
 static void zftc_lock(void)
 {
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-	if (!MOD_IN_USE) {
-		MOD_INC_USE_COUNT;
-	}
-#else
 	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
 			    *  locking is done with can_unload()
 			    */
-#endif
 	keep_module_locked = 1;
 }
 
@@ -291,11 +281,6 @@
 
 	memset((void *)&cseg, '\0', sizeof(cseg));
 	zftc_stats();
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-	if (MOD_IN_USE) {
-		MOD_DEC_USE_COUNT;
-	}
-#endif
 	keep_module_locked = 0;
 	TRACE_EXIT;
 }
@@ -570,15 +555,9 @@
 	TRACE_FUN(ft_t_flow);
 	
 	keep_module_locked = 1;
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,18)
 	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
 			    *  locking is done with can_unload()
 			    */
-#else
-	if (!MOD_IN_USE) {
-		MOD_INC_USE_COUNT;
-	}
-#endif
 	/* Note: we do not unlock the module because
 	 * there are some values cached in that `cseg' variable.  We
 	 * don't don't want to use this information when being
@@ -618,17 +597,10 @@
 		 * block.  We know, that the compression buffer is
 		 * empty (else there wouldn't be any space left).  
 		 */
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 		if (copy_from_user(zftc_scratch_buf, src_buf + result, 
 				   volume->blk_sz) != 0) {
 			TRACE_EXIT -EFAULT;
 		}
-#else
-		TRACE_CATCH(verify_area(VERIFY_READ, src_buf + result, 
-					volume->blk_sz),);
-		memcpy_fromfs(zftc_scratch_buf, src_buf + result, 
-			      volume->blk_sz);
-#endif
 		req_len_left -= volume->blk_sz;
 		cseg.cmpr_sz = zft_compress(zftc_scratch_buf, volume->blk_sz, 
 					    zftc_buf);
@@ -704,15 +676,9 @@
 	TRACE_FUN(ft_t_flow);
 
 	keep_module_locked = 1;
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,18)
 	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
 			    *  locking is done with can_unload()
 			    */
-#else
-	if (!MOD_IN_USE) {
-		MOD_INC_USE_COUNT;
-	}
-#endif
 	TRACE_CATCH(zft_allocate_cmpr_mem(volume->blk_sz),);
 	if (pos->seg_byte_pos == 0) {
 		/* new segment just read
@@ -746,16 +712,11 @@
 				      "Uncompressed blk (%d) != blk size (%d)",
 				      uncompressed_sz, volume->blk_sz);
 			}       
-#if LINUX_VERSION_CODE > KERNEL_VER(2,1,3)
 			if (copy_to_user(dst_buf + result, 
 					 zftc_scratch_buf, 
 					 uncompressed_sz) != 0 ) {
 				TRACE_EXIT -EFAULT;
 			}
-#else
-			memcpy_tofs(dst_buf + result, zftc_scratch_buf, 
-				    uncompressed_sz);
-#endif
 			remaining      -= uncompressed_sz;
 			result     += uncompressed_sz;
 			cseg.cmpr_pos  = 0;
@@ -839,15 +800,9 @@
 	TRACE_FUN(ft_t_flow);
 
 	keep_module_locked = 1;
-#if LINUX_VERSION_CODE >= KERNEL_VER(2,1,18)
 	MOD_INC_USE_COUNT; /*  sets MOD_VISITED and MOD_USED_ONCE,
 			    *  locking is done with can_unload()
 			    */
-#else
-	if (!MOD_IN_USE) {
-		MOD_INC_USE_COUNT;
-	}
-#endif
 	if (new_block_pos == 0) {
 		pos->seg_pos      = volume->start_seg;
 		pos->seg_byte_pos = 0;
@@ -1272,15 +1227,11 @@
 {
 	int result;
 
-#if LINUX_VERSION_CODE < KERNEL_VER(2,1,18)
-	register_symtab(0); /* remove global ftape symbols */
-#else
 #if 0 /* FIXME --RR */
 	if (!mod_member_present(&__this_module, can_unload))
 		return -EBUSY;
 	__this_module.can_unload = can_unload;
 #endif
-#endif
 	result = zft_compressor_init();
 	keep_module_locked = 0;
 	return result;
