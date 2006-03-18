Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWCRNQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWCRNQX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 08:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWCRNQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 08:16:23 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:49335 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932184AbWCRNQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 08:16:22 -0500
Message-ID: <441C0774.C5FA688D@tv-sign.ru>
Date: Sat, 18 Mar 2006 16:13:24 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       janak@us.ibm.com, viro@ftp.linux.org.uk, hch@lst.de,
       mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: [PATCH] implement unshare(CLONE_SIGHAND) for single-thread case
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>
		<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
		<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on top of (already merged)
	unshare-use-rcu_assign_pointer-when-setting-sighand.patch
depends on
	convert-sighand_cache-to-use-slab_destroy_by_rcu.patch

Implement unshare(CLONE_SIGHAND) for single-thread case.

I think it is not possible to do it for multithread case without
complication of copy_process().

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/fork.c~	2006-03-18 16:23:23.000000000 +0300
+++ MM/kernel/fork.c	2006-03-18 17:00:39.000000000 +0300
@@ -1483,18 +1483,24 @@ static int unshare_namespace(unsigned lo
 }
 
 /*
- * Unsharing of sighand for tasks created with CLONE_SIGHAND is not
- * supported yet
+ * Unsharing of sighand is only supported for single-thread applications
  */
 static int unshare_sighand(unsigned long unshare_flags, struct sighand_struct **new_sighp)
 {
-	struct sighand_struct *sigh = current->sighand;
-
 	if ((unshare_flags & CLONE_SIGHAND) &&
-	    (sigh && atomic_read(&sigh->count) > 1))
-		return -EINVAL;
-	else
-		return 0;
+			atomic_read(&current->sighand->count) > 1) {
+
+		if (!thread_group_empty(current))
+			return -EINVAL;
+
+		*new_sighp = kmem_cache_alloc(sighand_cachep, GFP_KERNEL);
+		if (unlikely(*new_sighp == NULL))
+			return -ENOMEM;
+
+		atomic_set(&(*new_sighp)->count, 1);
+	}
+
+	return 0;
 }
 
 /*
@@ -1579,7 +1585,18 @@ asmlinkage long sys_unshare(unsigned lon
 	if ((err = unshare_semundo(unshare_flags, &new_ulist)))
 		goto bad_unshare_cleanup_fd;
 
-	if (new_fs || new_ns || new_sigh || new_mm || new_fd || new_ulist) {
+	if (new_sigh) {
+		sigh = current->sighand;
+		write_lock_irq(&tasklist_lock);
+		spin_lock(&sigh->siglock);
+		memcpy(new_sigh->action, sigh->action, sizeof(sigh->action));
+		rcu_assign_pointer(current->sighand, new_sigh);
+		spin_unlock(&sigh->siglock);
+		write_unlock_irq(&tasklist_lock);
+		new_sigh = sigh;
+	}
+
+	if (new_fs || new_ns || new_mm || new_fd || new_ulist) {
 
 		task_lock(current);
 
@@ -1595,12 +1612,6 @@ asmlinkage long sys_unshare(unsigned lon
 			new_ns = ns;
 		}
 
-		if (new_sigh) {
-			sigh = current->sighand;
-			rcu_assign_pointer(current->sighand, new_sigh);
-			new_sigh = sigh;
-		}
-
 		if (new_mm) {
 			mm = current->mm;
 			active_mm = current->active_mm;
