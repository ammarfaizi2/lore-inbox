Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUFGRpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUFGRpb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 13:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264961AbUFGRpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 13:45:31 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:44479 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264949AbUFGRpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 13:45:04 -0400
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Missing BKL in sys_chroot() for 2.6
Date: Sun, 6 Jun 2004 19:58:48 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406061958.48262.blaisorblade_spam@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(PLEASE cc me on replies as I'm not subscribed).

Set_fs_root *claims* it wants the BKL held:

/*
 * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
 * It can block. Requires the big lock held.
 */
void set_fs_root(struct fs_struct *fs, struct vfsmount *mnt,
                 struct dentry *dentry)

But sys_chroot ignores this. So I attach this patch (apply with patch -p1 -l). 
Maybe the solution is to kill that comment, maybe not (sys_pivot_root() calls 
chroot_fs_refs() -> set_fs_root() with the BKL held, but that has a lot of 
reasons other than this). If that comment is correct, however, it probably 
holds even for set_fs_altroot(), since it's similar. So this patch adds it.


TESTING: none, I'm sure about the inconsistency, a lot less about the solution 
(no kernel manual explains the BKL, since it is a relict; except the ones who 
still says it blocks all the rest of the kernel, while I think it is just a 
recursive and "sleepable" spinlock - am I correct?).

--- vanilla-linux-2.6.6/fs/open.c.saved 2004-05-10 21:37:11.000000000 +0200
+++ vanilla-linux-2.6.6/fs/open.c       2004-06-06 19:40:20.000000000 +0200
@@ -581,8 +581,13 @@
        if (!capable(CAP_SYS_CHROOT))
                goto dput_and_out;

+       lock_kernel();
+
        set_fs_root(current->fs, nd.mnt, nd.dentry);
        set_fs_altroot();
+
+       unlock_kernel();
+
        error = 0;
 dput_and_out:
        path_release(&nd);
--- vanilla-linux-2.6.6/fs/namei.c.saved        2004-05-10 21:37:09.000000000 
+0200
+++ vanilla-linux-2.6.6/fs/namei.c      2004-06-06 19:49:25.000000000 +0200
@@ -814,6 +814,9 @@
        return 1;
 }

+/*
+ * Requires the big lock held.
+ */
 void set_fs_altroot(void)
 {
        char *emul = __emul_prefix();

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


