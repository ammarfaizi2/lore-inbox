Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292952AbSCMKMr>; Wed, 13 Mar 2002 05:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSCMKMb>; Wed, 13 Mar 2002 05:12:31 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:60945 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S292952AbSCMKMM>;
	Wed, 13 Mar 2002 05:12:12 -0500
Date: Wed, 13 Mar 2002 19:52:17 +1100
From: Anton Blanchard <anton@samba.org>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: 10.31 second kernel compile
Message-ID: <20020313085217.GA11658@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let the kernel compile benchmarks continue!

hardware: 24 way logical partition, 1.1GHz POWER4, 60G RAM

kernel: 2.5.6 + ppc64 pagetable rework

kernel compiled: 2.4.18 x86 with Martin's config

compiler: gcc 2.95.3 x86 cross compiler


# MAKE="make -j14" /usr/bin/time make -j14 bzImage
...
make[1]: Leaving directory `/home/anton/intel_kernel/linux/arch/i386/boot'
130.63user 71.31system 0:10.31elapsed 1957%CPU (0avgtext+0avgdata 0maxresident)k


Due to the final link and compress stage, there is a fair amount of idle
time at the end of the run. Its going to be hard to push that number
lower by adding cpus.

The profile results below show that kernel time is dominated by the low
level ppc64 pagetable management. We are working to correct this, a lot
of the overhead in __hash_page should be gone soon. The rest of the
profile looks pretty good, do_anonymous_page and lru_cache_add show
up high as they did in Martin's results.

Thanks to Milton Miller who helped with the benchmarking, and the ppc64
team!

Anton
--
anton@samba.org
anton@au.ibm.com

201150 total                                      0.0668
129051 .idled                                  

 43586 .__hash_page                            ppc64 specific
  6714 .local_flush_tlb_range                  ppc64 specific
  2773 .local_flush_tlb_page                   ppc64 specific

  2203 .do_anonymous_page                      
  2059 .lru_cache_add                          
  1379 .__copy_tofrom_user                     

  1220 .hpte_create_valid_pSeriesLP            ppc64 LPAR specific

  1039 .save_remaining_regs                    
   871 .do_page_fault                          

   575 .plpar_hcall                            ppc64 LPAR specific

   554 .d_lookup                               
   545 .rmqueue                                
   482 .copy_page                              
   475 .__strnlen_user                         
   391 .__free_pages_ok                        
   389 .zap_page_range                         
   366 .atomic_dec_and_lock                    
   296 .__find_get_page                        
   287 .set_page_dirty                         
   278 .page_cache_release                     
   218 .handle_mm_fault                        
   199 .__flush_dcache_icache                  
   175 .schedule                               
   173 .sys_brk                                
   163 .exit_notify                            
   156 .do_no_page                             
   152 .lru_cache_del                          
   147 .__wake_up                              
   146 .copy_page_range                        
   139 .ppc_irq_dispatch_handler               
   135 .find_vma                               
   131 .__lru_cache_del                        
   128 .fget                                   
   126 .link_path_walk                         
   115 .do_generic_file_read                   
   113 .pte_alloc_map                          
   113 .filemap_nopage                         
   109 .clear_user_page                        
   106 .fput                                   
   104 .__alloc_pages                          
   101 .nr_free_pages                          

