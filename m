Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312576AbSELLXQ>; Sun, 12 May 2002 07:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312581AbSELLXP>; Sun, 12 May 2002 07:23:15 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:41864 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S312576AbSELLXN>; Sun, 12 May 2002 07:23:13 -0400
Message-Id: <5.1.0.14.2.20020512204053.03cc2eb8@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sun, 12 May 2002 21:23:55 +1000
To: Andrea Arcangeli <andrea@suse.de>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH]
  2.5.14IDE  56)
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020510143616.C13730@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:36 PM 10/05/2002 +0200, Andrea Arcangeli wrote:
>Can you also give a spin to the same benchmark with 2.4.19pre8aa2? It
>has the vary-io stuff from Badari and futher kiobuf optimization from
>Chuck. (vary-io will work only with aic and qlogic, enabling it is a one
>liner if the driver is just ok with variable bh->b_size in the same I/O
>request). right fix for avoiding the flood of small bh is bio in 2.5,
>for 2.4 vary-io should be fine.

2.4.19pre8aa2 booted with "profile=2" on dual P3-Xeon (733MHz), 2G PC133 
SDRAM, qlogic 2300 HBA (firmware 3.01.02 driver version 6.0b20).
8 x 15K RPM 18G FC disks are directly-attached using 2gbit/s FC (actually, 
its via a FC switch but that makes zero difference..).
kernel is set with PAGE_OFFSET_RAW at 8000000 (ie. no highmem defined)
no idea if the "vary-io" stuff is enabled for the qlogic driver or not -- 
some hints as to what to look for needed here..)
a clean reboot was done prior to each test.

the benchmark results, in summary:

   O_DIRECT      62.02 mbyte/sec (2048 x 1048576byte reads)
   /dev/rawN     52.31 mbyte/sec (2048 x 1048576byte reads)
   base: 127.71 mbyte/sec        (262144 x 8192byte reads)
   nocopy hack:  182.17 mbyte/sec        (262144 x 8192byte reads)


we can still say that:
  - 'nocopy' is still 50% faster than copy_to_user().  ie. overhead of 
copy_to_user worth
    ~60mbyte/sec and 18usec latency
  - O_DIRECT is superior to /dev/raw/rawN but is still a huge performance hit
    versus normal i/o on the block devices.

the benchmark results, in detail: (traces for each at bottom of email)

  - O_DIRECT and disk devices never touched (ie. no filesystem on them at all),
    2.4.19pre8aa2 performance is down slightly to 62mbyte/sec (compared to
    65mbyte/sec with 2.4.18):
         [root@mel-stglab-host1 src]# readprofile -r; \
         ./test_disk_performance blocks=2K bs=1m direct /dev/sd[e-l] > 
/tmp/direct.txt; \
         readprofile -v | sort -n -k4 >> /tmp/direct.txt
         Completed reading 16000 mbytes in 257.977850 seconds (62.02 
Mbytes/sec), 15867usec mean

  - i/o without O_DIRECT on 2.4.19pre8aa2 basically has DOUBLE the performance:
         [root@mel-stglab-host1 src]# readprofile -r; \
         ./test_disk_performance blocks=256K bs=8k /dev/sd[e-l] > 
/tmp/base.txt; \
         readprofile -v | sort -n -k4 >> /tmp/base.txt
         Completed reading 16000 mbytes in 125.288417 seconds (127.71 
Mbytes/sec), 59usec mean

  - same rest using i/o on /dev/raw/rawN instead:
         [root@mel-stglab-host1 src]# readprofile -r; \
         ./test_disk_performance blocks=2K bs=1m /dev/raw/raw[1-8] > 
/tmp/raw.txt; \
         readprofile -v | sort -n -k4 >> /tmp/raw.txt
         Completed reading 16000 mbytes in 305.878143 seconds (52.31 
Mbytes/sec), 18583usec mean

  - to round out the numbers, we still have a bogus file_read_actor() that 
doesn't actually
    do the copy_to_user, thereby showing the overhead associated with that:
         [root@mel-stglab-host1 src]# readprofile -r; \
         ./test_disk_performance blocks=256K bs=8k nocopy /dev/sd[e-l] > 
/tmp/nocopy.txt; \
         readprofile -v | sort -n -k4 >> /tmp/nocopy.txt
         Completed reading 16000 mbytes in 87.827854 seconds (182.17 
Mbytes/sec), 41usec mean


