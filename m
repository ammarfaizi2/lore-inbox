Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVBPEB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVBPEB2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 23:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVBPEB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 23:01:28 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:36765 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261890AbVBPEAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 23:00:16 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Noel Maddy <noel@zhtwn.com>
Subject: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Date: Tue, 15 Feb 2005 23:00:13 -0500
User-Agent: KMail/1.7.92
Cc: Linus Torvalds <torvalds@osdl.org>, Jan Kasprzak <kas@fi.muni.cz>,
       Jens Axboe <axboe@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050121161959.GO3922@fi.muni.cz> <Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org> <20050208024714.GA16808@uglybox.localnet>
In-Reply-To: <20050208024714.GA16808@uglybox.localnet>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200502152300.15063.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running -rc3 on my AMD64 laptop and I noticed it becomes sluggish after 
use mainly due to growing swap use.  It has 768M of RAM and a Gig of swap. 
After following this thread, I started monitoring /proc/slabinfo. It seems 
size-64 is continuously growing and doing a compile run seem to make it grow 
noticeably faster. After a day's uptime size-64 line in /proc/slabinfo looks 
like 

size-64           7216543 7216544     64   61    1 : tunables  120   60    0 : 
slabdata 118304 118304      0

Since this doesn't seem to bio, I think we have another slab leak somewhere. 
The box recently went OOM during a gcc compile run after I killed the swap.

Output from free , OOM Killer, and /proc/slabinfo is down below..

free output -
           total       used       free     shared    buffers     cached
Mem:        767996     758120       9876          0       5276     130360
-/+ buffers/cache:     622484     145512
Swap:      1052248      67668     984580

OOM Killer Output
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        7260kB (0kB HighMem)
Active:62385 inactive:850 dirty:0 writeback:0 unstable:0 free:1815 slab:120136 
mapped:62334 pagetables:2110
DMA free:3076kB min:72kB low:88kB high:108kB active:3328kB inactive:0kB 
present:16384kB pages_scanned:4446 all_unreclaimable? yes
lowmem_reserve[]: 0 751 751
Normal free:4184kB min:3468kB low:4332kB high:5200kB active:246212kB 
inactive:3400kB present:769472kB pages_scanned:3834 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 
1*2048kB 0*4096kB = 3076kB
Normal: 170*4kB 10*8kB 2*16kB 0*32kB 1*64kB 0*128kB 1*256kB 2*512kB 0*1024kB 
1*2048kB 0*4096kB = 4184kB
HighMem: empty
Swap cache: add 310423, delete 310423, find 74707/105490, race 0+0
Free swap  = 0kB
Total swap = 0kB
Out of Memory: Killed process 4898 (klauncher).
oom-killer: gfp_mask=0x1d2
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
HighMem per-cpu: empty

Free pages:        7020kB (0kB HighMem)
Active:62308 inactive:648 dirty:0 writeback:0 unstable:0 free:1755 slab:120439 
mapped:62199 pagetables:2020
DMA free:3076kB min:72kB low:88kB high:108kB active:3336kB inactive:0kB 
present:16384kB pages_scanned:7087 all_unreclaimable? yes
lowmem_reserve[]: 0 751 751
Normal free:3944kB min:3468kB low:4332kB high:5200kB active:245896kB 
inactive:2592kB present:769472kB pages_scanned:3861 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
HighMem free:0kB min:128kB low:160kB high:192kB active:0kB inactive:0kB 
present:0kB pages_scanned:0 all_unreclaimable? no
lowmem_reserve[]: 0 0 0
DMA: 1*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB 
1*2048kB 0*4096kB = 3076kB
Normal: 112*4kB 9*8kB 0*16kB 1*32kB 1*64kB 0*128kB 1*256kB 2*512kB 0*1024kB 
1*2048kB 0*4096kB = 3944kB
HighMem: empty
Swap cache: add 310423, delete 310423, find 74707/105490, race 0+0
Free swap  = 0kB
Total swap = 0kB
Out of Memory: Killed process 4918 (kwin).

/proc/slabinfo output

