Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269866AbUJVHXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269866AbUJVHXx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 03:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269966AbUJVHWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 03:22:39 -0400
Received: from ozlabs.org ([203.10.76.45]:11678 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269952AbUJVHO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 03:14:58 -0400
Subject: [PATCH] Eliminate obsolete use of init_module and cleanup_module
	magic
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1098429294.12103.78.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 17:14:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: Eliminate Obsolete init_module and cleanup_module Uses
Status: Compiled on linux-2.6.9-bk6
Depends: Module/obsolete-init_module-docs.patch.gz
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

In 2.2, you used to just be able to call functions "init_module" and
"cleanup_module" and they'd be magically called.

Use module_init(myinit)/module_exit(myexit) instead: they won't break
with the coming changes.

diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/arch/alpha/math-emu/math.c working-2.6.9-bk6-obsolete-init_module/arch/alpha/math-emu/math.c
--- linux-2.6.9-bk6/arch/alpha/math-emu/math.c	2004-06-17 08:47:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/arch/alpha/math-emu/math.c	2004-10-22 14:02:00.000000000 +1000
@@ -62,7 +62,7 @@ static long (*save_emul) (unsigned long 
 long do_alpha_fp_emul_imprecise(struct pt_regs *, unsigned long);
 long do_alpha_fp_emul(unsigned long);
 
-int init_module(void)
+static int init(void)
 {
 	save_emul_imprecise = alpha_fp_emul_imprecise;
 	save_emul = alpha_fp_emul;
@@ -71,12 +71,15 @@ int init_module(void)
 	return 0;
 }
 
-void cleanup_module(void)
+static void cleanup(void)
 {
 	alpha_fp_emul_imprecise = save_emul_imprecise;
 	alpha_fp_emul = save_emul;
 }
 
+module_init(init);
+module_exit(cleanup);
+
 #undef  alpha_fp_emul_imprecise
 #define alpha_fp_emul_imprecise		do_alpha_fp_emul_imprecise
 #undef  alpha_fp_emul
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/block/acsi.c working-2.6.9-bk6-obsolete-init_module/drivers/block/acsi.c
--- linux-2.6.9-bk6/drivers/block/acsi.c	2003-10-09 18:02:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/block/acsi.c	2004-10-22 14:02:00.000000000 +1000
@@ -64,6 +64,7 @@ typedef void Scsi_Device; /* hack to avo
 #include <linux/blkpg.h>
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
+#include <linux/init.h>
 
 #include <asm/setup.h>
 #include <asm/pgtable.h>
@@ -1788,6 +1789,9 @@ void cleanup_module(void)
 		put_disk(acsi_gendisk[i]);
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/block/acsi_slm.c working-2.6.9-bk6-obsolete-init_module/drivers/block/acsi_slm.c
--- linux-2.6.9-bk6/drivers/block/acsi_slm.c	2003-09-22 10:27:56.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/block/acsi_slm.c	2004-10-22 14:02:00.000000000 +1000
@@ -67,6 +67,7 @@ not be guaranteed. There are several way
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/init.h>
 
 #include <asm/pgtable.h>
 #include <asm/system.h>
@@ -1042,4 +1043,7 @@ void cleanup_module(void)
 		printk( KERN_ERR "acsi_slm: cleanup_module failed\n");
 	atari_stram_free( SLMBuffer );
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/block/amiflop.c working-2.6.9-bk6-obsolete-init_module/drivers/block/amiflop.c
--- linux-2.6.9-bk6/drivers/block/amiflop.c	2004-10-19 14:33:56.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/block/amiflop.c	2004-10-22 14:02:00.000000000 +1000
@@ -1824,6 +1824,7 @@ int init_module(void)
 		return -ENXIO;
 	return amiga_floppy_init();
 }
+module_init(init_module);
 
 #if 0 /* not safe to unload */
 void cleanup_module(void)
@@ -1846,5 +1847,7 @@ void cleanup_module(void)
 	release_mem_region(CUSTOM_PHYSADDR+0x20, 8);
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 }
+
+module_exit(cleanup_module);
 #endif
 #endif
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/block/floppy.c working-2.6.9-bk6-obsolete-init_module/drivers/block/floppy.c
--- linux-2.6.9-bk6/drivers/block/floppy.c	2004-09-28 16:22:04.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/block/floppy.c	2004-10-22 14:07:22.000000000 +1000
@@ -4630,6 +4630,8 @@ MODULE_AUTHOR("Alain L. Knaff");
 MODULE_SUPPORTED_DEVICE("fd");
 MODULE_LICENSE("GPL");
 
+module_init(init_module);
+module_exit(cleanup_module);
 #else
 
 __setup("floppy=", floppy_setup);
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/block/ps2esdi.c working-2.6.9-bk6-obsolete-init_module/drivers/block/ps2esdi.c
--- linux-2.6.9-bk6/drivers/block/ps2esdi.c	2004-06-17 08:48:06.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/block/ps2esdi.c	2004-10-22 17:04:25.000000000 +1000
@@ -219,6 +219,9 @@ cleanup_module(void) {
 		put_disk(ps2esdi_gendisk[i]);
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /* handles boot time command line parameters */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/block/xd.c working-2.6.9-bk6-obsolete-init_module/drivers/block/xd.c
--- linux-2.6.9-bk6/drivers/block/xd.c	2004-09-28 16:22:04.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/block/xd.c	2004-10-22 17:04:46.000000000 +1000
@@ -1069,6 +1069,7 @@ void cleanup_module(void)
 			xd_dma_mem_free((unsigned long)xd_dma_buffer, xd_maxsectors * 0x200);
 	}
 }
