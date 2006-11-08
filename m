Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754527AbWKHLOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbWKHLOq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754528AbWKHLOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:14:46 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:54005 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1754527AbWKHLOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:14:45 -0500
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md
	array starts/stops.
From: Kay Sievers <kay.sievers@vrfy.org>
To: Neil Brown <neilb@suse.de>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <17742.32612.870346.954568@cse.unsw.edu.au>
References: <20061031164814.4884.patches@notabene>
	 <1061031060046.5034@suse.de> <20061031211615.GC21597@suse.de>
	 <3ae72650611020413q797cf62co66f76b058a57104b@mail.gmail.com>
	 <17737.58737.398441.111674@cse.unsw.edu.au>
	 <1162475516.7210.32.camel@pim.off.vrfy.org>
	 <17738.59486.140951.821033@cse.unsw.edu.au>
	 <1162542178.14310.26.camel@pim.off.vrfy.org>
	 <17742.32612.870346.954568@cse.unsw.edu.au>
Content-Type: text/plain
Date: Wed, 08 Nov 2006 12:14:42 +0100
Message-Id: <1162984482.16735.25.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 11:18 +1100, Neil Brown wrote:
> On Friday November 3, kay.sievers@vrfy.org wrote:

> > The persistent naming rules for /dev/disk/by-* are causing this. Md
> > devices will probably just get their own rules file, which will handle
> > this and which can be packaged and installed along with the md tools.

> I'm still a bit concerned about the open->add->open infinite loop.
> If anyone opens /dev/mdX while it isn't active (e.g. to check if it is
> active), that will (given a patch that I would like to include) cause
> and ADD event which will cause udev to start it's loop again.
> Can we make udev ignore ADD for md and only watch for CHANGE?

Is there a sysfs file or something similar(we could also call a md-tool)
udev could look at, before it tries to open the device? Like:
  KERNEL=="md*", ATTR{state}=="active", IMPORT{program}= ...

If we currently ignore the "add" event, then we will not hook into the
coldplug logic, where "add" events are requested for all devices to do
the initial setup after bootup.

If we can't read the state of the md device, to see if it's safe to open
the device, we would need to be smarter with the coldplug logic by
requesting "change" events if necessary, or by passing a "coldplug" flag
with the synthesized event.

Thanks,
Kay

