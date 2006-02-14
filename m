Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422807AbWBNVn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbWBNVn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422809AbWBNVn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:43:59 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:54020 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1422807AbWBNVn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:43:58 -0500
Date: Tue, 14 Feb 2006 22:43:49 +0100
From: Willy TARREAU <willy@w.ods.org>
To: Yoss <bartek@milc.com.pl>
Cc: linux-kernel@vger.kernel.org, Roberto Nibali <ratz@drugphish.ch>
Subject: Re: Memory leak in 2.4.33-pre1?
Message-ID: <20060214214349.GA298@w.ods.org>
References: <20060213214651.GA27844@milc.com.pl> <20060214000529.GJ11380@w.ods.org> <20060214082136.GA9993@milc.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214082136.GA9993@milc.com.pl>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 09:21:36AM +0100, Yoss wrote:
> On Tue, Feb 14, 2006 at 01:05:30AM +0100, Willy Tarreau wrote:
> > You don't have to worry. Simply check /proc/slabinfo, you'll see plenty
> > of memory used by dentry_cache and inode_cache and that's expected. This
> > memory will be reclaimed when needed (for instance by calls to malloc()).
> 
> I downgraded hernel to 2.4.33 last night.

I presume you mean 2.4.32 here.

> So there is no slabinfo from that problem now. But thank you for reply.
> Why is this memory not showed somewhere in top or free?

I don't know, it's some gray area for me too, it's just that I'm used to
this behaviour. I even have a program that I run to free it when I want
to prioritize disk cache usage over dentry cache (appended to this mail).

For instance, I've booted my notebook to work on it. 3 minutes after the boot
has completed, slocate starts indexing files (I wait 3 minutes to speed up
services start). Now that slocate has ended its job, here is what a few tools
have to say about my memory usage :

$ free        
             total       used       free     shared    buffers     cached
Mem:        514532     509576       4956          0      25836       5808
-/+ buffers/cache:     477932      36600
Swap:       312316       1436     310880

It even managed to swap !

$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0   1436   4908  25860   5824    0    1  1213    39  536   586  2  7 90  0
 0  0   1436   4904  25860   5824    0    0     0     0  254    16  0  0 100  0

$ top
top - 22:32:47 up 12 min,  1 user,  load average: 0.12, 0.52, 0.34
Tasks:  44 total,   1 running,  43 sleeping,   0 stopped,   0 zombie
Cpu(s):   0.1% user,   7.2% system,   2.2% nice,  90.5% idle
Mem:    514532k total,   510076k used,     4456k free,    25900k buffers
Swap:   312316k total,     1436k used,   310880k free,     6112k cached

$ cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  526880768 522194944  4685824        0 26521600  6946816
Swap: 319811584  1470464 318341120
MemTotal:       514532 kB
MemFree:          4576 kB
MemShared:           0 kB
Buffers:         25900 kB
Cached:           6132 kB
SwapCached:        652 kB
Active:          20052 kB
Inactive:        12664 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       514532 kB
LowFree:          4576 kB
SwapTotal:      312316 kB
SwapFree:       310880 kB

$ cat /proc/slabinfo 
slabinfo - version: 1.1
kmem_cache            81    108    108    3    3    1
urb_priv               0      0     64    0    0    1
ip_fib_hash           10    113     32    1    1    1
clip_arp_cache         0      0    128    0    0    1
mpr                    0      0     16    0    0    1
label                  0      0     32    0    0    1
tcp_tw_bucket          0      0     96    0    0    1
tcp_bind_bucket        9    113     32    1    1    1
tcp_open_request       0      0     64    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_dst_cache           2     20    192    1    1    1
arp_cache              1     40     96    1    1    1
ip_arpf_cache          0      0    128    0    0    1
blkdev_requests     5120   5120     96  128  128    1
xfs_chashlist          0      0     20    0    0    1
xfs_ili                0      0    140    0    0    1
xfs_ifork              0      0     56    0    0    1
xfs_efi_item           0      0    260    0    0    1
xfs_efd_item           0      0    260    0    0    1
xfs_buf_item           0      0    148    0    0    1
xfs_dabuf              0      0     16    0    0    1
xfs_da_state           0      0    336    0    0    1
xfs_trans              0      0    592    0    0    2
xfs_inode              0      0    376    0    0    1
xfs_btree_cur          0      0    132    0    0    1
xfs_bmap_free_item     0      0     12    0    0    1
xfs_buf_t              0      0    192    0    0    1
linvfs_icache          0      0    320    0    0    1
ext2_xattr             0      0     44    0    0    1
journal_head           0      0     48    0    0    1
revoke_table           0      0     12    0    0    1
revoke_record          0      0     32    0    0    1
ext3_xattr             0      0     44    0    0    1
eventpoll pwq          0      0     36    0    0    1
eventpoll epi          0      0     96    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        3     42     92    1    1    1
fasync_cache           0      0     16    0    0    1
uid_cache              6    113     32    1    1    1
skbuff_head_cache    207    220    192   11   11    1
sock                  34     36    896    9    9    1
sigqueue               0     29    132    0    1    1
kiobuf                 0      0     64    0    0    1
cdev_cache            60    177     64    3    3    1
bdev_cache             8     59     64    1    1    1
mnt_cache             16     59     64    1    1    1
inode_cache       751083 751096    480 93886 93887    1
dentry_cache      602570 607530    128 20251 20251    1
filp                 334    360    128   12   12    1
names_cache            0      2   4096    0    2    1
buffer_head         7084   9440     96  234  236    1
mm_struct             32     48    160    2    2    1
vm_area_struct      2362   2600     96   62   65    1
fs_cache              31    113     32    1    1    1
files_cache           32     36    416    4    4    1
signal_act            40     42   1312   14   14    1
size-131072(DMA)       0      0 131072    0    0   32
size-131072            0      0 131072    0    0   32
size-65536(DMA)        0      0  65536    0    0   16
size-65536             0      0  65536    0    0   16
size-32768(DMA)        0      0  32768    0    0    8
size-32768             8      8  32768    8    8    8
size-16384(DMA)        0      0  16384    0    0    4
size-16384             0      0  16384    0    0    4
size-8192(DMA)         0      0   8192    0    0    2
size-8192              4      4   8192    4    4    2
size-4096(DMA)         0      0   4096    0    0    1
size-4096             69     69   4096   69   69    1
size-2048(DMA)         0      0   2048    0    0    1
size-2048            213    216   2048  107  108    1
size-1024(DMA)         0      0   1024    0    0    1
size-1024             51     52   1024   13   13    1
size-512(DMA)          0      0    512    0    0    1
size-512             183    184    512   23   23    1
size-256(DMA)          0      0    256    0    0    1
size-256              51     60    256    4    4    1
size-128(DMA)          3     30    128    1    1    1
size-128            1574   1620    128   54   54    1
size-64(DMA)           0      0     64    0    0    1
size-64            38450  38468     64  652  652    1
size-32(DMA)          51    113     32    1    1    1
size-32            76440  78309     32  693  693    1

