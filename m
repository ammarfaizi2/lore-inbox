Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272639AbTHKOV4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 10:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272650AbTHKNma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:42:30 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:40331 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272627AbTHKNlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:41:05 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org, tigran@veritas.com
Subject: [PATCH] microcode driver sparse __user annotations.
Message-Id: <E19mCuO-0003dF-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Plus with a little codeshuffling, we can do away with the
prototypes.

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/microcode.c linux-2.5/arch/i386/kernel/microcode.c
--- bk-linus/arch/i386/kernel/microcode.c	2003-07-12 11:28:45.000000000 +0100
+++ linux-2.5/arch/i386/kernel/microcode.c	2003-07-13 16:55:50.000000000 +0100
@@ -89,15 +89,6 @@ MODULE_LICENSE("GPL");
 #define printf(x...)
 #endif
 
-/* VFS interface */
-static int microcode_open(struct inode *, struct file *);
-static ssize_t microcode_read(struct file *, char *, size_t, loff_t *);
-static ssize_t microcode_write(struct file *, const char *, size_t, loff_t *);
-static int microcode_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
-
-static int do_microcode_update(void);
-static void do_update_one(void *);
-
 /* read()/write()/ioctl() are serialized on this */
 static DECLARE_RWSEM(microcode_rwsem);
 
@@ -106,46 +97,6 @@ static unsigned int microcode_num;  /* n
 static char *mc_applied;            /* array of applied microcode blocks */
 static unsigned int mc_fsize;       /* file size of /dev/cpu/microcode */
 
-static struct file_operations microcode_fops = {
-	.owner		= THIS_MODULE,
-	.read		= microcode_read,
-	.write		= microcode_write,
-	.ioctl		= microcode_ioctl,
-	.open		= microcode_open,
-};
-
-static struct miscdevice microcode_dev = {
-	.minor		= MICROCODE_MINOR,
-	.name		= "microcode",
-	.devfs_name	= "cpu/microcode",
-	.fops		= &microcode_fops,
-};
-
-static int __init microcode_init(void)
-{
-	int error;
-
-	error = misc_register(&microcode_dev);
-	if (error)
-		return error;
-
-	printk(KERN_INFO 
-		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
-		MICROCODE_VERSION);
-	return 0;
-}
-
-static void __exit microcode_exit(void)
-{
-	misc_deregister(&microcode_dev);
-	kfree(mc_applied);
-	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
-			MICROCODE_VERSION);
-}
-
-module_init(microcode_init)
-module_exit(microcode_exit)
-
 static int microcode_open(struct inode *unused1, struct file *unused2)
 {
 	return capable(CAP_SYS_RAWIO) ? 0 : -EPERM;
@@ -160,27 +111,6 @@ struct update_req {
 	int slot;
 } update_req[NR_CPUS];
 
-static int do_microcode_update(void)
-{
-	int i, error = 0, err;
-	struct microcode *m;
-
-	if (on_each_cpu(do_update_one, NULL, 1, 1) != 0) {
-		printk(KERN_ERR "microcode: IPI timeout, giving up\n");
-		return -EIO;
-	}
-
-	for (i=0; i<NR_CPUS; i++) {
-		err = update_req[i].err;
-		error += err;
-		if (!err) {
-			m = (struct microcode *)mc_applied + i;
-			memcpy(m, &microcode[update_req[i].slot], sizeof(struct microcode));
-		}
-	}
-	return error;
-}
-
 static void do_update_one(void *unused)
 {
 	int cpu_num = smp_processor_id();
@@ -291,7 +221,28 @@ static void do_update_one(void *unused)
 }
 
 
-static ssize_t microcode_read(struct file *file, char *buf, size_t len, loff_t *ppos)
+static int do_microcode_update(void)
+{
+	int i, error = 0, err;
+	struct microcode *m;
+
+	if (on_each_cpu(do_update_one, NULL, 1, 1) != 0) {
+		printk(KERN_ERR "microcode: IPI timeout, giving up\n");
+		return -EIO;
+	}
+
+	for (i=0; i<NR_CPUS; i++) {
+		err = update_req[i].err;
+		error += err;
+		if (!err) {
+			m = (struct microcode *)mc_applied + i;
+			memcpy(m, &microcode[update_req[i].slot], sizeof(struct microcode));
+		}
+	}
+	return error;
+}
+
+static ssize_t microcode_read(struct file *file, char __user *buf, size_t len, loff_t *ppos)
 {
 	ssize_t ret = 0;
 
@@ -310,7 +261,7 @@ out:
 	return ret;
 }
 
-static ssize_t microcode_write(struct file *file, const char *buf, size_t len, loff_t *ppos)
+static ssize_t microcode_write(struct file *file, const char __user *buf, size_t len, loff_t *ppos)
 {
 	ssize_t ret;
 
@@ -384,3 +335,44 @@ static int microcode_ioctl(struct inode 
 	}
 	return -EINVAL;
 }
+
+static struct file_operations microcode_fops = {
+	.owner		= THIS_MODULE,
+	.read		= microcode_read,
+	.write		= microcode_write,
+	.ioctl		= microcode_ioctl,
+	.open		= microcode_open,
+};
+
+static struct miscdevice microcode_dev = {
+	.minor		= MICROCODE_MINOR,
+	.name		= "microcode",
+	.devfs_name	= "cpu/microcode",
+	.fops		= &microcode_fops,
+};
+
+static int __init microcode_init(void)
+{
+	int error;
+
+	error = misc_register(&microcode_dev);
+	if (error)
+		return error;
+
+	printk(KERN_INFO 
+		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
+		MICROCODE_VERSION);
+	return 0;
+}
+
+static void __exit microcode_exit(void)
+{
+	misc_deregister(&microcode_dev);
+	kfree(mc_applied);
+	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
+			MICROCODE_VERSION);
+}
+
+module_init(microcode_init)
+module_exit(microcode_exit)
+
