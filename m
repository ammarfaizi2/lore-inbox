Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSIEM3i>; Thu, 5 Sep 2002 08:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSIEM3i>; Thu, 5 Sep 2002 08:29:38 -0400
Received: from thales.mathematik.uni-ulm.de ([134.60.66.5]:20368 "HELO
	thales.mathematik.uni-ulm.de") by vger.kernel.org with SMTP
	id <S317462AbSIEM3h>; Thu, 5 Sep 2002 08:29:37 -0400
Message-ID: <20020905123413.21580.qmail@thales.mathematik.uni-ulm.de>
From: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Date: Thu, 5 Sep 2002 14:34:13 +0200
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org, Christian Ehrhardt <ulcae@in-ulm.de>
Subject: Re: [RFC] Alternative raceless page free
References: <3D644C70.6D100EA5@zip.com.au> <akdq8h$fqn$1@penguin.transmeta.com> <E17kunE-0003IO-00@starship> <E17moT6-00064X-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17moT6-00064X-00@starship>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 06:42:12AM +0200, Daniel Phillips wrote:
> I have a slight preference for the extra-lru-count version, because of the 
> trylock in page_cache_release.  This means that nobody will have to spin when 
> shrink_cache is active.  Instead, freed pages that collide with the lru lock 
> can just be left on the lru list to be picked up efficiently later.  The 
> trylock also allows the lru lock to be acquired speculatively from interrupt 
> context, without a requirement that lru lock holders disable interrupts.  
> Both versions are provably correct, modulo implementation gaffs.
> 
> The linked patch defaults to atomic_dec_and_lock version.  To change to
> the extra count version, define LRU_PLUS_CACHE as 2 instead of 1.
> 
> Christian, can you please run this one through your race detector?

I don't see a priciple problem with this approach (except that there
may be architectures that don't have cmpxchg or similar). But this hunk

@@ -455,7 +458,7 @@
                        } else {
                                /* failed to drop the buffers so stop here */
                                UnlockPage(page);
-                               page_cache_release(page);
+                               put_page(page);

                                spin_lock(&pagemap_lru_lock);
                                continue;

looks a bit suspicious. put_page is not allowed if the page is still
on the lru and there is no other reference to it. As we don't hold any
locks between UnlockPage and put_page there is no formal guarantee that
the above condition is met. I don't have another path that could race
with this one though and chances are that there actually is none.

    regards   Christian

-- 
THAT'S ALL FOLKS!
