Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUGSITZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUGSITZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 04:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGSITZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 04:19:25 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:22426 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264808AbUGSITT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 04:19:19 -0400
Date: Mon, 19 Jul 2004 10:02:37 +0200
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, akpm@osdl.org, rml@ximian.com, greg@kroah.com
Subject: Re: [RFC][PATCH] driver model and sysfs support for PCMCIA (1/3)
Message-ID: <20040719080237.GB9494@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk, akpm@osdl.org, rml@ximian.com, greg@kroah.com
References: <20040628200224.GE5175@neo.rr.com> <20040629190948.GA8659@dominikbrodowski.de> <20040705224704.GA4090@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705224704.GA4090@neo.rr.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On Mon, Jul 05, 2004 at 10:47:04PM +0000, Adam Belay wrote:
> > - I like many ideas in your patches -- large parts of them, though, are
> >   "double work" as similar things have already been submitted (by me)
> >   to Russell on the linux-pcmcia mailing list. What's missing in my current
> >   patches [proof-of-concepts do exist and had been announced both on lkml
> >   and on said linux-pcmcia list, though] is the exporting of product and
> >   manufactor ID and "vers_1" strings, because that needs better resource
> >   handling.
> > - the resource_ready handling is "racy", at least. Resources can disappear
> >   again.
> 
> Could you provide an example of how resources will disappear again?

/etc/pcmcia/config.opts may include

include memory 0xc0000-0xfffff
exclude memory 0xc0000-0xfffff

even though it wouldn't make sense.

>  My patch
> was designed so that even if they weren't available, nothing bad would happen.
> Furthermore, it rescans for devices when userspace attempts to bind a driver.
> Resources would almost certainly be available during that time,

Indeed, they _are_ available during that time, else userspace wouldn't know
what driver to bind. That's why my approach registers the pcmcia "sysfs"
device struct at that place.

> In other
> words, it seems that resource handling is a problem for all of pcmcia.

It is, but partly because used ioports and iomem are not 100% accounted in
/proc/ioports and /proc/iomem. I'm eagerly awaiting the creation of a PNP-
and/or ACPI-based resource core "backend", like you proposed at Kernel
Summit last year, IIRC, which possibly allows the PCMCIA core on x86{,_64} 
to "trust" the resources not in the resource database to be available for
PCMCIA's use.

> It was to add minimal support for a much needed feature while introducing
> as few potential bugs as possible to a stable kernel series.  I see 2.7 as 
> the time for rewrites.  With that in mind, I consider your patches to be a
> great solution, but I'm worried about changing internal ds functionality
> during 2.6.

However, adding pcmcia devices at the place you suggest causes resource
headaches and makes merging my patches in 2.7. much more difficult. So,
could we work to a compromise patch where PCMCIA sysfs device structs are
only registered at "bind" time [as long as Russell agrees, that is...]?

Also, what do we need the "hotplug" export for? I'd like to avoid backwards
compatibility trouble in future, and as users _need_ to run cardmgr hotplug
seems to be without usage now.

	Dominik
