Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbVJ2JLX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbVJ2JLX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 05:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVJ2JLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 05:11:23 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:11446
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750856AbVJ2JLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 05:11:22 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Mark Jenkins <umjenki5@cc.umanitoba.ca>
Subject: Re: Is sharpzdc_cs.o not a derivitive work of Linux?
Date: Sat, 29 Oct 2005 04:10:46 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <43625208.60703@cc.umanitoba.ca>
In-Reply-To: <43625208.60703@cc.umanitoba.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510290410.48454.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 October 2005 11:30, Mark Jenkins wrote:
> I have read, http://people.redhat.com/arjanv/COPYING.modules
> Summary: A Linux module is a derivative work unless a strong case is
> made otherwise.
>
> I would like to know if this is one of those exception cases. That is
> why I used the word 'not' in the subject line.
>
> Is sharpzdc_cs.o *not* a derivative work of Linux?

I suspect that right now the Linux developers are trying an end-run around the 
whole mess.  At a wild guess, binary-only modules will probably be obsolete 
in a few years.  I could easily be wrong, but here's why I think this:

2.6 introduced sysfs and udev.  When /dev is maintained by udev, then udev 
gets the list of devices and each device's major/minor numbers from the dev 
entry for the device in sysfs.  At boot time, udev starts with an empty /dev 
directory (generally tmpfs) and populates it from /sys, and hotplug events 
tell udev to take another look at sysfs.  I.E. if devices don't show up 
in /sys, then udev doesn't create device nodes for them in /dev.

Of course you can work around this by running a supplemental script at boot 
time to manually create extra devices (using the static major/minor numbers 
from the lanana.org list), or by simply not using udev at all (and thus not 
having modern features like good hotplug and persistent naming of things that 
move around on USB hubs and such).  The ability to use something other than 
udev depends on the existence of static major and minor numbers.

But static major and minor numbers are not required for udev.  Any system that 
has udev recreates the contents of /dev from scratch on each reboot, and does 
so based on major/minor pairs handed to it by sysfs.  Those numbers can be 
dynamically allocated by the kernel as each new device is hotplugged in, 
there's no need for them to be preassigned.

At some point in the future, a config option will probably show up to make all 
device numbers dynamically assigned.  (This used to be a plan for 2.7, back 
when we were going to have a 2.7.)  For purely technical reasons, it's a 
great simplifiation, making a lot of hardcoded magic numbers in the kernel 
simply go away, eliminating the need to manage the hugely complex lanana.org 
device number list, increasing scalability because now there's no real limit 
on how many devices of a given type you can plug in since you won't run out 
of major/minor pairs from the preallocated range to represent the new type.  
It's been discussed before, and is a to-do item.

Of course under a dynamic major/minor scheme, udev would no longer be optional 
but a requirement, and any device that wants a dev node _must_ show up in 
sysfs or there's no major/minor pair to assign to it.  And the really 
interesting bit is that all the kernel-side sysfs bindings are 
EXPORT_GPL_ONLY.  A non-gpl module _cannot_ show up in sysfs.  Thus under a 
dynamic major/minor scheme, binary only modules couldn't have device nodes.

Interesting, isn't it?  The normal churn in the kernel naturally renders old 
interfaces obsolete, but the new interfaces are GPL_ONLY.  Even if this isn't 
the specific way they get rendered obsolete, the window for binary only 
modules is slowly closing...

Rob
