Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbTDFHGM (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbTDFHGM (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:06:12 -0400
Received: from verein.lst.de ([212.34.181.86]:35598 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262837AbTDFHGK (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 03:06:10 -0400
Date: Sun, 6 Apr 2003 09:17:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix devfs support in i386 microcode driver
Message-ID: <20030406091740.A6637@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

register a /dev/cpu/microcode symlink instead of a regular file
with the same name - regular file support is gone in devfs.


--- 1.17/arch/i386/kernel/microcode.c	Tue Mar 11 09:16:36 2003
+++ edited/arch/i386/kernel/microcode.c	Thu Mar 27 10:24:37 2003
@@ -107,7 +107,6 @@
 static char *mc_applied;            /* array of applied microcode blocks */
 static unsigned int mc_fsize;       /* file size of /dev/cpu/microcode */
 
-/* we share file_operations between misc and devfs mechanisms */
 static struct file_operations microcode_fops = {
 	.owner		= THIS_MODULE,
 	.read		= microcode_read,
@@ -122,41 +121,33 @@
 	.fops	= &microcode_fops,
 };
 
-static devfs_handle_t devfs_handle;
-
 static int __init microcode_init(void)
 {
 	int error;
 
 	error = misc_register(&microcode_dev);
 	if (error)
-		printk(KERN_WARNING 
-			"microcode: can't misc_register on minor=%d\n",
-			MICROCODE_MINOR);
-
-	devfs_handle = devfs_register(NULL, "cpu/microcode",
-			DEVFS_FL_DEFAULT, 0, 0, S_IFREG | S_IRUSR | S_IWUSR, 
-			&microcode_fops, NULL);
-	if (devfs_handle == NULL && error) {
-		printk(KERN_ERR "microcode: failed to devfs_register()\n");
-		misc_deregister(&microcode_dev);
-		goto out;
-	}
-	error = 0;
+		goto fail;
+	error = devfs_mk_symlink("cpu/microcode", "../misc/microcode");
+	if (error)
+		goto fail_deregister;
+
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
 		MICROCODE_VERSION);
+	return 0;
 
-out:
+fail_deregister:
+	misc_deregister(&microcode_dev);
+fail:
 	return error;
 }
 
 static void __exit microcode_exit(void)
 {
 	misc_deregister(&microcode_dev);
-	devfs_unregister(devfs_handle);
-	if (mc_applied)
-		kfree(mc_applied);
+	devfs_remove("cpu/microcode");
+	kfree(mc_applied);
 	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
 			MICROCODE_VERSION);
 }
