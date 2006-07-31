Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWGaRhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWGaRhH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWGaRhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:37:07 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:9093 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1030284AbWGaRhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:37:05 -0400
Message-ID: <44CE3FC0.6080500@drzeus.cx>
Date: Mon, 31 Jul 2006 19:37:04 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060731151141.45469.qmail@web36702.mail.mud.yahoo.com>
In-Reply-To: <20060731151141.45469.qmail@web36702.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Dubov wrote:
> It appears that any socket can hold any card type. So
> the logic goes as following:
> 1. Get insertion interrupt on socket
> 2. Detect card type
> 3. Stick proper handler to the socket
> ...do work
> 4. Get removal interrupt on socket
> 5. Ditch type-specific handler, mark socket as empty
> A quick example: on 8033 sd cards are most often wired
> to socket 3, while on 803b they are wired to socket 1.
>
>   

Ah, ok, I see. The socket structure would then be similar to a device
structure in the kernel. Perhaps you should use the name "host" instead
of "card" then as that is widely used in the other mmc host drivers. It
makes it easier when reviewing your future patches.

> I'm afraid you'll have to clarify this issue further.
> Consider the following: TI uses look up table to set
> command type register. The decoding of this table is
> my tifm_sd_op_flags. Its output directly sent to
> hardware. Can you notice any bit patterns here:
> Response type (4b):
> R1 - 1     R1b - 9 (so highest 1 is MMC_RSP_BUSY)
> R2 - 2     R3 - 3      R6 - 6
> (if bit 1 is MMC_RSP_136 why it is set for R3 and R6;
> and if it's MMC_RSP_CRC why it is not set for R1?)
>   

Some controllers are brain dead like this, which makes forward
compatibility a bit difficult. I just wanted to make sure as some
previous drivers have added this artificial restriction in just the
software.

I would still like it to bail out on an unknown type though as anything
else can generate really unpredictable and annoying bugs.

> Command type (2b):
> BC - 0 (implied)   BCR  - 1
> AC - 2             ADTC - 3 
> (even if higher bit stands for "addressed vs
> broadcast" it still doesn't make sense for lower bit).
>   

These are more functional in nature, and therefore exactly how things
should work.

> By the way, if I recall correctly, SD spec does not
> splits command types and responses into components. It
> always speaks of R1s and R6s and so on.
>
>   

The SD spec is focused on cards, not controllers. If you check their
controller spec (sdhci), you'll see that they've split it up.

> It's not hard to figure out bits that are used
> systematically. The problem is that there are 4 or 5
> registers that are set to some constant at
> initialization. I made all kinds of trials with them
> and got no conclusive idea on their meaning.
>
>   

That's all one can expect. :)

You could put some comments about the registers somewhere so that other
people working on the driver will now what you've already tested.
Reverse engineered drivers are usually difficult for others to get into,
so everything you document will increase the changes of more people
helping you out.

Rgds
Pierre

