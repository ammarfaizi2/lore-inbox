Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUEFR4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUEFR4F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbUEFR4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:56:05 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:10988 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S261763AbUEFRz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:55:59 -0400
Subject: [2.6.6-rc3-mm2] genhd-unregister warn handling
From: FabF <Fabian.Frederick@skynet.be>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-0Zmfqh6RoF4mCr0N4iLF"
Message-Id: <1083866562.5865.6.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 06 May 2004 20:02:43 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx007.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0Zmfqh6RoF4mCr0N4iLF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Andrew,

	Here's a patch against 2.6.6-rc3-mm2 genhd.c unregister_blkdev

	-Standardize function for void xxx
	-Split uncorresponding return
	-Add printks
	-Merge kfree to positive case

	Could you apply ?

Regards,
Fabian

--=-0Zmfqh6RoF4mCr0N4iLF
Content-Disposition: attachment; filename=genhd1.diff
Content-Type: text/x-patch; name=genhd1.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/drivers/block/genhd.c edited/drivers/block/genhd.c
--- orig/drivers/block/genhd.c	2004-04-04 05:37:06.000000000 +0200
+++ edited/drivers/block/genhd.c	2004-05-06 19:52:56.000000000 +0200
@@ -116,31 +116,33 @@
 
 EXPORT_SYMBOL(register_blkdev);
 
-/* todo: make void - error printk here */
-int unregister_blkdev(unsigned int major, const char *name)
+void unregister_blkdev(unsigned int major, const char *name)
 {
 	struct blk_major_name **n;
 	struct blk_major_name *p = NULL;
 	int index = major_to_index(major);
 	unsigned long flags;
-	int ret = 0;
 
 	down_write(&block_subsys.rwsem);
 	spin_lock_irqsave(&major_names_lock, flags);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
-	if (!*n || strcmp((*n)->name, name))
-		ret = -EINVAL;
+	if (!*n)
+		printk(KERN_WARNING "Unable to unregister block device with major %d", major);
 	else {
-		p = *n;
-		*n = p->next;
+		if (strcmp((*n)->name, name))
+			printk(KERN_WARNING "Unable to unregister %s.Major name does not correspond", name);
+		else {
+			/*name was found in blk_major_name table.Skip it*/
+			p = *n;
+			*n = p->next;
+			kfree(p);
+		}
 	}
 	spin_unlock_irqrestore(&major_names_lock, flags);
 	up_write(&block_subsys.rwsem);
-	kfree(p);
 
-	return ret;
 }
 
 EXPORT_SYMBOL(unregister_blkdev);
diff -Naur orig/include/linux/fs.h edited/include/linux/fs.h
--- orig/include/linux/fs.h	2004-05-05 17:58:57.000000000 +0200
+++ edited/include/linux/fs.h	2004-05-06 19:19:26.000000000 +0200
@@ -1216,7 +1216,7 @@
 #endif
 
 extern int register_blkdev(unsigned int, const char *);
-extern int unregister_blkdev(unsigned int, const char *);
+extern void unregister_blkdev(unsigned int, const char *);
 extern struct block_device *bdget(dev_t);
 extern void bd_set_size(struct block_device *, loff_t size);
 extern void bd_forget(struct inode *inode);

--=-0Zmfqh6RoF4mCr0N4iLF--

