Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVIROYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVIROYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 10:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVIROXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 10:23:39 -0400
Received: from ppp-62-11-75-109.dialup.tiscali.it ([62.11.75.109]:35251 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S932074AbVIROXZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 10:23:25 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 05/12] HPPFS: check copy_*_user calls
Date: Sun, 18 Sep 2005 16:09:53 +0200
To: Antoine Martin <antoine@nagafix.co.uk>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: LKML <linux-kernel@vger.kernel.org>
Message-Id: <20050918140953.31461.96489.stgit@zion.home.lan>
In-Reply-To: 200509181400.39120.blaisorblade@yahoo.it
References: 200509181400.39120.blaisorblade@yahoo.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing checking for copy_to_user() calls, and fix the existing ones
(we must return the number of correctly read bytes - XXX: verify please.).
---

 fs/hppfs/hppfs_kern.c |   36 +++++++++++++++++++++---------------
 1 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/hppfs/hppfs_kern.c b/fs/hppfs/hppfs_kern.c
--- a/fs/hppfs/hppfs_kern.c
+++ b/fs/hppfs/hppfs_kern.c
@@ -258,7 +258,7 @@ static ssize_t read_proc(struct file *fi
 static ssize_t hppfs_read_file(int fd, char *buf, ssize_t count)
 {
 	ssize_t n;
-	int cur, err;
+	int cur, ret;
 	char *new_buf;
 
 	n = -ENOMEM;
@@ -268,27 +268,30 @@ static ssize_t hppfs_read_file(int fd, c
 		goto out;
 	}
 	n = 0;
-	while(count > 0){
+	while (count > 0) {
+		unsigned long left;
 		cur = min_t(ssize_t, count, PAGE_SIZE);
-		err = os_read_file(fd, new_buf, cur);
-		if(err < 0){
-			printk("hppfs_read : read failed, errno = %d\n", -err);
-			n = err;
+		ret = os_read_file(fd, new_buf, cur);
+		if (ret < 0) {
+			printk("hppfs_read : read failed, errno = %d\n", -ret);
+			n = ret;
 			goto out_free;
-		}
-		else if(err == 0)
+		} else if (ret == 0)
 			break;
 
-		if(copy_to_user(buf, new_buf, err)){
-			n = -EFAULT;
+		left = copy_to_user(buf, new_buf, ret);
+		n += ret - left;
+		count -= ret - left;
+
+		if (left) {
+			if (!n)
+				n = -EFAULT;
 			goto out_free;
 		}
-		n += err;
-		count -= err;
 	}
- out_free:
+out_free:
 	kfree(new_buf);
- out:
+out:
 	return n;
 }
 
@@ -313,7 +316,10 @@ static ssize_t hppfs_read(struct file *f
 
 		if(off + count > hppfs->len)
 			count = hppfs->len - off;
-		copy_to_user(buf, &data->contents[off], count);
+		err = copy_to_user(buf, &data->contents[off], count);
+		count -= err;
+		if (!count)
+			return -EFAULT;
 		*ppos += count;
 	} else if(hppfs->host_fd != -1) {
 		err = os_seek_file(hppfs->host_fd, *ppos);

