Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVC3W1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVC3W1W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 17:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVC3W1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 17:27:22 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:63619 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262460AbVC3W1E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 17:27:04 -0500
Subject: Re: [PATCH] Set MS_ACTIVE in isofs_fill_super()
From: Russ Weight <rweight@us.ibm.com>
Reply-To: rweight@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050330123907.10740bc1.akpm@osdl.org>
References: <1112213392.25362.65.camel@russw.beaverton.ibm.com>
	 <20050330123907.10740bc1.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 30 Mar 2005 14:26:59 -0800
Message-Id: <1112221619.9858.89.camel@russw.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 12:39 -0800, Andrew Morton wrote:
> Russ Weight <rweight@us.ibm.com> wrote:
> >
> > This patch sets the MS_ACTIVE bit in isofs_fill_super() prior to calling
> > iget() or iput(). This eliminates a race condition between mount
> > (for isofs) and kswapd that results in a system panic.
> > 
> > Signed-off-by: Russ Weight <rweight@us.ibm.com>
> > 
> > --- linux-2.6.12-rc1/fs/isofs/inode.c	2005-03-17 17:34:36.000000000
> > -0800
> > +++ linux-2.6.12-rc1-isofsfix/fs/isofs/inode.c	2005-03-22
> > 15:29:51.945607217 -0800
> > @@ -820,6 +820,7 @@
> >  	 * the s_rock flag. Once we have the final s_rock value,
> >  	 * we then decide whether to use the Joliet descriptor.
> >  	 */
> > +	s->s_flags |= MS_ACTIVE;
> >  	inode = isofs_iget(s, sbi->s_firstdatazone, 0);
> >  
> >  	/*
> > @@ -909,6 +910,7 @@
> >  		kfree(opt.iocharset);
> >  	kfree(sbi);
> >  	s->s_fs_info = NULL;
> > +	s->s_flags &= ~MS_ACTIVE;
> >  	return -EINVAL;
> >  }
> >  
> 
> The patch is obviously safe enough, but seems a bit kludgy.
> 
> The basic problem here appears to be that isofs is doing iget/iput in
> ->fill_super before MS_ACTIVE is set and the inode freeing code
> (generic_forget_inode) doesn't expect that to happen, yes?

Yes.

> I wonder if it would make more sense for all the ->fill_super callers to
> set MS_ACTIVE prior to calling ->fill_super(), and clear MS_ACTIVE if
> fill_super() failed?

It does seem a bit kludgy. I was trying keep the changes in isofs
specific code, and this seemed the best way to do it.

When you say "all the ->fill_super callers", are you referring to the
fill_super functions for all filesystems? Or just callers to
isofs_fill_super()?

isofs_fill_super() is called by get_sb_bdev(), which is in the generic
filesystem code. get_sb_bdev() receives a pointer as a parameter when it
is called from isofs_get_sb(). To make a change in get_sb_bdev() would
be to affect many (all?) filesystems. This may be the right thing to do
- although it seems a little heavy-weight since the failure hasn't been
reported in other filesystems.



