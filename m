Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263789AbUEMF7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263789AbUEMF7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 01:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUEMF7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 01:59:09 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:13540 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S263789AbUEMF7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 01:59:02 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Greg Banks <gnb@melbourne.sgi.com>
Date: Thu, 13 May 2004 15:58:35 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16547.3723.584971.907946@cse.unsw.edu.au>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
In-Reply-To: message from Greg Banks on Monday May 10
References: <16521.5104.489490.617269@laputa.namesys.com>
	<16529.56343.764629.37296@cse.unsw.edu.au>
	<409634B9.8D9484DA@melbourne.sgi.com>
	<16534.54704.792101.617408@cse.unsw.edu.au>
	<16542.63130.911881.340894@cse.unsw.edu.au>
	<409F6741.19A29C20@melbourne.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[I wrote this a few days ago but it looks like I forgot to post it...]

On Monday May 10, gnb@melbourne.sgi.com wrote:
> Neil Brown wrote:
> > 
> > > > *   Logic bug in d_splice_alias() forgets to clear the DCACHE_DISCONNECTED
> > > >     flag when a lookup connects a disconnected dentry.  Fix is (relative
> > > >     to Neil's patch):
> > >
> > Ok, I've reviewed the code and thought about it some more.
> > 
> > This was intentional and the patch to clear DCACHE_DISCONNECTED is not
> > needed and possibly wrong.
> > 
> > DCACHE_DISCONNECTED *doesn't* mean that the entries isn't connected,
> > but only that it might not be.
> 
> Agreed.  After reading your comments below the semantics of the flag
> make sense: was once disconnected and may or may not still be depending
> on lazy clearing by the expfs.c code).  My dentry state checking code
> was wrong.
> 
> Of course I now have an issue with the misleading name ;-)

Maybe:   DCACHE_NOT_KNOWN_TO_BE_CONNECTED.
Unfortunately the absence of the flags is stronger information that
it's presence and that makes it hard to name...

> 
> What I'm wondering is, do we still need DCACHE_DISCONNECTED at all?
> Perhaps the uses of it could be replaced with combinations of checks
> of IS_ROOT() and (d == d->d_sb->s_root) ?

It is still needed.
Suppose one thread creates a disconnected dentry, and then starts building
the path from the bottom up.
When it is half way up another request comes in for the same
filehandle.  The same dentry is found.  It is now not IS_ROOT, but
still DCACHE_DISCONNECTED.  Until it is fully connected the second
request shouldn't proceed, and without the DCACHE_DISCONNECTED flag it
is expensive to test for connected-ness.  !IS_ROOT certainly isn't
enough.

> 
> The changes look good but I think the invariants you describe above
> should go in a comment.

Good point.  Which comment I wonder...

> 
> I will try to do some testing in the next couple of days.
> 
> > -void d_move(struct dentry * dentry, struct dentry * target)
> > +static void d_move_locked(struct dentry * dentry, struct dentry * target)
> >  {
> >  	if (!dentry->d_inode)
> >  		printk(KERN_WARNING "VFS: moving negative dcache entry\n");
> >[...]
> > +
> > +void d_move(struct dentry * dentry, struct dentry * target)
> > +{
> > +       if (!dentry->d_inode)
> > +               printk(KERN_WARNING "VFS: moving negative dcache entry\n");
> > +
> 
> Do you need two copies of this check in the same path?
> 

No.  cut-and-paste error I think.

NeilBrown
