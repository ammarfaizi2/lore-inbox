Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbUKRTxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUKRTxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUKRTwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:52:08 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:52628 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S262948AbUKRTtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:49:53 -0500
Message-ID: <419CFCDE.6090400@free.fr>
Date: Thu, 18 Nov 2004 20:49:50 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: jt@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, syrjala@sci.fi,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
References: <419CECFF.2090608@free.fr> <20041118185503.GA5584@bougret.hpl.hp.com>
In-Reply-To: <20041118185503.GA5584@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Thu, Nov 18, 2004 at 07:42:07PM +0100, matthieu castet wrote:
> 
>>Hi,
>>
>>I had also done a pnp patch for the smsc-ircc2 and irport 3 months ago.
>>Unfortunaly I don't remember where I put the patches, certainly on the 
>>laptop that it is in my parent home.
> 
> 
> 	I've never seen you patches on the irda mailing list...
> 
> 
When I wanted to send them, I didn't find them, and after that I forgot 
them...

if you are still interested for the irport, I could try to ask someone 
to send it to me.
>>>I have a machine with nsc-ircc here so I think I'll try that too.
>>>
>>>
>>>>OnThe issue there is that if a smsc chipset has a valid PnP ID
>>>>but somehow the pnp_probe fails to set it up, then the regular probe
>>>>won't be able to configure it. This makes me nervous.
>>>>
>>
>>Yes that's the problem this pnp, if the probe failed it disable the 
>>device resource.
>>When I do my patch I encounter the problem : I called pnp driver after 
>>smsc_ircc_look_for_chips, so all the resources where already reserved, 
>>and the pnp probe failed and it disable the resource, and the device 
>>found with the traditional smsc_ircc_look_for_chips doesn't work.
>>
>>So in my patch if I register pnp devices, I don't run 
>>smsc_ircc_look_for_chips like it is done for (ircc_fir>0)&&(ircc_sir>0) 
>>case.
> 
> 
> 	smsc_ircc_look_for_chips won't re-register the devices
> configured via PnP, as smsc_ircc_present won't be able to request the
> region. So, I don't see the problem. And you could imagine having
> multiple SMSC in the box, some PnP, some not.
Yes, it was just because it produce some warning message.
> 	Note that we could put the region check earlier, but I like
> the fact that the driver is still able to probe completely the chip
> even if the serial driver has grabbed the regions. Maybe we could
> split the difference and request the FIR region early on (so to fail
> on SMC devices already registered) and request the other ressources
> late (so as to completely probe even when serial is loaded).
> 
> 
>>>>On3) If the ressources are markes as disabled, you just quit
>>>>with an error. Compouded with (2), this makes me doubly
>>>>nervous. Wouldn't it be possible to forcefully enable those 
>>
>>ressources ?
>>pnp should call automatiquely pnp_activate_dev() before probing the 
>>driver, so the resource should be activated. Have you got an example 
>>where the resource wheren't activated ?
> 
> 
> 	No, it was more that I don't understand what PnP does for
> us. I don't have a SMS chipset to test on. Also, I would like to know
> if it remove the need of smcinit.
> 
PnP is easy to understand ;)
When you probe a device, it will activate a device with the best 
configuration available.
When removing a device it will disable the resource of the device.
A driver could play a little with the resources configuration : try 
another configuration, but it is not really need.

Also PnP can provide several id for a device : for example for my smsc 
device, I have SMCf010 and PNP0510 or PNP0511. So in this case we should 
load the smsc driver first, otherwise for example a pnp version of 
irport could register the device and it is not available for smsc (PnP 
will see that there is a driver attached, and not give it to the smsc 
probe).


> 	Thanks, have fun...
> 
> 	Jean
> 
> 

Matthieu
