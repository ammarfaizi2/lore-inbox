Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129476AbQKUESA>; Mon, 20 Nov 2000 23:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbQKUERu>; Mon, 20 Nov 2000 23:17:50 -0500
Received: from asbestos.linuxcare.com.au ([203.17.0.30]:7151 "HELO rockhopper")
	by vger.kernel.org with SMTP id <S129476AbQKUERa>;
	Mon, 20 Nov 2000 23:17:30 -0500
From: Christopher Yeoh <cyeoh@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14873.61546.744658.589662@rockhopper.linuxcare.com.au>
Date: Tue, 21 Nov 2000 14:47:54 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Attempt to hard link across filesystems results in un-unmountable filesystem
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

In 2.4-test11 attempting to hard link a file across filesystems (the
link does fail correctly) results in one of the filesystems (the one
the hard link was to be created on) to be in a state such that it
can't be unmounted.

The attached patch fixes this problem.

Chris.

--- fs/namei.c.orig	Tue Nov 21 14:34:54 2000
+++ fs/namei.c	Tue Nov 21 14:34:22 2000
@@ -1607,7 +1607,7 @@
 			goto out;
 		error = -EXDEV;
 		if (old_nd.mnt != nd.mnt)
-			goto out;
+			goto out2;
 		new_dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(new_dentry);
 		if (!IS_ERR(new_dentry)) {
@@ -1615,6 +1615,7 @@
 			dput(new_dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
+out2:
 		path_release(&nd);
 out:
 		path_release(&old_nd);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
