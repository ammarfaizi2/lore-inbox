Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285828AbSBOCBo>; Thu, 14 Feb 2002 21:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285829AbSBOCB1>; Thu, 14 Feb 2002 21:01:27 -0500
Received: from mail.headlight.de ([195.254.117.141]:43531 "EHLO
	mail.headlight.de") by vger.kernel.org with ESMTP
	id <S285828AbSBOCBL>; Thu, 14 Feb 2002 21:01:11 -0500
Date: Fri, 15 Feb 2002 03:00:55 +0100
From: Daniel Mack <daniel@yoobay.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@zip.com.au>, Al Viro <viro@math.psu.edu>,
        Stephen Tweedie <sct@redhat.com>
Subject: [BUGFIX] (update): handling bad inodes in 2.4.x kernels
Message-ID: <20020215030055.A19035@chaos.intra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i already posted this to the lkml but found a new approach how to fix the
bug - see below. furthermore, i forgot to cc the maintainers in my last 
posting.

the bug is about the handling of bad inodes in at least the 2.4.9, .16,
.17 and .18-pre9 kernel releases (i suspect all 2.4 kernels are affected)
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

boom! 4294967295 == (unsigned long) -1, the cache's length is walking 
backwards. 

the bug is in/or around open_namei(). there is kernel memory beeing
allcated from the names_cache by sys_open():783 which is freed twice, 
by open_namei():1184 and by sys_open():795. (linenumbers from 2.4.17)
i found 2 possiblities to fix this - one is to simply break the branch
in open_namei() as soon as we can know we're playing with a bad inode:


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


since open() does not make sense on a bad inode, this is the simplest
fix and it's also faster than the other one. but that's a matter of taste i
guess ;)

the real reason for this behavior is rather a broken follow_link implementation
for bad inodes: the function bad_follow_link is called in namei.c, line 1161
which does (in contrast to all other follow_link routines i found) not allocate
memory with __getname() if called from within this special open_namei() loop
(see __vfs_follow_link).
my alternative proposal for fixing this goes here:


--- linux-2.4.17-orig/fs/bad_inode.c	Wed Apr 12 18:47:28 2000
+++ linux-2.4.17-uml/fs/bad_inode.c	Fri Feb 15 02:02:26 2002
@@ -17,8 +17,24 @@
  */
 static int bad_follow_link(struct dentry *dent, struct nameidata *nd)
 {
+	char *name;
+
 	dput(nd->dentry);
 	nd->dentry = dget(dent);
+        
+	/*
+	 * If it is an iterative symlinks resolution in open_namei() we
+	 * have to copy the last component. And all that crap because of
+	 * bloody create() on broken symlinks. Furrfu...
+	 */
+	if (!current->link_count) {
+		name = __getname();
+		if (!name)
+			return -ENOMEM;
+		strcpy(name, nd->last.name);
+		nd->last.name = name;				
+	}
+	
 	return 0;
 }


but since this is a very special workaround _only_ for open_namei(), 
those two patches should have the same effekt.
both patches fix the bug on all machines i tried.


thanks for listening,
daniel

