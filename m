Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267642AbUHPNbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267642AbUHPNbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 09:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUHPNas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 09:30:48 -0400
Received: from emulex.emulex.com ([138.239.112.1]:60583 "EHLO
	emulex.emulex.com") by vger.kernel.org with ESMTP id S267624AbUHPNa3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 09:30:29 -0400
From: James.Smart@Emulex.Com
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] SCSI midlayer power management
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Date: Mon, 16 Aug 2004 09:29:43 -0400
Message-ID: <0B1E13B586976742A7599D71A6AC733C02F15C@xbl3.ma.emulex.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] SCSI midlayer power management
Thread-Index: AcSArmZ5VmoXemt/RIm1dQ4GKCWBJgC4v/gw
To: <pavel@suse.cz>, <James.Bottomley@SteelEye.com>
Cc: <benh@kernel.crashing.org>, <nbryant@optonline.net>,
       <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <jgarzik@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Glad to see where this thread ended up...

Suspend, for scsi hosts, essentially has to end up being an unattach. You can't make assumptions on DMA use, etc based on just quiescing host i/o flow or no target for multi-initiators. There's too much variance in adapters design that depend on adapter-pull functionality - rings, ring pointers, host-based contexts, host-based firmware (scripts), and so on. There's also lots of potential asynchronous traffic that can occur outside of just host-requested io : for FC, there's ELS/BLS's; for iSCSI there's non-io PDU's (NOPs, AENs). Posted buffers to the adapter must be killed, and so on.  Ultimately, the scsi class drivers must quiesce the devices, then the LLDD's must "suspend", essentially saving software state and resetting hardware.

For Resume, given that the MMIO state isn't restored, and given the above argument of "detach" on suspend - the LLDD must essentially restart the hardware, reprogramming dma addresses, reposting buffers, reinstantiating contexts, etc.  As indicated, easier on some hardware, harder on others.

So, as Pavel indicates - powermanagement for the LLDD should look very similar to rmmod/insmod. The question usually comes down to whether the overhead of a suspend/resume, where the driver has to participate to save/restore software state, is worth the extra complexity vs. whether you are better off just having the LLDD fully detach/reattach. Latter usually wins as it supports hot-plug well, and moves the complexities out of each driver and into the infrastructure.

-- James S


> -----Original Message-----
> From: linux-scsi-owner@vger.kernel.org
> [mailto:linux-scsi-owner@vger.kernel.org]On Behalf Of Pavel Machek
> Sent: Thursday, August 12, 2004 4:49 PM
> To: James Bottomley
> Cc: Benjamin Herrenschmidt; Nathan Bryant; Linux SCSI Reflector; Linux
> Kernel list; Jeff Garzik
> Subject: Re: [PATCH] SCSI midlayer power management
> 
> 
> Hi!
> 
> > > Can't you simply reuse bootup code? It will no longer be __init,
> > > but it should make suspend/resume functions quite simple.
> > 
> > Unfortunately, no that simply.
> > 
> > Bootup is all about allocating these areas and initialising 
> the card. 
> > Resume will be about initialising the card knowing the 
> existing areas
> > (and the data about the existing areas will have to be part of our
> > persistent data on suspend).
> 
> You can simply free those areas during suspend, so that resume will be
> same as powerup....
> 
> Essentially if you can do insmod and rmmod, you can "simply" emulate
> rmmod during suspend and emulate "insmod" during resume...
> 
> > > > to pick three drivers to do this for, that would be 
> aic7xxx, aic79xx and
> > > > sym_2?
> > > 
> > > No idea, only SCSI host I owned was some 8-bit isa thing....
> > 
> > Well, someone who's interested needs to pick a driver.  It's usually
> > easier to persuade everyone to add the feature if there's 
> an example to
> > copy...
> 
> Make it aic7xxx then... Someone already worked on that one.
> 
> 								
> 	Pavel
> -- 
> People were complaining that M$ turns users into beta-testers...
> ...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
