Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317729AbSGKC4x>; Wed, 10 Jul 2002 22:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317730AbSGKC4w>; Wed, 10 Jul 2002 22:56:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44816 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317729AbSGKC4u>;
	Wed, 10 Jul 2002 22:56:50 -0400
Message-ID: <3D2CF62E.949F20B4@zip.com.au>
Date: Wed, 10 Jul 2002 20:06:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hanna Linder <hannal@us.ibm.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Keith Mannthey <mannthey@us.ibm.com>, haveblue@us.ibm.com,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: scalable kmap (was Re: vm lock contention reduction) (fwd)
References: <237170000.1026317715@flay> <40740000.1026339488@w-hlinder>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hanna Linder wrote:
> 
> ...
> Andrew and Martin,
> 
>         I ran this updated patch on 2.5.25 with dbench on
> the 8-way with 4 Gb of memory compared to clean 2.5.25.
> I saw a significant improvement in throughput about 15%
> (averaged over 5 runs each).

Thanks, Hanna.

The kernel compile test isn't a particularly heavy user of
copy_to_user(), whereas with RAM-only dbench, copy_*_user()
is almost the only thing it does.  So that makes sense.

Tried dbench on the 2.5G 4xPIII Xeon: no improvement at all.
This thing seems to have quite poor memory bandwidth - maybe
250 megabyte/sec downhill with the wind at its tail.

>         Included is the pretty picture (akpm-2525.png) the
> data that picture came from (akpm-2525.data) and the raw
> results of the runs with min/max and timing results
> (2525akpmkmaphi and 2525clnhi).
>         I believe the drop at around 64 clients is caused by
> memory swapping leading to increased disk accesses since the
> time increased by 200% in direct correlation with the decreased
> throughput.

Yes.  The test went to disk.   There are two reasons why
it will do this:

1: Some dirty data was in memory for more than 30-35 seconds or

2: More than 40% of memory is dirty.

In your case, the 64-client run was taking 32 seconds.  After that
the disks lit up.  Once that happens, dbench isn't a very good
benchmark.  It's an excellent benchmark when it's RAM-only
though.  Very repeatable and hits lots of code paths which matter.

You can run more clients before the disk I/O cuts in by
increasing /proc/sys/vm/dirty_expire_centisecs and
/proc/sys/vm/dirty_*_ratio.

The patch you tested only uses the atomic kmap across generic_file_read.
It is reasonable to hope that another 15% or morecan be gained by holding
an atomic kmap across writes as well.  On your machine ;)

Here's what oprofile says about `dbench 40' with that patch:

c0140f1c 402      0.609543    __block_commit_write    
c013dfd4 413      0.626222    vfs_write               
c01402cc 431      0.653515    __find_get_block        
c013a895 472      0.715683    .text.lock.highmem      
c017fe30 494      0.749041    ext2_get_block          
c012cef0 564      0.85518     unlock_page             
c013ee80 564      0.85518     fget                    
c01079f4 571      0.865794    apic_timer_interrupt    
c01e8ecc 594      0.900669    radix_tree_lookup       
c013da90 597      0.905218    generic_file_llseek     
c01514b4 607      0.92038     __d_lookup              
c0106ff8 687      1.04168     system_call             
c013a02c 874      1.32523     kunmap_high             
c0148388 922      1.39801     link_path_walk          
c0140b00 1097     1.66336     __block_prepare_write   
c01346d0 1138     1.72552     rmqueue                 
c01127ac 1243     1.88473     smp_apic_timer_interrupt 
c0139eb8 1514     2.29564     kmap_high               
c0105368 6188     9.38272     poll_idle               
c012d8a8 9564     14.5017     file_read_actor         
c012ea70 21326    32.3361     generic_file_write      


Not taking a kmap in generic_file_write is a biggish patch - it
means changing the prepare_write/commit_write API and visiting
all filesystems.  The API change would be: core kernel no longer
holds a kmap across prepare/commit. If the filesystem wants one
for its own purposes then it gets to do it for itself, possibly in
its prepare_write().

I think I'd prefer to get some additional testing and understanding
before undertaking that work.  It arguably makes sense as a small
cleanup/speedup anyway, but that's not a burning issue.

hmm.  I'll do just ext2, and we can take another look then.

-
