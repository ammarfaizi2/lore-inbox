Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932407AbVJaKRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932407AbVJaKRj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbVJaKRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:17:39 -0500
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:8113 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932407AbVJaKRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:17:39 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't
	change mtime if size doesn't change.
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: NeilBrown <neilb@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1130752124.7504.13.camel@imp.csi.cam.ac.uk>
References: <20051031173358.9566.patches@notabene>
	 <1051031063444.9586@suse.de>  <20051030234837.36c7a249.akpm@osdl.org>
	 <1130752124.7504.13.camel@imp.csi.cam.ac.uk>
Content-Type: text/plain
Organization: Computing Service, University of Cambridge, UK
Date: Mon, 31 Oct 2005 10:16:59 +0000
Message-Id: <1130753819.7504.21.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 09:48 +0000, Anton Altaparmakov wrote:
> On Sun, 2005-10-30 at 23:48 -0800, Andrew Morton wrote:
> > NeilBrown <neilb@suse.de> wrote:
> > > According to Posix and SUS, truncate(2) and ftruncate(2) only update
> > > ctime and mtime if the size actually changes.  Linux doesn't currently
> > > obey this.
> > > 
> > > There is no need to test the size under i_sem, as loosing any race
> > > will not make a noticable different the mtime or ctime.
> > 
> > Well if there's a race then the file may end up not being truncated after
> > this patch is applied.  But that could have happened anwyay, so I don't see
> > a need for i_sem synchronisation either.
> > 
> > > (According to SUS, truncate and ftruncate 'may' clear setuid/setgid
> > >  as well, currently we don't.  Should we?
> > > )
> > > 
> > > 
> > > Signed-off-by: Neil Brown <neilb@suse.de>
> > > 
> > > ### Diffstat output
> > >  ./fs/open.c |    6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff ./fs/open.c~current~ ./fs/open.c
> > > --- ./fs/open.c~current~	2005-10-31 16:22:44.000000000 +1100
> > > +++ ./fs/open.c	2005-10-31 16:22:44.000000000 +1100
> > > @@ -260,7 +260,8 @@ static inline long do_sys_truncate(const
> > >  		goto dput_and_out;
> > >  
> > >  	error = locks_verify_truncate(inode, NULL, length);
> > > -	if (!error) {
> > > +	if (!error &&
> > > +	    length != i_size_read(dentry->d_inode)) {
> > 
> > Odd code layout?
> > 
> > >  		DQUOT_INIT(inode);
> > >  		error = do_truncate(nd.dentry, length);
> > >  	}
> > > @@ -313,7 +314,8 @@ static inline long do_sys_ftruncate(unsi
> > >  		goto out_putf;
> > >  
> > >  	error = locks_verify_truncate(inode, file, length);
> > > -	if (!error)
> > > +	if (!error &&
> > > +	    length != i_size_read(dentry->d_inode))
> > >  		error = do_truncate(dentry, length);
> > >  out_putf:
> > >  	fput(file);
> > 
> > This partially obsoletes the similar optimisation in inode_setattr().  I
> > guess the optimisation there retains some usefulness for O_TRUNC opens of
> > zero-length files, but for symettry and micro-efficiency, perhaps we should
> > remvoe the inode_setattr() test and check for i_size==0 in may_open()?
> 
> Sounds like a good idea.  That does simplify inode_setattr() nicely...

D'oh!  I forgot to append the may_open diff!  Below is full patch...

> Signed-off-by: Anton Altaparmakov <aia21@cantab.net>
> 
> --- linux-2.6/fs/attr.c.old	2005-10-31 09:29:38.000000000 +0000
> +++ linux-2.6/fs/attr.c	2005-10-31 09:30:39.000000000 +0000
> @@ -70,19 +70,10 @@ int inode_setattr(struct inode * inode, 
>  	int error = 0;
>  
>  	if (ia_valid & ATTR_SIZE) {
> -		if (attr->ia_size != i_size_read(inode)) {
> -			error = vmtruncate(inode, attr->ia_size);
> -			if (error || (ia_valid == ATTR_SIZE))
> -				goto out;
> -		} else {
> -			/*
> -			 * We skipped the truncate but must still update
> -			 * timestamps
> -			 */
> -			ia_valid |= ATTR_MTIME|ATTR_CTIME;
> -		}
> +		error = vmtruncate(inode, attr->ia_size);
> +		if (error || (ia_valid == ATTR_SIZE))
> +			goto out;
>  	}
> -
>  	if (ia_valid & ATTR_UID)
>  		inode->i_uid = attr->ia_uid;
>  	if (ia_valid & ATTR_GID)
> 
> btw. Is it actually correct that we "goto out;" when "ia_valid ==
> ATTR_SIZE"?  That way we skip the mark_inode_dirty() call just before
> the "out" label...
> 
> For ntfs at least that is fine because ntfs does an
> "inode_update_time(inode, 1)" unconditionally in ntfs_truncate() even
> when the size has not changed which calls mark_inode_dirty_sync() and
> when the size changes it also does a "__mark_inode_dirty(inode,
> I_DIRTY_SYNC | I_DIRTY_DATASYNC);" but I am not sure all filesystems are
> fine in that respect?

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

---

From: Anton Altaparmakov <aia21@cantab.net>

In may_open() only truncate when O_TRUNC is set and the file size is not
zero.

And in inode_setattr() always do the truncate as we catch the file size
not changing case earlier.  (And on a race condition the filesystem will
notice that the size is not changing...)

Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

--- linux-2.6/fs/attr.c.old	2005-10-31 09:29:38.000000000 +0000
+++ linux-2.6/fs/attr.c	2005-10-31 09:30:39.000000000 +0000
@@ -70,19 +70,10 @@ int inode_setattr(struct inode * inode, 
 	int error = 0;
 
 	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size != i_size_read(inode)) {
-			error = vmtruncate(inode, attr->ia_size);
-			if (error || (ia_valid == ATTR_SIZE))
-				goto out;
-		} else {
-			/*
-			 * We skipped the truncate but must still update
-			 * timestamps
-			 */
-			ia_valid |= ATTR_MTIME|ATTR_CTIME;
-		}
+		error = vmtruncate(inode, attr->ia_size);
+		if (error || (ia_valid == ATTR_SIZE))
+			goto out;
 	}
-
 	if (ia_valid & ATTR_UID)
 		inode->i_uid = attr->ia_uid;
 	if (ia_valid & ATTR_GID)
--- linux-2.6/fs/namei.c.old	2005-10-31 09:28:38.000000000 +0000
+++ linux-2.6/fs/namei.c	2005-10-31 09:30:39.000000000 +0000
@@ -1447,7 +1447,7 @@ int may_open(struct nameidata *nd, int a
 	if (error)
 		return error;
 
-	if (flag & O_TRUNC) {
+	if (flag & O_TRUNC && i_size_read(inode)) {
 		error = get_write_access(inode);
 		if (error)
 			return error;


