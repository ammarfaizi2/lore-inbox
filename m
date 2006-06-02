Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751071AbWFBBP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbWFBBP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWFBBP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:15:59 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:48748 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751069AbWFBBP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:15:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JbykoXnWrSRe8Bn+JrRIlS3ygUhJeLUXAEVD8cl2QPlTlsAM7w8bPhQGzgZP0XansdiufjXMf5EWOQmsNUlAQohsiSoZVxjb3d7Uus1eG3J2APonvQW/9B440OBppbLYfcW4gDSsO0G4m2heVaS6qQc1o18Bd4cXQsPF6vTL8i0=
Message-ID: <21d7e9970606011815y226ebb86ob42ec0421072cf07@mail.gmail.com>
Date: Fri, 2 Jun 2006 11:15:47 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Ondrej Zajicek" <santiago@mail.cz>, "D. Hazelton" <dhazelton@enter.net>,
       "Pavel Machek" <pavel@ucw.cz>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, adaplas@gmail.com
In-Reply-To: <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605302314.25957.dhazelton@enter.net>
	 <9e4733910605302116s5a47f5a3kf0f941980ff17e8@mail.gmail.com>
	 <200605310026.01610.dhazelton@enter.net>
	 <9e4733910605302139t4f10766ap86f78e50ee62f102@mail.gmail.com>
	 <20060601092807.GA7111@localhost.localdomain>
	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without specifying a design here are a few requirements I would have:
>
> 1) The kernel subsystem should be agnostic of the display server. The
> solution should not be X specific. Any display system should be able
> to use it, SDL, Y Windows, Fresco, etc...

of course, but that doesn't mean it can't re-use X's code, they are
the best drivers we have. you forget everytime that the kernel fbdev
drivers aren't even close, I mean not by a long long way apart from
maybe radeon.

> 2) State inside the hardware is maintained by a single driver. No
> hooks for state swapping (ie, save your state, now I'll load mine,
> ...).

We still have to do state swapping, we just don't expose it,
suspend/resume places state swapping as a requirement.

> 3) A non-root user can control their graphics device.

Of course, how we decide their device is another story best left to a
permissions model, either  /dev or sockets will cover this.

> 4) Multiple independent users should work

Multiple independent users on one card is always nasty but I can't see
anything to stop this from working.

> 5) The system needs to be robust. Daemons can be killed by the OOM
> mechanism, you don't want to lose your console in the middle of trying
> to fix a problem. This also means that you have to be able to display
> printk's from inside interrupt handles.

I've already pointed out the first of these is crap, a protected
daemon is better. displaying printks inside interrupt handlers on a
graphics console is always nasty, especially if the engine waits for
idle space etc.. so ideally this should involve just blasting to the
fb using info we know about like framebuffer/font etc..

> 6) Things like panics should be visible no matter what is running. No
> more silent deaths.

Same as 5 really..

> 7) Obviously part of this is going to exist in user space since some
> cards can only be controlled by VBIOS calls. Has anyone explored using
> the in-kernel protected mode VESA hooks for this?

Obviously as part of replacing X we must implement all features that X has.

> 8) The user space fbdev API has to be maintained for legacy apps. DRM
> can be changed if needed since there is only a single user of it, but
> there is no obvious need to change it.

DRM is designed to be incrementally changed, we cannot just break it
however, we can add new features that are enabled for a new userspcae,
but old X servers should continue to work with the new DRMs, this is a
hard requirement that is missing and will be missing every time you
post these lists.

> 9) there needs to be a way to control the mode on each head, merged fb
> should also work. Monitor hotplug should work. Video card hot plug
> should work. These should all work for console and the display
> servers.

Of course, have you got drivers for these written? this is mostly in
the realms of the driver developer, the modesetting API is going to
have to deal with all these concepts.

> 10) Console support for complex scripts should get consideration.

not really necessary.. nor should it be... fbset works, something like
it would be good enough..

> 11) VGA is x86 specific. Solutions have to work on all architectures.
> That implies that the code needed to get a basic console up needs to
> fit on initramfs. Use PPC machines as an example.

or other arches can have initial fbdev drivers that get disabled at
run time, stated a few times previously

> 12) If a driver system is loaded is has to inform the kernel of what
> resources it is using.

of coursee again this obvious.

13) text mode
Yes should always be an option.

Some simple ones from me:

14) backwards compatible, an old X server should still run on a new
kernel. I will allow for new options to be enabled at run-time so that
this isn't possible, but just booting a kernel and starting X should
work.

15) re-use as much of the X drivers as possible, otherwise it will KGI.

16) secure - no direct IO or MMIO access, modesetting is slow anyways
having the kernel checking the mmio access won't make it much slower.

17) incremental implementation - so it won't KGI.

Dave.

Dave.
