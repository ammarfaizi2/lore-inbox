Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbVIONkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbVIONkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 09:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIONkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 09:40:23 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:20716 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1030415AbVIONkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 09:40:23 -0400
Date: Thu, 15 Sep 2005 21:43:17 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Subject: Adaptive read-ahead with look-ahead
Message-ID: <20050915134317.GA5527@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a more complete version of the adaptive read-ahead logic.

There are mainly two changes:

1. DELAYED ACTIVATION
activate_page() now simply sets a PG_activate flag; the activation is
delayed to be handled by shrink_list().
That change effectively eliminates the disturbing problem, for the
timing information that lie in the chunks inside inactive_list are
preserved. But I'm not sure if the change will cause any negative
effects.

2. LOOK AHEAD
The new logic now mimics the ahead window behavior of the current logic,
by setting a PG_readahead flag on some pages as look-ahead reminders.
The added overhead is to find out where to start the next readahead.
Typical values would be two or more radix tree lookups for each
readahead IO, and one lru lock when in grow up phase.

Now the two logics behave roughly the same. It makes benchmarks more
meaningful and comparable. A rerun of the tests show that:
1. System time reports are still higher for the new logic.
2. The overall samples reported by oprofile are not distinguishable,
sometimes one counts more and sometimes the other.

TIME OUTPUTS
=====================================================================
# ./test_ra.sh 4k 0 50 100
readahead_ratio = 0
79.88s real  9.09s system  0.47s user  13651+130 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
146.75s real  1.33s system  21.44s user  13459+264 cs  grep -r 'asdfghjkl;' linux-2.6.13
181.19s real  3.80s system  1.58s user  32744+83 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
181.48s real  9.64s system  0.51s user  25141+181 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
readahead_ratio = 50
79.47s real  9.32s system  0.52s user  13928+107 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
141.93s real  1.46s system  21.78s user  13565+327 cs  grep -r 'asdfghjkl;' linux-2.6.13
178.20s real  4.04s system  1.56s user  32144+83 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
181.87s real  9.83s system  0.52s user  24836+150 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
readahead_ratio = 100
79.92s real  9.21s system  0.48s user  13668+134 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
144.82s real  1.47s system  21.61s user  13405+264 cs  grep -r 'asdfghjkl;' linux-2.6.13
179.62s real  3.90s system  1.48s user  32336+67 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
182.00s real  9.91s system  0.50s user  25723+145 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null

# ./test_ra.sh 32k 0 50 100
readahead_ratio = 0
79.80s real  8.07s system  0.09s user  14250+96 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
146.20s real  1.44s system  24.17s user  12954+299 cs  grep -r 'asdfghjkl;' linux-2.6.13
181.49s real  3.83s system  1.57s user  32098+72 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
182.00s real  8.63s system  0.08s user  25673+181 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
readahead_ratio = 50
79.74s real  8.24s system  0.08s user  13904+127 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
145.22s real  1.44s system  24.87s user  13182+303 cs  grep -r 'asdfghjkl;' linux-2.6.13
180.60s real  4.12s system  1.47s user  32096+53 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null
181.78s real  8.75s system  0.12s user  25843+188 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
readahead_ratio = 100
80.08s real  8.38s system  0.07s user  13806+131 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
147.72s real  1.74s system  23.23s user  12986+299 cs  grep -r 'asdfghjkl;' linux-2.6.13
179.43s real  9.21s system  0.10s user  26010+142 cs  dd if=$FILE of=/dev/null bs=$bs 2> /dev/null
180.20s real  4.10s system  1.41s user  32616+72 cs  diff -r linux-2.6.13 linux-2.6.13ra > /dev/null


