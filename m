Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267804AbTAMEAX>; Sun, 12 Jan 2003 23:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbTAMEAW>; Sun, 12 Jan 2003 23:00:22 -0500
Received: from dp.samba.org ([66.70.73.150]:52419 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267804AbTAMEAQ>;
	Sun, 12 Jan 2003 23:00:16 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: [PATCH] fixup loop blkdev, add module_get 
In-reply-to: Your message of "Sun, 12 Jan 2003 21:03:25 CDT."
             <20030113020325.GA18756@gtf.org> 
Date: Mon, 13 Jan 2003 15:08:25 +1100
Message-Id: <20030113040906.A72D22C052@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030113020325.GA18756@gtf.org> you write:
> On Mon, Jan 13, 2003 at 11:55:47AM +1100, Rusty Russell wrote:
> > In message <20030112035620.GA25648@gtf.org> you write:
> > > Sometimes, we are absolutely certain that we have at least one module
> > > reference "locked open" for us.  Loop is an example of such a case:  the
> > > set-fd and clear-fd struct block_device_operations ioctls already have a
> > > module reference from simply the block device being opened.
> > > 
> > > Therefore, we can just unconditionally increment the module refcount.
> > > I added module_get to do this.
> > 
> > Hi Jeff,
> > 
> > 	We may yet want such a primitive, but I've been resisting it
> > for the moment.
> > 
> > 	Firstly, because it's a very specialized and rare case which
> > lends itself to being abused, and secondly because if I "rmmod --wait"
> > the module, then such operations which try to hold the module in place
> > *should* fail.  Not doing so is impolite, at least.
> 
> Eh...  You are trying to chase infinity with 'rmmod --wait'.

No, you are trying to remove something and you want to chase down and
kill the users, scripts, whatever.  It guarantees that no new users
will access the module.

> I disagree:
> 
> 1) we do not prevent root from shooting themselves in the foot,

I don't understand this point.

> 2) moreover we do not prevent them from doing something that may be
> perfectly reasonable,

Nor this one, which seems to bethe same.

> 3) and this kind of code just adds error handling for no reason, when
> _not_ handling the error keeps the code more clean.

No, the reason is simple: the admin has said they want the damn module
removed.  They've *told* you what they want.  Why do you want to
disobey them?  8)

> In general this is just caring way too much about an obscure corner
> case.  Is the increased complexity of error handling when we _know_ the
> refcnt is locked for worth it?

Is the increased complexity of another primitive for "you know you
have a refcount" worth it? 8)

If there were 10 of these cases, sure, a __try_module_get() makes
sense: IMHO this is one of those areas on which intelligent people can
disagree, I think.

> Note that Linus turned off the 'deprecated' warning because MOD.*COUNT
> users are just too frequent, still.

Note that I didn't put the damn thing in there 8)

Hope he turned them back into macros, so the __unsafe runtime warning
doesn't report "module.h".

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
