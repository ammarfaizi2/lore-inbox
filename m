Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbVL3XKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbVL3XKQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVL3XKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:10:16 -0500
Received: from mx.pathscale.com ([64.160.42.68]:11674 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964929AbVL3XKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:10:15 -0500
Subject: Re: [PATCH 12 of 20] ipath - misc driver support code
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051230082505.GC7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <5e9b0b7876e2d570f25e.1135816291@eng-12.pathscale.com>
	 <20051230082505.GC7438@kroah.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 30 Dec 2005 15:10:09 -0800
Message-Id: <1135984209.13318.47.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 00:25 -0800, Greg KH wrote:

> No description of what the patch does?

Ahem.  Oops.

> > +struct _infinipath_do_not_use_kernel_regs {
> > +	unsigned long long Revision;
> 
> u64?

Right.

> > +	unsigned long long Control;
> > +	unsigned long long PageAlign;
> > +	unsigned long long PortCnt;
> 
> And what's with the InterCapsNamingScheme of these variables?

They're taken straight from the register names in our chip spec.  I can
squish them to lowercase-only, if that seems important.

> > +/*
> > + * would prefer to not inline this, to avoid code bloat, and simplify debugging
> > + * But when compiling against 2.6.10 kernel tree, it gets an error, so
> > + * not for now.
> > + */
> > +static void ipath_i2c_delay(ipath_type, int);
> 
> You aren't compiling this for a 2.6.10 kernel anymore :)

Yes, that hunk is redundant.  Thanks for spotting it.

> > +static void ipath_i2c_delay(ipath_type dev, int dtime)

> Huh?  After reading your comment, I still don't understand why you can't
> just use udelay().  Or are you counting on calling this function with
> only "1" being set for dtime?

It's usually called with a dtime of 1, but there's an added delay in one
place.

I just rewrote that routine, so it's now a one-liner that does a read
which waits for writes to the chip to complete.  The sole caller that
wanted an added wait calls udelay itself now.

> Ah, isn't it fun to write bit-banging functions...  And the in-kernel
> i2c code is messier than doing this by hand?

>From looking at it, it will make the i2c part of the driver longer,
rather than shorter.  There's nothing objectionable about the kernel i2c
interfaces per se, but our bit-banging code is pretty small and
specialised.

> Odd function comment style.  Please fix this to be in kerneldoc format.

Sure.

> Are you _sure_ you need all of these for the one function in this file?

That file will be taken out and put to sleep.

> > +#include <stddef.h>
> 
> Where is this file being pulled in from?

Ugh, braino.

> Woah, um, don't you think that you should either export the main mlock
> function itself, or fix your code to not need it?  Rolling it yourself
> isn't a good idea...

Other people have pointed out that our page-pinning code is horked.
We'll find a saner alternative.

Thanks for the comments, Greg.

	<b

