Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVCBALK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVCBALK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 19:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVCBALK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 19:11:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:15031 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262129AbVCBALI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 19:11:08 -0500
Date: Tue, 1 Mar 2005 16:10:46 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Alexander Nyberg <alexn@dsv.su.se>
Subject: [PATCH] sysfs: fix signedness problem
Message-ID: <20050302001046.GA26525@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


count is size_t, fill_write_buffer() may return a negative number
which would evade the 'count > 0' checks and do bad things.

found by the Coverity tool

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- 1.22/fs/sysfs/file.c	2004-11-04 03:04:14 +01:00
+++ edited/fs/sysfs/file.c	2005-02-26 15:48:19 +01:00
@@ -231,15 +231,16 @@ static ssize_t
 sysfs_write_file(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct sysfs_buffer * buffer = file->private_data;
+	ssize_t len;
 
 	down(&buffer->sem);
-	count = fill_write_buffer(buffer,buf,count);
-	if (count > 0)
-		count = flush_write_buffer(file->f_dentry,buffer,count);
-	if (count > 0)
-		*ppos += count;
+	len = fill_write_buffer(buffer, buf, count);
+	if (len > 0)
+		len = flush_write_buffer(file->f_dentry, buffer, len);
+	if (len > 0)
+		*ppos += len;
 	up(&buffer->sem);
-	return count;
+	return len;
 }
 
 static int check_perm(struct inode * inode, struct file * file)



