Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270148AbTHOQzN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 12:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270142AbTHOQMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 12:12:05 -0400
Received: from zeus.kernel.org ([204.152.189.113]:59269 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S267471AbTHOQJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 12:09:01 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] call drv->shutdown at rmmod
References: <Pine.LNX.4.33.0308140929180.916-100000@localhost.localdomain>
	<1060937467.13316.39.camel@gaston>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Aug 2003 09:28:31 -0600
In-Reply-To: <1060937467.13316.39.camel@gaston>
Message-ID: <m1oeyrx7mo.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> > You're assuming that a driver can always bring a device out a shutdown
> > state. That's one of the things we talked about at OLS, and the other half
> > of the justification behind such a feature, not just making sure the
> > device is queisced. Your argument against my suggestion are some of the
> > same arguments for a feature like you're introducing. 
> 
> There is a problem of semantics here. Is shutdown() supposed to shutdown
> the hardware device (ie. low power) or just the driver ? If yes, then
> it's duplicate of the PM callbacks. My understanding of the shutdown()
> callback is that it was more than "stop driver activity, put device into
> idle state" to prepare for a shutdown/reboot (though we do also sleep
> IDE drives in this case, but this is because of that nasty cache flush
> issue).
> 
> The problem with kexec is just that. What it needs isn't low power devices,
> it needs device back in "idle" state, but if possible powered up (or at
> least in whatever state the driver found them on boot). The most important
> thing is to actually stop pending bus mastering activities.
> 
> On PPC, we have a name for that which comes from Open Firmware (since we
> need to ask the firmware to stop bus mastering & idle devices the same way
> when we take over it and before we get control of the system memory) and
> it's called "quiesce".

Even if kexec is not brought into the picture the devices need to be quiesed on
reboot.  On x86 and probably other architectures there are 2 ways a reboot can go.
1) The firmware when it regains control toggles the motherboard reset
   line resetting all of the devices, so nothing we do really makes a difference.
2) The firmware when it regains control tweaks a few things and
   pretends it was never out of control, and restarts the boot
   process.

When the firmware does not toggle the motherboard reset line during a
reboot the firmware case is exactly equivalent to the kexec one.

So shutdown needs to quiese things.

Eric
