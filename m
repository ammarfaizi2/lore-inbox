Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271678AbTGRCBV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 22:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271680AbTGRCBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 22:01:21 -0400
Received: from dp.samba.org ([66.70.73.150]:28806 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271678AbTGRCBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 22:01:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re-xmit: Delete init/cleanup_module prototypes in obscure places.
Date: Fri, 18 Jul 2003 12:04:45 +1000
Message-Id: <20030718021559.189E52C729@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply.

The prototype is already in init.h.  And this blocks us from
implementation later changes (declaring functions by these names and
having them magically called in the deprecated 2.2 interface).

Name: Delete redundant init_module and cleanup_module prototypes.
Author: Rusty Russell
Status: Trivial

D: A few places pre-declare "int module_init(void);" and "void
D: module_cleanup(void);".  Other than being obsolete, this is
D: unneccessary (it's in init.h anyway).
D: 
D: There are still about 100 places which still use the
D: obsolete-since-2.2 "a function named module_init() magically gets
D: called": this change frees us up implement that via a macro.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/block/paride/pf.c .11903-linux-2.5.73-bk1.updated/drivers/block/paride/pf.c
--- .11903-linux-2.5.73-bk1/drivers/block/paride/pf.c	2003-05-05 12:36:58.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/block/paride/pf.c	2003-06-24 11:43:58.000000000 +1000
@@ -222,9 +222,6 @@ MODULE_PARM(drive3, "1-7i");
 #define ATAPI_READ_10		0x28
 #define ATAPI_WRITE_10		0x2a
 
-#ifdef MODULE
-void cleanup_module(void);
-#endif
 static int pf_open(struct inode *inode, struct file *file);
 static void do_pf_request(request_queue_t * q);
 static int pf_ioctl(struct inode *inode, struct file *file,
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/istallion.c .11903-linux-2.5.73-bk1.updated/drivers/char/istallion.c
--- .11903-linux-2.5.73-bk1/drivers/char/istallion.c	2003-06-15 11:29:51.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/istallion.c	2003-06-24 11:43:58.000000000 +1000
@@ -650,8 +650,6 @@ static unsigned int	stli_baudrates[] = {
  */
 
 #ifdef MODULE
-int		init_module(void);
-void		cleanup_module(void);
 static void	stli_argbrds(void);
 static int	stli_parsebrd(stlconf_t *confp, char **argp);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/moxa.c .11903-linux-2.5.73-bk1.updated/drivers/char/moxa.c
--- .11903-linux-2.5.73-bk1/drivers/char/moxa.c	2003-06-23 10:52:46.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/moxa.c	2003-06-24 11:43:58.000000000 +1000
@@ -216,10 +216,7 @@ static struct timer_list moxaEmptyTimer[
 static struct semaphore moxaBuffSem;
 
 int moxa_init(void);
-#ifdef MODULE
-int init_module(void);
-void cleanup_module(void);
-#endif
+
 /*
  * static functions:
  */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/nwbutton.h .11903-linux-2.5.73-bk1.updated/drivers/char/nwbutton.h
--- .11903-linux-2.5.73-bk1/drivers/char/nwbutton.h	2003-05-27 15:02:08.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/nwbutton.h	2003-06-24 11:43:58.000000000 +1000
@@ -32,10 +32,6 @@ int button_init (void);
 int button_add_callback (void (*callback) (void), int count);
 int button_del_callback (void (*callback) (void));
 static void button_consume_callbacks (int bpcount);
-#ifdef MODULE
-int init_module (void);
-void cleanup_module (void);
-#endif /* MODULE */
 
 #else /* Not compiling the driver itself */
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/pcxx.c .11903-linux-2.5.73-bk1.updated/drivers/char/pcxx.c
--- .11903-linux-2.5.73-bk1/drivers/char/pcxx.c	2003-06-15 11:29:51.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/pcxx.c	2003-06-24 11:50:28.000000000 +1000
@@ -209,17 +209,9 @@ static void cleanup_board_resources(void
 
 #ifdef MODULE
 
-/*
- * pcxe_init() is our init_module():
- */
-#define pcxe_init init_module
-
-void	cleanup_module(void);
-
-
 /*****************************************************************************/
 
-void cleanup_module()
+static void pcxe_cleanup()
 {
 
 	unsigned long	flags;
@@ -240,6 +232,12 @@ void cleanup_module()
 	kfree(digi_channels);
 	restore_flags(flags);
 }
+
+/*
+ * pcxe_init() is our init_module():
+ */
+module_init(pcxe_init);
+module_cleanup(pcxe_cleanup);
 #endif
 
 static inline struct channel *chan(register struct tty_struct *tty)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/char/stallion.c .11903-linux-2.5.73-bk1.updated/drivers/char/stallion.c
--- .11903-linux-2.5.73-bk1/drivers/char/stallion.c	2003-06-15 11:29:52.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/char/stallion.c	2003-06-24 11:43:58.000000000 +1000
@@ -472,8 +472,6 @@ static unsigned int	stl_baudrates[] = {
  */
 
 #ifdef MODULE
-int		init_module(void);
-void		cleanup_module(void);
 static void	stl_argbrds(void);
 static int	stl_parsebrd(stlconf_t *confp, char **argp);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/net/wan/sdladrv.c .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdladrv.c
--- .11903-linux-2.5.73-bk1/drivers/net/wan/sdladrv.c	2003-06-15 11:29:56.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdladrv.c	2003-06-24 11:43:58.000000000 +1000
@@ -160,10 +160,6 @@
 
 /****** Function Prototypes *************************************************/
 
-/* Module entry points. These are called by the OS and must be public. */
-int init_module (void);
-void cleanup_module (void);
-
 /* Hardware-specific functions */
 static int sdla_detect	(sdlahw_t* hw);
 static int sdla_autodpm	(sdlahw_t* hw);
@@ -325,11 +321,7 @@ static int pci_slot_ar[MAX_S514_CARDS];
  * Context:	process
  */
 
-#ifdef MODULE
-int init_module (void)
-#else
 int sdladrv_init(void)
-#endif
 {
 	int i=0;
 
@@ -354,9 +346,12 @@ int sdladrv_init(void)
  * Module 'remove' entry point.
  * o release all remaining system resources
  */
-void cleanup_module (void)
+static void sdladrv_cleanup(void)
 {
 }
+
+module_init(sdladrv_init);
+module_cleanup(sdladrv_cleanup);
 #endif
 
 /******* Kernel APIs ********************************************************/
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11903-linux-2.5.73-bk1/drivers/net/wan/sdlamain.c .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdlamain.c
--- .11903-linux-2.5.73-bk1/drivers/net/wan/sdlamain.c	2003-05-27 15:02:12.000000000 +1000
+++ .11903-linux-2.5.73-bk1.updated/drivers/net/wan/sdlamain.c	2003-06-24 11:43:58.000000000 +1000
@@ -177,10 +177,6 @@ static void dbg_kfree(void * v, int line
 extern void disable_irq(unsigned int);
 extern void enable_irq(unsigned int);
  
-/* Module entry points */
-int init_module (void);
-void cleanup_module (void);
-
 /* WAN link driver entry points */
 static int setup(struct wan_device* wandev, wandev_conf_t* conf);
 static int shutdown(struct wan_device* wandev);
@@ -246,11 +242,7 @@ static int wanpipe_bh_critical=0;
  * Context:	process
  */
  
-#ifdef MODULE
-int init_module (void)
-#else
 int wanpipe_init(void)
-#endif
 {
 	int cnt, err = 0;
 
@@ -313,7 +305,7 @@ int wanpipe_init(void)
  * o unregister all adapters from the WAN router
  * o release all remaining system resources
  */
-void cleanup_module (void)
+static void wanpipe_cleanup(void)
 {
 	int i;
 
@@ -329,6 +321,8 @@ void cleanup_module (void)
 	printk(KERN_INFO "\nwanpipe: WANPIPE Modules Unloaded.\n");
 }
 
+module_init(wanpipe_init);
+module_exit(wanpipe_cleanup);
 #endif
 
 /******* WAN Device Driver Entry Points *************************************/


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
