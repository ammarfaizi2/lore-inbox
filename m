Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285156AbRLFOnB>; Thu, 6 Dec 2001 09:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285157AbRLFOmw>; Thu, 6 Dec 2001 09:42:52 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:37133 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S285156AbRLFOmk>;
	Thu, 6 Dec 2001 09:42:40 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200112061442.PAA02140@nbd.it.uc3m.es>
Subject: memleak in recent 2.4 kernels
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
To: linux kernel <linux-kernel@vger.kernel.org>
Date: Thu, 6 Dec 2001 15:42:32 +0100 (CET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about not attaching this to the right thread subject. I've lost
it.

A week or so ago I chimed in to say that I too had had memory problems
with kernels >=~ 2.4.10. Dual P2 500, 128MB ram, raid5 and raid1 and
scsi adaptec 1960 to four wd disks.

So I rebooted my 2.4.13 (plus xfs patches) and have been watching
for a few days. After nearly 4 days it's beginning to show noticable
leakage. Maybe 5MB a day, going by the free middle line.

             total       used       free     shared    buffers     cached
Mem:        126224     104300      21924          0       7488      49688
-/+ buffers/cache:      47124      79100
                        ^^^^^^  start
Swap:       144504          0     144504

             total       used       free     shared    buffers     cached
Mem:        126164     121204       4960          0        660      29228
-/+ buffers/cache:      91316      34848
                        ^^^^^^ started off around 50MB
Swap:       144504      13188     131316

I am not currently running X, though I have been. I wanted a normal
spectrum of behaviour. I am running exactly this login shell and
this copy of elm and this copy of vi. 

Here's the diff between the slabinfo at 1 minute and now, at 3 days 17
hours and counting.. looks like inode and dentry counts are way up.
Maybe that's not surprising!

  1:52pm  up 3 days, 17:24,  1 user,  load average: 0.00, 0.02, 0.01

--- nbd13_slabinfo_0mins	Sun Dec  2 20:35:11 2001
+++ nbd13_slabinfo_65hrs	Thu Dec  6 13:40:36 2001
@@ -1,6 +1,6 @@
 slabinfo - version: 1.1 (SMP)
 kmem_cache            80     80    248    5    5    1 :  252  126
-xfs_chashlist          0      0     16    0    0    1 :  252  126
+xfs_chashlist        907   1616     16    8    8    1 :  252  126
 xfs_ili                0      0    136    0    0    1 :  252  126
 xfs_ifork              0      0     56    0    0    1 :  252  126
 xfs_efi_item           0      0    260    0    0    1 :  124   62
@@ -9,70 +9,70 @@
 xfs_dabuf              0      0     16    0    0    1 :  252  126
 xfs_da_state           0      0    340    0    0    1 :  124   62
 xfs_trans              0      0    324    0    0    1 :  124   62
-xfs_inode              0      0    508    0    0    1 :  124   62
+xfs_inode            910   5096    508  728  728    1 :  124   62
 xfs_btree_cur          0      0    140    0    0    1 :  252  126
 xfs_bmap_free_item     0      0     16    0    0    1 :  252  126
-page_buf_t             0      0    224    0    0    1 :  252  126
+page_buf_t             4     17    224    1    1    1 :  252  126
-page_buf_reg_t         0      0     96    0    0    1 :  252  126
+page_buf_reg_t         1     40     96    1    1    1 :  252  126
-avl_object_t           0      0     32    0    0    1 :  252  126
+avl_object_t           1    113     32    1    1    1 :  252  126
 avl_entry_t            0      0     32    0    0    1 :  252  126
-nfs_read_data         10     10    384    1    1    1 :  124   62
+nfs_read_data          0      0    384    0    0    1 :  124   62
-nfs_write_data        10     10    384    1    1    1 :  124   62
+nfs_write_data         0      0    384    0    0    1 :  124   62
-nfs_page              40     40     96    1    1    1 :  252  126
+nfs_page               0      0     96    0    0    1 :  252  126
 urb_priv               2    118     64    2    2    1 :  252  126
 ip_mrt_cache           0      0     96    0    0    1 :  252  126
-tcp_tw_bucket         60     60    128    2    2    1 :  252  126
+tcp_tw_bucket         30     30    128    1    1    1 :  252  126
 tcp_bind_bucket      226    226     32    2    2    1 :  252  126
-tcp_open_request      40     40     96    1    1    1 :  252  126
+tcp_open_request       0      0     96    0    0    1 :  252  126
 inet_peer_cache        4    118     64    2    2    1 :  252  126
 ip_fib_hash           18    226     32    2    2    1 :  252  126
-ip_dst_cache         168    168    160    7    7    1 :  252  126
+ip_dst_cache         207    264    160   11   11    1 :  252  126
-arp_cache             60     60    128    2    2    1 :  252  126
+arp_cache            120    120    128    4    4    1 :  252  126
 blkdev_requests      896    960     96   24   24    1 :  252  126
 dnotify cache          0      0     20    0    0    1 :  252  126
-file lock cache      120    120     96    3    3    1 :  252  126
+file lock cache      200    200     96    5    5    1 :  252  126
 fasync cache           2    202     16    1    1    1 :  252  126
 uid_cache              5    113     32    1    1    1 :  252  126
-skbuff_head_cache    473    600    160   25   25    1 :  252  126
+skbuff_head_cache   1133   1320    160   55   55    1 :  252  126
-sock                 264    264    960   66   66    1 :  124   62
+sock                 216    216    960   54   54    1 :  124   62
-sigqueue             174    174    132    6    6    1 :  252  126
+sigqueue              87     87    132    3    3    1 :  252  126
-cdev_cache           590    590     64   10   10    1 :  252  126
+cdev_cache            29    295     64    5    5    1 :  252  126
-bdev_cache           177    177     64    3    3    1 :  252  126
+bdev_cache            22    118     64    2    2    1 :  252  126
-mnt_cache             21    118     64    2    2    1 :  252  126
+mnt_cache             22    177     64    3    3    1 :  252  126
-inode_cache         5033   5187    512  741  741    1 :  124   62
+inode_cache        60747  84224    512 12032 12032  1 :  124   62
-dentry_cache        5079   6180    128  206  206    1 :  252  126
+dentry_cache       27241  63540    128 2118 2118    1 :  252  126
 dquot                  0      0    128    0    0    1 :  252  126
-filp                1170   1170    128   39   39    1 :  252  126
+filp                1598   1620    128   54   54    1 :  252  126
-names_cache            8      8   4096    8    8    1 :   60   30
+names_cache            3      3   4096    3    3    1 :   60   30
-buffer_head        33494  51690    128 1616 1723    1 :  252  126
+buffer_head        20817  25890    128  862  863    1 :  252  126
-mm_struct            192    192    160    8    8    1 :  252  126
+mm_struct            216    216    160    9    9    1 :  252  126
-vm_area_struct      3440   3440     96   86   86    1 :  252  126
+vm_area_struct      2038   3120     96   78   78    1 :  252  126
-fs_cache             236    236     64    4    4    1 :  252  126
+fs_cache             295    295     64    5    5    1 :  252  126
-files_cache          135    135    448   15   15    1 :  124   62
+files_cache          153    153    448   17   17    1 :  124   62
-signal_act           135    135   1312   45   45    1 :   60   30
+signal_act           123    123   1312   41   41    1 :   60   30
 size-131072(DMA)       0      0 131072    0    0   32 :    0    0
 size-131072            0      0 131072    0    0   32 :    0    0
 size-65536(DMA)        0      0  65536    0    0   16 :    0    0
-size-65536             1      1  65536    1    1   16 :    0    0
+size-65536             3      3  65536    3    3   16 :    0    0
 size-32768(DMA)        0      0  32768    0    0    8 :    0    0
-size-32768             0      1  32768    0    1    8 :    0    0
+size-32768             1      4  32768    1    4    8 :    0    0
 size-16384(DMA)        0      0  16384    0    0    4 :    0    0
 size-16384             2      2  16384    2    2    4 :    0    0
 size-8192(DMA)         0      0   8192    0    0    2 :    0    0
-size-8192              5      5   8192    5    5    2 :    0    0
+size-8192              4      5   8192    4    5    2 :    0    0
 size-4096(DMA)         0      0   4096    0    0    1 :   60   30
-size-4096            114    114   4096  114  114    1 :   60   30
+size-4096            111    111   4096  111  111    1 :   60   30
 size-2048(DMA)         0      0   2048    0    0    1 :   60   30
-size-2048            100    100   2048   50   50    1 :   60   30
+size-2048            110    110   2048   55   55    1 :   60   30
 size-1024(DMA)         0      0   1024    0    0    1 :  124   62
-size-1024            488    488   1024  122  122    1 :  124   62
+size-1024            452    452   1024  113  113    1 :  124   62
 size-512(DMA)          0      0    512    0    0    1 :  124   62
-size-512             184    184    512   23   23    1 :  124   62
+size-512             208    208    512   26   26    1 :  124   62
 size-256(DMA)          0      0    256    0    0    1 :  252  126
-size-256             270    285    256   19   19    1 :  252  126
+size-256             998   1020    256   68   68    1 :  252  126
 size-128(DMA)          1     30    128    1    1    1 :  252  126
-size-128            3060   3060    128  102  102    1 :  252  126
+size-128            3105   3630    128  121  121    1 :  252  126
 size-64(DMA)           0      0     64    0    0    1 :  252  126
-size-64             1062   1062     64   18   18    1 :  252  126
+size-64             1357   2891     64   49   49    1 :  252  126
 size-32(DMA)          18    226     32    2    2    1 :  252  126
-size-32             2162   2599     32   23   23    1 :  252  126
+size-32             2597  10057     32   87   89    1 :  252  126
