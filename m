Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287908AbSBMR3b>; Wed, 13 Feb 2002 12:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287919AbSBMR3W>; Wed, 13 Feb 2002 12:29:22 -0500
Received: from mail.headlight.de ([195.254.117.141]:49930 "EHLO
	mail.headlight.de") by vger.kernel.org with ESMTP
	id <S287908AbSBMR3I>; Wed, 13 Feb 2002 12:29:08 -0500
Date: Wed, 13 Feb 2002 18:29:27 +0100
From: Daniel Mack <daniel@yoobay.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [BUG] + [PATCH]: handling bad inodes in 2.4.x kernels
Message-ID: <20020213182927.I15910@chaos.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i already wrote this a few days ago but did not get any response yet.
since i believe this is a serious bug, i'm posting this again...

the bug is about the handling of bad inodes in at least the 2.4.16, .17,
.18-pre9 and .9 kernel releases (i suspect all 2.4 kernels are affected)
and causes the names_cache to get confused.
you can easily reproduce this effect by making an inode bad using debugfs
(or using a bad one if you have, of course) and open() it with the flag
O_CREAT set. watching /proc/slabinfo will show you the weirdness.
consider /tmp/bad is a bad inode:

# cd /tmp
# ls | grep bad
bad
# cat bad
cat: bad: Input/output error
# cat /proc/slabinfo | grep names
names_cache 0 2 4096 0 2 1 : 2 333 2 0 0
# echo foo >bad
sh: bad: Input/output error
# cat /proc/slabinfo | grep names
names_cache 4294967295 2 4096 1 2 1

boom! 4294967295 == (unsigned long) -1, the cache length is growing backwards.
this "echo foo >bad" opens the file with O_CREAT set which forces the effect.

what confuses me is that the system remains stable after that happened, the
only effect i got was that i wasn't able to rename() a file on any filesystem
anymore. what the rename() syscall does on kernel side is getting memory from
the names_cache twice by calling __getname() which gives out the same pointer
twice when the kernel is poisoned this way.
anyway, it's an ugly bug that needs to get fixed.

the bug is most likely in fs/namei.c, open_namei() - at least i fixed my
machine here with this:

--- linux-2.4.17-orig/fs/namei.c Wed Oct 17 23:46:29 2001
+++ linux-2.4.17-uml/fs/namei.c Fri Feb 8 02:53:36 2002
@@ -1052,6 +1052,11 @@
        error = -ENOENT;
        if (!dentry->d_inode)
                goto exit_dput;
+
+ error = -EIO;
+ if (is_bad_inode(dentry->d_inode))
+ goto exit_dput;
+
        if (dentry->d_inode->i_op && dentry->d_inode->i_op->follow_link)
                goto do_link;

an open() does not make any sense on a bad inode so i see no reason for
not breaking the branch at this point.

any comments? please let me know if you're able to trigger this effect
on older 2.4 kernels. btw, version 2.2.19 is not tainted.

greets,
daniel


