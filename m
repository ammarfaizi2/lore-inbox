Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVAUWzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVAUWzY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 17:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVAUWzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 17:55:24 -0500
Received: from fmr18.intel.com ([134.134.136.17]:63125 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262552AbVAUWzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 17:55:10 -0500
Date: Fri, 21 Jan 2005 14:55:09 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: [PATCH 3/3] change sematics of read flag
Message-ID: <Pine.CYG.4.58.0501211452420.3364@mawilli1-desk2.amr.corp.intel.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reverses the semantics of the read fill flag, getting rid of an
extra assignment at allocation time.

Generated from 2.6.11-rc1.

Signed-off-by:  Mitch Williams <mitch.a.williams@intel.com>

diff -uprN -X dontdiff linux-2.6.11-clean/fs/sysfs/file.c linux-2.6.11/fs/sysfs/file.c
--- linux-2.6.11-clean/fs/sysfs/file.c	2004-12-24 13:33:50.000000000 -0800
+++ linux-2.6.11/fs/sysfs/file.c	2005-01-21 13:09:21.000000000 -0800
@@ -61,7 +61,7 @@ struct sysfs_buffer {
 	char			* page;
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
-	int			needs_read_fill;
+	int			read_filled;
 };


@@ -89,7 +89,7 @@ static int fill_read_buffer(struct dentr
 		return -ENOMEM;

 	count = ops->show(kobj,attr,buffer->page);
-	buffer->needs_read_fill = 0;
+	buffer->read_filled = 1;
 	BUG_ON(count > (ssize_t)PAGE_SIZE);
 	if (count >= 0)
 		buffer->count = count;
@@ -154,7 +154,7 @@ sysfs_read_file(struct file *file, char
 	ssize_t retval = 0;

 	down(&buffer->sem);
-	if (buffer->needs_read_fill) {
+	if (!buffer->read_filled) {
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			goto out;
 	}
@@ -308,7 +307,6 @@ static int check_perm(struct inode * ino
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
 		init_MUTEX(&buffer->sem);
-		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
 		file->private_data = buffer;
 	} else
