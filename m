Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276906AbRJQOwv>; Wed, 17 Oct 2001 10:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276907AbRJQOwl>; Wed, 17 Oct 2001 10:52:41 -0400
Received: from zok.sgi.com ([204.94.215.101]:25783 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S276906AbRJQOwf>;
	Wed, 17 Oct 2001 10:52:35 -0400
Message-Id: <200110171450.f9HEodJ17523@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
cc: Steve Lord <lord@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: NFS related Oops in 2.4.[39]-xfs 
In-Reply-To: Message from Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de> 
   of "Wed, 17 Oct 2001 15:53:19 +0200." <3BCD8D4F.B26684B@loewe-komp.de> 
Content-Transfer-Encoding: 8bit
Date: Wed, 17 Oct 2001 09:50:39 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Peter Wdchtler wrote:
> > 
> > Steve Lord wrote:
> > >
> > > Where did you get your kernel (the 2.4.9 version that is) this problem
> > > sounds familiar, but I am pretty sure we fixed this case in XFS somewhere
> > > between 2.4.3 and 2.4.9.
> > >
> > 
> > The following diff was made in 2.4.4.
> > 
> > diff -u --recursive --new-file v2.4.4/linux/fs/nfsd/nfsfh.c linux/fs/nfsd/n
> fsfh.c
> > --- v2.4.4/linux/fs/nfsd/nfsfh.c        Fri Feb  9 11:29:44 2001
> > +++ linux/fs/nfsd/nfsfh.c       Sat May 19 17:47:55 2001
> > @@ -244,6 +245,11 @@
> >          */
> >         pdentry = child->d_inode->i_op->lookup(child->d_inode, tdentry);
> >         d_drop(tdentry); /* we never want ".." hashed */
> > +       if (!pdentry && tdentry->d_inode == NULL) {
> > +               /* File system cannot find ".." ... sad but possible */
> > +               dput(tdentry);
> > +               pdentry = ERR_PTR(-EINVAL);
> > +       }
> > 
> > But it would not prevent the code path 2.4.3-xfs hit.
> > pdentry is !=NULL and tdentry->d_inode is always NULL after d_alloc():611
> > 
> 
> Damn. pdentry IS NULL.
> Sorry, the patch would prevent the crash.


OK, I am back again....

I went and looked through xfs code changes, and the 2.4.9 patch should
have some changes in it related to this type of issue. However, you would
have to be using xfsdump to trigger them I think, or possibly the xfs_fsr
program. The combination of xfsdump and an nfs server did have some problems.

So, does this tie in with your configuation? It does not however explain
problems in 2.4.9. There was just a recent code cleanup of the code paths
used by xfsdump (post 2.4.12 patch), but I am not aware of any other XFS
changes in this area. 

XFS does work OK with the new VM, so you can try later kernels if you want,
I am not aware of anyone else having problems with XFS which appear dcache
related.

Steve (slightly stumped and in need of coffee)



> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


