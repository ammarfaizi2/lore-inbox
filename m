Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276768AbRJQNj3>; Wed, 17 Oct 2001 09:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276682AbRJQNjU>; Wed, 17 Oct 2001 09:39:20 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:25104 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S276836AbRJQNjK>; Wed, 17 Oct 2001 09:39:10 -0400
Message-ID: <3BCD8AC5.8FD733BC@loewe-komp.de>
Date: Wed, 17 Oct 2001 15:42:29 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Steve Lord <lord@sgi.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS related Oops in 2.4.[39]-xfs
In-Reply-To: <200110170928.f9H9SsP07618@jen.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> 
> Where did you get your kernel (the 2.4.9 version that is) this problem
> sounds familiar, but I am pretty sure we fixed this case in XFS somewhere
> between 2.4.3 and 2.4.9.
> 

The following diff was made in 2.4.4.

diff -u --recursive --new-file v2.4.4/linux/fs/nfsd/nfsfh.c linux/fs/nfsd/nfsfh.c
--- v2.4.4/linux/fs/nfsd/nfsfh.c        Fri Feb  9 11:29:44 2001
+++ linux/fs/nfsd/nfsfh.c       Sat May 19 17:47:55 2001
@@ -244,6 +245,11 @@
         */
        pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
        d_drop(tdentry); /* we never want ".." hashed */
+       if (!pdentry && tdentry->d_inode == NULL) {
+               /* File system cannot find ".." ... sad but possible */
+               dput(tdentry);
+               pdentry = ERR_PTR(-EINVAL);
+       }

But it would not prevent the code path 2.4.3-xfs hit.
pdentry is !=NULL and tdentry->d_inode is always NULL after d_alloc():611

Does xfs' child->d_inode->i_op->lookup(child->d_inode, tdentry);
change the contents of tdentry if the lookup("..") succeeds?

Then I suggest:

!       if (!pdentry || tdentry->d_inode == NULL) {

What do you think?
BTW, when does a lookup("..") fail? Even in "/", lookup("..") returns "."


> > struct dentry *nfsd_findparent(struct dentry *child)
> > {
> >         struct dentry *tdentry, *pdentry;
> >         tdentry = d_alloc(child, &(const struct qstr) {"..", 2, 0});
> >         if (!tdentry)
> >                 return ERR_PTR(-ENOMEM);
> >
> >         /* I'm going to assume that if the returned dentry is different, then
> >          * it is well connected.  But nobody returns different dentrys do they?
> >          */
> >         pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
> >         d_drop(tdentry); /* we never want ".." hashed */
+       if (!pdentry && tdentry->d_inode == NULL) {
+               /* File system cannot find ".." ... sad but possible */
+               dput(tdentry);
+               pdentry = ERR_PTR(-EINVAL);
+       }
> >         if (!pdentry) {
> >                 /* I don't want to return a ".." dentry.
> >                  * I would prefer to return an unconnected "IS_ROOT" dentry,
> >                  * though a properly connected dentry is even better
> >                  */
> >                 /* if first or last of alias list is not tdentry, use that
> >                  * else make a root dentry
> >                  */
> >                 struct list_head *aliases = &tdentry->d_inode->i_dentry;
> >                 spin_lock(&dcache_lock);
> >                 if (aliases->next != aliases) {         <=========== CRASH
> >                         pdentry = list_entry(aliases->next, struct dentry, d_
