Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSJMVXT>; Sun, 13 Oct 2002 17:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSJMVXS>; Sun, 13 Oct 2002 17:23:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5239 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261721AbSJMVXR>; Sun, 13 Oct 2002 17:23:17 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: Eric Blade <eblade@blackmagik.dynup.net>, linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
References: <200210131924.MAA00308@baldur.yggdrasil.com>
	<1034538718.1215.4.camel@cpq>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Oct 2002 15:27:39 -0600
In-Reply-To: <1034538718.1215.4.camel@cpq>
Message-ID: <m1elaum3lg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Blade <eblade@blackmagik.dynup.net> writes:

> On Sun, 2002-10-13 at 15:24, Adam J. Richter wrote:
> > 	linux-2.5.42 had an annoying new behavior.  When I would
> > try to do a warm reboot, it would spin down the hard drives, which
> > just made the reboot take longer and gave the impression that a
> > halt or poweroff was in progress.
> > 
> > 	At first, I suspected IDE, but I think the new behavior in IDE
> > of spinning down the hard drives on suspend is correct.  The problem
> > is that the warm reboot system call is trying to suspend all of the
> > devices before a warm reboot for no reason.


There is a very good reason for calling the driver->remove() function
on a reboot so that we place the devices in a consistent state.  And
stop any on going DMA etc.  If the ide module spins down disks when
you remove it that is a little odd.

>  We already have a reboot
> > notifier chain that drivers can use to register code that has to be
> > run in order to safely reboot or halt.  

The reboot notifier call chain, is highly underused, and all of the drivers
already have the code they need in their remove function.

> I am not talking about
> > eliminating that.  I am only talking about the soft reboot putting
> > devices into a power saving mode that is allowed to take a long
> > recovery time, especially given that the reboot is likely to want to
> > talk to every hardware device connected to the system.

If 
driver->remove() 
does that it is an issue with that device driver.

> > 	Anyhow, here is the patch.  As far as I can tell, there is no
> > delegated mainainer for kernel/sys.c, so I am sending this to
> > linux-kernel and I will resend it to Linus later if nobody points me
> > to another maintainer to go through and there are no complaints.
> 
> Adam,
>   I'm not sure the proper thing to do is necessarily remove the
> device_shutdown() call.  

I am certain it is.  

> I did the changes to the device_shutdown()
> function, but as far as I can tell, it should not have changed any
> behavior like that - all I did was re-work the logic a bit.  In any
> case, what I did submit to the mailing list was absent a small piece of
> code (a change to device.h), and the person who forwarded it onto Linus
> (thank you!) did make a change to make it compile without that.

Hmm.  Does SUSPEND_POWER_DOWN have noticeably different behavior?

>   Please try this patch to the base 2.5.42 code, and let me know if this
> returns it to the previous behavior?

How can this affect device_shutdown()?  
If POWER_DOWN is used in different places I can see the desire for the change.
But I don't even see why we would want this.

Oh, and thank you for the code by the way.  I can finally write a correct
version of kexec, and expect the device drivers to clean themselves up
properly.

Eric
