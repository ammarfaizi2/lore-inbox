Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263665AbTFHSaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 14:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTFHSaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 14:30:18 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:6 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263665AbTFHSaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 14:30:05 -0400
Date: Sun, 8 Jun 2003 19:43:35 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>, greg@kroah.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix character subsystem initialisation panic
Message-ID: <20030608194335.A11163@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Bottomley <James.Bottomley@steeleye.com>,
	torvalds@transmeta.com, Andrew Morton <akpm@digeo.com>,
	greg@kroah.com, Linux Kernel <linux-kernel@vger.kernel.org>
References: <1055093727.1982.17.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1055093727.1982.17.camel@mulgrave>; from James.Bottomley@steeleye.com on Sun, Jun 08, 2003 at 12:35:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 08, 2003 at 12:35:25PM -0500, James Bottomley wrote:
> In 2.5.70 bk latest, I'm getting a panic related to character device
> initialisation.  The problem seems to be that the new sysfs entries for
> character devices require that everything now have a properly
> initialised parent.  However, the character subsystem is set up in
> drivers/char/mem.c as
> 
> __initcall(chr_dev_init);
> 
> However, __initcall() is the same priority as module_init(), so whether
> character devices are initialised before their required subsystem
> depends purely on link ordering (on parisc, we initialise devices/parisc
> before everything else, so it is panicing reliably with this).
> 
> I think the fix is to convert the __initcall to subsys_initcall (patch
> attached).  The patch allows parisc to boot properly now.

This means that all the drivers initialized from chr_dev_init are
also at subsystem level now which doesn't seem to break something
(yet) but still is v ery confusing.  This patch converts all of
them (except fbmem_init which is in a different directory so
we could get link order problems) to module_init.


--- 1.40/drivers/char/mem.c	Sun Jun  8 14:02:24 2003
+++ edited/drivers/char/mem.c	Sat Jun  7 22:30:30 2003
@@ -698,17 +698,8 @@
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
--- 1.20/drivers/char/misc.c	Sat May 17 21:39:13 2003
+++ edited/drivers/char/misc.c	Sat Jun  7 22:25:37 2003
@@ -244,7 +244,7 @@
 EXPORT_SYMBOL(misc_register);
 EXPORT_SYMBOL(misc_deregister);
 
-int __init misc_init(void)
+static int __init misc_init(void)
 {
 	create_proc_read_entry("misc", 0, 0, misc_read_proc, NULL);
 #ifdef CONFIG_MVME16x
@@ -281,3 +281,4 @@
 	}
 	return 0;
 }
+module_init(misc_init);
--- 1.33/drivers/char/random.c	Mon May  5 07:49:54 2003
+++ edited/drivers/char/random.c	Sat Jun  7 22:23:12 2003
@@ -1420,7 +1420,7 @@
 	}
 }
 
-void __init rand_initialize(void)
+static void __init rand_initialize(void)
 {
 	int i;
 
@@ -1443,6 +1443,7 @@
 	memset(&extract_timer_state, 0, sizeof(struct timer_rand_state));
 	extract_timer_state.dont_count_entropy = 1;
 }
+module_init(rand_initialize);
 
 void rand_initialize_irq(int irq)
 {
--- 1.106/drivers/char/tty_io.c	Fri Jun  6 08:36:47 2003
+++ edited/drivers/char/tty_io.c	Sat Jun  7 22:31:23 2003
@@ -2364,7 +2364,7 @@
  * Ok, now we can initialize the rest of the tty devices and can count
  * on memory allocations, interrupts etc..
  */
-void __init tty_init(void)
+static void __init tty_init(void)
 {
 	strcpy(tty_cdev.kobj.name, "dev.tty");
 	cdev_init(&tty_cdev, &tty_fops);
@@ -2454,3 +2454,4 @@
 	a2232board_init();
 #endif
 }
+module_init(tty_init);
--- 1.4/drivers/char/ftape/lowlevel/ftape-init.c	Mon Feb  3 21:19:37 2003
+++ edited/drivers/char/ftape/lowlevel/ftape-init.c	Sat Jun  7 22:28:33 2003
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
--- 1.3/include/linux/ftape.h	Tue Apr  1 01:55:26 2003
+++ edited/include/linux/ftape.h	Sat Jun  7 22:26:34 2003
@@ -199,8 +199,6 @@
 #define ABS(a)          ((a) < 0 ? -(a) : (a))
 #define NR_ITEMS(x)     (int)(sizeof(x)/ sizeof(*x))
 
-extern int ftape_init(void);
-
 #endif  /* __KERNEL__ */
 
 #endif
--- 1.7/include/linux/miscdevice.h	Mon Apr 21 01:21:19 2003
+++ edited/include/linux/miscdevice.h	Sat Jun  7 22:26:22 2003
@@ -34,8 +34,6 @@
 
 #define TUN_MINOR	     200
 
-extern int misc_init(void);
-
 struct miscdevice 
 {
 	int minor;
--- 1.2/include/linux/random.h	Mon Oct 28 20:57:55 2002
+++ edited/include/linux/random.h	Sat Jun  7 22:24:29 2003
@@ -42,7 +42,6 @@
 
 #ifdef __KERNEL__
 
-extern void rand_initialize(void);
 extern void rand_initialize_irq(int irq);
 
 extern void batch_entropy_store(u32 a, u32 b, int num);
--- 1.18/include/linux/tty.h	Mon May 26 08:19:13 2003
+++ edited/include/linux/tty.h	Sat Jun  7 22:24:19 2003
@@ -351,7 +351,6 @@
 
 extern int lp_init(void);
 extern int pty_init(void);
-extern void tty_init(void);
 extern int mxser_init(void);
 extern int moxa_init(void);
 extern int ip2_init(void);
