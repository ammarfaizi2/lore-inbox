Return-Path: <linux-kernel-owner+willy=40w.ods.org-S381520AbUKBCVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S381520AbUKBCVH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 21:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S287505AbUKAXOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:14:24 -0500
Received: from mail.kroah.org ([69.55.234.183]:8356 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S284626AbUKAV7V convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:59:21 -0500
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.10-rc1
In-Reply-To: <10993462761856@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Mon, 1 Nov 2004 13:57:56 -0800
Message-Id: <1099346276148@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2446, 2004/11/01 13:04:46-08:00, akpm@osdl.org

[PATCH] Possible race in sysfs_read_file() and sysfs_write_file()

From: Simon Derr <Simon.Derr@bull.net>

Add a `needs_read_fill' field in sysfs_buffer so that reading after a write in
a sysfs file returns valid data.

(instead of the data that have been written, that may be invalid or at the
wrong offset)

Signed-off-by: Simon Derr <simon.derr@bull.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 fs/sysfs/file.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)


diff -Nru a/fs/sysfs/file.c b/fs/sysfs/file.c
--- a/fs/sysfs/file.c	2004-11-01 13:36:42 -08:00
+++ b/fs/sysfs/file.c	2004-11-01 13:36:42 -08:00
@@ -55,6 +55,7 @@
 	char			* page;
 	struct sysfs_ops	* ops;
 	struct semaphore	sem;
+	int			needs_read_fill;
 };
 
 
@@ -82,6 +83,7 @@
 		return -ENOMEM;
 
 	count = ops->show(kobj,attr,buffer->page);
+	buffer->needs_read_fill = 0;
 	BUG_ON(count > (ssize_t)PAGE_SIZE);
 	if (count >= 0)
 		buffer->count = count;
@@ -146,7 +148,7 @@
 	ssize_t retval = 0;
 
 	down(&buffer->sem);
-	if ((!*ppos) || (!buffer->page)) {
+	if (buffer->needs_read_fill) {
 		if ((retval = fill_read_buffer(file->f_dentry,buffer)))
 			goto out;
 	}
@@ -182,6 +184,7 @@
 	if (count >= PAGE_SIZE)
 		count = PAGE_SIZE - 1;
 	error = copy_from_user(buffer->page,buf,count);
+	buffer->needs_read_fill = 1;
 	return error ? -EFAULT : count;
 }
 
@@ -299,6 +302,7 @@
 	if (buffer) {
 		memset(buffer,0,sizeof(struct sysfs_buffer));
 		init_MUTEX(&buffer->sem);
+		buffer->needs_read_fill = 1;
 		buffer->ops = ops;
 		file->private_data = buffer;
 	} else

