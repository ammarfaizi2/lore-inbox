Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267756AbUHJVpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267756AbUHJVpA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHJVmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:42:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:12997 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267740AbUHJVk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:40:27 -0400
Date: Tue, 10 Aug 2004 14:16:42 -0700
From: Greg KH <greg@kroah.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hotplug resource limitation
Message-ID: <20040810211641.GB4124@kroah.com>
References: <41177703.5070202@suse.de> <20040810001016.GC7131@kroah.com> <411882DA.5090400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411882DA.5090400@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 10:10:02AM +0200, Hannes Reinecke wrote:
> Greg KH wrote:
> >On Mon, Aug 09, 2004 at 03:07:15PM +0200, Hannes Reinecke wrote:
> >
> >>Hi all,
> >>this is the second patch to implement hotplug resource limitation 
> >>(relative to 2.6.7-rc2-mm2).
> >>
> >>In some cases it is preferrable to adapt the number of concurrent 
> >>hotplug processes on the fly in addition to set the number statically 
> >>during boot.
> >
> >
> >Why?  This should be "auto-tuning".  We don't want to provide
> >yet-another-knob-for-people-to-tweak-from-userspace, right?
> >
> In principle you're right. But as we don't really now how much resources 
> the installed hotplug program will require I don't really see another way.

But who is going to know how to tweak such a knob?  How will an admin
know they should reduce the number of outstanding processes?

> >>Additionally, it might be required to disable hotplug / 
> >>kmod event delivery altogether for debugging purposes (e.g. if a module 
> >>loaded automatically is crashing the machine).
> >
> >
> >Ugh, that's just not a good thing at all.  You can do that by running:
> >	echo /bin/true > /proc/sys/kernel/hotplug
> >today if you have to.  I don't like the ability to stop the kernel from
> >running properly, like this patch allows you to.
> >
> But then you'll lose all events which happen in the meantime.

Yup.

> The dynamic setting is mainly intended for two scenarios:
> - Booting. You can disable all events on boot with the kernel 
> commandline and re-enable them once your hotplug subsystem is up and 
> running. This way you can handle all (ok, all devices appearing in 
> sysfs) device with hotplug events; there is no need to regenerate / fake 
> all events which might have been missed. Currently you need two sets of 
> scripts, one for configuring all devices until hotplug is running and 
> another one used by hotplug.

Or just put hotplug into your initramfs to catch all of the events from
the beginning of kernel time.

Actually, we currently only have 1 set of scripts that do the hotplug
work.  We have an additional one that makes some "fake" hotplug events
at init time to catch the events that we were not able to catch.  So we
still only have 1 main code path.

> - Debugging. Especially laptops or legacy free machines do have the 
> problem that hotplug scripts might misconfigure the machine, e.g. by 
> loading the wrong module. Of course it's possible to keep this 'disable 
> hotplug events on request' (which should event available during boot) 
> entirely in userspace. But it would increase the size of /sbin/hotplug 
> (and hence the running time) by quite a bit; and this would bite us on 
> every hotplug event generated resulting in a general slowdown of the 
> hotplug subsystem.

I'd be very supprised if you could actually measure the hit of adding 2
more lines of bash to those hotplug scripts.  They aren't exactly the
fastest thing in the world in the first place, nor do they need to be.

> If we can stop the hotplug event delivery from within the kernel, we
> can keep the main hotplug script as small as possible while retaining
> the functionality of temporarily disabling all hotplug events.

So, add kernel complexity in order to reduce userspace complexity?  I
don't think that argument is going to win here :)

> What we could do, though, is to implement two semaphores, one for kmod 
> calls and another one for hotplug calls. Then we can queue or event 
> delay all hotplug events while any kmod call would just be blocked until 
> the semaphore is free again.
> 
> Better approach?

Drop the whole thing?  I really don't see the need for this part of the
patch (part 1 makes sense for some limited memory machines like the s390
boxes.)  But I'm always open to further convincing...

thanks,

greg k-h
