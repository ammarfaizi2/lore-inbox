Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279798AbSAGQvV>; Mon, 7 Jan 2002 11:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbSAGQvM>; Mon, 7 Jan 2002 11:51:12 -0500
Received: from pat.uio.no ([129.240.130.16]:4284 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S279798AbSAGQvF>;
	Mon, 7 Jan 2002 11:51:05 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15417.53743.840597.686135@charged.uio.no>
Date: Mon, 7 Jan 2002 17:50:55 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: NFS "dev_t" issues..
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201011402560.13397-100000@penguin.transmeta.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > I made a pre6, which contains a new-and-anal "kdev_t".

<snip>

     > I fixed up the stuff I use and which showed up in compiles (on
     > a source level, it's so far totally untested), but I'd really
     > like people to check out their own subsystems. _Especially_ NFS
     > and NFSD, which had several cases of mixing the two dev_t's
     > around, and which also used them as numbers. Trond, Neil?

Hi Linus & Marcelo,

  Sorry I'm a bit late in replying. AFAICS as of 2.5.2-pre9, all is
more or less well, however when reviewing that code, I noticed what is
probably a bug:

  Given that (for character devices) the value of inode->i_cdev in
2.[45].x depends on the i_rdev, it would appear to be a bug for us to
be able to change inode->i_rdev *after* we've called
init_special_inode().
For this reason, I'd advocate removing the lines in
nfs_refresh_inode() that reset the inode->i_rdev (as per the patch
below) and instead rely on the ordinary stale inode checks to tell us
if/when the inode->i_rdev has changed.

It's hardly a new bug. It's been around ever since we added
init_special_inode(), so it's clearly not one that bites us every day
of the year. Even so, the same patch should probably be applied to
2.4.x.

Cheers,
  Trond


diff -u --recursive --new-file linux-2.5.2-pre9/fs/nfs/inode.c linux-2.5.2-fix/fs/nfs/inode.c
--- linux-2.5.2-pre9/fs/nfs/inode.c	Mon Jan  7 16:57:18 2002
+++ linux-2.5.2-fix/fs/nfs/inode.c	Mon Jan  7 17:08:42 2002
@@ -1107,9 +1107,6 @@
  		inode->i_blocks = fattr->du.nfs2.blocks;
  		inode->i_blksize = fattr->du.nfs2.blocksize;
  	}
- 	inode->i_rdev = NODEV;
- 	if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode))
- 		inode->i_rdev = to_kdev_t(fattr->rdev);
  
 	/* Update attrtimeo value */
 	if (!invalid && time_after(jiffies, NFS_ATTRTIMEO_UPDATE(inode)+NFS_ATTRTIMEO(inode))) {
