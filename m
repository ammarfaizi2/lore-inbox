Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266659AbUGKUjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266659AbUGKUjv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 16:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266660AbUGKUjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 16:39:51 -0400
Received: from smtp814.mail.ukl.yahoo.com ([217.12.12.204]:51312 "HELO
	smtp814.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S266659AbUGKUjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 16:39:46 -0400
Date: Sun, 11 Jul 2004 21:50:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>, linux-kernel@vger.kernel.org
Subject: [SE/Linux] warning about debian hotplug package 20040329-9!
Message-ID: <20040711205047.GQ4677@lkcl.net>
Mail-Followup-To: SE-Linux <selinux@tycho.nsa.gov>,
	linux-kernel@vger.kernel.org
References: <20040709201413.GB3168@lkcl.net> <200407112050.08313.russell@coker.com.au> <20040711112237.GI3390@lkcl.net> <40F16D8B.4010601@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F16D8B.4010601@bellsouth.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear selinux and linux kernel,

i am after some assistance in clarifying how hotplug works, with
a view to solving an issue with SE/Linux where the default
SE/Linux policy is to deny write permission to /etc/hotplug
(with good reason) but the hotplug package is presently demanding
write permission.

a simple request for a change to writing to /var/state/hotplug
instead has thrown up a number of issues with kernel (2.6.6)
hotplugging and i would greatly appreciate some confirmation
and some assistance.


i raised a bug with the debian maintainer for hotplug [he
is known to be, how to describe in a few polite words, a
control freak.  coming from me, that's saying a lot].

i suggested that the location for files to be written to be moved
to /var/state/hotplug and he CLOSED the bug with a message saying
"you can't do that, /var might not be mounted at the time".

i reopened the bug, and then pointed out that the boottime order
was "Mounting local filesystems" (/etc/init.d/mountall.sh) followed
by "Starting Hotplug" (/etc/init.d/hotplug) and he responded with
"well the kernel can run hotplug at any time".

which seems to me to be a bit daft: if you haven't initialised
the hotplug system with /etc/init.d/hotplug, what's the point of
responding to kernel-triggered hotplug events?

sounds like an issue with the kernel, there, to me.

can anyone on the linux kernel mailing list who has knowledge of
the hotplug kernel stuff (and also who knows or is capable of knowing
how the debian hotplug system works) confirm whether hotplug
events will or will not be triggered by the kernel if you have NOT
run the /etc/init.d/hotplug script?


for example, i'm staring at line 176 of /etc/hotplug/usb.rc (v 1.22)
in version hotplug-20040329-8 and i note that usbdevfs is mounted
on /proc/bus/usb.

a comment at line 148 and 164 makes it clear (ish) that a distro
could mount usbdevfs, which could cause a "partial" initialisation
of the usb hotplugging subsystem, and hotplug events could have
been dropped as a result, or not properly started.

so, distros shouldn't _be_ doing a partial initialisation of the
usb subsystem, basically!

anyway.

from this cursory examination, i would conclude that the
argument used [to justify not moving state information to a
new directory /var/state/hotplug] by the debian maintainer of
hotplug that "the hotplug system may generate events at any
time" is bogus.

e.g. under such circumstances where a distribution has
initialised the usb hotplug system BEFORE /etc/init.d/hotplug start
gets a chance to run "/etc/hotplug/usb.rc start", hotplug
events are likely to get missed - not least because the
filesystem might not have been initialised / mounted (except
the root filesystem maybe) and consequently it's hazardous and
problematic, and the usb.rc script has to reinvent some of
the events it might have missed!!

l.

On Sun, Jul 11, 2004 at 12:40:43PM -0400, Jim McCullough wrote:
> Luke Kenneth Casson Leighton wrote:
> 
> >On Sun, Jul 11, 2004 at 08:50:08PM +1000, Russell Coker wrote:
> > 
> >
> >>On Sat, 10 Jul 2004 06:14, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
> >>wrote:
> >>   
> >>
> >>>warning warning warning, do not install hotplug version 20040329-9
> >>>from debian unstable because /etc/hotplug/net.rc attempts to write
> >>>to /etc/hotplug/net.enable.
> >>>
> >>>hotplug writing to /etc/ even /etc/hotplug is banned by the [present]
> >>>selinux policy.
> >>>
> >>>i'm raising a bugreport about this one if there isn't one already.
> >>>     
> >>>
> >>That package is broken in other ways.  
