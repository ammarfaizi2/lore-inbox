Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUKSVTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUKSVTE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUKSVTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:19:04 -0500
Received: from motgate6.mot.com ([144.189.100.106]:48601 "EHLO
	motgate6.mot.com") by vger.kernel.org with ESMTP id S261353AbUKSVS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:18:57 -0500
In-Reply-To: <1100820391.25521.14.camel@gaston>
References: <069B6F33-341C-11D9-9652-000393DBC2E8@freescale.com> <9B0D9272-398A-11D9-96F6-000393C30512@freescale.com> <1100820391.25521.14.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <97DA0EF0-3A70-11D9-B023-000393C30512@freescale.com>
Content-Transfer-Encoding: 7bit
Cc: <netdev@oss.sgi.com>, Linux Kernel list <linux-kernel@vger.kernel.org>,
       <jason.mcmullan@timesys.com>, Andy Fleming <AFLEMING@motorola.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] MII bus API for PHY devices
Date: Fri, 19 Nov 2004 15:18:44 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 18, 2004, at 17:26, Benjamin Herrenschmidt wrote:

> On Thu, 2004-11-18 at 11:52 -0600, Andy Fleming wrote:
>
>> 1) How should we pass initialization information from the system to 
>> the
>> bus.  Information like which irq to use for each PHY, and what the
>> address space for the bus's controls is.  I would like to enforce
>> encapsulation so that the ethernet drivers don't need to know this
>> information, or pass it to the bus.
>
> Unfortunately, this is all quite platform specific and the ethernet
> driver may be the only one to know what to do here... add to that
> various special cases of the way the PHY is wired or controlled, I 
> think
> we can't completely avoid special casing...

Well, under the system I'm currently envisioning, the driver would be 
able to provide the data needed by the mii bus, but the hope would be 
to enable board files (for when the PHY is soldered on the motherboard, 
and the enet is not -- like on an MPC85xx) to provide this information 
instead, and leave out the enet as middleman.

>
>> 2) How should we reflect the dependency of the ethernet driver on the
>> mii bus driver?
>
> The ethernet driver can instanciate the PHYs at it's childs, though the
> case of several MACs sharing PHYs will be difficult to represent...

I really don't want the driver to intantiate PHYs directly.  The PHY is 
its own device, and the less net drivers have to understand their inner 
workings, the better.  However, I hadn't considered the possibility of 
multiple MACs sharing the same PHY.  It does, as you say, support my 
argument, though.  With some careful design, the mii bus should be able 
to handle this type of setup easily.

One of my goals, personally, is to allow multiple net drivers to share 
the same mii bus, as in the case of the FCC enet controllers' PHYs on 
an 8560 ADS, which can be accessed through TSEC1's MII Management bus.


>
>> 3) How should we bind ethernet drivers to PHY drivers?
>
> I would have them instanciated by the ethernet driver. Besides, the PHY
> driver will need to be able to identify it's "parent" driver in some
> ways to deal with special cases. It would be nice to have a library of
> utility code to independently deal with link tracking (basically what
> drivers like sungem do independently), with a callback to the ethernet
> driver to inform it of actual changes (notifier ?). MACs often have
> autopoll features and PHY often have interrupts, but from experience,
> that's not very useful and a good old timer based polling tend to do a
> better job most of the time.

So when you say instantiated, would you consider calling an "attach" 
function with the phy_id and bus_id of the desired PHY instantiation?  
I'm fine with that.  The PHY would need to be able to send 
notifications to the enet controller (currently done through a 
callback).  I'm interested in ideas on how the notifier could be used 
(I have a distaste for callbacks).

Autopoll features sound pretty neat.  I think the system should support 
that.  PHY interrupts are supported (they work quite well on my 85xx 
system), as is timer-based polling.  Do you really think that there are 
special cases which can't be handled using a library similar to the 
sungem_phy one?
>
>> Oh, and a 4th side-issue:
>> Should each PHY have its own file?  Or should we dump all the PHY
>> drivers in one file?  And if so, should THAT file be separate from the
>> mii bus implementation file?
>
> I'd put all bcm5xxx in the same file ... they can be put together by
> families...

Yeah, that sounds good.


Andy Fleming
Open Source Team
Freescale Semiconductor, Inc

