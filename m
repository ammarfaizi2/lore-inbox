Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSEMLhM>; Mon, 13 May 2002 07:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSEMLhL>; Mon, 13 May 2002 07:37:11 -0400
Received: from [195.223.140.120] ([195.223.140.120]:31584 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293337AbSEMLhK>; Mon, 13 May 2002 07:37:10 -0400
Date: Mon, 13 May 2002 13:37:18 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14IDE  56)
Message-ID: <20020513133718.R13730@dualathlon.random>
In-Reply-To: <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020512204053.03cc2eb8@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 09:23:55PM +1000, Lincoln Dale wrote:
> O_DIRECT:
>         [root@mel-stglab-host1 src]# tail -20 /tmp/direct.txt
>         8012a670 follow_page                                  25   0.1202
>         8012a740 get_user_pages                               89   0.1918

follow-page and get_user_pages is the actual cpu cost of walking the
pagetables. that could be trimmed down by wasting some memory for an
efficient software-kernel-side tlb.

>         80136d40 __free_pages                                 10   0.2083
>         801d28b0 generic_make_request                         83   0.2730
>         8012aa50 mark_dirty_kiobuf                            35   0.3125
>         8013f0e0 set_bh_page                                  22   0.3438
>         8011f950 do_softirq                                   88   0.3929
>         8023d670 sd_find_queue                                26   0.4062
>         80142a10 max_block                                    54   0.4219
>         80200fb0 __scsi_end_request                          165   0.5428
>         80142c80 blkdev_get_block                             37   0.5781
>         801405d0 brw_kiovec                                  581   0.6371
>         80140560 wait_kio                                     90   0.8036
>         80152820 end_kio_request                              76   0.9500
>         801d29e0 submit_bh                                   181   1.6161
>         8013e950 init_buffer                                  55   1.7188
>         801d22a0 __make_request                             3073   1.9800
>         8013dd10 unlock_buffer                               189   2.3625
>         80140520 end_buffer_io_kiobuf                        408   6.3750
>         80106d20 default_idle                              45686 713.8438

the cpu cost is much smaller than base as you can see and most of it
will be optimized away with vary-io that should lead to follow_page and
get_user_pages to move down in the above profiling.

> 
> base:
>         [root@mel-stglab-host1 src]# tail -20 /tmp/base.txt
>         80133e60 kmem_cache_alloc                            249   0.9154
>         80200fb0 __scsi_end_request                          291   0.9572
>         80134fb0 delta_nr_inactive_pages                      93   0.9688
>         801288b0 _spin_unlock_                               131   1.0234
>         8013f380 create_empty_buffers                        107   1.1146
>         80135010 delta_nr_cache_pages                        119   1.2396
>         801d28b0 generic_make_request                        396   1.3026
>         8013f0e0 set_bh_page                                 102   1.5938
>         80108a48 system_call                                  91   1.6250
>         801d29e0 submit_bh                                   185   1.6518
>         801340e0 kmem_cache_free                             217   1.6953
>         80140ea0 try_to_free_buffers                         664   1.9762
>         801d22a0 __make_request                             3214   2.0709
>         8012e0c0 unlock_page                                 283   2.2109
>         801298cc .text.lock.lockmeter                        332   2.2432
>         80136d40 __free_pages                                125   2.6042
>         801287d0 _spin_lock_                                 585   5.2232
>         8013e970 end_buffer_io_async                        1234   6.4271
>         8012edd0 file_read_actor                            3732  33.3214
>         80106d20 default_idle                               8875 138.6719

as expected the biggest cost is file_read_actor.

Both profiling looks fine, as expected.


> /dev/raw/rawN:
>         [root@mel-stglab-host1 src]# tail -20 /tmp/raw.txt
>         80122c50 tqueue_bh                                     4   0.1250
>         8012a670 follow_page                                  33   0.1587
>         8012a740 get_user_pages                              118   0.2543
>         80203890 scsi_init_io_vc                             139   0.2555
>         8012aa50 mark_dirty_kiobuf                            36   0.3214
>         80136d40 __free_pages                                 22   0.4583
>         8011f950 do_softirq                                  113   0.5045
>         801d28b0 generic_make_request                        204   0.6711
>         8013e950 init_buffer                                  34   1.0625
>         8023d670 sd_find_queue                                70   1.0938
>         8013f0e0 set_bh_page                                  74   1.1562
>         80200fb0 __scsi_end_request                          365   1.2007
>         801405d0 brw_kiovec                                 1288   1.4123
>         80140560 wait_kio                                    193   1.7232
>         80152820 end_kio_request                             166   2.0750
>         801d29e0 submit_bh                                   347   3.0982
>         8013dd10 unlock_buffer                               357   4.4625
>         801d22a0 __make_request                            11014   7.0966
>         80140520 end_buffer_io_kiobuf                        835  13.0469
>         80106d20 default_idle                              45156 705.5625

expected again, as you can see the cost goes quite up for __make_request
compared to O_DIRECT due the 512 b_size (raw compared to base is unfair
because base uses 1k b_size and raw uses 512 b_size and that's why it's
wasting so much cpu time there, o_direct vs base is instead fair because
they both uses 1k of b_size, once o_direct will take advantage of varyio
in your upgraded driver, the comparison between o_direct vs base will
become unfair too, o_direct will be more advantaged by a virtual-common
4k b_size)


> nocopy hack:
>         [root@mel-stglab-host1 src]# tail -20 /tmp/nocopy.txt
>         8012dec0 page_cache_read                             197   0.7695
>         80134fb0 delta_nr_inactive_pages                      77   0.8021
>         80133e60 kmem_cache_alloc                            221   0.8125
>         8013f020 get_unused_buffer_head                      182   0.9479
>         801288b0 _spin_unlock_                               124   0.9688
>         80135010 delta_nr_cache_pages                        110   1.1458
>         8013f380 create_empty_buffers                        114   1.1875
>         801d28b0 generic_make_request                        375   1.2336
>         801d29e0 submit_bh                                   201   1.7946
>         8013f0e0 set_bh_page                                 121   1.8906
>         8012e0c0 unlock_page                                 254   1.9844
>         80108a48 system_call                                 116   2.0714
>         801d22a0 __make_request                             3234   2.0838
>         80140ea0 try_to_free_buffers                         707   2.1042
>         801340e0 kmem_cache_free                             272   2.1250
>         801298cc .text.lock.lockmeter                        392   2.6486
>         80136d40 __free_pages                                134   2.7917
>         801287d0 _spin_lock_                                 636   5.6786
>         8013e970 end_buffer_io_async                        1200   6.2500
>         80106d20 default_idle                               5226  81.6562

very similar to o_direct, notice the overhead in _spin_lock_ here (and
also in "base") it's certainly the page_cache lock that won't go away in
2.5 with radix tree because you're working on the same file, higher
bandwith because the disks runs at the same time and possibly because
read/write returns faster and part of the cost of the I/O happens
outside your time measurements (for a more fair comparison you can
benchmark the whole workload, not only how fast read/write returns).

Andrea
