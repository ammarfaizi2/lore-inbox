Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSJ1WEp>; Mon, 28 Oct 2002 17:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJ1WEp>; Mon, 28 Oct 2002 17:04:45 -0500
Received: from hera.cwi.nl ([192.16.191.8]:47831 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261532AbSJ1WEo>;
	Mon, 28 Oct 2002 17:04:44 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 28 Oct 2002 23:10:25 +0100 (MET)
Message-Id: <UTC200210282210.g9SMAPU10164.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: CLONE_NEWNS flaw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

Now that hch mentioned CLONE_NEWNS I looked at the code
to see how things are today. But in 2.5.44 it is still
broken. One thing that is wrong is that when you copy
namespaces, the order is reversed, but you depend on
the order for assigning root, altroot and cwd.
Thus, after using CLONE_NEWNS these, and in particular
cwd, will be random and probably incorrect.

Maybe something like

--- namespace.c~        Mon Oct 28 21:25:08 2002
+++ namespace.c Mon Oct 28 22:50:10 2002
@@ -110,7 +110,7 @@
        mnt->mnt_parent = mntget(nd->mnt);
        mnt->mnt_mountpoint = dget(nd->dentry);
        list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
-       list_add(&mnt->mnt_child, &nd->mnt->mnt_mounts);
+       list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
        nd->dentry->d_mounted++;
 }
 

is good enough to repair, but I have not checked all callers
of attach_mnt().

Andries
