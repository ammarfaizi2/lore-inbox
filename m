Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbULEWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbULEWLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbULEWLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 17:11:12 -0500
Received: from gate.crashing.org ([63.228.1.57]:38613 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261408AbULEWKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 17:10:47 -0500
Subject: Re: [linux-pm] swsusp-bigdiff: power-managment changes that are
	waiting in my tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, mjg59@srcf.ucam.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20041205214910.GA1293@elf.ucw.cz>
References: <20041205214910.GA1293@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 09:10:11 +1100
Message-Id: <1102284611.11763.97.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +ON -- no need to do anything except special cases like broken
> +HW.

I'm not sure what is this one supposed to be ... The description is
definitely not clear, can you precise in what context it is sent and
give maybe an example of "broken hw" ?

Ok, now I'm reading the rest of the mail and I see but your description
is really confusing. Also, we really need the resume argument to be
added for the opposite (after resume) call to be sent. It makes little
sense to pipe it through the suspned() callback.

> +FREEZE -- stop DMA and interrupts, and be prepared to reinit HW from
> +scratch. That probably means stop accepting upstream requests, the
> +actual policy of what to do with them beeing specific to a given
> +driver. It's acceptable for a network driver to just drop packets
> +while a block driver is expected to block the queue so no request is
> +lost. (Use IDE as an example on how to do that). FREEZE requires no
> +power state change, and it's expected for drivers to be able to
> +quickly transition back to operating state.

Some examples of the kind of transitions to be expected by drivers or
contexts in which the above will be called would be useful as part of
the documentation

> +SUSPEND -- like FREEZE, but also put hardware into low-power state. If
> +there's need to distinguish several levels of sleep, additional flag
> +is probably best way to do that.

Here add a blurb about transitions. They are only from a resumed state
to a suspended state, never between 2 suspended states.

> +All events are: 
> +
> +#Prepare for suspend -- userland is still running but we are going to
> +#enter suspend state. This gives drivers chance to load firmware from
> +#disk and store it in memory, or do other activities taht require
> +#operating userland, ability to kmalloc GFP_KERNEL, etc... All of these
> +#are forbiden once the suspend dance is started.. event = ON, flags =
> +#PREPARE_TO_SUSPEND

Note that we should probably fix kmalloc itself to turn GFP_KERNEL into
GFP_NOIO during the suspend process. For call_usermodehelper, I wnated
to "queue" them, but greg suggested that instead, we fail them, and at
the end of the suspend process, we send a special /sbin/hotplug event
telling userland to rescan sysfs.

Now about your (long) list bewlow, it's really confusing as a
documentation. People will think they have somewhat to switch/case on
all these possible 'events' which is implied by the fact that you
indicate different actions for each of them. I would redo that
documentation completely differently.

First , describe the kind of transitions we have identified, then
present the 3 major states and quickly explain how they would cover all
needs, then give the table showing how we map all those events to those
3 major states, and a  small blurb about the flags allowing the few
drivers that care to know more precisely what the initial event was.

> +Apm standby -- prepare for APM event. Quiesce devices to make life
> +easier for APM BIOS. event = FREEZE, flags = APM_STANDBY
> +
> +Apm suspend -- same as APM_STANDBY, but it we should probably avoid
> +spinning down disks. event = FREEZE, flags = APM_SUSPEND
> +
> +System halt, reboot -- quiesce devices to make life easier for BIOS. event
> += FREEZE, flags = SYSTEM_HALT or SYSTEM_REBOOT
> +
> +System shutdown -- at least disks need to be spun down, or data may be
> +lost. Quiesce devices, just to make life easier for BIOS. event =
> +FREEZE, flags = SYSTEM_SHUTDOWN
> +
> +Kexec    -- turn off DMAs and put hardware into some state where new
> +kernel can take over. event = FREEZE, flags = KEXEC
> +
> +Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
> +may need to be enabled on some devices. This actually has at least 3
> +subtypes, system can reboot, enter S4 and enter S5 at the end of
> +swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
> +SYSTEM_SHUTDOWN, SYSTEM_S4

Hrm... shuoldn't we rather use different calls for the above ? For S3/S4
do a SUSPEND call rather than freeze ?

> +Suspend to ram  -- put devices into low power state. event = SUSPEND,
> +flags = SUSPEND_TO_RAM
> +
> +Freeze for swsusp snapshot -- stop DMA and interrupts. No need to put
> +devices into low power mode, but you must be able to reinitialize
> +device from scratch in resume method. This has two flavors, its done
> +once on suspending kernel, once on resuming kernel. event = FREEZE,
> +flags = DURING_SUSPEND or DURING_RESUME
> +
> +Device detach requested from /sys -- deinitialize device; proably same as
> +SYSTEM_SHUTDOWN, I do not understand this one too much. probably event
> += FREEZE, flags = DEV_DETACH.
> +
> +#These are not really events sent:
> +#
> +#System fully on -- device is working normally; this is probably never
> +#passed to suspend() method... event = ON, flags = 0
> +#
> +#Ready after resume -- userland is now running, again. Time to free any
> +#memory you ate during prepare to suspend... event = ON, flags =
> +#READY_AFTER_RESUME

I think we need to add the pm_message_t to resume. You are already
"fixing" everybody to change u32 -> pm_message_t, so it  shouldn't be
that bad to add this too.

Ben.


