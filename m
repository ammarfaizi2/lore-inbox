Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275422AbTHNRpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275417AbTHNRpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:45:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39726 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S275422AbTHNRo6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:44:58 -0400
To: Patrick Mochel <mochel@osdl.org>
Cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] call drv->shutdown at rmmod
References: <Pine.LNX.4.33.0308140929180.916-100000@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 14 Aug 2003 11:41:13 -0600
In-Reply-To: <Pine.LNX.4.33.0308140929180.916-100000@localhost.localdomain>
Message-ID: <m1smo4xhl2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@osdl.org> writes:

> > Assuming the device driver can get a device out of the suspend state
> > when the module is loaded.  This has been one of the biggest problem areas
> > with the e100 driver.  It's init code cannot bring the device out of a low
> > power state.
> 
> You're assuming that a driver can always bring a device out a shutdown
> state. 

I am assuming that is a requirement that it is possible for software
to bring a device out of the state is place in by the ->shutdown method.
->shutdown is called on the reboot path and if it results in a pure
software only reboot (i.e. the reset line on the motherboard is not toggled),
then the device driver for the OS loaded after the reboot must reinitialize it.

> That's one of the things we talked about at OLS, and the other half
> of the justification behind such a feature, not just making sure the
> device is queisced. Your argument against my suggestion are some of the
> same arguments for a feature like you're introducing. 

Yes.  My point is that I don't especially like having an additional argument
as that introduces more conditional control flow cases.  My experience
suggests unconditional control flow is more likely to be implemented properly.
 
> We have similar goals - introduce device power state code paths into 
> common operations (e.g module removal). Doing so gets the code paths 
> tested, which will help us ultimately achieve our utopian goals. And, it 
> can be done in one shot. 

If it can be done reasonably I am for it.

> > > The default would always be 'Do Nothing', but with a per-device sysfs 
> > > file, a developer/user/gui app could be used to set the policy from user 
> > > space. 
> > 
> > Possibly.  But this is getting complicated.  And while I do support things
> > being complicated enough to handle the problem this part of the API feels
> > like it is excessively complicated.  Which is why I was trying to simply
> > it by always calling shutdown on a device before we remove it.
> 
> Eh? This is complicated? especially compared your overall goal, kexec? Let 
> me explain again: 

Except that kexec suffers from the same class of issues a cooperative
multitasking (every component must do the right thing), it is quite
simple.  All of my code paths are written assuming they are the slow
uncommon path, so they place the smallest possible burden on the rest
of the kernel.

> I won't take the patch to unconditionally shutdown devices on module 
> removal, so you need some sort of flag. But, you must have some way to set 
> the flag, which is what sysfs is designed for. While you're at it, we 
> might as well make it an integer value, rather than a pure binary one, and 
> conditionally attempt to set the power state if the user says so. 
> 
> It's actually pretty simple, and if it is confusing, then sit back and 
> wait, and I'll provide documentation when I submit the patch. 

I think I now see where you are coming from.  Instead of changing the
production code paths.  Introducing a set of testing code paths to
assist with driver testing.  At least that is the feel I am getting.

Eric


