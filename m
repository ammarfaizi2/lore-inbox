Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVGZRXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVGZRXr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 13:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVGZRXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 13:23:47 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41914 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261849AbVGZRWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 13:22:43 -0400
Message-ID: <42E6715E.5080308@pobox.com>
Date: Tue, 26 Jul 2005 13:22:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukasz Kosewski <lkosewsk@nit.ca>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Add disk hotswap support to libata
References: <42E0102E.2050603@nit.ca>
In-Reply-To: <42E0102E.2050603@nit.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Kosewski wrote:
> This patch changes the sata_promise driver in libata to correctly mask 
> out hotplug interrupts.  The location of the primary hotplug registers 
> in the SATA150 Tx4/Tx2 Plus controllers is correctly defined as '0x6C', 
> HOWEVER, for the SATAII150 Tx4/Tx2 Plus controllers, this changes to 
> '0x60'.  This patch rectifies us 'masking out interrupts' at the wrong 
> location, thus not masking them out at all.
> 
> Also, the promise interrupt handler uses a 'spin_lock', I have changed 
> it into a 'spin_lock_irqsave', since I observe this on most other libata 
> drivers, so for consistency.

Comments:

1) Interrupt handler should use the much-less-expensive spin_lock(). 
spin_lock_irqsave() is only used where two separate interrupts (legacy 
IDE irqs 14 & 15) could be sharing the same interrupt handler.

2) Don't pass the hotplug register offset as an argument to a function. 
  Add the offset as a member of struct pdc_port_priv.

This eliminates the need to split up the interrupt handler as you have done.

3) Don't comment out ATA_FLAG_SATA, it is a SATA controller :)

	Jeff


P.S.  Watch for the SiI hotplug email I'm about to send, too...
