Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315120AbSENCm6>; Mon, 13 May 2002 22:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315130AbSENCm5>; Mon, 13 May 2002 22:42:57 -0400
Received: from sj-msg-core-2.cisco.com ([171.69.24.11]:12004 "EHLO
	sj-msg-core-2.cisco.com") by vger.kernel.org with ESMTP
	id <S315120AbSENCmy>; Mon, 13 May 2002 22:42:54 -0400
Message-Id: <5.1.0.14.2.20020514105002.03b54760@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 14 May 2002 12:43:48 +1000
To: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: O_DIRECT on 2.4.19pre8aa2 md device
In-Reply-To: <20020514022238.J22902@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

g'day,

At 02:22 AM 14/05/2002 +0200, Andrea Arcangeli wrote:
>I think raid0 is a good start to make all disks running at the same time
>for O_DIRECT too (only make sure to use a buffer large nr_PV*512k or

same hardware as before -- dual P3 Xeon (733MHz), 133MHz FSB, 2G PC133 SDRAM.
this time, a raid-0 array using MD driver across 8 x 18G 15K RPM disks.  md 
driver is using "128k chunks".

kernel is 2.4.19pre8aa2 with the qlogic 2300 HBA driver compiled with 
vary_io set to 1.  FC network is all 2gbit/s.  no highmem.
kernel is booted using "profile=2" and has lockmeter compiled in also.
system rebooted after each test.

i promise its the same amount of data for each test this time: :-)
   O_DIRECT      blocksize = 4 megabytes, blocks = 28000: 112000 mbytes in 
977.869706 seconds (120.10 Mbytes/sec)
   'raw'         blocksize = 4 megabytes, blocks = 28000: 112000 mbytes in 
1659.551271 seconds (70.77 Mbytes/sec)
   base          blocksize = 8 kilobytes, blocks = 14336000: 112000 mbytes 
in  918.287570 seconds (127.89 Mbytes/sec)
   nocopy hack:  blocksize = 8 kilobytes, blocks = 14336000: 112000 mbytes 
in 671.560772 seconds (174.88 Mbytes/sec)

net-effect is that O_DIRECT still has a performance hit versus base, 'raw' 
just sucks wind versus the others, even 'nocopy' cannot hit line-rate on 
the fibre-channel card.  (its possible to hit 205mbytes/sec using sg_tools 
sg_read or sg_dd).


O_DIRECT:
         [root@mel-stglab-host1 src]# readprofile -r; 
./test_disk_performance bs=4m blocks=28000 direct /dev/md0 > 
/tmp/vary_direct.txt; readprofile -v | sort -n -k4 >> /tmp/vary_direct.txt
         Completed reading 112000 mbytes in 977.869706 seconds (120.10 
Mbytes/sec), 34849usec mean

         [root@mel-stglab-host1 tmp]# tail -20 vary_direct.txt
         8012aa50 mark_dirty_kiobuf                           234   2.0893
         8013f0e0 set_bh_page                                 134   2.0938
         801d28b0 generic_make_request                        785   2.5822
         80136d40 __free_pages                                137   2.8542
         80142a10 max_block                                   406   3.1719
         8011f950 do_softirq                                  724   3.2321
         801405d0 brw_kiovec                                 3219   3.5296
         80271370 md_make_request                             484   4.3214
         80200fb0 __scsi_end_request                         1321   4.3454
         8023d670 sd_find_queue                               334   5.2188
         80142c80 blkdev_get_block                            358   5.5938
         80140560 wait_kio                                    690   6.1607
         80152820 end_kio_request                             601   7.5125
         80267320 raid0_make_request                         3059   9.1042
         8013e950 init_buffer                                 310   9.6875
         801d29e0 submit_bh                                  1274  11.3750
         801d22a0 __make_request                            20967  13.5097
         8013dd10 unlock_buffer                              1283  16.0375
         80140520 end_buffer_io_kiobuf                       2946  46.0312
         80106d20 default_idle                             151886 2373.2188

'raw':
         [root@mel-stglab-host1 src]# readprofile -r; 
./test_disk_performance bs=4m blocks=28000 /dev/raw/raw1 > 
/tmp/vary_raw.txt; readprofile -v | sort -n -k4 >> /tmp/vary_raw.txt
         Completed reading 112000 mbytes in 1659.551271 seconds (70.77 
Mbytes/sec), 59167usec mean

         [root@mel-stglab-host1 src]# tail -20 /tmp/vary_raw.txt
         8012a740 get_user_pages                              636   1.3707
         80203890 scsi_init_io_vc                             989   1.8180
         80136d40 __free_pages                                126   2.6250
         8012aa50 mark_dirty_kiobuf                           300   2.6786
         8011f950 do_softirq                                  836   3.7321
         801d28b0 generic_make_request                       1727   5.6809
         8013e950 init_buffer                                 237   7.4062
         801405d0 brw_kiovec                                 7164   7.8553
         80200fb0 __scsi_end_request                         2574   8.4671
         8023d670 sd_find_queue                               602   9.4062
         80140560 wait_kio                                   1155  10.3125
         80271370 md_make_request                            1176  10.5000
         8013f0e0 set_bh_page                                 799  12.4844
         80152820 end_kio_request                            1084  13.5500
         80267320 raid0_make_request                         5904  17.5714
         801d29e0 submit_bh                                  2426  21.6607
         8013dd10 unlock_buffer                              2540  31.7500
         801d22a0 __make_request                            77413  49.8795
         80140520 end_buffer_io_kiobuf                       5540  86.5625
         80106d20 default_idle                             214369 3349.5156


base:
         [root@mel-stglab-host1 src]# readprofile -r; 
./test_disk_performance bs=8k blocks=14336000 /dev/md0 > 
/tmp/vary_base.txt; readprofile -v | sort -n -k4 >> /tmp/vary_base.txt
         Completed reading 112000 mbytes in 918.287570 seconds (127.89 
Mbytes/sec), 63usec mean

         [root@mel-stglab-host1 src]# tail -20 /tmp/vary_base.txt
         80135010 delta_nr_cache_pages                        591   6.1562
         80203890 scsi_init_io_vc                            3448   6.3382
         801288b0 _spin_unlock_                               894   6.9844
         8013f380 create_empty_buffers                        717   7.4688
         80133e60 kmem_cache_alloc                           2152   7.9118
         80267320 raid0_make_request                         3125   9.3006
         801d28b0 generic_make_request                       2861   9.4112
         801d29e0 submit_bh                                  1304  11.6429
         8013f0e0 set_bh_page                                 795  12.4219
         80108a48 system_call                                 766  13.6786
         801d22a0 __make_request                            23675  15.2545
         8012e0c0 unlock_page                                1990  15.5469
         80140ea0 try_to_free_buffers                        5294  15.7560
         801340e0 kmem_cache_free                            2563  20.0234
         80136d40 __free_pages                               1012  21.0833
         801298cc .text.lock.lockmeter                       3129  21.1419
         801287d0 _spin_lock_                                4097  36.5804
         8013e970 end_buffer_io_async                        9310  48.4896
         8012edd0 file_read_actor                           26102 233.0536
         80106d20 default_idle                              59883 935.6719

nocopy hack:
         [root@mel-stglab-host1 src]# readprofile -r; 
./test_disk_performance bs=8k blocks=14336000 nocopy /dev/md0 > 
/tmp/vary_nocopy.txt; readprofile -v | sort -n -k4 >> /tmp/vary_nocopy.txt
         Completed reading 112000 mbytes in 671.560772 seconds (174.88 
Mbytes/sec), 46usec mean

         [root@mel-stglab-host1 src]# tail -20 /tmp/vary_nocopy.txt
         8013f020 get_unused_buffer_head                     1152   6.0000
         80134fb0 delta_nr_inactive_pages                     583   6.0729
         80135010 delta_nr_cache_pages                        617   6.4271
         801288b0 _spin_unlock_                               854   6.6719
         80133e60 kmem_cache_alloc                           2154   7.9191
         8013f380 create_empty_buffers                        785   8.1771
         80267320 raid0_make_request                         3112   9.2619
         801d28b0 generic_make_request                       2876   9.4605
         801d29e0 submit_bh                                  1293  11.5446
         8013f0e0 set_bh_page                                 759  11.8594
         80108a48 system_call                                 778  13.8929
         8012e0c0 unlock_page                                1814  14.1719
         80140ea0 try_to_free_buffers                        4908  14.6071
         801d22a0 __make_request                            23997  15.4620
         801340e0 kmem_cache_free                            2562  20.0156
         80136d40 __free_pages                                980  20.4167
         801298cc .text.lock.lockmeter                       3411  23.0473
         801287d0 _spin_lock_                                4099  36.5982
         8013e970 end_buffer_io_async                        8741  45.5260
         80106d20 default_idle                              39093 610.8281


cheers,

lincoln.

