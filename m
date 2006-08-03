Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWHCJTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWHCJTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 05:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWHCJTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 05:19:42 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:36109 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S932412AbWHCJTm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 05:19:42 -0400
Date: Thu, 3 Aug 2006 11:19:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: David Brownell <david-b@pacbell.net>
Cc: Komal Shah <komal_shah802003@yahoo.com>, akpm@osdl.org, gregkh@suse.de,
       i2c@lm-sensors.org, imre.deak@nokia.com, juha.yrjola@solidboot.com,
       linux-kernel@vger.kernel.org, r-woodruff2@ti.com, tony@atomide.com
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #2
Message-Id: <20060803111949.91e8e7bc.khali@linux-fr.org>
In-Reply-To: <200608021218.30763.david-b@pacbell.net>
References: <1154066134.13520.267064606@webmail.messagingengine.com>
	<200607311653.48240.david-b@pacbell.net>
	<20060802175044.3d47d85b.khali@linux-fr.org>
	<200608021218.30763.david-b@pacbell.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> > >  - The REVISIT about maybe a better way to probe is also low
> > >    priority; someone with a board that needs better probing
> > >    could address it at that time.  (Then restest any changes
> > >    on multiple generations of silicion ... which IMO is the
> > >    role the linux-omap tree should play.)
> > 
> > No, it's not low priority, it's a blocker. I can't let that code go in.
> > The driver must do what it is told to do. If it can't, it must fail.
> 
> Well for the record that's not been reported as a problem ... that is,
> nobody's reported a board where that matters.  We'd have to see if the
> driver is even usable without that, since the I2C stack overall seemed
> to require probing to work.

The i2c core provides a mechanism to bypass the probing when you know
for sure what device is at a given address. For an embedded system, that
should work.

> (There's a separate issue about how the I2C stack doesn't just have a
> mechanism to just declare "this board has these chips, these addresses",
> so I2C drivers have needless reliance on probing...)

This is being (slowly) addressed by Nathan Lutchansky and Mark M.
Hoffman. The best solution implies converting the i2c subsystem to the
device driver model - a non-trivial task.

> > Yes, this means no (in-kernel) probing on this bus at the moment. Blame
> > it on the hardware manufacturer (if the chip actually can't do it.) In
> > user-space, i2cdetect can be told to use byte reads for probing.
> 
> The spec does say it's tested for zero after decrementing the count,
> so a value of zero gives a 65536 byte transfer.

Did you try setting the OMAP_I2C_CON_STP bit before writing the address
to OMAP_I2C_SA_REG for zero-byte transfactions? And then don't write to
the OMAP_I2C_CNT_REG register at all, as the transaction is already
finished.

BTW, it looks like the driver attempts to handle 10-bit addresses, but
the way it is done, I very much doubt it would work. So it would be
better no to implement it at all (I've never seen a 10-bit address chip
anyway.)

> > >  - The revisit about adap->retries is still up in the air,
> > >    and was a question in my submission from last year.
> > >    How exactly is that supposed to be used?  Right now
> > >    it's neither initialized (except to zero) nor tested.
> > 
> > This is an optional feature, most i2c adapter drivers don't implement
> > it. I'm fine without it, this can always be implemented later if needed.
> 
> Good.  Komal, please update the comment accordingly ... it'd be
> handy if kerneldoc or Documentation/i2c/* said that adap->retries
> is optional, and said what it's supposed to do.

I take patches :) I don't see in which file it would fit under
Documentation/i2c (there's no i2c bus driver writing howto), maybe it
would be more useful to add a comment to include/linux/i2c.h instead.

-- 
Jean Delvare
