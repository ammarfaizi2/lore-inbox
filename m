Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbWJJV43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbWJJV43 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbWJJVrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:47:16 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:25787 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030507AbWJJVq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:46:58 -0400
To: torvalds@osdl.org
Subject: [PATCH] make kernel/relay.c __user-clean
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1GXPRB-0007NM-A5@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 10 Oct 2006 22:46:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 kernel/relay.c |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 1d63ecd..f04bbdb 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -887,7 +887,7 @@ static int subbuf_read_actor(size_t read
 
 	from = buf->start + read_start;
 	ret = avail;
-	if (copy_to_user(desc->arg.data, from, avail)) {
+	if (copy_to_user(desc->arg.buf, from, avail)) {
 		desc->error = -EFAULT;
 		ret = 0;
 	}
@@ -946,24 +946,17 @@ typedef int (*subbuf_actor_t) (size_t re
  */
 static inline ssize_t relay_file_read_subbufs(struct file *filp,
 					      loff_t *ppos,
-					      size_t count,
 					      subbuf_actor_t subbuf_actor,
 					      read_actor_t actor,
-					      void *target)
+					      read_descriptor_t *desc)
 {
 	struct rchan_buf *buf = filp->private_data;
 	size_t read_start, avail;
-	read_descriptor_t desc;
 	int ret;
 
-	if (!count)
+	if (!desc->count)
 		return 0;
 
-	desc.written = 0;
-	desc.count = count;
-	desc.arg.data = target;
-	desc.error = 0;
-
 	mutex_lock(&filp->f_dentry->d_inode->i_mutex);
 	do {
 		if (!relay_file_read_avail(buf, *ppos))
@@ -974,19 +967,19 @@ static inline ssize_t relay_file_read_su
 		if (!avail)
 			break;
 
-		avail = min(desc.count, avail);
-		ret = subbuf_actor(read_start, buf, avail, &desc, actor);
-		if (desc.error < 0)
+		avail = min(desc->count, avail);
+		ret = subbuf_actor(read_start, buf, avail, desc, actor);
+		if (desc->error < 0)
 			break;
 
 		if (ret) {
 			relay_file_read_consume(buf, read_start, ret);
 			*ppos = relay_file_read_end_pos(buf, read_start, ret);
 		}
-	} while (desc.count && ret);
+	} while (desc->count && ret);
 	mutex_unlock(&filp->f_dentry->d_inode->i_mutex);
 
-	return desc.written;
+	return desc->written;
 }
 
 static ssize_t relay_file_read(struct file *filp,
@@ -994,8 +987,13 @@ static ssize_t relay_file_read(struct fi
 			       size_t count,
 			       loff_t *ppos)
 {
-	return relay_file_read_subbufs(filp, ppos, count, subbuf_read_actor,
-				       NULL, buffer);
+	read_descriptor_t desc;
+	desc.written = 0;
+	desc.count = count;
+	desc.arg.buf = buffer;
+	desc.error = 0;
+	return relay_file_read_subbufs(filp, ppos, subbuf_read_actor,
+				       NULL, &desc);
 }
 
 static ssize_t relay_file_sendfile(struct file *filp,
@@ -1004,8 +1002,13 @@ static ssize_t relay_file_sendfile(struc
 				   read_actor_t actor,
 				   void *target)
 {
-	return relay_file_read_subbufs(filp, ppos, count, subbuf_send_actor,
-				       actor, target);
+	read_descriptor_t desc;
+	desc.written = 0;
+	desc.count = count;
+	desc.arg.data = target;
+	desc.error = 0;
+	return relay_file_read_subbufs(filp, ppos, subbuf_send_actor,
+				       actor, &desc);
 }
 
 struct file_operations relay_file_operations = {
-- 
1.4.2.GIT


