Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWEDOBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWEDOBy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWEDOBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:01:53 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:15067 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751089AbWEDOBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:01:42 -0400
Date: Thu, 4 May 2006 16:01:45 +0200
From: Michael Holzheu <holzheu@de.ibm.com>
To: akpm@osdl.org
Cc: ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       linux-kernel@vger.kernel.org, mschwid2@de.ibm.com,
       penberg@cs.helsinki.fi, greg@kroah.com
Subject: [PATCH 3/3] Add /sys/hypervisor/s390 as mount point for s390-hypfs
Message-Id: <20060504160145.0ffe04a1.holzheu@de.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch creates /sys/hypervisor/s390 as mount point
for s390-hypfs.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>

---

 arch/s390/hypfs/inode.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff -urpN linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/hypfs/inode.c linux-2.6.16-hypfs-2006-04-28-update3/arch/s390/hypfs/inode.c
--- linux-2.6.16-hypfs-2006-04-28-update2/arch/s390/hypfs/inode.c	2006-05-04 10:23:49.000000000 +0200
+++ linux-2.6.16-hypfs-2006-04-28-update3/arch/s390/hypfs/inode.c	2006-05-04 10:31:55.000000000 +0200
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
