Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbWDSVC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWDSVC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWDSVC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:02:26 -0400
Received: from outmx025.isp.belgacom.be ([195.238.4.49]:13026 "EHLO
	outmx025.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1751244AbWDSVC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:02:26 -0400
Date: Wed, 19 Apr 2006 23:02:04 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Rudolf Marek <r.marek@sh.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
Message-ID: <20060419210204.GA4205@infomag.infomag.iguana.be>
References: <4443EED9.30603@sh.cvut.cz> <20060418195751.GA6968@infomag.infomag.iguana.be> <4445533D.9010000@sh.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4445533D.9010000@sh.cvut.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rudolf,

> Aha good. I will check it later.

You can have a check now. I uploaded some code. Need to retest it, but it
has been working on my v2.6.5 test machine.

> > 	int	(*get_timervalue)(struct watchdog_device *, int *);
> Good one.

We should add this indeed. it's usefull for testing drivers also :-)

> > 	int	(*sys_restart)(struct watchdog_device *);		/* operation = force a
> system_restart for rebooting */
> 
> Aha as for the cobalt stuff?

Yes and no: cobalt needs it in it's notifier reboot part which is not part
of the generic watchdog device. But I think the option should be available
if you go sysfs.

> > 	int	(*get_status)(struct watchdog_device *,int *);		/* operation = get the watchdog's status */
> > 	int	(*get_temperature)(struct watchdog_device *, int *);	/* operation = get the temperature in °F */
> 
> I had those there too but I eliminated them. I used following methods:
> For the status stuff I did a variable boot_status and status. I have
> a handler for this in the common IOCTL handling code.

Don't agree here: boot_status is a copy of the status at boot. the status
itself can change during normal operation. and thus get_status must return
the "devices status" at that moment.

> I have no such thing for the temp IOCTL but the new "ioctl" operation
> could be created to catch it.
> (and get called when no standard ioctl in watchdog-dev is used)

I think we want to review the temperature stuff in the kernel in general.

> As for sysfs, I would like to have the temps handled with the hwmon class
> and have some sort of "symlink" from the watchdog directory to corresponding
> hwmon directory. The status stuff might be handled via standard format sysfs file.

And I like the idea to look at it as a hwmon.

> > 	/* From here on everything is device dependent */
> > 	void	*private;
> 
> In the w83792d I used different approach, because the device is not only a
> watchog, the struct watchdog_device was a part of the common device structure,
> and for single purpose devices this *private makes sense. But I think there
> some per device private data pointer somewhere.

I still have to look at your driver in detail, but my first thought would
be that the private part here would be a link to this common device structure.
(see what I did with the example softdog implementation in the experimental tree).

> Now it seems we have two different approaches and a code, so which one will wim
> ? ;) If you want to talk to me you may find me on #linux-sensors on freenode.net.

It's not about different approaches: we have to find the best thing for watchdog
devicesi, so the best thing is to talk about pro's and con's and see what we should 
do best. (I for instance didn't come to the sysfs part yet of my code (which would
be in watchdog_sysfs.c)

> Also I would like to know your ideas about the sysfs file structure for
> watchdogs and also If you like to have more watchdogs active in the system or
> just one.

My view:
to start we should keep one /dev/watchdog, but we should create/define a suitable
sysfs interface that makes it possible to have multiple watchdog devices running 
in parallel. We will need this functionality in the future when a system will 
consist of different processors that all have their own memory and some basic
I/O interfacing.
Later on we will then see what we will do with /dev/watchdog.

Greetings,
Wim.

