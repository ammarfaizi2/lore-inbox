Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbULIVzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbULIVzz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 16:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbULIVzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 16:55:54 -0500
Received: from [213.146.154.40] ([213.146.154.40]:11952 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261634AbULIVyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 16:54:18 -0500
Date: Thu, 9 Dec 2004 21:54:14 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jakob Oestergaard <jakob@unthought.net>, Jan Kasprzak <kas@fi.muni.cz>,
       linux-kernel@vger.kernel.org, kruty@fi.muni.cz
Subject: Re: XFS: inode with st_mode == 0
Message-ID: <20041209215414.GA21503@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jakob Oestergaard <jakob@unthought.net>,
	Jan Kasprzak <kas@fi.muni.cz>, linux-kernel@vger.kernel.org,
	kruty@fi.muni.cz
References: <20041209125918.GO9994@fi.muni.cz> <20041209135322.GK347@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041209135322.GK347@unthought.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry, last post got out to far too few people]

On Thu, Dec 09, 2004 at 02:53:23PM +0100, Jakob Oestergaard wrote:
> On Thu, Dec 09, 2004 at 01:59:18PM +0100, Jan Kasprzak wrote:
> > 	Hi all,
> > 
> > I have seen the strange problem on our NFS server: yesterday I have
> > found an empty file owned by UID 0/GID 0 and st_mode == 0 in my home
> > directory (ls -l said "?--------- 1 root root 0 <date> <filename>").
> > The <filename> was correct name of a temporary file used by one of my
> > cron jobs (and the cron job was failing because it could not rewrite the file).
> > It was not possible to write to this file, so I have renamed it
> > as "badfile" for further investigation (using mv(1) on the NFS server itself).
> 
> Known problem
> 
> http://lkml.org/lkml/2004/11/23/283
> 
> Seems there is no solution yet
> 
> http://lkml.org/lkml/2004/11/30/145

If it's really st_mode I suspect it's a different problem.  Can you retry
with current oss.sgi.com CVS (or the patch below).  Note that this patch
breaks xfsdump unfortunately, we're looking into a fix.

> > Maybe some data is flushed in an incorrect order?
> 
> Maybe  :)

No, the problem I've fixed was related to XFS getting the inode version
number wrong - or at least different than NFSD expects.


Index: fs/xfs/xfs_ialloc.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/xfs_ialloc.c,v
retrieving revision 1.175
diff -u -p -r1.175 xfs_ialloc.c
--- fs/xfs/xfs_ialloc.c	6 Oct 2003 18:11:55 -0000	1.175
+++ fs/xfs/xfs_ialloc.c	30 Nov 2004 10:18:16 -0000
@@ -270,6 +270,11 @@ xfs_ialloc_ag_alloc(
 	INT_SET(dic.di_magic, ARCH_CONVERT, XFS_DINODE_MAGIC);
 	INT_SET(dic.di_version, ARCH_CONVERT, version);
 
+	/*
+	 * Start at generation 1 because the NFS code uses 0 as wildcard.
+	 */
+	INT_SET(dic.di_gen, ARCH_CONVERT, 1);
+
 	for (j = 0; j < nbufs; j++) {
 		/*
 		 * Get the block.
Index: fs/xfs/xfs_inode.c
===================================================================
RCS file: /cvs/linux-2.6-xfs/fs/xfs/xfs_inode.c,v
retrieving revision 1.406
diff -u -p -r1.406 xfs_inode.c
--- fs/xfs/xfs_inode.c	27 Oct 2004 12:06:24 -0000	1.406
+++ fs/xfs/xfs_inode.c	30 Nov 2004 10:18:18 -0000
@@ -1028,6 +1028,16 @@ xfs_iread(
 		ip->i_d.di_projid = 0;
 	}
 
+	/*
+	 * IRIX and older Linux Kernel initialized di_gen to zero when
+	 * creating new inodes, but the NFSD uses i_generation = 0 as
+	 * a wildcard.  We bump di_gen here to avoid that problem for new
+	 * exports, and filehandles created by an older kernel using
+	 * the same filesystem are still valid as the wildcard matches it.
+	 */
+	if (unlikely(ip->i_d.di_gen == 0))
+		ip->i_d.di_gen++;
+
 	ip->i_delayed_blks = 0;
 
 	/*
@@ -2370,11 +2380,17 @@ xfs_ifree(
 		XFS_IFORK_DSIZE(ip) / (uint)sizeof(xfs_bmbt_rec_t);
 	ip->i_d.di_format = XFS_DINODE_FMT_EXTENTS;
 	ip->i_d.di_aformat = XFS_DINODE_FMT_EXTENTS;
+
 	/*
 	 * Bump the generation count so no one will be confused
-	 * by reincarnations of this inode.
+	 * by reincarnations of this inode.  Note that we have to
+	 * skip 0 as that would confuse the NFS server, and we
+	 * have to do it here because the XFS inode might be
+	 * around for a while after deletion (unlike the normal
+	 * Linux inode semantics).
 	 */
-	ip->i_d.di_gen++;
+	if (++ip->i_d.di_gen == 0)
+		ip->i_d.di_gen++;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
 	if (delete) {
