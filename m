Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUHNOds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUHNOds (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 10:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUHNOdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 10:33:47 -0400
Received: from verein.lst.de ([213.95.11.210]:23211 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S263100AbUHNOai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 10:30:38 -0400
Date: Sat, 14 Aug 2004 16:30:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reduce pty.c ifdef clutter
Message-ID: <20040814143032.GA26012@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - build only if either CONFIG_LEGACY_PTYS or CONFIG_UNIX98_PTYS are set
   instead of testing in the file
 - try to keep big CONFIG_LEGACY_PTYS and CONFIG_UNIX98_PTYS ifdef
   blocks at the end of the file instead of cluttering all over


--- 1.75/drivers/char/Makefile	2004-07-29 06:58:35 +02:00
+++ edited/drivers/char/Makefile	2004-08-13 16:31:11 +02:00
@@ -7,8 +7,11 @@
 #
 FONTMAPFILE = cp437.uni
 
-obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o
+obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o
 
+obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
+obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
+obj-y				+= misc.o
 obj-$(CONFIG_VT)		+= vt_ioctl.o vc_screen.o consolemap.o \
 				   consolemap_deftbl.o selection.o keyboard.o
 obj-$(CONFIG_HW_CONSOLE)	+= vt.o defkeymap.o
===== drivers/char/pty.c 1.26 vs edited =====
--- 1.26/drivers/char/pty.c	2004-06-30 08:02:10 +02:00
+++ edited/drivers/char/pty.c	2004-08-13 16:50:22 +02:00
@@ -32,12 +32,6 @@
 #include <asm/bitops.h>
 #include <linux/devpts_fs.h>
 
-#if defined(CONFIG_LEGACY_PTYS) || defined(CONFIG_UNIX98_PTYS)
-
-#ifdef CONFIG_LEGACY_PTYS
-static struct tty_driver *pty_driver, *pty_slave_driver;
-#endif
-
 /* These are global because they are accessed in tty_io.c */
 #ifdef CONFIG_UNIX98_PTYS
 struct tty_driver *ptm_driver;
@@ -205,19 +199,6 @@
 	return ((count < N_TTY_BUF_SIZE/2) ? 0 : count);
 }
 
-/* 
- * Return the device number of a Unix98 PTY (only!).  This lets us open a
- * master pty with the multi-headed ptmx device, then find out which
- * one we got after it is open, with an ioctl.
- */
-#ifdef CONFIG_UNIX98_PTYS
-static int pty_get_device_number(struct tty_struct *tty, unsigned __user *value)
-{
-	unsigned int result = tty->index;
-	return put_user(result, value);
-}
-#endif
-
 /* Set the lock flag on a pty */
 static int pty_set_lock(struct tty_struct *tty, int __user * arg)
 {
@@ -231,41 +212,6 @@
 	return 0;
 }
 
-#ifdef CONFIG_LEGACY_PTYS
-static int pty_bsd_ioctl(struct tty_struct *tty, struct file *file,
-			 unsigned int cmd, unsigned long arg)
-{
-	if (!tty) {
-		printk("pty_ioctl called with NULL tty!\n");
-		return -EIO;
-	}
-	switch(cmd) {
-	case TIOCSPTLCK: /* Set PT Lock (disallow slave open) */
-		return pty_set_lock(tty, (int __user *) arg);
-	}
-	return -ENOIOCTLCMD;
-}
-#endif
-
-#ifdef CONFIG_UNIX98_PTYS
-static int pty_unix98_ioctl(struct tty_struct *tty, struct file *file,
-			    unsigned int cmd, unsigned long arg)
-{
-	if (!tty) {
-		printk("pty_unix98_ioctl called with NULL tty!\n");
-		return -EIO;
-	}
-	switch(cmd) {
-	case TIOCSPTLCK: /* Set PT Lock (disallow slave open) */
-		return pty_set_lock(tty, (int __user *)arg);
-	case TIOCGPTN: /* Get PT Number */
-		return pty_get_device_number(tty, (unsigned int __user *)arg);
-	}
-
-	return -ENOIOCTLCMD;
-}
-#endif
-
 static void pty_flush_buffer(struct tty_struct *tty)
 {
 	struct tty_struct *to = tty->link;
@@ -322,42 +268,22 @@
 	.set_termios = pty_set_termios,
 };
 
-/* sysctl support for setting limits on the number of Unix98 ptys allocated.
-   Otherwise one can eat up all kernel memory by opening /dev/ptmx repeatedly. */
-#ifdef CONFIG_UNIX98_PTYS
-int pty_limit = NR_UNIX98_PTY_DEFAULT;
-static int pty_limit_min = 0;
-static int pty_limit_max = NR_UNIX98_PTY_MAX;
+/* Traditional BSD devices */
+#ifdef CONFIG_LEGACY_PTYS
+static struct tty_driver *pty_driver, *pty_slave_driver;
 
-ctl_table pty_table[] = {
-	{
-		.ctl_name	= PTY_MAX,
-		.procname	= "max",
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.data		= &pty_limit,
-		.proc_handler	= &proc_dointvec_minmax,
-		.strategy	= &sysctl_intvec,
-		.extra1		= &pty_limit_min,
-		.extra2		= &pty_limit_max,
-	}, {
-		.ctl_name	= PTY_NR,
-		.procname	= "nr",
-		.maxlen		= sizeof(int),
-		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
-	}, {
-		.ctl_name	= 0
+static int pty_bsd_ioctl(struct tty_struct *tty, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case TIOCSPTLCK: /* Set PT Lock (disallow slave open) */
+		return pty_set_lock(tty, (int __user *) arg);
 	}
-};
-#endif
-
-/* Initialization */
+	return -ENOIOCTLCMD;
+}
 
-static int __init pty_init(void)
+static void __init legacy_pty_init(void)
 {
-#ifdef CONFIG_LEGACY_PTYS
-	/* Traditional BSD devices */
 
 	pty_driver = alloc_tty_driver(NR_PTYS);
 	if (!pty_driver)
@@ -404,11 +330,58 @@
 		panic("Couldn't register pty driver");
 	if (tty_register_driver(pty_slave_driver))
 		panic("Couldn't register pty slave driver");
+}
+#else
+static inline void legacy_pty_init(void) { }
+#endif
 
-#endif /* CONFIG_LEGACY_PTYS */
-
+/* Unix98 devices */
 #ifdef CONFIG_UNIX98_PTYS
-	/* Unix98 devices */
+/*
+ * sysctl support for setting limits on the number of Unix98 ptys allocated.
+ * Otherwise one can eat up all kernel memory by opening /dev/ptmx repeatedly.
+ */
+int pty_limit = NR_UNIX98_PTY_DEFAULT;
+static int pty_limit_min = 0;
+static int pty_limit_max = NR_UNIX98_PTY_MAX;
+
+ctl_table pty_table[] = {
+	{
+		.ctl_name	= PTY_MAX,
+		.procname	= "max",
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.data		= &pty_limit,
+		.proc_handler	= &proc_dointvec_minmax,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &pty_limit_min,
+		.extra2		= &pty_limit_max,
+	}, {
+		.ctl_name	= PTY_NR,
+		.procname	= "nr",
+		.maxlen		= sizeof(int),
+		.mode		= 0444,
+		.proc_handler	= &proc_dointvec,
+	}, {
+		.ctl_name	= 0
+	}
+};
+
+static int pty_unix98_ioctl(struct tty_struct *tty, struct file *file,
+			    unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	case TIOCSPTLCK: /* Set PT Lock (disallow slave open) */
+		return pty_set_lock(tty, (int __user *)arg);
+	case TIOCGPTN: /* Get PT Number */
+		return put_user(tty->index, (unsigned int __user *)arg);
+	}
+
+	return -ENOIOCTLCMD;
+}
+
+static void __init unix98_pty_init(void)
+{
 	devfs_mk_dir("pts");
 	ptm_driver = alloc_tty_driver(NR_UNIX98_PTY_MAX);
 	if (!ptm_driver)
@@ -455,10 +428,15 @@
 		panic("Couldn't register Unix98 pts driver");
 
 	pty_table[1].data = &ptm_driver->refcount;
-#endif /* CONFIG_UNIX98_PTYS */
+}
+#else
+static inline void unix98_pty_init(void) { }
+#endif
 
+static int __init pty_init(void)
+{
+	legacy_pty_init();
+	unix98_pty_init();
 	return 0;
 }
 module_init(pty_init);
-
-#endif /* CONFIG_LEGACY_PTYS || CONFIG_UNIX98_PTYS */
