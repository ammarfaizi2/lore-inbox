Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265652AbTF2NBN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 09:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265653AbTF2NBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 09:01:13 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:12307 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S265652AbTF2NBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 09:01:08 -0400
Date: Sun, 29 Jun 2003 15:09:52 +0200
From: Willy TARREAU <willy@w.ods.org>
To: marcelo@conectiva.com.br, viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH-2.4] Prevent mounting on ".."
Message-ID: <20030629130952.GA246@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al and Marcelo,

while I was trying to get maximum restrictions on a chroot on 2.4.21-pre,
I found that it's always possible to mount a ramfs or a tmpfs on "..",
and then upload whatever I wanted in it. It's a shame because I was
trying to isolate network daemons inside empty, read-only file-systems,
and I discovered that this effort was worthless. To resume, imagine a
network daemon which does :


chroot("/var/empty") (read-only directory or file-system)
chdir("/")
listen(), accept(), fork(), whatever...
-> external code injection from a cracker :
   mount("none", "..", "ramfs")
   mkdir("../mydir")
   chdir("../mydir")
   the cracker now installs whatever he wants here.
  
The worst is that the new directory can even become invisible from all
other processes, so that the intruder has nothing to fear :-( 

So I read fs/namei.c and fs/namespace.c, and found a way to prevent
this. Basically, the only case where it's still possible to mount
something on the current->fs->root now, is when the process wants to
remount the root fs, but no other mounts are allowed.

Since I'm really clueless about VFS code, I might have done it wrong,
or broken something, so I post this patch for comments. If everyone
agrees, I would really appreciate it if it was accepted in mainstream,
because it's a security problem IMHO.

It still applies to 2.5.66 with offset BTW.

Cheers,
Willy


--- linux-2.4.22-pre2/fs/namespace.c	Sat May 10 11:36:02 2003
+++ linux-2.4.22-pre2-dotdot-mount/fs/namespace.c	Sun Jun 29 14:38:16 2003
@@ -732,6 +732,10 @@
 	if (flags & MS_REMOUNT)
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
+	else if (nd.dentry == current->fs->root &&
+		 nd.mnt == current->fs->rootmnt)
+		/* prevents someone from mounting on . or .. */
+		retval = -EINVAL;
 	else if (flags & MS_BIND)
 		retval = do_loopback(&nd, dev_name, flags & MS_REC);
 	else if (flags & MS_MOVE)

