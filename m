Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTITN3P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 09:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbTITN3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 09:29:15 -0400
Received: from verein.lst.de ([212.34.189.10]:59777 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261881AbTITN3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 09:29:04 -0400
Date: Sat, 20 Sep 2003 15:29:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] move some more intilization out of drivers/char/mem.c
Message-ID: <20030920132900.GC23153@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

keeping init order the same..

--- 1.58/drivers/char/Makefile	Sat Jun  7 15:41:09 2003
+++ edited/drivers/char/Makefile	Sat Sep 20 13:13:49 2003
@@ -7,7 +7,7 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o
+obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o
 
 obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
--- 1.43/drivers/char/mem.c	Tue Aug 26 18:25:41 2003
+++ edited/drivers/char/mem.c	Sat Sep 20 13:12:30 2003
@@ -680,17 +680,8 @@
 				S_IFCHR | devlist[i].mode, devlist[i].name);
 	}
 	
-	rand_initialize();
 #if defined (CONFIG_FB)
 	fbmem_init();
-#endif
-	tty_init();
-#ifdef CONFIG_M68K_PRINTER
-	lp_m68k_init();
-#endif
-	misc_init();
-#ifdef CONFIG_FTAPE
-	ftape_init();
 #endif
 	return 0;
 }
--- 1.23/drivers/char/misc.c	Wed Sep 17 15:42:51 2003
+++ edited/drivers/char/misc.c	Sat Sep 20 13:12:30 2003
@@ -277,7 +277,7 @@
 EXPORT_SYMBOL(misc_register);
 EXPORT_SYMBOL(misc_deregister);
 
-int __init misc_init(void)
+static int __init misc_init(void)
 {
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *ent;
@@ -320,3 +320,4 @@
 	}
 	return 0;
 }
+module_init(misc_init);
--- 1.38/drivers/char/random.c	Wed Sep 10 08:41:47 2003
+++ edited/drivers/char/random.c	Sat Sep 20 13:12:30 2003
@@ -1493,7 +1493,7 @@
 	}
 }
 
-void __init rand_initialize(void)
+static void __init rand_initialize(void)
 {
 	int i;
 
@@ -1516,6 +1516,7 @@
 	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
 	extract_timer_state.dont_count_entropy = 1;
 }
+module_init(rand_initialize);
 
 void rand_initialize_irq(int irq)
 {
--- 1.119/drivers/char/tty_io.c	Fri Sep  5 13:31:50 2003
+++ edited/drivers/char/tty_io.c	Sat Sep 20 13:12:30 2003
@@ -2423,7 +2423,7 @@
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
-void __init tty_init(void)
+static void __init tty_init(void)
 {
 	strcpy(tty_cdev.kobj.name, "dev.tty");
 	cdev_init(&tty_cdev, &tty_fops);
@@ -2513,3 +2513,4 @@
 	a2232board_init();
 #endif
 }
+module_init(tty_init);
--- 1.4/drivers/char/ftape/lowlevel/ftape-init.c	Mon Feb  3 21:19:37 2003
+++ edited/drivers/char/ftape/lowlevel/ftape-init.c	Sat Sep 20 13:12:30 2003
@@ -55,14 +55,24 @@
 char ft_dat[] __initdata = "$Date: 1997/11/06 00:38:08 $";
 
 
+#ifndef CONFIG_FT_NO_TRACE_AT_ALL
+static int ft_tracing = -1;
+#endif
+
+
 /*  Called by modules package when installing the driver
  *  or by kernel during the initialization phase
  */
-int __init ftape_init(void)
+static int __init ftape_init(void)
 {
 	TRACE_FUN(ft_t_flow);
 
 #ifdef MODULE
+#ifndef CONFIG_FT_NO_TRACE_AT_ALL
+	if (ft_tracing != -1) {
+		ftape_tracing = ft_tracing;
+	}
+#endif
 	printk(KERN_INFO FTAPE_VERSION "\n");
         if (TRACE_LEVEL >= ft_t_info) {
 		printk(
@@ -112,13 +122,6 @@
 #endif
 	TRACE_EXIT 0;
 }
-
-#ifdef MODULE
-
-#ifndef CONFIG_FT_NO_TRACE_AT_ALL
-static int ft_tracing = -1;
-#endif
-
 #define FT_MOD_PARM(var,type,desc) \
 	MODULE_PARM(var,type); MODULE_PARM_DESC(var,desc)
 
@@ -141,21 +144,7 @@
 	"QIC-117 driver for QIC-40/80/3010/3020 floppy tape drives.");
 MODULE_LICENSE("GPL");
 
-/*  Called by modules package when installing the driver
- */
-int init_module(void)
-{
-#ifndef CONFIG_FT_NO_TRACE_AT_ALL
-	if (ft_tracing != -1) {
-		ftape_tracing = ft_tracing;
-	}
-#endif
-	return ftape_init();
-}
-
-/*  Called by modules package when removing the driver
- */
-void cleanup_module(void)
+static void __exit ftape_exit(void)
 {
 	TRACE_FUN(ft_t_flow);
 
@@ -167,3 +156,6 @@
 	TRACE_EXIT;
 }
 #endif /* MODULE */
+
+module_init(ftape_init);
+module_exit(ftape_exit);
