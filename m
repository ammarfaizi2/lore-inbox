Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261818AbUJZAPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbUJZAPw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUJYPEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:04:20 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:8873 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261889AbUJYOwY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:52:24 -0400
Cc: raven@themaw.net
Subject: [PATCH 27/28] Testing syscall for expiry
In-Reply-To: <1098715902968@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:52:12 -0400
Message-Id: <1098715932358@sun.com>
References: <1098715902968@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a temporary syscall (to x86 only) that allows for quick
testing to make sure that mnt_expire works properly.  Tests can be found in
the autofsng userspace package.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 arch/i386/kernel/entry.S  |    1 +
 fs/namespace.c            |   32 ++++++++++++++++++++++++++++++++
 include/asm-i386/unistd.h |    3 ++-
 3 files changed, 35 insertions(+), 1 deletion(-)

Index: linux-2.6.9-quilt/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.9-quilt.orig/arch/i386/kernel/entry.S	2004-10-22 17:17:40.735271440 -0400
+++ linux-2.6.9-quilt/arch/i386/kernel/entry.S	2004-10-22 17:17:48.436100736 -0400
@@ -903,5 +903,6 @@ ENTRY(sys_call_table)
 	.long sys_ni_syscall
 	.long sys_ni_syscall
 	.long sys_mountfd		/* 300 */
+	.long sys_mnt_expire
 
 syscall_table_size=(.-sys_call_table)
Index: linux-2.6.9-quilt/include/asm-i386/unistd.h
===================================================================
--- linux-2.6.9-quilt.orig/include/asm-i386/unistd.h	2004-10-22 17:17:40.735271440 -0400
+++ linux-2.6.9-quilt/include/asm-i386/unistd.h	2004-10-22 17:17:48.436100736 -0400
@@ -290,8 +290,9 @@
 #define __NR_mq_getsetattr	(__NR_mq_open+5)
 #define __NR_sys_kexec_load	283
 #define __NR_mountfd		300
+#define __NR_mnt_expire		301
 
-#define NR_syscalls 301
+#define NR_syscalls 302
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
Index: linux-2.6.9-quilt/fs/namespace.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/namespace.c	2004-10-22 17:17:47.809196040 -0400
+++ linux-2.6.9-quilt/fs/namespace.c	2004-10-22 17:17:48.437100584 -0400
@@ -1119,6 +1119,38 @@ static void bump_expiry_counter(struct v
 		parent->mnt_expiry_countdown = diff;
 }
 
+/* TESTING PURPOSES ONLY:  THIS IS NOT A REAL SYSCALL!! - IT WILL GO AWAY */
+asmlinkage int sys_mnt_expire(char __user *_path, int ticks)
+{
+	struct nameidata nd;
+	char *path;
+	int err;
+
+	path = getname(_path);
+	err = PTR_ERR(path);
+	if (IS_ERR(path))
+		goto out;
+
+	err = path_lookup(path, LOOKUP_FOLLOW|LOOKUP_DIRECTORY|LOOKUP_NOALT, &nd);
+	if (err)
+		goto out_name;
+
+	err = -EINVAL;
+	if (nd.mnt->mnt_root != nd.dentry)
+		goto out_nd;
+
+	err = -EBUSY;
+	if (!mnt_expire(nd.mnt, ticks))
+		err = 0;
+
+out_nd:
+	path_release(&nd);
+out_name:
+	putname(path);
+out:
+	return err;
+}
+
 /*
  * process a list of expirable mountpoints with the intent of discarding any
  * mountpoints that aren't in use and haven't been touched since last we came

