Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTLDAEl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 19:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbTLDAEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 19:04:40 -0500
Received: from galileo.bork.org ([66.11.174.156]:1492 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262902AbTLDAEd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 19:04:33 -0500
Subject: pivot_root off an initramfs broken
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-XcboO6EmIy513H+/1iZI"
Organization: Wild Open Source Inc.
Message-Id: <1070496272.8280.443.camel@plato.i.bork.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 19:04:32 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XcboO6EmIy513H+/1iZI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


This is the conclusion that I've come to.  For background please see:

http://www.zytor.com/pipermail/klibc/2003-November/000223.html
which finishes up here:
http://www.zytor.com/pipermail/klibc/2003-December/000254.html


The executive summary is this:

If I boot a 2.6 kernel that first execs /sbin/kinit on the initramfs,
does some setup (mostly to find the real root filesystem), then
pivot_roots over to the real root filesystem and execs /sbin/init the
kernel spins inside check_mnt() while mounting /proc in the initscripts.

The reason is because the vfsmount structures for the root filesystem
looks like this:

mnt->mnt_devname = /dev/root                    (this is good)
mnt->mnt_parent->mnt_devname = rootfs           (this is good, I think)
mnt->mnt_parent->mnt_parent->mnt_devname = /dev/root   (wrong!)

I think it's in pivot_root that something is going wrong.

The attached patch fixes the problem, but is just a hack.
Any comments on how to really fix this?

TIA,
mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296


--=-XcboO6EmIy513H+/1iZI
Content-Disposition: attachment; filename=namespace.diff
Content-Type: text/x-patch; name=namespace.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

===== fs/namespace.c 1.50 vs edited =====
--- 1.50/fs/namespace.c	Tue Oct  7 21:52:02 2003
+++ edited/fs/namespace.c	Wed Dec  3 18:48:59 2003
@@ -1064,6 +1064,9 @@
 	detach_mnt(user_nd.mnt, &root_parent);
 	attach_mnt(user_nd.mnt, &old_nd);
 	attach_mnt(new_nd.mnt, &root_parent);
+	if (new_nd.mnt == new_nd.mnt->mnt_parent->mnt_parent &&
+	    new_nd.mnt != new_nd.mnt->mnt_parent)  /* initramfs loop */
+		new_nd.mnt->mnt_parent->mnt_parent = new_nd.mnt->mnt_parent;
 	spin_unlock(&vfsmount_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
 	security_sb_post_pivotroot(&user_nd, &new_nd);

--=-XcboO6EmIy513H+/1iZI--