O_DIRECT:
         [root@mel-stglab-host1 src]# tail -20 /tmp/direct.txt
         8012a670 follow_page                                  25   0.1202
         8012a740 get_user_pages                               89   0.1918
         80136d40 __free_pages                                 10   0.2083
         801d28b0 generic_make_request                         83   0.2730
         8012aa50 mark_dirty_kiobuf                            35   0.3125
         8013f0e0 set_bh_page                                  22   0.3438
         8011f950 do_softirq                                   88   0.3929
         8023d670 sd_find_queue                                26   0.4062
         80142a10 max_block                                    54   0.4219
         80200fb0 __scsi_end_request                          165   0.5428
         80142c80 blkdev_get_block                             37   0.5781
         801405d0 brw_kiovec                                  581   0.6371
         80140560 wait_kio                                     90   0.8036
         80152820 end_kio_request                              76   0.9500
         801d29e0 submit_bh                                   181   1.6161
         8013e950 init_buffer                                  55   1.7188
         801d22a0 __make_request                             3073   1.9800
         8013dd10 unlock_buffer                               189   2.3625
         80140520 end_buffer_io_kiobuf                        408   6.3750
         80106d20 default_idle                              45686 713.8438

base:
         [root@mel-stglab-host1 src]# tail -20 /tmp/base.txt
         80133e60 kmem_cache_alloc                            249   0.9154
         80200fb0 __scsi_end_request                          291   0.9572
         80134fb0 delta_nr_inactive_pages                      93   0.9688
         801288b0 _spin_unlock_                               131   1.0234
         8013f380 create_empty_buffers                        107   1.1146
         80135010 delta_nr_cache_pages                        119   1.2396
         801d28b0 generic_make_request                        396   1.3026
         8013f0e0 set_bh_page                                 102   1.5938
         80108a48 system_call                                  91   1.6250
         801d29e0 submit_bh                                   185   1.6518
         801340e0 kmem_cache_free                             217   1.6953
         80140ea0 try_to_free_buffers                         664   1.9762
         801d22a0 __make_request                             3214   2.0709
         8012e0c0 unlock_page                                 283   2.2109
         801298cc .text.lock.lockmeter                        332   2.2432
         80136d40 __free_pages                                125   2.6042
         801287d0 _spin_lock_                                 585   5.2232
         8013e970 end_buffer_io_async                        1234   6.4271
         8012edd0 file_read_actor                            3732  33.3214
         80106d20 default_idle                               8875 138.6719

/dev/raw/rawN:
         [root@mel-stglab-host1 src]# tail -20 /tmp/raw.txt
         80122c50 tqueue_bh                                     4   0.1250
         8012a670 follow_page                                  33   0.1587
         8012a740 get_user_pages                              118   0.2543
         80203890 scsi_init_io_vc                             139   0.2555
         8012aa50 mark_dirty_kiobuf                            36   0.3214
         80136d40 __free_pages                                 22   0.4583
         8011f950 do_softirq                                  113   0.5045
         801d28b0 generic_make_request                        204   0.6711
         8013e950 init_buffer                                  34   1.0625
         8023d670 sd_find_queue                                70   1.0938
         8013f0e0 set_bh_page                                  74   1.1562
         80200fb0 __scsi_end_request                          365   1.2007
         801405d0 brw_kiovec                                 1288   1.4123
         80140560 wait_kio                                    193   1.7232
         80152820 end_kio_request                             166   2.0750
         801d29e0 submit_bh                                   347   3.0982
         8013dd10 unlock_buffer                               357   4.4625
         801d22a0 __make_request                            11014   7.0966
         80140520 end_buffer_io_kiobuf                        835  13.0469
         80106d20 default_idle                              45156 705.5625

nocopy hack:
         [root@mel-stglab-host1 src]# tail -20 /tmp/nocopy.txt
         8012dec0 page_cache_read                             197   0.7695
         80134fb0 delta_nr_inactive_pages                      77   0.8021
         80133e60 kmem_cache_alloc                            221   0.8125
         8013f020 get_unused_buffer_head                      182   0.9479
         801288b0 _spin_unlock_                               124   0.9688
         80135010 delta_nr_cache_pages                        110   1.1458
         8013f380 create_empty_buffers                        114   1.1875
         801d28b0 generic_make_request                        375   1.2336
         801d29e0 submit_bh                                   201   1.7946
         8013f0e0 set_bh_page                                 121   1.8906
         8012e0c0 unlock_page                                 254   1.9844
         80108a48 system_call                                 116   2.0714
         801d22a0 __make_request                             3234   2.0838
         80140ea0 try_to_free_buffers                         707   2.1042
         801340e0 kmem_cache_free                             272   2.1250
         801298cc .text.lock.lockmeter                        392   2.6486
         80136d40 __free_pages                                134   2.7917
         801287d0 _spin_lock_                                 636   5.6786
         8013e970 end_buffer_io_async                        1200   6.2500
         80106d20 default_idle                               5226  81.6562

