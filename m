Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWEYXEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWEYXEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 19:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWEYXEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 19:04:44 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:4735 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030188AbWEYXEo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 19:04:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NoTXOJLCfBFD//UEBmfyUU94Rzv7QltkvsHju3uV+I3DC+rwUA7rG0ZsSXS+2YmlM+OJ7jFzXU9vQKAcW0uct/yltGztGlG08mkzYELNDiXB8DIqeh/bPlY53Wh5qz75gztnHZf7ati4RjejuKLRKCWNxxdkNgSUEa0MIBSTeJA=
Message-ID: <21d7e9970605251604l409feddfycf004113def96574@mail.gmail.com>
Date: Fri, 26 May 2006 09:04:41 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Jeff Garzik" <jeff@garzik.org>, "D. Hazelton" <dhazelton@enter.net>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <9e4733910605241656r6a88b5d3hda8c8a4e72edc193@mail.gmail.com>
	 <4475007F.7020403@garzik.org> <200605250237.20644.dhazelton@enter.net>
	 <44756E70.9020207@garzik.org>
	 <9e4733910605250704m68235d88lcd8eaedfda5e63cf@mail.gmail.com>
	 <4475C845.5000801@garzik.org>
	 <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Take your pick.  An fbdev driver is nothing but a PCI driver that
> > registers itself with the fbdev subsystem.  Ditto a DRM driver, though
> > the DRM and agpgart layering is royally screwed up ATM.  Regardless, he
> > who codes, wins.
>
> There is significant architectural difference between the two schemes.
> Is the base driver an absolute minimal driver that only serves as a
> switch to route into the other drivers, or does the base driver
> contain all the common code? I'm in the common code camp, DaveA is in
> the minimal switch camp.

You should really stop saying what I want, and look at what I did, my
code is in those patches.

What you realise after working on this from both directions is that it
doesn't matter, you just need a lowlevel layer initially, that you can
bind functionality to, the first step is to allow the DRM and fb to
become aware and communicate with each other, once you have this, you
can then start shuffling code down into the lowlevel driver, without
breaking the functionality of the fbdev or DRM drivers.

I'm not having a switch between DRM and fbdev, its not one or the
other yet, you need to learn to take small steps, we just need to
formalise the relationship between the two so that they can deal with
each other being there in a better fashion than they do currently, and
also so we can better suspend/resume support etc.

> Take memory management for example. I think the memory manager should
> go into the base driver. The other strategy is for each driver to have
> their own memory manager and then the base provides a way to select
> which one is active. (Note that in all cases the complex part of
> memory management is running in user space).

So far we have no memory management, and most of the plans I've seen
involved using a userspace system to do it, really we just want the
fbdev driver to be able to ask the DRM, so where the hell is the
frontbuffer, if the DRM is loaded and if it isn't just say I'm using
here.

> > No "hopefully."  X must be forced to use this driver, otherwise the
> > system is unworkable.
>
> I have had no success in making this happen.

And won't as long as you fight against it, we don't have to force X to
use it, we have to make it an option in X that distros turn on... we
have to let the X people keep doing their drivers the way they do
drivers... I'm still not convinced putting modesetting in kernel is at
all necessary, I think a simple MMIO parser to stop bad commands from
getting to the hardware is all we should need, modesetting normally
consists of a small number of operations.

Write register,
Read register,
Wait for something to happen (vblank, bit set in a register X times..)

I think we can write an interface via the DRM to do these, but these
are a for later thing, until the fbdev and DRM layers can communicate
it is not practical.

> What is cooperation? Is it shared code in the base coordinating a
> single state in the hardware, or is it save your state, I'm switching
> to another driver, now I'm loading its state. We can't achieve
> agreement on this.

It'll be hopefully shared-state handling I dislike the amount of
save/restore stuff we do now, however you have to remember for
suspend/resume we normally have to this anyways, so we end up having
all the save/restore code in the end.

Dave.
