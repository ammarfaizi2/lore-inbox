Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUA1Ao4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 19:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265678AbUA1Ao4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 19:44:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:34789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265680AbUA1Aow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 19:44:52 -0500
Date: Tue, 27 Jan 2004 16:46:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: thockin@sun.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: NGROUPS 2.6.2rc2
Message-Id: <20040127164615.38fd992e.akpm@osdl.org>
In-Reply-To: <20040127225311.GA9155@sun.com>
References: <20040127225311.GA9155@sun.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@sun.com> wrote:
>
> Attached is a patch to remove the NGROUPS limit (again).

+/* export the group_info to a user-space array */
+static int groups_to_user(gid_t *grouplist, struct group_info __user *info)
+{
+	int i;
+	int count = info->ngroups;
+
+	for (i = 0; i < info->nblocks; i++) {
+		int cp_count = min(NGROUPS_BLOCK, count);
+		int off = i * NGROUPS_BLOCK;
+		int len = cp_count * sizeof(*grouplist);
+
+		if (copy_to_user(grouplist+off, info->blocks[i], len))
+			return -EFAULT;
+

This had me thorougly confused for a while ;) The __user tag here should
apply to grouplist, not to info.


+static int groups16_to_user(old_gid_t __user *grouplist,
+    struct group_info *info)
+{
+	int i;
+	old_gid_t group;
+
+	if (info->ngroups > TASK_SIZE/sizeof(group))
+		return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, grouplist, info->ngroups * sizeof(group)))
+		return -EFAULT;

Why are many functions playing with TASK_SIZE?

--- 1.2/fs/nfsd/auth.c	Tue Jun 17 16:31:29 2003
+++ edited/fs/nfsd/auth.c	Tue Jan 27 12:40:02 2004
@@ -10,12 +10,15 @@
 #include <linux/sunrpc/svcauth.h>
 #include <linux/nfsd/nfsd.h>
 
+extern asmlinkage long sys_setgroups(int gidsetsize, gid_t *grouplist);
+

rant.  We have soooo many syscalls declared in .c files.  We had a bug due
to this a while back.  Problem is, we have no anointed header in which to
place them.  include/linux/syscalls.h would suit.  And unistd.h for
arch-specific syscalls.  But that's not appropriate to this patch.

