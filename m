Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318472AbSHUPla>; Wed, 21 Aug 2002 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318488AbSHUPla>; Wed, 21 Aug 2002 11:41:30 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:10656 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S318472AbSHUPl2>; Wed, 21 Aug 2002 11:41:28 -0400
Message-ID: <20020821154535.11432.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Wed, 21 Aug 2002 17:45:35 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Thomas Molina <tmolina@cox.net>
Subject: Race in pagevec code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

the following could explain Ooops reports which
BUG_ON(page->pte.chain != NULL) and possibly others. The kernel I'm
talking about is 2.5.31+akpm-everything.gz but others might be
affected as well:

Summary: Don't try to work with page_count == 0. 
	 Don't hold references to a page that don't count towards
	 the page count.


Processor 1                            Processor 2
refill_inactive grabs a page with      
page_count == 1 from the lru.
                                       __pagevec_release tries to release
					 the same page with page_count == 1
					 and does put_page_test_zero
					 bringing the page_count to 0
					 (No spinlocks involved!)

				       Interrupt or preempt or something
					 else that gives the other processor
					 some time.

refill_inactive calls page_cache_get
bringing the page_count back to 1
(this should ring some alarm bells)

refill_inactive continues all the way
down until it calls __pagevec_release
itself.

__pagevec_release calls put_page_test_zero
bringing the count back to 0

      Both processors succeeded in bringing the page_count to zero,
      i.e. both processors will add the page to their own
      pages_to_free_list.

actually frees the page and reallocates
it to a new process which immediatly
sets page->pte.chain to something useful.

                                          actully frees the page and sees
                                          BUGs on page->pte.chain beeing
					  non zero.
                                            
Depending on what the new process does with the page this may also
explain other Ooopses on one of the BUGs in free_pages_ok as well.
Also it probably isn't necessarily a pagevec only BUG. I think
__page_cache_release has very much the same Problem:

Processor 1                               Processor 2
page_cache_release frees a page
still on a lru list brining the
page count to to 0.
   => Interrupt to make the timeing
      possible

                                          Grabs page from lru list
					  and temporarily increments
					  page_count back to 1.
BUG_ON(page_count(page) != 0)
in __page_cache_release.

I don't have a fix but I think the only real solution is to
increment the page count if a page is on a lru list. After all
this is a reference to the page.

     regards    Christian Ehrhardt

-- 
THAT'S ALL FOLKS!