OPROFILE RESULTS
=====================================================================

  oprofile.0.4k                                |  oprofile.100.4k
  ---------------------------------------------+------------------------------------------------
  samples  %        symbol name                |  samples  %        symbol name
  35783    14.3839  __copy_to_user_ll          |  34962    13.9808  __copy_to_user_ll
  15432     6.2033  ll_rw_block                |  15608     6.2414  ll_rw_block
  12055     4.8458  shrink_list                |  12115     4.8446  shrink_list
  10373     4.1697  system_call                |  10746     4.2972  system_call
  10037     4.0346  __find_get_block           |  10199     4.0784  __find_get_block
  7661      3.0795  delay_pmtmr                |  7716      3.0855  delay_pmtmr
  6671      2.6816  add_to_page_cache          |  6853      2.7404  add_to_page_cache
  5981      2.4042  radix_tree_delete          |  6155      2.4613  do_generic_mapping_read
  5433      2.1839  isolate_lru_pages          |  5796      2.3177  radix_tree_delete
  5346      2.1490  __brelse                   |  5362      2.1442  __brelse
  5268      2.1176  dnotify_parent             |  5298      2.1186  isolate_lru_pages
  4986      2.0042  unlock_buffer              |  5252      2.1002  dnotify_parent
  4884      1.9632  inotify_dentry_parent_queue|  5085      2.0334  inotify_dentry_parent_queue_event
  4779      1.9210  do_generic_mapping_read    |  4942      1.9762  unlock_buffer
  4509      1.8125  find_get_page              |  4869      1.9470  find_get_page
  4206      1.6907  do_mpage_readpage          |  4237      1.6943  do_mpage_readpage
  4074      1.6376  default_idle               |  4125      1.6495  default_idle
  4007      1.6107  __do_page_cache_readahead  |  3986      1.5939  __do_page_cache_readahead
  3242      1.3032  kmap_atomic                |  3159      1.2632  kmap_atomic
  2847      1.1444  __read_lock_failed         |  2923      1.1689  __read_lock_failed
  2748      1.1046  free_pages_bulk            |  2772      1.1085  free_pages_bulk
  2713      1.0906  unlock_page                |  2709      1.0833  unlock_page
  2582      1.0379  __wake_up_bit              |  2641      1.0561  mpage_end_io_read
  2534      1.0186  mpage_end_io_read          |  2502      1.0005  __wake_up_bit
  2468      0.9921  __pagevec_lru_add          |  2463      0.9849  __pagevec_lru_add
  2199      0.8839  __mod_page_state           |  2223      0.8889  __mod_page_state
  2142      0.8610  __alloc_pages              |  1964      0.7854  __alloc_pages
  1935      0.7778  bad_range                  |  1907      0.7626  bad_range
  1775      0.7135  mark_page_accessed         |  1771      0.7082  mark_page_accessed
  1765      0.7095  __write_lock_failed        |  1748      0.6990  __rmqueue
  1705      0.6854  find_busiest_group         |  1682      0.6726  zone_watermark_ok
  1634      0.6568  zone_watermark_ok          |  1677      0.6706  find_busiest_group
  1618      0.6504  buffered_rmqueue           |  1619      0.6474  buffered_rmqueue
  1617      0.6500  radix_tree_lookup          |  1599      0.6394  __write_lock_failed
  1599      0.6428  __rmqueue                  |  1556      0.6222  mark_offset_pmtmr
  1587      0.6379  mark_offset_pmtmr          |  1524      0.6094  free_hot_cold_page
  1580      0.6351  free_hot_cold_page         |  1503      0.6010  radix_tree_lookup
  1383      0.5559  schedule                   |  1399      0.5594  schedule
  1314      0.5282  page_referenced            |  1363      0.5450  page_referenced


  oprofile.0.32k                               |  oprofile.50.32k
  ---------------------------------------------+------------------------------------------------
  samples  %        symbol name                |  samples  %        symbol name
  36914    16.3667  __copy_to_user_ll          |  36787    16.2290  __copy_to_user_ll
  15604     6.9184  ll_rw_block                |  15507     6.8411  ll_rw_block
  11881     5.2677  shrink_list                |  11975     5.2829  shrink_list
  9893      4.3863  __find_get_block           |  10370     4.5749  __find_get_block
  7865      3.4871  delay_pmtmr                |  8043      3.5483  delay_pmtmr
  6684      2.9635  add_to_page_cache          |  6740      2.9734  add_to_page_cache
  6225      2.7600  isolate_lru_pages          |  6162      2.7184  isolate_lru_pages
  5634      2.4980  find_get_page              |  5852      2.5817  find_get_page
  5603      2.4842  radix_tree_delete          |  5718      2.5226  radix_tree_delete
  5400      2.3942  __brelse                   |  5193      2.2910  __brelse
  4958      2.1982  unlock_buffer              |  4974      2.1943  unlock_buffer
  4268      1.8923  default_idle               |  4159      1.8348  do_mpage_readpage
  4241      1.8803  do_mpage_readpage          |  4103      1.8101  mpage_end_io_read
  4113      1.8236  mpage_end_io_read          |  4084      1.8017  default_idle
  3944      1.7487  __do_page_cache_readahead  |  4008      1.7682  __do_page_cache_readahead
  3141      1.3926  kmap_atomic                |  3515      1.5507  do_generic_mapping_read
  2758      1.2228  unlock_page                |  3031      1.3372  kmap_atomic
  2740      1.2148  __read_lock_failed         |  2916      1.2864  __read_lock_failed
  2692      1.1936  __wake_up_bit              |  2749      1.2128  unlock_page
  2631      1.1665  __rmqueue                  |  2654      1.1708  __rmqueue
  2391      1.0601  free_pages_bulk            |  2541      1.1210  __wake_up_bit
  2378      1.0543  __pagevec_lru_add          |  2520      1.1117  __pagevec_lru_add
  2310      1.0242  do_generic_mapping_read    |  2424      1.0694  free_pages_bulk
  2206      0.9781  __mod_page_state           |  2279      1.0054  __mod_page_state
  2046      0.9071  __alloc_pages              |  1972      0.8700  __alloc_pages
  1730      0.7670  mark_page_accessed         |  1806      0.7967  mark_page_accessed
  1639      0.7267  buffered_rmqueue           |  1726      0.7614  zone_watermark_ok
  1629      0.7223  zone_watermark_ok          |  1695      0.7478  radix_tree_lookup
  1615      0.7160  find_busiest_group         |  1689      0.7451  find_busiest_group
  1570      0.6961  radix_tree_lookup          |  1562      0.6891  mark_offset_pmtmr
  1499      0.6646  mark_offset_pmtmr          |  1514      0.6679  buffered_rmqueue
  1448      0.6420  free_hot_cold_page         |  1508      0.6653  free_hot_cold_page
  1438      0.6376  schedule                   |  1488      0.6564  schedule
  1437      0.6371  bad_range                  |  1434      0.6326  system_call
  1431      0.6345  __write_lock_failed        |  1412      0.6229  bad_range
  1426      0.6322  release_pages              |  1394      0.6150  __write_lock_failed
  1392      0.6172  system_call                |  1366      0.6026  release_pages
  1331      0.5901  page_waitqueue             |  1352      0.5965  page_referenced
  1307      0.5795  page_referenced            |  1279      0.5642  page_waitqueue

 oprofile.0.8k vs oprofile.50.8k with accumulated samples.
