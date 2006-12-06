Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757969AbWLFADN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757969AbWLFADN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 19:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757769AbWLFADN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 19:03:13 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:42788 "HELO
	smtp112.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757385AbWLFADM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 19:03:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Wwh2U1Cb7BET/P0pLWrsrwPjJr0fpGOWPEpV8RueBKBtMXDoVNX2iB0L1ffX35E09dqlf9lBCSew8Z8Aif8Uc6yiO8DuHLeJDZHoA+gtAxnAWvRmtEa/vv7ksQalnl/vlw6X4BXruGsLdeS6GOvgivc27fo5QOKvFVipRSsjIEc=  ;
X-YMail-OSG: 2xZDgOcVM1n6vPyNPC1h0lUTIIZLhRov0vk5NcQtdX.Hrrq2kKRYLdn6Juo6gO9OFT1MFT808u8oHC5GsaBAjCzpGkc7HK25wPx_tyPHNqGaaMl2FPW.q3m3CCBXJdFZNTbKGfATwLRCdGg-
From: David Brownell <david-b@pacbell.net>
To: "Marco d'Itri" <md@Linux.IT>
Subject: Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Date: Tue, 5 Dec 2006 16:03:08 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <gregkh@suse.de>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
References: <20061122135948.GA7888@bongo.bofh.it> <200612041828.01381.david-b@pacbell.net> <20061205100152.GB5805@bongo.bofh.it>
In-Reply-To: <20061205100152.GB5805@bongo.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612051603.09649.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 December 2006 2:01 am, Marco d'Itri wrote:
> On Dec 05, David Brownell <david-b@pacbell.net> wrote:
> 
> > The pushback on $SUBJECT patch.  Which amounts to wanting to break hotplug
> > for several busses, unless someone (NOT the folk promoting the breakage!)
>
> Please explain in more details how hotplugging would be broken, possibly
> with examples.

First, for reference, I refer to hotplugging using the trivial ASH scripts
from [1], updated by removing no-longer-needed special cases for platform_bus
(that original logic didn't work sometimes) and pcmcia.  See the (short)
contemporary thread [2] discussing platform_bus support, and some of issues
related to why its hotplug support works the way it does now.  (Looks like
some messages are not archived, but the key points are there.)

Those scripts have supported hotplug and coldplug on several embedded boards
for some time now.  The ancient "runs on 2.4" scripts would have been way
too slow to justify using hotplug and udev to replace devfs, and also needed
all sorts of extra crap that's regularly not found with embedded Linuxes.
Plus of course they never understood platform_bus, which is the main way
those PCI-less systems are hooked together.


Second, note that you're asking me to construct a straw man for you and
then break it down, since nobody arguing with the $SUBJECT patch has ever
provided a complete counter-proposal (much less respond to the points
I've made about legacy driver bugginess -- which is suggestive).

That said, the common thread in that pushback is that $MODALIAS (and also
modalias files) "should" have some value other than platform_device.name ...
which name is conventionaly also the name of the driver's module.  That goes
along with a (weak) rationale that requires spi_bus and KMOD to change, plus
(presumably, pending a code audit) other kernel subsystems.


That should make it clear how accepting that pushback would break hotplug:
"modprobe $MODALIAS" would no longer load the right module.  Likewise
the more significant case of coldplug; "modprobe $(cat modalias)" would
likewise no longer work.


> > There are really two issues here:
> > 
> >  - The "real one", as (yes!) fixed by the $SUBJECT patch.  Troublesome legacy
> >    drivers, like "i82365", written so they can't hotplug ... but the kernel
> >    hasn't previously known that.
> > 
> >  - The confusion, caused by a false identification of the "i82365" issue
> >    being a problem related to module aliasing ... instead of being rooted in
> >    the fact that it's a "legacy style" non-hotpluggable driver, since it
> >    creates its own device node.
> 
> Nonsense. The purpose of $MODALIAS is to allow automatically loading
> modules using the information provided by the bus driver.

Without using sysfs.  And that's exactly what it does _today_ for the
platform_bus.

Modulo the real issue, which is that legacy/ISA style drivers like i82365 will
never support hotplugging ("automatically loading modules ..." plus consequent
device configuration), without first being split into separate bus support
(making the device nodes) and driver module (the thing $MODALIAS supports).
Hotplug depends on that split in a fundamental manner.

So ... on what point were you disagreeing with me??


> Because of this reason there is no point for a driver to provide a
> $MODALIAS referring to itself. It will only waste resources causing udev
> to try loading it again.

The $SUBJECT patch makes those legacy drivers NOT use the $MODALIAS
mechanism ... you seem to be overlooking that.

And "udev" was from day one supposed to solve  a different problem
than "loading modules".  There was to be a clear and strong separation
of roles between hotplug (load modules, don't rely on sysfs, use other
components for the rest of device setup) and udev (make /dev nodes,
ok to rely on sysfs).  That is, "udev" wouldn't do any loading.

- Dave

[1] http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=111903647518255&w=2
[2] http://marc.theaimsgroup.com/?t=111895889800001&r=1&w=2

