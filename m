Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVIGCBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVIGCBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 22:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVIGCBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 22:01:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46570 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751192AbVIGCBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 22:01:46 -0400
Message-ID: <431E4A04.5030609@pobox.com>
Date: Tue, 06 Sep 2005 22:01:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brett Russ <russb@emc.com>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13] libata: use common pci remove in ahci
References: <20050903071852.95A10271C2@lns1058.lss.emc.com> <431CBDCB.40903@pobox.com> <431DB127.3010809@emc.com>
In-Reply-To: <431DB127.3010809@emc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brett Russ wrote:
> Jeff Garzik wrote:
>> Brett Russ wrote:
>>> 2) Isn't it wrong for the IRQ disable at the chip to occur *after*
>>> free_irq() is called to disconnect the handler (independent of
>>> question 1...since this is the case currently)?  Granted, all of the
>>> ports have gone through scsi_remove_host() but theoretically there
>>> still is a possibility the chip could interrupt.

Answer:  depends on hardware.

For all hardware, the conditions that generate interrupts should be shut 
down, and then free_irq() is called after that.

Some hardware only needs per-port disable, or nothing besides clearing 
any commands, to ensure that interrupts from that hardware are disabled 
(this excludes shared interrupts, of course).

This logic is another reason why a driver author may choose to implement 
their own PCI ->remove() hook, rather than using the generic 
ata_pci_remove_one().  Eliminates the need for a ->host_stop() hook 
implementation, and allows one to perform tasks before calling 
free_irq(), as well as tasks after the call (normal ->host_stop stuff).

	Jeff