+module_exit(cleanup_module);
 #else
 
 static int __init xd_setup (char *str)
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/block/z2ram.c working-2.6.9-bk6-obsolete-init_module/drivers/block/z2ram.c
--- linux-2.6.9-bk6/drivers/block/z2ram.c	2004-10-22 07:56:47.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/block/z2ram.c	2004-10-22 14:02:00.000000000 +1000
@@ -426,4 +426,7 @@ cleanup_module( void )
 
     return;
 } 
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/char/applicom.c working-2.6.9-bk6-obsolete-init_module/drivers/char/applicom.c
--- linux-2.6.9-bk6/drivers/char/applicom.c	2004-10-22 07:56:47.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/char/applicom.c	2004-10-22 14:02:00.000000000 +1000
@@ -165,11 +165,7 @@ static int ac_register_board(unsigned lo
 	return boardno + 1;
 }
 
-#ifdef MODULE
-
-#define applicom_init init_module
-
-void cleanup_module(void)
+static void __exit applicom_cleanup(void)
 {
 	int i;
 
@@ -187,8 +183,6 @@ void cleanup_module(void)
 	}
 }
 
-#endif				/* MODULE */
-
 int __init applicom_init(void)
 {
 	int i, numisa = 0;
@@ -339,9 +333,8 @@ int __init applicom_init(void)
 }
 
 
-#ifndef MODULE
-__initcall(applicom_init);
-#endif
+module_init(applicom_init)
+module_exit(applicom_cleanup);
 
 static ssize_t ac_write(struct file *file, const char __user *buf, size_t count, loff_t * ppos)
 {
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/char/ftape/compressor/zftape-compress.c working-2.6.9-bk6-obsolete-init_module/drivers/char/ftape/compressor/zftape-compress.c
--- linux-2.6.9-bk6/drivers/char/ftape/compressor/zftape-compress.c	2004-09-28 16:22:04.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/char/ftape/compressor/zftape-compress.c	2004-10-22 14:02:00.000000000 +1000
@@ -35,6 +35,7 @@
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/init.h>
 
 #include <linux/zftape.h>
 
@@ -1206,4 +1207,7 @@ int init_module(void)
 	return zft_compressor_init();
 }
 
+
+module_init(init_module);
+
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/char/i8k.c working-2.6.9-bk6-obsolete-init_module/drivers/char/i8k.c
--- linux-2.6.9-bk6/drivers/char/i8k.c	2004-06-17 08:48:08.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/char/i8k.c	2004-10-22 14:02:01.000000000 +1000
@@ -778,6 +778,9 @@ void cleanup_module(void)
 
     printk(KERN_INFO "i8k: module unloaded\n");
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
 /* end of file */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/char/ip2main.c working-2.6.9-bk6-obsolete-init_module/drivers/char/ip2main.c
--- linux-2.6.9-bk6/drivers/char/ip2main.c	2004-10-22 07:56:48.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/char/ip2main.c	2004-10-22 14:02:01.000000000 +1000
@@ -369,6 +369,7 @@ init_module(void)
 #endif
     return 0;
 }
+module_init(init_module);
 #endif /* MODULE */
 
 /******************************************************************************/
@@ -462,6 +463,8 @@ cleanup_module(void)
 	printk (KERN_DEBUG "IP2 Unloaded\n" );
 #endif
 }
+
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 static struct tty_operations ip2_ops = {
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/char/isicom.c working-2.6.9-bk6-obsolete-init_module/drivers/char/isicom.c
--- linux-2.6.9-bk6/drivers/char/isicom.c	2004-10-22 07:56:48.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/char/isicom.c	2004-10-22 14:02:01.000000000 +1000
@@ -1934,3 +1934,6 @@ void cleanup_module(void)
 	if (misc_deregister(&isiloader_device))
 		printk(KERN_ERR "ISICOM: Unable to unregister Firmware Loader driver\n");
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/char/toshiba.c working-2.6.9-bk6-obsolete-init_module/drivers/char/toshiba.c
--- linux-2.6.9-bk6/drivers/char/toshiba.c	2004-06-17 08:48:08.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/char/toshiba.c	2004-10-22 14:02:01.000000000 +1000
@@ -522,6 +522,9 @@ void cleanup_module(void)
 
 	misc_deregister(&tosh_device);
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/ide/ide.c working-2.6.9-bk6-obsolete-init_module/drivers/ide/ide.c
--- linux-2.6.9-bk6/drivers/ide/ide.c	2004-10-22 07:56:49.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/ide/ide.c	2004-10-22 14:08:38.000000000 +1000
@@ -2520,6 +2520,8 @@ void cleanup_module (void)
 
 	bus_unregister(&ide_bus_type);
 }
+module_init(init_module);
+module_exit(cleanup_module);
 
 #else /* !MODULE */
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/media/video/cpia_pp.c working-2.6.9-bk6-obsolete-init_module/drivers/media/video/cpia_pp.c
--- linux-2.6.9-bk6/drivers/media/video/cpia_pp.c	2004-03-12 07:56:56.000000000 +1100
+++ working-2.6.9-bk6-obsolete-init_module/drivers/media/video/cpia_pp.c	2004-10-22 14:02:01.000000000 +1000
@@ -861,6 +861,8 @@ void cleanup_module(void)
 	return;
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #else /* !MODULE */
 
 static int __init cpia_pp_setup(char *str)
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/media/video/vino.c working-2.6.9-bk6-obsolete-init_module/drivers/media/video/vino.c
--- linux-2.6.9-bk6/drivers/media/video/vino.c	2003-09-21 17:34:00.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/media/video/vino.c	2004-10-22 14:02:01.000000000 +1000
@@ -264,4 +264,7 @@ int init_module(void)
 void cleanup_module(void)
 {
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/3c501.c working-2.6.9-bk6-obsolete-init_module/drivers/net/3c501.c
--- linux-2.6.9-bk6/drivers/net/3c501.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/3c501.c	2004-10-22 14:02:01.000000000 +1000
@@ -932,6 +932,8 @@ void cleanup_module(void)
 	free_netdev(dev);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 MODULE_AUTHOR("Donald Becker, Alan Cox");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/3c503.c working-2.6.9-bk6-obsolete-init_module/drivers/net/3c503.c
--- linux-2.6.9-bk6/drivers/net/3c503.c	2004-09-28 16:22:06.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/3c503.c	2004-10-22 14:02:01.000000000 +1000
@@ -731,4 +731,6 @@ cleanup_module(void)
 		}
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/3c505.c working-2.6.9-bk6-obsolete-init_module/drivers/net/3c505.c
--- linux-2.6.9-bk6/drivers/net/3c505.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/3c505.c	2004-10-22 14:02:01.000000000 +1000
@@ -1696,5 +1696,7 @@ void cleanup_module(void)
 	}
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif				/* MODULE */
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/3c507.c working-2.6.9-bk6-obsolete-init_module/drivers/net/3c507.c
--- linux-2.6.9-bk6/drivers/net/3c507.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/3c507.c	2004-10-22 14:02:01.000000000 +1000
@@ -938,6 +938,8 @@ cleanup_module(void)
 	release_region(dev->base_addr, EL16_IO_EXTENT);
 	free_netdev(dev);
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 MODULE_LICENSE("GPL");
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/3c515.c working-2.6.9-bk6-obsolete-init_module/drivers/net/3c515.c
--- linux-2.6.9-bk6/drivers/net/3c515.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/3c515.c	2004-10-22 14:02:01.000000000 +1000
@@ -73,6 +73,7 @@ static int max_interrupt_work = 20;
 #include <linux/timer.h>
 #include <linux/ethtool.h>
 #include <linux/bitops.h>
