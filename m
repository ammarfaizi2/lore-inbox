Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267312AbUIIVwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267312AbUIIVwQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUIIVvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:51:22 -0400
Received: from open.hands.com ([195.224.53.39]:16349 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S266196AbUIIVpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:45:17 -0400
Date: Thu, 9 Sep 2004 22:56:32 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: new function proc_task_dentry_lookup() based on proc_exe_link() where should it go?
Message-ID: <20040909215632.GA11785@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for the ipt_owner patch to include netfilter support by program name,
i've had to cut/paste / make-use-of some code in fs/proc/base.c.

where _should_ this code go, and is there some functionality that
already exists that is identical to what i have called
proc_task_dentry_lookup().

if so, why isn't it being used by fs/proc/base.c?
[not a trick question, just an honest appraisal]

if not, where _could_ this new function go that's more
appropriate, such that i don't have to rely on CONFIG_FS_PROC
for something totally unrelated [ipt_owner.c of all things!]

l.


	Index: fs/proc/base.c
	===================================================================
	RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/proc/base.c,v
	retrieving revision 1.1.1.9
	diff -u -u -r1.1.1.9 base.c
	--- fs/proc/base.c	18 Jun 2004 19:30:20 -0000	1.1.1.9
	+++ fs/proc/base.c	9 Sep 2004 15:32:32 -0000
	@@ -206,11 +206,12 @@
		return -ENOENT;
	 }
	 
	-static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
	+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, struct vfsmount **mnt);
	+
	+int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, struct vfsmount **mnt)
	 {
		struct vm_area_struct * vma;
		int result = -ENOENT;
	-	struct task_struct *task = proc_task(inode);
		struct mm_struct * mm = get_task_mm(task);
	 
		if (!mm)
	@@ -233,6 +234,11 @@
		return result;
	 }
	 
	+static int proc_exe_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
	+{
	+	return proc_task_dentry_lookup(proc_task(inode), dentry, mnt);
	+}
	+
	 static int proc_cwd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
	 {
		struct fs_struct *fs;
	Index: fs/proc/root.c
	===================================================================
	RCS file: /cvsroot/selinux/nsa/linux-2.6/fs/proc/root.c,v
	retrieving revision 1.1.1.2
	diff -u -u -r1.1.1.2 root.c
	--- fs/proc/root.c	8 Apr 2004 14:13:50 -0000	1.1.1.2
	+++ fs/proc/root.c	9 Sep 2004 15:32:32 -0000
	@@ -147,6 +147,8 @@
		.parent		= &proc_root,
	 };
	 
	+extern int proc_task_dentry_lookup(struct task_struct *task, struct dentry **dentry, struct vfsmount **mnt);
	+
	 #ifdef CONFIG_SYSCTL
	 EXPORT_SYMBOL(proc_sys_root);
	 #endif
	@@ -159,3 +161,4 @@
	 EXPORT_SYMBOL(proc_net);
	 EXPORT_SYMBOL(proc_bus);
	 EXPORT_SYMBOL(proc_root_driver);
	+EXPORT_SYMBOL(proc_task_dentry_lookup);
	Index: include/linux/netfilter_ipv4/ipt_owner.h

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

