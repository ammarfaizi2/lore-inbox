Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWEYPh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWEYPh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWEYPh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 11:37:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:38075 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030226AbWEYPh2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 11:37:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TW2IJYM5EHtNeOZcQqXJcbLfaut1TH0qjyUAkSIE7BQ9sGTACHtL+xdoktcPM8HjFeTTlTym3nxhFRNk45VA2+1/2BQBYhSTGNUq3LgYnj5EbappnUVC2flURdBnDFg1I3X0jZ71t+P1mU9Qrkl7LMckBIvIBd6dxu9YMUfQfcg=
Message-ID: <9e4733910605250837u59ad3881s75a0ed366fa2eefb@mail.gmail.com>
Date: Thu, 25 May 2006 11:37:27 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "D. Hazelton" <dhazelton@enter.net>, "Dave Airlie" <airlied@gmail.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <4475C845.5000801@garzik.org>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/06, Jeff Garzik <jeff@garzik.org> wrote:
> Jon Smirl wrote:
> In Linux, the lowlevel driver registers irq handlers, so your simple
> problem has the simple and obvious answer.  Further, reviewing my
> statement above, if fbdev/DRM are aware of each other, and if they both
> are layered on top of the lowlevel driver, then it should also be
> obvious that they are cooperatively sharing resources, not competing
> against one another.
>
>
> > I would instead start by making fbdev the low level driver. DRM could
> > then bind to it and redundant code in DRM could be removed. 90% of the
> > code in fbdev is always needed.  Hopefully X could be convinced to use
>
> Take your pick.  An fbdev driver is nothing but a PCI driver that
> registers itself with the fbdev subsystem.  Ditto a DRM driver, though
> the DRM and agpgart layering is royally screwed up ATM.  Regardless, he
> who codes, wins.

There is significant architectural difference between the two schemes.
Is the base driver an absolute minimal driver that only serves as a
switch to route into the other drivers, or does the base driver
contain all the common code? I'm in the common code camp, DaveA is in
the minimal switch camp.

Take memory management for example. I think the memory manager should
go into the base driver. The other strategy is for each driver to have
their own memory manager and then the base provides a way to select
which one is active. (Note that in all cases the complex part of
memory management is running in user space).

> > the services offered by the fbdev/DRM pair. New memory management code
>
> No "hopefully."  X must be forced to use this driver, otherwise the
> system is unworkable.

I have had no success in making this happen.

> > would be added to this base driver since everyone needs it. Fbdev
>
> If fbdev and DRM are cooperating, then obviously they will cooperate
> when managing resources.  GPU memory is but one example of a resource.

What is cooperation? Is it shared code in the base coordinating a
single state in the hardware, or is it save your state, I'm switching
to another driver, now I'm loading its state. We can't achieve
agreement on this.

> > would also pick up the ability to reset secondary cards at boot.
>
> But if you think the kernel will grow an x86 emulator, you're dreaming.
> That's what initramfs and friends are for.

Depends on what you mean by the kernel growing the emulator. I don't
want to put it in the kernel binary, but I would like to see it in the
kernel tree. It would use klibc and initramfs. There are some classes
of machines that cannot get video at boot without running the ROM.
Making this part of the boot process will guarantee that all cards
have been POSTed by the time normal user space is up.

-- 
Jon Smirl
jonsmirl@gmail.com
