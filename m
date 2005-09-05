Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVIEVvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVIEVvP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 17:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVIEVvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 17:51:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37604 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964793AbVIEVvM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 17:51:12 -0400
Message-ID: <431CBDCB.40903@pobox.com>
Date: Mon, 05 Sep 2005 17:51:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: use common pci remove in ahci
References: <20050903071852.95A10271C2@lns1058.lss.emc.com>
In-Reply-To: <20050903071852.95A10271C2@lns1058.lss.emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Jeff,
> 
> This looked prime to cut since ahci_remove_one() was a functionally
> identical to ata_pci_remove_one() except for the interrupt disable
> (have_msi) bits, which fit nicely into ahci_host_stop().  However,
> 
> 1) Will it work?
> 
> 2) Isn't it wrong for the IRQ disable at the chip to occur *after*
> free_irq() is called to disconnect the handler (independent of
> question 1...since this is the case currently)?  Granted, all of the
> ports have gone through scsi_remove_host() but theoretically there
> still is a possibility the chip could interrupt.
> 
> If I'm wrong on both counts I'll blame it on need for sleep... :-)


Moving AHCI away from ata_pci_remove_one() was actually intentional. 
This gives the driver a bit more freedom:  legacy region handling and 
->host_stop() became unnecessary.  Also, I was concerned that 
ata_pci_remove_one() might grow into a one-size-fits-all unmaintainable 
behemoth.

Short term, if one were being obsessive, a potential cleanup could be to 
make common the two loops in ahci_remove_one()/ata_pci_remove_one().

Long term, libata driver API should become more like the 
register_foo()/unregister_foo() interfaces you see elsewhere in the 
kernel.  That direction has the potential to shake up the current code 
path through ata_pci_remove_one().

So... your patch, while technically correct, is going in the opposite 
direction to where I want to go :)

	Jeff


