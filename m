Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbREYTyS>; Fri, 25 May 2001 15:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbREYTyI>; Fri, 25 May 2001 15:54:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:14099 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261802AbREYTyD>; Fri, 25 May 2001 15:54:03 -0400
Date: Fri, 25 May 2001 16:53:38 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] highmem deadlock removal, balancing & cleanup
Message-ID: <Pine.LNX.4.33.0105251637490.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the following patch does:

1) Remove GFP_BUFFER and HIGHMEM related deadlocks, by letting
   these allocations fail instead of looping forever in
   __alloc_pages() when they cannot make any progress there.

   Now Linux no longer hangs on highmem machines with heavy
   write loads.

2) Clean up the __alloc_pages() / __alloc_pages_limit() code
   a bit, moving the direct reclaim condition from the latter
   function into the former so we run it less often ;)

3) Remove the superfluous wakeups from __alloc_pages(), not
   only are the tests a real CPU eater, they also have the
   potential of waking up bdflush in a situation where it
   shouldn't run in the first place.  The kswapd wakeup didn't
   seem to have any effect either.

4) Do make sure GFP_BUFFER allocations NEVER eat into the
   very last pages of the system. It is important to preserve
   the following ordering:
	- normal allocations
	- GFP_BUFFER
	- atomic allocations
	- other recursive allocations

   Using this ordering, we can be pretty sure that eg. a
   GFP_BUFFER allocation to swap something out to an
   encrypted device won't eat the memory the device driver
   will need to perform its functions. It also means that
   a gigabit network flood won't eat those pages...

5) Change nr_free_buffer_pages() a bit to not return pages
   which cannot be used as buffer pages, this makes a BIG
   difference on highmem machines (which now DO have a working
   write throttling again).

6) Simplify the refill_inactive() loop enough that it actually
   works again. Calling page_launder() and shrink_i/d_memory()
   by the same if condition means that the different caches
   get balanced against each other again.

   The illogical argument for not shrinking the slab cache
   while we're under a free shortage turned out to be very
   much illogical too.  All needed buffer heads will have been
   allocated in page_launder() and shrink_i/d_memory() before
   we get here and we can be pretty sure that these functions
   will keep re-using those same buffer heads as soon as the
   IO finishes.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

