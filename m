Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVAYWlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVAYWlW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbVAYWlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 17:41:21 -0500
Received: from fmr18.intel.com ([134.134.136.17]:27522 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262191AbVAYWkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 17:40:06 -0500
Date: Tue, 25 Jan 2005 14:40:02 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [PATCH 2/2] Disallow seeks on sysfs files.
Message-ID: <Pine.CYG.4.58.0501251438090.696@mawilli1-desk2.amr.corp.intel.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch causes an error return if the user attempts to seek on a sysfs
file.

The patch was generated from 2.6.11-rc1.

Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>

diff -urpN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-25 10:28:25.000000000 -0800
@@ -307,6 +307,10 @@ static int check_perm(struct inode * ino
 		file->private_data = buffer;
 	} else
 		error = -ENOMEM;
+
+	/*  Set mode bits to disallow seeking.  */
+	file->f_mode &= ~(FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE);
+
 	goto Done;

  Einval:
@@ -349,7 +353,7 @@ static int sysfs_release(struct inode *
 struct file_operations sysfs_file_operations = {
 	.read		= sysfs_read_file,
 	.write		= sysfs_write_file,
-	.llseek		= generic_file_llseek,
+	.llseek		= no_llseek,
 	.open		= sysfs_open_file,
 	.release	= sysfs_release,
 };
