Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270320AbUJTCqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270320AbUJTCqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 22:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbUJTCmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 22:42:24 -0400
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:47048 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S269536AbUJTCgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 22:36:12 -0400
Date: Tue, 19 Oct 2004 19:35:58 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, Gerd Knorr <kraxel@bytesex.org>
Subject: [PATCH] UML: kraxel's mconsole_proc rewrite
Message-ID: <20041020023558.GD8597@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an update/resync of kraxel's mconsole_proc rewrite from about
two months ago and IMO it should be merged as-is.

I didn't originally write this, so no Signed-off-by...  I'd love to
see his re-post with that though.

diff -Nru a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
--- a/arch/um/drivers/mconsole_kern.c	2004-10-19 17:48:18 -07:00
+++ b/arch/um/drivers/mconsole_kern.c	2004-10-19 17:48:18 -07:00
@@ -19,6 +19,7 @@
 #include "linux/fs.h"
 #include "linux/namei.h"
 #include "linux/proc_fs.h"
+#include "linux/syscalls.h"
 #include "asm/irq.h"
 #include "asm/uaccess.h"
 #include "user_util.h"
@@ -120,77 +121,50 @@
 
 void mconsole_proc(struct mc_request *req)
 {
-	struct nameidata nd;
-	struct file_system_type *proc;
-	struct super_block *super;
-	struct file *file;
-	int n, err;
-	char *ptr = req->request.data, *buf;
+	char path[64];
+	char *buf;
+	int len;
+	int fd;
+	char *ptr = req->request.data;
 
 	ptr += strlen("proc");
 	while(isspace(*ptr)) ptr++;
+	snprintf(path, sizeof(path), "/proc/%s", ptr);
 
-	proc = get_fs_type("proc");
-	if(proc == NULL){
-		mconsole_reply(req, "procfs not registered", 1, 0);
-		goto out;
-	}
-
-	super = (*proc->get_sb)(proc, 0, NULL, NULL);
-	put_filesystem(proc);
-	if(super == NULL){
-		mconsole_reply(req, "Failed to get procfs superblock", 1, 0);
-		goto out;
-	}
-	up_write(&super->s_umount);
-
-	nd.dentry = super->s_root;
-	nd.mnt = NULL;
-	nd.flags = O_RDONLY + 1;
-	nd.last_type = LAST_ROOT;
-
-	err = link_path_walk(ptr, &nd);
-	if(err){
-		mconsole_reply(req, "Failed to look up file", 1, 0);
-		goto out_kill;
-	}
-
-	file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
-	if(IS_ERR(file)){
+	fd = sys_open(path, 0, 0);
+	if (fd < 0) {
 		mconsole_reply(req, "Failed to open file", 1, 0);
-		goto out_kill;
+		printk("open %s: %d\n",path,fd);
+		goto out;
 	}
 
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if(buf == NULL){
 		mconsole_reply(req, "Failed to allocate buffer", 1, 0);
-		goto out_fput;
+		goto out_close;
 	}
 
-	if((file->f_op != NULL) && (file->f_op->read != NULL)){
-		do {
-			n = (*file->f_op->read)(file, buf, PAGE_SIZE - 1,
-						&file->f_pos);
-			if(n >= 0){
-				buf[n] = '\0';
-				mconsole_reply(req, buf, 0, (n > 0));
-			}
-			else {
-				mconsole_reply(req, "Read of file failed",
-					       1, 0);
-				goto out_free;
-			}
-		} while(n > 0);
+	for (;;) {
+		len = sys_read(fd, buf, PAGE_SIZE-1);
+		if (len < 0) {
+			mconsole_reply(req, "Read of file failed", 1, 0);
+			goto out_free;
+		} else if (len == PAGE_SIZE-1) {
+			buf[len] = '\0';
+			mconsole_reply(req, buf, 0, 1);
+		} else {
+			buf[len] = '\0';
+			mconsole_reply(req, buf, 0, 0);
+			break;
+		}
 	}
-	else mconsole_reply(req, "", 0, 0);
 
  out_free:
 	kfree(buf);
- out_fput:
-	fput(file);
- out_kill:
-	deactivate_super(super);
- out: ;
+ out_close:
+	sys_close(fd);
+ out:
+	/* nothing */;
 }
 
 #define UML_MCONSOLE_HELPTEXT \
