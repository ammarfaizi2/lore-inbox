Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbWHDFnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbWHDFnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWHDFnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:43:24 -0400
Received: from mx1.suse.de ([195.135.220.2]:29668 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030309AbWHDFnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:43:21 -0400
Date: Thu, 3 Aug 2006 22:38:30 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, Greg KH <gregkh@suse.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Eugene Teo <eteo@redhat.com>,
       Marcel Holtmann <marcel@holtmann.org>
Subject: [patch 02/23] Dont allow chmod() on the /proc/<pid>/ files
Message-ID: <20060804053830.GC769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="don-t-allow-chmod-on-the-proc-pid-files.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Marcel Holtmann <marcel@holtmann.org>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/proc/base.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

--- linux-2.6.17.7.orig/fs/proc/base.c
+++ linux-2.6.17.7/fs/proc/base.c
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

--
