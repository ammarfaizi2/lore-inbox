Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263215AbTJ0PMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbTJ0PMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:12:40 -0500
Received: from msgdirector3.onetel.net.uk ([212.67.96.159]:20803 "EHLO
	msgdirector3.onetel.net.uk") by vger.kernel.org with ESMTP
	id S263215AbTJ0PMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:12:38 -0500
Message-ID: <3F9D355C.8070103@tungstengraphics.com>
Date: Mon, 27 Oct 2003 15:10:20 +0000
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Egbert Eich <eich@xfree86.org>, Jon Smirl <jonsmirl@yahoo.com>,
       Eric Anholt <eta@lclark.edu>, kronos@kronoz.cjb.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net,
       dri-devel <dri-devel@lists.sourceforge.net>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [Dri-devel] Re: [Linux-fbdev-devel] DRM and pci_driver conversion
References: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0310251116140.4083-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sat, 25 Oct 2003, Egbert Eich wrote:
> 
>>Speaking of XFree86: when I developed the PCI resource stuff in 
>>XFree86 I was trying to get support from kernel folks to get the 
>>appropriate user space interfaces into the kernel. When I got 
>>nowhere I decided to do everything myself. 
> 
> 
> There won't be any "user space interfaces". There are perfectly good 
> in-kernel interfaces, and anybody who needs them needs to be in kernel 
> space. Ie the kernel interfaces are for kernel modules, not for user space 
> accesses.
> 
> The kernel module can be a simple interface layer like DRI, but the thing 
> is, it needs to be specific to some kind of hardware. I refuse to have 
> some kind of crap "user space driver" interface - drivers in user space 
> are a mistake. 
> 
> 
>>Is there any API that allows one to do this from user space?
> 
> 
> No. And I don't really see any huge reason for it.
> 
> 
>>There are plenty of XFree86 drivers around that don't have a
>>DRM kernel module and it should  be possible to run those which
>>do without DRI support, therefore it would be a good if the
>>XFree86 driver could do this registration itself.
> 
> 
> If you do this, do it _right_. Look at what X really needs, and make a
> driver for it. A _real_ driver. Not just a half-hearted "we want to do
> things in user space, but we can't".
> 
> Face it, a good graphics driver needs more than just "set up the ROM". It
> needs DMA access, and the ability to use interrupts. It needs a real 
> driver.
> 
> It basically needs something like what the DRI modules tend to do.
> 
> I'd be really happy to have real graphics drivers in the kernel, but quite
> frankly, so far the abstractions I've seen have sucked dead donkeys
> through a straw. "fbcon" does way too much (it's not a driver, it's more a
> text delivery system and a mode switcher). And DRI is too complex and
> fluid to be a good low-level driver.
> 
> Quite frankly, I'd much rather see a low-level graphics driver that does
> _two_ things, and those things only:
> 
>  - basic hardware enumeration and setup (and no, "basic setup" does not
>    mean "mode switching": it literally means things like doing the 
>    pci_enable_device() stuff.
> 
>  - serialization and arbitrary command queuing from a _trusted_ party (ie
>    it could take command lists from the X server, but not from untrusted
>    clients). This part basically boils down to "DMA and interrupts". This 
>    is the part that allows others to wait for command completion, "enough 
>    space in the ring buffers" etc. But it does _not_ know or care what the 
>    commands are.
> 
> Then, fbcon and DRI and X could all three use these basics - and they'd be
> _so_ basic that the hardware layer could be really stable (unlike the DRI
> code that tends to have to upgrade for each new type of command that DRI
> adds - since it has to take care of untrusted clients. So DRI would
> basically use the low-level driver as a separate module, the way it
> already uses AGP).

That makes sense - the abstraction of dma engine away from the 
security-providing gumpf that is so much of the DRM modules, to form a single 
kernel-level "owner" of the graphics hardware.

This would also answer various questions that float around regarding who is 
the ultimate "owner" of the graphics hardware - in particular, who is 
responsible for virtualization of the graphics memory.

Of course, that's a trickier task because it is one which doesn't just rip 
existing code out of various poorly-conceived modules.

Keith

