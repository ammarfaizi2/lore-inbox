Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVBVE4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVBVE4R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 23:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbVBVE4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 23:56:17 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:15456 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262206AbVBVE4N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 23:56:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=PhAN5Yy6y0mWAj55zBtYiK1SRaTsc8uuYfRV09db+V/dwhwEfMVfD0Fsm2tgxMJzj+0vQic4Nd6GtLOd4AxG/oD6lV/t+D6dNmq9NB4p0xO+XmlIcmSxAZrKhgFLqKFU1MiTU0UgJQzECGYqqrQBA0Bd9zInB1JhOFGUnLjkgqU=
Message-ID: <a728f9f9050221205634a3acf0@mail.gmail.com>
Date: Mon, 21 Feb 2005 23:56:12 -0500
From: Alex Deucher <alexdeucher@gmail.com>
Reply-To: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <1109041968.5412.63.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <4218BAF0.3010603@tungstengraphics.com>
	 <21d7e997050220150030ea5a68@mail.gmail.com>
	 <9e4733910502201542afb35f7@mail.gmail.com>
	 <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 14:12:48 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> 
> > Ben, since I'm not getting any help on LKML maybe you can answer this.
> > Secondary cards needs reset. After looking at a bunch of fbdev drivers
> > their code assumes the card has been reset when their probe() function
> > runs. So this means that we have to run the VBIOS reset before probe
> > is called.
> 
> I'm putting back LKML on CC since I intended to reply to your post there
> once I got a bit of time.
> 
> No, we can't really do that _before_ probe is called. It's the
> responsibility of the driver to do what it needs at probe time or later.
> Some drivers need that reset (and not that many in fact), some don't.
> 
> We may provide a "helper" to use from the probe() for that purpose, to
> make things easier.
> 
> Wether the reset code is kernel based or userland based, I would avoid
> have it run synchronously anyway. If a driver detects that it's card
> hasn't been properly initialized by the firmware (and the driver should
> be able to detect that), I suggest it's probe routine calls the
> appropriate helper, providing it with ways to get to the ROM (in some
> case, the same helper will be needed for resume from sleep, and the ROM
> may not be the PCI BAR one, but the memory shadow, though that will not
> always work afaik).
> 
> Look at the firmware download helper, that's very similar. I want an
> asynchronous interface though (that is you get a callback when the reset
> is complete or timed out) rather than synchronous since it's wrong to
> synchronously rely on userland beeing available (power management,
> pre-root mount, etc...)
> 
> > So where can I hook up the call to run the VBIOS up in the kernel? You
> > can't trigger it on module load since the module may support multiple
> > identical adapters. One adapter may already have the module loaded and
> > then a second shows up via hotplug. In this case the module won't get
> > loaded again and the second card doesn't get reset.
> >
> > If using a user space reset program what do you do if the user space
> > program is missing or does not complete running? Somehow you have to
> > stop the probe function from being called.
> 
> That's ok. We deal with that in the firmware loader code already. Just
> timeout or check for errors from call_usermodehelper. You basically run
> the user program and wait for it to write a "reply" via sysfs. In fact,
> the existing firmware loading facility could be re-used.
> 
> > Another case, you have a card and load the module for it, this causes
> > reset. Now unload the module and load it again. This probably should
> > not reset the card a second time. You also have to make sure you don't
> > reset the primary card.
> 
> It's up to each driver to detect wether it's card need to be POSTed or
> not. Anything else would mean infinite breakage.
> 
> > One solution is to track in pci_dev if the card has been reset. This
> > preserves the state across module load/unload. I'm then tempted to put
> > an in-kernel emu86 (I have a 40K one) into the pci driver. PCI would
> > use this to reset the card before calling probe(). If the VBIOS/emu86
> > has an error it simply wouldn't call the probe function. Doing this
> > in-kernel makes everything synchronous but GregKH would probably have
> > some choice words about the emulator in the PCI driver.
> 
> No, again, it's up to the driver to decide wether it needs to POST or
> not (I prefer that to "reset"). I have no preference for the emulator to
> be in-kernel or userland. I suppose it's easier in userland, just
> re-using the existing infrastructure for firmware loading.
> 

another advantage of the emulator would be that "PC" vga cards could
be used in non-x86 platforms, which I'm sure would be quite popular...

Alex