+#include <linux/init.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -424,7 +425,7 @@ int init_module(void)
 		found++;
 	return found ? 0 : -ENODEV;
 }
-
+module_init(init_module);
 #else
 struct net_device *tc515_probe(int unit)
 {
@@ -1588,6 +1589,7 @@ void cleanup_module(void)
 		free_netdev(dev);
 	}
 }
+module_exit(cleanup_module);
 #endif				/* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/3c523.c working-2.6.9-bk6-obsolete-init_module/drivers/net/3c523.c
--- linux-2.6.9-bk6/drivers/net/3c523.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/3c523.c	2004-10-22 14:02:01.000000000 +1000
@@ -1320,4 +1320,7 @@ void cleanup_module(void)
 	}
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
+
 #endif				/* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/3c527.c working-2.6.9-bk6-obsolete-init_module/drivers/net/3c527.c
--- linux-2.6.9-bk6/drivers/net/3c527.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/3c527.c	2004-10-22 14:02:01.000000000 +1000
@@ -1672,4 +1672,6 @@ void cleanup_module(void)
 	free_netdev(this_device);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/82596.c working-2.6.9-bk6-obsolete-init_module/drivers/net/82596.c
--- linux-2.6.9-bk6/drivers/net/82596.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/82596.c	2004-10-22 14:02:01.000000000 +1000
@@ -1609,6 +1609,8 @@ void cleanup_module(void)
 	free_netdev(dev_82596);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif				/* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/8390.c working-2.6.9-bk6-obsolete-init_module/drivers/net/8390.c
--- linux-2.6.9-bk6/drivers/net/8390.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/8390.c	2004-10-22 14:02:01.000000000 +1000
@@ -1118,16 +1118,4 @@ EXPORT_SYMBOL(ei_tx_timeout);
 EXPORT_SYMBOL(NS8390_init);
 EXPORT_SYMBOL(__alloc_ei_netdev);
 
-#if defined(MODULE)
-
-int init_module(void)
-{
-	return 0;
-}
-
-void cleanup_module(void)
-{
-}
-
-#endif /* MODULE */
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ac3200.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ac3200.c
--- linux-2.6.9-bk6/drivers/net/ac3200.c	2004-09-28 16:22:06.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ac3200.c	2004-10-22 14:02:01.000000000 +1000
@@ -431,4 +431,7 @@ cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/apne.c working-2.6.9-bk6-obsolete-init_module/drivers/net/apne.c
--- linux-2.6.9-bk6/drivers/net/apne.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/apne.c	2004-10-22 14:02:01.000000000 +1000
@@ -590,6 +590,8 @@ void cleanup_module(void)
 	free_netdev(apne_dev);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
 static int init_pcmcia(void)
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/appletalk/cops.c working-2.6.9-bk6-obsolete-init_module/drivers/net/appletalk/cops.c
--- linux-2.6.9-bk6/drivers/net/appletalk/cops.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/appletalk/cops.c	2004-10-22 14:02:01.000000000 +1000
@@ -1048,6 +1048,9 @@ void cleanup_module(void)
 	cleanup_card(cops_dev);
 	free_netdev(cops_dev);
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/appletalk/ltpc.c working-2.6.9-bk6-obsolete-init_module/drivers/net/appletalk/ltpc.c
--- linux-2.6.9-bk6/drivers/net/appletalk/ltpc.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/appletalk/ltpc.c	2004-10-22 14:02:01.000000000 +1000
@@ -1263,7 +1263,7 @@ MODULE_PARM(irq, "i");
 MODULE_PARM(dma, "i");
 
 
