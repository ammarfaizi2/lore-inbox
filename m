Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbTC3McZ>; Sun, 30 Mar 2003 07:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263540AbTC3McZ>; Sun, 30 Mar 2003 07:32:25 -0500
Received: from hera.cwi.nl ([192.16.191.8]:12928 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S262611AbTC3McY>;
	Sun, 30 Mar 2003 07:32:24 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 30 Mar 2003 14:43:41 +0200 (MEST)
Message-Id: <UTC200303301243.h2UChfg10861.aeb@smtp.cwi.nl>
To: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] readlink in /proc w/ overlong path
Cc: akpm@digeo.com, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Trying to read the overlong target of a /proc/*/fd/N file descriptor
> leads with the current BK kernel to a segfault in the kernel.

Yes. Below a patch.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/fs/proc/base.c b/fs/proc/base.c
--- a/fs/proc/base.c	Sun Feb 23 22:47:55 2003
+++ b/fs/proc/base.c	Sun Mar 30 14:32:35 2003
@@ -565,10 +565,10 @@
 }
 
 static int do_proc_readlink(struct dentry *dentry, struct vfsmount *mnt,
-			    char * buffer, int buflen)
+			    char *buffer, int buflen)
 {
 	struct inode * inode;
-	char * tmp = (char*)__get_free_page(GFP_KERNEL), *path;
+	char *tmp = (char*)__get_free_page(GFP_KERNEL), *path;
 	int len;
 
 	if (!tmp)
@@ -576,13 +576,17 @@
 		
 	inode = dentry->d_inode;
 	path = d_path(dentry, mnt, tmp, PAGE_SIZE);
+	len = PTR_ERR(path);
+	if (IS_ERR(path))
+		goto out;
 	len = tmp + PAGE_SIZE - 1 - path;
 
-	if (len < buflen)
-		buflen = len;
-	copy_to_user(buffer, path, buflen);
+	if (len > buflen)
+		len = buflen;
+	copy_to_user(buffer, path, len);
+ out:
 	free_page((unsigned long)tmp);
-	return buflen;
+	return len;
 }
 
 static int proc_pid_readlink(struct dentry * dentry, char * buffer, int buflen)
