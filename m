Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261406AbSIZQJg>; Thu, 26 Sep 2002 12:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSIZQJg>; Thu, 26 Sep 2002 12:09:36 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:65484 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S261406AbSIZQJN>; Thu, 26 Sep 2002 12:09:13 -0400
Date: Thu, 26 Sep 2002 09:14:48 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [RFC] consolidate /sbin/hotplug call for pci and
 usb
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Message-id: <3D933278.9010905@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20020925212955.GA32487@kroah.com> <3D9250CD.7090409@pacbell.net>
 <20020926002554.GB518@kroah.com> <3D92749F.9050504@pacbell.net>
 <20020926042715.GB1790@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, Pat and I have talked a lot about the need for a driver "state".  I
> think the current goal was to see how far we can get without needing it.
> I was certainly cursing the lack of it today when trying to debug this
> problem, but in the end, having it would have only masked over the
> real problem that was there.

It'd actually be a "device state", not a "driver state" ...

And I suspect that the specific usbfs issue got fixed by that patch
to make its disconnect() method actually do its job, earlier this
year.  If there's an open issue, I'd likely characterize it as needing
to trust device drivers to disconnect() correctly ... without having
good ways to verify (later on) they really did so.  Unfortunately
that's an area where we know drivers like to make mistakes.



>>Without having a way to answer that question, today's un-helpful
>>"driver is in active use" refcount would encourage rmmodding drivers
>>that users will expect to still be available.  Plug in two devices,
>>look at one, decide to use the other, unplug the first ... and just
>>because you hadn't yet opened the second device, its driver module
>>vanishes.  As you start to use it ... huge frustration quotient! :)
> 
> 
> Well, that's a driver unload issue, which I think everyone agrees on the
> fact that it's not ok to do automatic driver unload when a device is
> removed, because of this very problem.

I think it _could_ be fine to do such rmmods, if all the module
remove races were removed ... and (for this issue) if the primitve
were actually "remove if the driver is not (a) in active use, or
(b) bound to any device".  Today we have races and (a) ... but it's
the lack of (b) that prevents hotplug from even trying to rmmod,
on the optimistic assumption there are no races.

- Dave