-int __init init_module(void)
+static int __init init(void)
 {
         if(io == 0)
 		printk(KERN_NOTICE
@@ -1274,6 +1274,7 @@ int __init init_module(void)
 		return PTR_ERR(dev_ltpc);
 	return 0;
 }
+module_init(init);
 #endif
 
 static void __exit ltpc_cleanup(void)
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/arcnet/com20020.c working-2.6.9-bk6-obsolete-init_module/drivers/net/arcnet/com20020.c
--- linux-2.6.9-bk6/drivers/net/arcnet/com20020.c	2004-02-18 23:54:20.000000000 +1100
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/arcnet/com20020.c	2004-10-22 14:02:01.000000000 +1000
@@ -344,4 +344,6 @@ void cleanup_module(void)
 {
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif				/* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/at1700.c working-2.6.9-bk6-obsolete-init_module/drivers/net/at1700.c
--- linux-2.6.9-bk6/drivers/net/at1700.c	2004-10-22 07:56:51.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/at1700.c	2004-10-22 14:02:01.000000000 +1000
@@ -923,6 +923,8 @@ cleanup_module(void)
 	cleanup_card(dev_at1700);
 	free_netdev(dev_at1700);
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 MODULE_LICENSE("GPL");
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/atari_bionet.c working-2.6.9-bk6-obsolete-init_module/drivers/net/atari_bionet.c
--- linux-2.6.9-bk6/drivers/net/atari_bionet.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/atari_bionet.c	2004-10-22 14:02:01.000000000 +1000
@@ -661,6 +661,8 @@ void cleanup_module(void)
 	free_netdev(bio_dev);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /* Local variables:
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/atari_pamsnet.c working-2.6.9-bk6-obsolete-init_module/drivers/net/atari_pamsnet.c
--- linux-2.6.9-bk6/drivers/net/atari_pamsnet.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/atari_pamsnet.c	2004-10-22 14:02:01.000000000 +1000
@@ -882,6 +882,8 @@ void cleanup_module(void)
 	free_netdev(pam_dev);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /* Local variables:
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/atarilance.c working-2.6.9-bk6-obsolete-init_module/drivers/net/atarilance.c
--- linux-2.6.9-bk6/drivers/net/atarilance.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/atarilance.c	2004-10-22 14:02:01.000000000 +1000
@@ -1195,6 +1195,8 @@ void cleanup_module(void)
 	free_netdev(atarilance_dev);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/bagetlance.c working-2.6.9-bk6-obsolete-init_module/drivers/net/bagetlance.c
--- linux-2.6.9-bk6/drivers/net/bagetlance.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/bagetlance.c	2004-10-22 14:02:01.000000000 +1000
@@ -1358,6 +1358,8 @@ void cleanup_module(void)
 	free_netdev(bagetlance_dev);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/cs89x0.c working-2.6.9-bk6-obsolete-init_module/drivers/net/cs89x0.c
--- linux-2.6.9-bk6/drivers/net/cs89x0.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/cs89x0.c	2004-10-22 14:02:01.000000000 +1000
@@ -1853,6 +1853,9 @@ cleanup_module(void)
 	release_region(dev_cs89x0->base_addr, NETCARD_IO_EXTENT);
 	free_netdev(dev_cs89x0);
 }
+module_init(init_module);
+module_exit(cleanup_module);
+
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/de620.c working-2.6.9-bk6-obsolete-init_module/drivers/net/de620.c
--- linux-2.6.9-bk6/drivers/net/de620.c	2004-02-18 23:54:21.000000000 +1100
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/de620.c	2004-10-22 14:02:01.000000000 +1000
@@ -1026,6 +1026,9 @@ void cleanup_module(void)
 	release_region(de620_dev->base_addr, 3);
 	free_netdev(de620_dev);
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 MODULE_LICENSE("GPL");
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/e2100.c working-2.6.9-bk6-obsolete-init_module/drivers/net/e2100.c
--- linux-2.6.9-bk6/drivers/net/e2100.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/e2100.c	2004-10-22 14:02:01.000000000 +1000
@@ -474,4 +474,6 @@ cleanup_module(void)
 		}
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/eepro.c working-2.6.9-bk6-obsolete-init_module/drivers/net/eepro.c
--- linux-2.6.9-bk6/drivers/net/eepro.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/eepro.c	2004-10-22 14:02:01.000000000 +1000
@@ -1784,4 +1784,7 @@ cleanup_module(void)
 		free_netdev(dev);
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
+
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/eexpress.c working-2.6.9-bk6-obsolete-init_module/drivers/net/eexpress.c
--- linux-2.6.9-bk6/drivers/net/eexpress.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/eexpress.c	2004-10-22 14:02:01.000000000 +1000
@@ -1742,6 +1742,8 @@ void cleanup_module(void)
 		}
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/es3210.c working-2.6.9-bk6-obsolete-init_module/drivers/net/es3210.c
--- linux-2.6.9-bk6/drivers/net/es3210.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/es3210.c	2004-10-22 14:02:01.000000000 +1000
@@ -468,5 +468,8 @@ cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/eth16i.c working-2.6.9-bk6-obsolete-init_module/drivers/net/eth16i.c
--- linux-2.6.9-bk6/drivers/net/eth16i.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/eth16i.c	2004-10-22 14:02:01.000000000 +1000
@@ -1494,6 +1494,9 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/fmv18x.c working-2.6.9-bk6-obsolete-init_module/drivers/net/fmv18x.c
--- linux-2.6.9-bk6/drivers/net/fmv18x.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/fmv18x.c	2004-10-22 14:02:01.000000000 +1000
@@ -676,6 +676,9 @@ cleanup_module(void)
 	release_region(dev_fmv18x->base_addr, FMV18X_IO_EXTENT);
 	free_netdev(dev_fmv18x);
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/hp-plus.c working-2.6.9-bk6-obsolete-init_module/drivers/net/hp-plus.c
--- linux-2.6.9-bk6/drivers/net/hp-plus.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/hp-plus.c	2004-10-22 14:02:01.000000000 +1000
@@ -492,4 +492,6 @@ cleanup_module(void)
 		}
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/hp.c working-2.6.9-bk6-obsolete-init_module/drivers/net/hp.c
--- linux-2.6.9-bk6/drivers/net/hp.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/hp.c	2004-10-22 14:13:34.000000000 +1000
@@ -461,4 +461,6 @@ cleanup_module(void)
 		}
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/hplance.c working-2.6.9-bk6-obsolete-init_module/drivers/net/hplance.c
--- linux-2.6.9-bk6/drivers/net/hplance.c	2004-04-05 09:04:29.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/hplance.c	2004-10-22 14:02:01.000000000 +1000
@@ -239,4 +239,6 @@ void cleanup_module(void)
         }
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ibmlana.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ibmlana.c
--- linux-2.6.9-bk6/drivers/net/ibmlana.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ibmlana.c	2004-10-22 14:02:01.000000000 +1000
@@ -1081,4 +1081,7 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif				/* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/isa-skeleton.c working-2.6.9-bk6-obsolete-init_module/drivers/net/isa-skeleton.c
--- linux-2.6.9-bk6/drivers/net/isa-skeleton.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/isa-skeleton.c	2004-10-22 14:02:01.000000000 +1000
@@ -709,6 +709,8 @@ cleanup_module(void)
 	free_netdev(this_device);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/lance.c working-2.6.9-bk6-obsolete-init_module/drivers/net/lance.c
--- linux-2.6.9-bk6/drivers/net/lance.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/lance.c	2004-10-22 14:02:01.000000000 +1000
@@ -382,6 +382,8 @@ void cleanup_module(void)
 		}
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 MODULE_LICENSE("GPL");
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/lne390.c working-2.6.9-bk6-obsolete-init_module/drivers/net/lne390.c
--- linux-2.6.9-bk6/drivers/net/lne390.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/lne390.c	2004-10-22 14:02:01.000000000 +1000
@@ -464,5 +464,8 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/mac8390.c working-2.6.9-bk6-obsolete-init_module/drivers/net/mac8390.c
--- linux-2.6.9-bk6/drivers/net/mac8390.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/mac8390.c	2004-10-22 14:02:01.000000000 +1000
@@ -413,6 +413,8 @@ void cleanup_module(void)
 	}
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 static int __init mac8390_initdev(struct net_device * dev, struct nubus_dev * ndev,
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/mac89x0.c working-2.6.9-bk6-obsolete-init_module/drivers/net/mac89x0.c
--- linux-2.6.9-bk6/drivers/net/mac89x0.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/mac89x0.c	2004-10-22 14:02:01.000000000 +1000
@@ -652,6 +652,9 @@ cleanup_module(void)
 	nubus_writew(0, dev_cs89x0->base_addr + ADD_PORT);
 	free_netdev(dev_cs89x0);
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/macsonic.c working-2.6.9-bk6-obsolete-init_module/drivers/net/macsonic.c
--- linux-2.6.9-bk6/drivers/net/macsonic.c	2004-10-22 07:56:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/macsonic.c	2004-10-22 14:02:01.000000000 +1000
@@ -631,6 +631,8 @@ cleanup_module(void)
 	kfree(dev_macsonic->priv);
 	free_netdev(dev_macsonic);
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/mvme147.c working-2.6.9-bk6-obsolete-init_module/drivers/net/mvme147.c
--- linux-2.6.9-bk6/drivers/net/mvme147.c	2004-02-18 23:54:22.000000000 +1100
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/mvme147.c	2004-10-22 14:02:01.000000000 +1000
@@ -201,5 +201,6 @@ void cleanup_module(void)
 	free_pages(lp->ram, 3);
 	free_netdev(dev_mvme147_lance);
 }
-
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ne-h8300.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ne-h8300.c
--- linux-2.6.9-bk6/drivers/net/ne-h8300.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ne-h8300.c	2004-10-22 14:02:01.000000000 +1000
@@ -667,4 +667,7 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ne.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ne.c
--- linux-2.6.9-bk6/drivers/net/ne.c	2004-10-19 14:34:03.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ne.c	2004-10-22 14:02:01.000000000 +1000
@@ -859,4 +859,7 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ne2.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ne2.c
--- linux-2.6.9-bk6/drivers/net/ne2.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ne2.c	2004-10-22 14:02:01.000000000 +1000
@@ -826,4 +826,7 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ni5010.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ni5010.c
--- linux-2.6.9-bk6/drivers/net/ni5010.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ni5010.c	2004-10-22 14:02:01.000000000 +1000
@@ -799,6 +799,9 @@ void cleanup_module(void)
 	release_region(dev_ni5010->base_addr, NI5010_IO_EXTENT);
 	free_netdev(dev_ni5010);
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 MODULE_LICENSE("GPL");
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ni52.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ni52.c
--- linux-2.6.9-bk6/drivers/net/ni52.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ni52.c	2004-10-22 14:02:01.000000000 +1000
@@ -1341,6 +1341,8 @@ void cleanup_module(void)
 	release_region(dev_ni52->base_addr, NI52_TOTAL_SIZE);
 	free_netdev(dev_ni52);
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 #if 0
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/ni65.c working-2.6.9-bk6-obsolete-init_module/drivers/net/ni65.c
--- linux-2.6.9-bk6/drivers/net/ni65.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/ni65.c	2004-10-22 14:02:01.000000000 +1000
@@ -1269,6 +1269,9 @@ void cleanup_module(void)
  	cleanup_card(dev_ni65);
  	free_netdev(dev_ni65);
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/seeq8005.c working-2.6.9-bk6-obsolete-init_module/drivers/net/seeq8005.c
--- linux-2.6.9-bk6/drivers/net/seeq8005.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/seeq8005.c	2004-10-22 16:25:20.000000000 +1000
@@ -757,6 +757,8 @@ void cleanup_module(void)
 	free_netdev(dev_seeq);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/sk_mca.c working-2.6.9-bk6-obsolete-init_module/drivers/net/sk_mca.c
--- linux-2.6.9-bk6/drivers/net/sk_mca.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/sk_mca.c	2004-10-22 14:14:49.000000000 +1000
@@ -1221,4 +1221,7 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif				/* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/slhc.c working-2.6.9-bk6-obsolete-init_module/drivers/net/slhc.c
--- linux-2.6.9-bk6/drivers/net/slhc.c	2003-09-22 10:05:31.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/slhc.c	2004-10-22 14:04:53.000000000 +1000
@@ -68,6 +68,7 @@
 #include <linux/fcntl.h>
 #include <linux/inet.h>
 #include <linux/netdevice.h>
+#include <linux/init.h>
 #include <net/ip.h>
 #include <net/protocol.h>
 #include <net/icmp.h>
@@ -730,16 +731,18 @@ EXPORT_SYMBOL(slhc_toss);
 
 #ifdef MODULE
 
-int init_module(void)
+static int init(void)
 {
 	printk(KERN_INFO "CSLIP: code copyright 1989 Regents of the University of California\n");
 	return 0;
 }
 
-void cleanup_module(void)
+static void cleanup(void)
 {
 	return;
 }
+module_init(init);
+module_exit(cleanup);
 
 #endif /* MODULE */
 #else /* CONFIG_INET */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/smc-ultra.c working-2.6.9-bk6-obsolete-init_module/drivers/net/smc-ultra.c
--- linux-2.6.9-bk6/drivers/net/smc-ultra.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/smc-ultra.c	2004-10-22 14:15:00.000000000 +1000
@@ -608,4 +608,6 @@ cleanup_module(void)
 		}
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/smc-ultra32.c working-2.6.9-bk6-obsolete-init_module/drivers/net/smc-ultra32.c
--- linux-2.6.9-bk6/drivers/net/smc-ultra32.c	2004-09-28 16:22:07.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/smc-ultra32.c	2004-10-22 14:15:07.000000000 +1000
@@ -444,5 +444,8 @@ void cleanup_module(void)
 		}
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/smc9194.c working-2.6.9-bk6-obsolete-init_module/drivers/net/smc9194.c
--- linux-2.6.9-bk6/drivers/net/smc9194.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/smc9194.c	2004-10-22 14:15:14.000000000 +1000
@@ -1628,4 +1628,6 @@ void cleanup_module(void)
 	free_netdev(devSMC9194);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/sun3lance.c working-2.6.9-bk6-obsolete-init_module/drivers/net/sun3lance.c