ipx_sock               0      0    896    4    1 : tunables   54   27    0 : 
slabdata      0      0      0
scsi_cmd_cache         3      7    576    7    1 : tunables   54   27    0 : 
slabdata      1      1      0
ip_fib_alias          10    119     32  119    1 : tunables  120   60    0 : 
slabdata      1      1      0
ip_fib_hash           10     61     64   61    1 : tunables  120   60    0 : 
slabdata      1      1      0
sgpool-128            32     32   4096    1    1 : tunables   24   12    0 : 
slabdata     32     32      0
sgpool-64             32     32   2048    2    1 : tunables   24   12    0 : 
slabdata     16     16      0
sgpool-32             32     32   1024    4    1 : tunables   54   27    0 : 
slabdata      8      8      0
sgpool-16             32     32    512    8    1 : tunables   54   27    0 : 
slabdata      4      4      0
sgpool-8              32     45    256   15    1 : tunables  120   60    0 : 
slabdata      3      3      0
ext3_inode_cache    2805   3063   1224    3    1 : tunables   24   12    0 : 
slabdata   1021   1021      0
ext3_xattr             0      0     88   45    1 : tunables  120   60    0 : 
slabdata      0      0      0
journal_handle        16    156     24  156    1 : tunables  120   60    0 : 
slabdata      1      1      0
journal_head          49    180     88   45    1 : tunables  120   60    0 : 
slabdata      4      4      0
revoke_table           6    225     16  225    1 : tunables  120   60    0 : 
slabdata      1      1      0
revoke_record          0      0     32  119    1 : tunables  120   60    0 : 
slabdata      0      0      0
unix_sock            170    175   1088    7    2 : tunables   24   12    0 : 
slabdata     25     25      0
ip_mrt_cache           0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
tcp_tw_bucket          1     20    192   20    1 : tunables  120   60    0 : 
slabdata      1      1      0
tcp_bind_bucket        4    119     32  119    1 : tunables  120   60    0 : 
slabdata      1      1      0
tcp_open_request       0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
inet_peer_cache        0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
secpath_cache          0      0    192   20    1 : tunables  120   60    0 : 
slabdata      0      0      0
xfrm_dst_cache         0      0    384   10    1 : tunables   54   27    0 : 
slabdata      0      0      0
ip_dst_cache          14     20    384   10    1 : tunables   54   27    0 : 
slabdata      2      2      0
arp_cache              2     12    320   12    1 : tunables   54   27    0 : 
slabdata      1      1      0
raw_sock               2      7   1088    7    2 : tunables   24   12    0 : 
slabdata      1      1      0
udp_sock               7      7   1088    7    2 : tunables   24   12    0 : 
slabdata      1      1      0
tcp_sock               4      4   1920    2    1 : tunables   24   12    0 : 
slabdata      2      2      0
flow_cache             0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
cfq_ioc_pool           0      0     48   81    1 : tunables  120   60    0 : 
slabdata      0      0      0
cfq_pool               0      0    176   22    1 : tunables  120   60    0 : 
slabdata      0      0      0
crq_pool               0      0    104   38    1 : tunables  120   60    0 : 
slabdata      0      0      0
deadline_drq           0      0     96   41    1 : tunables  120   60    0 : 
slabdata      0      0      0
as_arq                32     70    112   35    1 : tunables  120   60    0 : 
slabdata      2      2      0
mqueue_inode_cache      1      3   1216    3    1 : tunables   24   12    0 : 
slabdata      1      1      0
isofs_inode_cache      0      0    872    4    1 : tunables   54   27    0 : 
slabdata      0      0      0
hugetlbfs_inode_cache      1      9    824    9    2 : tunables   54   27    
0 : slabdata      1      1      0
ext2_inode_cache       0      0   1024    4    1 : tunables   54   27    0 : 
slabdata      0      0      0
ext2_xattr             0      0     88   45    1 : tunables  120   60    0 : 
slabdata      0      0      0
dnotify_cache         75     96     40   96    1 : tunables  120   60    0 : 
slabdata      1      1      0
dquot                  0      0    320   12    1 : tunables   54   27    0 : 
slabdata      0      0      0
eventpoll_pwq          1     54     72   54    1 : tunables  120   60    0 : 
slabdata      1      1      0
eventpoll_epi          1     20    192   20    1 : tunables  120   60    0 : 
slabdata      1      1      0
kioctx                 0      0    512    7    1 : tunables   54   27    0 : 
slabdata      0      0      0
kiocb                  0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
fasync_cache           2    156     24  156    1 : tunables  120   60    0 : 
slabdata      1      1      0
shmem_inode_cache    302    308   1056    7    2 : tunables   24   12    0 : 
slabdata     44     44      0
posix_timers_cache      0      0    264   15    1 : tunables   54   27    0 : 
slabdata      0      0      0
uid_cache              5     61     64   61    1 : tunables  120   60    0 : 
slabdata      1      1      0
blkdev_ioc            84     90     88   45    1 : tunables  120   60    0 : 
slabdata      2      2      0
blkdev_queue          20     27    880    9    2 : tunables   54   27    0 : 
slabdata      3      3      0
blkdev_requests       32     32    248   16    1 : tunables  120   60    0 : 
slabdata      2      2      0
biovec-(256)         256    256   4096    1    1 : tunables   24   12    0 : 
slabdata    256    256      0
biovec-128           256    256   2048    2    1 : tunables   24   12    0 : 
slabdata    128    128      0
biovec-64            256    256   1024    4    1 : tunables   54   27    0 : 
slabdata     64     64      0
biovec-16            256    270    256   15    1 : tunables  120   60    0 : 
slabdata     18     18      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : 
slabdata      5      5      0
biovec-1             272    450     16  225    1 : tunables  120   60    0 : 
slabdata      2      2      0
bio                  272    279    128   31    1 : tunables  120   60    0 : 
slabdata      9      9      0
file_lock_cache        7     40    200   20    1 : tunables  120   60    0 : 
slabdata      2      2      0
sock_inode_cache     192    192    960    4    1 : tunables   54   27    0 : 
slabdata     48     48      0
skbuff_head_cache     45     72    320   12    1 : tunables   54   27    0 : 
slabdata      6      6      0
sock                   6      8    896    4    1 : tunables   54   27    0 : 
slabdata      2      2      0
proc_inode_cache      50    128    856    4    1 : tunables   54   27    0 : 
slabdata     32     32      0
sigqueue              23     23    168   23    1 : tunables  120   60    0 : 
slabdata      1      1      0
radix_tree_node     2668   2856    536    7    1 : tunables   54   27    0 : 
slabdata    408    408      0
bdev_cache             9      9   1152    3    1 : tunables   24   12    0 : 
slabdata      3      3      0
sysfs_dir_cache     2437   2440     64   61    1 : tunables  120   60    0 : 
slabdata     40     40      0
mnt_cache             26     40    192   20    1 : tunables  120   60    0 : 
slabdata      2      2      0
inode_cache          778    918    824    9    2 : tunables   54   27    0 : 
slabdata    102    102      0
dentry_cache        4320   8895    264   15    1 : tunables   54   27    0 : 
slabdata    593    593      0
filp                1488   1488    320   12    1 : tunables   54   27    0 : 
slabdata    124    124      0
names_cache           11     11   4096    1    1 : tunables   24   12    0 : 
slabdata     11     11      0
idr_layer_cache       76     77    528    7    1 : tunables   54   27    0 : 
slabdata     11     11      0
buffer_head         2360   2385     88   45    1 : tunables  120   60    0 : 
slabdata     53     53      0
mm_struct             65     65   1472    5    2 : tunables   24   12    0 : 
slabdata     13     13      0
vm_area_struct      5628   5632    176   22    1 : tunables  120   60    0 : 
slabdata    256    256      0
fs_cache              76    122     64   61    1 : tunables  120   60    0 : 
slabdata      2      2      0
files_cache           64     64    896    4    1 : tunables   54   27    0 : 
slabdata     16     16      0
signal_cache          96    119    512    7    1 : tunables   54   27    0 : 
slabdata     17     17      0
sighand_cache         78     78   2112    3    2 : tunables   24   12    0 : 
slabdata     26     26      0
task_struct           96     96   1936    2    1 : tunables   24   12    0 : 
slabdata     48     48      0
anon_vma            1464   1464     64   61    1 : tunables  120   60    0 : 
slabdata     24     24      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : 
slabdata      0      0      0
size-65536             3      3  65536    1   16 : tunables    8    4    0 : 
slabdata      3      3      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : 
slabdata      0      0      0
size-32768             4      4  32768    1    8 : tunables    8    4    0 : 
slabdata      4      4      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : 
slabdata      0      0      0
size-16384             4      4  16384    1    4 : tunables    8    4    0 : 
slabdata      4      4      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : 
slabdata      0      0      0
size-8192             31     31   8192    1    2 : tunables    8    4    0 : 
slabdata     31     31      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-4096             56     56   4096    1    1 : tunables   24   12    0 : 
slabdata     56     56      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : 
slabdata      0      0      0
size-2048            123    126   2048    2    1 : tunables   24   12    0 : 
slabdata     63     63      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-1024            252    252   1024    4    1 : tunables   54   27    0 : 
slabdata     63     63      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : 
slabdata      0      0      0
size-512             421    448    512    8    1 : tunables   54   27    0 : 
slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-256             108    120    256   15    1 : tunables  120   60    0 : 
slabdata      8      8      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-192            1204   1220    192   20    1 : tunables  120   60    0 : 
slabdata     61     61      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-128            1247   1426    128   31    1 : tunables  120   60    0 : 
slabdata     46     46      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-64           7265953 7265954     64   61    1 : tunables  120   60    0 : 
slabdata 119114 119114      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : 
slabdata      0      0      0
size-32             1071   1071     32  119    1 : tunables  120   60    0 : 
slabdata      9      9      0
kmem_cache           120    120    256   15    1 : tunables  120   60    0 : 
slabdata      8      8      0

