Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVIMP4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVIMP4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 11:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVIMP4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 11:56:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964818AbVIMP4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 11:56:07 -0400
Date: Tue, 13 Sep 2005 08:55:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Adam Kropelin <akropel1@rochester.rr.com>
cc: Norbert Kiesel <nkiesel@tbdnetworks.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
In-Reply-To: <20050913120255.A16713@mail.kroptech.com>
Message-ID: <Pine.LNX.4.58.0509130850550.3351@g5.osdl.org>
References: <20050913120255.A16713@mail.kroptech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Adam Kropelin wrote:
> 
> That made me do some grepping of my own. Nothing obvious, but this bit
> from drivers/scsi/qla2xxx/qla_init.c seems a little odd:
> 
>         uint16_t w, mwi;
> 	...
>         /* Reset expansion ROM address decode enable */
>         pci_read_config_word(ha->pdev, PCI_ROM_ADDRESS, &w);
>         w &= ~PCI_ROM_ADDRESS_ENABLE;
>         pci_write_config_word(ha->pdev, PCI_ROM_ADDRESS, w);
> 
> Is the address register really only 16 bits wide on some hw?

Nope.

_Most_ hardware will "do the right thing" when you do a sub-word write. 
So these things often work (eg, the ROM enable code that used byte writes 
probably worked fine - as long as the high bytes already matched the 
expectations).

But I think the spec says that you should always write a whole dword at a
time for all the dword registers, and some hardware will literally do the
wrong thing if you try to update things a byte at a time. 

So the above probably works fine, especially since it's just disabling the 
ROM (ie we don't end up caring at all about the upper bits even if they 
did get the wrong value). But it's definitely bad practice, and there are 
probably cards (for which that driver is irrelevant, of course ;) where 
doing something like the above might not work at all.

		Linus
