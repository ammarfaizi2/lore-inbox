Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbUKWWnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbUKWWnu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUKWWml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:42:41 -0500
Received: from [213.146.154.40] ([213.146.154.40]:36048 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261606AbUKWWjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:39:37 -0500
Date: Tue, 23 Nov 2004 22:39:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>, Phil Dier <phil@dier.us>,
       linux-kernel@vger.kernel.org, Scott Holdren <scott@icglink.com>,
       ziggy <ziggy@icglink.com>, Jack Massari <webmaster@icglink.com>
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041123223935.GA1889@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>, Phil Dier <phil@dier.us>,
	linux-kernel@vger.kernel.org, Scott Holdren <scott@icglink.com>,
	ziggy <ziggy@icglink.com>, Jack Massari <webmaster@icglink.com>
References: <20041122130622.27edf3e6.phil@dier.us> <20041122161725.21adb932.akpm@osdl.org> <20041123093744.25c09245.phil@dier.us> <20041123170222.GS4469@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123170222.GS4469@unthought.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 06:02:23PM +0100, Jakob Oestergaard wrote:
> With SMP, what I see is that sometimes a directory might decide that
> it's a file - but I can't delete it, becuase it isn't 'empty' (it's
> still somehow a directory).  Waiting a day or two, the system will
> change its mind back to letting the directory be a directory. Sometimes
> modes will be fscked up as well - a regular file can change owner, or it
> can change modes from '-rw-rw---' to '?---------'.    Weird stuff, no
> way to reproduce it reliably.

Actually I can reproduce it reliably by running nfs_fsstress.sh for a
looong time.  The problem is that in the current XFS code the inode
generation counter starts at 0, but higher level code uses that as
a wildcard for any possible generation, so you may get a newly created
file for a stale nfs file handler of an deleted file with the same inode
number.

The patch below fixes it for me:


Index: fs/xfs/xfs_inode.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/xfs_inode.c,v
retrieving revision 1.406
diff -u -p -r1.406 xfs_inode.c
--- fs/xfs/xfs_inode.c	27 Oct 2004 12:06:24 -0000	1.406
+++ fs/xfs/xfs_inode.c	23 Nov 2004 20:40:56 -0000
@@ -1224,9 +1224,16 @@ xfs_ialloc(
 	ip->i_d.di_nextents = 0;
 	ASSERT(ip->i_d.di_nblocks == 0);
 	xfs_ichgtime(ip, XFS_ICHGTIME_CHG|XFS_ICHGTIME_ACC|XFS_ICHGTIME_MOD);
+
 	/*
-	 * di_gen will have been taken care of in xfs_iread.
+	 * Bump the generation count so no one will confuse us with an
+	 * earlier incarnations of this inode.
+	 *
+	 * Done early to skip generation 0, which is used as a wildcard
+	 * by higher level code.
 	 */
+	ip->i_d.di_gen++;
+
 	ip->i_d.di_extsize = 0;
 	ip->i_d.di_dmevmask = 0;
 	ip->i_d.di_dmstate = 0;
@@ -2370,11 +2377,6 @@ xfs_ifree(
 		XFS_IFORK_DSIZE(ip) / (uint)sizeof(xfs_bmbt_rec_t);
 	ip->i_d.di_format = XFS_DINODE_FMT_EXTENTS;
 	ip->i_d.di_aformat = XFS_DINODE_FMT_EXTENTS;
-	/*
-	 * Bump the generation count so no one will be confused
-	 * by reincarnations of this inode.
-	 */
-	ip->i_d.di_gen++;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	if (delete) {
