Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318270AbSHDXUs>; Sun, 4 Aug 2002 19:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318271AbSHDXUs>; Sun, 4 Aug 2002 19:20:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318270AbSHDXUo>;
	Sun, 4 Aug 2002 19:20:44 -0400
Message-ID: <3D4DB9E4.E785184E@zip.com.au>
Date: Sun, 04 Aug 2002 16:33:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I warmed the code up a bit and did some more measurement.
Your locking patch has improved things significantly.  And
we're now getting hurt by all the cache misses walking the
pte chains.

Here are some uniprocessor numbers:

up, 2.5.30+rmap-lock-speedup:

./daniel.sh  28.32s user 42.59s system 90% cpu 1:18.20 total
./daniel.sh  29.25s user 38.62s system 91% cpu 1:14.34 total
./daniel.sh  29.13s user 38.70s system 91% cpu 1:14.50 total

c01cdc88 149      0.965276    strnlen_user            
c01341f4 181      1.17258     __page_add_rmap         
c012d364 195      1.26328     rmqueue                 
c0147680 197      1.27624     __d_lookup              
c010bb28 229      1.48354     timer_interrupt         
c013f3b0 235      1.52242     link_path_walk          
c01122cc 261      1.69085     do_page_fault           
c0111fd0 291      1.8852      pte_alloc_one           
c0124be4 292      1.89168     do_anonymous_page       
c0123478 304      1.96942     clear_page_tables       
c01236c8 369      2.39052     copy_page_range         
c01078dc 520      3.36875     page_fault              
c012b620 552      3.57606     kmem_cache_alloc        
c0124d58 637      4.12672     do_no_page              
c0123960 648      4.19798     zap_pte_range           
c012b80c 686      4.44416     kmem_cache_free         
c0134298 2077     13.4556     __page_remove_rmap      
c0124540 2661     17.2389     do_wp_page              


up, 2.5.26:

./daniel.sh  27.90s user 31.28s system 90% cpu 1:05.25 total
./daniel.sh  31.41s user 35.30s system 100% cpu 1:06.71 total
./daniel.sh  28.54s user 32.01s system 91% cpu 1:06.41 total

c0124f2c 167      1.21155     find_vma                
c0131ea8 183      1.32763     do_page_cache_readahead 
c012c07c 186      1.34939     rmqueue                 
c01c7dc8 192      1.39292     strnlen_user            
c010ba78 210      1.52351     timer_interrupt         
c0144c50 222      1.61056     __d_lookup              
c01120b8 250      1.8137      do_page_fault           
c013cc40 260      1.88624     link_path_walk          
c0122cd0 282      2.04585     clear_page_tables       
c0124128 337      2.44486     do_anonymous_page       
c0122e7c 347      2.51741     copy_page_range         
c0111e50 363      2.63349     pte_alloc_one           
c01c94ac 429      3.1123      radix_tree_lookup       
c01077cc 571      4.14248     page_fault              
c0123070 620      4.49797     zap_pte_range           
c0124280 715      5.18717     do_no_page              
c0123afc 2957     21.4524     do_wp_page              


So the pte_chain stuff seems to be costing 20% system time here.
But note that I made the do_page_cache_readahead and radix_tree_lookup
cost go away in 2.5.29.  So it's more like 30%.

And it's all really in __page_remove_rmap, kmem_cache_alloc/free.

If we convert the pte_chain structure to

struct pte_chain {
	struct pte_chain *next;
	pte_t *ptes[L1_CACHE_BYTES - 4];
};

and take care to keep them compacted we shall reduce the overhead
of both __page_remove_rmap and the slab functions by up to 7, 15
or 31-fold, depending on the L1 size.  page_referenced() wins as well.

Plus we almost halve the memory consumption of the pte_chains
in the high sharing case.  And if we have to kmap these suckers
we reduce the frequency of that by 7x,15x,31x,etc.

I'll code it tomorrow.
