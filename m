Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293646AbSCSE0f>; Mon, 18 Mar 2002 23:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293647AbSCSE0Z>; Mon, 18 Mar 2002 23:26:25 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:20911 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293646AbSCSE0I>; Mon, 18 Mar 2002 23:26:08 -0500
Date: Mon, 18 Mar 2002 20:25:42 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <47390000.1016511942@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I finally got the -aa kernel series running in conjunction with the
NUMA-Q discontigmem stuff. For some reason which I haven't debugged
yet 2.4.19-pre3-aa2 won't boot on the NUMA-Q even without the discontigmem
stuff in ... so I went back to 2.4.19-pre1-aa1, which I knew worked from
last time around (thanks again for that patch).

So just comparing aa+discontigmem to standard 2.4.18+discontigmem, I see
kernel compile times are about 35s vs 26.5s .... hmmm. Looking at the top
part of the profiles, I see this:

standard:

 23991 total                                      0.0257
  7679 default_idle                             147.6731
  3044 _text_lock_dcache                          8.7221
  2340 _text_lock_swap                           43.3333
  1160 do_anonymous_page                          3.4940
   776 d_lookup                                   2.8116
   650 __free_pages_ok                            1.2405
   627 lru_cache_add                              6.8152
   608 do_generic_file_read                       0.5468
   498 __generic_copy_from_user                   4.7885
   480 lru_cache_del                             21.8182
   437 atomic_dec_and_lock                        6.0694
   426 schedule                                   0.3017
   402 _text_lock_dec_and_lock                   16.7500
...   
   109 kmap_high                                  0.3028
    46 _text_lock_highmem                  0.4071

andrea:    
 38549 total                                      0.0405
 13102 _text_lock_highmem                       108.2810
  8627 default_idle                             165.9038
  2578 kunmap_high                               14.3222
  2556 kmap_high                                  6.0857
  1242 do_anonymous_page                          3.2684
  1052 _text_lock_swap                           22.8696
   942 _text_lock_dcache                          2.4987
   683 do_page_fault                              0.4337
   587 pte_alloc                                  1.2332
   535 __generic_copy_from_user                   5.1442
   518 d_lookup                                   1.8768
   443 __free_pages_ok                            0.7745
   422 lru_cache_add                              2.7763

_text_lock_highmem appears to be kmap_lock, looking at dissassembly.
Recompiling with the trusty lockmeter, I see this (on -aa).

 33.4% 63.5%  5.4us(7893us)  155us(  16ms)(37.8%)   2551814 36.5% 63.5%    0%  kmap_lock_cacheline
 17.4% 64.9%  5.7us(7893us)  158us(  16ms)(19.7%)   1275907 35.1% 64.9%    0%    kmap_high+0x34
 16.0% 62.1%  5.2us( 982us)  152us(  13ms)(18.1%)   1275907 37.9% 62.1%    0%    kunmap_high+0x40

Ick. On a vaguely comparible mainline kernel we're looking at:

  1.6%  2.7%  0.5us(4208us)   28us(3885us)(0.14%)    716044 97.3%  2.7%    0%  kmap_lock
  1.2%  2.9%  0.9us(4208us)   35us(3885us)(0.09%)    358022 97.1%  2.9%    0%    kmap_high+0x10
 0.33%  2.5%  0.2us(  71us)   21us(2598us)(0.05%)    358022 97.5%  2.5%    0%    kunmap_high+0xc

Andrea - is this your new highmem pte stuff doing this?
Or is that not even in your tree as yet? Would be a shame if that's
the problem as I really want to get the highmem pte stuff - allows
me to put processes pagetables on their own nodes ....

Thanks,

Martin.


