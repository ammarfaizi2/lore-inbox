Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264459AbTIJELK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 00:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264470AbTIJELK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 00:11:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:28089 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264459AbTIJELG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 00:11:06 -0400
Date: Tue, 9 Sep 2003 21:11:22 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030910041122.GE9760@kroah.com>
References: <20030909222421.GA7703@kroah.com> <20030910035038.3BE5E2C013@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910035038.3BE5E2C013@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 01:31:02PM +1000, Rusty Russell wrote:
> In message <20030909222421.GA7703@kroah.com> you write:
> > Hi,
> > 
> > A while ago we had talked about adding a kobject to struct module.  By
> > doing this we add support for module paramaters and other module info to
> > be exported in sysfs.  So here's a patch that does this that is against
> > 2.6.0-test4 (it applies with some fuzz, sorry.)
> 
> I'd just started on the same thing, but I'll use yours as a bae.
> 
> > I used the kobject reference count to add to the module reference count
> > to handle races if a user has a module owned sysfs file open, but this
> > reference is not exported to userspace, as that just confuses the
> > userspace tools a bunch (and I don't want to force people to upgrade
> > module-init-tools this late in the development cycle...)
> 
> I'm not sure if embedding the kobject in the module is the correct
> approach in this case, because we can't use the kobject refcount for
> modules because it's too slow.  This cannot be fixed before 2.7 8(

That's fine, I do not want to use the kobject refcount for modules.
modules have "special" refcount issues that you've already solved.  I
don't want to go down that rathole :)

> Because kobject does not have a "struct module *owner", we can't
> simply add in the refcount.

Um, I don't understand.  There is no "struct module *owner in struct
kobject.  There is one in struct attribute, but I don't set it, so it
doesn't matter for this usage.

> The module reference count is defined to never go from zero to one
> when the module is dying, which means callers must use
> try_module_get().  I grab the reference on read/write, which means
> opening the file won't hold the module, either.

read/write of what?  The attribute?  Sure, why not set the module
attribute sysfs file to the module that way the reference count will be
incremented if the sysfs file is opened.

I'm not trying to touch the module reference count logic here, besides
adding the kobject reference count to the internal module count logic.
I think I got it all correct and it worked for me :)

But in looking at your patch, I don't see why you want to separate the
module from the kobject?  What benefit does it have?

Hey, you're the maintainer, it's your call :)

> Were you intending to put all the info currently in /proc/modules
> under sysfs?  Makes sense I think.  For the options you'll need a
> subdir to avoid name clashes.

Yes, I was going to add it, this patch was more of a "test" to see how
receptive you were to it.

If you want, I can add the options and other info based off of this
patch.

thanks,

greg k-h
