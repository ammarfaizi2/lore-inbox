Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbRGWXjF>; Mon, 23 Jul 2001 19:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265024AbRGWXi4>; Mon, 23 Jul 2001 19:38:56 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:49935 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264976AbRGWXin>; Mon, 23 Jul 2001 19:38:43 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Gordon Lack <gmlack@freenet.co.uk>
Date: Tue, 24 Jul 2001 09:38:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15196.46461.777316.202665@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFSv3 pathname problems in 2.4 kernels
In-Reply-To: message from Gordon Lack on Monday July 23
In-Reply-To: <3B5B32B2.B96E6BD3@freenet.co.uk>
	<15195.35313.83387.515099@notabene.cse.unsw.edu.au>
	<3B5CA338.890F9586@freenet.co.uk>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Monday July 23, gmlack@freenet.co.uk wrote:
> Neil Brown wrote:
> > 
> > This shouldn't be a problem for Solaris 2.6, but definately is for
> > Irix.
> 
>    Well, there are many 2.6 systems and they all fail in the same aay
> as Irix.  So does Solaris 2.7.  (2.8 seems to be Ok).

Odd indeed.  I use 2.6 systems and they seem fine.  I have only had
the problem when using an old version of mountd.  What verion of
nfs-utils are you using?

> > Look in fs/nfsd/nfsfh.c, in fh_compose.
> > If you change:
> >         if (ref_fh &&
> >             ref_fh->fh_handle.fh_version == 0xca &&
> >             parent->d_inode->i_sb->s_op->dentry_to_fh == NULL) {
> > to
> >         if (parent->d_inode->i_sb->s_op->dentry_to_fh == NULL) {
> > you will probably get what you want, for ext2 at least.
> 
>    Thanks, but this is for xfs (I didn't fancy fsck'ing a 470GB file
> system!).  I suppose it's suck it and see....

It should work for xfs, and infact everything but reiserfs as it is
the only filesys that currently sets dentry_to_fh.
However a better, more general solution would be to add a line:

 if (fhp->fh_handle.fh_size < NFS_FHSIZE)
     fhp->fh_handle.fh_size = NFS_FHSIZE;

just before the "return 0" in fh_update, and

 if (inode && fhp->fh_handle.fh_size < NFS_FHSIZE)
     fhp->fh_handle.fh_size = NFS_FHSIZE;

before the "return 0" in fh_compose.

NeilBrown
