Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315259AbSEaNEQ>; Fri, 31 May 2002 09:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315265AbSEaNEP>; Fri, 31 May 2002 09:04:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:47551 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315259AbSEaNEO>;
	Fri, 31 May 2002 09:04:14 -0400
Date: Fri, 31 May 2002 16:03:21 +0300
From: Dan Aloni <da-x@gmx.net>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dcache.{c,h} cleanup
Message-ID: <20020531130321.GA22523@callisto.yi.org>
In-Reply-To: <20020531082806.GA4053@callisto.yi.org> <200205310919.g4V9JgA22954@northrelay01.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 02:56:23PM +0530, Maneesh Soni wrote:
> On Fri, 31 May 2002 14:02:07 +0530, Dan Aloni wrote:
> 
> >  + use d_unhashed() instead of list_empty(&dentry->d_hash) 
> There are few more list_empty(...->d_hash)s left 
> 
> fs/intermezzo/journal.c presto_path   
> fs/libfs.c              dcache_dir_lseek  
> fs/libfs.c              dcache_readdir    
> kernel/exit.c           __unhash_process  

I'll send a patch to rusty.

> >  	if (dentry->d_op && dentry->d_op->d_delete) {
> >  		if (dentry->d_op->d_delete(dentry))
> > -			goto unhash_it;
> > +			goto kill_it;
> >  	}
> >  	/* Unreachable? Get rid of it */
> > -	if (list_empty(&dentry->d_hash))
> > +	if (d_unhashed(dentry))
> >  		goto kill_it;
> 		^^^^^^^^^^^^^
> This will do list_del_init on a already unhashed dentry.
> 

I am awake of this. From what I've seen, a second list_del_init 
is a no-op, and this one-liner doesn't yell 'refactor me'.

> > -unhash_it:
> > -	list_del_init(&dentry->d_hash);
> > +kill_it:
> > +	parent = d_release(dentry);
> > +	if (dentry == parent)

-- 
Dan Aloni
da-x@gmx.net