--------------------------------------------------------------------------------------------------------------------
  samples  cum. samples  %        cum. %     symbol name    |  samples  cum. samples  %        cum. %     symbol name
  38565    38565         14.4471  14.4471    __copy_to_user_|  36673    36673         15.0370  15.0370    __copy_to_user_
  16341    54906          6.1216  20.5687    ll_rw_block    |  15770    52443          6.4662  21.5032    ll_rw_block
  12407    67313          4.6479  25.2166    shrink_list    |  11999    64442          4.9199  26.4231    shrink_list
  10404    77717          3.8975  29.1141    __find_get_bloc|  11027    75469          4.5214  30.9445    __find_get_bloc
  8157     85874          3.0558  32.1699    delay_pmtmr    |  8003     83472          3.2815  34.2260    delay_pmtmr
  6961     92835          2.6077  34.7776    add_to_page_cac|  6836     90308          2.8030  37.0289    add_to_page_cac
  6546     99381          2.4522  37.2299    system_call    |  6362     96670          2.6086  39.6375    isolate_lru_pag
  6432     105813         2.4095  39.6394    isolate_lru_pag|  5882     102552         2.4118  42.0493    find_get_page
  6098     111911         2.2844  41.9238    find_get_page  |  5808     108360         2.3815  44.4308    radix_tree_dele
  5948     117859         2.2282  44.1520    radix_tree_dele|  5567     113927         2.2826  46.7134    system_call
  5743     123602         2.1514  46.3035    __brelse       |  5311     119238         2.1777  48.8911    __brelse
  5247     128849         1.9656  48.2691    unlock_buffer  |  5082     124320         2.0838  50.9748    unlock_buffer
  4505     133354         1.6877  49.9567    do_mpage_readpa|  4858     129178         1.9919  52.9668    do_generic_mapp
  4501     137855         1.6862  51.6429    mpage_end_io_re|  4252     133430         1.7434  54.7102    do_mpage_readpa
  4341     142196         1.6262  53.2691    __do_page_cache|  4189     137619         1.7176  56.4278    __do_page_cache
  4315     146511         1.6165  54.8856    default_idle   |  4159     141778         1.7053  58.1331    default_idle
  3655     150166         1.3692  56.2548    do_generic_mapp|  4127     145905         1.6922  59.8253    mpage_end_io_re
  3146     153312         1.1785  57.4333    kmap_atomic    |  3152     149057         1.2924  61.1177    kmap_atomic
  2942     156254         1.1021  58.5355    __read_lock_fai|  2947     152004         1.2084  62.3261    __read_lock_fai
  2918     159172         1.0931  59.6286    unlock_page    |  2787     154791         1.1428  63.4688    __rmqueue
  2900     162072         1.0864  60.7150    __rmqueue      |  2782     157573         1.1407  64.6095    unlock_page
  2839     164911         1.0635  61.7785    dnotify_parent |  2778     160351         1.1391  65.7486    dnotify_parent
  2814     167725         1.0542  62.8327    __wake_up_bit  |  2663     163014         1.0919  66.8405    __wake_up_bit
  2759     170484         1.0336  63.8663    inotify_dentry_|  2556     165570         1.0480  67.8886    inotify_dentry_
  2533     173017         0.9489  64.8152    free_pages_bulk|  2455     168025         1.0066  68.8952    free_pages_bulk
  2524     175541         0.9455  65.7607    __pagevec_lru_a|  2414     170439         0.9898  69.8850    __pagevec_lru_a
  2344     177885         0.8781  66.6388    __mod_page_stat|  2146     172585         0.8799  70.7649    __mod_page_stat
  2319     180204         0.8687  67.5076    __d_lookup     |  2060     174645         0.8447  71.6096    __alloc_pages
  2183     182387         0.8178  68.3253    __alloc_pages  |  1839     176484         0.7540  72.3636    mark_page_acces
  1952     184339         0.7313  69.0566    radix_tree_look|  1731     178215         0.7098  73.0734    radix_tree_look
  1918     186257         0.7185  69.7751    mark_page_acces|  1707     179922         0.6999  73.7733    zone_watermark_
  1886     188143         0.7065  70.4816    zone_watermark_|  1680     181602         0.6888  74.4621    find_busiest_gr
  1880     190023         0.7043  71.1859    schedule       |  1598     183200         0.6552  75.1174    __write_lock_fa
  1861     191884         0.6972  71.8831    find_busiest_gr|  1572     184772         0.6446  75.7619    buffered_rmqueu
  1837     193721         0.6882  72.5713    buffered_rmqueu|  1543     186315         0.6327  76.3946    mark_offset_pmt
  1644     195365         0.6159  73.1871    mark_offset_pmt|  1500     187815         0.6150  77.0097    free_hot_cold_p
  1582     196947         0.5926  73.7798    free_hot_cold_p|  1494     189309         0.6126  77.6222    schedule
  1481     198428         0.5548  74.3346    bad_range      |  1482     190791         0.6077  78.2299    radix_tree_inse
  1480     199908         0.5544  74.8890    release_pages  |  1376     192167         0.5642  78.7941    bad_range
......
  2        266707        7.5e-04  99.9131    generic_file_mm|  1        243885        4.1e-04  100.000    vma_link

Here the new logic gets fewer samples!


ABOUT DEBUGGING
=====================================================================
But there is a significant rise for do_generic_mapping_read().
The problem was tracked down to be TestClearPageReadahead(), and was
solved by changing it to PageReadahead() and move the test-clear thing
to page_cache_readahead_adaptive().

I used the following commands to check things out, are there other ways
to do this?

# opreport -cl linux-2.6.13ra/vmlinux
# opannotate --assembly linux-2.6.13ra/vmlinux
# make CONFIG_DEBUG_INFO=1 mm/filemap.o
# objdump -S mm/filemap.o > mm/filemap.asm 

First I found the current logic has one major hot spot:
    vma      samples  cum. samples  %        cum. %
    c013c84f 1479     3969          31.7586  85.2265

While the new one has two:
    c013c84f 1587     5769          24.6047  89.4419
    c013c6ce 1169     3248          18.1240  50.3566

The c013c84f address is found out to be:
  1520  0.5394 :c013c84f:       sets   %al
