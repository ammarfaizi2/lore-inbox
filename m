Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVGCTGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVGCTGA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVGCTF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:05:59 -0400
Received: from smtp104.mail.sc5.yahoo.com ([66.163.169.223]:53641 "HELO
	smtp104.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261493AbVGCTFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:05:16 -0400
Message-ID: <42C83759.1070809@asmallpond.org>
Date: Sun, 03 Jul 2005 21:07:05 +0200
From: Richard Fish <bigfish@asmallpond.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mount/umount badness after initramfs pivot_root
Content-Type: multipart/mixed;
 boundary="------------020908090900020308090207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020908090900020308090207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

Using 2.6.12, or 2.6.12.1 or 2.6.13-rc1, I have two problems with
mount/umount commands after I boot using an initramfs instead of an
initrd.  The problems are:

1. If I try to unmount the initramfs (umount /old_root), the system hangs.
2. If I try to use "mount --move", the system hangs.

Alt-SysRq-p still works, and I was able to determine that for #1, the
kernel gets into an endless loop in the following lines in umount_tree()
in fs/namespace.c:

    for (p = mnt; p; p = next_mnt(p, mnt)) {
        list_del(&p->mnt_list);
        list_add(&p->mnt_list, &kill);
    }

For #2, it appears the following lines in do_move_mount() in
fs/namespace.c cause the endless loop:

    for (p = nd->mnt; p->mnt_parent!=p; p = p->mnt_parent)
        if (p == old_nd.mnt)
            goto out2;

Problem #2 does not occur if I do not execute the pivot_root in my
initramfs, and neither problem occurs if I boot using an initrd, with or
without using pivot_root.

I added debug printk's to the detach_mnt and attach_mnt functions, which
produced the following when pivot_root is run:

detach_mnt: mnt=d7ee3300, old_nd=d7d39ee8
detach_mnt: mnt=d7ee3780, old_nd=d7d39ea8
attach_mnt: mnt=d7ee3780, nd=d7d39f28
            mnt->mnt_parent=d7ee3300
attach_mnt: mnt=d7ee3300, nd=d7d39ea8
            mnt->mnt_parent=d7ee3780

Notice the mnt->mnt_parent assignments in the attach_mnt calls...they
create a circular reference in the mount tree!

I have attached the best patch to pivot_root that I can come up with for
this.  It preserves the behavior for initrd (leaving the rootfs as the
top of the tree), while fixing the case where it is the rootfs that is
being pivoted.  This passes the WOMM test, but maybe there is a better
way? In particular, does something need to be done with
current->namespace->root in this case?

-Richard


--------------020908090900020308090207
Content-Type: text/plain;
 name="fix_pivot_root_from_rootfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix_pivot_root_from_rootfs.patch"

--- linux-2.6.13-rc1/fs/namespace.c.orig	2005-07-03 20:30:18.000000000 +0200
+++ linux-2.6.13-rc1/fs/namespace.c	2005-07-03 20:31:54.000000000 +0200
@@ -1344,6 +1344,9 @@
 		goto out3;
 	detach_mnt(new_nd.mnt, &parent_nd);
 	detach_mnt(user_nd.mnt, &root_parent);
+	if (user_nd.mnt == current->namespace->root) {
+		root_parent.mnt = new_nd.mnt; /* avoid creating a mount loop */
+	}
 	attach_mnt(user_nd.mnt, &old_nd);     /* mount old root on put_old */
 	attach_mnt(new_nd.mnt, &root_parent); /* mount new_root on / */
 	spin_unlock(&vfsmount_lock);



--------------020908090900020308090207--
