Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWBRDae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWBRDae (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 22:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWBRDad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 22:30:33 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:20906 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750783AbWBRDad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 22:30:33 -0500
Date: Sat, 18 Feb 2006 04:30:31 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: kjournald keeps reference to namespace
Message-ID: <20060218033031.GB32706@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
References: <20060218013547.GA32706@MAIL.13thfloor.at> <20060217175428.7ce7b26f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217175428.7ce7b26f.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 05:54:28PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > 
> > Hi Folks!
> > 
> > when creating a private namespace (CLONE_NS) and
> > then mounting an ext3 filesystem, a new kernel
> > thread (kjournald) is created, which keeps a
> > reference to the namespace, which after the the
> > process exits, remains and blocks access to the
> > block device, as it is still bd_claim-ed.
> 
> There are numerous ways in which user processes can parent kernel threads.
> 
> bix:/usr/src/linux-2.6.16-rc4> grep -rl kernel_thread drivers net fs | wc
>      64      64    1657
> 
> > this leaves a private namespace behind and a
> > block device which cannot be opened exclusively.
> > unmount is not an option, as the namespace is
> > not longer reachable.
> > 
> > this behaviour seems to be there since ever,
> > well since namespaces and kjournald exists :)
> > 
> > the following 'cruel' hack 'solves' this issue
> > 
> > best,
> > Herbert
> > 
> > 
> > --- fs/jbd/journal.c.orig	2006-01-03 17:29:56 +0100
> > +++ fs/jbd/journal.c	2006-02-18 02:23:21 +0100
> > @@ -33,6 +33,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/suspend.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/namespace.h>
> >  #include <asm/uaccess.h>
> >  #include <asm/page.h>
> >  #include <linux/proc_fs.h>
> > @@ -116,6 +117,13 @@ static int kjournald(void *arg)
> >  	struct timer_list timer;
> >  
> >  	daemonize("kjournald");
> > +	{
> > +		struct namespace *ns = current->namespace;
> > +
> > +		current->namespace = NULL;
> > +		put_namespace(ns);
> > +	}
> > +
> >  
> 
> I think it'd be better to convert ext3 to use the kthread API which
> appears to accidentally not have this problem, because such threads
> are parented by keventd, which were parented by init.

sounds like a plan!

> That being said, perhaps we should do a put_namespace() in
> kernel_thread(), too.

hmm, keep the reference but put_namespace()?

> I'm kinda surprised that your patch didn't oops over a NULL
> ->namespace when the kernel internally mounted the root filesystem.

nope, booted just fine, but I was worried too, the
interesting detail is that the kjournald thread 
vanishes with this 'hack' when the namespace is
disposed, which doesn't happen without it ...

anyway, will look into it, of course, input is
welcome ...

best,
Herbert


