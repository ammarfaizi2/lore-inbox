Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265979AbTIJXGQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbTIJXGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:06:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:34783 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265979AbTIJXGL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:06:11 -0400
Date: Wed, 10 Sep 2003 16:06:14 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030910230614.GB5758@kroah.com>
References: <20030910041122.GE9760@kroah.com> <20030910080955.9318E2C0EB@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910080955.9318E2C0EB@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:07:35PM +1000, Rusty Russell wrote:
> In message <20030910041122.GE9760@kroah.com> you write:
> > On Wed, Sep 10, 2003 at 01:31:02PM +1000, Rusty Russell wrote:
> > > Because kobject does not have a "struct module *owner", we can't
> > > simply add in the refcount.
> > 
> > Um, I don't understand.  There is no "struct module *owner in struct
> > kobject.  There is one in struct attribute, but I don't set it, so it
> > doesn't matter for this usage.
> 
> Your parser broke, I think 8)

Ok, let's try again. :)

Why are you detaching the kobject from struct module?
In my patch I accounted for the kobject's reference count in the module
reference count (just not the count exported to userspace, as to not
break the userspace tools.)  So if a user has a module sysfs file open
(like the "refcount" file), the module reference count is incremented
and the module is not allowed to be unloaded until that count drops.
This removes any race condition with the kobject being in use when the
module structure is freed.

Does that make sense?

> > > The module reference count is defined to never go from zero to one
> > > when the module is dying, which means callers must use
> > > try_module_get().  I grab the reference on read/write, which means
> > > opening the file won't hold the module, either.
> > 
> > read/write of what?  The attribute?  Sure, why not set the module
> > attribute sysfs file to the module that way the reference count will be
> > incremented if the sysfs file is opened.
> 
> Hmm, because there's one attribute: which module would own it?  You're
> going to creation attributes per module later (for module parameters),
> so when you do that it might make sense to do this too.

The attribute "refcount" is "owned" by the module itself.  The kobject
count is incremented if the file is opened by the sysfs core, thus
preventing the module from being able to be unloaded.

The same thing will happen for module paramaters.  They are owned by the
module structure as well.

It all "just works" :)

> > But in looking at your patch, I don't see why you want to separate the
> > module from the kobject?  What benefit does it have?
> 
> The lifetimes are separate, each controlled by their own reference
> count.  I *know* this will work even if someone holds a reference to
> the kobject (for some reason in the future) even as the module is
> removed.

But my patch prevented that from ever happening.  If someone grabbed the
kobject, the module could not be unloaded.  That fixes all kinds of
races.

> > > Were you intending to put all the info currently in /proc/modules
> > > under sysfs?  Makes sense I think.  For the options you'll need a
> > > subdir to avoid name clashes.
> > 
> > Yes, I was going to add it, this patch was more of a "test" to see how
> > receptive you were to it.
> 
> More more! 8)

But whose patch to build on, mine, or your version?  :)

thanks,

greg k-h
