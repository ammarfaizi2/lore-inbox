Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVEPQU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVEPQU7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 12:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVEPQU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 12:20:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:42141 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261732AbVEPQUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 12:20:16 -0400
Date: Mon, 16 May 2005 09:20:11 -0700
From: Greg KH <greg@kroah.com>
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
Cc: akpm@zip.com.au, ecashin@coraid.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.11.7] ATA Over Ethernet Root, Mark 2
Message-ID: <20050516162011.GA8716@kroah.com>
References: <1116011879.9050.92.camel@jmcmullan.timesys> <20050514072826.GB20021@kroah.com> <1116249602.9050.105.camel@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116249602.9050.105.camel@jmcmullan.timesys>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 09:14:02AM -0400, McMullan, Jason wrote:
> [First off: Andrew, I'm sorry I didn't make it more clear that the AOE
>  root patch was just for review, not for submission. Please remove it
>  from -mm]
> 
> 
> On Sat, 2005-05-14 at 00:28 -0700, Greg KH wrote:
> > I'm guessing you are only testing this out on devfs?
> 
>   Yes. udev takes 5 minutes to complete on my 8mb, 100Mhz board.

Ouch, that's not good at all.  Care to take this info to the
linux-hotplug-devel mailing list and we can work on fixing this for you?
(first a few things to try, use 'udevsend' and build udev using klibc.
Also do not have any rules that call out to shell scripts, as you are
using devfs I don't see that you need any special rules at all
probably.)

> > Why not fix this up properly, and allow root devices on _any_ type of
> > block device that is not immediately present at "try to mount time"?  The
> > USB and firewire users of the world will love you...
> 
>   Sure. No problem. Where is this patch you speak of?

It can be based on your patch :)

Anyway, it's floating around in the lkml archives, sorry, don't have a
direct link.

> > Also, please CC the aoe maintainer, that's documented in
> > Documentation/SubmittingPatches :)
> 
>   I did to support@coraid.com, in a separate message.

That's not the email address listed in MAINTAINERS, is it?

> > > +config ATA_OVER_ETH_ROOT_SHELF
> > > +	int "Shelf ID"
> > > +	depends on ATA_OVER_ETH_ROOT
> > 
> > Ick.  Why not use a boot parameter if you really want to use something
> > so icky (hint, we should rely on the name or major/minor, not something
> > else like this.)
> 
>   Because kernel major/minor change dynamically based upon the number of
> AOE blades on your LAN. As setting them in __setup() - sure, no problem,
> this patch was just a 15 minute hack job.
> 
> 
> > You do know devfs is going away in 2 months, right?
> 
>   Yes, much to my disappointment. udevd is so frick'n bloaty.

with klibc?  Again, take it to linux-hotplug-devel, if we don't get
reports about problems, we assume that everyone is happy with it.  I
haven't seen you asking about this there.

> > Should be in a separate patch, to fix up devfs issues in the driver,
> > right?  This goes for the other devfs calls in this patch.  That is if
> > you don't mind me removing them in 2 months :)
> 
>   Yeah, I know, I was just being lazy and using the uber-fast devfs.

It's just a mirrage, it's not really that fast :)

> > If so, I suggest one of the two solutions:
> > 	- do like the rest of the world does for usb and firewire and
> > 	  other types of slow boot devices and use an initrd/initramfs
> > 	  that mounts the root partition after it is properly found.
> > 	  Distros do this all the time, so there are lots of examples to
> > 	  pull from if you want to do this for yours.
> 
>    I only have 8Mb of RAM. No room for initrd.

Even with ash built with klibc and/or busybox?

> > 	- fix up the patch that is floating around that allows the
> > 	  kernel to pause and wait and not oops out if the root
> > 	  partition is not found.  That way all users of all kinds of
> > 	  slow devices can benefit, and driver specific hacks like this
> > 	  are not needed.
> 
>    Again, this happy patch you speak of... Where can I find this wonder?

lkml archives.  Or base it on your work you have already started to do
:)

thanks,

greg k-h
