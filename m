Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUBPOyL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 09:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265615AbUBPOyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 09:54:11 -0500
Received: from fungus.teststation.com ([212.32.186.211]:36365 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id S265592AbUBPOyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 09:54:01 -0500
Date: Mon, 16 Feb 2004 15:53:28 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: puw@cola.local
To: Nico Schottelius <nico-kernel@schottelius.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: smbfs / loop: problematic or not unuseable?
In-Reply-To: <20040216134628.GL1881@schottelius.org>
Message-ID: <Pine.LNX.4.44.0402161549530.7756-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Nico Schottelius wrote:

> Hello!
> 
> While still suffering from my more or less dead harddisk I am seeing
> other nice problems. I copied my blowfish encrypted partition to a samba
> server. Now I want to mount it and use it:
> 
> pc-it-nico# mount
> [...]
> //fs2/home on /home/nico/fs2 type smbfs (rw)
> 
> pc-it-nico# mount /home/nico/fs2/home-13-Feb-2004.tar.crypt /tmp/ -o loop,encryption=blowfish 
> Password: 
> ioctl: LOOP_SET_FD: Invalid argument

Yes, it is known. You can try the patch below.

I don't know if there is anything more to supporting sendfile than this.
smb_file_sendfile follows the same pattern as the other smb_file_*
operations.

/Urban


diff -urN -X exclude linux-2.6.3-rc1-orig/fs/smbfs/file.c linux-2.6.3-rc1-smbfs/fs/smbfs/file.c
--- linux-2.6.3-rc1-orig/fs/smbfs/file.c	Mon Feb  9 19:04:47 2004
+++ linux-2.6.3-rc1-smbfs/fs/smbfs/file.c	Sun Feb 15 19:14:06 2004
@@ -257,6 +257,27 @@
 	return status;
 }
 
+static ssize_t
+smb_file_sendfile(struct file *file, loff_t *ppos,
+		  size_t count, read_actor_t actor, void __user *target)
+{
+	struct dentry *dentry = file->f_dentry;
+	ssize_t status;
+
+	VERBOSE("file %s/%s, pos=%Ld, count=%d\n",
+		DENTRY_PATH(dentry), *ppos, count);
+
+	status = smb_revalidate_inode(dentry);
+	if (status) {
+		PARANOIA("%s/%s validation failed, error=%d\n",
+			 DENTRY_PATH(dentry), status);
+		goto out;
+	}
+	status = generic_file_sendfile(file, ppos, count, actor, target);
+out:
+	return status;
+}
+
 /*
  * This does the "real" work of the write. The generic routine has
  * allocated the page, locked it, done all the page alignment stuff
@@ -388,6 +409,7 @@
 	.open		= smb_file_open,
 	.release	= smb_file_release,
 	.fsync		= smb_fsync,
+	.sendfile	= smb_file_sendfile,
 };
 
 struct inode_operations smb_file_inode_operations =
diff -urN -X exclude linux-2.6.3-rc1-orig/fs/smbfs/proc.c linux-2.6.3-rc1-smbfs/fs/smbfs/proc.c
--- linux-2.6.3-rc1-orig/fs/smbfs/proc.c	Mon Feb  9 19:08:39 2004
+++ linux-2.6.3-rc1-smbfs/fs/smbfs/proc.c	Sun Feb 15 19:16:40 2004
@@ -1015,12 +1015,6 @@
 	p += 19;
 	p += 8;
 
-	/* FIXME: the request will fail if the 'tid' is changed. This
-	   should perhaps be set just before transmitting ... */
-	WSET(req->rq_header, smb_tid, server->opt.tid);
-	WSET(req->rq_header, smb_pid, 1);
-	WSET(req->rq_header, smb_uid, server->opt.server_uid);
-
 	if (server->opt.protocol > SMB_PROTOCOL_CORE) {
 		int flags = SMB_FLAGS_CASELESS_PATHNAMES;
 		int flags2 = SMB_FLAGS2_LONG_PATH_COMPONENTS |
diff -urN -X exclude linux-2.6.3-rc1-orig/fs/smbfs/request.c linux-2.6.3-rc1-smbfs/fs/smbfs/request.c
--- linux-2.6.3-rc1-orig/fs/smbfs/request.c	Fri Jan  9 08:00:13 2004
+++ linux-2.6.3-rc1-smbfs/fs/smbfs/request.c	Sun Feb 15 16:41:34 2004
@@ -384,6 +384,12 @@
 	struct smb_sb_info *server = req->rq_server;
 	int result;
 
+	if (req->rq_bytes_sent == 0) {
+		WSET(req->rq_header, smb_tid, server->opt.tid);
+		WSET(req->rq_header, smb_pid, 1);
+		WSET(req->rq_header, smb_uid, server->opt.server_uid);
+	}
+
 	result = smb_send_request(req);
 	if (result < 0 && result != -EAGAIN)
 		goto out;
diff -urN -X exclude linux-2.6.3-rc1-orig/fs/smbfs/smbiod.c linux-2.6.3-rc1-smbfs/fs/smbfs/smbiod.c
--- linux-2.6.3-rc1-orig/fs/smbfs/smbiod.c	Fri Jan  9 07:59:45 2004
+++ linux-2.6.3-rc1-smbfs/fs/smbfs/smbiod.c	Sun Feb 15 16:44:07 2004
@@ -161,6 +161,9 @@
 	while (head != &server->xmitq) {
 		req = list_entry(head, struct smb_request, rq_queue);
 		head = head->next;
+
+		WSET(req->rq_header, smb_uid, -1);
+		req->rq_bytes_sent = 0;
 		if (req->rq_flags & SMB_REQ_NORETRY) {
 			VERBOSE("aborting request %p on xmitq\n", req);
 			req->rq_errno = -EIO;

