Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSDNBtr>; Sat, 13 Apr 2002 21:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311572AbSDNBtq>; Sat, 13 Apr 2002 21:49:46 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:49143 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S311564AbSDNBtp>; Sat, 13 Apr 2002 21:49:45 -0400
Date: Sat, 13 Apr 2002 18:49:13 -0700
From: Chris Wright <chris@wirex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: xystrus <xystrus@haxm.com>, linux-kernel@vger.kernel.org
Subject: Re: link() security
Message-ID: <20020413184913.E6039@figure1.int.wirex.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	xystrus <xystrus@haxm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020411181524.A1463@figure1.int.wirex.com> <E16wQsU-0000cb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> 
> How practical is it to make this a mount option and to do so cleanly ?

Well, it's not too bad.  Below is a patch (albeit quick and dirty)
that adds a MS_SECURE_LINK mount option to enforce this behaviour.
To simplify testing, I cheated and piggy backed the MS_SECURE_LINK option
on the MS_NOSUID option.  So a simple 'mount -o nosuid,remount /foo'
enables this.  The secure link test allows a hard link if you own the
target file or are in the same group _and_ can (by group) write to
the file, or have proper capability, of course.  Patch is against
2.4.19-pre5-ac3.

cheers,
-chris

--- 2.4.19-pre5-ac3/fs/namespace.c.link	Sat Apr 13 18:06:21 2002
+++ 2.4.19-pre5-ac3/fs/namespace.c	Sat Apr 13 18:12:11 2002
@@ -707,8 +707,10 @@
 		return -EINVAL;
 
 	/* Separate the per-mountpoint flags */
-	if (flags & MS_NOSUID)
+	if (flags & MS_NOSUID) {
 		mnt_flags |= MNT_NOSUID;
+		flags |= MS_SECURE_LINK;
+	}
 	if (flags & MS_NODEV)
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
--- 2.4.19-pre5-ac3/fs/namei.c.link	Sat Apr 13 18:06:21 2002
+++ 2.4.19-pre5-ac3/fs/namei.c	Sat Apr 13 18:12:11 2002
@@ -1614,6 +1614,11 @@
 	error = -EPERM;
 	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
 		goto exit_lock;
+	if (IS_SECURE_LINK(inode) && (!capable(CAP_FOWNER) &&
+				current->fsuid != inode->i_uid &&
+			       	(current->fsgid != inode->i_gid ||
+				!(inode->i_mode & S_IWGRP))))
+		goto exit_lock;
 	if (!dir->i_op || !dir->i_op->link)
 		goto exit_lock;
 
--- 2.4.19-pre5-ac3/include/linux/fs.h.link	Sat Apr 13 18:06:21 2002
+++ 2.4.19-pre5-ac3/include/linux/fs.h	Sat Apr 13 18:15:38 2002
@@ -111,6 +111,7 @@
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_SECURE_LINK  65536
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -118,7 +119,7 @@
  * Superblock flags that can be altered by MS_REMOUNT
  */
 #define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
-			 MS_NODIRATIME)
+			 MS_NODIRATIME|MS_SECURE_LINK)
 
 /*
  * Old magic mount flag and mask
@@ -161,6 +162,7 @@
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
+#define IS_SECURE_LINK(inode)	__IS_FLG(inode, MS_SECURE_LINK)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 