--- linux-2.6.9-bk6/drivers/net/sun3lance.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/sun3lance.c	2004-10-22 14:15:37.000000000 +1000
@@ -961,5 +961,7 @@ void cleanup_module(void)
 	free_netdev(sun3lance_dev);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/tokenring/proteon.c working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/proteon.c
--- linux-2.6.9-bk6/drivers/net/tokenring/proteon.c	2004-04-05 09:04:30.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/proteon.c	2004-10-22 14:11:53.000000000 +1000
@@ -417,6 +417,8 @@ void cleanup_module(void)
 		free_netdev(dev);
 	}
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/tokenring/skisa.c working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/skisa.c
--- linux-2.6.9-bk6/drivers/net/tokenring/skisa.c	2004-04-05 09:04:30.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/skisa.c	2004-10-22 14:11:25.000000000 +1000
@@ -427,6 +427,9 @@ void cleanup_module(void)
 		free_netdev(dev);
 	}
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
 
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/tokenring/smctr.c working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/smctr.c
--- linux-2.6.9-bk6/drivers/net/tokenring/smctr.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/smctr.c	2004-10-22 14:11:14.000000000 +1000
@@ -5739,4 +5739,7 @@ void cleanup_module(void)
 		}
         }
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/tokenring/tms380tr.c working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/tms380tr.c
--- linux-2.6.9-bk6/drivers/net/tokenring/tms380tr.c	2004-10-22 07:56:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/tokenring/tms380tr.c	2004-10-22 14:11:06.000000000 +1000
@@ -2393,6 +2393,9 @@ void cleanup_module(void)
 {
 	TMS380_module = NULL;
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/wan/hostess_sv11.c working-2.6.9-bk6-obsolete-init_module/drivers/net/wan/hostess_sv11.c
--- linux-2.6.9-bk6/drivers/net/wan/hostess_sv11.c	2004-03-12 07:57:01.000000000 +1100
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/wan/hostess_sv11.c	2004-10-22 14:10:38.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/if_arp.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
+#include <linux/init.h>
 #include <net/arp.h>
 
 #include <asm/io.h>
@@ -416,5 +417,7 @@ void cleanup_module(void)
 		sv11_shutdown(sv11_unit);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/wan/sbni.c working-2.6.9-bk6-obsolete-init_module/drivers/net/wan/sbni.c
--- linux-2.6.9-bk6/drivers/net/wan/sbni.c	2004-10-22 07:56:54.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/wan/sbni.c	2004-10-22 14:12:13.000000000 +1000
@@ -1541,6 +1541,8 @@ cleanup_module( void )
 		}
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #else	/* MODULE */
 
 static int __init
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/wd.c working-2.6.9-bk6-obsolete-init_module/drivers/net/wd.c
--- linux-2.6.9-bk6/drivers/net/wd.c	2004-09-28 16:22:08.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/wd.c	2004-10-22 14:02:01.000000000 +1000
@@ -500,8 +500,8 @@ MODULE_LICENSE("GPL");
 
 /* This is set up so that only a single autoprobe takes place per call.
 ISA device autoprobes on a running machine are not recommended. */
