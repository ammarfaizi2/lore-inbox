Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVALWVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVALWVS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:21:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVALWSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:18:55 -0500
Received: from tim.rpsys.net ([194.106.48.114]:59044 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261486AbVALWHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:07:38 -0500
Message-ID: <023c01c4f8f3$1d497030$0f01a8c0@max>
From: "Richard Purdie" <rpurdie@rpsys.net>
To: "Russell King" <rmk+lkml@arm.linux.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Ian Molton" <spyro@f2s.com>
References: <021901c4f8eb$1e9cc4d0$0f01a8c0@max> <20050112214345.D17131@flint.arm.linux.org.uk>
Subject: Re: MMC Driver RFC
Date: Wed, 12 Jan 2005 22:07:26 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King:
>> The PXA code calls mmc_detect_change() whenever an interrupt is detected.
>> The MMC core then does a schedule_work(&host->detect). The problem is 
>> that
>> when the interrupt is generated, the card may not be 100% inserted or 
>> 100%
>> removed. Given the mechanical nature of insertions and removals, 
>> electrical
>> contact is possible for a while after removal has been started (and a 
>> while
>> before insertion is complete).
>
> If your socket works like that, you need to handle that by using a timer
> yourself.  It normally only affects removal rather than insertion.

It has only shown up on removal events *so far*. I know that the interrupt 
triggers before the card is fully seated in the slot upon insertion on this 
device as well and I'd imagine it does so on other devices given the 
physical design of the cards. Initalisation whilst the electrical contacts 
are still moving can't be a wise idea even if it hasn't bitten anyone yet.

I'm therefore asking if there is a general case for waiting a short while 
after any card insertion/removal event?

If not, I will just have to delay the interrupt on my hardware as you 
suggest. (A user isn't going to notice 0.25s delay in the grand scheme of 
things...). I suspect I'll not be the last person to have problems with this 
though.

>> 2. Card Initialisation Problems
>
> Different cards behave differently.  I suspect you have yet another
> quirky card.

What is the policy on handling this? Pin the error down, then see what can 
be done about it? I'll just have to move delays about until I find the one 
that helps guess.

I was wondering if there was some kind of timing specification somewhere as 
all these cards seem to work fine under other operating systems...

>> I suspect this is related to the 1ms wait that was added to mmc_setup() 
>> as
>> per comments. Is there any documentation which tells us exactly what 
>> timings
>> we should be aiming for here? Has anyone else has problems like this?
>
> There isn't any 1ms wait in mmc_setup().

I was referrng to the 1ms delay in mmc_idle_cards() which is called twice by 
mmc_setup(). There is a comment about it in mmc_setup(): "We wait 1ms to 
give cards time to respond.". Was this just derived from experimentation?

> People are nervous about SD support - the SD forum has been traditionally
> rather closed, and there is the perception that a SD card driver may not
> go down well.  I have even heard rumours of patent issues/IP issues in
> this area, and I don't wish to get stung.
>
> However, that said, the situation has improved recently - we've gone from
> no documentation to limited documentation.  However, this documentation
> still isn't sufficient to do the job - eg, the SD formats for the CID
> and CSD registers remain completely undocumented.

Looking at the code from hh.org, it could be (and probably has been) derived 
from the documentation available so I can't see a patent/IP problem although 
I understand the concern. I agree that lack of info about the formatting of 
CID and CSD registers is an issue although the hh.org code does seem to 
work. Is guessing what the values mean an IP/patent infringement?...

Richard 

