Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423138AbWANADl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423138AbWANADl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 19:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423139AbWANADl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 19:03:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:37513 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1423138AbWANADk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 19:03:40 -0500
Date: Fri, 13 Jan 2006 16:02:46 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] kobject: don't oops on null kobject.name
Message-ID: <20060114000246.GA7549@kroah.com>
References: <200601122004_MC3-1-B5C5-4B72@compuserve.com> <20060113143013.0ed0f9c0.akpm@osdl.org> <20060113225537.GA25522@kroah.com> <20060113151213.61e40f2b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113151213.61e40f2b.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 03:12:13PM -0800, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > > 
> > > I'd have thought that we'd want the test right at the start of
> > > kobject_add() - fail it if ->name is zero.  I don't know if that'd work for
> > > all callers, but kobject_add() does play around with the ->name field and
> > > will go oops if ->name==NULL and debugging is enabled.
> > 
> > Something like this instead?
> 
> I think so.
> 
> >   (warning, untested...)
> 
> Ship it!

Heh, it works for me, I'm running with it right now :)

> 
> > I'll try it out in a reboot cycle...
> > 
> > --- gregkh-2.6.orig/lib/kobject.c	2006-01-13 09:15:18.000000000 -0800
> > +++ gregkh-2.6/lib/kobject.c	2006-01-13 14:54:40.000000000 -0800
> > @@ -164,6 +164,11 @@ int kobject_add(struct kobject * kobj)
> >  		return -ENOENT;
> >  	if (!kobj->k_name)
> >  		kobj->k_name = kobj->name;
> > +	if (!kobj->k_name) {
> > +		pr_debug("kobject attempted to be registered with no name!\n");
> > +		WARN_ON(1);
> > +		return -EINVAL;
> > +	}
> >  	parent = kobject_get(kobj->parent);
> >  
> >  	pr_debug("kobject %s: registering. parent: %s, set: %s\n",
> 
> It might be worth emitting the warning and then proceeding rather than
> failing - minimise potential disruption.  I guess we'll see...

Hm, I looked at the only user of kobjects in the kernel that I know of
that doesn't use sysfs (the cdev code) and even it sets the kobject name
to something sane, so I think we should be safe with this.

I'll add it to my tree and let's see what the next -mm causes to pop up
:)

thanks,

greg k-h
