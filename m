Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270657AbRH1Kr4>; Tue, 28 Aug 2001 06:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270661AbRH1Krr>; Tue, 28 Aug 2001 06:47:47 -0400
Received: from chello212017081026.15.vie.surfer.at ([212.17.81.26]:9465 "EHLO
	nerd.clifford.at") by vger.kernel.org with ESMTP id <S270657AbRH1Krg>;
	Tue, 28 Aug 2001 06:47:36 -0400
Date: Tue, 28 Aug 2001 12:52:46 +0200 (CEST)
From: Clifford Wolf <clifford@clifford.at>
To: <Remy.Card@linux.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Ext2FS: SUID on Dir
Message-ID: <Pine.LNX.4.33.0108281227280.1127-100000@nerd.clifford.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm not subscribed to l-k anymore since I'm not doing much kernel hacking
now - so please don't send your replies only to the list but also to me.

As you all know, on Ext2FS Partitions the SGID flag has a special function
on directories: files within that directories will be owned by the same
group that also owns the directory - which is useful for creating
directories which are shared between the members of a group.

But that only makes sense if the umask is set to give full permissions to
the group (e.g. 007 or 002). Noone would do that if there is a system-wide
'users' group - so some distributions add an extra group for every user
which lets the /etc/group file grow very fast and makes the admins life
harder ...

The following small patch adds a function to the SUID flag on directories.
If the SUID flag is set for a diectory, all new files in that directory
will get the same rights in the group-field as they have in their
user-field.  So, if one sets both - SUID and SGID - on a directory, it
will also work with a umask like 022 or 077 and there is no more need for
an extra group for every user.

Also, the SUID flag will be set to all subdirectories of a SUID directory
(as it is already now with the SGID flag on directories).

--- linux/fs/ext2/ialloc.c.orig	Tue Aug 28 10:59:09 2001
+++ linux/fs/ext2/ialloc.c	Tue Aug 28 11:03:17 2001
@@ -427,6 +427,11 @@
 			mode |= S_ISGID;
 	} else
 		inode->i_gid = current->fsgid;
+	if (dir->i_mode & S_ISUID) {
+		mode |= (mode & 0700) >> 3;
+		if (S_ISDIR(mode))
+			mode |= S_ISUID;
+	}
 	inode->i_mode = mode;

 	inode->i_ino = j;
--- linux/CREDITS.orig	Tue Aug 28 11:03:27 2001
+++ linux/CREDITS	Tue Aug 28 11:05:07 2001
@@ -3064,6 +3064,8 @@
 E: god@clifford.at
 W: http://www.clifford.at/
 D: Menuconfig/lxdialog improvement
+D: Initial Wacom Intuos USB Driver
+D: Ext2FS: SUID on directories
 S: Foehrengasse 16
 S: A-2333 Leopoldsdorf b. Wien
 S: Austria

What do you thing? Good idea? Bad idea? Why?

yours,
 - clifford

--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
Clifford Wolf ................ www.clifford.at         IRC: http://opirc.nu
The ROCK Projects Workgroup .. www.rock-projects.com  Tel: +43-699-10063494
The ROCK Linux Workgroup ..... www.rocklinux.org      Fax: +43-2235-42788-4
The NTx Consulting Group ..... www.ntx.at            email: god@clifford.at

Reality corrupted. Reboot universe? (Y/N)                 www.rocklinux.net