-int
-init_module(void)
+static int
+init(void)
 {
 	struct net_device *dev;
 	int this_dev, found = 0;
@@ -534,8 +534,8 @@ init_module(void)
 	return -ENXIO;
 }
 
-void
-cleanup_module(void)
+static void
+cleanup(void)
 {
 	int this_dev;
 
@@ -548,4 +548,6 @@ cleanup_module(void)
 		}
 	}
 }
+module_init(init);
+module_exit(cleanup);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/wireless/arlan-main.c working-2.6.9-bk6-obsolete-init_module/drivers/net/wireless/arlan-main.c
--- linux-2.6.9-bk6/drivers/net/wireless/arlan-main.c	2004-04-05 09:04:31.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/wireless/arlan-main.c	2004-10-22 14:12:25.000000000 +1000
@@ -1894,6 +1894,7 @@ void cleanup_module(void)
 	ARLAN_DEBUG_EXIT("cleanup_module");
 }
 
-
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/net/wireless/wavelan.c working-2.6.9-bk6-obsolete-init_module/drivers/net/wireless/wavelan.c
--- linux-2.6.9-bk6/drivers/net/wireless/wavelan.c	2004-10-22 07:56:54.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/net/wireless/wavelan.c	2004-10-22 14:12:46.000000000 +1000
@@ -4404,6 +4404,9 @@ void cleanup_module(void)
 	printk(KERN_DEBUG "<- cleanup_module()\n");
 #endif
 }
