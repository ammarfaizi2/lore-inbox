Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268244AbTCCBxG>; Sun, 2 Mar 2003 20:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268248AbTCCBxG>; Sun, 2 Mar 2003 20:53:06 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:53452 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268244AbTCCBxE>; Sun, 2 Mar 2003 20:53:04 -0500
Date: Mon, 03 Mar 2003 15:06:14 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: SWSUSP Discontiguous pagedir patch
In-reply-to: <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
To: Patrick Mochel <mochel@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046657173.8669.30.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <Pine.LNX.4.33.0303021731510.1120-100000@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks for your comments. I'll take a look at your rewrite. I'm
currently working on a port of the 2.4 beta, so I'm hoping we're not
going at cross-purposes here. 

> Thank you for putting this back in C, it's much appreciated. 

I know nothing about x86 assembly and have just been following the
existing code, so I can't claim any credit for this. do_magic in
assembly was just a cut and paste from suspend_asm.S so that I could get
things going with the PAGEDIR_ENTRY macro.

> Do you have something against indenting comments? ;)

Cut and paste from the original - not my comment :>

> This is better done as 
> 
> 	for (loop = 0; loop < nr_copy_pagse; loop++) {
> 		memcpy((char *)pagedir_nosave[loop].orig_address,
> 		       (char *)pagedir_nosave[loop].address,
> 		       PAGE_SIZE);
> 		__flush_tlb();
> 	}
> 
> Is __flush_tlb() really necessary? 

Pass. Once again, I'm blindly following the comment that says you can't
use memcpy. All of my changes are algorithm rewrites, not changes to the
'magic'.

> This, and the rest of the deleted patch, are dubious. Once you start
> adding 
> 
> - more page flag bits
> - functions that use double pointers
> 
> big warning alarms start going off I haven't looked that far into it yet,
> but I suspect there are some design issues there that should get resolved.

Longer term, I don't want to add page_flags. A page_flag was just here
because it was the simplest way of getting a working implementation. In
the long term I would use a dynamically allocated bitmap instead.

The double pointers where the true point to the patch. They are
necessary because my aim in future patches is to get 2.5 to the same
point as 2.4. Under 2.4, you can now suspend to disk without needing to
eat any memory (assuming enough swap etc). To achieve this, the pages of
the pagedir must be able to be scattered around memory. With the
existing code, you have to be able to allocate a contiguous set of pages
for the whole pagedir. Take for an example a suspend cycle I did this
morning:

Mar  3 07:45:07 laptop-linux kernel: Free:1343. Sets:7720(7891),21527. PD:170. Swap:29589/53139. RAM to suspend:29930; resume:17459. Limits:30592,0
[deletia]
Mar  3 07:45:07 laptop-linux kernel: - SWSUSP Version : beta 18
Mar  3 07:45:07 laptop-linux kernel: - Swap available : 53139 (amount unused when preparing image).
Mar  3 07:45:07 laptop-linux kernel: - Pageset sizes  : 7891 and 21527. (Pagedir size: 170)
Mar  3 07:45:07 laptop-linux kernel: - Expected sizes : 7891 and 21527.
Mar  3 07:45:07 laptop-linux kernel: - Parameters     : 1 0 255 255 0
Mar  3 07:45:07 laptop-linux kernel: - Calculations   : Image size: 29760. Ram to suspend: 30101. To resume: 17801.
Mar  3 07:45:07 laptop-linux kernel: - Limits         : 30592 pages RAM. Initial boot: 29435. Current boot: 0.

In order to save 29760 pages, I needed a pagedir of 170 pages. Using the
old code, I'd have to allocate 256 contiguous pages. With only 1343
available, what do you think my chances are? With the new functionality,
it's no problem. (I should mention that I've seen a way in which I can
reduce the pagedir size that this code uses - the struct this is using
is different to the one currently in 2.5, and I would keep using the 2.5
version. This might mean we would need 128 pages instead of 256 for the
same image size, but I'm sure you'll appreciate that the argument still
stands).

Regards,

Nigel

