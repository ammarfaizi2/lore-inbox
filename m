Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129428AbQLMW1C>; Wed, 13 Dec 2000 17:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129757AbQLMW0x>; Wed, 13 Dec 2000 17:26:53 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44502 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129428AbQLMW0s> convert rfc822-to-8bit;
	Wed, 13 Dec 2000 17:26:48 -0500
Date: Wed, 13 Dec 2000 16:56:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Henrik Størner <henrik@storner.dk>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: test12: innd bug came back?
In-Reply-To: <918pmt$q9s$1@osiris.storner.dk>
Message-ID: <Pine.GSO.4.21.0012131646070.5045-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Dec 2000, Henrik [ISO-8859-1] Størner wrote:

> Just to add a "me too" on this. I didn't report when I saw it last week,
> because I was uncertain of exactly what might have caused it - I was
> booting several different kernels at the time, including one from a
> rescue disk (I was trying to salvage bits of a Win9x disk at the time -
> don't ask for details!)
> 
> Alas, I lost the test program someone wrote to test for the truncate
> problem, and due to moving I will not be able to test anything until 
> next Monday. But if needed, I can do some testing then. Something 
> definitely went wrong with innd during the test12 pre-patches.

It may be a side effect of removing partial_clear() in test12-final.
Relevant chunk (in mm/memory.c):
@@ -953,10 +914,6 @@
                /* Ok, partially affected.. */
                start += diff << PAGE_SHIFT;
                len = (len - diff) << PAGE_SHIFT;
-               if (start & ~PAGE_MASK) {
-                       partial_clear(mpnt, start);
-                       start = (start + ~PAGE_MASK) & PAGE_MASK;
-               }
                flush_cache_range(mm, start, end);
                zap_page_range(mm, start, len);
                flush_tlb_range(mm, start, end);
should actually be
@@ -954,7 +915,6 @@
                start += diff << PAGE_SHIFT;
                len = (len - diff) << PAGE_SHIFT;
                if (start & ~PAGE_MASK) {
-                       partial_clear(mpnt, start);
                        start = (start + ~PAGE_MASK) & PAGE_MASK;
                }
                flush_cache_range(mm, start, end);

IOW, we have off-by-one when calling zap_page_range() and friends.
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
