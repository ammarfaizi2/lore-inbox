Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSHCFMO>; Sat, 3 Aug 2002 01:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSHCFMO>; Sat, 3 Aug 2002 01:12:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31504 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317482AbSHCFMG>;
	Sat, 3 Aug 2002 01:12:06 -0400
Message-ID: <3D4B692B.46817AD0@zip.com.au>
Date: Fri, 02 Aug 2002 22:24:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <3D4AE995.DFD862EF@zip.com.au> <E17aptH-0008DR-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No joy, I'm afraid.

2.5.26:

./daniel.sh  39.78s user 71.72s system 368% cpu 30.260 total
quad:/home/akpm> time ./daniel.sh
./daniel.sh  38.45s user 70.00s system 365% cpu 29.642 total

c0132b0c 328      1.03288     free_page_and_swap_cache 
c013074c 334      1.05177     lru_cache_add           
c0112a64 428      1.34778     do_page_fault           
c0144e90 434      1.36667     link_path_walk          
c01388b4 458      1.44225     do_page_cache_readahead 
c01263e0 468      1.47374     clear_page_tables       
c01319b0 479      1.50838     __free_pages_ok         
c01e0700 514      1.61859     radix_tree_lookup       
c012a8a8 605      1.90515     find_get_page           
c01079f8 640      2.01537     page_fault              
c01127d4 649      2.04371     pte_alloc_one           
c0131ca0 811      2.55385     rmqueue                 
c0127cc8 1152     3.62766     do_anonymous_page       
c013230c 1421     4.47474     page_cache_release      
c0126880 1544     4.86207     zap_pte_range           
c012662c 1775     5.58949     copy_page_range         
c0127e70 1789     5.63358     do_no_page              
c012750c 6860     21.6022     do_wp_page              

Stock 2.5.30:

./daniel.sh  36.60s user 88.23s system 366% cpu 34.029 total
quad:/home/akpm> time ./daniel.sh
./daniel.sh  37.22s user 87.88s system 354% cpu 35.288 total

c014fdc4 191      0.872943    __d_lookup              
c01310c0 203      0.927788    kmem_cache_alloc_batch  
c0114154 227      1.03748     do_page_fault           
c0146ea8 243      1.1106      link_path_walk          
c0132fd0 257      1.17459     __free_pages_ok         
c0134284 279      1.27514     free_page_and_swap_cache 
c0131538 309      1.41225     kmem_cache_free         
c0107c90 320      1.46252     page_fault              
c012ca48 326      1.48995     find_get_page           
c012a220 349      1.59506     handle_mm_fault         
c0128520 360      1.64534     clear_page_tables       
c0113ed0 367      1.67733     pte_alloc_one           
c013129c 399      1.82358     kmem_cache_alloc        
c01332bc 453      2.07038     rmqueue                 
c0129df4 557      2.5457      do_anonymous_page       
c013392c 689      3.14899     page_cache_release      
c0128a60 832      3.80256     zap_pte_range           
c0129fa0 893      4.08135     do_no_page              
c0128828 1081     4.94059     copy_page_range         
c013aa74 1276     5.83181     page_add_rmap           
c013ab3c 3094     14.1408     page_remove_rmap        
c01296a8 3466     15.841      do_wp_page              

2.5.30+pagemap_lru_lock stuff

quad:/home/akpm> time ./daniel.sh
./daniel.sh  41.01s user 97.15s system 373% cpu 36.996 total
quad:/home/akpm> time ./daniel.sh
./daniel.sh  36.67s user 87.04s system 368% cpu 33.575 total                    

c0131d60 230      1.08979     kmem_cache_alloc_batch  
c0148728 231      1.09453     link_path_walk          
c01321d8 238      1.12769     kmem_cache_free         
c01142b4 240      1.13717     do_page_fault           
c0135624 291      1.37882     free_page_and_swap_cache 
c012a8cc 323      1.53044     handle_mm_fault         
c0128790 326      1.54466     clear_page_tables       
c0107c90 338      1.60152     page_fault              
c0131f3c 350      1.65837     kmem_cache_alloc        
c0113f20 373      1.76735     pte_alloc_one           
c012d2a8 397      1.88107     find_get_page           
c013466c 415      1.96636     rmqueue                 
c0132f74 449      2.12746     __pagevec_release       
c012a3bc 532      2.52073     do_anonymous_page       
c012a5b0 772      3.6579      do_no_page              
c0128da0 854      4.04643     zap_pte_range           
c0128b48 1031     4.8851      copy_page_range         
c013c054 1244     5.89434     page_add_rmap           
c013c11c 3088     14.6316     page_remove_rmap        
c0129b58 3206     15.1907     do_wp_page              

2.5.30+pagemap_lru_lock+this patch:

quad:/home/akpm> time ./daniel.sh
./daniel.sh  38.78s user 91.56s system 366% cpu 35.534 total
quad:/home/akpm> time ./daniel.sh
./daniel.sh  38.07s user 88.64s system 363% cpu 34.883 total

c0135a90 332      1.30853     free_page_and_swap_cache 
c013c57c 332      1.30853     page_add_rmap           
c012ad4d 337      1.32824     .text.lock.memory       
c0132448 353      1.3913      kmem_cache_free         
c0128790 372      1.46618     clear_page_tables       
c0107c90 377      1.48589     page_fault              
c01142b4 423      1.66719     do_page_fault           
c0113f20 432      1.70266     pte_alloc_one           
c012d518 438      1.72631     find_get_page           
c013c91c 438      1.72631     .text.lock.rmap         
c01321ac 443      1.74602     kmem_cache_alloc        
c012aafc 453      1.78543     handle_mm_fault         
c01349fc 463      1.82485     rmqueue                 
c012a5ec 655      2.58159     do_anonymous_page       
c01331e4 748      2.94813     __pagevec_release       
c012a7e0 992      3.90982     do_no_page              
c0128e90 1426     5.62037     zap_pte_range           
c0128b48 1586     6.25099     copy_page_range         
c013c5c8 2324     9.1597      __page_remove_rmap      
c0129d88 4028     15.8758     do_wp_page              

- page_add_rmap has vanished
- page_remove_rmap has halved (80% of the remaining is the
  list walk)
- we've moved the cost into the new locking site, zap_pte_range
  and copy_page_range.

So rmap locking is still a 15% slowdown on my soggy quad, which generally
seems relatively immune to locking costs.  PPC will like the change
because spinlocks are better than bitops.   ia32 should have liked it
for the same reason but, as I say, this machine doesn't seem to have
the bandwidth*latency to be affected much by these things.

On more modern machines and other architectures this remains
a significant problem for rmap, I expect.

Guess we should instrument it up and make sure that the hashing
and index thing is getting the right locality.  I saw UML-for-2.5.30
whizz past, if you have time ;)

Broken out patches are at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.30/
Rolled-up patch is at
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.30/everything.gz
