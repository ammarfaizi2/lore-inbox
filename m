Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266767AbRGMDvG>; Thu, 12 Jul 2001 23:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbRGMDu4>; Thu, 12 Jul 2001 23:50:56 -0400
Received: from muggy.gg.caltech.edu ([131.215.129.14]:64517 "EHLO
	muggy.gg.caltech.edu") by vger.kernel.org with ESMTP
	id <S266767AbRGMDuj>; Thu, 12 Jul 2001 23:50:39 -0400
Message-Id: <200107130350.UAA28646@muggy.gg.caltech.edu>
Reply-to: monty@druggist.gg.caltech.edu
X-Secret: Congratulations, you found the secret message.
X-URL: http://www.gg.caltech.edu/~monty/monty.shtml
X-PGP-Fingerprint: E4 EA 6D B1 82 46 DB A1  B0 FF 60 B9 F9 5D 5C F7 
X-Face: ;XP1'D'Y7hP0IDW,()+Au)M`LZuSzXBcB1OJaU"gRtYuy<Yc40d\k#A3q<M
 d55~Md==Nf6-rRKS<en?8|JeAQ@F:V*]r[$$s4"LhXLuq--dsbXz^PK;*Y^]tk*&]&
 \T1x['z^6=zq/c~[Bth9i<%nmq|uC!%KP*)n)Zf"6(aKukQ{y%(C+z|vq<sio1xd40
 *D14qG<5u-*Lgo8z)'wiwsl$p?c}4[,pUg0e9kk
To: linux-kernel@vger.kernel.org
Subject: 2.4.6 mount behavior changed (graft_tree in fs/super.c)
Date: Thu, 12 Jul 2001 20:50:38 -0700
From: Mark Montague <monty@gg.caltech.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, NFS has traditionally been happy mounting a plain
file on a directory, but hasn't liked mount points that aren't
directories. Although I have no idea why this is, I've been using it
to mount just one file from an NFS server.

The vfs changes in 2.4.6 now will *only* mount a file on a file, and a
directory on a directory, which, although it kinda makes more sense,
doesn't agree with mount(2):

       ENOTDIR
              The second argument, or a prefix of the first argu
              ment, is not a directory.

For what it's worth, HPUX 10.20's, IRIX 6.5's, and SunOS 5.7's
mount(2)s agree with the man page. I don't know if the change breaks
POSIXly-correctness, but for consistency with other OSes, it seems
like the old behavior, while bizarre, is desirable.

I'm not supplying a real patch because I suspect that the fact that
graft_tree is called from two contexts makes fiddling there fraught
with peril, and I don't have time to test it right now, but I think
this patch will return mount to its old behavior (and will do
something random and possibly horrible to loopback mounts, and may not
be consistent with NFS, and probably causes cancer):

--- super.c.orig        Thu Jul 12 20:42:08 2001
+++ super.c     Thu Jul 12 20:47:51 2001
@@ -422,8 +422,7 @@

 static int graft_tree(struct vfsmount *mnt, struct nameidata *nd)
 {
-       if (S_ISDIR(nd->dentry->d_inode->i_mode) !=
-             S_ISDIR(mnt->mnt_root->d_inode->i_mode))
+       if ((!S_ISDIR(nd->dentry->d_inode->i_mode))
                return -ENOTDIR;

        down(&nd->dentry->d_inode->i_zombie);

			shrug

					- M
--
Mark "Monty" Montague | monty@gg.caltech.edu  | I don't do Windows(tm)
		 main(){printf("I am self-aware\\n");}
	  <URL:http://www.gg.caltech.edu/~monty/monty.shtml>
 X-PGP-Fingerprint: E4 EA 6D B1 82 46 DB A1  B0 FF 60 B9 F9 5D 5C F7

