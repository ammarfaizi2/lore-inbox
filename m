Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWEIK4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWEIK4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 06:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWEIK4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 06:56:49 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44462 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751398AbWEIK4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 06:56:49 -0400
Date: Tue, 9 May 2006 12:56:48 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: akpm@osdl.org, greg@kroah.com
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi
Subject: [PATCH 2/2] s390: Make hypfs more s390 specific
Message-Id: <20060509125648.060b0b1b.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Rename filesystem from "hypfs" to "s390-hypfs"
- Create /sys/hypervisor/s390 instead of /sys/hypervisor
  as mount point for s390-hypfs.
- Rename kernel config option from "HYPFS_FS" to
  "S390_HYPFS_FS"

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 arch/s390/Kconfig        |    3 ++-
 arch/s390/hypfs/Makefile |    2 +-
 arch/s390/hypfs/inode.c  |   23 ++++++++++++-----------
 3 files changed, 15 insertions(+), 13 deletions(-)

diff -urpN linux-2.6.17-rc3-mm1-sys-hypervisor/arch/s390/Kconfig linux-2.6.17-rc3-mm1-sys-hypervisor-hypfs/arch/s390/Kconfig
--- linux-2.6.17-rc3-mm1-sys-hypervisor/arch/s390/Kconfig	2006-05-08 15:57:31.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor-hypfs/arch/s390/Kconfig	2006-05-08 16:24:27.000000000 +0200
@@ -446,8 +446,9 @@ config NO_IDLE_HZ_INIT
 	  The HZ timer is switched off in idle by default. That means the
 	  HZ timer is already disabled at boot time.
 
-config HYPFS_FS
+config S390_HYPFS_FS
 	bool "s390 hypervisor file system support"
+	select SYS_HYPERVISOR
 	default y
 	help
 	  This is a virtual file system intended to provide accounting
diff -urpN linux-2.6.17-rc3-mm1-sys-hypervisor/arch/s390/hypfs/Makefile linux-2.6.17-rc3-mm1-sys-hypervisor-hypfs/arch/s390/hypfs/Makefile
--- linux-2.6.17-rc3-mm1-sys-hypervisor/arch/s390/hypfs/Makefile	2006-05-08 15:57:31.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor-hypfs/arch/s390/hypfs/Makefile	2006-05-08 18:08:55.000000000 +0200
@@ -2,6 +2,6 @@
 # Makefile for the linux hypfs filesystem routines.
 #
 
-obj-$(CONFIG_HYPFS_FS) += hypfs.o
+obj-$(CONFIG_S390_HYPFS_FS) += hypfs.o
 
 hypfs-objs := inode.o hypfs_diag.o
diff -urpN linux-2.6.17-rc3-mm1-sys-hypervisor/arch/s390/hypfs/inode.c linux-2.6.17-rc3-mm1-sys-hypervisor-hypfs/arch/s390/hypfs/inode.c
--- linux-2.6.17-rc3-mm1-sys-hypervisor/arch/s390/hypfs/inode.c	2006-05-08 15:57:31.000000000 +0200
+++ linux-2.6.17-rc3-mm1-sys-hypervisor-hypfs/arch/s390/hypfs/inode.c	2006-05-08 16:58:01.000000000 +0200
@@ -422,7 +422,7 @@ static struct file_operations hypfs_file
 
 static struct file_system_type hypfs_type = {
 	.owner		= THIS_MODULE,
-	.name		= "hypfs",
+	.name		= "s390-hypfs",
 	.get_sb		= hypfs_get_super,
 	.kill_sb	= kill_litter_super
 };
@@ -433,7 +433,7 @@ static struct super_operations hypfs_s_o
 	.put_super	= hypfs_put_super
 };
 
-static decl_subsys(hypervisor, NULL, NULL);
+static decl_subsys(s390, NULL, NULL);
 
 static int __init hypfs_init(void)
 {
@@ -443,21 +443,22 @@ static int __init hypfs_init(void)
 		return -ENODATA;
 	if (hypfs_diag_init()) {
 		rc = -ENODATA;
-		goto err_msg;
+		goto fail_diag;
 	}
-	rc = subsystem_register(&hypervisor_subsys);
+	kset_set_kset_s(&s390_subsys, hypervisor_subsys);
+	rc = subsystem_register(&s390_subsys);
 	if (rc)
-		goto err_diag;
+		goto fail_sysfs;
 	rc = register_filesystem(&hypfs_type);
 	if (rc)
-		goto err_sysfs;
+		goto fail_filesystem;
 	return 0;
 
-err_sysfs:
-	subsystem_unregister(&hypervisor_subsys);
-err_diag:
+fail_filesystem:
+	subsystem_unregister(&s390_subsys);
+fail_sysfs:
 	hypfs_diag_exit();
-err_msg:
+fail_diag:
 	printk(KERN_ERR "hypfs: Initialization failed with rc = %i.\n", rc);
 	return rc;
 }
@@ -466,7 +467,7 @@ static void __exit hypfs_exit(void)
 {
 	hypfs_diag_exit();
 	unregister_filesystem(&hypfs_type);
-	subsystem_unregister(&hypervisor_subsys);
+	subsystem_unregister(&s390_subsys);
 }
 
 module_init(hypfs_init)