+
+module_init(init_module);
+module_exit(cleanup_module);
 #endif				/* MODULE */
 MODULE_LICENSE("GPL");
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/sbus/char/vfc_dev.c working-2.6.9-bk6-obsolete-init_module/drivers/sbus/char/vfc_dev.c
--- linux-2.6.9-bk6/drivers/sbus/char/vfc_dev.c	2004-09-28 16:22:08.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/sbus/char/vfc_dev.c	2004-10-22 14:02:01.000000000 +1000
@@ -702,11 +702,7 @@ static int vfc_probe(void)
 	return 0;
 }
 
-#ifdef MODULE
-int init_module(void)
-#else 
 int vfc_init(void)
-#endif
 {
 	return vfc_probe();
 }
@@ -721,7 +717,7 @@ static void deinit_vfc_device(struct vfc
 	kfree(dev);
 }
 
-void cleanup_module(void)
+void __exit vfc_cleanup(void)
 {
 	struct vfc_dev **devp;
 
@@ -734,6 +730,9 @@ void cleanup_module(void)
 	kfree(vfc_dev_lst);
 	return;
 }
+
+module_init(vfc_init);
+module_exit(vfc_cleanup);
 #endif
 
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/scsi/NCR53C9x.c working-2.6.9-bk6-obsolete-init_module/drivers/scsi/NCR53C9x.c
--- linux-2.6.9-bk6/drivers/scsi/NCR53C9x.c	2004-10-19 14:34:08.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/scsi/NCR53C9x.c	2004-10-22 14:02:01.000000000 +1000
@@ -3637,8 +3637,6 @@ void esp_slave_destroy(Scsi_Device *SDpt
 }
 
 #ifdef MODULE
-int init_module(void) { return 0; }
-void cleanup_module(void) {}
 void esp_release(void)
 {
 	esps_in_use--;
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/serial/dz.h working-2.6.9-bk6-obsolete-init_module/drivers/serial/dz.h
--- linux-2.6.9-bk6/drivers/serial/dz.h	2004-03-12 07:57:09.000000000 +1100
+++ working-2.6.9-bk6-obsolete-init_module/drivers/serial/dz.h	2004-10-22 14:15:49.000000000 +1000
@@ -110,9 +110,4 @@
 #define DZ_XMIT_SIZE   4096                 /* buffer size */
 #define DZ_WAKEUP_CHARS   DZ_XMIT_SIZE/4
 
-#ifdef MODULE
-int init_module (void)
-void cleanup_module (void)
-#endif
-
 #endif /* DZ_SERIAL_H */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/atafb.c working-2.6.9-bk6-obsolete-init_module/drivers/video/atafb.c
--- linux-2.6.9-bk6/drivers/video/atafb.c	2004-06-17 08:48:48.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/atafb.c	2004-10-22 14:02:01.000000000 +1000
@@ -3091,8 +3091,5 @@ int __init atafb_setup( char *options )
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	return atafb_init();
-}
+module_init(atafb_init);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/aty/atyfb_base.c working-2.6.9-bk6-obsolete-init_module/drivers/video/aty/atyfb_base.c
--- linux-2.6.9-bk6/drivers/video/aty/atyfb_base.c	2004-10-22 07:57:00.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/aty/atyfb_base.c	2004-10-22 14:16:08.000000000 +1000
@@ -2633,5 +2633,7 @@ void cleanup_module(void)
 	kfree(info);
 }
 
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 MODULE_LICENSE("GPL");
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/controlfb.c working-2.6.9-bk6-obsolete-init_module/drivers/video/controlfb.c
--- linux-2.6.9-bk6/drivers/video/controlfb.c	2004-10-19 14:34:11.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/controlfb.c	2004-10-22 14:16:38.000000000 +1000
@@ -200,6 +200,8 @@ void cleanup_module(void)
 {
 	control_cleanup();
 }
+module_init(init_module);
+module_exit(cleanup_module);
 #endif
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/cyberfb.c working-2.6.9-bk6-obsolete-init_module/drivers/video/cyberfb.c
--- linux-2.6.9-bk6/drivers/video/cyberfb.c	2004-06-17 08:48:49.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/cyberfb.c	2004-10-22 14:02:01.000000000 +1000
@@ -1201,10 +1201,7 @@ static struct display_switch fbcon_cyber
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	return cyberfb_init();
-}
+module_init(cyberfb_init);
 #endif /* MODULE */
 
 /*
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/matrox/matroxfb_base.c working-2.6.9-bk6-obsolete-init_module/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-bk6/drivers/video/matrox/matroxfb_base.c	2004-10-22 07:57:00.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/matrox/matroxfb_base.c	2004-10-22 14:16:20.000000000 +1000
@@ -2562,6 +2562,8 @@ int __init init_module(void){
 	/* never return failure; user can hotplug matrox later... */
 	return 0;
 }
+
+module_init(init_module);
 #endif	/* MODULE */
 
 module_exit(matrox_done);
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/pm3fb.c working-2.6.9-bk6-obsolete-init_module/drivers/video/pm3fb.c
--- linux-2.6.9-bk6/drivers/video/pm3fb.c	2003-10-09 18:02:57.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/pm3fb.c	2004-10-22 14:02:01.000000000 +1000
@@ -3784,7 +3784,7 @@ void pm3fb_build_options(void)
 	DPRINTK(1, "pm3fb use options: %s\n", g_options);
 }
 
-int init_module(void)
+static int init(void)
 {
 	DTRACE;
 
@@ -3795,7 +3795,7 @@ int init_module(void)
 	return (0);
 }
 
