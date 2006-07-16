Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946035AbWGPAVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946035AbWGPAVW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWGPAVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:21:21 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:58326 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S964815AbWGPAVV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:21:21 -0400
Subject: Re: Linux 2.6.17.6
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
In-Reply-To: <1153009083.12764.18.camel@localhost>
References: <20060715193552.GA5330@kroah.com>
	 <1153009083.12764.18.camel@localhost>
Content-Type: multipart/mixed; boundary="=-GEkV6TiuevxoGz9GQfPH"
Date: Sun, 16 Jul 2006 02:20:53 +0200
Message-Id: <1153009253.12764.20.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GEkV6TiuevxoGz9GQfPH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Greg,

> > This should fix the reported issue of NetworkManager dying when using
> > the 2.6.17.5 kernel release.  All users of the 2.6.17 kernel are
> > recommended to upgrade to this kernel, as it fixes a publicly known
> > security issue that can provide root access to any local user of the
> > machine.
> 
> attached is the backported "don't allow chmod()" patch. Please consider
> including it into the next stable release. Since the 2.6.17.6 kernel is
> no longer vulnerable against CVE-2006-3626, this has no real urgent need
> to get out.

actually attaching the patch might help ;)

Regards

Marcel


--=-GEkV6TiuevxoGz9GQfPH
Content-Disposition: attachment; filename=patch-dont-allow-chmod-on-proc
Content-Type: text/plain; name=patch-dont-allow-chmod-on-proc; charset=utf-8
Content-Transfer-Encoding: 7bit

Don't allow chmod() on the /proc/<pid>/ files

This just turns off chmod() on the /proc/<pid>/ files, since there is no
good reason to allow it, and had we disallowed it originally, the nasty
/proc race exploit wouldn't have been possible.

The other patches already fixed the problem chmod() could cause, so this
is really just some final mop-up..

This particular version is based off a patch by Eugene and Marcel which
had much better naming than my original equivalent one.

Signed-off-by: Eugene Teo <eteo@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>

---
commit 5aa433ab7de5110cc76d19763e2e6424279bcf79
tree 51ce3e286807c56567eb05ec835e7c3d84f42eba
parent 245b3c810f1d09ac27f326346cb58451556ecc0b
author Marcel Holtmann <marcel@holtmann.org> Sun, 16 Jul 2006 02:13:16 +0200
committer Marcel Holtmann <marcel@holtmann.org> Sun, 16 Jul 2006 02:13:16 +0200

 fs/proc/base.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f801693..a3b825f 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -596,6 +596,27 @@ static int proc_permission(struct inode 
 	return proc_check_root(inode);
 }
 
+static int proc_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	int error;
+	struct inode *inode = dentry->d_inode;
+
+	if (attr->ia_valid & ATTR_MODE)
+		return -EPERM;
+
+	error = inode_change_ok(inode, attr);
+	if (!error) {
+		error = security_inode_setattr(dentry, attr);
+		if (!error)
+			error = inode_setattr(inode, attr);
+	}
+	return error;
+}
+
+static struct inode_operations proc_def_inode_operations = {
+	.setattr	= proc_setattr,
+};
+
 static int proc_task_permission(struct inode *inode, int mask, struct nameidata *nd)
 {
 	struct dentry *root;
@@ -987,6 +1008,7 @@ static struct file_operations proc_oom_a
 
 static struct inode_operations proc_mem_inode_operations = {
 	.permission	= proc_permission,
+	.setattr	= proc_setattr,
 };
 
 #ifdef CONFIG_AUDITSYSCALL
@@ -1184,7 +1206,8 @@ out:
 
 static struct inode_operations proc_pid_link_inode_operations = {
 	.readlink	= proc_pid_readlink,
-	.follow_link	= proc_pid_follow_link
+	.follow_link	= proc_pid_follow_link,
+	.setattr	= proc_setattr,
 };
 
 #define NUMBUF 10
@@ -1356,6 +1379,7 @@ static struct inode *proc_pid_make_inode
 	ei->task = NULL;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
+	inode->i_op = &proc_def_inode_operations;
 
 	if (!pid_alive(task))
 		goto out_unlock;
@@ -1579,11 +1603,13 @@ static struct file_operations proc_task_
 static struct inode_operations proc_fd_inode_operations = {
 	.lookup		= proc_lookupfd,
 	.permission	= proc_permission,
+	.setattr	= proc_setattr,
 };
 
 static struct inode_operations proc_task_inode_operations = {
 	.lookup		= proc_task_lookup,
 	.permission	= proc_task_permission,
+	.setattr	= proc_setattr,
 };
 
 #ifdef CONFIG_SECURITY
@@ -1873,10 +1899,12 @@ static struct file_operations proc_tid_b
 
 static struct inode_operations proc_tgid_base_inode_operations = {
 	.lookup		= proc_tgid_base_lookup,
+	.setattr	= proc_setattr,
 };
 
 static struct inode_operations proc_tid_base_inode_operations = {
 	.lookup		= proc_tid_base_lookup,
+	.setattr	= proc_setattr,
 };
 
 #ifdef CONFIG_SECURITY
@@ -1918,10 +1946,12 @@ static struct dentry *proc_tid_attr_look
 
 static struct inode_operations proc_tgid_attr_inode_operations = {
 	.lookup		= proc_tgid_attr_lookup,
+	.setattr	= proc_setattr,
 };
 
 static struct inode_operations proc_tid_attr_inode_operations = {
 	.lookup		= proc_tid_attr_lookup,
+	.setattr	= proc_setattr,
 };
 #endif
 
@@ -1946,6 +1976,7 @@ static void *proc_self_follow_link(struc
 static struct inode_operations proc_self_inode_operations = {
 	.readlink	= proc_self_readlink,
 	.follow_link	= proc_self_follow_link,
+	.setattr	= proc_setattr,
 };
 
 /**

--=-GEkV6TiuevxoGz9GQfPH--

