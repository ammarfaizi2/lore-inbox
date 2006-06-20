Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWFTWbh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWFTWbh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWFTW3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:29:23 -0400
Received: from 1wt.eu ([62.212.114.60]:4361 "EHLO 1wt.eu") by vger.kernel.org
	with ESMTP id S1751336AbWFTW3N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:29:13 -0400
Date: Wed, 21 Jun 2006 00:23:57 +0200
From: Willy Tarreau <w@1wt.eu>
To: Marcelo Tosatti <marcelo@kvack.org>
Cc: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Linux 2.4.33-rc1
Message-ID: <20060620222357.GA11862@1wt.eu>
References: <20060618133718.GA2467@dmt> <ksib9210010mt9r3gjevi3dhlp4biqf59k@4ax.com> <20060618223736.GA4965@1wt.eu> <dmlb92lmehf2jufjuk8emmh63afqfmg5et@4ax.com> <20060619040152.GB2678@1wt.eu> <fvbc92higiliou420n3ctjfecdl5leb49o@4ax.com> <20060619080651.GA3273@1wt.eu> <20060619220405.GA16251@dmt> <20060619230007.GA6471@1wt.eu> <20060619234506.GA2763@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619234506.GA2763@dmt>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:45:06PM -0300, Marcelo Tosatti wrote:
> > 
> > ---- from here ----
> > 
> > 
> > > +		inode = dentry->d_inode;
> > > +		if (inode)
> > > +			atomic_inc(&inode->i_count);
> > >  		error = vfs_unlink(nd.dentry->d_inode, dentry);
> > >  	exit2:
> > >  		dput(dentry);
> > >  	}
> > >  	up(&nd.dentry->d_inode->i_sem);
> > > +	if (inode)
> > > +		iput(inode);
> > 
> > ---- to here ----
> > 
> > I believe that nd.dentry->d_inode cannot vanish because it is protected by the
> > down(->i_sem) before and the up(->i_sem) after. Am I right or am I missing
> > something important ?
> 
> Indeed it can't, but dentry->d_inode will be set to NULL by
> nfs_unlink->nfs_safe_remove->d_delete. Thus the problem.

What puzzles me is how are we supposed to up(&nd.dentry->d_inode->i_sem) if
dentry->d_inode can become NULL ? simply by keeping a copy of it ? I thought
that the down() protected the whole thing, but may be that's stupid anyway.
I've been running rc1 without this patch for a few hours and during kernel
compiles without a problem, so I'm not sure about what to think about the
other changes which were apparently harmless too :-/

Well, if I resume it right, we only need to merge your patch and mine and
it *should* be OK.

BTW, I've been reviewing the PaX patch and found *at least* one patch
that should be merged (fix for oops). I'll send it separately, and it's
queued in -upstream.

Cheers,
Willy