-void cleanup_module(void)
+static void cleanup(void)
 {
 	DTRACE;
 	{
@@ -3824,4 +3824,7 @@ void cleanup_module(void)
 	}
 	return;
 }
+
+module_init(init);
+module_exit(cleanup);
 #endif /* MODULE */
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/retz3fb.c working-2.6.9-bk6-obsolete-init_module/drivers/video/retz3fb.c
--- linux-2.6.9-bk6/drivers/video/retz3fb.c	2004-06-17 08:48:50.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/retz3fb.c	2004-10-22 14:02:01.000000000 +1000
@@ -1485,10 +1485,7 @@ static int __init get_video_mode(const c
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	return retz3fb_init();
-}
+module_init(retz3fb_init);
 #endif
 
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/vgastate.c working-2.6.9-bk6-obsolete-init_module/drivers/video/vgastate.c
--- linux-2.6.9-bk6/drivers/video/vgastate.c	2004-10-19 14:34:12.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/vgastate.c	2004-10-22 14:02:01.000000000 +1000
@@ -490,11 +490,6 @@ int restore_vga (struct vgastate *state)
 	return 0;
 }
 
-#ifdef MODULE
-int init_module(void) { return 0; };
-void cleanup_module(void) {};
-#endif
-
 EXPORT_SYMBOL(save_vga);
 EXPORT_SYMBOL(restore_vga);
 
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/drivers/video/virgefb.c working-2.6.9-bk6-obsolete-init_module/drivers/video/virgefb.c
--- linux-2.6.9-bk6/drivers/video/virgefb.c	2004-06-17 08:48:52.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/drivers/video/virgefb.c	2004-10-22 14:02:01.000000000 +1000
@@ -2059,10 +2059,7 @@ static struct display_switch fbcon_virge
 #ifdef MODULE
 MODULE_LICENSE("GPL");
 
-int init_module(void)
-{
-	return virgefb_init();
-}
+module_init(virgefb_init);
 #endif /* MODULE */
 
 static int cv3d_has_4mb(void)
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/fs/jffs2/comprtest.c working-2.6.9-bk6-obsolete-init_module/fs/jffs2/comprtest.c
--- linux-2.6.9-bk6/fs/jffs2/comprtest.c	2003-09-21 17:22:53.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/fs/jffs2/comprtest.c	2004-10-22 14:02:01.000000000 +1000
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/module.h>
+#include <linux/init.h>
 #include <asm/types.h>
 #if 0
 #define TESTDATA_LEN 512
@@ -270,7 +271,7 @@ int jffs2_decompress(unsigned char compr
 unsigned char jffs2_compress(unsigned char *data_in, unsigned char *cpage_out, 
 			     uint32_t *datalen, uint32_t *cdatalen);
 
-int init_module(void ) {
+static int init(void) {
 	unsigned char comprtype;
 	uint32_t c, d;
 	int ret;
@@ -305,3 +306,4 @@ int init_module(void ) {
 		printk("Compression good for %d bytes\n", d);
 	return 1;
 }
+module_init(init);
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/net/wanrouter/af_wanpipe.c working-2.6.9-bk6-obsolete-init_module/net/wanrouter/af_wanpipe.c
--- linux-2.6.9-bk6/net/wanrouter/af_wanpipe.c	2004-10-19 14:34:27.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/net/wanrouter/af_wanpipe.c	2004-10-22 14:02:01.000000000 +1000
@@ -2570,7 +2570,7 @@ struct notifier_block wanpipe_netdev_not
 
 
 #ifdef MODULE
-void cleanup_module(void)
+static void cleanup(void)
 {
 	printk(KERN_INFO "wansock: Cleaning up \n");
 	unregister_netdevice_notifier(&wanpipe_netdev_notifier);
@@ -2579,7 +2579,7 @@ void cleanup_module(void)
 }
 
 
-int init_module(void)
+static int init(void)
 {
 
 	printk(KERN_INFO "wansock: Registering Socket \n");
@@ -2587,6 +2587,8 @@ int init_module(void)
 	register_netdevice_notifier(&wanpipe_netdev_notifier);
 	return 0;
 }
+module_init(init);
+module_exit(cleanup);
 #endif
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_WANPIPE);
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/sound/oss/msnd.c working-2.6.9-bk6-obsolete-init_module/sound/oss/msnd.c
--- linux-2.6.9-bk6/sound/oss/msnd.c	2004-10-19 14:34:31.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/sound/oss/msnd.c	2004-10-22 14:02:01.000000000 +1000
@@ -363,14 +363,4 @@ EXPORT_SYMBOL(msnd_disable_irq);
 MODULE_AUTHOR				("Andrew Veliath <andrewtv@usa.net>");
 MODULE_DESCRIPTION			("Turtle Beach MultiSound Driver Base");
 MODULE_LICENSE("GPL");
-
-
-int init_module(void)
-{
-	return 0;
-}
-
-void cleanup_module(void)
-{
-}
 #endif
diff -urp --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff linux-2.6.9-bk6/sound/oss/skeleton.c working-2.6.9-bk6-obsolete-init_module/sound/oss/skeleton.c
--- linux-2.6.9-bk6/sound/oss/skeleton.c	2003-09-22 10:27:47.000000000 +1000
+++ working-2.6.9-bk6-obsolete-init_module/sound/oss/skeleton.c	2004-10-22 14:02:01.000000000 +1000
@@ -18,6 +18,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
@@ -181,7 +182,7 @@ int init_mycard(void)
  */
 
 
-int init_module(void)
+static int init(void)
 {
 	if(init_mycard()<0)
 	{
@@ -197,7 +198,7 @@ int init_module(void)
  *	when its use count is 0.
  */
  
-void cleanup_module(void)
+static void cleanup(void)
 {
 	for(i=0;i< cards; i++)
 	{
@@ -217,3 +218,5 @@ void cleanup_module(void)
 	}
 }
 
+module_init(init);
+module_exit(cleanup);

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

