Return-Path: <linux-kernel-owner+w=401wt.eu-S932962AbXABHsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962AbXABHsM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 02:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932964AbXABHsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 02:48:12 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:24924 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932962AbXABHsL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 02:48:11 -0500
Date: Tue, 2 Jan 2007 08:48:08 +0100 (MET)
From: Oliver Neukum <oliver@neukum.name>
To: gregkh@suse.de, Alan Stern <stern@rowland.harvard.edu>, maneesh@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: error handling in sysfs, fill_read_buffer()
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701020850.28724.oliver@neukum.name>
X-RZG-AUTH: kN+qSWxTQH+Xqix8Cni7tCsVYhPCm1GP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

if a driver returns an error in fill_read_buffer(), the buffer will be
marked as filled. Subsequent reads will return eof. But there is
no data because of an error, not because it has been read.
Not marking the buffer filled is the obvious fix.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oliver@neukum.name>
--

--- a/fs/sysfs/file.c	2006-12-24 05:00:32.000000000 +0100
+++ b/fs/sysfs/file.c	2007-01-01 15:03:14.000000000 +0100
@@ -70,7 +70,8 @@
  *	Allocate @buffer->page, if it hasn't been already, then call the
  *	kobject's show() method to fill the buffer with this attribute's 
  *	data. 
- *	This is called only once, on the file's first read. 
+ *	This is called only once, on the file's first read unless an error
+ *	is returned.
  */
 static int fill_read_buffer(struct dentry * dentry, struct sysfs_buffer * buffer)
 {
@@ -88,12 +89,13 @@
 
 	buffer->event = atomic_read(&sd->s_event);
 	count = ops->show(kobj,attr,buffer->page);
-	buffer->needs_read_fill = 0;
 	BUG_ON(count > (ssize_t)PAGE_SIZE);
-	if (count >= 0)
+	if (count >= 0) {
+		buffer->needs_read_fill = 0;
 		buffer->count = count;
-	else
+	} else {
 		ret = count;
+	}
 	return ret;
 }
 
