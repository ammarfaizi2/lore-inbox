Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUHBFBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUHBFBk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 01:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266258AbUHBFBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 01:01:40 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:272 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S266257AbUHBFBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 01:01:35 -0400
Message-ID: <410DCB45.7060407@kolumbus.fi>
Date: Mon, 02 Aug 2004 08:04:05 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@digitalimplant.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net> <20040718220954.GB31958@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.50.0408012018370.30101-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0408012018370.30101-100000@monsoon.he.net>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 02.08.2004 08:04:31,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 02.08.2004 08:03:23,
	Serialize complete at 02.08.2004 08:03:23
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick Mochel wrote:

>Sorry about the delay; all the conferences are finally over (for now)
>
>On Mon, 19 Jul 2004, Pavel Machek wrote:
>
>  
>
>>Hi!
>>
>>    
>>
>>>+static void calc_order(void)
>>>+{
>>>+	int diff;
>>>+	int order;
>>>+
>>>+	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
>>>+	nr_copy_pages += 1 << order;
>>>+	do {
>>>+		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
>>>+		if (diff) {
>>>+			order += diff;
>>>+			nr_copy_pages += 1 << diff;
>>>+		}
>>>+	} while(diff);
>>>+	pagedir_order = order;
>>>+}
>>>      
>>>
>>This code is "interesting". Perhaps at least comment would be good
>>here?
>>    
>>
>
>Sure, patch below.
>
>
>
>	Pat
>
>diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
>--- a/kernel/power/swsusp.c	2004-08-01 20:18:35 -07:00
>+++ b/kernel/power/swsusp.c	2004-08-01 20:18:35 -07:00
>@@ -659,13 +659,38 @@
> }
>
>
>+/**
>+ *	calc_order - Determine the order of allocation needed for pagedir_save.
>+ *
>+ *	This looks tricky, but is just subtle. Please fix it some time.
>+ *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
>+ *	to allocate enough contiguous space to hold
>+ *		(%nr_copy_pages * sizeof(struct pbe)),
>+ *	which has the saved/orig locations of the page..
>+ *
>+ *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those
>+ *	structures, then we call get_bitmask_order(), which will tell us the
>+ *	last bit set in the number, starting with 1. (If we need 30 pages, that
>+ *	is 0x0000001e in hex. The last bit is the 5th, which is the order we
>+ *	would use to allocate 32 contiguous pages).
>+ *
>+ *	Since we also need to save those pages, we add the number of pages that
>+ *	we need to nr_copy_pages, and in case of an overflow, do the
>+ *	calculation again to update the number of pages needed.
>+ *
>+ *	With this model, we will tend to waste a lot of memory if we just cross
>+ *	an order boundary. Plus, the higher the order of allocation that we try
>+ *	to do, the more likely we are to fail in a low-memory situtation
>+ *	(though	we're unlikely to get this far in such a case, since swsusp
>+ *	requires half of memory to be free anyway).
>+ */
>+
>+
> static void calc_order(void)
> {
>-	int diff;
>-	int order;
>+	int diff = 0;
>+	int order = 0;
>
>-	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
>-	nr_copy_pages += 1 << order;
> 	do {
> 		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
> 		if (diff) {
>@@ -687,7 +712,7 @@
> static int alloc_pagedir(void)
> {
> 	calc_order();
>-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
>+	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
> 							     pagedir_order);
> 	if(!pagedir_save)
> 		return -ENOMEM;
>-
>  
>

Why alloc twice for the saved pages, once in calc_order() and then in 
alloc_image_pages() ?


--Mika



