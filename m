Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261386AbRE3SIt>; Wed, 30 May 2001 14:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261735AbRE3SI3>; Wed, 30 May 2001 14:08:29 -0400
Received: from haybaler.sackheads.org ([209.133.38.16]:46858 "HELO
	haybaler.sackheads.org") by vger.kernel.org with SMTP
	id <S261386AbRE3SIT>; Wed, 30 May 2001 14:08:19 -0400
Date: Wed, 30 May 2001 11:08:18 -0700
From: Jimmie Mayfield <mayfield+kernel@sackheads.org>
To: linux-kernel@vger.kernel.org
Subject: Athlon fast_copy_page revisited
Message-ID: <20010530110817.A12364@sackheads.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi.  A few weeks ago there was a discussion centering on the Athlon-optimized
fast_copy_page routine and how the prefetch might be causing problems on Via 
motherboards.  Unfortunately Alan's proposed fixes (to not prefetch the final 320 bytes)
don't seem to help...at least on my iWill KT-133A system as recent as 2.4.5-ac1.

Since Alan's code looks like it prevents the possibility of prefetching too much data, 
it seems something else must be the culprit.  Arjan posted a link to a user-space program 
that benchmarks various *_clear_page and *_copy_page schemes.  I spent yesterday evening
playing with this.

On a whim, I added some NOP statements to the even_faster copy_page routine.  Imagine
my surprise when I found that the NOP-modified routine showed the highest
throughput of all the *_copy_page routines, consistently beating the other optimized
routines by sometimes 10% or more (but generally between 2-5%).  On my two Athlon machines 
(both socket-A thunderbirds), I found that I got the best scores if I grouped the MOVQ and 
MOVNTQ operations into sets of 4.

It's interesting to note that I don't run into any problems running any of the *_copy_page
schemes in user-space but if I try in kernel space, I get the notorious crash inside
fast_copy_page.  (If there was some sort of fundamental hardware problem associated with
prefetch or streaming, wouldn't it also show up in user-space?)  Note: I've yet to try the 
NOP-modified routines in kernel-space.

I've tried this benchmark on 4 Athlon/Duron machines now (2 Socket-A Thunderbirds, 1
Socket-A Duron and 1 Slot-A Athlon).  Each of the Socket-A machines showed improvement
using the NOP-modified routines while the Slot-A machine performed better with the original
3DNow routine.

Arjan's original code is at: http://www.fenrus.demon.nl/athlon.c
My modifications are at: http://sackheads.org/~mayfield/jrm_athlon.c

Example test runs:

copy_page() tests 
copy_page function 'warm up run'         took 21350 cycles per page
copy_page function '2.4 non MMX'         took 27706 cycles per page
copy_page function '2.4 MMX fallback'    took 28600 cycles per page
copy_page function '2.4 MMX version'     took 21370 cycles per page
copy_page function 'faster_copy'         took 13119 cycles per page
copy_page function 'even_faster'         took 14767 cycles per page
copy_page function 'jrm_copy_page_8nop'  took 12774 cycles per page
copy_page function 'jrm_copy_page_10nop'         took 12746 cycles per page
copy_page function 'jrm_copy_page_12nop'         took 12740 cycles per page

copy_page() tests 
copy_page function 'warm up run'         took 22499 cycles per page
copy_page function '2.4 non MMX'         took 27769 cycles per page
copy_page function '2.4 MMX fallback'    took 27696 cycles per page
copy_page function '2.4 MMX version'     took 22666 cycles per page
copy_page function 'faster_copy'         took 13058 cycles per page
copy_page function 'even_faster'         took 13169 cycles per page
copy_page function 'jrm_copy_page_8nop'  took 12691 cycles per page
copy_page function 'jrm_copy_page_10nop'         took 12750 cycles per page
copy_page function 'jrm_copy_page_12nop'         took 14786 cycles per page

The values obviously fluctuate depending on system activity but the jrm_* routines were
faster in 13 out of 15 trials.


   - Jimmie

-- 
Jimmie Mayfield  
http://www.sackheads.org/mayfield       email: mayfield+kernel@sackheads.org
My mail provider does not welcome UCE -- http://www.sackheads.org/uce

