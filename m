Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264548AbTK3BM7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 20:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTK3BM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 20:12:59 -0500
Received: from holomorphy.com ([199.26.172.102]:10182 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264548AbTK3BMu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 20:12:50 -0500
Date: Sat, 29 Nov 2003 17:12:46 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031130011246.GC19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <20031128072148.GY8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 27, 2003 at 11:21:48PM -0800, William Lee Irwin III wrote:
> Now also ported to 2.6.0-test11:
> ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/pgcl-2.6.0-test11-1.gz
> This also corrects some PAGE_SHIFT instances that crept into mm/mmap.c
> while I wasn't looking and drops sym2 driver changes.

Quick performance and functionality test on a 32x/64GB 700MHz P-III.
Compressed dmesg attached. Not sure where the SCSI error came from.

This seems to show that reworking the rmap interaction is a pressing
performance issue (however pressing kernel compiles can be considered
to be, never mind all the actual bugs) since the rmap functions are
burning more cpu time than bitblitting luserspace. Unfortunately there
isn't really enough disk for on-disk dbench etc. so I resorted to ramfs,
whose readdir() etc. methods appear not to be very well parallelized. I
should probably have tried ext2 on loop on ramfs or some such nonsense.

The good news is that it does still run on the thing even after all of
the massive shakeups, rewrites, and time since my last boot on it in May.


Kernel compile on ext2:

$ time make -s -j bzImage > /dev/null
arch/i386/boot/setup.S: Assembler messages:
arch/i386/boot/setup.S:168: Warning: value 0x77dfffff truncated to 0x77dfffff
Root device is (8, 2)
Boot sector 512 bytes.
Setup is 2538 bytes.
System is 1117 kB
make -s -j bzImage > /dev/null  712.96s user 284.86s system 1140% cpu 1:27.46 total

6094329 total                                      3.8079
5787061 default_idle                             90422.8281
 85912 __page_remove_rmap                       298.3056
 38331 page_remove_rmap                         140.9228
 28287 copy_folio                                88.3969
 19051 page_add_rmap                             79.3792
 14709 __copy_to_user_ll                        131.3304
  7078 __copy_user_intel                         40.2159
  6901 __copy_from_user_ll                       61.6161
  5704 __page_add_rmap                           22.2812
  4710 __d_lookup                                17.3162
  4259 zap_pte_range                              3.6464
  4127 schedule                                   2.5288
  3940 rmap_add_folio                            14.4853
  3852 kmap_atomic                                8.0250
  3258 kmem_cache_free                           33.9375
  3053 clear_page_tables                          3.3476
  2079 try_to_wake_up                             4.0605
  2012 find_get_page                             31.4375
  1815 current_kernel_time                       22.6875
  1638 kmap_atomic_sg                             4.0950
  1627 path_lookup                                4.6222


dbench on ramfs:

$ time dbench 32 
32 clients started
   0     62477  296.11 MB/sec
Throughput 296.11 MB/sec 32 procs
dbench 32  20.60s user 989.43s system 2674% cpu 37.767 total

2328901 total                                      1.4552
1335226 default_idle                             20862.9062
415966 .text.lock.libfs                         2298.1547
168210 .text.lock.dec_and_lock                  15291.8182
157310 .text.lock.dcache                        291.3148
 70329 dcache_readdir                           146.5188
 23983 atomic_dec_and_lock                      347.5797
 21502 __copy_to_user_ll                        191.9821
 18555 .text.lock.file_table                    157.2458
 16183 __copy_from_user_ll                      144.4911
 11169 d_alloc                                   23.2688
 11055 filldir64                                 40.6434
  6661 d_instantiate                             69.3854
  5826 __d_lookup                                21.4191
  5405 path_lookup                               15.3551
  4545 path_release                              71.0156
  3728 file_move                                 58.2500
  3537 d_delete                                  18.4219
  3336 fd_install                                52.1250
  3220 simple_prepare_write                      20.1250
  3081 call_rcu                                  48.1406
  2704 vfs_readdir                               21.1250


SDET 32 profile:

4605683 total                                      2.8778
3480214 default_idle                             54378.3438
212021 page_remove_rmap                         779.4890
163508 __page_remove_rmap                       567.7361
 98710 page_add_rmap                            411.2917
 87944 copy_folio                               274.8250
 31101 __page_add_rmap                          121.4883
 20883 simple_prepare_write                     130.5188
 19818 copy_page_range                           15.6788
 18555 .text.lock.dcache                         34.3611
 18277 zap_pte_range                             15.6481
 17973 rmap_add_folio                            66.0772
 17932 .text.lock.dec_and_lock                  1630.1818
 17816 __d_lookup                                65.5000
 17680 __down                                    78.9286
 16517 __copy_to_user_ll                        147.4732
 11960 atomic_dec_and_lock                      173.3333
 11795 release_pages                             36.8594
 11256 kmap_atomic                               23.4500
  9696 kmem_cache_free                          101.0000
  9622 copy_mm                                    9.5456
  9371 .text.lock.libfs                          51.7735


SDET 128 profile:

19885416 total                                     12.4250
10870694 default_idle                             169854.5938
1868923 page_remove_rmap                         6871.0404
1722495 __page_remove_rmap                       5980.8854
991381 page_add_rmap                            4130.7542
619755 __down                                   2766.7634
403192 copy_folio                               1259.9750
172220 __page_add_rmap                          672.7344
164246 rmap_add_folio                           603.8456
161239 __wake_up                                2015.4875
123047 __d_lookup                               452.3787
121684 schedule                                  74.5613
120902 zap_pte_range                            103.5120
101418 __copy_to_user_ll                        905.5179
 99572 copy_page_range                           78.7753
 95709 simple_prepare_write                     598.1812
 76676 atomic_dec_and_lock                      1111.2464
 66245 remove_shared_vm_struct                  517.5391
 64159 path_lookup                              182.2699
 61922 release_pages                            193.5062
 61415 copy_mm                                   60.9276
 61356 clear_page_tables                         67.2763


I could probably use suggestions for a more mergeable method of
mitigating the rmap functions' overheads than the currently
available mm/rmap.c rewrites.

In more relevant news, I've started taking stabs at the rvmalloc()
mess and drm, with copious help from Zwane.


-- wli

--24zk1gE8NUlDmwG9
Content-Type: application/octet-stream
Content-Description: 64G.pgcl.test11.log.gz
Content-Disposition: attachment; filename="64G.test11.log.gz"
Content-Transfer-Encoding: base64

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
P1D9d/4N2pwlEqbKAAA=

--24zk1gE8NUlDmwG9--
