Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTKGXvp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTKGWNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:13:46 -0500
Received: from pat.uio.no ([129.240.130.16]:59063 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264412AbTKGPdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 10:33:23 -0500
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: linux-kernel@vger.kernel.org
Subject: NFS and dnotify. 
MIME-Version: 1.0
Message-Id: <E1AI8bu-0004RC-00@aqualene.uio.no>
Date: Fri, 7 Nov 2003 16:33:18 +0100
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Programs running on an NFS-server won't get dnotify-events when
NFS-clients change files. This is a problem with filesystems which are
exported with both NFS and Samba. Typically a Windooze-system running
IIS and ASP will not pick up changes made via NFS because of this.

The following patch fixes the problem for me at least. I'm not
familiar with the internals so possibly there are better ways of doing
this, but it seems pretty straightforward.

Obviously the DN_ACCESS part does not work when the client already has
cached the file. The important thing is that DN_MODIFY works.

The patch is actually against RedHat's 2.4.20-20.9, but the code in
question is identical in stock 2.4.22.

It would be very nice if this or something like it could get into the
standard kernel.

--- fs/nfsd/vfs.c.org	2003-11-07 14:18:33.000000000 +0100
+++ fs/nfsd/vfs.c	2003-11-07 15:31:12.000000000 +0100
@@ -42,7 +42,7 @@
 #endif /* CONFIG_NFSD_V3 */
 #include <linux/nfsd/nfsfh.h>
 #include <linux/quotaops.h>
-
+#include <linux/dnotify.h>
 #include <asm/uaccess.h>
 
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
@@ -627,6 +627,9 @@
 	err = file.f_op->read(&file, buf, *count, &file.f_pos);
 	set_fs(oldfs);
 
+	if (*count > 0)
+	        dnotify_parent(file.f_dentry, DN_ACCESS);
+
 	/* Write back readahead params */
 	if (ra != NULL) {
 		dprintk("nfsd: raparms %ld %ld %ld %ld %ld\n",
@@ -711,8 +714,10 @@
 	/* Write the data. */
 	oldfs = get_fs(); set_fs(KERNEL_DS);
 	err = file.f_op->write(&file, buf, cnt, &file.f_pos);
-	if (err >= 0)
+	if (err >= 0) {
 		nfsdstats.io_write += cnt;
+	        dnotify_parent(file.f_dentry, DN_MODIFY);
+	}
 	set_fs(oldfs);
 
 	/* clear setuid/setgid flag after write */

-- 
 - Terje
malmedal@usit.uio.no
