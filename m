Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVB0NZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVB0NZd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 08:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVB0NZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 08:25:33 -0500
Received: from mailfe03.swip.net ([212.247.154.65]:62945 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261386AbVB0NZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 08:25:26 -0500
X-T2-Posting-ID: icQHdNe7aEavrnKIz+aKnQ==
Subject: [PATCH] sysfs: Signedness problem
From: Alexander Nyberg <alexn@dsv.su.se>
To: gregkh@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 27 Feb 2005 14:25:23 +0100
Message-Id: <1109510723.2295.3.camel@boxen>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

count is size_t, fill_write_buffer() may return a negative number
which would evade the 'count > 0' checks and do bad things.

found by the Coverity tool

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

===== fs/sysfs/file.c 1.22 vs edited =====
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