or:
--------------------------------------------------------------------------------
static inline void put_page(struct page *page)
{       
        if (!PageReserved(page) && put_page_testzero(page))
     ee1:       8b 43 04                mov    0x4(%ebx),%eax
     ee4:       40                      inc    %eax
     ee5:       74 3f                   je     f26 <do_generic_mapping_read+0x316>
static __inline__ int atomic_add_negative(int i, atomic_t *v)
{       
        unsigned char c;

        __asm__ __volatile__(
     ee7:       8b 75 9c                mov    0xffffff9c(%ebp),%esi
     eea:       f0 83 46 04 ff          lock addl $0xffffffff,0x4(%esi)
     eef:       0f 98 c0                sets   %al
     ef2:       84 c0                   test   %al,%al
     ef4:       75 27                   jne    f1d <do_generic_mapping_read+0x30d>
                page_cache_release(prev_page);
--------------------------------------------------------------------------------
And the c013c6ce address is
               :c013c6ce:       sbb    %eax,%eax
or: 
--------------------------------------------------------------------------------
static inline int test_and_clear_bit(int nr, volatile unsigned long * addr)
{       
        int oldbit;

        __asm__ __volatile__( LOCK_PREFIX
     d69:       f0 0f ba 37 15          lock btrl $0x15,(%edi)
     d6e:       19 c0                   sbb    %eax,%eax
     d70:       85 c0                   test   %eax,%eax
     d72:       0f 85 08 04 00 00       jne    1180 <do_generic_mapping_read+0x570>
                                page_cache_readahead_adaptive(mapping, &ra,
                                                filp, prev_page, NULL,
                                                *ppos >> PAGE_CACHE_SHIFT,
                                                index, last_index);
                                page = find_get_page(mapping, index);
                        } else if (TestClearPageReadahead(page)) {
                                page_cache_readahead_adaptive(mapping, &ra,
                                                filp, prev_page, page,
                                                *ppos >> PAGE_CACHE_SHIFT,
                                                index, last_index);
                        }
                }
--------------------------------------------------------------------------------
Then I knew that TestClearPageReadahead() can be a lot expensive than
PageReadahead()!



diff -rup linux-2.6.13/include/linux/mm.h linux-2.6.13ra/include/linux/mm.h
--- linux-2.6.13/include/linux/mm.h	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/include/linux/mm.h	2005-09-14 22:15:09.000000000 +0800
@@ -875,7 +875,7 @@ extern int filemap_populate(struct vm_ar
 int write_one_page(struct page *page, int wait);
 
 /* readahead.c */
-#define VM_MAX_READAHEAD	128	/* kbytes */
+#define VM_MAX_READAHEAD	1024	/* kbytes */
 #define VM_MIN_READAHEAD	16	/* kbytes (includes current page) */
 #define VM_MAX_CACHE_HIT    	256	/* max pages in a row in cache before
 					 * turning readahead off */
@@ -889,6 +889,12 @@ unsigned long  page_cache_readahead(stru
 			  struct file *filp,
 			  unsigned long offset,
 			  unsigned long size);
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			unsigned long first_index,
+			unsigned long index, unsigned long last_index);
 void handle_ra_miss(struct address_space *mapping, 
 		    struct file_ra_state *ra, pgoff_t offset);
 unsigned long max_sane_readahead(unsigned long nr);
diff -rup linux-2.6.13/include/linux/page-flags.h linux-2.6.13ra/include/linux/page-flags.h
--- linux-2.6.13/include/linux/page-flags.h	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/include/linux/page-flags.h	2005-09-15 09:39:49.000000000 +0800
@@ -75,6 +75,8 @@
 #define PG_reclaim		17	/* To be reclaimed asap */
 #define PG_nosave_free		18	/* Free, should not be written */
 #define PG_uncached		19	/* Page has been mapped as uncached */
+#define PG_activate		20	/* delayed activate */
+#define PG_readahead		21	/* check readahead when reading this page */
 
 /*
  * Global page accounting.  One instance per CPU.  Only unsigned longs are
@@ -305,6 +307,18 @@ extern void __mod_page_state(unsigned lo
 #define SetPageUncached(page)	set_bit(PG_uncached, &(page)->flags)
 #define ClearPageUncached(page)	clear_bit(PG_uncached, &(page)->flags)
 
+#define PageActivate(page)	test_bit(PG_activate, &(page)->flags)
+#define SetPageActivate(page)	set_bit(PG_activate, &(page)->flags)
+#define ClearPageActivate(page)	clear_bit(PG_activate, &(page)->flags)
+#define TestClearPageActivate(page) test_and_clear_bit(PG_activate, &(page)->flags)
+#define TestSetPageActivate(page) test_and_set_bit(PG_activate, &(page)->flags)
+
+#define PageReadahead(page)	test_bit(PG_readahead, &(page)->flags)
+#define SetPageReadahead(page)	set_bit(PG_readahead, &(page)->flags)
+#define ClearPageReadahead(page) clear_bit(PG_readahead, &(page)->flags)
+#define TestClearPageReadahead(page) test_and_clear_bit(PG_readahead, &(page)->flags)
+#define TestSetPageReadahead(page) test_and_set_bit(PG_readahead, &(page)->flags)
+
 struct page;	/* forward declaration */
 
 int test_clear_page_dirty(struct page *page);
diff -rup linux-2.6.13/include/linux/sysctl.h linux-2.6.13ra/include/linux/sysctl.h
--- linux-2.6.13/include/linux/sysctl.h	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/include/linux/sysctl.h	2005-09-13 17:04:42.000000000 +0800
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_READAHEAD_RATIO=29, /* ratio of readahead request size to backward-looking size */
 };
 
 
diff -rup linux-2.6.13/kernel/sysctl.c linux-2.6.13ra/kernel/sysctl.c
--- linux-2.6.13/kernel/sysctl.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/kernel/sysctl.c	2005-09-13 17:04:42.000000000 +0800
@@ -66,6 +66,7 @@ extern int min_free_kbytes;
 extern int printk_ratelimit_jiffies;
 extern int printk_ratelimit_burst;
 extern int pid_max_min, pid_max_max;
+extern int readahead_ratio;
 
 #if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_X86)
 int unknown_nmi_panic;
@@ -851,6 +852,16 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_READAHEAD_RATIO,
+		.procname	= "readahead_ratio",
+		.data		= &readahead_ratio,
+		.maxlen		= sizeof(readahead_ratio),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
diff -rup linux-2.6.13/mm/filemap.c linux-2.6.13ra/mm/filemap.c
--- linux-2.6.13/mm/filemap.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/mm/filemap.c	2005-09-15 15:51:53.000000000 +0800
@@ -699,6 +699,8 @@ grab_cache_page_nowait(struct address_sp
 
 EXPORT_SYMBOL(grab_cache_page_nowait);
 
+extern int readahead_ratio;
+
 /*
  * This is a generic file read routine, and uses the
  * mapping->a_ops->readpage() function for the actual low-level
@@ -726,10 +728,12 @@ void do_generic_mapping_read(struct addr
 	unsigned long prev_index;
 	loff_t isize;
 	struct page *cached_page;
+	struct page *prev_page;
 	int error;
 	struct file_ra_state ra = *_ra;
 
 	cached_page = NULL;
+	prev_page = NULL;
 	index = *ppos >> PAGE_CACHE_SHIFT;
 	next_index = index;
 	prev_index = ra.prev_page;
@@ -758,16 +762,35 @@ void do_generic_mapping_read(struct addr
 		nr = nr - offset;
 
 		cond_resched();
-		if (index == next_index)
+		
+		if (readahead_ratio <= 9 && index == next_index)
 			next_index = page_cache_readahead(mapping, &ra, filp,
 					index, last_index - index);
 
 find_page:
 		page = find_get_page(mapping, index);
+		if (readahead_ratio > 9) {
+			if (unlikely(page == NULL)) {
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, NULL,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+				page = find_get_page(mapping, index);
+			} else if (PageReadahead(page)) {
+				page_cache_readahead_adaptive(mapping, &ra,
+						filp, prev_page, page,
+						*ppos >> PAGE_CACHE_SHIFT,
+						index, last_index);
+			}
+		}
 		if (unlikely(page == NULL)) {
-			handle_ra_miss(mapping, &ra, index);
+			if (readahead_ratio <= 9)
+				handle_ra_miss(mapping, &ra, index);
 			goto no_cached_page;
 		}
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		if (!PageUptodate(page))
 			goto page_not_up_to_date;
 page_ok:
@@ -802,7 +825,6 @@ page_ok:
 		index += offset >> PAGE_CACHE_SHIFT;
 		offset &= ~PAGE_CACHE_MASK;
 
-		page_cache_release(page);
 		if (ret == nr && desc->count)
 			continue;
 		goto out;
@@ -814,7 +836,6 @@ page_not_up_to_date:
 		/* Did it get unhashed before we got the lock? */
 		if (!page->mapping) {
 			unlock_page(page);
-			page_cache_release(page);
 			continue;
 		}
 
@@ -839,7 +860,6 @@ readpage:
 					 * invalidate_inode_pages got it
 					 */
 					unlock_page(page);
-					page_cache_release(page);
 					goto find_page;
 				}
 				unlock_page(page);
@@ -860,7 +880,6 @@ readpage:
 		isize = i_size_read(inode);
 		end_index = (isize - 1) >> PAGE_CACHE_SHIFT;
 		if (unlikely(!isize || index > end_index)) {
-			page_cache_release(page);
 			goto out;
 		}
 
@@ -869,7 +888,6 @@ readpage:
 		if (index == end_index) {
 			nr = ((isize - 1) & ~PAGE_CACHE_MASK) + 1;
 			if (nr <= offset) {
-				page_cache_release(page);
 				goto out;
 			}
 		}
@@ -879,7 +897,6 @@ readpage:
 readpage_error:
 		/* UHHUH! A synchronous read error occurred. Report it */
 		desc->error = error;
-		page_cache_release(page);
 		goto out;
 
 no_cached_page:
@@ -904,6 +921,9 @@ no_cached_page:
 		}
 		page = cached_page;
 		cached_page = NULL;
+		if (prev_page)
+			page_cache_release(prev_page);
+		prev_page = page;
 		goto readpage;
 	}
 
