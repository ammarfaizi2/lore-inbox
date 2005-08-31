Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbVHaLzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbVHaLzF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 07:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbVHaLzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 07:55:05 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:5505 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S932413AbVHaLzD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 07:55:03 -0400
Date: Wed, 31 Aug 2005 11:54:41 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Jens Axboe <axboe@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <20050831072644.GF4018@suse.de>
Message-ID: <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Jens Axboe wrote:

> On Wed, Aug 31 2005, Vojtech Pavlik wrote:
>> On Tue, Aug 30, 2005 at 08:06:21PM +0000, Holger Kiehl wrote:
>>>>> How does one determine the PCI-X bus speed?
>>>>
>>>> Usually only the card (in your case the Symbios SCSI controller) can
>>>> tell. If it does, it'll be most likely in 'dmesg'.
>>>>
>>> There is nothing in dmesg:
>>>
>>>    Fusion MPT base driver 3.01.20
>>>    Copyright (c) 1999-2004 LSI Logic Corporation
>>>    ACPI: PCI Interrupt 0000:02:04.0[A] -> GSI 24 (level, low) -> IRQ 217
>>>    mptbase: Initiating ioc0 bringup
>>>    ioc0: 53C1030: Capabilities={Initiator,Target}
>>>    ACPI: PCI Interrupt 0000:02:04.1[B] -> GSI 25 (level, low) -> IRQ 225
>>>    mptbase: Initiating ioc1 bringup
>>>    ioc1: 53C1030: Capabilities={Initiator,Target}
>>>    Fusion MPT SCSI Host driver 3.01.20
>>>
>>>> To find where the bottleneck is, I'd suggest trying without the
>>>> filesystem at all, and just filling a large part of the block device
>>>> using the 'dd' command.
>>>>
>>>> Also, trying without the RAID, and just running 4 (and 8) concurrent
>>>> dd's to the separate drives could show whether it's the RAID that's
>>>> slowing things down.
>>>>
>>> Ok, I did run the following dd command in different combinations:
>>>
>>>    dd if=/dev/zero of=/dev/sd?1 bs=4k count=5000000
>>
>> I think a bs of 4k is way too small and will cause huge CPU overhead.
>> Can you try with something like 4M? Also, you can use /dev/full to avoid
>> the pre-zeroing.
>
> That was my initial thought as well, but since he's writing the io side
> should look correct. I doubt 8 dd's writing 4k chunks will gobble that
> much CPU as to make this much difference.
>
> Holger, we need vmstat 1 info while the dd's are running. A simple
> profile would be nice as well, boot with profile=2 and do a readprofile
> -r; run tests; readprofile > foo and send the first 50 lines of foo to
> this list.
>
Here vmstat for 8 dd's still with 4k blocksize:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
  9  2   5244  38272 7738248  10400    0    0     3 11444  390    24  0  5 75 20
  5 10   5244  30824 7747680   8684    0    0     0 265672 2582  1917  1 95  0  4
  2 12   5244  30948 7747248   8708    0    0     0 222620 2858   292  0 33  0 67
  4 10   5244  31072 7747516   8644    0    0     0 236400 3132   326  0 43  0 57
  2 12   5244  31320 7747792   8512    0    0     0 250204 3225   285  0 37  0 63
  1 13   5244  30948 7747412   8552    0    0    24 227600 3261   312  0 41  0 59
  2 12   5244  32684 7746124   8616    0    0     0 235392 3219   274  0 32  0 68
  1 13   5244  30948 7747940   8568    0    0     0 228020 3394   296  0 37  0 63
  0 14   5244  31196 7747680   8624    0    0     0 232932 3389   300  0 32  0 68
  3 12   5244  31072 7747904   8536    0    0     0 233096 3545   312  0 33  0 67
  1 13   5244  31072 7747852   8520    0    0     0 226992 3381   290  0 31  0 69
  1 13   5244  31196 7747704   8396    0    0     0 230112 3372   265  0 28  0 72
  0 14   5244  31072 7747928   8512    0    0     0 240652 3491   295  0 33  0 67
  3 13   5244  31072 7748104   8608    0    0     0 222944 3433   269  0 27  0 73
  1 13   5244  31072 7748000   8508    0    0     0 207944 3470   294  0 28  0 72
  0 14   5244  31072 7747980   8528    0    0     0 234608 3496   272  0 31  0 69
  2 12   5244  31196 7748148   8496    0    0     0 228760 3480   280  0 28  0 72
  0 14   5244  30948 7748568   8620    0    0     0 214372 3551   302  0 29  0 71
  1 13   5244  31072 7748392   8524    0    0     0 226732 3494   284  0 29  0 71
  0 14   5244  31072 7748004   8640    0    0     0 229628 3604   273  0 26  0 74
  1 13   5244  30948 7748392   8660    0    0     0 212868 3563   266  0 28  0 72
  1 13   5244  30948 7748600   8520    0    0     0 228244 3568   294  0 30  0 70
  1 13   5244  31196 7748228   8416    0    0     0 221692 3543   258  0 27  0 73
  1 13   5244  31072 7748192   8520    0    0     0 241040 3983   330  0 25  0 74
  1 13   5244  31196 7748288   8560    0    0     0 217108 3676   276  0 28  0 72
                              .
                              .
                              .
                This goses on up to the end.
                              .
                              .
                              .
  0  3   5244 825096 6949252   8596    0    0     0 241244 2683   223  0  7 71 22
  0  2   5244 825108 6949252   8596    0    0     0 229764 2683   214  0  7 73 20
  0  3   5244 826348 6949252   8596    0    0     0 116840 2046   450  0  4 71 26
  0  3   5244 826976 6949252   8596    0    0     0 141992 1887    97  0  4 73 23
  0  3   5244 827100 6949252   8596    0    0     0 137716 1871    93  0  4 70 26
  0  3   5244 827100 6949252   8596    0    0     0 137032 1894    96  0  4 75 21
  0  3   5244 827224 6949252   8596    0    0     0 131332 1860   288  0  4 73 23
  0  1   5244 1943732 5833756   8620    0    0     0 72404 1560   481  0 24 61 16
  0  2   5244 1943732 5833756   8620    0    0     0 71680 1450    60  0  2 61 38
  0  2   5244 1943736 5833756   8620    0    0     0 71680 1464    70  0  2 52 46
  0  2   5244 1943736 5833756   8620    0    0     0 66560 1436    66  0  2 50 48
  0  2   5244 1943984 5833756   8620    0    0     0 71680 1454    72  0  2 50 48
  0  2   5244 1943984 5833756   8620    0    0     0 71680 1450    70  0  2 50 48
  1  0   5244 2906484 4872176   8612    0    0     0 12760 1240   321  0 13 68 19
  0  0   5244 3306732 4472300   8580    0    0     0     0 1109    31  0  9 91  0
  0  0   5244 3306732 4472300   8580    0    0     0     0 1008    22  0  0 100  0

