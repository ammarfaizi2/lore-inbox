Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265747AbUFDMAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265747AbUFDMAR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 08:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUFDMAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 08:00:17 -0400
Received: from [194.85.238.98] ([194.85.238.98]:32975 "EHLO school.ioffe.ru")
	by vger.kernel.org with ESMTP id S265747AbUFDMAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 08:00:09 -0400
Date: Fri, 4 Jun 2004 16:00:02 +0400
To: linux-kernel@vger.kernel.org
Cc: James Morris <jmorris@redhat.com>, mason@suse.com, jeffm@suse.com
Subject: Re: 2.6.7-rc2: open() hangs on ReiserFS with SELinux enabled
Message-ID: <20040604120002.GB18344@school.ioffe.ru>
References: <20040602174810.GA31263@school.ioffe.ru> <1086201647.15871.135.camel@moss-spartans.epoch.ncsc.mil> <20040603083622.GA9918@school.ioffe.ru> <1086271751.17657.104.camel@moss-spartans.epoch.ncsc.mil> <1086291991.19025.55.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1086291991.19025.55.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.3.28i
From: mitya@school.ioffe.ru (Dmitry Baryshkov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Thu, Jun 03, 2004 at 03:46:31PM -0400, Stephen Smalley wrote:
> On Thu, 2004-06-03 at 10:09, Stephen Smalley wrote:
> 
> Actually, that last part may be a red herring, since reiserfs_write_lock
> is simply a macro for lock_kernel.  The more immediate concern is
> avoiding the inode->i_op->getxattr call from SELinux on the xattr
> directory inode.  reiserfs xattr code would need to call a new security
> hook to mark the xattr root directory inode in some manner, so that
> subsequent security_d_instantiate calls on the per-object subdirectories
> could be identified by SELinux, and it could then just set the SID on
> the incore inode to a well-defined value and not call
> inode->i_op->getxattr for those inodes.

Here is a patch, based on discussion with Stephen Smalley, that fixes
the problem for me. As private files don't have xattrs,
reiserfs_getxattr should return early for them, thus not trying to lock anything.
-- 
With best wishes
Dmitry Baryshkov

diff -pur linux-2.6.7-rc2-orig/fs/reiserfs/xattr.c linux-2.6.7-rc2/fs/reiserfs/xattr.c
--- linux-2.6.7-rc2-orig/fs/reiserfs/xattr.c	2004-06-04 00:22:25.000000000 +0400
+++ linux-2.6.7-rc2/fs/reiserfs/xattr.c	2004-06-04 10:13:00.000000000 +0400
@@ -944,6 +944,16 @@ reiserfs_getxattr (struct dentry *dentry
 {
     struct reiserfs_xattr_handler *xah = find_xattr_handler_prefix (name);
     int err;
+    struct dentry *dpar;
+
+    dpar = dget_parent(dentry);
+    if (is_reiserfs_priv_object (dentry->d_inode) ||
+        (dpar && is_reiserfs_priv_object (dpar->d_inode)))
+    {
+	    dput(dpar);
+	    return -ENODATA;
+    }
+    dput(dpar);
 
     if (!xah || !reiserfs_xattrs(dentry->d_sb) ||
         get_inode_sd_version (dentry->d_inode) == STAT_DATA_V1)

