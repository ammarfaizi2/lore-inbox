Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbUJZBTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbUJZBTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUJZBRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:17:40 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36305 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261868AbUJZBOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:14:31 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Buffered write slowness
User-Agent: KMail/1.7
MIME-Version: 1.0
X-Length: 11989
Date: Mon, 25 Oct 2004 18:14:23 -0700
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vTafBmncvHrsLeH"
Message-Id: <200410251814.23273.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_vTafBmncvHrsLeH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've been doing some simple disk I/O benchmarking with an eye towards 
improving large, striped volume bandwidth.  I ran some tests on individual 
disks and filesystems to establish a baseline and found that things generally 
scale quite well:

o one thread/disk using O_DIRECT on the block device
  read avg: 2784.81 MB/s
  write avg: 2585.60 MB/s

o one thread/disk using O_DIRECT + filesystem
  read avg: 2635.98 MB/s
  write avg: 2573.39 MB/s

o one thread/disk using buffered I/O + filesystem
  read w/default (128) block/*/queue/read_ahead_kb avg: 2626.25 MB/s
  read w/max (4096) block/*/queue/read_ahead_kb avg: 2652.62 MB/s
  write avg: 1394.99 MB/s

Configuration:
  o 8p sn2 ia64 box
  o 8GB memory
  o 58 disks across 16 controllers
    (4 disks for 10 of them and 3 for the other 6)
  o aggregate I/O bw available is about 2.8GB/s

Test:
  o one I/O thread per disk, round robined across the 8 CPUs
  o each thread did ~450MB of I/O depending on the test (ran for 10s)
    Note: the total was > 8GB so in the buffered read case not everything
    could be cached

As you can see, for a test that does one thread/disk things look really good 
(very close to the available bandwidth in the system) with the exception of 
buffered writes.  I've attached the vmstat and profile from that run in case 
anyone's interested.  It seems that there was some spinlock contention in 
that run that wasn't present in other runs.

Preliminary runs on a large volume showed that a single thread reading from a 
striped volume w/O_DIRECT performed poorly, while a single thread writing to 
a volume the same way was able to get slightly over 1GB/s.  Using multiple 
read threads against the volume increased the bandwidth to near 1GB/s, but 
multiple threads writing slightly slowed performance.  My tests and the 
system configuration have changed slightly though, so don't put much stock in 
these numbers until I rerun them (and collect profiles and such).

Thanks,
Jesse

P.S. The 'dev-fs' in the filenames doesn't mean I was using devfs (I wasn't, 
not that it should matter), just that I was running per-dev tests with a 
filesystem. :)

--Boundary-00=_vTafBmncvHrsLeH
Content-Type: text/plain;
  charset="us-ascii";
  name="profile-buffered-write-dev-fs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="profile-buffered-write-dev-fs.txt"

598157 total                                      0.1052
132002 _spin_unlock_irq                         2062.5312
 87219 ia64_pal_call_static                     454.2656
 72515 default_idle                             161.8638
 60019 __copy_user                               25.3459
 37898 ia64_spinlock_contention                 394.7708
 32167 _spin_unlock_irqrestore                  335.0729
 15351 kmem_cache_free                           39.9766
 11585 smp_call_function                         10.3438
 10047 kmem_cache_alloc                          39.2461
 10007 ia64_save_scratch_fpregs                 156.3594
  9994 ia64_load_scratch_fpregs                 156.1562
  7125 bio_put                                   24.7396
  6540 __end_that_request_first                   5.5236
  6064 shrink_list                                1.3345
  5829 buffered_rmqueue                           3.1406
  5137 mempool_alloc                              4.8646
  4986 set_bh_page                               17.3125
  4261 bio_alloc                                  3.0967
  4069 end_bio_bh_io_sync                         9.0826
  3906 submit_bh                                  4.3594
  3653 wake_up_page                              28.5391
  3607 drop_buffers                               6.6305
  3381 __might_sleep                              5.5609
  3335 free_hot_cold_page                         3.2568
  3157 writeback_inodes                           3.5234
  3105 __alloc_pages                              1.2937
  2533 submit_bio                                 3.0445
  2486 __block_prepare_write                      0.9033
  2335 mark_buffer_async_write                   18.2422

