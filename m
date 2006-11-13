Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753920AbWKMEwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbWKMEwJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 23:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753921AbWKMEwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 23:52:09 -0500
Received: from cantor2.suse.de ([195.135.220.15]:48840 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1753920AbWKMEwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 23:52:08 -0500
From: Neil Brown <neilb@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Date: Mon, 13 Nov 2006 15:52:00 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17751.63984.838723.340682@cse.unsw.edu.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] include/linux/nfsd/nfsfh.h:fh_unlock(): change an error to a BUG_ON()
In-Reply-To: message from Adrian Bunk on Sunday November 12
References: <20061112131748.GI25057@stusta.de>
	<1163347127.6612.66.camel@lade.trondhjem.org>
	<20061112174831.GD3382@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday November 12, bunk@stusta.de wrote:
> > 
> > This issue has come up on lkml before. Please just convert that check
> > for fhp->fh_dentry into a BUG_ON().
> 
> Patch below.
> 

Thanks.  I might that the opportunity to do a bit more cleaning up
here and suggest this version .

NeilBrown

---------------------------
Subject: Replace some warning ins nfsfh.h with BUG_ON or WARN_ON

A couple of the warning will be followed by an Oops if they ever fire,
so may as well be BUG_ON.  Another isn't obviously fatal but has never
been known to fire, so make it a WARN_ON.

Cc: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./include/linux/nfsd/nfsfh.h |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff .prev/include/linux/nfsd/nfsfh.h ./include/linux/nfsd/nfsfh.h
--- .prev/include/linux/nfsd/nfsfh.h	2006-11-13 15:44:24.000000000 +1100
+++ ./include/linux/nfsd/nfsfh.h	2006-11-13 15:47:02.000000000 +1100
@@ -217,11 +217,7 @@ void	fh_put(struct svc_fh *);
 static __inline__ struct svc_fh *
 fh_copy(struct svc_fh *dst, struct svc_fh *src)
 {
-	if (src->fh_dentry || src->fh_locked) {
-		struct dentry *dentry = src->fh_dentry;
-		printk(KERN_ERR "fh_copy: copying %s/%s, already verified!\n",
-			dentry->d_parent->d_name.name, dentry->d_name.name);
-	}
+	WARN_ON(src->fh_dentry || src->fh_locked);
 			
 	*dst = *src;
 	return dst;
@@ -300,10 +296,8 @@ fh_lock_nested(struct svc_fh *fhp, unsig
 	dfprintk(FILEOP, "nfsd: fh_lock(%s) locked = %d\n",
 			SVCFH_fmt(fhp), fhp->fh_locked);
 
-	if (!fhp->fh_dentry) {
-		printk(KERN_ERR "fh_lock: fh not verified!\n");
-		return;
-	}
+	BUG_ON(!dentry);
+
 	if (fhp->fh_locked) {
 		printk(KERN_WARNING "fh_lock: %s/%s already locked!\n",
 			dentry->d_parent->d_name.name, dentry->d_name.name);
@@ -328,8 +322,7 @@ fh_lock(struct svc_fh *fhp)
 static inline void
 fh_unlock(struct svc_fh *fhp)
 {
-	if (!fhp->fh_dentry)
-		printk(KERN_ERR "fh_unlock: fh not verified!\n");
+	BUG_ON(!fhp->fh_dentry);
 
 	if (fhp->fh_locked) {
 		fill_post_wcc(fhp);
