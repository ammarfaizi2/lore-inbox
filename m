Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265200AbSJaHKu>; Thu, 31 Oct 2002 02:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265202AbSJaHKu>; Thu, 31 Oct 2002 02:10:50 -0500
Received: from dp.samba.org ([66.70.73.150]:41381 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265200AbSJaHKs>;
	Thu, 31 Oct 2002 02:10:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] Module rewrite series 2/5: Obsolete init_module
In-reply-to: Your message of "Thu, 31 Oct 2002 17:39:57 +1100."
             <20021031064316.D9F5D2C0E1@lists.samba.org> 
Date: Thu, 31 Oct 2002 17:52:05 +1100
Message-Id: <20021031071714.6338D2C058@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People seemed to cheer this change generally.  If you use the old
"init_module" style you need to have a separate init routing for
non-modular anyway, which is horribly icky.

Name: init_module removal
Author: Rusty Russell
Status: Trivial

D: Modules in 2.4 can simply name functions init_module() and
D: cleanup_module(), and they will be called at module load and
D: unload.  The preferred way is to use module_init(funcname) and
D: module_exit(funcname), and this is the only way once the
D: in-kernel-module loader is included.
D:
D: This is not all of them, just some examples (the ones I needed to
D: successfully compile).

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.35/drivers/net/ethertap.c working-2.5.35-modbase-try-i386/drivers/net/ethertap.c
--- linux-2.5.35/drivers/net/ethertap.c	Fri May 24 15:20:21 2002
+++ working-2.5.35-modbase-try-i386/drivers/net/ethertap.c	Tue Sep 17 18:50:15 2002
@@ -346,7 +346,7 @@ static struct net_device dev_ethertap =
 	0, 0, 0, NULL, ethertap_probe
 };
 
-int init_module(void)
+static int init(void)
 {
 	dev_ethertap.base_addr=unit+NETLINK_TAPBASE;
 	sprintf(dev_ethertap.name,"tap%d",unit);
@@ -360,7 +360,7 @@ int init_module(void)
 	return 0;
 }
 
-void cleanup_module(void)
+static void cleanup(void)
 {
 	tap_map[dev_ethertap.base_addr]=NULL;
 	unregister_netdev(&dev_ethertap);
@@ -372,6 +372,10 @@ void cleanup_module(void)
 	kfree(dev_ethertap.priv);
 	dev_ethertap.priv = NULL;	/* gets re-allocated by ethertap_probe */
 }
+
+/* FIXME: Remove Space.c hardcoded crap --RR */
+module_init(init);
+module_exit(cleanup);
 
 #endif /* MODULE */
 MODULE_LICENSE("GPL");
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.35/drivers/net/slhc.c working-2.5.35-modbase-try-i386/drivers/net/slhc.c
--- linux-2.5.35/drivers/net/slhc.c	Sat Nov 10 12:52:24 2001
+++ working-2.5.35-modbase-try-i386/drivers/net/slhc.c	Tue Sep 17 18:54:16 2002
@@ -735,17 +735,20 @@ EXPORT_SYMBOL(slhc_toss);
 
 #ifdef MODULE
 
-int init_module(void)
+static int init(void)
 {
 	printk(KERN_INFO "CSLIP: code copyright 1989 Regents of the University of California\n");
 	return 0;
 }
 
-void cleanup_module(void)
+static void fini(void)
 {
 	return;
 }
 
+/* FIXME: Remove hard-coded initializers for builtin case */
+module_init(init);
+module_exit(fini);
 #endif /* MODULE */
 #else /* CONFIG_INET */
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.35/drivers/parport/init.c working-2.5.35-modbase-try-i386/drivers/parport/init.c
--- linux-2.5.35/drivers/parport/init.c	Thu Jul 25 10:13:08 2002
+++ working-2.5.35-modbase-try-i386/drivers/parport/init.c	Tue Sep 17 18:56:13 2002
@@ -120,7 +120,7 @@ __setup ("parport=", parport_setup);
 #endif
 
 #ifdef MODULE
