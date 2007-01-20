Return-Path: <linux-kernel-owner+w=401wt.eu-S932879AbXATNjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932879AbXATNjv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 08:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965262AbXATNjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 08:39:51 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:28534 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932879AbXATNjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 08:39:51 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] mm: search_binary_handler mem limit fix 
From: Dmitriy Monakhov <dmonakhov@openvz.org>
Date: Sat, 20 Jan 2007 16:40:08 +0300
Message-ID: <87ejppston.fsf@sw.ru>
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Function change mem limit to USER_DS before possible modprobe, but never restore 
it again. Why does this happend, is it just forgotten? As i understand currently
this not cause actual problems, but any one may call access_ok() after 
search_binary_handler() and will be really surprised.

Signed-off-by: Dmitriy Monakhov <dmonakhov@openvz.org>
--------

--=-=-=
Content-Disposition: inline; filename=diff-ms-fs-exec-fix

diff --git a/fs/exec.c b/fs/exec.c
index 11fe93f..c7e017b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1020,6 +1020,7 @@ int search_binary_handler(struct linux_b
 {
 	int try,retval;
 	struct linux_binfmt *fmt;
+	mm_segment_t oldfs;
 #ifdef __alpha__
 	/* handle /sbin/loader.. */
 	{
@@ -1061,11 +1062,12 @@ int search_binary_handler(struct linux_b
 
 	/* kernel module loader fixup */
 	/* so we don't try to load run modprobe in kernel space. */
+	oldfs = get_fs();
 	set_fs(USER_DS);
 
 	retval = audit_bprm(bprm);
 	if (retval)
-		return retval;
+		goto out;
 
 	retval = -ENOENT;
 	for (try=0; try<2; try++) {
@@ -1086,7 +1088,7 @@ int search_binary_handler(struct linux_b
 				bprm->file = NULL;
 				current->did_exec = 1;
 				proc_exec_connector(current);
-				return retval;
+				goto out;
 			}
 			read_lock(&binfmt_lock);
 			put_binfmt(fmt);
@@ -1094,7 +1096,7 @@ int search_binary_handler(struct linux_b
 				break;
 			if (!bprm->file) {
 				read_unlock(&binfmt_lock);
-				return retval;
+				goto out;
 			}
 		}
 		read_unlock(&binfmt_lock);
@@ -1112,6 +1114,8 @@ int search_binary_handler(struct linux_b
 #endif
 		}
 	}
+out:
+	set_fs(oldfs);
 	return retval;
 }
 

--=-=-=--

