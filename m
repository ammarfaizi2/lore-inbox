Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbRGNEt4>; Sat, 14 Jul 2001 00:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbRGNEti>; Sat, 14 Jul 2001 00:49:38 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:5587 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S267574AbRGNEtT>; Sat, 14 Jul 2001 00:49:19 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Sat, 14 Jul 2001 14:49:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15183.53052.826318.795664@notabene.cse.unsw.edu.au>
Cc: Abramo Bagnara <abramo@alsa-project.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        <nfs-devel@linux.kernel.org>, <nfs@lists.sourceforge.net>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [NFS] [PATCH] Bug in NFS - should init be allowed to set umask???
In-Reply-To: message from Linus Torvalds on Friday July 13
In-Reply-To: <15183.31372.316080.1208@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.33.0107131902420.1431-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday July 13, torvalds@transmeta.com wrote:
> 
> On Sat, 14 Jul 2001, Neil Brown wrote:
> >
> > I've found a 4th option.  We make it so that fs->umask does not affect
> > nfsd
> 
> Me likee.
> 
> Applied. I'd only like to double-check that you made sure you changed all
> callers?

There is just the call to vfs_mknod in net/unix/af_unix.c that I
mentioned.  I'm not sure what to do about that one.

A
    find -name '*.[ch]' | xargs egrep 'vfs_(mkdir|mknod|create)'

found:
  4 matches in fs/nfsd/vfs.c       which I explicitly didn't want to change
  6 matches in fs/devfs/base.c     which were really matches for devfs_(mkdir|mknod)
  7 matches in fs/namei.c          which the patch changed
  3 matches in kernel/ksyms.c      which are EXPORT_SYMBOLs, not calls
  3 matches in include/linux/fs.h  which are declatations
  2 matches in net/unix/af_unix.c  one is a comment, the other is the
                                   one in question

To be maximally conservative, you might want to apply this patch,
just in case it is important.

NeilBrown

--- ./net/unix/af_unix.c	2001/07/14 04:43:58	1.1
+++ ./net/unix/af_unix.c	2001/07/14 04:46:39
@@ -714,7 +714,7 @@
 		 * All right, let's create it.
 		 */
 		err = vfs_mknod(nd.dentry->d_inode, dentry,
-			S_IFSOCK|sock->inode->i_mode, 0);
+			(S_IFSOCK|sock->inode->i_mode) & ~current->fs->umask, 0);
 		if (err)
 			goto out_mknod_dput;
 		up(&nd.dentry->d_inode->i_sem);