-int init_module(void)
+static int init(void)
 {
 #ifdef CONFIG_SYSCTL
 	parport_default_proc_register ();
@@ -128,12 +128,15 @@ int init_module(void)
 	return 0;
 }
 
-void cleanup_module(void)
+static void fini(void)
 {
 #ifdef CONFIG_SYSCTL
 	parport_default_proc_unregister ();
 #endif
 }
+
+module_init(init);
+module_exit(fini);
 
 #else
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.35/drivers/parport/parport_pc.c working-2.5.35-modbase-try-i386/drivers/parport/parport_pc.c
--- linux-2.5.35/drivers/parport/parport_pc.c	Sat Jul 27 15:24:38 2002
+++ working-2.5.35-modbase-try-i386/drivers/parport/parport_pc.c	Tue Sep 17 18:57:17 2002
@@ -3069,7 +3069,7 @@ MODULE_PARM_DESC(verbose_probing, "Log c
 MODULE_PARM(verbose_probing, "i");
 #endif
 
-int init_module(void)
+static int init(void)
 {	
 	/* Work out how many ports we have, then get parport_share to parse
 	   the irq values. */
@@ -3118,7 +3118,7 @@ int init_module(void)
 	return ret;
 }
 
-void cleanup_module(void)
+static void fini(void)
 {
 	/* We ought to keep track of which ports are actually ours. */
 	struct parport *p = parport_enumerate(), *tmp;
@@ -3134,4 +3134,8 @@ void cleanup_module(void)
 		p = tmp;
 	}
 }
+
+/* FIXME: Merge builtin and modular initializers --RR */
+module_init(init);
+module_exit(fini);
 #endif
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.35/net/netlink/netlink_dev.c working-2.5.35-modbase-try-i386/net/netlink/netlink_dev.c
--- linux-2.5.35/net/netlink/netlink_dev.c	Sun Aug 11 15:31:47 2002
+++ working-2.5.35-modbase-try-i386/net/netlink/netlink_dev.c	Tue Sep 17 18:51:54 2002
@@ -208,16 +208,20 @@ int __init init_netlink(void)
 
 MODULE_LICENSE("GPL");
 
-int init_module(void)
+static int init(void)
 {
 	printk(KERN_INFO "Network Kernel/User communications module 0.04\n");
 	return init_netlink();
 }
 
-void cleanup_module(void)
+static void fini(void)
 {
 	devfs_unregister (devfs_handle);
 	unregister_chrdev(NETLINK_MAJOR, "netlink");
 }
+
+/* FIXME: Remove harded init call in socket.c */
+module_init(init);
+module_exit(fini);
 
 #endif

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18828-linux-2.5.35/drivers/char/ftape/zftape/zftape-init.c .18828-linux-2.5.35.updated/drivers/char/ftape/zftape/zftape-init.c
--- .18828-linux-2.5.35/drivers/char/ftape/zftape/zftape-init.c	2002-08-02 11:15:07.000000000 +1000
+++ .18828-linux-2.5.35.updated/drivers/char/ftape/zftape/zftape-init.c	2002-09-18 11:50:20.000000000 +1000
@@ -393,20 +393,26 @@ KERN_INFO
 
 
 #ifdef MODULE
+
+#if 0 /* FIXME --RR */
 /* Called by modules package before trying to unload the module
  */
 static int can_unload(void)
 {
 	return (GET_USE_COUNT(THIS_MODULE)||zft_dirty()||test_bit(0,&busy_flag))?-EBUSY:0;
 }
+#endif
+
 /* Called by modules package when installing the driver
  */
 int init_module(void)
 {
+#if 0 /*FIXME --RR*/
 	if (!mod_member_present(&__this_module, can_unload)) {
 		return -EBUSY;
 	}
 	__this_module.can_unload = can_unload;
+#endif
 	return zft_init();
 }
 
@@ -444,3 +450,5 @@ void cleanup_module(void)
 }
 
 #endif /* MODULE */
+
+module_init(init_module);

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