Have you noticed dentry_cache and inode_cache above ?
Now I will allocate (and touch) 500000 kB of ram (OK it speaks french) :

$ ~/dev/freemem 500000
Liberation de 500000 ko de ram en cours
500000 k alloues (blocs de 1k) 
Memoire liberee.

$ free
             total       used       free     shared    buffers     cached
Mem:        514532      22368     492164          0       1324       4276
-/+ buffers/cache:      16768     497764
Swap:       312316       4252     308064

$ grep cache /proc/slabinfo 
kmem_cache            81    108    108    3    3    1
clip_arp_cache         0      0    128    0    0    1
inet_peer_cache        0      0     64    0    0    1
ip_dst_cache           2     20    192    1    1    1
arp_cache              1     40     96    1    1    1
ip_arpf_cache          0      0    128    0    0    1
linvfs_icache          0      0    320    0    0    1
dnotify_cache          0      0     20    0    0    1
file_lock_cache        3     42     92    1    1    1
fasync_cache           0      0     16    0    0    1
uid_cache              6    113     32    1    1    1
skbuff_head_cache    208    220    192   11   11    1
cdev_cache            17    177     64    3    3    1
bdev_cache             8     59     64    1    1    1
mnt_cache             16     59     64    1    1    1
inode_cache          321    768    480   96   96    1
dentry_cache         338   1740    128   58   58    1
names_cache            0      2   4096    0    2    1
fs_cache              31    113     32    1    1    1
files_cache           32     36    416    4    4    1

Have you noticed the difference ? So the memory is not wasted at all. It's
just reported as 'used'.

> > If you don't believe me, simply allocate 1 GB in a process, then free it.
> 
> If that what you said is rigth, day after tomorow I'll have the same
> situation - only thing I have changed is kernel. So we'll see. :)

If you encounter it, simply run the tool below with a size in kB. Warning!
a wrong parameter associated with improper ulimit will hang your system !
Ask it to allocate what you *know* you can free (eg: the swapfree space).

> -- 
> Bart?omiej Butyn aka Yoss
> Nie ma tego z?ego co by na gorsze nie wysz?o.

Regards,
Willy

--- begin freemem.c ---
/* it's old and ugly but still useful */
#include <stdio.h>

main(int argc, char **argv) {

  unsigned long int i,k=0, max;
  char *p;


  if (argc>1)
      max=atol(argv[1]);
  else
      max=0xffffffff;

  printf("Liberation de %lu ko de ram en cours\n",max);
  /* allocation de blocs de 1 Mo */
  while (((p=(char *)malloc(1048576))!=NULL) && (k+1024<=max)) {
    for (i=0;i<256;p[4096*i++]=0);  /* utilisation du bloc */
    k+=1024;
    fprintf(stderr,"\r%d k alloues (blocs de 1M)",k);
  }
  while (((p=(char *)malloc(65536))!=NULL) && (k+64<=max)) {
    for (i=0;i<16;p[4096*i++]=0);  /* utilisation du bloc */
    k+=64;
    fprintf(stderr,"\r%d k alloues (blocs de 64k)",k);
  }
  while (((p=(char *)malloc(1024))!=NULL) && (k+1<=max)) {
    for (i=0;i<16;p[64*i++]=0);  /* utilisation du bloc */
    k+=1;
    fprintf(stderr,"\r%d k alloues (blocs de 1k) ",k);
  }
  fprintf(stderr,"\nMemoire liberee.\n");
  exit(0);
}
--- end freemem.c ---

