Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUF3UdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUF3UdU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUF3UdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:33:20 -0400
Received: from ns0.cobite.com ([208.222.80.10]:17561 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id S262329AbUF3Uc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:32:57 -0400
Subject: ext3 (?) performance problems on 2.6 kernels
From: David Mansfield <lkml@dm.cobite.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1088627575.2784.263.camel@dhcp07.cobite.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 30 Jun 2004 16:32:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have an odd performance problem to report.  

The problem is when writing to an ext3 partition (root partition,
created by FC2 install), the performance drops drastically after about
15 seconds (750GB of data written).   It drops from 50MB/sec (and ~10%
of a single CPU of system time) to 20MB/sec (and 100% of a single CPU of
system time).  It goes from I/O bound to 100% cpu bound.

The oddest part is that on a different ext3 filesystem on a different
'partition' of the raid 5, the problem doesn't occur.  I.e. i/o and cpu
usage pattern remains constant indefinitely.  Problem also confirmed not
to occur with writes to an xfs filesystem, or to the underlying block
device (partition).

It has been demonstrated on 2.6.5 and 2.6.6 kernels from FC2.
(2.6.5-1.358 and 2.6.6-1.435).  I have not tried 'vanilla' kernels yet.

The system is a dual Athlon 64 running the x86_64 FC2 distribution, with
2gb of ram.  The underlying storage device is a megaraid logical volume,
on a megaraid hardware raid-5 on 5x15000RPM scsi 320 disks.

The test program is a little proggy I wrote which reads from one 'file'
and writes to another 'file', with a specified i/o size.  Each 'file'
can be a file or device, and direct i/o can be specified for each,
separately, as a flag.  Basically a simple 'dd' with the ability to
specify O_DIRECT.

For the tests, normal i/o read from /dev/zero, direct i/o write to a
file, i/o size is 512kb.

I have vmstat snippets, readprofile | tail -40, and diffprofile of the
test running on both the 'bad' partition (root partition incidentally)
and the 'good' partition.  I also have tune2fs of the two filesystems'
superblocks.

Here is the most interesting, the diffprofile:
      2668  7847.1% find_get_page
      2092   817.2% __find_get_block
      1949     0.0% __bforget
      1546     3.8% total
      1359  22650.0% file_fsync
       728  1967.6% __brelse
       492   848.3% wake_up_buffer
       410  10250.0% put_page
       234  3900.0% __bread
       214   891.7% unlock_buffer
       145  2900.0% __getblk
        61  1016.7% bh_waitq_head
        21    23.6% mark_page_accessed
        18   360.0% blk_queue_bounce
        15  1500.0% __breadahead
         7    46.7% get_user_pages
        -8   -61.5% bio_get_nr_vecs
       -11  -100.0% percpu_counter_mod
       -23   -24.2% current_kernel_time
       -27   -46.6% mpage_writepages
     -8779   -22.2% enable_hlt

Here is the vmstat of the 'bad' partition running the test.  Notice
halfway through the numbers change drastically (and don't recover).  The
readprofile for the 'bad' test is completely done after the behavior
switches (I have cut the swap columns so wrapping won't occur, there was
no swapping):

procs -----------memory---------- ---io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache  bi    bo   in    cs us sy id wa
 1  1      0 1588380  74240 264944   0 49664 1808   217  0  6 50 44
 1  0      0 1588380  74288 264964   0 49024 1799   221  0  5 50 44
 0  1      0 1588316  74336 264916   0 48768 1798   206  0  6 50 45
 0  1      0 1588252  74384 264936   0 48412 1790   222  0  5 50 45
 0  1      0 1588188  74436 264952   0 49664 1804   217  0  6 50 45
 0  1      0 1588124  74484 264972   0 49664 1800   215  0  5 50 45
 0  1      0 1588060  74532 264924   0 49664 1800   213  0  6 50 45
 0  1      0 1587996  74580 264944   0 49664 1809   215  0  5 50 45
 0  1      0 1587932  74632 264960   0 48924 1800   219  0  5 50 45
 0  1      0 1587932  74680 264912   0 48640 1786   211  0  5 50 45
 0  1      0 1587868  74728 264932   0 50176 1808   217  0  5 50 45
 0  1      0 1587804  74776 264952   0 49152 1798   217  0  5 50 45
 0  1      0 1587740  74824 264972   0 48128 1791   205  0  4 50 45
 0  1      0 1587676  74884 264912   0 48928 1793   225  0  5 50 45
 1  0      0 1587612  74932 264932   0 49856 1805   210  0  5 50 45
 1  0      0 1587164  74956 264976   0 25408 1434   187  0 38 50 12
 2  0      0 1587164  74976 264956   0 21120 1347   189  0 45 50  6
 3  0      0 1587100  74996 264936   0 21696 1358   189  0 46 50  3
 3  0      0 1586844  75028 264972   0 22852 1383   221  0 47 50  4
 3  0      0 1586844  75052 264948   0 23296 1394   221  0 48 50  2
 3  0      0 1586780  75072 264928   0 22784 1377   195  0 46 50  4
 1  0      0 1586780  75096 264972   0 21616 1361   203  0 44 50  6
 3  0      0 1586716  75116 264952   0 23248 1384   205  0 47 50  3
 3  0      0 1586716  75148 264920   0 24752 1407   226  0 47 50  3
 2  0      0 1586716  75172 264964   0 23424 1392   209  0 45 50  5
 3  0      0 1586652  75192 264944   0 22784 1388   219  0 43 50  7
 3  0      0 1586652  75216 264920   0 22976 1394   215  0 44 50  7
 3  0      0 1586652  75236 264968   0 22016 1376   211  0 43 50  7
 4  0      0 1586588  75268 264936   0 23128 1386   220  0 43 50  6
 1  0      0 1586588  75292 264912   0 23360 1386   206  0 45 50  5
 1  0      0 1586524  75316 264956   0 24576 1404   207  0 47 50  3
 3  0      0 1586524  75340 264932   0 24768 1405   219  0 48 50  3

The 'good' vmstat looks exactly like the top portion, but doesn't
change.

Here are the actual two profiles, first the bad (tail -40):

ffffffff80158e18 kfree                           1   0.0047
ffffffff8016219a find_vma                        1   0.0006
ffffffff8016e8f1 vfs_read                        1   0.0038
ffffffff8021cfb3 generic_unplug_device           1   0.0081
ffffffff8021d35e blk_get_queue                   1   0.0009
ffffffff802ad9ab tcp_write_xmit                  1   0.0006
ffffffff80152cc9 mempool_alloc                   2   0.0068
ffffffff80171296 unmap_underlying_metadata       2   0.0011
ffffffff8019f28d remove_proc_entry               2   0.0002
ffffffff801cfb40 copy_user_generic               2   0.0062
ffffffff802db996 schedule                        2   0.0008
ffffffff801303a6 wake_up_process                 3   0.0004
ffffffff801588c4 kmem_cache_alloc                3   0.0094
ffffffff8021edac blk_rq_prep_restart             3   0.0009
ffffffff80172f04 bio_alloc                       4   0.0106
ffffffff80176d66 inode_add_bytes                 4   0.0426
ffffffff801702bd invalidate_bdev                 5   0.0151
ffffffff8017313f bio_get_nr_vecs                 5   0.0149
ffffffff8021df0e __blk_attempt_remerge           8   0.0053
ffffffff8018b158 __mark_inode_dirty              9   0.0037
ffffffff8017328e bio_add_page                   11   0.0210
ffffffff80170fd5 __breadahead                   16   0.3478
ffffffff8015e9b4 get_user_pages                 22   0.0101
ffffffff8015d2c6 blk_queue_bounce               23   0.0039
ffffffff8018c8bb mpage_writepages               31   0.0058
ffffffff8016f9f0 bh_waitq_head                  67   1.0000
ffffffff801398af current_kernel_time            72   0.2637
ffffffff8015a0b6 mark_page_accessed            110   0.4151
ffffffff80170fad __getblk                      150   3.7500
ffffffff8016fb56 unlock_buffer                 238  17.0000
ffffffff80171003 __bread                       240   1.8321
ffffffff80159e80 put_page                      414   0.7314
ffffffff8016fa33 wake_up_buffer                550   4.2308
ffffffff80170d13 __brelse                      765  11.2500
ffffffff8016ffd4 file_fsync                   1365   1.8322
ffffffff80170d57 __bforget                    1949   4.7770
ffffffff80170eef __find_get_block             2348  12.3579
ffffffff80150b8c find_get_page                2702  42.8889
ffffffff8010f708 enable_hlt                  30840  13.3796
0000000000000000 total                       41978   0.0215

Now the good:
ffffffff801f8dab batch_entropy_store            1   0.0014
ffffffff801f90d6 add_disk_randomness            1   0.0010
ffffffff8021e4ff generic_make_request           1   0.0028
ffffffff80220efe scsi_cmd_ioctl                 1   0.0001
ffffffff80152e64 mempool_free_slab              2   0.0004
ffffffff80155803 __set_page_dirty_nobuffers     2   0.0066
ffffffff801588c4 kmem_cache_alloc               2   0.0063
ffffffff8019f28d remove_proc_entry              2   0.0002
ffffffff8021d35e blk_get_queue                  2   0.0019
ffffffff8021e663 submit_bio                     2   0.0054
ffffffff8021edac blk_rq_prep_restart            2   0.0006
ffffffff80119574 mtrr_del                       3   0.0002
ffffffff80152cc9 mempool_alloc                  3   0.0101
ffffffff80158dce kmem_cache_free                3   0.0405
ffffffff80171296 unmap_underlying_metadata      3   0.0016
ffffffff801cfb40 copy_user_generic              3   0.0093
ffffffff80159e80 put_page                       4   0.0071
ffffffff80176d66 inode_add_bytes                4   0.0426
ffffffff8015d2c6 blk_queue_bounce               5   0.0009
ffffffff80170fad __getblk                       5   0.1250
ffffffff8016f9f0 bh_waitq_head                  6   0.0896
ffffffff8016ffd4 file_fsync                     6   0.0081
ffffffff80171003 __bread                        6   0.0458
ffffffff80172f04 bio_alloc                      6   0.0159
ffffffff8015a6d3 percpu_counter_mod            11   0.0302
ffffffff8017328e bio_add_page                  12   0.0229
ffffffff8021df0e __blk_attempt_remerge         12   0.0079
ffffffff8017313f bio_get_nr_vecs               13   0.0388
ffffffff8018b158 __mark_inode_dirty            13   0.0053
ffffffff8015e9b4 get_user_pages                15   0.0069
ffffffff8016fb56 unlock_buffer                 24   1.7143
ffffffff80150b8c find_get_page                 34   0.5397
ffffffff80170d13 __brelse                      37   0.5441
ffffffff8016fa33 wake_up_buffer                58   0.4462
ffffffff8018c8bb mpage_writepages              58   0.0108
ffffffff8015a0b6 mark_page_accessed            89   0.3358
ffffffff801398af current_kernel_time           95   0.3480
ffffffff80170eef __find_get_block             256   1.3474
ffffffff8010f708 enable_hlt                 39619  17.1883
0000000000000000 total                      40432   0.0208


Here is a diff of the tune2fs -l of the two superblocks, diff is ok to
bad, i.e.

diff -u super.ok super.bad 

--- super.ok    2004-06-30 15:53:39.626125169 -0400
+++ super.bad   2004-06-30 15:53:52.464060888 -0400
@@ -1,39 +1,39 @@
 tune2fs 1.35 (28-Feb-2004)
-Filesystem volume name:   <none>
+Filesystem volume name:   /
 Last mounted on:          <not available>
-Filesystem UUID:          608c1d46-d33e-4d1d-8d59-583178961e02
+Filesystem UUID:          bc7b7120-f75f-4f26-9d0e-2f038f331e92
 Filesystem magic number:  0xEF53
 Filesystem revision #:    1 (dynamic)
-Filesystem features:      has_journal filetype needs_recovery
sparse_super large_file
+Filesystem features:      has_journal ext_attr dir_index filetype
needs_recovery sparse_super large_file
 Default mount options:    (none)
 Filesystem state:         clean
 Errors behavior:          Continue
 Filesystem OS type:       Linux
-Inode count:              2003424
-Block count:              4002185
-Reserved block count:     200109
-Free blocks:              3931105
-Free inodes:              2003413
+Inode count:              2097152
+Block count:              4192965
+Reserved block count:     209648
+Free blocks:              2805083
+Free inodes:              1911707
 First block:              0
 Block size:               4096
 Fragment size:            4096
 Blocks per group:         32768
 Fragments per group:      32768
-Inodes per group:         16288
-Inode blocks per group:   509
-Filesystem created:       Wed Jun 30 15:31:38 2004
-Last mount time:          Wed Jun 30 15:34:18 2004
-Last write time:          Wed Jun 30 15:34:18 2004
-Mount count:              1
-Maximum mount count:      23
-Last checked:             Wed Jun 30 15:31:38 2004
-Check interval:           15552000 (6 months)
-Next check after:         Mon Dec 27 14:31:38 2004
+Inodes per group:         16384
+Inode blocks per group:   512
+Filesystem created:       Wed Jun 30 06:44:42 2004
+Last mount time:          Wed Jun 30 13:33:36 2004
+Last write time:          Wed Jun 30 13:33:36 2004
+Mount count:              5
+Maximum mount count:      -1
+Last checked:             Wed Jun 30 06:44:42 2004
+Check interval:           0 (<none>)
 Reserved blocks uid:      0 (user root)
 Reserved blocks gid:      0 (group root)
 First inode:              11
 Inode size:              128
 Journal inode:            8
+First orphan inode:       245774
 Default directory hash:   tea
-Directory Hash Seed:      842fd72b-188a-4423-9c3c-297cc05cf52a
+Directory Hash Seed:      1ad26963-e7a9-4edd-b77d-e7364a69f49e
 Journal backup:           inode blocks

Anyone have any suggestions?  I can test any vanilla kernel that there
are patches for.  i.e 2.6.7-bksomething or 2.6.7-mmsomething or
whatever.

David

P.S.

Test program is essentially (buff is page aligned, {r|w}fd may or may
not have been opened with O_DIRECT, see above):

        while (loop) {
                ssize_t n;
                if ((n = read(rfd, buff, iosz)) != iosz) {
                        fprintf(stderr, "short read\n");
                        break;
                }
 
                if ((n = write(wfd, buff, iosz)) != iosz) {
                        fprintf(stderr, "short write\n");
                        break;
                }
 
                total += n;
        }

Full program available on request.



