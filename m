Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbTLLO4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 09:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTLLO4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 09:56:41 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:19843 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S265170AbTLLO4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 09:56:38 -0500
Date: Fri, 12 Dec 2003 14:51:24 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Duncan Sands <baldrick@free.fr>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
Message-ID: <20031212145124.GA13865@mail.shareable.org>
References: <20031208154256.GV19856@holomorphy.com> <3FD5AB6C.3040008@aitel.hist.no> <20031212112636.GA12727@mail.shareable.org> <200312121433.14603.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312121433.14603.baldrick@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> >     2. Keep track of when devices are used, and when they are not busy.
> >        We already have this, it's the module reference count.
> 
> USB modules (eg: xxxx-hcd) are typically set up so they can be
> unloaded at any time: the act of unloading disconnects any devices
> driven by the module and frees resources.  I guess this is
> problematic for your point 2.  I understand that some network
> modules work this way too.

I don't see a problem.  A HCD device such as a keyboard is always
"active" because it must always be listening for keys as long as the
keyboard is plugged in.  You can explicitly "soft unplug" by unloading
the module; the proposal doesn't change that.  (Although it would be a
nice interface to copy the PCMCIA method, where you tell the USB
subsystem to disconnect a device instead of having to know which
module(s) to unload).

I agree that in that case, the device is active regardless of its
module reference count.  They aren't the same thing.

(Taking it further, USB keyboard is an example of a driver that could
be made permanently demand-pageable as all of the code _could_ be
executed in a process context, if USB's callbacks were made to work
that way, but that road is potentially quite a complicated and error
prone one).

A network device is similar as long as its interface is up (if it's a
device).  A protocol module is active as long as it has any active
users, for which various definitions are possible.

Protocol (+ mid-layer, helper modules etc.) show that ideally the
"active" property of a module includes any references to it by other
active modules, which can be interpreted in a simple or a complicated
way, depending on how thoroughly you want modules to be paged out
while still presenting their interfaces in /sys, /dev, /proc,
ifconfig, iptables etc.

-- Jamie
