Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVBVTTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVBVTTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBVTTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:19:39 -0500
Received: from fire.osdl.org ([65.172.181.4]:35979 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261326AbVBVTTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:19:19 -0500
Date: Tue, 22 Feb 2005 11:19:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Dave Airlie <airlied@linux.ie>, dri-devel@lists.sourceforge.net,
       xorg@lists.freedesktop.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
In-Reply-To: <9e473391050221204215a079e1@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0502221111410.2378@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502201049480.18753@skynet> 
 <4218BAF0.3010603@tungstengraphics.com>  <21d7e997050220150030ea5a68@mail.gmail.com>
  <9e4733910502201542afb35f7@mail.gmail.com>  <1108973275.5326.8.camel@gaston>
  <9e47339105022111082b2023c2@mail.gmail.com>  <1109019855.5327.28.camel@gaston>
  <9e4733910502211717116a4df3@mail.gmail.com>  <1109041968.5412.63.camel@gaston>
 <9e473391050221204215a079e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Feb 2005, Jon Smirl wrote:
>
> I was working on the assumption that all PCI based, VGA class hardware
> that is not the boot device needs to be posted.

I don't think that's true. We certainly don't _want_ it to be true in the 
long run - and even now there are cards that we can initialize fully 
without using the BIOS at all.

> And that the posting should occur before the drivers are
> loaded.

Personally, I'd much rather let the driver be involved in the decision.

That may mean that the probe routine knows how to initialize the card, but
it may mean that it does an "exec_usermodehelper()" kind of thing.  
Actually, I'd prefer it if this was largely up to "udev": if the driver
notices that it can't initialize the card, why not just enumerate it
enough that "udev" knows about it (that's pretty much automatic), and let
the driver just ignore the card until some (possibly much later) date when
the user level scripts have found it and initialized it.

That would imply that the driver have some "re-attach" entrypoint (which 
migth be a ioctl, but might also be just a /sysfs file access), which is 
the user-lands way of saying "try again - I've now initialized the 
hardware".

The advantage of that kind of "disconnected" initialization is that you
don't _need_ to have the card initialization in initramfs or other "very
early boot" sequence. It gets _detected_ early on, but you can then delay
initializing it arbitrarily long, and it obviously won't be usable until 
that point (but who cares? The ones that do care can put the things in 
their initramfs, others may decide to do it only once the system is 
up-and-running and /usr has been NFS-mounted).

		Linus