Parag

On Monday 07 February 2005 09:47 pm, Noel Maddy wrote:
> On Mon, Feb 07, 2005 at 07:38:12AM -0800, Linus Torvalds wrote:
> > Whee. You've got 5 _million_ bio's "active". Which account for about
> > 750MB of your 860MB of slab usage.
>
> Same situation here, at different rates on two different platforms,
> both running same kernel build. Both show steadily increasing biovec-1.
>
> uglybox was previously running Ingo's 2.6.11-rc2-RT-V0.7.36-03, and was
> well over 3,000,000 bios after about a week of uptime. With only 512M of
> memory, it was pretty sluggish.
>
> Interesting that the 4-disk RAID5 seems to be growing about 4 times as
> fast as the RAID1.
>
> If there's anything else that could help, or patches you want me to try,
> just ask.
>
> Details:
>
> =================================
> #1: Soyo KT600 Platinum, Athlon 2500+, 512MB
> 	2 SATA, 2 PATA (all on 8237)
> 	RAID1 and RAID5
> 	on-board tg3
> ================================
>
> >uname -a
>
> Linux uglybox 2.6.11-rc3 #2 Thu Feb 3 16:19:44 EST 2005 i686 GNU/Linux
>
> >uptime
>
>  21:27:47 up  7:04,  4 users,  load average: 1.06, 1.03, 1.02
>
> >grep '^bio' /proc/slabinfo
>
> biovec-(256)         256    256   3072    2    2 : tunables   24   12    0
> : slabdata    128    128      0 biovec-128           256    260   1536    5
>    2 : tunables   24   12    0 : slabdata     52     52      0 biovec-64   
>         256    260    768    5    1 : tunables   54   27    0 : slabdata   
>  52     52      0 biovec-16            256    260    192   20    1 :
> tunables  120   60    0 : slabdata     13     13      0 biovec-4           
>  256    305     64   61    1 : tunables  120   60    0 : slabdata      5   
>   5      0 biovec-1           64547  64636     16  226    1 : tunables  120
>   60    0 : slabdata    286    286      0 bio                64551  64599  
>   64   61    1 : tunables  120   60    0 : slabdata   1059   1059      0
>
> >lsmod
>
> Module                  Size  Used by
> ppp_deflate             4928  2
> zlib_deflate           21144  1 ppp_deflate
> bsd_comp                5376  0
> ppp_async               9280  1
> crc_ccitt               1728  1 ppp_async
> ppp_generic            21396  7 ppp_deflate,bsd_comp,ppp_async
> slhc                    6720  1 ppp_generic
> radeon                 76224  1
> ipv6                  235456  27
> pcspkr                  3300  0
> tg3                    84932  0
> ohci1394               31748  0
> ieee1394               94196  1 ohci1394
> snd_cmipci             30112  1
> snd_pcm_oss            48480  0
> snd_mixer_oss          17728  1 snd_pcm_oss
> usbhid                 31168  0
> snd_pcm                83528  2 snd_cmipci,snd_pcm_oss
> snd_page_alloc          7620  1 snd_pcm
> snd_opl3_lib            9472  1 snd_cmipci
> snd_timer              21828  2 snd_pcm,snd_opl3_lib
> snd_hwdep               7456  1 snd_opl3_lib
> snd_mpu401_uart         6528  1 snd_cmipci
> snd_rawmidi            20704  1 snd_mpu401_uart
> snd_seq_device          7116  2 snd_opl3_lib,snd_rawmidi
> snd                    48996  12
> snd_cmipci,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_hwd
>ep,snd_mpu401_uart,snd_rawmidi,snd_seq_device soundcore               7648 
> 1 snd
> uhci_hcd               29968  0
> ehci_hcd               29000  0
> usbcore               106744  4 usbhid,uhci_hcd,ehci_hcd
> dm_mod                 52796  0
> it87                   23900  0
> eeprom                  5776  0
> lm90                   11044  0
> i2c_sensor              2944  3 it87,eeprom,lm90
> i2c_isa                 1728  0
> i2c_viapro              6412  0
> i2c_core               18512  6
> it87,eeprom,lm90,i2c_sensor,i2c_isa,i2c_viapro
>
> >lspci
>
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP]
> Host Bridge (rev 80) 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237
> PCI Bridge
> 0000:00:07.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5705
> Gigabit Ethernet (rev 03) 0000:00:0d.0 FireWire (IEEE 1394): VIA
> Technologies, Inc. IEEE 1394 Host Controller (rev 46) 0000:00:0e.0
> Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
> 0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA
> RAID Controller (rev 80) 0000:00:0f.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1
> Controller (rev 81) 0000:00:10.1 USB Controller: VIA Technologies, Inc.
> VT82xxxxx UHCI USB 1.1 Controller (rev 81) 0000:00:10.2 USB Controller: VIA
> Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81) 0000:00:10.3
> USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
> (rev 81) 0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev
> 86) 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge
> [K8T800 South] 0000:00:13.0 RAID bus controller: Silicon Image, Inc.
> (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA
> Controller (rev 02) 0000:01:00.0 VGA compatible controller: ATI
> Technologies Inc Radeon RV200 QW [Radeon 7500]
>
> >cat /proc/mdstat
>
> Personalities : [raid0] [raid1] [raid5]
> md1 : active raid1 sdb1[0] sda1[1]
>       489856 blocks [2/2] [UU]
>
> md4 : active raid5 sdb3[2] sda3[3] hdc3[1] hda3[0]
>       8795136 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
>
> md5 : active raid5 sdb5[2] sda5[3] hdc5[1] hda5[0]
>       14650752 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
>
> md6 : active raid5 sdb6[2] sda6[3] hdc6[1] hda6[0]
>       43953408 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
>
> md7 : active raid5 sdb7[2] sda7[3] hdc7[1] hda7[0]
>       164103552 blocks level 5, 128k chunk, algorithm 2 [4/4] [UUUU]
>
> md0 : active raid1 hdc1[1] hda1[0]
>       489856 blocks [2/2] [UU]
>
> unused devices: <none>
>
> ================================
> #2: Soyo KT400 Platinum, Athlon 2500+, 512MB
> 	2 PATA (one on 8235, one on HPT372)
> 	RAID1
> 	on-board via rhine
> ================================
>
> >uname -a
>
> Linux lepke 2.6.11-rc3 #2 Thu Feb 3 16:19:44 EST 2005 i686 GNU/Linux
>
> >uptime
>
>  21:30:13 up  7:16,  1 user,  load average: 1.00, 1.00, 1.23
>
> >grep '^bio' /proc/slabinfo
>
> biovec-(256)         256    256   3072    2    2 : tunables   24   12    0
> : slabdata    128    128      0 biovec-128           256    260   1536    5
>    2 : tunables   24   12    0 : slabdata     52     52      0 biovec-64   
>         256    260    768    5    1 : tunables   54   27    0 : slabdata   
>  52     52      0 biovec-16            256    260    192   20    1 :
> tunables  120   60    0 : slabdata     13     13      0 biovec-4           
>  256    305     64   61    1 : tunables  120   60    0 : slabdata      5   
>   5      0 biovec-1           14926  15142     16  226    1 : tunables  120
>   60    0 : slabdata     67     67      0 bio                14923  15006  
>   64   61    1 : tunables  120   60    0 : slabdata    246    246      0
> Module                  Size  Used by
> ipv6                  235456  17
> pcspkr                  3300  0
> tuner                  21220  0
> ub                     15324  0
> usbhid                 31168  0
> bttv                  146064  0
> video_buf              17540  1 bttv
> firmware_class          7936  1 bttv
> i2c_algo_bit            8840  1 bttv
> v4l2_common             4736  1 bttv
> btcx_risc               3912  1 bttv
> tveeprom               11544  1 bttv
> videodev                7488  1 bttv
> uhci_hcd               29968  0
> ehci_hcd               29000  0
> usbcore               106744  5 ub,usbhid,uhci_hcd,ehci_hcd
> via_ircc               23380  0
> irda                  121784  1 via_ircc
> crc_ccitt               1728  1 irda
> via_rhine              19844  0
> mii                     4032  1 via_rhine
> dm_mod                 52796  0
> snd_bt87x              12360  0
> snd_cmipci             30112  0
> snd_opl3_lib            9472  1 snd_cmipci
> snd_hwdep               7456  1 snd_opl3_lib
> snd_mpu401_uart         6528  1 snd_cmipci
> snd_cs46xx             85064  0
> snd_rawmidi            20704  2 snd_mpu401_uart,snd_cs46xx
> snd_seq_device          7116  2 snd_opl3_lib,snd_rawmidi
> snd_ac97_codec         73976  1 snd_cs46xx
> snd_pcm_oss            48480  0
> snd_mixer_oss          17728  1 snd_pcm_oss
> snd_pcm                83528  5
> snd_bt87x,snd_cmipci,snd_cs46xx,snd_ac97_codec,snd_pcm_oss snd_timer       
>       21828  2 snd_opl3_lib,snd_pcm
> snd                    48996  13
> snd_bt87x,snd_cmipci,snd_opl3_lib,snd_hwdep,snd_mpu401_uart,snd_cs46xx,snd_
>rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_
>timer soundcore               7648  1 snd
> snd_page_alloc          7620  3 snd_bt87x,snd_cs46xx,snd_pcm
> lm90                   11044  0
> eeprom                  5776  0
> it87                   23900  0
> i2c_sensor              2944  3 lm90,eeprom,it87
> i2c_isa                 1728  0
> i2c_viapro              6412  0
> i2c_core               18512  10
> tuner,bttv,i2c_algo_bit,tveeprom,lm90,eeprom,it87,i2c_sensor,i2c_isa,i2c_vi
>apro 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600
> AGP] Host Bridge 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI
> Bridge
> 0000:00:09.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
> [CrystalClear SoundFusion Audio Accelerator] (rev 01) 0000:00:0b.0
> Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev
> 11) 0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio
> Capture (rev 11) 0000:00:0e.0 Multimedia audio controller: C-Media
> Electronics Inc CM8738 (rev 10) 0000:00:0f.0 RAID bus controller: Triones
> Technologies, Inc. HPT366/368/370/370A/372 (rev 05) 0000:00:10.0 USB
> Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev
> 80) 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB
> 1.1 Controller (rev 80) 0000:00:10.2 USB Controller: VIA Technologies, Inc.
> VT82xxxxx UHCI USB 1.1 Controller (rev 80) 0000:00:10.3 USB Controller: VIA
> Technologies, Inc. USB 2.0 (rev 82) 0000:00:11.0 ISA bridge: VIA
> Technologies, Inc. VT8235 ISA Bridge
> 0000:00:11.1 IDE interface: VIA Technologies, Inc.
> VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II]
> (rev 74) 0000:01:00.0 VGA compatible controller: ATI Technologies Inc
> Radeon R200 QM [Radeon 9100] Personalities : [raid0] [raid1] [raid5]
> md4 : active raid1 hda1[0] hde1[1]
>       995904 blocks [2/2] [UU]
>
> md5 : active raid1 hda2[0] hde2[1]
>       995904 blocks [2/2] [UU]
>
> md6 : active raid1 hda7[0] hde7[1]
>       5855552 blocks [2/2] [UU]
>
> md7 : active raid0 hda8[0] hde8[1]
>       136496128 blocks 32k chunks
>
> unused devices: <none>
