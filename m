Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUFSUdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUFSUdk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 16:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUFSUdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 16:33:40 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9429 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262574AbUFSUdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 16:33:35 -0400
Date: Sat, 19 Jun 2004 16:35:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Christophe Saout <christophe@saout.de>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.7 Samba OOPS (in smb_readdir)
In-Reply-To: <1087586532.9085.1.camel@leto.cs.pocnet.net>
Message-ID: <Pine.LNX.4.58.0406191624430.2228@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> 
 <20040618163759.GN1146@ens-lyon.fr> <20040618164125.GO1146@ens-lyon.fr> 
 <Pine.LNX.4.58.0406181309440.2228@montezuma.fsmlabs.com> 
 <1087585251.13235.3.camel@leto.cs.pocnet.net> <1087586532.9085.1.camel@leto.cs.pocnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Christophe Saout wrote:

> Well, it's not. :(
>
> The oops is gone but the processes are still hanging. I'm posting the
> SysRq-T trace on bugzilla. Hope it helps. If you need some help
> debugging the problem, please tell me if I can do something.

This is an updated debugging patch (which is also added to Bugzilla),
please give this a spin. There are still a few issues with this patch but
lets try at least avoid oopsing for now.

Index: linux-2.6.7/include/linux/smb_fs_sb.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.7/include/linux/smb_fs_sb.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smb_fs_sb.h
--- linux-2.6.7/include/linux/smb_fs_sb.h	16 Jun 2004 16:49:26 -0000	1.1.1.1
+++ linux-2.6.7/include/linux/smb_fs_sb.h	19 Jun 2004 20:22:35 -0000
@@ -57,7 +57,7 @@ struct smb_sb_info {
 	unsigned int generation;
 	pid_t conn_pid;
 	struct smb_conn_opt opt;
-
+	wait_queue_head_t conn_wq;
 	struct semaphore sem;

         unsigned short     rcls; /* The error codes we received */
Index: linux-2.6.7/fs/smbfs/inode.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7/fs/smbfs/inode.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 inode.c
--- linux-2.6.7/fs/smbfs/inode.c	16 Jun 2004 16:49:47 -0000	1.1.1.1
+++ linux-2.6.7/fs/smbfs/inode.c	19 Jun 2004 20:22:35 -0000
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
+++ linux-2.6.7/fs/smbfs/proc.c	19 Jun 2004 20:23:39 -0000
@@ -56,6 +56,7 @@ static struct smb_ops smb_ops_os2;
 static struct smb_ops smb_ops_win95;
 static struct smb_ops smb_ops_winNT;
 static struct smb_ops smb_ops_unix;
+static struct smb_ops smb_ops_null;

 static void
 smb_init_dirent(struct smb_sb_info *server, struct smb_fattr *fattr);
@@ -878,7 +879,6 @@ smb_newconn(struct smb_sb_info *server,
 	server->conn_pid = current->pid;
 	server->opt = *opt;
 	server->generation += 1;
-	server->state = CONN_VALID;
 	error = 0;

 	if (server->conn_error) {
@@ -981,6 +981,9 @@ smb_newconn(struct smb_sb_info *server,
 	smbiod_wake_up();
 	if (server->opt.capabilities & SMB_CAP_UNIX)
 		smb_proc_query_cifsunix(server);
+
+	server->state = CONN_VALID;
+	wake_up_interruptible_all(&server->conn_wq);
 	return error;

 out:
@@ -2794,10 +2797,48 @@ out:
 }

 static int
+smb_proc_ops_wait(struct smb_sb_info *server)
+{
+	int result;
+
+	result = wait_event_interruptible_timeout(server->conn_wq,
+				server->state == CONN_VALID, 30*HZ);
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
 	return -EIO;
+#if 0
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
+#endif
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
@@ -3431,6 +3472,7 @@ static struct smb_ops smb_ops_unix =
 /* Place holder until real ops are in place */
 static struct smb_ops smb_ops_null =
 {
+	.readdir	= smb_proc_readdir_null,
 	.getattr	= smb_proc_getattr_null,
 };

