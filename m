Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268957AbTBSQTW>; Wed, 19 Feb 2003 11:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268956AbTBSQTW>; Wed, 19 Feb 2003 11:19:22 -0500
Received: from mail.cs.Virginia.EDU ([128.143.137.19]:26317 "EHLO
	ares.cs.Virginia.EDU") by vger.kernel.org with ESMTP
	id <S268953AbTBSQTS>; Wed, 19 Feb 2003 11:19:18 -0500
Date: Wed, 19 Feb 2003 11:29:20 -0500 (EST)
From: Ronghua Zhang <rz5b@cs.virginia.edu>
To: linux-fsdevel@vger.kernel.org, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: ext2 cannot be compiled as module
Message-ID: <Pine.GSO.4.51.0302191110040.18317@mamba.cs.Virginia.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I compiled ext2 support into a module, but when I mount an ext
partition, kernel oops. The following is what I have done:
 1. copy ext2 directory into another one, say test
 2. change the file system name into 'test'
 3. compile it into a module ext2.o
 4. insmod ext2.o
 5. mound /dev/hdb1 /mnt -t test, kernel oops.

I found out the oops happens at ext2_read_inode() called by
ext2_read_super() to read inode for the root. ext2_read_inode() need to
access inode->i_sb->u.ext2_sb.s_es, but suprisingly, this s_es is NULL!
I further found that this is because inode->i_sb does NOT points to the
supper block whose content is filled by ext2_read_super(), instead it
points to other unknown memory. Printing out inode->s_sb in
ext2_read_inode() and priniting out sb before ext2_read_super() executes
sb->s_root = d_alloc_root(iget(sb, EXT2_ROOT_INO)) can easily reveal this
problem.

I also wrote a very simple file system, only implementing read_super and
read_inode. When it's compiled as a module, the same problem exists. But
when it's compiled into the kernel, no problem at all!

Is it a bug or am I missing something? BTW, the kernel is 2.4.19 and gcc
is 3.2

Ronghua
