Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbUKDB7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbUKDB7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUKDB7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:59:48 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:59283
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S262047AbUKDBzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:55:13 -0500
Subject: [patch 08/20] uml: mconsole_proc simplify and partial fix
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it, kraxel@bytesex.org
From: blaisorblade_spam@yahoo.it
Date: Thu, 04 Nov 2004 00:17:33 +0100
Message-Id: <20041103231733.43B8355C77@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Gerd Knorr <kraxel@bytesex.org>, and me, Paolo Giarrusso

This is a rewrite of the mconsole_proc function.

The old code had the problem that the kernel crashed after calling
"uml_mconsole proc <somefile>" a few times.  I havn't tracked what
exactly causes the problem, I guess trying to access the procfs without
actually mounting it somewhere causes some corruption of kernel data
structures.

The new code simply openes /proc/<file> via sys_open().  That simplifies
the function alot.  It also doesn't crash any more ;)

Also, from Paolo Giarrusso:
When printing the content of a file through the "proc" command, make
it begin on his own line.

PROBLEMS:
Drawback is that it only works when procfs is actually mounted below
/proc. And within UML, often this is false, because when building honeypots we
mount HPPFS under /proc to avoid the hacker recognizing he's attacking a UML
instance.

One suggestion I've received to fix the later issue was to mount
the procfs within a kernel thread with a private namespace, but I havn't
tried that so far.

Instead, we'd like to fix the actual code of the mconsole_proc function. From
"Anthony Brock" Anthony_Brock (at) ous (dot) edu comes a comment, suggesting
where the bug lays (as noted in the source): removing part of the code (it
seems the symlink lookup) there are no more crashes.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/drivers/mconsole_kern.c |   94 +++++++++++++-
 1 files changed, 93 insertions(+), 1 deletion(-)

diff -puN arch/um/drivers/mconsole_kern.c~uml-mconsole_proc-simplify-fix arch/um/drivers/mconsole_kern.c
--- vanilla-linux-2.6.9/arch/um/drivers/mconsole_kern.c~uml-mconsole_proc-simplify-fix	2004-11-03 23:44:59.175564064 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/drivers/mconsole_kern.c	2004-11-03 23:44:59.178563608 +0100
@@ -119,12 +119,98 @@ void mconsole_log(struct mc_request *req
 	mconsole_reply(req, "", 0, 0);
 }
 
+/* This is a more convoluted version of mconsole_proc, which has some stability
+ * problems; however, we need it fixed, because it is expected that UML users
+ * mount HPPFS instead of procfs on /proc. And we want mconsole_proc to still
+ * show the real procfs content, not the ones from hppfs.*/
+#if 0
+void mconsole_proc(struct mc_request *req)
+{
+	struct nameidata nd;
+	struct file_system_type *proc;
+	struct super_block *super;
+	struct file *file;
+	int n, err;
+	char *ptr = req->request.data, *buf;
+
+	ptr += strlen("proc");
+	while(isspace(*ptr)) ptr++;
+
+	proc = get_fs_type("proc");
+	if(proc == NULL){
+		mconsole_reply(req, "procfs not registered", 1, 0);
+		goto out;
+	}
+
+	super = (*proc->get_sb)(proc, 0, NULL, NULL);
+	put_filesystem(proc);
+	if(super == NULL){
+		mconsole_reply(req, "Failed to get procfs superblock", 1, 0);
+		goto out;
+	}
+	up_write(&super->s_umount);
+
+	nd.dentry = super->s_root;
+	nd.mnt = NULL;
+	nd.flags = O_RDONLY + 1;
+	nd.last_type = LAST_ROOT;
+
+	/* START: it was experienced that the stability problems are closed
+	 * if commenting out these two calls + the below read cycle. To
+	 * make UML crash again, it was enough to readd either one.*/
+	err = link_path_walk(ptr, &nd);
+	if(err){
+		mconsole_reply(req, "Failed to look up file", 1, 0);
+		goto out_kill;
+	}
+
+	file = dentry_open(nd.dentry, nd.mnt, O_RDONLY);
+	if(IS_ERR(file)){
+		mconsole_reply(req, "Failed to open file", 1, 0);
+		goto out_kill;
+	}
+	/*END*/
+
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if(buf == NULL){
+		mconsole_reply(req, "Failed to allocate buffer", 1, 0);
+		goto out_fput;
+	}
+
+	if((file->f_op != NULL) && (file->f_op->read != NULL)){
+		do {
+			n = (*file->f_op->read)(file, buf, PAGE_SIZE - 1,
+						&file->f_pos);
+			if(n >= 0){
+				buf[n] = '\0';
+				mconsole_reply(req, buf, 0, (n > 0));
+			}
+			else {
+				mconsole_reply(req, "Read of file failed",
+					       1, 0);
+				goto out_free;
+			}
+		} while(n > 0);
+	}
+	else mconsole_reply(req, "", 0, 0);
+
+ out_free:
+	kfree(buf);
+ out_fput:
+	fput(file);
+ out_kill:
+	deactivate_super(super);
+ out: ;
+}
+#endif
+
 void mconsole_proc(struct mc_request *req)
 {
 	char path[64];
 	char *buf;
 	int len;
 	int fd;
+	int first_chunk = 1;
 	char *ptr = req->request.data;
 
 	ptr += strlen("proc");
@@ -149,7 +235,13 @@ void mconsole_proc(struct mc_request *re
 		if (len < 0) {
 			mconsole_reply(req, "Read of file failed", 1, 0);
 			goto out_free;
-		} else if (len == PAGE_SIZE-1) {
+		}
+		/*Begin the file content on his own line.*/
+		if (first_chunk) {
+			mconsole_reply(req, "\n", 0, 1);
+			first_chunk = 0;
+		}
+		if (len == PAGE_SIZE-1) {
 			buf[len] = '\0';
 			mconsole_reply(req, buf, 0, 1);
 		} else {
_
