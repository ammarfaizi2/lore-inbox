Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314842AbSEUPw5>; Tue, 21 May 2002 11:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314961AbSEUPw4>; Tue, 21 May 2002 11:52:56 -0400
Received: from [195.223.140.120] ([195.223.140.120]:50477 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S314842AbSEUPwy>; Tue, 21 May 2002 11:52:54 -0400
Date: Tue, 21 May 2002 17:51:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lincoln Dale <ltd@cisco.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT on 2.4.19pre8aa2 md device
Message-ID: <20020521155115.GK21806@dualathlon.random>
In-Reply-To: <5.1.0.14.2.20020514095214.040f5098@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au> <5.1.0.14.2.20020510155122.02d97910@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020510191214.018915f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020511125811.02bd29f0@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020514095214.040f5098@mira-sjcm-3.cisco.com> <5.1.0.14.2.20020514105002.03b54760@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 12:43:48PM +1000, Lincoln Dale wrote:
> g'day,
> 
> At 02:22 AM 14/05/2002 +0200, Andrea Arcangeli wrote:
> >I think raid0 is a good start to make all disks running at the same time
> >for O_DIRECT too (only make sure to use a buffer large nr_PV*512k or
> 
> same hardware as before -- dual P3 Xeon (733MHz), 133MHz FSB, 2G PC133 
> SDRAM.
> this time, a raid-0 array using MD driver across 8 x 18G 15K RPM disks.  md 
> driver is using "128k chunks".
> 
> kernel is 2.4.19pre8aa2 with the qlogic 2300 HBA driver compiled with 
> vary_io set to 1.  FC network is all 2gbit/s.  no highmem.
> kernel is booted using "profile=2" and has lockmeter compiled in also.
> system rebooted after each test.
> 
> i promise its the same amount of data for each test this time: :-)
>   O_DIRECT      blocksize = 4 megabytes, blocks = 28000: 112000 mbytes in 

btw, since you've 8 disks it probably would be a bit faster with 8meg,
so you submit at least 2 scsi commands for each disk at the same time,
not only 1.

> 977.869706 seconds (120.10 Mbytes/sec)
>   'raw'         blocksize = 4 megabytes, blocks = 28000: 112000 mbytes in 
> 1659.551271 seconds (70.77 Mbytes/sec)
>   base          blocksize = 8 kilobytes, blocks = 14336000: 112000 mbytes 
> in  918.287570 seconds (127.89 Mbytes/sec)

120 vs 127 is pretty good, also considering an 8meg buffer may be enough
to give you such 7 mbyte/sec back too.

>   nocopy hack:  blocksize = 8 kilobytes, blocks = 14336000: 112000 mbytes 
> in 671.560772 seconds (174.88 Mbytes/sec)
> 
> net-effect is that O_DIRECT still has a performance hit versus base, 'raw' 

yes, a performance hit in absolute disk performance is expected due the
additional synchronization after each read/write syscall returns (the
synchronous beahviour), if the mem bandwith is very high and the mem
bandwith and cpu is otherwise unused, so if the machine is completly
dedicated to I/O and the mem bandwith is high. But look at the
profiling...

> just sucks wind versus the others, even 'nocopy' cannot hit line-rate on 
> the fibre-channel card.  (its possible to hit 205mbytes/sec using sg_tools 
> sg_read or sg_dd).
> 
> 
> O_DIRECT:
>         [root@mel-stglab-host1 src]# readprofile -r; 
> ./test_disk_performance bs=4m blocks=28000 direct /dev/md0 > 
> /tmp/vary_direct.txt; readprofile -v | sort -n -k4 >> /tmp/vary_direct.txt
>         Completed reading 112000 mbytes in 977.869706 seconds (120.10 
> Mbytes/sec), 34849usec mean
> 
>         [root@mel-stglab-host1 tmp]# tail -20 vary_direct.txt
>         8012aa50 mark_dirty_kiobuf                           234   2.0893
>         8013f0e0 set_bh_page                                 134   2.0938
>         801d28b0 generic_make_request                        785   2.5822
>         80136d40 __free_pages                                137   2.8542
>         80142a10 max_block                                   406   3.1719
>         8011f950 do_softirq                                  724   3.2321
>         801405d0 brw_kiovec                                 3219   3.5296
>         80271370 md_make_request                             484   4.3214
>         80200fb0 __scsi_end_request                         1321   4.3454
>         8023d670 sd_find_queue                               334   5.2188
>         80142c80 blkdev_get_block                            358   5.5938
>         80140560 wait_kio                                    690   6.1607
>         80152820 end_kio_request                             601   7.5125
>         80267320 raid0_make_request                         3059   9.1042
>         8013e950 init_buffer                                 310   9.6875
>         801d29e0 submit_bh                                  1274  11.3750
>         801d22a0 __make_request                            20967  13.5097
>         8013dd10 unlock_buffer                              1283  16.0375
>         80140520 end_buffer_io_kiobuf                       2946  46.0312
>         80106d20 default_idle                             151886 2373.2188

here you see the machine was basically idle for the whole time.

> base:
>         [root@mel-stglab-host1 src]# readprofile -r; 
> ./test_disk_performance bs=8k blocks=14336000 /dev/md0 > 
> /tmp/vary_base.txt; readprofile -v | sort -n -k4 >> /tmp/vary_base.txt
>         Completed reading 112000 mbytes in 918.287570 seconds (127.89 
> Mbytes/sec), 63usec mean
> 
>         [root@mel-stglab-host1 src]# tail -20 /tmp/vary_base.txt
>         80135010 delta_nr_cache_pages                        591   6.1562
>         80203890 scsi_init_io_vc                            3448   6.3382
>         801288b0 _spin_unlock_                               894   6.9844
>         8013f380 create_empty_buffers                        717   7.4688
>         80133e60 kmem_cache_alloc                           2152   7.9118
>         80267320 raid0_make_request                         3125   9.3006
>         801d28b0 generic_make_request                       2861   9.4112
>         801d29e0 submit_bh                                  1304  11.6429
>         8013f0e0 set_bh_page                                 795  12.4219
>         80108a48 system_call                                 766  13.6786
>         801d22a0 __make_request                            23675  15.2545
>         8012e0c0 unlock_page                                1990  15.5469
>         80140ea0 try_to_free_buffers                        5294  15.7560
>         801340e0 kmem_cache_free                            2563  20.0234
>         80136d40 __free_pages                               1012  21.0833
>         801298cc .text.lock.lockmeter                       3129  21.1419
>         801287d0 _spin_lock_                                4097  36.5804
>         8013e970 end_buffer_io_async                        9310  48.4896
>         8012edd0 file_read_actor                           26102 233.0536
>         80106d20 default_idle                              59883 935.6719

and here the machine was almost completly loaded in the file_read_actor,
it was unusable for anything other than I/O.

To make a similar example my first pentium had a very slow harddisk that
in DMA mode was running 10/20% slower than in PIO mode, but the cpu
utilization of the DMA mode was so much lower that DMA was an huge
global win during kernel compiles etc...

In any real usage where I/O is combined with CPU and mem bus utilization
for computations, not only to move data from disk to userspace memory
O_DIRECT is an _huge_ win as you found out. You have 100000 more usable
ticks for computations over 150000 total ticks.  I didn't do exact math
but a rough measure is that with "buffered I/O" (i.e. base) only around
20% of the cpu was available for doing useful things, with O_DIRECT the
90% of the cpu is available for doing useful things, not to tell the
difference in membus utilization. So I think the improvement of O_DIRECT
is just huge and pays off as I also mentioned in an erarlier email in
this thread, even if the absolute I/O performance may decrease of a few
point percent due the synchronous behaviour (and one of the items for
2.5 is to optionally make the synchronous behaviour to go away, plus
providing a generic_direct_IO that synchronizes with the pagecache via
anchors and so allows O_DIRECT to be used with data journaling too).

And again, if you use larger buffers you may be able to fix also the
last 8mbyte/sec difference :).

Andrea
