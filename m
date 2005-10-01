Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVJAA1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVJAA1I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 20:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVJAA1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 20:27:08 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:10138 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750701AbVJAA1G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 20:27:06 -0400
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Valdis.Kletnieks@vt.edu, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050928223829.GH10408@opteron.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu>
	 <200509231036.16921.kernel@kolivas.org>
	 <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
	 <20050923153158.GA4548@x30.random>
	 <1127509047.8880.4.camel@kleikamp.austin.ibm.com>
	 <1127509155.8875.6.camel@kleikamp.austin.ibm.com>
	 <1127511979.8875.11.camel@kleikamp.austin.ibm.com>
	 <20050928223829.GH10408@opteron.random>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 19:27:04 -0500
Message-Id: <1128126424.10237.7.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-29 at 00:38 +0200, Andrea Arcangeli wrote:
> On Fri, Sep 23, 2005 at 04:46:19PM -0500, Dave Kleikamp wrote:
> > On Fri, 2005-09-23 at 15:59 -0500, Dave Kleikamp wrote:
> > I'd guess that it's spinning in balance_dirty_pages.
> > /proc/<pid>/future_dirty is 25650 for fsx.  It appears that
> > nr_reclaimable is not going to zero for some reason.

I tracked down my problem to a bug in jfs.  jfs is explicitly setting
I_DIRTY in the i_state for a special inode that is preventing it from
being put on the s_dirty list.  This must have been something I did a
long time ago when I was a newbie.  I'm embarrassed I hadn't noticed it
until now.

I still had the problem even with your latest patch, but it's fixed with
this patch to jfs.  I haven't yet tried the jfs patch with the earlier
versions of your patch to see if there is really a problem with them.

I don't have anything to say about the original problem reported on
ext3, since I only saw the problem on jfs.

> Even if nr_reclaimable isn't going to zero, eventually the loop should
> break out because pages_written must increase.
> 
> So this make me think it might be the nr_unstable that destabilizes it,
> and whatever it is, it is a bug in mainline as well, except it was well
> hidden until now, because the dirty levels never approached zero during
> heavy write-IO like it can happen with this feature enabled.
> 
> Basically whatever we account as "reclaimable" must be _written_out_ and
> accounted as well in the "pages_written" otherwise it'll just hang. 
> If there's a problem, it shall be a longstanding one.

Yep.  My bad.

> Can you try with this new patch that stops accounting "unstable" as
> "reclaimable". It should be possible to flush the dirty pages to disk so
> "nr_dirty" should be safe because they should always increase the
> "pages_written". I'm not sure if this fixes it, but this at least rule
> out the nfs from the equation (perhaps nfs will never be accounted as
> "pages_written" and that would be a possible explanation of the infinite
> loop).
> 
> This new update also makes sure to never account rewrites (except for
> reiserfs where it's more difficult to change the code for this).
> 
> I tried with fsx (no params) but I couldn't reproduce any problem yet,
> but I've no nfs workload involved in my test box.
> 
> http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.14-rc1/per-task-predictive-write-throttling-4
> 
> thanks for the help!

JFS: jfs should not be playing with i_state

jfs has been explicitly setting i_state |= I_DIRTY on a special inode.
This prevented it from being put on the s_dirty list.  Very stupid.

Signed-off-by: Dave Kleikamp <shaggy@austin.ibm.com>

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -305,7 +305,6 @@ int dbSync(struct inode *ipbmap)
 	filemap_fdatawrite(ipbmap->i_mapping);
 	filemap_fdatawait(ipbmap->i_mapping);
 
-	ipbmap->i_state |= I_DIRTY;
 	diWriteSpecial(ipbmap, 0);
 
 	return (0);
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -514,8 +514,6 @@ void diWriteSpecial(struct inode *ip, in
 	ino_t inum = ip->i_ino;
 	struct metapage *mp;
 
-	ip->i_state &= ~I_DIRTY;
-
 	if (secondary)
 		address = addressPXD(&sbi->ait2) >> sbi->l2nbperpage;
 	else
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2396,7 +2396,6 @@ static void txUpdateMap(struct tblock * 
 	 */
 	if (tblk->xflag & COMMIT_CREATE) {
 		diUpdatePMap(ipimap, tblk->ino, FALSE, tblk);
-		ipimap->i_state |= I_DIRTY;
 		/* update persistent block allocation map
 		 * for the allocation of inode extent;
 		 */
@@ -2407,7 +2406,6 @@ static void txUpdateMap(struct tblock * 
 	} else if (tblk->xflag & COMMIT_DELETE) {
 		ip = tblk->u.ip;
 		diUpdatePMap(ipimap, ip->i_ino, TRUE, tblk);
-		ipimap->i_state |= I_DIRTY;
 		iput(ip);
 	}
 }

-- 
David Kleikamp
IBM Linux Technology Center

