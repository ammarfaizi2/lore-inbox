Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVEQP1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVEQP1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 11:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEQP1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 11:27:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:20680 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261590AbVEQP1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 11:27:01 -0400
Date: Tue, 17 May 2005 10:26:57 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Chris Wright <chrisw@osdl.org>,
       Serge Hallyn <serue@us.ibm.com>, mhalcrow@us.ibm.com
Subject: [patch 3/7] BSD Secure Levels: allow suid and sgid on directories
Message-ID: <20050517152657.GB2944@halcrow.us>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20050517152303.GA2814@halcrow.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517152303.GA2814@halcrow.us>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the third in a series of seven patches to the BSD Secure
Levels LSM.  It allows setuid and setgid on directories.  It also
disallows the creation of setuid/setgid executables via open or mknod.
Thanks to Brad Spengler for the suggestion.

Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>

Index: linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c
===================================================================
--- linux-2.6.12-rc4-mm2-seclvl.orig/security/seclvl.c	2005-05-16 16:27:27.000000000 -0500
+++ linux-2.6.12-rc4-mm2-seclvl/security/seclvl.c	2005-05-16 16:28:19.000000000 -0500
@@ -540,7 +540,11 @@
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
@@ -554,6 +558,36 @@
 }
 
 /**
+ * Prevent an end-run around the inode_setattr control.
+ */
+static int seclvl_inode_mknod(struct inode *inode, struct dentry *dentry,
+			      int mode, dev_t dev)
+{
+	if (seclvl > 0 && (mode & 02000 || mode & 04000)) {
+		seclvl_printk(1, KERN_WARNING "%s: Attempt to mknod with suid "
+			      "or guid bit set in seclvl [%d]\n", __FUNCTION__,
+			      seclvl);
+		return -EPERM;
+	}
+	return 0;
+}
+
+/**
+ * Prevent an end-run around the inode_setattr control.
+ */
+static int
+seclvl_inode_create(struct inode *inode, struct dentry *dentry, int mask)
+{
+	if (seclvl > 0 && (mask & 02000 || mask & 04000)) {
+		seclvl_printk(1, KERN_WARNING "%s: Attempt to "
+			      "create inode with suid or guid bit set in "
+			      "seclvl [%d]\n", __FUNCTION__, seclvl);
+		return -EPERM;
+	}
+	return 0;
+}
+
+/**
  * Release busied block devices.
  */
 static void seclvl_file_free_security(struct file *filp)
@@ -594,6 +628,8 @@
 	.capable = seclvl_capable,
 	.file_permission = seclvl_file_permission,
 	.inode_setattr = seclvl_inode_setattr,
+	.inode_mknod = seclvl_inode_mknod,
+	.inode_create = seclvl_inode_create,
 	.file_free_security = seclvl_file_free_security,
 	.settime = seclvl_settime,
 	.sb_umount = seclvl_umount,
