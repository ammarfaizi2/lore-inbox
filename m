Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWHPUnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWHPUnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 16:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWHPUnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 16:43:17 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:52667 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750847AbWHPUnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 16:43:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uQOepFVh9ZTaqTqpR9D+u0A3OR9Xsq0zYTJsgf2oeq6arvCh4LiNwXFkJRaGW/gSQYq5SElUokihdbZpMLDSi2JXUtCJ/5YJK6ZBevue6XDKv39GZQLDGndoR0ypCr9J67XMTNoerR3/tOb4qhHQ7JyMdTlbMlUZOzZfNt5whBM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: [PATCH] XFS: remove pointless conditional testing 'nmp' vs NULL in fs/xfs/xfs_rtalloc.c::xfs_growfs_rt()
Date: Wed, 16 Aug 2006 22:44:19 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
References: <200608130016.51136.jesper.juhl@gmail.com> <20060814110942.C2698880@wobbly.melbourne.sgi.com> <9a8748490608140025w3257f315jcceccf05d200437f@mail.gmail.com>
In-Reply-To: <9a8748490608140025w3257f315jcceccf05d200437f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608162244.19957.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 09:25, Jesper Juhl wrote:
> On 14/08/06, Nathan Scott <nathans@sgi.com> wrote:
> > On Sun, Aug 13, 2006 at 12:16:50AM +0200, Jesper Juhl wrote:
> >
> > Really this code would be better if reworked slightly to just
> > allocate nmp once before entering the loop, and then free it
> > once at the end... we wouldn't need a goto, just a few breaks
> > in the loop and a conditional transaction cancel.
> >
> > > This patch gets rid of the pointless check.
> >
> > Hmm, seems like code churn that makes the code slightly less
> > obvious, but thats just me... I'd prefer a tested patch that
> > implements the above suggestion, to be honest. :)
> >
> Ok, I'll see what I can come up with.
> 

How this?

Compile tested only since I'm at home and don't have any XFS filesystems to
play with atm.



Rework fs/xfs/xfs_rtalloc.c::xfs_growfs_rt() to allocate and free 'nmp' just
once and make the error handling a bit clearer.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/xfs/xfs_rtalloc.c |   37 +++++++++++++++----------------------
 1 files changed, 15 insertions(+), 22 deletions(-)

--- linux-2.6.18-rc4-orig/fs/xfs/xfs_rtalloc.c	2006-08-11 00:11:13.000000000 +0200
+++ linux-2.6.18-rc4/fs/xfs/xfs_rtalloc.c	2006-08-16 22:36:03.000000000 +0200
@@ -1976,7 +1976,11 @@ xfs_growfs_rt(
 	if ((error = xfs_growfs_rt_alloc(mp, rsumblocks, nrsumblocks,
 			mp->m_sb.sb_rsumino)))
 		return error;
-	nmp = NULL;
+
+	/*
+	 * Allocate a new (fake) mount/sb.
+	 */
+	nmp = kmem_alloc(sizeof(*nmp), KM_SLEEP);
 	/*
 	 * Loop over the bitmap blocks.
 	 * We will do everything one bitmap block at a time.
@@ -1987,10 +1991,6 @@ xfs_growfs_rt(
 		     ((sbp->sb_rextents & ((1 << mp->m_blkbit_log) - 1)) != 0);
 	     bmbno < nrbmblocks;
 	     bmbno++) {
-		/*
-		 * Allocate a new (fake) mount/sb.
-		 */
-		nmp = kmem_alloc(sizeof(*nmp), KM_SLEEP);
 		*nmp = *mp;
 		nsbp = &nmp->m_sb;
 		/*
@@ -2018,13 +2018,13 @@ xfs_growfs_rt(
 		cancelflags = 0;
 		if ((error = xfs_trans_reserve(tp, 0,
 				XFS_GROWRTFREE_LOG_RES(nmp), 0, 0, 0)))
-			goto error_exit;
+			break;
 		/*
 		 * Lock out other callers by grabbing the bitmap inode lock.
 		 */
 		if ((error = xfs_trans_iget(mp, tp, mp->m_sb.sb_rbmino, 0,
 						XFS_ILOCK_EXCL, &ip)))
-			goto error_exit;
+			break;
 		ASSERT(ip == mp->m_rbmip);
 		/*
 		 * Update the bitmap inode's size.
@@ -2038,7 +2038,7 @@ xfs_growfs_rt(
 		 */
 		if ((error = xfs_trans_iget(mp, tp, mp->m_sb.sb_rsumino, 0,
 						XFS_ILOCK_EXCL, &ip)))
-			goto error_exit;
+			break;
 		ASSERT(ip == mp->m_rsumip);
 		/*
 		 * Update the summary inode's size.
@@ -2053,7 +2053,7 @@ xfs_growfs_rt(
 		    mp->m_rsumlevels != nmp->m_rsumlevels) {
 			error = xfs_rtcopy_summary(mp, nmp, tp);
 			if (error)
-				goto error_exit;
+				break;
 		}
 		/*
 		 * Update superblock fields.
@@ -2080,18 +2080,13 @@ xfs_growfs_rt(
 		error = xfs_rtfree_range(nmp, tp, sbp->sb_rextents,
 			nsbp->sb_rextents - sbp->sb_rextents, &bp, &sumbno);
 		if (error)
-			goto error_exit;
+			break;
 		/*
 		 * Mark more blocks free in the superblock.
 		 */
 		xfs_trans_mod_sb(tp, XFS_TRANS_SB_FREXTENTS,
 			nsbp->sb_rextents - sbp->sb_rextents);
 		/*
-		 * Free the fake mp structure.
-		 */
-		kmem_free(nmp, sizeof(*nmp));
-		nmp = NULL;
-		/*
 		 * Update mp values into the real mp structure.
 		 */
 		mp->m_rsumlevels = nrsumlevels;
@@ -2101,15 +2096,13 @@ xfs_growfs_rt(
 		 */
 		xfs_trans_commit(tp, 0, NULL);
 	}
-	return 0;
-
+	if (error)
+		xfs_trans_cancel(tp, cancelflags);
 	/*
-	 * Error paths come here.
+	 * Free the fake mp structure.
 	 */
-error_exit:
-	if (nmp)
-		kmem_free(nmp, sizeof(*nmp));
-	xfs_trans_cancel(tp, cancelflags);
+	kmem_free(nmp, sizeof(*nmp));
+
 	return error;
 }
 


