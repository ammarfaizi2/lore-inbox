Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVHRItb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVHRItb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVHRItb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 04:49:31 -0400
Received: from [85.8.12.41] ([85.8.12.41]:53907 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932127AbVHRItb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 04:49:31 -0400
Message-ID: <43044B7A.6090102@drzeus.cx>
Date: Thu, 18 Aug 2005 10:48:58 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-3 (X11/20050806)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org> <20050818073824.C2365@flint.arm.linux.org.uk> <4304380B.5070406@drzeus.cx> <20050818092321.B3966@flint.arm.linux.org.uk>
In-Reply-To: <20050818092321.B3966@flint.arm.linux.org.uk>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:

>On Thu, Aug 18, 2005 at 09:26:03AM +0200, Pierre Ossman wrote:
>  
>
>>We had this discussion on LKML and Alan Cox' comment on it was that a
>>solution like this would be acceptable, where we try and shove
>>everything out first and then fall back on sector-by-sector to determine
>>where an error occurs. This will only break if the problematic sector
>>keeps shifting around, but at that point the card is probably toast
>>anyway (if the thing keeps moving how can you bad block it?).
>>    
>>
>
>There are two different kinds of error - the ones at the transport
>level which we are able to force a result of "no sectors transferred"
>for.  For all other errors and successful completions, the driver
>reports "all sectors tranferred" since the driver level doesn't know
>that an error occurred.
>
>This causes us to tell the upper levels that we were successful,
>even if we weren't.  Hence the problem.
>
>  
>

I still don't understand where you see the problem. As you said there
are two problems that can occur:

* Transport problem. The driver will report back a CRC error, timeout or
whatnot and break. We might not know how many sectors survived so we try
again, going sector-by-sector. We might get a transfer error again,
possibly even before the previous one. But at this point the transport
is probably so noisy that we have little chans of doing a clean umount
anyway. So when the device gets fixed, either by replaying the journal
or doing a fsck, it would have been in the same state if we would have
been able to tell exactly which sectors got written.

* Media error. If the card fails to write data to flash then it will set
the corresponding bits in the status register. We do not check these ATM
so any errors there will get overlooked. So I fail to see how this would
be different when writing several sectors at once. If we implement this
check we will not know where the card failed its write, but again we
fall back to sector-by-sector in this case to determine exactly where
the card has problems.

Rgds
Pierre

