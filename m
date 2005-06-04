Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVFDGbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVFDGbI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 02:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVFDGbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 02:31:06 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:53007 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S261258AbVFDGTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 02:19:41 -0400
Date: Sat, 4 Jun 2005 14:10:16 +0800 (WST)
From: raven@themaw.net
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] autofs4 - avoid panic on bind mount of autofs owned directory
 (fwd)
Message-ID: <Pine.LNX.4.62.0506041408500.8459@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-98.1, required 8,
	NO_REAL_NAME, RCVD_IN_ORBS, RCVD_IN_OSIRUSOFT_COM, USER_AGENT_PINE,
	USER_IN_WHITELIST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ----------
Date: Sat, 4 Jun 2005 14:02:36 +0800 (WST)
From: raven@themaw.net
To: Andrew Morton <akpm@osdl.org>
Cc: Dan@Merillat.org, Steinar H. Gunderson <sgunderson@bigfoot.com>,
    Michael Blandford <michael@kmaclub.com>, Jeff Moyer <jmoyer@redhat.com>
Subject: [PATCH] autofs4 - avoid panic on bind mount of autofs owned directory


While this is not a solution to bind and move mounts on autofs owned 
directories it is necessary to fix the trady error handling.

At least it avoids the kernel panic I observed checking out bug #4589.

Signed-off-by: Ian Kent <raven@themaw.net>

diff -Nurp linux-2.6.12-rc5-mm1.orig/fs/autofs4/autofs_i.h linux-2.6.12-rc5-mm1/fs/autofs4/autofs_i.h
--- linux-2.6.12-rc5-mm1.orig/fs/autofs4/autofs_i.h	2005-05-29 14:37:27.000000000 +0800
+++ linux-2.6.12-rc5-mm1/fs/autofs4/autofs_i.h	2005-05-29 14:32:35.000000000 +0800
@@ -185,6 +185,19 @@ int autofs4_wait(struct autofs_sb_info *
 int autofs4_wait_release(struct autofs_sb_info *,autofs_wqt_t,int);
 void autofs4_catatonic_mode(struct autofs_sb_info *);
 
+static inline int autofs4_follow_mount(struct vfsmount **mnt, struct dentry **dentry)
+{
+	int res = 0;
+
+	while (d_mountpoint(*dentry)) {
+		int followed = follow_down(mnt, dentry);
+		if (!followed)
+			break;
+		res = 1;
+	}
+	return res;
+}
+
 static inline int simple_positive(struct dentry *dentry)
 {
 	return dentry->d_inode && !d_unhashed(dentry);
diff -Nurp linux-2.6.12-rc5-mm1.orig/fs/autofs4/expire.c linux-2.6.12-rc5-mm1/fs/autofs4/expire.c
--- linux-2.6.12-rc5-mm1.orig/fs/autofs4/expire.c	2005-05-29 14:37:27.000000000 +0800
+++ linux-2.6.12-rc5-mm1/fs/autofs4/expire.c	2005-05-29 14:32:35.000000000 +0800
@@ -56,12 +56,9 @@ static int autofs4_check_mount(struct vf
 	mntget(mnt);
 	dget(dentry);
 
-	if (!follow_down(&mnt, &dentry))
+	if (!autofs4_follow_mount(&mnt, &dentry))
 		goto done;
 
-	while (d_mountpoint(dentry) && follow_down(&mnt, &dentry))
-		;
-
 	/* This is an autofs submount, we can't expire it */
 	if (is_autofs4_dentry(dentry))
 		goto done;
diff -Nurp linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c linux-2.6.12-rc5-mm1/fs/autofs4/root.c
--- linux-2.6.12-rc5-mm1.orig/fs/autofs4/root.c	2005-05-29 14:37:27.000000000 +0800
+++ linux-2.6.12-rc5-mm1/fs/autofs4/root.c	2005-05-29 14:32:35.000000000 +0800
@@ -205,7 +205,11 @@ static int autofs4_dir_open(struct inode
 		struct vfsmount *fp_mnt = mntget(mnt);
 		struct dentry *fp_dentry = dget(dentry);
 
-		while (follow_down(&fp_mnt, &fp_dentry) && d_mountpoint(fp_dentry));
+		if (!autofs4_follow_mount(&fp_mnt, &fp_dentry)) {
+			dput(fp_dentry);
+			mntput(fp_mnt);
+			return -ENOENT;
+		}
 
 		fp = dentry_open(fp_dentry, fp_mnt, file->f_flags);
 		status = PTR_ERR(fp);

