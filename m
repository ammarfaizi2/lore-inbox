Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267492AbSLFBUY>; Thu, 5 Dec 2002 20:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbSLFBUX>; Thu, 5 Dec 2002 20:20:23 -0500
Received: from mailhub1.une.edu.au ([129.180.1.202]:19716 "HELO
	mailhub1.une.edu.au") by vger.kernel.org with SMTP
	id <S267492AbSLFBUV>; Thu, 5 Dec 2002 20:20:21 -0500
Date: Fri, 6 Dec 2002 12:27:53 +1100
From: Norman Gaywood <norm@turing.une.edu.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206122753.A8992@turing.une.edu.au>
References: <mailman.1039133948.27411.linux-kernel2news@redhat.com> <200212060035.gB60ZnV07386@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200212060035.gB60ZnV07386@devserv.devel.redhat.com>; from zaitcev@redhat.com on Thu, Dec 05, 2002 at 07:35:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 07:35:49PM -0500, Pete Zaitcev wrote:
> > I think I have a trigger for a VM bug in the RH kernel-bigmem-2.4.18-18
> 
> > By doing a large copy I can trigger this problem in about 30-40 minutes. At
> > the end of that time, kswapd will start to get a larger % of CPU and
> > the system load will be around 2-3. The system will feel sluggish at an
> > interactive shell and it will take several seconds before a command like
> > top would start to display. [...]
> 
> Check your /proc/slabinfo, just in case, to rule out a leak.

Here is a /proc/slabinfo diff of a good system and a very sluggish one:

1c1
< Mon Nov 25 17:13:04 EST 2002
---
> Mon Nov 25 22:35:58 EST 2002
6c6
< nfs_inode_cache        6      6    640    1    1    1 :  124   62
---
> nfs_inode_cache        1      6    640    1    1    1 :  124   62
8,11c8,11
< ip_fib_hash          224    224     32    2    2    1 :  252  126
< journal_head        3101  36113     48   69  469    1 :  252  126
< revoke_table         250    250     12    1    1    1 :  252  126
< revoke_record        672    672     32    6    6    1 :  252  126
---
> ip_fib_hash           10    224     32    2    2    1 :  252  126
> journal_head          12    154     48    2    2    1 :  252  126
> revoke_table           7    250     12    1    1    1 :  252  126
> revoke_record          0      0     32    0    0    1 :  252  126
14,20c14,20
< tcp_tw_bucket        210    210    128    7    7    1 :  252  126
< tcp_bind_bucket      896    896     32    8    8    1 :  252  126
< tcp_open_request     180    180    128    6    6    1 :  252  126
< inet_peer_cache        0      0     64    0    0    1 :  252  126
< ip_dst_cache         105    105    256    7    7    1 :  252  126
< arp_cache             90     90    128    3    3    1 :  252  126
< blkdev_requests    16548  17430    128  561  581    1 :  252  126
---
> tcp_tw_bucket          0      0    128    0    0    1 :  252  126
> tcp_bind_bucket       28    784     32    7    7    1 :  252  126
> tcp_open_request       0      0    128    0    0    1 :  252  126
> inet_peer_cache        1     58     64    1    1    1 :  252  126
> ip_dst_cache          40    105    256    7    7    1 :  252  126
> arp_cache              4     90    128    3    3    1 :  252  126
> blkdev_requests    16384  16410    128  547  547    1 :  252  126
22c22
< file_lock_cache      328    328     92    8    8    1 :  252  126
---
> file_lock_cache        3     82     92    2    2    1 :  252  126
24,27c24,27
< uid_cache            672    672     32    6    6    1 :  252  126
< skbuff_head_cache   1107   2745    256   77  183    1 :  252  126
< sock                 270    270   1280   90   90    1 :   60   30
< sigqueue             870    870    132   30   30    1 :  252  126
---
> uid_cache              9    448     32    4    4    1 :  252  126
> skbuff_head_cache    816   1110    256   74   74    1 :  252  126
> sock                  81    129   1280   43   43    1 :   60   30
> sigqueue              29     29    132    1    1    1 :  252  126
29,33c29,33
< cdev_cache           498   2262     64   12   39    1 :  252  126
< bdev_cache           290    290     64    5    5    1 :  252  126
< mnt_cache            232    232     64    4    4    1 :  252  126
< inode_cache       543337 553490    512 79070 79070    1 :  124   62
< dentry_cache      373336 554430    128 18481 18481    1 :  252  126
---
> cdev_cache            16    290     64    5    5    1 :  252  126
> bdev_cache            27    174     64    3    3    1 :  252  126
> mnt_cache             19    174     64    3    3    1 :  252  126
> inode_cache       305071 305081    512 43583 43583    1 :  124   62
> dentry_cache         418   2430    128   81   81    1 :  252  126
35,43c35,43
< filp                 930    930    128   31   31    1 :  252  126
< names_cache           48     48   4096   48   48    1 :   60   30
< buffer_head       831810 831810    128 27727 27727    1 :  252  126
< mm_struct            510    510    256   34   34    1 :  252  126
< vm_area_struct      4488   4740    128  158  158    1 :  252  126
< fs_cache             696    696     64   12   12    1 :  252  126
< files_cache          469    469    512   67   67    1 :  124   62
< signal_act           388    418   1408   38   38    4 :   60   30
< pae_pgd              696    696     64   12   12    1 :  252  126
---
> filp                1041   1230    128   41   41    1 :  252  126
> names_cache            7      8   4096    7    8    1 :   60   30
> buffer_head       3431966 3432150    128 114405 114405    1 :  252  126
> mm_struct            198    315    256   21   21    1 :  252  126
> vm_area_struct      5905   5970    128  199  199    1 :  252  126
> fs_cache             204    464     64    8    8    1 :  252  126
> files_cache          204    217    512   31   31    1 :  124   62
> signal_act           246    286   1408   26   26    4 :   60   30
> pae_pgd              198    638     64   11   11    1 :  252  126
51c51
< size-16384            16     24  16384   16   24    4 :    0    0
---
> size-16384            20     20  16384   20   20    4 :    0    0
53c53
< size-8192              5     11   8192    5   11    2 :    0    0
---
> size-8192              9      9   8192    9    9    2 :    0    0
55c55
< size-4096            287    407   4096  287  407    1 :   60   30
---
> size-4096             56     56   4096   56   56    1 :   60   30
57c57
< size-2048            426    666   2048  213  333    1 :   60   30
---
> size-2048            281    314   2048  157  157    1 :   60   30
59c59
< size-1024           1024   1272   1024  256  318    1 :  124   62
---
> size-1024            659    712   1024  178  178    1 :  124   62
61c61
< size-512            3398   3584    512  445  448    1 :  124   62
---
> size-512            2782   2856    512  357  357    1 :  124   62
63c63
< size-256             777   1155    256   67   77    1 :  252  126
---
> size-256             101    255    256   17   17    1 :  252  126
65c65
< size-128            4836  19200    128  244  640    1 :  252  126
---
> size-128            2757   3750    128  125  125    1 :  252  126
67c67
< size-64             8958  20550    128  356  685    1 :  252  126
---
> size-64              178    510    128   17   17    1 :  252  126
69c69
< size-32            23262  43674     64  433  753    1 :  252  126
---
> size-32              711   1218     64   21   21    1 :  252  126


> > cat /proc/meminfo
> This is not interesting. Get it _after_ the box becomes sluggish.

I don't have one of those, but here is a top of a sluggish system:

  3:51pm  up 43 min,  3 users,  load average: 1.69, 1.28, 0.92
109 processes: 108 sleeping, 1 running, 0 zombie, 0 stopped
CPU0 states:  0.0% user,  0.3% system,  0.0% nice, 99.2% idle
CPU1 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU2 states:  0.0% user,  0.0% system,  0.0% nice, 100.0% idle
CPU3 states:  0.0% user,  1.4% system,  0.0% nice, 98.0% idle
CPU4 states:  0.0% user, 58.2% system,  0.0% nice, 41.2% idle
CPU5 states:  0.0% user, 96.4% system,  0.0% nice,  3.0% idle
CPU6 states:  0.0% user,  0.5% system,  0.0% nice, 99.0% idle
CPU7 states:  0.0% user,  0.3% system,  0.0% nice, 99.2% idle
Mem:  16280784K av, 15747124K used,  533660K free,       0K shrd, 20952K buff
Swap: 33559768K av,       0K used, 33559768K free 15037240K cached

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
   19 root      25   0     0    0     0 SW   96.7  0.0   1:52 kswapd
 1173 root      21   0 10592  10M   424 D    58.2  0.0   3:30 cp
  202 root      15   0     0    0     0 DW    1.9  0.0   0:04 kjournald
  205 root      15   0     0    0     0 DW    0.9  0.0   0:10 kjournald
   21 root      15   0     0    0     0 SW    0.5  0.0   0:01 kupdated
 1121 root      16   0  1056 1056   836 R     0.5  0.0   0:09 top
    1 root      15   0   476  476   424 S     0.0  0.0   0:04 init
    2 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU0
    3 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU1
    4 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU2
    5 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU3
    6 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU4
    7 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU5
    8 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU6
    9 root      0K   0     0    0     0 SW    0.0  0.0   0:00 migration_CPU7
   10 root      15   0     0    0     0 SW    0.0  0.0   0:00 keventd

> Remember, the 2.4.18 stream in RH does not have its own VM, distinct
> from Marcelo+Riel. So, you can come to linux-kernel for advice,
> but first, get it all reproduced with Marcelo's tree with
> Riel's patches all the same.

Yep, I understand that. I just thought this might be of interest
however. It's pretty hard to find a place to talk about this problem
with someone who might know something! I've got a service request in
with RH but no answer yet, but it's only been 1.5 days.

While I've been writing this it looks like Andrew Morton and Andrea
Arcangeli have given me some great answers and have declared this a
"well known problem".  Looks like I've got something to try.

-- 
Norman Gaywood -- School of Mathematical and Computer Sciences
University of New England, Armidale, NSW 2351, Australia
norm@turing.une.edu.au     http://turing.une.edu.au/~norm
Phone: +61 2 6773 2412     Fax: +61 2 6773 3312
