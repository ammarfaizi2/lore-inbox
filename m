Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131340AbQKUUXg>; Tue, 21 Nov 2000 15:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131339AbQKUUXQ>; Tue, 21 Nov 2000 15:23:16 -0500
Received: from d12lmsgate-2.de.ibm.com ([195.212.91.200]:25491 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id <S131017AbQKUUXJ> convert rfc822-to-8bit; Tue, 21 Nov 2000 15:23:09 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: andrea@suse.de, riel@conectiva.com.br, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Message-ID: <C125699E.006D332D.00@d12mta07.de.ibm.com>
Date: Tue, 21 Nov 2000 20:55:27 +0100
Subject: Re: Memory management bug
Mime-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>Agreed, that's almost sure _not_ random memory corruption of the page
>structure. It looks like a VM bug (if you can reproduce trivially I'd give
a
>try to test8 too since test8 is rock solid for me while test10 lockups in
VM
>core at the second bonnie if using emulated highmem).
I was lucky. Somehow I managed to f**k up my disk in a way that the
filesystem
check triggers the bug in a reproducible way and always with the same page!
I setup a "trace store into" to the page structure and logged who is
changing
the "struct page". Here is the log starting after page->mapping was set:

address changed   function
5c13a   mapping   add_to_page_cache_unique
                     count=2, flags=PG_locked, age=2
5b14a   next_hash __add_page_to_hash_queue
5b178   buffers   __add_page_to_hash_queue
68440   flags     lru_cache_add
                     flags=PG_active|PG_locked
6846a   lru       lru_cache_add
68470   lru       lru_cache_add
78fc6   virtual   create_empty_buffers
78fda   count     create_empty_buffers
                     count=3
6d9ce   count     __free_pages
                     count=2
5c122   list      __add_page_to_hash_queue
68464   lru       lru_cache_add
77b16   flags     end_buffer_io_async
                     flags=PG_active|PG_uptodate|PG_locked
77b52   flags     end_buffer_io_async
                     flags=PG_active|PG_uptodate|PG_locked
77bc4   flags     end_buffer_io_async
                     flags=PG_active|PG_uptodate
67792   age       age_page_up
                     age=5
5c88c   count     __find_get_page
                     count=3
559be   count     copy_page_range
                     count=4
559be   count     copy_page_rage
                     count=5
6d9ce   count     __free_pages
                     count=4
6b55e   lru       refill_inactive_scan
6b4ac   flags     refill_inactive_scan
                     flags=PG_active|PG_uptodate
6770c   age       age_page_down_ageonly
                     age=2
6b570   lru       refill_inactive_scan
6b576   lru       refill_inactive_scan
6b56a   lru       refill_inactive_scan
6b55e   lru       refill_inactive_scan
6b4ac   flags     refill_inactive_scan
                     flags=PG_active|PG_uptodate
6770c   age       age_page_down_ageonly
                     age=1
6b570   lru       refill_inactive_scan
6b576   lru       refill_inactive_scan
6b56a   lru       refill_inactive_scan
6b55e   lru       refill_inactive_scan
6b4ac   flags     refill_inactive_scan
                     flags=PG_active|PG_uptodate
6770c   age       age_page_down_ageonly
                     age=0
6b570   lru       refill_inactive_scan
6b576   lru       refill_inactive_scan
6b56a   lru       refill_inactive_scan

program check at 6e1e0 because of BUG() in line 60 of swap_state.c.
Stack backtrace from there:
6e1e0 add_to_swap_cache
6900a try_to_swap_out
69408 swap_out_vma
69578 swap_out_mm
69838 swap_out
6b90a refill_inactive
6bab4 do_try_to_free_pages
6bbba kswapd

age_page_down_ageonly was always called from refill_inactive_scan. So
refill_inactive_scan lowers the age of the pages but does not deactivate
the
page when it reached age==0 (page->count to big). try_to_swap_out doesn't
check for page->mapping and tries to swap out the page because the age is
0. Bang!

blue skies,
   Martin

P.S. by the way this test was done on linux-2.4.0-test11

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
