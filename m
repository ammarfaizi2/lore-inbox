Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264833AbUEEWqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbUEEWqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264834AbUEEWqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:46:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:15036 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264833AbUEEWqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:46:12 -0400
Date: Wed, 5 May 2004 15:45:34 -0700
From: Greg KH <greg@kroah.com>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
Message-ID: <20040505224534.GB30345@kroah.com>
References: <408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net> <c6od9g$53k$1@gatekeeper.tmr.com> <s5ghdv0i8w4.fsf@patl=users.sf.net> <20040504200147.GA26579@kroah.com> <s5ghduvdg1u.fsf@patl=users.sf.net> <20040504223550.GA32155@kroah.com> <s5gy8o7bnhv.fsf@patl=users.sf.net> <20040505025602.GA19873@kroah.com> <s5gpt9jexwg.fsf@patl=users.sf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gpt9jexwg.fsf@patl=users.sf.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 11:19:56AM -0400, Patrick J. LoPresti wrote:
> What I want is to load a driver and not proceed until it has finished
> loading, which I am told "does not fit into the way the kernel handles
> drivers anymore".  This strikes me as a clear misdesign.

No, it is designed this way on purpose.  Think about devices that can be
added or removed at any point in time.  Failing a module load if a
device isn't present at this point in time is not good if the device is
plugged in a while later.

It also would not allow you to bind a driver to a device while the
kernel is running that the driver doesn't originally know about.  See
the pci sysfs file "new_id" for how you can do this today.  If we didn't
allow the driver to load that would not be possible at all.

> > So, what are you trying to fix/solve/monitor/do here?
> 
> I have a custom Linux boot disk for my project
> (http://unattended.sourceforge.net/).  I want it to work unaltered on
> as many different systems as possible.  The boot disk can be
> interactive or non-interactive, depending on how the system is
> configured.  Early on, it issues a prompt "Override boot disk
> defaults?", which defaults to "no" after a ten-second timeout.
> 
> So, first, I want to load the driver for the keyboard, if any.  I want
> to wait until the keyboard is ready before I emit any prompts.  Under
> no circumstances do I want to wait forever.
> 
> This is just one example.  I have now had essentially the same problem
> three different times:
> 
>   1) Loading hid.o to talk to the keyboard, as described.

Why not just build this in the kernel?  Once the driver is bound to the
device, the user can eventually press a key.  Perhaps make your timeout
longer (1 minute)?

>   3) When I load the network driver, I want to wait until it is ready
>      to use.  Otherwise, when I try to obtain a DHCP lease, sometimes
>      it fails.

Run your dhcp connect script after the device is bound to the driver
through the hotplug interface (the default hotplug scripts do this
today.)  No waiting, no guessing, no additional scripting, it just works
exactly when the device is ready for it to work.

> In all of these cases, I am hacking around an apparent design flaw in
> the kernel's device loading architecture.  Obviously, random delays
> are inherently unreliable; hence my comment about "unreliable by
> design".

Sorry, but your situation is very unusual, and based on my suggestions,
I don't think it is needed.

But hey, you have the source, if you don't like it, feel free to change
the code :)

thanks,

greg k-h
