Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263059AbUFTWs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263059AbUFTWs4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUFTWs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:48:56 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:36292 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263059AbUFTWsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:48:50 -0400
Date: Sun, 20 Jun 2004 18:50:56 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Urban Widmark <urban@teststation.com>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6] Fix smbfs readdir oops
Message-ID: <Pine.LNX.4.58.0406201834390.3273@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been reported a couple of times and is consistently causing some
folks grief, so Urban, would you mind terribly if i send this patch to at
least clear current bug reports. If there is additional stuff you want
ontop of this let me know and i can send a follow up patch.

The bug is that at times we haven't completed setting up the smb_ops so we
have a temporary 'null' ops in place until the connection is completely
up. With this setup it's possible to hit ->readdir() whilst the null
ops are still in place, so we put the process to sleep until the
connection setup is complete and then call the real ->readdir().

This patch addresses the bugzilla report at
http://bugzilla.kernel.org/show_bug.cgi?id=1671

 fs/smbfs/inode.c          |    1 +
 fs/smbfs/proc.c           |   44 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/smb_fs_sb.h |    3 ++-
 3 files changed, 45 insertions(+), 3 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.7/include/linux/smb_fs_sb.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.7/include/linux/smb_fs_sb.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smb_fs_sb.h
--- linux-2.6.7/include/linux/smb_fs_sb.h	16 Jun 2004 16:49:26 -0000	1.1.1.1
+++ linux-2.6.7/include/linux/smb_fs_sb.h	20 Jun 2004 00:06:45 -0000
@@ -57,7 +57,8 @@ struct smb_sb_info {
 	unsigned int generation;
 	pid_t conn_pid;
 	struct smb_conn_opt opt;
-
+	wait_queue_head_t conn_wq;
+	int conn_complete;
 	struct semaphore sem;

         unsigned short     rcls; /* The error codes we received */
Index: linux-2.6.7/fs/smbfs/inode.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7/fs/smbfs/inode.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 inode.c
--- linux-2.6.7/fs/smbfs/inode.c	16 Jun 2004 16:49:47 -0000	1.1.1.1
+++ linux-2.6.7/fs/smbfs/inode.c	19 Jun 2004 21:19:04 -0000
@@ -521,6 +521,7 @@ int smb_fill_super(struct super_block *s
 	server->super_block = sb;
 	server->mnt = NULL;
 	server->sock_file = NULL;
+	init_waitqueue_head(&server->conn_wq);
 	init_MUTEX(&server->sem);
 	INIT_LIST_HEAD(&server->entry);
 	INIT_LIST_HEAD(&server->xmitq);
Index: linux-2.6.7/fs/smbfs/proc.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7/fs/smbfs/proc.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 proc.c
--- linux-2.6.7/fs/smbfs/proc.c	16 Jun 2004 16:49:47 -0000	1.1.1.1
+++ linux-2.6.7/fs/smbfs/proc.c	20 Jun 2004 00:26:57 -0000
@@ -56,6 +56,7 @@ static struct smb_ops smb_ops_os2;
 static struct smb_ops smb_ops_win95;
 static struct smb_ops smb_ops_winNT;
 static struct smb_ops smb_ops_unix;
+static struct smb_ops smb_ops_null;

 static void
 smb_init_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
@@ -981,6 +982,9 @@ smb_newconn(struct smb_sb_info *server,
 	smbiod_wake_up();
 	if (server->opt.capabilities & SMB_CAP_UNIX)
 		smb_proc_query_cifsunix(server);
+
+	server->conn_complete++;
+	wake_up_interruptible_all(&server->conn_wq);
 	return error;

 out:
@@ -2794,10 +2798,45 @@ out:
 }

 static int
+smb_proc_ops_wait(struct smb_sb_info *server)
+{
+	int result;
+
+	result = wait_event_interruptible_timeout(server->conn_wq,
+				server->conn_complete, 30*HZ);
+
+	if (!result || signal_pending(current))
+		return -EIO;
+
+	return 0;
+}
+
+static int
 smb_proc_getattr_null(struct smb_sb_info *server, struct dentry *dir,
-		      struct smb_fattr *attr)
+			  struct smb_fattr *fattr)
 {
-	return -EIO;
+	int result;
+
+	if (smb_proc_ops_wait(server) < 0)
+		return -EIO;
+
+	smb_init_dirent(server, fattr);
+	result = server->ops->getattr(server, dir, fattr);
+	smb_finish_dirent(server, fattr);
+
+	return result;
+}
+
+static int
+smb_proc_readdir_null(struct file *filp, void *dirent, filldir_t filldir,
+		      struct smb_cache_control *ctl)
+{
+	struct smb_sb_info *server = server_from_dentry(filp->f_dentry);
+
+	if (smb_proc_ops_wait(server) < 0)
+		return -EIO;
+
+	return server->ops->readdir(filp, dirent, filldir, ctl);
 }

 int
@@ -3431,6 +3470,7 @@ static struct smb_ops smb_ops_unix =
 /* Place holder until real ops are in place */
 static struct smb_ops smb_ops_null =
 {
+	.readdir	= smb_proc_readdir_null,
 	.getattr	= smb_proc_getattr_null,
 };