--Boundary-00=_vTafBmncvHrsLeH
Content-Type: text/plain;
  charset="us-ascii";
  name="vmstat-buffered-write-dev-fs.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vmstat-buffered-write-dev-fs.txt"

[root@junkbond ~]# vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0   2544 230240   1040 6981472    0    0  4342 10272    7    77  0  4 93  3
 0  0   2544 231776   1040 6981472    0    0    24 16515 8529   143  0  0 100  0
 0  0   2544 230880   1040 6981472    0    0    64 276273 10068    96  0  4 96  0
63  0   2544  14176   1040 7196128    0    0    24 303435 13281   216  0 12 88  0
62  1   2544   8736   1104 7187808    0    0    72 755830 51021  5716  0 100  0  0
63  2   2544   5728    656 7182064    0    0     4 1330749 79954 10109  0 100  0  0
61 17   2544   9056    672 7107744    0    0   104 2905708 68129  8461  0 100  0  0
58 23   2544   6368    672 7052016    0    0    64 2432964 66482  6400  0 100  0  0
60 25   2544  14816    848 7025008    0    0   428 1755180 68765  8282  0 100  0  0
57 20   2544   5856    448 7021280    0    0    72 1216548 63333  7905  0 100  0  0
58 17   2544  10272    448 7006832    0    0    32 1097956 61771  8779  0 100  0  0
57 10   2544   8224    624 7010784    0    0   464 1083460 60803  6123  0 100  0  0
62 14   2544   5792    464 7015072    0    0   100 1005260 63960  5773  0 100  0  0
 5  1   2544  14912    752 7000336    0    0   620 1060772 60624  5679  0 98  1  0
 0  1   2544  14784    976 6998048    0    0   856 63972 16941  3954  1 16 70 13
 0  0   2544  14720    976 6998048    0    0    16  4920 14865  1285  0  9 82  9
 0  1   2544  14784    976 6998048    0    0     8 23728 13974    40  0  7 93  0
 0  1   2544  15040    976 6998048    0    0     0 18432 14097   847  0  8 81 11
63  1   2544   8640   1040 7008304    0    0    64 140656 39666  2799  0 40 52  8
59  1   2544  11328   1008 7004208    0    0    80 915952 64727  8821  0 100  0  0
62  7   2544   9952    448 7015088    0    0    64 2327688 76873  9117  0 100  0  0
60 12   2544   6688    448 7013024    0    0    32 2457992 66550  8099  0 100  0  0
61 15   2544   8032    448 7010960    0    0    80 1851480 66455  7185  0 100  0  0
60 18   2544   6144    448 6994448    0    0    80 1488552 70833  8758  0 100  0  0
60 13   2544   7456    448 6984128    0    0    32 1207904 65113  7116  0 100  0  0
58 10   2544   5664    448 6982064    0    0    32 985696 64674  7964  0 100  0  0
60 21   2544   7840    448 6984128    0    0    64 976540 61481  7015  0 100  0  0
59 15   2544   8736    448 6982064    0    0    88 869564 60383  6613  0 100  0  0
61 11   2544   7616    736 6981776    0    0   592 1183640 63801  7145  0 100  0  0
 4  1   2544  85376    896 6971296    0    0   924 193617 22851  4451  1 27 62 11
 0  1   2544  11904    896 6971296    0    0    12     0 14137  1325  0 10 79 11
 0  1   2544  11840    896 6971296    0    0     0     6 13729   446  0  7 82 11
 0  1   2544  11968    896 6971296    0    0     0     2 13719   952  0  7 82 11
 0  1   2544  12160    960 6971232    0    0     8    69 12409   858  0  6 82 12
