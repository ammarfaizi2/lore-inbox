Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbUKIIIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUKIIIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUKIIGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:06:48 -0500
Received: from mail.kroah.org ([69.55.234.183]:6042 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261435AbUKIIFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:05:31 -0500
Date: Tue, 9 Nov 2004 00:05:09 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, Tejun Heo <tj@home-tj.org>
Cc: mingo@elte.hu, diffie@gmail.com, linux-kernel@vger.kernel.org,
       diffie@blazebox.homeip.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041109080509.GA10724@kroah.com>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu> <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org> <20041109071455.GA11643@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109071455.GA11643@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 11:14:55PM -0800, Greg KH wrote:
> On Mon, Nov 08, 2004 at 09:27:47PM -0800, Andrew Morton wrote:
> > Greg KH <greg@kroah.com> wrote:
> > >
> > > So I don't see how that could be failing here.  And why I don't see this
> > >  on my boxes...
> > 
> > OK, progress.  The oops is due to CONFIG_LEGACY_PTY_COUNT=512.  I assume
> > anything greater than 256 will trigger it.
> > 
> > - tty_register_driver() calls tty_register_device() for 512 devices.
> > 
> > - tty_register_device() calls pty_line_name() for the 512 devices, but
> >   pty_line_name() only understands 256 devices.  After that, it starts
> >   returning duplicated names.
> > 
> > - class_simple_device_add() gets an -EEXIST return from
> >   class_device_register() and then tries to kfree local variable s_dev, but
> >   it's already free.  Presumably all that icky refcounting under
> >   class_device_register() did this for us already.  Can you fix this one
> >   Greg?  Just enable slab debugging, set CONFIG_LEGACY_PTY_COUNT=512 and
> >   watch the fun.
> 
> Ick, yeah, I just tested that.  I don't know why that's happening, I'll
> go fix it up now.

Ah, found it.  Was caused by a patch from Tejun Heo <tj@home-tj.org>
that went into the tree in my last round of driver core changes.

Tejun, the call to unlink() in the error path in kobject_add() does a
kobject_put().  Your patch added an extra kobject_put() which caused bad
things to happen when we failed.

Andrew, does the patch below fix the issue for you?  It fixed my test
case.

thanks,

greg k-h

 Subject: Remove extra kobject_put() in kobject_add() error path.

 Also document the thing so no one tries to "fix" it again...
 
 Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


--- a/lib/kobject.c	2004-11-05 10:06:33 -08:00
+++ b/lib/kobject.c	2004-11-08 23:58:02 -08:00
@@ -181,10 +181,10 @@ int kobject_add(struct kobject * kobj)
 
 	error = create_dir(kobj);
 	if (error) {
+		/* Does the kobject_put() for us */
 		unlink(kobj);
 		if (parent)
 			kobject_put(parent);
-		kobject_put(kobj);
 	} else {
 		kobject_hotplug(kobj, KOBJ_ADD);
 	}
