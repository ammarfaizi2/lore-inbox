Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751404AbWJRQUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbWJRQUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 12:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWJRQUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 12:20:45 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:935 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751404AbWJRQUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 12:20:44 -0400
Date: Wed, 18 Oct 2006 10:20:42 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian King <brking@us.ibm.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Adam Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] Block on access to temporarily unavailable pci device
Message-ID: <20061018162042.GT22289@parisc-linux.org>
References: <20061017145146.GJ22289@parisc-linux.org> <45354A59.3010109@us.ibm.com> <20061018145104.GN22289@parisc-linux.org> <1161186652.9363.68.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161186652.9363.68.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 04:50:51PM +0100, Alan Cox wrote:
> Ar Mer, 2006-10-18 am 08:51 -0600, ysgrifennodd Matthew Wilcox:
> > The existing implementation of pci_block_user_cfg_access() was recently
> > criticised for providing out of date information and for returning errors
> > on write, which applications won't be expecting.
> 
> It was also favoured by some of us as well. In addition this whole issue
> was extensively debated in the past to select the current approach. That
> said I do like the approach of a short wait *specifically* on power
> transitions, its bounded in time, its neat and it makes sense. 
> 
> We must be very very sure its never triggered in the real world any
> other way (eg your >block testing must be impossible)

Oh yes, absolutely.  That's why I posted it with a Nacked-by.

> So unless you distinguish between "back in a moment", "back someday" and
> "not coming back" it isn't useful. Thus your patch is incomplete as it
> does not provide the cache that is also needed. At least I don't think X
> hanging forever mid mode switch is terribly useful...

I don't see how that's possible.  If the driver forgets to call
pci_unblock_user_cfg_access(), that's a bug in the kernel driver.
The current user is limited to a two-second delay and the one I'm
proposing introducing is a delay measued in milli- or microseconds.
An extra two-second delay while you BIST your IPR device and change
modes in X at the same time (does X really scan all devices when it's
changing mode settings?  That's odd) doesn't strike me as a huge failure.

> > I also addressed the potential issue with nested attempts to block.
> > Now pci_block_user_cfg_access() can return -EBUSY if it's already blocked,
> > and pci_unblock_user_cfg_access() will WARN if you try to unblock an
> > already unblocked device.
> 
> Gak that is IMHO a mistake. Just keep a counter. You've just added
> another "what the hell do I do if this returns -EBUSY" problem for all
> the driver authors.

You fail the operation if it returns busy.  Or you loop.  It's really up
to you, the driver author.  You know what operation you're trying to do,
you know what makes more sense.

> NAK for all the above reasons. This is a cure looking for a disease, and
> its a cure which is worse than the theoretical disease it wants to fix.

Absolutely not.  It's an attempt to solve a tricky problem.  Devfs, now
there was a cure looking for a disease.

It seemed to me there was consensus that blocking was a better approach
than returning a cached value or returning an error.  If we're
decided that returning a cached value is the better approach, then
the patch to fix it is trivial; move the pci_set_state() call from the
pci_block_user_cfg_access() function to the IPR driver.  Done and dusted.
