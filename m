Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbUKOWxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbUKOWxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKOWxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:53:20 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:54762 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261533AbUKOWwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:52:17 -0500
Message-ID: <41993320.3010501@free.fr>
Date: Mon, 15 Nov 2004 23:52:16 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>,
       bjorn.helgaas@hp.com, vojtech@suse.cz
Subject: Re: [PATCH] PNP support for i8042 driver
References: <41960AE9.8090409@free.fr>	 <200411140148.02811.dtor_core@ameritech.net>	 <41974DFD.5070603@free.fr> <d120d50004111506416237ff1b@mail.gmail.com>	 <419908B8.10202@free.fr> <d120d500041115122846b9f0fa@mail.gmail.com>
In-Reply-To: <d120d500041115122846b9f0fa@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dmitry Torokhov wrote:
> On Mon, 15 Nov 2004 20:51:20 +0100, matthieu castet
 >>Yes you could do a very ugly hack : set pnp_can_disable(dev) to 0 before
 >> unregister. With that the device won't be disabled (no resource
 >>desalocation), but the device will be mark as not active in pnp layer.
 >>
 >
 >
 > I'd like to release resoures al well (interrupts only really, as 
ports are
 > always reserved by the system even before PNP is initialized).
 >
 >
that's the case : well I said no resource desalocation it was for the 
motherboard. We haven't other choice : if we disable them, they won't be 
unusable until an other driver ask the motherboard to activate them.
And for the kbd and mouse these resources are always activated on 
motherboard : the systems that don't support dynamic allocation should 
be able to use them, so with "pnp_can_disable(dev) = 0", we let the 
resources like they were before.
Note also if there weren't activate on boot, the acpi driver couldn't 
find them, because it don't know how to allocate a resource...

>>
>>I don't agree at all :
>>- the pci layer allow you to find the device like pnp layer, then you
>>register resource with request_region or equivalent. Do we need to do
>>the same for all pci drivers?
> 
> 
> While PCI devices can be very flexible i8042 is extremely rigid. Its
> resources are pretty much fixed and will not move. Its IO port region
> is reserved by the kernel right off the bat and is not available to anyone
> including PNP subsystem to ensure that nothing will touch it or bad
> things might happen. 
> 
> 
>>- actually the resources are registered in the kernel, but not in the
>>bios, why some strange bios can allow to use irq 12 to an other device
>>if it isn't used ?
> 
> 
> I think you need to make an effort to make a PCI device use IRQ12
> but the idea is that if you don't have a mouse attached (but you do
> have i8042) and you are short on free interrupts and your HW can
> use IRQ12 for some other stuff let it have it. That is the reqson why
> i8042 requests IRQ only when corresponding port is open. No mouse -
> IRQ is free.
> 
And what happen if you use irq12 for an other stuff and you plug your 
mouse and try to use it. The motherboard hasn't desalocated the irq12 
for mouse, so there will be a big conflict...

> 
>>- Do you save lot's of memory with __init/__initdata ? The pnp code is
>>quite small.
>>
> 
> 
> Well it is not needed one i8042 has been initialized at all so why
> keep it? Even if it saves 1K it is good enough.
> 
well that less that 400 between i8042 with pnp support and without.

And why not "__init" init code, "__devinit" probe, "__devinitdata" 
array, "__exit" exit ?

And if you are sure that hotpluging is not possible for i8042, then you 
could even __init the probe and array since there will be not used 
again, but that more ugly than the pnp_can_disable(dev) hack ;)



regards,


Matthieu
