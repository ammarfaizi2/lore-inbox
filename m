Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317092AbSFFTOn>; Thu, 6 Jun 2002 15:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317104AbSFFTOm>; Thu, 6 Jun 2002 15:14:42 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:24557 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S317092AbSFFTOk>; Thu, 6 Jun 2002 15:14:40 -0400
Date: Thu, 06 Jun 2002 12:15:22 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: device model documentation 2/3
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>,
        Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>,
        linux-kernel@vger.kernel.org,
        linux-hotplug-devel@lists.sourceforge.net,
        linux-usb-devel@lists.sourceforge.net
Message-id: <3CFFB4CA.3020508@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
In-Reply-To: <200206051253.g55Crs331876@fachschaft.cup.uni-muenchen.de>
 <Pine.LNX.4.33.0206051205150.654-100000@geena.pdx.osdl.net>
 <20020602044907.A121@toy.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > All calls are made with interrupts enabled, except for the
 > > SUSPEND_POWER_DOWN level.
 >
 > This is a slight problem for USB. We need to switch on interupts
 > to send a message to the device.

For example, to enable remote wakeup (whenever we start to
support that).  I understand that a lot of USB hardware does
not work reliably if that's enabled much before a USB suspend.
If only SUSPEND_POWER_DOWN notification was delivered, that'd
have to be enabled at that point.


>>Why would you allocate memory on a resume transition? 

One example comes to mind.  There are systems that, rather
than supporting a "suspend to reduced power", are actually
set up so they "suspend to no power".  Or in short, they
power off in cases when other systems don't ... saving even
more power.  (I think that is the difference between D3hot
and D3cold, or somesuch, but there are so many different
names for the various states and contexts that I've been
known to get them wrong.)

In that case, a "resume" needs to be able to completely
re-initialize the hardware.  As a rule, that's going to
want to be able to allocate memory.

... though FWIW I missed seeing anything that showed how
those API summaries would place constraints on allocating
memory, so I didn't assume there could be any.


What did seem to be missing was anything saying whether
those device methods would be called in_interrupt() or
whether instead they could sleep.  I'd hope all of them
would be specified to allow blocking as needed, like their
current analogues in PCI and USB.

Also, there was some mention not that long ago about
desirability of some kind of device abort() call.  That
would differ from the current remove() call because an
abort() would pass the explicit knowledge that hardware
was gone ... unplugged before driver shutdown, for one
example.  That could also be achieved using some kind
of mode parameter to remove() -- perhaps three values,
saying whether the hardware was present, removed, or
in some indeterminate state.

- Dave

