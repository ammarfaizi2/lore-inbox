Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbUKSBlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbUKSBlD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUKSBk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:40:58 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:38845 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S262850AbUKRSmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:42:10 -0500
Message-ID: <419CECFF.2090608@free.fr>
Date: Thu, 18 Nov 2004 19:42:07 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, syrjala@sci.fi, jt@hpl.hp.com
Cc: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had also done a pnp patch for the smsc-ircc2 and irport 3 months ago.
Unfortunaly I don't remember where I put the patches, certainly on the 
laptop that it is in my parent home.

 > On Wed, Nov 17, 2004 at 03:20:47PM -0800, Jean Tourrilhes wrote:
 > > Ville wrote :
 > > > Add PnP support to smsc-ircc2 driver.
 > > > Briefly tested with irdadump on a Dell Inpsiron 7000.
 > >
 > > OnThanks for the patch. I slightly moved you code around, you'll
 > > find my version of your patch on my web page.
 > >
 > > OnNow, a few comments...
 > >
 > > On1) I don't have any SmSC chipset around, so I can't do any
 > > testing. I would appreciate other people to test your patch. Also,
 > > make sure I did not introduce mistakes in my version of the patch.
 >
 > Your version works fine (irdadump works).
 >
 > > On2) I tried to apply the same code to NSC. It did not manage to
 > > read the ressource properly, and therefore the PnP code disabled the
 > > hardware, and I was no longer able to get it running (short of a
 > > reboot of the computer). The nsc-ircc has only one i/o region (dumb
 > > nsc).
 >
try to do an "echo auto > /sys/bus/pnp/device_number/resources"

It will reenable the device.

 > I have a machine with nsc-ircc here so I think I'll try that too.
 >
 > > OnThe issue there is that if a smsc chipset has a valid PnP ID
 > > but somehow the pnp_probe fails to set it up, then the regular probe
 > > won't be able to configure it. This makes me nervous.
 > >
Yes that's the problem this pnp, if the probe failed it disable the 
device resource.
When I do my patch I encounter the problem : I called pnp driver after 
smsc_ircc_look_for_chips, so all the resources where already reserved, 
and the pnp probe failed and it disable the resource, and the device 
found with the traditional smsc_ircc_look_for_chips doesn't work.

So in my patch if I register pnp devices, I don't run 
smsc_ircc_look_for_chips like it is done for (ircc_fir>0)&&(ircc_sir>0) 
case.



 > > On3) If the ressources are markes as disabled, you just quit
 > > with an error. Compouded with (2), this makes me doubly
 > > nervous. Wouldn't it be possible to forcefully enable those 
ressources ?
pnp should call automatiquely pnp_activate_dev() before probing the 
driver, so the resource should be activated. Have you got an example 
where the resource wheren't activated ?

 > > OnThe idea there is that more and more IrDA devices are comming
 > > disabled in BIOS with no BIOS entry to enable them. Enabling those
 > > ressources would fix that and possible make smc-init redundant (I 
wish).
 >
 > pnp_activate_dev() should probably be used to enable the device but 
it was
 > only used by ISAPNP drivers so I didn't use it in this patch.
 >
 > I must admit that I really don't know much about the PNP subsystem. I
 > used the parport_pc driver as a guide. I've CC'd Adam Belay and
 > linux-kernel in the hopes that someone can help with this stuff.
