Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWKCIXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWKCIXJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 03:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWKCIXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 03:23:09 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:45773 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751049AbWKCIXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 03:23:05 -0500
Subject: Re: [PATCH 001 of 6] md: Send online/offline uevents when an md
	array starts/stops.
From: Kay Sievers <kay.sievers@vrfy.org>
To: Neil Brown <neilb@suse.de>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <17738.59486.140951.821033@cse.unsw.edu.au>
References: <20061031164814.4884.patches@notabene>
	 <1061031060046.5034@suse.de> <20061031211615.GC21597@suse.de>
	 <3ae72650611020413q797cf62co66f76b058a57104b@mail.gmail.com>
	 <17737.58737.398441.111674@cse.unsw.edu.au>
	 <1162475516.7210.32.camel@pim.off.vrfy.org>
	 <17738.59486.140951.821033@cse.unsw.edu.au>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:22:58 +0100
Message-Id: <1162542178.14310.26.camel@pim.off.vrfy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:4ddcc9dd12ba6cf3155e4d81b383efda
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 17:57 +1100, Neil Brown wrote:
> On Thursday November 2, kay.sievers@vrfy.org wrote:
> > On Thu, 2006-11-02 at 23:32 +1100, Neil Brown wrote:

> > We couldn't think of any use of an "offline" event. So we removed the
> > event when the device-mapper device is suspended.
> > 
> > > Should ONLINE and OFFLINE remain and CHANGE be added, or should they
> > > go away?
> > 
> > The current idea is to send only a "change" event if something happens
> > that makes it necessary for udev to reinvestigate the device, like
> > possible filesystem content that creates /dev/disk/by-* links.
> > 
> > Finer grained device-monitoring is likely better placed by using the
> > poll() infrastructure for a sysfs file, instead of sending pretty
> > expensive uevents. 
> > 
> > Udev only hooks into "change" and revalidates all current symlinks for
> > the device. Udev can run programs on "online", but currently, it will
> > not update any /dev/disk/by-* link, if the device changes its content.
> > 
> 
> OK.  Makes sense.
> I tried it an got an interesting result....
> 
> This is with md generating 'CHANGE' events when an array goes on-line
> and when it goes off line, and also with another patch which causes md
> devices to disappear when not active so that we get ADD and REMOVE
> events at reasonably appropriate times.
> 
> It all works fine until I stop an array.
> We get a CHANGE event and then a REMOVE event.
> And then a seemingly infinite series of ADD/REMOVE pairs.
> 
> I guess that udev sees the CHANGE and so opens the device to see what
> is there.  By that time the device has disappeared so the open causes
> an ADD.  udev doesn't find anything and closes the device which causes
> it to disappear and we get a REMOVE.
> Now udev sees that ADD and so opens the device again to see what it
> there, triggering an ADD.  Nothing is there so we close it and get a
> REMOVE.
> Now udev sees the second ADD and ....

Hmm, why does the open() of device node of a stopped device cause an "add"?
Shouldn't it just return a failure, instead of creating a device?

> A bit unfortunate really.  This didn't happen when I had
> ONLINE/OFFLINE as udev ignored the OFFLINE.
> I guess I can removed the CHANGE at shutdown, but as there really is a
> change there, that doesn't seem right.

Yeah, it's the same problem we had with device-mapper, nobody could
think of any useful action at a dm-device suspend "change"-event, so we
didn't add it. :)   

> The real problem is that udev opens the device, and md interprets and
> 'open' as a request to create the device. And udev see the open and an
> ADD and so opens the device....

Yes, current udev rules are written to to so, md needs to be excluded
from the list of block devices which are handled by the default
persistent naming rules, and moved to its own rules file. We did the
same for device-mapper to ignore some "private" dm-* volumes like
snapshot devices. 

> It's not clear to me what the 'right' thing to do here is:
>  - I could stop removing the device on last-close, but I still
>    think that (the current situation) is ugly.
>  - I could delay the remove until udev will have stopped poking,
>    but that is even more ugly
>  - udev could avoid opening md devices until it has poked in 
>    /sys/block/mdX to see what the status is, but that is very specific
>    to md
> 
> It would be nice if I could delay the add until later, but that would
> require major surgery and probably break the model badly.
> 
> On the whole, it seems that udev was designed without thought to the
> special needs of md, and md was designed (long ago) without thought
> the ugliness that "open creates a device" causes.

The persistent naming rules for /dev/disk/by-* are causing this. Md
devices will probably just get their own rules file, which will handle
this and which can be packaged and installed along with the md tools.

If it's acceptable for you, so leave the shutdown "change" event out for
now, until someone has the need for it.
We will update the rules in the meantime, and read a sysfs file or call
a md-tool to query the current state of the device on "add" and "change"
events, this will prevent the opening of the device when it's not
supposed to do so.

Thanks,
Kay

