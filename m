Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVJFURP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVJFURP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 16:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbVJFURP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 16:17:15 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:37537 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750933AbVJFURO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 16:17:14 -0400
Date: Thu, 6 Oct 2005 16:17:09 -0400 (EDT)
From: Jim McQuillan <jam@McQuil.com>
X-X-Sender: jam@www.mcquillansystems.com
To: linux-kernel@vger.kernel.org
Subject: pivot_root doesn't work for me in 2.6.14-rc3
Message-ID: <Pine.LNX.4.62.0510061555190.12337@www.mcquillansystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found a problem with pivot_root that worked fine in 2.6.13.3, but
fails for me, starting in 2.6.14-rc3  (haven't tried rc1 or rc2).

This is for LTSP.org (Linux Terminal Server Project) thin clients.

In our initramfs, we have a '/init' script that creates a mountpoint for
a 2nd ramfs, and i'm trying to pivot_root to that mount point.

I'm getting:

   pivot_root: Invalid Argument


This worked perfectly in 2.6.13.3, so I looked at the 2.6.14-rc3 patch,
and I found the code in fs/namespace.c that is causing it to fail for
me:


@@ -1334,8 +1332,12 @@ asmlinkage long sys_pivot_root(const cha
        error = -EINVAL;
        if (user_nd.mnt->mnt_root != user_nd.dentry)
                goto out2; /* not a mountpoint */
+       if (user_nd.mnt->mnt_parent == user_nd.mnt)
+               goto out2; /* not attached */
        if (new_nd.mnt->mnt_root != new_nd.dentry)
                goto out2; /* not a mountpoint */
+       if (new_nd.mnt->mnt_parent == new_nd.mnt)
+               goto out2; /* not attached */
        tmp = old_nd.mnt; /* make sure we can reach put_old from
new_root */
        spin_lock(&vfsmount_lock);
        if (tmp != new_nd.mnt) {


The first of the 2 new tests are causing the pivot_root to fail for me.
If I comment out those lines, it works again.

I'm thinking that somebody put those lines there for a reason, so
there's possibly something wrong with the way i've been doing this for a
long time, and the tightening of the code has uncovered my problem.

I'll explain how we use the initramfs/nfsroot:

  1) kernel boots, mounts initramfs
  2) /init creates and mouts a ramfs on /newroot
  3) create /newroot/nfsroot mountpoint
  4) nfsmount /opt/ltsp/i386 from the server on /newroot/nfsroot
  5) create a bunch of symlinks to things we need on the nfs filesystem
     such as bin, etc, lib, sbin, usr
  6) create a bunch of ram-based directories in /newroot, such as
     tmp, dev, oldroot, proc and sys
  7) cd /newroot; pivot_root . oldroot
  8) mount /sys and /proc, start udev
  9) exec /sbin/init

We don't do the pivot_root directly to the nfs-mounted filesystem,
because then EVERY file access we do causes NFS traffic.

If you'd like to see a diagram, check out

http://wiki.ltsp.org/twiki/bin/view/Ltsp/WorkInProgress#Diagram_of_initramfs_nfs_layout

Somebody recently told me that pivot_root has been put in the 'evil way
to do things' category, and that there was a new way, but he couldn't
remember what that was.

So, if anybody knows the new way, i'd appreciate hearing about it.

Thanks,

Jim McQuillan
jam@Ltsp.org
