Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbTGBWzr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 18:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbTGBWxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 18:53:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14546 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265514AbTGBWw6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 18:52:58 -0400
Message-ID: <3F0365A0.7040203@pobox.com>
Date: Wed, 02 Jul 2003 19:07:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ICH5 SATA causes high interrupt/system load?
References: <1057087443.3373.4.camel@paragon.slim>	 <3F01F1F5.5050907@pobox.com> <1057169427.3261.14.camel@paragon.slim>
In-Reply-To: <1057169427.3261.14.camel@paragon.slim>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurgen Kramer wrote:
> BTW it seems that all ATA ports have their own interrupt:
> 
>            CPU0       CPU1
>  14:       5062       5316    IO-APIC-edge  ide0
>  15:          1          1    IO-APIC-edge  ide1
>  16:      43464      43565   IO-APIC-level  usb-uhci, usb-uhci, nvidia
>  17:      26180      26194   IO-APIC-level  Intel ICH5
>  18:  119342344  119704504   IO-APIC-level  ide2, usb-uhci

The interrupt count is definitely high.

WRT the interrupt distribution through, the above is normal.  irq 14 and 
15 are the magic legacy IDE interrupts.  Anything other than 14 and 15 
are (usually) standard shareable PCI interrupts.


>  20:08:28  up 19 min,  3 users,  load average: 0.08, 0.06, 0.02
> 75 processes: 74 sleeping, 1 running, 0 zombie, 0 stopped
> CPU0 states:   0.5% user  20.2% system    0.0% nice   0.0% iowait  78.2%
> idle
> CPU1 states:   0.5% user  17.0% system    0.0% nice   0.0% iowait  81.4%
> idle
> Mem:   515128k av,  187396k used,  327732k free,       0k shrd,   13336k
> buff
>         45524k active,             118320k inactive
> Swap:  787176k av,       0k used,  787176k free                   90804k
> cached
> 
> With your patch and in XP a have a nice nullish system load.

Very strange.  My first guess would be that the drivers/ide driver 
appears unfriendly to shared interrupts.  In certain cases the ATA 
protocol does not offer a single, easy "is this interrupt mine?" test; 
the logic has to be implicitly worked into the driver code.  However, 
normally the drivers/ide driver knows what the heck it is doing, so this 
is quite out of the ordinary.

Perhaps you can fiddle with BIOS settings to get ide2 onto an interrupt 
all by itself, and see if the behavior improves.

	Jeff


