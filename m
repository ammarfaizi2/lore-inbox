Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVBGThW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVBGThW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVBGTgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:36:19 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:20123 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261261AbVBGTas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:30:48 -0500
Date: Mon, 7 Feb 2005 13:30:17 -0600
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>
Subject: [PATCH] BSD Secure Levels: suid/sgid on directories; open/mknod issue, 2.6.11-rc2-mm1 (2/8)
Message-ID: <20050207193016.GA834@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050207192108.GA776@halcrow.us>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20050207192108.GA776@halcrow.us>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is the second in a series of eight patches to the BSD Secure
Levels LSM.  It allows setuid and setgid on directories.  It also
disallows the creation of setuid/setgid executables via open or mknod.
Thanks to Brad Spengler for the suggestion.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="seclvl_suid_and_guid.patch"

Index: linux-2.6.11-rc2-mm1-modules/security/seclvl.c
===================================================================
--- linux-2.6.11-rc2-mm1-modules.orig/security/seclvl.c	2005-02-03 15:14:54.907684456 -0600
+++ linux-2.6.11-rc2-mm1-modules/security/seclvl.c	2005-02-03 15:36:43.925683472 -0600
@@ -552,7 +552,11 @@
 static int seclvl_inode_setattr(struct dentry *dentry, struct iattr *iattr)
 {
 	if (seclvl > 0) {
-		if (iattr->ia_valid & ATTR_MODE)
+		if (dentry && dentry->d_inode
+		    && S_ISDIR(dentry->d_inode->i_mode)) {
+			return 0;
+		}
+		if (iattr && iattr->ia_valid & ATTR_MODE)
 			if (iattr->ia_mode & S_ISUID ||
 			    iattr->ia_mode & S_ISGID) {
 				seclvl_printk(1, KERN_WARNING "%s: Attempt to "
@@ -565,6 +569,36 @@
 	return 0;
 }
 
+/**
+ * Prevent an end-run around the inode_setattr control.
+ */
+static int seclvl_inode_mknod (struct inode * inode, struct dentry * dentry,
+			       int mode, dev_t dev)
+{
+	if (seclvl > 0 && (mode & 02000 || mode & 04000)) {
+		seclvl_printk(1, KERN_WARNING "%s: Attempt to mknod with suid "
+			      "or guid bit set in seclvl [%d]\n", __FUNCTION__,
+			      seclvl );
+		return -EPERM;
+	}
+        return 0;
+}
+
+/**
+ * Prevent an end-run around the inode_setattr control.
+ */
+static int
+seclvl_inode_create (struct inode * inode, struct dentry * dentry, int mask)
+{
+	if (seclvl > 0 && (mask & 02000 || mask & 04000)) {
+		seclvl_printk(1, KERN_WARNING "%s: Attempt to "
+			      "create inode with suid or guid bit set in "
+			      "seclvl [%d]\n", __FUNCTION__, seclvl );
+		return -EPERM;
+	}
+        return 0;
+}
+
 /* release busied block devices */
 static void seclvl_file_free_security(struct file *filp)
 {
@@ -598,6 +632,8 @@
 	.capable = seclvl_capable,
 	.inode_permission = seclvl_inode_permission,
 	.inode_setattr = seclvl_inode_setattr,
+	.inode_mknod = seclvl_inode_mknod,
+	.inode_create = seclvl_inode_create,
 	.file_free_security = seclvl_file_free_security,
 	.settime = seclvl_settime,
 	.sb_umount = seclvl_umount,

--h31gzZEtNLTqOjlF--
