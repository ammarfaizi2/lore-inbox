Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937938AbWLGBry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937938AbWLGBry (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 20:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937941AbWLGBry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 20:47:54 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:27603 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S937938AbWLGBrx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 20:47:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=MNyouABg+DglEUrUFVJwkrYgb3UaX8+V9f+QJEuJ/R/OLNMqvaLM/Q3d23Ci7/WAu4V71JsKrus8dj8ZtueNg/fRQmC8lHngpVIec1TFPA4+f7/kb7hEqWv7QDyWrTBqVhPOx4MsIz/ZPR0scSwEr/9n9dUewdNZtonNHmfesQE=  ;
X-YMail-OSG: 57_PK70VM1lAWi.oivr1rUR6wh8ZdkWBdSuoKfvUI1kfrVG4NCZPoi0qRHDPrfsE6AsHIoE.HW0MhM2GZm4.if1zrutkmP2xuT2a0OU797xyOpP2VWGdxuBQOrgf7LBK.b6yDGGuPH1QQfzs4sqw.O6HZ7SV1AyvEvnq9zkyOkANEFfB8PGEePGq0fO9
From: David Brownell <david-b@pacbell.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: [Bulk] Re: [patch 2.6.19-rc6] fix hotplug for legacy platform drivers
Date: Wed, 6 Dec 2006 16:25:33 -0800
User-Agent: KMail/1.7.1
Cc: "Marco d'Itri" <md@Linux.IT>, Kay Sievers <kay.sievers@vrfy.org>,
       linux-kernel@vger.kernel.org
References: <20061122135948.GA7888@bongo.bofh.it> <200612051603.09649.david-b@pacbell.net> <20061206060802.GB12997@suse.de>
In-Reply-To: <20061206060802.GB12997@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612061625.34324.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > First, for reference, I refer to hotplugging using the trivial ASH scripts
> > from [1], updated by removing no-longer-needed special cases for platform_bus
> > (that original logic didn't work sometimes) and pcmcia. ...
> 
> Ah, so for the platform devices, doing a
> 	modprobe /sys/devices/platform/*
> would load all of the proper modules for the specific platform devices
> that are already present due to the MODULE_ALIAS() stuff?

That's sort of how that original "coldplug" script worked, but it didn't
work except in some trivial cases.  For example, it fails in a common case
when platform_device.id != -1; and for platform devices that are children
of other devices.  And of course there's the syntax issue ... only one
module name at a time (so modprobe in a loop).

The MODULE_ALIAS() stuff only kicks in when the driver name isn't the
same as its module name.  Normally, developers just stick to one name.


> > That should make it clear how accepting that pushback would break hotplug:
> > "modprobe $MODALIAS" would no longer load the right module.  Likewise
> > the more significant case of coldplug; "modprobe $(cat modalias)" would
> > likewise no longer work.
> 
> But, I don't understand why a module would have an alias with the same
> name as itself?  What is that achieving here?  Shouldn't redundancy like
> that be eliminated?

To repeat, I am _not_ the one who has made that proposal.  I'm the one
pointing out that all names for a module (aliases vs. what "ls" shows)
should be treated the same ... introducing a new rule about how hotplug
(or coldplug) must only refer to aliases promotes fragility.


> > The $SUBJECT patch makes those legacy drivers NOT use the $MODALIAS
> > mechanism ... you seem to be overlooking that.
> 
> No, I'm not overlooking that, I think it's a good thing.  I'm just
> wondering if it could be done a different way.  Perhaps in the platform
> device itself instead of the driver core code?

Marco was overlooking it.

I thought about moving that bit elsewhere, but three things came to mind:

 * Space-wise, there are already unused bits there, so this is free;
   but there are no such bits in platform_device.

 * Given that this is a "legacy style" issue, not all such driver
   code is (or will be) on the platform bus.

 * Hey, not all devices and busses support hotplugging, and it'd be
   worth having discussion on that.  The flag is explicitly about
   the _driver_ not supporting hotplug ... a device node creation
   problem.  When the _device_ is physically not hotpluggable, a
   different approach might help rid the kernel of probe()/remove()
   infrastructure.

Given those points, I thought this was probably the best place to
put it; at least as an initial proposal.

Another proposal, which I dislike, is just not to have platform_bus
do hotplug (via $MODALIAS).  That'd be OK for some current embedded
systems, since the devices get created during board startup and are
not added/removed later, but that's exactly the sort of idiosyncratic
restriction I've observed will invariably cause pain later on.  It's
too easy to think of counterexamples, like devices appearing when a
board gets powered up.

- Dave