And here the profile output (I assume you meant sorted):

3236497 total                                      1.4547
2507913 default_idle                             52248.1875
158752 shrink_zone                               43.3275
121584 copy_user_generic_c                      3199.5789
  34271 __wake_up_bit                            713.9792
  31131 __make_request                            23.1629
  22096 scsi_request_fn                           18.4133
  21915 rotate_reclaimable_page                   80.5699
  20641 end_buffer_async_write                    86.0042
  18701 __clear_user                             292.2031
  13562 __block_write_full_page                   18.4266
  12981 test_set_page_writeback                   47.7243
  10772 kmem_cache_free                           96.1786
  10216 unlock_page                              159.6250
   9492 free_hot_cold_page                        32.9583
   9478 add_to_page_cache                         45.5673
   9117 page_waitqueue                            81.4018
   8671 drop_buffers                              38.7098
   8584 __set_page_dirty_nobuffers                31.5588
   8444 release_pages                             23.9886
   8204 scsi_dispatch_cmd                         14.2431
   8191 buffered_rmqueue                          11.6349
   7966 page_referenced                           22.6307
   7093 generic_file_buffered_write                4.1431
   6953 __pagevec_lru_add                         28.9708
   6740 __alloc_pages                              5.6926
   6369 __end_that_request_first                  11.7077
   5940 dnotify_parent                            30.9375
   5880 kmem_cache_alloc                          91.8750
   5797 submit_bh                                 19.0691
   4720 find_lock_page                            21.0714
   4612 __generic_file_aio_write_nolock            4.8042
   4559 __do_softirq                              20.3527
   4337 end_page_writeback                        54.2125
   4090 create_empty_buffers                      25.5625
   3985 bio_alloc_bioset                           9.2245
   3787 mempool_alloc                             12.4572
   3708 set_page_refs                            231.7500
   3545 __block_commit_write                      17.0433
   3037 system_call                               23.1832
   2968 zone_watermark_ok                         15.4583
   2966 cond_resched                              26.4821
   2828 generic_make_request                       4.7770
   2766 __mod_page_state                          86.4375
   2759 fget_light                                15.6761
   2692 test_clear_page_dirty                     11.2167
   2523 vfs_write                                  8.2993
   2406 generic_file_aio_write_nolock             15.0375
   2335 bio_put                                   36.4844
   2287 bad_range                                 23.8229

Under ftp://ftp.dwd.de/pub/afd/linux_kernel_debug/ I put the full vmstat
and profile output (also with -v). There is also dmesg and my kernel.config
from this system.

I will also do some test with 4M instead of 4k and as Al Boldi hinted
do a test together with some CPU load.

Thanks,
Holger

