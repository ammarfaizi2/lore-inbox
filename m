Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933034AbWKLRs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933034AbWKLRs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 12:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbWKLRs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 12:48:28 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15370 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S933034AbWKLRs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 12:48:27 -0500
Date: Sun, 12 Nov 2006 18:48:31 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] include/linux/nfsd/nfsfh.h:fh_unlock(): change an error to a BUG_ON()
Message-ID: <20061112174831.GD3382@stusta.de>
References: <20061112131748.GI25057@stusta.de> <1163347127.6612.66.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1163347127.6612.66.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2006 at 10:58:47AM -0500, Trond Myklebust wrote:
> On Sun, 2006-11-12 at 14:17 +0100, Adrian Bunk wrote:
> > dereference
> > Reply-To: 
> > Fcc: =sent-mail
> > 
> > When we know fhp->fh_dentry is NULL, a code path where it's being 
> > dereferenced isn't a good choice.
> > 
> > Spotted by the coverity checker.
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-2.6/include/linux/nfsd/nfsfh.h.old	2006-11-12 14:13:34.000000000 +0100
> > +++ linux-2.6/include/linux/nfsd/nfsfh.h	2006-11-12 14:13:49.000000000 +0100
> > @@ -330,8 +330,7 @@ fh_unlock(struct svc_fh *fhp)
> >  {
> >  	if (!fhp->fh_dentry)
> >  		printk(KERN_ERR "fh_unlock: fh not verified!\n");
> > -
> > -	if (fhp->fh_locked) {
> > +	else if (fhp->fh_locked) {
> >  		fill_post_wcc(fhp);
> >  		mutex_unlock(&fhp->fh_dentry->d_inode->i_mutex);
> >  		fhp->fh_locked = 0;
> > 
> 
> This issue has come up on lkml before. Please just convert that check
> for fhp->fh_dentry into a BUG_ON().

Patch below.

> Trond

cu
Adrian


<--  snip  -->


!fhp->fh_dentry is a condition that mustn't ever happen (and we might 
run into additional trouble later).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/include/linux/nfsd/nfsfh.h.old	2006-11-12 18:37:43.000000000 +0100
+++ linux-2.6/include/linux/nfsd/nfsfh.h	2006-11-12 18:38:03.000000000 +0100
@@ -328,8 +328,7 @@
 static inline void
 fh_unlock(struct svc_fh *fhp)
 {
-	if (!fhp->fh_dentry)
-		printk(KERN_ERR "fh_unlock: fh not verified!\n");
+	BUG_ON(!fhp->fh_dentry);
 
 	if (fhp->fh_locked) {
 		fill_post_wcc(fhp);

