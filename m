Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUHPKNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUHPKNd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 06:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267507AbUHPKNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 06:13:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:35021 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267511AbUHPKMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 06:12:50 -0400
Message-ID: <41208835.2080702@suse.de>
Date: Mon, 16 Aug 2004 12:11:01 +0200
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hotplug resource limitation
References: <41177703.5070202@suse.de> <20040810001016.GC7131@kroah.com> <411882DA.5090400@suse.de> <20040810211641.GB4124@kroah.com>
In-Reply-To: <20040810211641.GB4124@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Aug 10, 2004 at 10:10:02AM +0200, Hannes Reinecke wrote:
> 
>>Greg KH wrote:
>>
>>>On Mon, Aug 09, 2004 at 03:07:15PM +0200, Hannes Reinecke wrote:
>>>
>>>
>>>>Hi all,
>>>>this is the second patch to implement hotplug resource limitation 
>>>>(relative to 2.6.7-rc2-mm2).
>>>>
>>>>In some cases it is preferrable to adapt the number of concurrent 
>>>>hotplug processes on the fly in addition to set the number statically 
>>>>during boot.
>>>
>>>
>>>Why?  This should be "auto-tuning".  We don't want to provide
>>>yet-another-knob-for-people-to-tweak-from-userspace, right?
>>>
>>
>>In principle you're right. But as we don't really now how much resources 
>>the installed hotplug program will require I don't really see another way.
> 
> 
> But who is going to know how to tweak such a knob?  How will an admin
> know they should reduce the number of outstanding processes?
> 
Documentation?

> 
>>>>Additionally, it might be required to disable hotplug / 
>>>>kmod event delivery altogether for debugging purposes (e.g. if a module 
>>>>loaded automatically is crashing the machine).
>>>
>>>
>>>Ugh, that's just not a good thing at all.  You can do that by running:
>>>	echo /bin/true > /proc/sys/kernel/hotplug
>>>today if you have to.  I don't like the ability to stop the kernel from
>>>running properly, like this patch allows you to.
>>>
>>
>>But then you'll lose all events which happen in the meantime.
> 
> 
> Yup.
> 
> 
>>The dynamic setting is mainly intended for two scenarios:
>>- Booting. You can disable all events on boot with the kernel 
>>commandline and re-enable them once your hotplug subsystem is up and 
>>running. This way you can handle all (ok, all devices appearing in 
>>sysfs) device with hotplug events; there is no need to regenerate / fake 
>>all events which might have been missed. Currently you need two sets of 
>>scripts, one for configuring all devices until hotplug is running and 
>>another one used by hotplug.
> 
> 
> Or just put hotplug into your initramfs to catch all of the events from
> the beginning of kernel time.
> 
Unfortunately this does not quite work as of today.
Open issues:
- udp sockets are not available during early stages, making it 
impossible to use udevsend/udevd
- No initial hook is given, which would allow for a setup of the 
initramfs (e.g. mounting of /dev on ramfs). Relying to catch event with 
SEQNUM 0 is dodgy (as it might well be that we never get this one); 
checking on every event ditto (as one might want to use 'udev' as 
hotplug program).
- Synchronisation of configuration files is hard to solve; either you 
have to update the initramfs every time after a device has been 
reconfigured or you do some sort of auto-detection, in which case you 
have to pack in every module etc. into the initramfs.

> Actually, we currently only have 1 set of scripts that do the hotplug
> work.  We have an additional one that makes some "fake" hotplug events
> at init time to catch the events that we were not able to catch.  So we
> still only have 1 main code path.
> 
But IMHO the main advantage of having initramfs is that we can get rid 
of this 'coldplug' / fake hotplug event stuff as we're able to catch all 
events. Otherwise I don't really see the point in initramfs.

> 
>>- Debugging. Especially laptops or legacy free machines do have the 
>>problem that hotplug scripts might misconfigure the machine, e.g. by 
>>loading the wrong module. Of course it's possible to keep this 'disable 
>>hotplug events on request' (which should event available during boot) 
>>entirely in userspace. But it would increase the size of /sbin/hotplug 
>>(and hence the running time) by quite a bit; and this would bite us on 
>>every hotplug event generated resulting in a general slowdown of the 
>>hotplug subsystem.
> 
> 
> I'd be very supprised if you could actually measure the hit of adding 2
> more lines of bash to those hotplug scripts.  They aren't exactly the
> fastest thing in the world in the first place, nor do they need to be.
> 
But we want to keep the initial 'hotplug' script as small/fast as 
possible, as this script is called by _every_ event.
Any subsequent script (e.g. agents) do not really matter, as they are 
called much more infrequently (here on my local desktop machine I have a 
ration of 10:1).

> 
>>If we can stop the hotplug event delivery from within the kernel, we
>>can keep the main hotplug script as small as possible while retaining
>>the functionality of temporarily disabling all hotplug events.
> 
> 
> So, add kernel complexity in order to reduce userspace complexity?  I
> don't think that argument is going to win here :)
> 
Unfair argument :-).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