57  1   2544  13312    960 6971232    0    0    96 686610 58996  5417  0 97  3  0
58  1   2544  11008    448 6980000    0    0   104 1973020 81572 12784  0 100  0  0
60 19   2544   9632    448 6977936    0    0    88 2302016 74034  9208  0 100  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
62 20   2544  11872    448 6984128    0    0    48 1914352 71746  8483  0 100  0  0
56 22   2544   5472    448 6984128    0    0    56 1413780 68497  7051  0 100  0  0
60 12   2544  10912    448 6980000    0    0   112 1076532 67341  7422  0 100  0  0
59 19   2544   5984    448 6984128    0    0    56 1129136 69899  7353  0 100  0  0
55 19   2544   9696    448 6980000    0    0    48 1113548 72296  6531  0 100  0  0
65 15   2544   7584    448 6984128    0    0    32 1028156 66183  8963  0 100  0  0
62 26   2544   9728    784 6977600    0    0   604 997204 69320 10154  0 100  0  0
 0  4   2544  29376    864 6963072    0    0   836 49804 17486  5250  1 28 31 40
 0  1   2544  29376    864 6963072    0    0     0 24856 15374   952  0 10 76 14
 0  1   2544  29376    864 6963072    0    0     0     0 14715  1532  0  9 80 11
 0  1   2544  29312    864 6963072    0    0     8 18856 13580   735  0  8 85  7
64  2   2544   8768    928 6981584    0    0   104 422060 54309  2831  0 68 28  4
56  1   2544   6592    576 6986064    0    0    48 1364520 75387  8135  0 100  0  0
63 24   2544   7776    448 6990320    0    0    56 2284556 66785  9020  0 100  0  0
57 33   2544   5536    448 6988256    0    0    80 1774088 62152  9677  0 100  0  0
58 19   2544   8992    448 6988256    0    0    40 1671936 70438  7714  0 100  0  0
58 15   2544   7520    448 6984128    0    0    48 1333652 69927  6837  0 100  0  0
56 10   2544   9824    448 6988256    0    0    16 1095912 73715  7797  0 100  0  0
58  7   2544   7008    448 6982064    0    0    56 1167724 67655  6401  0 100  0  0
57 10   2544   8480    448 6986192    0    0     8 915948 69804  6384  0 100  0  0
56 11   2544   7392    448 6986192    0    0    32 998204 69488  6417  0 100  0  0
59 13   2544   7296    528 6988176    0    0   196 1001173 68362  6354  0 100  0  0
 6  2   2544  14528    784 6977600    0    0   440 277287 25760  5077  0 35 44 21
 1  1   2544  13184    944 6965056    0    0   844  6335 15959  3621  1 16 70 13
 0  1   2544  13120    944 6965056    0    0     0     2 13599   833  0  7 81 11
 0  1   2544  13120    944 6965056    0    0     0    11 13051  1347  0  7 82 11
 0  1   2544  13056   1008 6964992    0    0     8    80 11969   858  0  5 83 12
59  1   2544   9984    992 6971200    0    0   128 874215 69268  7155  0 83 14  2
61  2   2544   7712    480 6975840    0    0    40 1739593 73008 12486  0 100  0  0
61 18   2544   5536    448 6977936    0    0   128 2176972 67952  9666  0 100  0  0
59 19   2544   5792    448 6973808    0    0    64 2008752 68552  7674  0 100  0  0
57 24   2544   8288    448 6973808    0    0    80 1561368 71155  8361  0 100  0  0
63 14   2544  11744    448 6971744    0    0    96 1349620 71476  7671  0 100  0  0
60 17   2544   5856    448 6967616    0    0    64 958588 66934  5707  0 100  0  0
56 15   2544   6560    448 6967616    0    0   112 1061172 71689  7726  0 100  0  0
57  8   2544   6176    448 6969680    0    0    48 948800 70414  7758  0 100  0  0
62 10   2544   8704    704 6969424    0    0   596 959484 66082  8013  0 100  0  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  3   2544  23872    656 6957088    0    0   144 613012 47183  8732  0 72 17 11
 0  1   2544 112000    896 6956848    0    0  1220 48532 14407  3578  2 14 58 26
 0  1   2544 112000    896 6956848    0    0     0     0 13582   995  0  8 81 11

--Boundary-00=_vTafBmncvHrsLeH--
