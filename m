Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289290AbSBNBP3>; Wed, 13 Feb 2002 20:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289294AbSBNBPN>; Wed, 13 Feb 2002 20:15:13 -0500
Received: from sc-gw.scientific.de ([194.121.255.233]:49084 "EHLO
	sarah.scientific.de") by vger.kernel.org with ESMTP
	id <S289290AbSBNBPF>; Wed, 13 Feb 2002 20:15:05 -0500
Subject: [patch] tmpfs: incr. link-count on directory rename
From: Uli Martens <um@scientific.de>
To: Christoph Rohland <cr@sap.com>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 14 Feb 2002 02:07:18 +0100
Message-Id: <1013648840.2317.5.camel@isax>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph, hi all! 

When I move a directory into another on a tmpfs filesystem, the
link-count of the new parent directory isn't getting incremented. 
(which leads to find getting hickup, which eg. lets dpkg produce a
"bzip2" binary package without binaries, generally not a nice thing) 

test: 

isax@home:/tmp/test$ mkdir t1 
isax@home:/tmp/test$ mkdir t2 
isax@home:/tmp/test$ mv t2 t1 
isax@home:/tmp/test$ ls -lRa 
.: 
total 0 
drwxr-xr-x    5 isax     isax            0 Feb 13 23:05 . 
drwxrwxrwt   13 root     root            0 Feb 13 23:04 .. 
drwxr-xr-x    2 isax     isax            0 Feb 13 23:05 t1 

./t1: 
total 0 
drwxr-xr-x    2 isax     isax            0 Feb 13 23:05 . 
drwxr-xr-x    5 isax     isax            0 Feb 13 23:05 .. 
drwxr-xr-x    2 isax     isax            0 Feb 13 23:05 t2 

./t1/t2: 
total 0 
drwxr-xr-x    2 isax     isax            0 Feb 13 23:05 . 
drwxr-xr-x    2 isax     isax            0 Feb 13 23:05 .. 

the link count of "t1", "t1/." and "t1/t2/.." should be "3", not "2". 
The following patch seems to work fine for me and is tested on my
machine running debian's 2.4.17-1 and user-mode-linux 2.5.1-1. 
This is my first patch to the kernel, so I suppose there is a really
huge mistake in my patch I don't see now... 
 
--- linux/mm/shmem.orig Wed Feb 13 00:56:14 2002
+++ linux/mm/shmem.c    Wed Feb 13 18:09:04 2002
@@ -1085,6 +1085,9 @@
 {
        int error = -ENOTEMPTY;
 
+       if (S_ISDIR(old_dentry->d_inode->i_mode)) {
+               new_dir->i_nlink++;
+       }
        if (shmem_empty(new_dentry)) {
                struct inode *inode = new_dentry->d_inode;
                if (inode) {

-- 
uli martens

