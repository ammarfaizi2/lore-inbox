Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318031AbSHDAbg>; Sat, 3 Aug 2002 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318033AbSHDAbf>; Sat, 3 Aug 2002 20:31:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52754 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318031AbSHDAbe>;
	Sat, 3 Aug 2002 20:31:34 -0400
Message-ID: <3D4C78F0.5793D6B3@zip.com.au>
Date: Sat, 03 Aug 2002 17:44:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rmap speedup
References: <E17aiJv-0007cr-00@starship> <E17b3sE-0001T4-00@starship> <3D4C4DD9.779C057B@zip.com.au> <E17b8Rk-0003iQ-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Saturday 03 August 2002 23:40, Andrew Morton wrote:
> > Running the same test on 2.4:
> >
> > 2.4.19-pre7:
> >       ./daniel.sh  35.12s user 65.96s system 363% cpu 27.814 total
> >       ./daniel.sh  35.95s user 64.77s system 362% cpu 27.763 total
> >       ./daniel.sh  34.99s user 66.46s system 364% cpu 27.861 total
> >
> > 2.4.19-pre7+rmap:
> >       ./daniel.sh  36.20s user 106.80s system 363% cpu 39.316 total
> >       ./daniel.sh  38.76s user 118.69s system 399% cpu 39.405 total
> >       ./daniel.sh  35.47s user 106.90s system 364% cpu 39.062 total
> >
> > 2.4.19-pre7+rmap-13b+your patch:
> >       ./daniel.sh  33.72s user 97.20s system 364% cpu 35.904 total
> >       ./daniel.sh  35.18s user 94.48s system 363% cpu 35.690 total
> >       ./daniel.sh  34.83s user 95.66s system 363% cpu 35.921 total
> >
> > The system time is pretty gross, isn't it?
> >
> > And it's disproportional to the increased number of lockings.
> 
> These numbers show a 30% reduction in rmap overhead with my patch,
> close to what I originally reported:
> 
>   ((35.904 + 35.690 + 35.921) - (27.814 + 27.763 + 27.861)) /
>   ((39.316 + 39.405 + 39.062) - (27.814 + 27.763 + 27.861)) ~= .70
> 
> But they also show that rmap overhead is around 29% on your box,
> even with my patch:
> 
>   (35.904 + 35.690 + 35.921) / (27.814 + 27.763 + 27.861) ~= 1.29
> 
> Granted, it's still way too high, and we are still in search of the
> 'dark cycles'.

I'd say that the rmap overhead remains 50%, actually.  That's the
increase in system time.

> Did we do an apples-to-apples comparison of 2.4 to 2.5?

Seems 2.4 is a little faster - see the other email.  Just another
hit on page->flags somewhere would be enough to make that difference.
Nothing very obvious stands out in the oprofiles.

2.5.26:

c011c7b0 255      0.820833    exit_notify             
c0131d00 255      0.820833    lru_cache_add           
c0117d48 257      0.827271    copy_mm                 
c012d078 271      0.872336    filemap_nopage          
c0113dec 312      1.00431     pgd_alloc               
c011415c 338      1.08801     do_page_fault           
c014eb84 379      1.21998     __d_lookup              
c0134050 385      1.2393      free_page_and_swap_cache 
c0139a08 405      1.30368     do_page_cache_readahead 
c0145e08 417      1.3423      link_path_walk          
c0132f30 428      1.37771     __free_pages_ok         
c012c3b8 582      1.87343     find_get_page           
c01db08c 583      1.87665     radix_tree_lookup       
c0128040 594      1.91206     clear_page_tables       
c0107b58 650      2.09232     page_fault              
c0113ea0 682      2.19533     pte_alloc_one           
c01331c0 785      2.52688     rmqueue                 
c0129868 1146     3.68892     do_anonymous_page       
c013383c 1485     4.78015     page_cache_release      
c01284f0 1513     4.87028     zap_pte_range           
c0129a04 1717     5.52694     do_no_page              
c01282b0 1726     5.55591     copy_page_range         
c0129124 6653     21.4157     do_wp_page      

2.4.19-pre7:
        
c0140004 144      0.79929     free_page_and_swap_cache 
c013bbc4 146      0.810391    kmem_cache_alloc        
c011bf44 148      0.821492    copy_mm                 
c013c290 163      0.904751    kmem_cache_free         
c01193fc 164      0.910302    do_schedule             
c011c88c 168      0.932504    do_fork                 
c0155fe4 192      1.06572     link_path_walk          
c013d6e0 211      1.17118     lru_cache_add           
c01182d8 220      1.22114     do_page_fault           
c0122158 226      1.25444     exit_notify             
c012e5c4 252      1.39876     clear_page_tables       
c013eee0 292      1.62078     __free_pages_ok         
c01096cc 404      2.24245     page_fault              
c013f298 409      2.2702      rmqueue                 
c0161438 440      2.44227     d_lookup                
c0130c60 443      2.45893     pte_alloc               
c0134318 634      3.51909     __find_get_page         
c0130404 660      3.66341     do_anonymous_page       
c013fa3c 728      4.04085     __free_pages            
c012e960 972      5.3952      zap_page_range          
c012e6d8 1031     5.72269     copy_page_range         
c01306a0 1042     5.78375     do_no_page              
c012f8a0 3940     21.8694     do_wp_page
