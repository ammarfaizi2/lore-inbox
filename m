Return-Path: <linux-kernel-owner+w=401wt.eu-S1754952AbXABV3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754952AbXABV3H (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbXABV3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:29:06 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46779 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952AbXABV3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:29:05 -0500
Message-ID: <459ACE9C.7020107@pobox.com>
Date: Tue, 02 Jan 2007 16:29:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>,
       Alessandro Suardi <alessandro.suardi@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libata: fix combined mode (was Re: Happy New Year (and
 v2.6.20-rc3 released))
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>	<5a4c581d0701010528y3ba05247nc39f2ef096f84afa@mail.gmail.com>	<Pine.LNX.4.64.0701011209140.4473@woody.osdl.org>	<459973F6.2090201@pobox.com>	<20070102115834.1e7644b2@localhost.localdomain>	<459AC808.1030807@pobox.com> <20070102212701.4b4535cf@localhost.localdomain>
In-Reply-To: <20070102212701.4b4535cf@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
>>> This is a silly complaint because the SFF layer in libata doesn't handle
>>> this case yet anyway.
>> Yes, it's "silly" people people use configurations you find inconvenient.
>>
>> At least one embedded x86 case cares, that I know of.  They only needed 
>> to make two minor changes to make it work.
> 
> *It is not part of 2.6.20*
> 
>> The code no long reserves resources for the "extra" PCI BAR that often 
>> exists on PCI controllers regardless of legacy/native mode.  Previously, 
>> the code called pci_request_regions() to reserve ALL regions attached to 
>> the PCI device.
> 
> We use BAR5 on two devices in legacy mode. Both of those reserve all the
> other resources.

Translation:  You want to hand-wave away an obvious regression that YOU 
have created with your fix-to-a-fix.


> We can fix BAR5 in .21 when all the combined mode crap
> goes away.

Translation:  Problems disappear in 2.6.21 because Jeff will revert the 
code I touched to its previous state -- always calling 
pci_request_regions() -- and all the problems I introduced by avoiding 
pci_request_regions() will go away.

Why INTRODUCE these 2.6.20 Alan-isms, if they are going away in 2.6.21?


>> You have suddenly decided that it's OK to --not reserve at all-- these 
>> additional regions.
> 
> It's not ideal - but it is perfectly sufficient for 2.6.20
> 
>> Proof:  The AHCI PCI BAR (#5, zero-based) is clearly NOT reserved, even 
>> though we talk to it, in piix_disable_ahci() of ata_piix.c.
> 
> We always claim the other BARs so catch a collision.

Where?  AFAICS, it is crystal clear the behavior:

* Prior to your patch, ata_piix in legacy mode calls 
pci_request_regions() to intentionally reserve ALL regions on the PCI 
device.

* After your patch, the code explicitly calls pci_request_region() for 
BARs 0-4, but never for BAR5.

Another driver is now free to claim a PCI BAR, and start running the 
hardware in AHCI mode, whee!

	Jeff