@@ -913,6 +933,8 @@ out:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
+	if (prev_page)
+		page_cache_release(prev_page);
 	if (filp)
 		file_accessed(filp);
 }
@@ -1210,19 +1232,33 @@ retry_all:
 	 *
 	 * For sequential accesses, we use the generic readahead logic.
 	 */
-	if (VM_SequentialReadHint(area))
+	if (readahead_ratio <= 9 && VM_SequentialReadHint(area))
 		page_cache_readahead(mapping, ra, file, pgoff, 1);
 
+
 	/*
 	 * Do we have something in the page cache already?
 	 */
 retry_find:
 	page = find_get_page(mapping, pgoff);
+	if (VM_SequentialReadHint(area) && readahead_ratio > 9) {
+		if (!page) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, NULL,
+						pgoff, pgoff, pgoff + 1);
+			page = find_get_page(mapping, pgoff);
+		} else if (PageReadahead(page)) {
+			page_cache_readahead_adaptive(mapping, ra,
+						file, NULL, page,
+						pgoff, pgoff, pgoff + 1);
+		}
+	}
 	if (!page) {
 		unsigned long ra_pages;
 
 		if (VM_SequentialReadHint(area)) {
-			handle_ra_miss(mapping, ra, pgoff);
+			if (readahead_ratio <= 9)
+				handle_ra_miss(mapping, ra, pgoff);
 			goto no_cached_page;
 		}
 		ra->mmap_miss++;
diff -rup linux-2.6.13/mm/readahead.c linux-2.6.13ra/mm/readahead.c
--- linux-2.6.13/mm/readahead.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/mm/readahead.c	2005-09-15 15:56:06.000000000 +0800
@@ -15,6 +15,9 @@
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
 
+int readahead_ratio = 0;
+EXPORT_SYMBOL(readahead_ratio);
+
 void default_unplug_io_fn(struct backing_dev_info *bdi, struct page *page)
 {
 }
@@ -254,20 +257,24 @@ out:
  */
 static int
 __do_page_cache_readahead(struct address_space *mapping, struct file *filp,
-			unsigned long offset, unsigned long nr_to_read)
+			unsigned long offset, unsigned long nr_to_read,
+			unsigned long lookahead_size)
 {
 	struct inode *inode = mapping->host;
-	struct page *page;
+	struct page *page = NULL;
 	unsigned long end_index;	/* The last page we want to read */
 	LIST_HEAD(page_pool);
 	int page_idx;
 	int ret = 0;
 	loff_t isize = i_size_read(inode);
 
+	if (page && !TestClearPageReadahead(page))
+		return 0;
+
 	if (isize == 0)
 		goto out;
 
- 	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
+	end_index = ((isize - 1) >> PAGE_CACHE_SHIFT);
 
 	/*
 	 * Preallocate as many pages as we will need.
@@ -280,8 +287,12 @@ __do_page_cache_readahead(struct address
 			break;
 
 		page = radix_tree_lookup(&mapping->page_tree, page_offset);
-		if (page)
+		if (page) {
+			if (readahead_ratio > 9 &&
+					page_idx == nr_to_read - lookahead_size)
+				SetPageReadahead(page);
 			continue;
+		}
 
 		read_unlock_irq(&mapping->tree_lock);
 		page = page_cache_alloc_cold(mapping);
@@ -289,9 +300,16 @@ __do_page_cache_readahead(struct address
 		if (!page)
 			break;
 		page->index = page_offset;
+		if (readahead_ratio > 9 &&
+				page_idx == nr_to_read - lookahead_size)
+			SetPageReadahead(page);
 		list_add(&page->lru, &page_pool);
 		ret++;
 	}
+	if (page && readahead_ratio > 9 && (readahead_ratio % 3) == 0)
+		get_page(page);
+	else
+		page = NULL;
 	read_unlock_irq(&mapping->tree_lock);
 
 	/*
@@ -301,6 +319,11 @@ __do_page_cache_readahead(struct address
 	 */
 	if (ret)
 		read_pages(mapping, filp, &page_pool, ret);
+	if (page) {
+		lock_page(page);
+		__put_page(page);
+		unlock_page(page);
+	}
 	BUG_ON(!list_empty(&page_pool));
 out:
 	return ret;
@@ -326,7 +349,7 @@ int force_page_cache_readahead(struct ad
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		err = __do_page_cache_readahead(mapping, filp,
-						offset, this_chunk);
+						offset, this_chunk, 0);
 		if (err < 0) {
 			ret = err;
 			break;
@@ -373,7 +396,7 @@ int do_page_cache_readahead(struct addre
 	if (bdi_read_congested(mapping->backing_dev_info))
 		return -1;
 
-	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	return __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
 }
 
 /*
@@ -393,9 +416,15 @@ blockable_page_cache_readahead(struct ad
 	if (!block && bdi_read_congested(mapping->backing_dev_info))
 		return 0;
 
-	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read);
+	actual = __do_page_cache_readahead(mapping, filp, offset, nr_to_read, 0);
+
+	if (readahead_ratio <= 9 && (readahead_ratio & 1)) {
+		printk(KERN_DEBUG
+			"blockable-readahead(ino=%lu, ra=%lu+%lu) = %d\n",
+			mapping->host->i_ino, offset, nr_to_read, actual);
+	}
 
-	return check_ra_success(ra, nr_to_read, actual);
+	return (readahead_ratio > 9) ? actual : check_ra_success(ra, nr_to_read, actual);
 }
 
 static int make_ahead_window(struct address_space *mapping, struct file *filp,
@@ -555,3 +584,349 @@ unsigned long max_sane_readahead(unsigne
 	__get_zone_counts(&active, &inactive, &free, NODE_DATA(numa_node_id()));
 	return min(nr, (inactive + free) / 2);
 }
+
+
+/* STATUS	VALUE		TYPE
+ *  ___ 	0		not in inactive list
+ *  L__ 	1		fresh
+ *  L_R 	2		stale
+ *  LA_ 	4		disturbed once
+ *  LAR 	8		disturbed twice
+ */
+static inline int get_sequential_type(struct page *page)
+{
+	if (page && PageLRU(page) && !PageActive(page)) {
+		if (!PageActivate(page))
+			return 1 + PageReferenced(page);
+		else
+			return 4 + 4*PageReferenced(page);
+	}
+	else
+		return 0;
+}
+
+/*
+ * Look back to estimate safe readahead size.
+ * It will normally be around min(nr_lookback, offset), unless either memory or
+ * read speed is low.  A rigid implementation would be a simple loop to scan
+ * page by page backward, though this may be unnecessary and inefficient, so
+ * the stepping forward scheme is used.
+ */
+static int count_sequential_pages(struct address_space *mapping,
+			unsigned long offset, unsigned long nr_lookback,
+			int sequential_type)
+{
+	int step;
+	int count;
+	unsigned long index;
+	struct page *page;
+
+	index = offset - nr_lookback;
+	if (unlikely(index > offset))
+		index = 0;
+
+	read_lock_irq(&mapping->tree_lock);
+	for(step = (offset - index + 3) / 4, count = 0;
+			index < offset;
+			index += step) {
+		page = radix_tree_lookup(&mapping->page_tree, index);
+		if (get_sequential_type(page) >= sequential_type) {
+			if (++count >= 3)
+				break;
+		} else {
+			count = 0;
+			step = (offset - index + 3) / 4;
+		}
+	}
+	read_unlock_irq(&mapping->tree_lock);
+
+	return (offset > index) ? (4 * step) : 0;
+}
+
+/*
+ * Scan forward/backward for the first non-present page.
+ * It takes advantage of the adjacency of pages in inactive_list.
+ */
+static unsigned long lru_scan(struct page *page, int dir,
+				int nr_chunks, int nr_pages)
+{
+	unsigned long index = page->index;
+	struct address_space *mapping = page->mapping;
+	struct page *head_page = NULL;
+	struct zone *zone;
+
+	BUG_ON(nr_pages <= 0);
+	BUG_ON(nr_chunks <= 0);
+	BUG_ON(dir != 1 && dir != -1);
+
+	for(;;) {
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+
+		if (!PageLRU(page))
+			goto out;
+
+		do {    
+			index += dir;
+			if (!--nr_pages)
+				goto out;
+
+			page = list_entry(dir == 1 ?
+					page->lru.prev : page->lru.next,
+					struct page, lru);
+		} while (page->mapping == mapping && page->index == index);
+
+		if (!--nr_chunks)
+			goto out;
+		spin_unlock_irq(&zone->lru_lock);
+
+		if (head_page)
+			page_cache_release(head_page);
+
+		head_page = page = find_get_page(mapping, index);
+		if (!page)
+			return index;
+	}
+
+out:    
+	spin_unlock_irq(&zone->lru_lock);
+	if (head_page)
+		page_cache_release(head_page);
+
+	return (nr_chunks && nr_pages) ? index : 0;
+}
+
+static unsigned long get_readahead_index(struct address_space *mapping,
+				unsigned long index, unsigned long ra_size)
+{
+	struct page *page;
+
+	page = find_get_page(mapping, index + ra_size);
+	if (page)
+		goto scan;
+
+	page = find_get_page(mapping, index + ra_size - 1);
+	if (page) {
+		page_cache_release(page);
+		return index + ra_size;
+	}
+
+	for(ra_size -= ra_size / 4;; ra_size = (ra_size + 1) / 2) {
+		if (ra_size == 1)
+			return index + 1;
+		page = find_get_page(mapping, index + ra_size);
+		if (page)
+			break;
+	}
+scan:
+	index = lru_scan(page, 1, ra_size, ra_size);
+	page_cache_release(page);
+	return index;
+}
+
+/*
+ * Rotate old cached pages in inactive_list to prevent readahead thrashing.
+ * Not expected to happen too much.
+ */
+static void rotate_old_pages(struct address_space *mapping,
+			unsigned long offset, unsigned long nr_scan)
+{
+	struct page *page;
+	struct zone *zone;
+
+	for (; nr_scan--; offset++) {
+		page = find_get_page(mapping, offset);
+		if (unlikely(!page))
+			break;
+		zone = page_zone(page);
+		spin_lock_irq(&zone->lru_lock);
+		if (PageLRU(page) && !PageLocked(page) && !PageActive(page)) {
+			list_del(&page->lru);
+			list_add(&page->lru, &zone->inactive_list);
+			/* inc_page_state(pgrotated); */
+		}
+		spin_unlock_irq(&zone->lru_lock);
+		page_cache_release(page);
+	}
+}
+
+
+/*
+ * ra_size is mainly determined by:
+ * 1. sequential-start: min(KB(32 + mem_mb/4), KB(128))
+ * 2. sequential-max:	min(KB(64 + mem_mb*8), KB(2048))
+ * 3. sequential:	(history pages) * (readahead_ratio / 100)
+ *
+ * Table of concrete numbers:
+ *  (inactive + free) (in MB):   8  16  32  64  128  256  1024  2048
+ *    initial ra_size (in KB):  34  36  40  48   64   96   128   128
+ *	  max ra_size (in KB): 128 192 320 576 1088 2048  2048  2048
+ */
+static inline void get_readahead_bounds(struct address_space *mapping,
+					unsigned long *ra_min,
+					unsigned long *ra_max)
+{
+	unsigned long mem_mb;
+
+#define KB(size)	(((size) * (1<<10)) / PAGE_CACHE_SIZE)
+	mem_mb = max_sane_readahead(KB(1024*1024)) * 2 *
+				PAGE_CACHE_SIZE / 1024 / 1024;
+
+	*ra_max = min(min(KB(64 + mem_mb*8), KB(2048)),
+			mapping->backing_dev_info->ra_pages); 
+
+	*ra_min = min(min(KB(32 + mem_mb/4), KB(128)), *ra_max);
+#undef KB
+}
+
+/* 
+ * Adaptive readahead based on page cache context
+ */
+unsigned long
+page_cache_readahead_adaptive(struct address_space *mapping,
+			struct file_ra_state *ra, struct file *filp,
+			struct page *prev_page, struct page *page,
+			unsigned long first_index,
+			unsigned long index, unsigned long last_index)
+{
+	unsigned long eof_index;
+	unsigned long ra_index = index;
+	unsigned long ra_size;
+	unsigned long la_size = 0;
+	unsigned long ra_min;
+	unsigned long ra_max;
+	int ret;
+	int release_prev_page = 0;
+	int sequential_type;
+
+	get_readahead_bounds(mapping, &ra_min, &ra_max);
+
+	/* do not run across EOF */
+	eof_index = ((i_size_read(mapping->host) - 1)
+			>> PAGE_CACHE_SHIFT) + 1;
+	if (last_index > eof_index)
+		last_index = eof_index;
+
+	/*
+	 * readahead disabled?
+	 */
+	if (unlikely(!ra_max)) {
+		ra_size = max_sane_readahead(last_index - index);
+		goto readit;
+	}
+	if (unlikely(!readahead_ratio))
+		goto read_random;
+
+	/*
+	 * Start of file.
+	 */
+	if (index == 0) {
+		if (eof_index >= 2 * ra_min)
+			ra_size = ra_min;
+		else
+			ra_size = eof_index;
+		la_size = ra_size / 2;
+		goto readit;
+	}
+
+	if (!prev_page) {
+		prev_page = find_get_page(mapping, index - 1);
+		release_prev_page = 1;
+	}
+
+	/*
+	 * Bare support for read backward.
+	 */
+	if (!prev_page && first_index == index &&
+			last_index - index < ra_min) {
+		struct page *last_page;
+
+		last_page = find_get_page(mapping, last_index);
+		if (get_sequential_type(page) == 2) {
+			ra_index = ((index > 8) ? (index - 8) : 0);
+			ra_size = last_index - ra_index;
+			page_cache_release(last_page);
+			goto readit;
+		}
+		if (last_page)
+			page_cache_release(last_page);
+	}
+
+	/*
+	 * Random read.
+	 */
+	if (!prev_page)
+		goto read_random;
+
+	/* 
+	 * Sequential readahead?
+	 */ 
+	sequential_type = get_sequential_type(prev_page);
+	if (sequential_type > 1 && (!page || !PageActive(page)) &&
+				get_sequential_type(page) < sequential_type) {
+		ra_size = count_sequential_pages(mapping, index,
+				ra_max * 100 / readahead_ratio,
+				sequential_type) * readahead_ratio / 100;
+		if (last_index - first_index < ra_max &&
+			ra_size < ra_min && sequential_type != 2)
+			goto read_random;
+
+		if (ra_size > ra_max)
+			ra_size = ra_max;
+		else if (ra_size < ra_min)
+			ra_size = ra_min;
+
+		if (page) { /* ahead window */
+			ra_index = get_readahead_index(mapping, index, ra_size);
+			if (unlikely(!ra_index))
+				goto out;
+			if (ra_index + ra_size + ra_min <= eof_index)
+				la_size = ra_size;
+			else
+				ra_size = eof_index - ra_index;
+		} else { /* current + ahead window */
+			if (ra_index + 2 * ra_size + ra_min <= eof_index) {
+				la_size = ra_size;
+				ra_size *= 2;
+			}
+			else
+				ra_size = eof_index - ra_index;
+		}
+
+		goto readit;
+	}
+
+read_random:
+	ra_size = min(last_index - index, ra_max);
+
+readit: 
+	ret = __do_page_cache_readahead(mapping, filp, ra_index, ra_size, la_size);
+
+	/* 
+	 * If found hole, rotate old pages to prevent readahead-thrashing.
+	 */
+	if (ret != la_size + ra_size && ra_size < ra_max)
+		rotate_old_pages(mapping, ra_index, ra_size);
+
+	/* if (la_size) {
+		page = find_get_page(mapping, ra_index + ra_size - la_size);
+		if (page) {
+			SetPageReadahead(page);
+			page_cache_release(page);
+		}
+	}                                                                       */
+
+	if (readahead_ratio & 1)
+		printk(KERN_DEBUG "readahead(ino=%lu, index=%lu-%lu-%lu, "
+				"ra=%lu+%lu-%lu) = %d\n",
+				mapping->host->i_ino,
+				first_index, index, last_index,
+				ra_index, ra_size, la_size, ret);
+
+out:
+	if (release_prev_page && prev_page)
+		page_cache_release(prev_page);
+
+	return ra_index + ra_size;
+}
+
diff -rup linux-2.6.13/mm/swap.c linux-2.6.13ra/mm/swap.c
--- linux-2.6.13/mm/swap.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/mm/swap.c	2005-09-15 14:29:11.000000000 +0800
@@ -96,6 +96,8 @@ int rotate_reclaimable_page(struct page 
 	return 0;
 }
 
+extern int readahead_ratio;
+
 /*
  * FIXME: speed this up?
  */
@@ -103,6 +105,11 @@ void fastcall activate_page(struct page 
 {
 	struct zone *zone = page_zone(page);
 
+	if (readahead_ratio > 9 || (readahead_ratio & 1)) {
+		SetPageActivate(page);
+		return;
+	}
+
 	spin_lock_irq(&zone->lru_lock);
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(zone, page);
@@ -122,7 +129,8 @@ void fastcall activate_page(struct page 
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+	if (!PageActive(page) && !PageActivate(page) &&
+			PageReferenced(page) && PageLRU(page)) {
 		activate_page(page);
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
diff -rup linux-2.6.13/mm/vmscan.c linux-2.6.13ra/mm/vmscan.c
--- linux-2.6.13/mm/vmscan.c	2005-08-29 07:41:01.000000000 +0800
+++ linux-2.6.13ra/mm/vmscan.c	2005-09-15 10:20:35.000000000 +0800
@@ -407,6 +407,9 @@ static int shrink_list(struct list_head 
 		if (PageWriteback(page))
 			goto keep_locked;
 
+		if (TestClearPageActivate(page))
+			goto activate_locked;
+
 		referenced = page_referenced(page, 1, sc->priority <= 0);
 		/* In active use or really unfreeable?  Activate it. */
 		if (referenced && page_mapping_inuse(page))

-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui
