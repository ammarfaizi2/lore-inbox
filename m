Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbTIKG0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266144AbTIKG0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:26:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:58508 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266143AbTIKG0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:26:39 -0400
Date: Wed, 10 Sep 2003 23:26:49 -0700
From: Greg KH <greg@kroah.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030911062649.GA10454@kroah.com>
References: <Pine.LNX.4.33.0309100807430.1012-100000@localhost.localdomain> <20030911011644.DA21C2C335@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911011644.DA21C2C335@lists.samba.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 11:13:25AM +1000, Rusty Russell wrote:
> > > > But in looking at your patch, I don't see why you want to separate the
> > > > module from the kobject?  What benefit does it have?
> > > 
> > > The lifetimes are separate, each controlled by their own reference
> > > count.  I *know* this will work even if someone holds a reference to
> > > the kobject (for some reason in the future) even as the module is
> > > removed.
> > 
> > Correct me if I'm wrong, but this sounds similar to the networking 
> > refcount problem. The reference on the containing object is the 
> > interesting one, as far as visibility goes. As long as its positive, the 
> > module is active. 
> 
> There are basically two choices: ensure that the reference count is
> taken using try_module_get() (kobject doesn't have an owner field, so
> it does not match this one), or ensure that an object isn't ever
> referenced after the module cleanup function is called.
> 
> In this context, that means that the module cleanup must pause until
> the reference count of the kobject hits zero, so it can be freed.
> 
> Implementation below.

Ah, nice catch on that bug.  I like this implementation.

On a site note, can't you just use a "struct completion" to use for your
waiting?  Or do you need to do something special here?

> BTW, The *real* answer IMHO is (this is 2.7 stuff:)
> 
> 1) Adopt a faster, smaller implementation of alloc_percpu (this patch
>    exists, needs some arch-dependent love for ia64).
> 2) Use it to generalize the current module reference count scheme to
>    a "bigref_t" (I have a couple of these)
> 3) Use that in kobjects.

Hm, I don't know if kobjects really need to get that heavy.

> 4) Decide that module removal is not as important as it was, and not
>    all modules need be removable (at least in finite time).
> 5) Use the kobject reference count everywhere, including modules.
> 
> This would make everything faster, except for the case where someone
> is actually waiting for a refcount to hit zero: for long-lived objects
> like kobjects, this seems the right tradeoff.

As more people use kobjects, I think we'll see some pretty short
lifespans...

But yes, that's all 2.7 dreams :)

thanks,

greg k-h
