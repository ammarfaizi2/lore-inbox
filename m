Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbULEXsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbULEXsi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbULEXsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:48:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:29910 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261420AbULEXs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:48:29 -0500
Subject: Re: [linux-pm] swsusp-bigdiff: power-managment changes that are
	waiting in my tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, mjg59@srcf.ucam.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20041205233110.GB1490@elf.ucw.cz>
References: <20041205214910.GA1293@elf.ucw.cz>
	 <1102284611.11763.97.camel@gaston>  <20041205233110.GB1490@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 06 Dec 2004 10:47:56 +1100
Message-Id: <1102290476.11761.116.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh I just wanted to have ON for future expansion, like that "warning
> userland is going away" or something like that. Maybe it can be eve
> killed.

Ok, I'm a bit confused by the "ON" terminology. I wouldn't mind having 2
separate messages: NOTIFY_WILL_SUSPEND and NOTIFY_RESUMED here, but we
can keep that on hold for now. We'll need a system-wide notifier at one
point too I suppose. I also need to think how to hoook the APM emulation
in there (which is the missing piece even on x86/ACPI S3 for X to work
properly in lots of cases on resume).

> > Note that we should probably fix kmalloc itself to turn GFP_KERNEL into
> > GFP_NOIO during the suspend process. For call_usermodehelper, I wnated
> > to "queue" them, but greg suggested that instead, we fail them, and at
> > the end of the suspend process, we send a special /sbin/hotplug event
> > telling userland to rescan sysfs.
> 
> Actually I do not think that automatically doing GFP_NOIO instead of
> GFP_KERNEL is right thing. Is it that hard to teach drivers to get it
> right?

But what about non-drivers ? Teaching drivers is hard because that would
require every single of them to actually have notifiers to "know" that
we are about to start the suspend dance or that we have completed it,
which mean keeping track additional state, etc... So that is a
significant burden on drivers to add. Besides, as I wrote earlier, it
may concern things implicitely called by drivers, or other kernel
subsystems (like things in keventd, we don't wnat keventd to block or
work_queues would stop, and drivers could die on flush_work_queues,
which is common to be called on suspend) etc...
 
> No idea, it is certainly usefull for me :-). Hopefully noone is stupid
> enough to do case according to this, and flags are not even defined
> just yet, so spending extra time writing docs does not seem that great
> right now...
> 
> Anyway, feel free to send improved version...

Yes, I'm thinking about rewriting it in the plane to France next
week-end :)

> > > +Powerdown at end of swsusp -- very similar to SYSTEM_SHUTDOWN, except wake
> > > +may need to be enabled on some devices. This actually has at least 3
> > > +subtypes, system can reboot, enter S4 and enter S5 at the end of
> > > +swsusp. event = FREEZE, flags = SWSUSP and one of SYSTEM_REBOOT,
> > > +SYSTEM_SHUTDOWN, SYSTEM_S4
> > 
> > Hrm... shuoldn't we rather use different calls for the above ? For S3/S4
> > do a SUSPEND call rather than freeze ?
> 
> S3 needs SUSPEND (and I specify it like that). At suspend-to-disk, you
> don't care about hardware state before poweroff (on PC anyway) so
> FREEZE seems like right thing to do.

Oh, I meant S4/S5... shouldn't it be SUSPEND rather than FREEZE ? I
mean, don't some BIOSes who do S4/S5 expect us to actually suspend the
HW (while other machines that don't have BIOS support will do a normal
SHUTDOWN and thus wouldn't care). I don't know for sure here, this is an
x86 thing ...

> Attached is my version of file with one paragraph added.
> 								Pavel
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

