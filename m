Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262159AbSIZDWa>; Wed, 25 Sep 2002 23:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262158AbSIZDWa>; Wed, 25 Sep 2002 23:22:30 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:54229 "EHLO
	shookay.newview.com") by vger.kernel.org with ESMTP
	id <S262156AbSIZDW0>; Wed, 25 Sep 2002 23:22:26 -0400
Date: Wed, 25 Sep 2002 23:27:36 -0400
From: Mathieu Chouquet-Stringer <mathieu@newview.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Warning - running *really* short on DMA buffers while doing file transfers
Message-ID: <20020925232736.A19209@shookay.newview.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mathieu@newview.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	  Hello!

I've upgraded a while to 2.4.19 and my box has been happy for the last 52
days (it's a dual PIII). Tonight while going through my logs, I've found
these:

Sep 25 22:18:41 bigip kernel: Warning - running *really* short on DMA buffers
Sep 25 22:18:47 bigip last message repeated 55 times
Sep 25 22:19:41 bigip last message repeated 71 times

I know where it's coming from (drivers/scsi/scsi_merge.c):
        /* scsi_malloc can only allocate in chunks of 512 bytes so
         * round it up.
         */
        SCpnt->sglist_len = (SCpnt->sglist_len + 511) & ~511;

        sgpnt = (struct scatterlist *) scsi_malloc(SCpnt->sglist_len);

	/*
         * Now fill the scatter-gather table.
         */
        if (!sgpnt) {
                /*
                 * If we cannot allocate the scatter-gather table, then
                 * simply write the first buffer all by itself.
                 */
                printk("Warning - running *really* short on DMA
		buffers\n");
                this_count = SCpnt->request.current_nr_sectors;
                goto single_segment;
        }

So I know that scsi_malloc failed, the reason, I don't know. Well I guess
either this test if (len % SECTOR_SIZE != 0 || len > PAGE_SIZE) or this one
if ((dma_malloc_freelist[i] & (mask << j)) == 0) failed (both come from
scsi_dma.c).

It is easily reproducible though: I just have to start a huge file transfer
from a crappy ide drive (ie low throughput) to a scsi one and the result is
almost garanteed.

I'm running a 2.4.19 + freeswan but I can easily get rid of freeswan if you
want me to (the kernel was compiled with gcc 2.96 20000731). The kernel has
nothing wierd enabled (it runs netfilter and nfs). 
I've got both ide and scsi drives with ext3 as the only fs, the scsi card
is an Adaptec AHA-2940U2/U2W (oem version) and has only 3 devices
connected:
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 18SCA  Rev: UCIE
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 05 Lun: 00
  Vendor: TEAC     Model: CD-R55S          Rev: 1.0R
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: HP       Model: C1537A           Rev: L706
  Type:   Sequential-Access                ANSI SCSI revision: 02

The ide chip being the regular Intel Corp. 82801AA IDE (rev 02).

Here the output of /proc/slabinfo few minutes after the last line in the
logs:

slabinfo - version: 1.1 (SMP)
kmem_cache            80     80    244    5    5    1 :  252  126
fib6_nodes             9    226     32    2    2    1 :  252  126
ip6_dst_cache         16     40    192    2    2    1 :  252  126
ndisc_cache            1     30    128    1    1    1 :  252  126
ip_conntrack          84    132    352   12   12    1 :  124   62
tcp_tw_bucket          1     30    128    1    1    1 :  252  126
tcp_bind_bucket       22    226     32    2    2    1 :  252  126
tcp_open_request       0      0     96    0    0    1 :  252  126
inet_peer_cache        3     59     64    1    1    1 :  252  126
ip_fib_hash           23    226     32    2    2    1 :  252  126
ip_dst_cache         150    216    160    9    9    1 :  252  126
arp_cache              6     60    128    2    2    1 :  252  126
blkdev_requests      896    920     96   23   23    1 :  252  126
journal_head         293    390     48    5    5    1 :  252  126
revoke_table           8    253     12    1    1    1 :  252  126
revoke_record          0      0     32    0    0    1 :  252  126
dnotify cache          0      0     20    0    0    1 :  252  126
file lock cache      168    168     92    4    4    1 :  252  126
fasync cache           0      0     16    0    0    1 :  252  126
uid_cache             10    226     32    2    2    1 :  252  126
skbuff_head_cache    392    720    160   30   30    1 :  252  126
sock                  97    148    928   37   37    1 :  124   62
sigqueue              29     29    132    1    1    1 :  252  126
cdev_cache            17    295     64    5    5    1 :  252  126
bdev_cache            12    118     64    2    2    1 :  252  126
mnt_cache             22    118     64    2    2    1 :  252  126
inode_cache         1390   2176    480  272  272    1 :  124   62
dentry_cache        1440   4620    128  154  154    1 :  252  126
filp                1455   1560    128   52   52    1 :  252  126
names_cache            2      2   4096    2    2    1 :   60   30
buffer_head        76691  77160     96 1929 1929    1 :  252  126
mm_struct            194    264    160   11   11    1 :  252  126
vm_area_struct      4303   4840     96  121  121    1 :  252  126
fs_cache             194    236     64    4    4    1 :  252  126
files_cache          130    153    416   17   17    1 :  124   62
signal_act           114    114   1312   38   38    1 :   60   30
size-131072(DMA)       0      0 131072    0    0   32 :    0    0
size-131072            0      0 131072    0    0   32 :    0    0
size-65536(DMA)        0      0  65536    0    0   16 :    0    0
size-65536             1      1  65536    1    1   16 :    0    0
size-32768(DMA)        0      0  32768    0    0    8 :    0    0
size-32768             3      3  32768    3    3    8 :    0    0
size-16384(DMA)        0      0  16384    0    0    4 :    0    0
size-16384            11     12  16384   11   12    4 :    0    0
size-8192(DMA)         0      0   8192    0    0    2 :    0    0
size-8192              9     10   8192    9   10    2 :    0    0
size-4096(DMA)         0      0   4096    0    0    1 :   60   30
size-4096             63     63   4096   63   63    1 :   60   30
size-2048(DMA)         0      0   2048    0    0    1 :   60   30
size-2048            252    282   2048  139  141    1 :   60   30
size-1024(DMA)         0      0   1024    0    0    1 :  124   62
size-1024            175    176   1024   44   44    1 :  124   62
size-512(DMA)          0      0    512    0    0    1 :  124   62
size-512             448    448    512   56   56    1 :  124   62
size-256(DMA)          0      0    256    0    0    1 :  252  126
size-256             263    270    256   18   18    1 :  252  126
size-128(DMA)          0      0    128    0    0    1 :  252  126
size-128            2128   2670    128   89   89    1 :  252  126
size-64(DMA)           0      0     64    0    0    1 :  252  126
size-64              718   2537     64   43   43    1 :  252  126
size-32(DMA)           0      0     32    0    0    1 :  252  126
size-32             1495  11413     32  101  101    1 :  252  126

And /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  394948608 389390336  5558272        0 15466496 310026240
Swap: 806068224 33927168 772141056
MemTotal:       385692 kB
MemFree:          5428 kB
MemShared:           0 kB
Buffers:         15104 kB
Cached:         298916 kB
SwapCached:       3844 kB
Active:          22192 kB
Inactive:       335208 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       385692 kB
LowFree:          5428 kB
SwapTotal:      787176 kB
SwapFree:       754044 kB


So my question: know issue (like memory fragmentation) or bug (in this case
I would be glad to test any patches you would want me to or to give you
anything missing in this email)?

Regards, Mathieu.

Oh BTW, just one thing, I wanted to give the throughput of the ide drived
but it failed:
Sep 25 23:18:32 bigip kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Sep 25 23:18:32 bigip kernel: hdb: dma_intr: error=0x40 { UncorrectableError }, LBAsect=102882, sector=102784

I read my logs every day so I know for sure these messages are new (damn it
doesn't look good)...

-- 
Mathieu Chouquet-Stringer              E-Mail : mathieu@newview.com
    It is exactly because a man cannot do a thing that he is a
                      proper judge of it.
                      -- Oscar Wilde
