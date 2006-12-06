Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760199AbWLFGIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760199AbWLFGIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 01:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760230AbWLFGIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 01:08:30 -0500
Received: from ns2.suse.de ([195.135.220.15]:57787 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760199AbWLFGI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 01:08:29 -0500
Date: Tue, 5 Dec 2006 22:08:02 -0800
From: Greg KH <gregkh@suse.de>
To: David Brownell <david-b@pacbell.net>
Cc: "Marco d'Itri" <md@Linux.IT>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Message-ID: <20061206060802.GB12997@suse.de>
References: <20061122135948.GA7888@bongo.bofh.it> <200612041828.01381.david-b@pacbell.net> <20061205100152.GB5805@bongo.bofh.it> <200612051603.09649.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612051603.09649.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 04:03:08PM -0800, David Brownell wrote:
> On Tuesday 05 December 2006 2:01 am, Marco d'Itri wrote:
> > On Dec 05, David Brownell <david-b@pacbell.net> wrote:
> > 
> > > The pushback on $SUBJECT patch.  Which amounts to wanting to break hotplug
> > > for several busses, unless someone (NOT the folk promoting the breakage!)
> >
> > Please explain in more details how hotplugging would be broken, possibly
> > with examples.
> 
> First, for reference, I refer to hotplugging using the trivial ASH scripts
> from [1], updated by removing no-longer-needed special cases for platform_bus
> (that original logic didn't work sometimes) and pcmcia.  See the (short)
> contemporary thread [2] discussing platform_bus support, and some of issues
> related to why its hotplug support works the way it does now.  (Looks like
> some messages are not archived, but the key points are there.)
> 
> Those scripts have supported hotplug and coldplug on several embedded boards
> for some time now.  The ancient "runs on 2.4" scripts would have been way
> too slow to justify using hotplug and udev to replace devfs, and also needed
> all sorts of extra crap that's regularly not found with embedded Linuxes.
> Plus of course they never understood platform_bus, which is the main way
> those PCI-less systems are hooked together.

Ah, so for the platform devices, doing a
	modprobe /sys/devices/platform/*
would load all of the proper modules for the specific platform devices
that are already present due to the MODULE_ALIAS() stuff?

Interesting, I didn't know that.

> Second, note that you're asking me to construct a straw man for you and
> then break it down, since nobody arguing with the $SUBJECT patch has ever
> provided a complete counter-proposal (much less respond to the points
> I've made about legacy driver bugginess -- which is suggestive).

Well, no, I just thought the patch in $SUBJECT was very ugly, and hence,
didn't like it :)

> That said, the common thread in that pushback is that $MODALIAS (and also
> modalias files) "should" have some value other than platform_device.name ...
> which name is conventionaly also the name of the driver's module.  That goes
> along with a (weak) rationale that requires spi_bus and KMOD to change, plus
> (presumably, pending a code audit) other kernel subsystems.
> 
> 
> That should make it clear how accepting that pushback would break hotplug:
> "modprobe $MODALIAS" would no longer load the right module.  Likewise
> the more significant case of coldplug; "modprobe $(cat modalias)" would
> likewise no longer work.

But, I don't understand why a module would have an alias with the same
name as itself?  What is that achieving here?  Shouldn't redundancy like
that be eliminated?

> The $SUBJECT patch makes those legacy drivers NOT use the $MODALIAS
> mechanism ... you seem to be overlooking that.

No, I'm not overlooking that, I think it's a good thing.  I'm just
wondering if it could be done a different way.  Perhaps in the platform
device itself instead of the driver core code?

> And "udev" was from day one supposed to solve  a different problem
> than "loading modules".  There was to be a clear and strong separation
> of roles between hotplug (load modules, don't rely on sysfs, use other
> components for the rest of device setup) and udev (make /dev nodes,
> ok to rely on sysfs).  That is, "udev" wouldn't do any loading.

Well, things evolve and change over time.  In the beginning, Linux was
only supposed to run on one CPU type and merely display ABABABAB on a
console properly :)

thanks,

greg k-h
