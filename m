Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWCBW3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWCBW3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWCBW3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:29:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750899AbWCBW3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:29:01 -0500
Date: Thu, 2 Mar 2006 14:31:11 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060302143111.6889f221.akpm@osdl.org>
In-Reply-To: <20060302221102.2814c07a@werewolf.auna.net>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<4405723E.5060606@free.fr>
	<20060301023235.735c8c47.akpm@osdl.org>
	<20060301152246.77c24ae8@werewolf.auna.net>
	<20060301205138.12ec91b1.akpm@osdl.org>
	<20060302221102.2814c07a@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> What I have collected till now is below (against -mm2-pre1). What is
> (not) needed from this ? Thanks...

You should need only the below:


--- devel/fs/dcache.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix-2	2006-03-01 21:41:16.000000000 -0800
+++ devel-akpm/fs/dcache.c	2006-03-01 21:41:16.000000000 -0800
@@ -1177,6 +1177,9 @@ void d_delete(struct dentry * dentry)
 	spin_lock(&dentry->d_lock);
 	isdir = S_ISDIR(dentry->d_inode->i_mode);
 	if (atomic_read(&dentry->d_count) == 1) {
+		/* remove this and other inotify debug checks after 2.6.18 */
+		dentry->d_flags &= ~DCACHE_INOTIFY_PARENT_WATCHED;
+
 		dentry_iput(dentry);
 		fsnotify_nameremove(dentry, isdir);
 		return;
diff -puN fs/inotify.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix-2 fs/inotify.c
--- devel/fs/inotify.c~inotify-lock-avoidance-with-parent-watch-status-in-dentry-fix-2	2006-03-01 21:41:16.000000000 -0800
+++ devel-akpm/fs/inotify.c	2006-03-01 21:41:16.000000000 -0800
@@ -390,6 +390,7 @@ static inline int inotify_inode_watched(
 
 /*
  * Get child dentry flag into synch with parent inode.
+ * Flag should always be clear for negative dentrys.
  */
 static void set_dentry_child_flags(struct inode *inode, int watched)
 {
@@ -400,6 +401,10 @@ static void set_dentry_child_flags(struc
 		struct dentry *child;
 
 		list_for_each_entry(child, &alias->d_subdirs, d_u.d_child) {
+			if (!child->d_inode) {
+				WARN_ON(child->d_flags & DCACHE_INOTIFY_PARENT_WATCHED);
+				continue;
+			}
 			spin_lock(&child->d_lock);
 			if (watched) {
 				WARN_ON(child->d_flags &
_


Anyway, I think things are pretty much sorted out now so I'll try to do mm2
today (approx 12 hours hence).
