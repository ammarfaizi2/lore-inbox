Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVAUWuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVAUWuG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVAUWuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:50:06 -0500
Received: from fmr19.intel.com ([134.134.136.18]:62917 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262521AbVAUWtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:49:42 -0500
Date: Fri, 21 Jan 2005 14:49:39 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [PATCH 1/3] disallow seeks and appends on sysfs files
Message-ID: <Pine.CYG.4.58.0501211441430.3364@mawilli1-desk2.amr.corp.intel.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch causes sysfs to return errors if the caller attempts to append
to or seek on a sysfs file.

Generated from 2.6.11-rc1.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>

diff -uprN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-21 13:09:21.000000000 -0800
@@ -281,6 +281,11 @@ static int check_perm(struct inode * ino
 	if (!ops)
 		goto Eaccess;

+	/* Is the file is open for append?  Sorry, we don't do that. */
+	if (file->f_flags & O_APPEND) {
+		goto Einval;
+	}
+
 	/* File needs write support.
 	 * The inode's perms must say it's ok,
 	 * and we must have a store method.
@@ -312,6 +302,10 @@ static int check_perm(struct inode * ino
 		file->private_data = buffer;
 	} else
 		error = -ENOMEM;
+
+	/*  Set mode bits to disallow seeking.  */
+	file->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+
 	goto Done;

  Einval:
@@ -368,7 +343,7 @@ static int sysfs_release(struct inode *
 struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
-	.llseek		= generic_file_llseek,
+	.llseek		= no_llseek,
 	.open		= sysfs_open_file,
 	.release	= sysfs_release,
 };
