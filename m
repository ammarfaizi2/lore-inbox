Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUIKRVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUIKRVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 13:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUIKRVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 13:21:44 -0400
Received: from the-village.bc.nu ([81.2.110.252]:41907 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268224AbUIKRVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 13:21:40 -0400
Subject: Re: radeon-pre-2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
References: <9e47339104090919015b5b5a4d@mail.gmail.com>
	 <9e47339104091008115b821912@mail.gmail.com>
	 <1094829278.17801.18.camel@localhost.localdomain>
	 <9e4733910409100937126dc0e7@mail.gmail.com>
	 <1094832031.17883.1.camel@localhost.localdomain>
	 <9e47339104091010221f03ec06@mail.gmail.com>
	 <1094835846.17932.11.camel@localhost.localdomain>
	 <9e47339104091011402e8341d0@mail.gmail.com>
	 <Pine.LNX.4.58.0409102254250.13921@skynet>
	 <20040911132727.A1783@infradead.org>
	 <9e47339104091109111c46db54@mail.gmail.com>
	 <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094919501.21088.111.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 17:18:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 18:02, Linus Torvalds wrote:
> My personal preference for this whole mess has always been the "silly 
> driver" that isn't even hardware-specific, and really does _nothing_ on 
> its own. This one would be the only thing that actually reserves the IO 
> regions and "owns" the card from the respect of the resources. EVERYBODY 
> else would be a "stealth" driver. Not just DRM.

How do you plan to deal with hot plug. At the point the "silly driver"
(in my case this is the vga class driver) claims the PCI device and
propogates things onwards hotplug seems to work.

The second fun bit is that Jon is right that in some cases the fb driver
for a card may want to use the DRI layer if loaded - but only some and
only in a controlled manner. Sometimes the drivers want to co-operate
sometimes they just want to avoid beating each other senseless.

>    Now, the reason why these things are _pointers_ to locks rather than 
>    locks themselves is that maybe some hardware ends up sharing resources 
>    between these things (maybe "modeswitch" needs the accelerator to 

How do you deal with making sure the lock doesn't get freed and knowing
who needs it still ? I ended up with locks in the shared area itself
because I couldn't figure that one out ?

>  - memory allocation. Many of these issues really are generic, and once 
>    you have the locking setup done, maybe you can have a generic memory
>    allocation layer for splitting up AGP memory or whatever. See the 
>    "dma_declare_coherent_memory()" interfaces that James Bottomley did for 
>    some SCSI devices that have on-board memory that they want to let the 
>    kernel allocate as DMA'able.

I think allocation is genuinely a hard problem in the 3D card case. Some
devices have the most wonderful restrictions on layout that range
from "the frame buffer is here" to "I want 2Mb, 1Mb aligned within a 4Mb
range and you can free this stuff if you notify me but its not
textures". Multihead really makes this interesting and DRI itself
doesn't really address this problem either.

Linus let me run what I have now past you for comment (the code isnt
working yet since I've been having a fight with the class code)

The vga_class module registers itself as the owner of every VGA class
device on the PCI bus. The PCI layer duely gives it all the video
hotplug events.

On creation it creates a set of (currently 3) vga bus objects for each
card. So if we find say a Voodoo 3, we will create vga bus objects

		Voodoo 3 memory manager
		Voodoo 3 DRI
		Voodoo 3 Frame buffer 0

(for now. Quite possibly mode management is separate, maybe memory 
 manager eventually will or will not be)

and stick them onto global and per vga router lists.

vga_register_driver works like PCI register driver but also takes a 
"type" field and will attach to the appropriate one of the 3 objects,
detach on hotplug and all the rest as the base/* code provides.

When you attach or detach you get a notifier to the other members that
are loaded.

Finally there is a shared structure between the different vga bus
objects for each video card which allows you to find one function from
another (maybe the notifiers should pass these) and also a semaphore.


