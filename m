Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263029AbTDBPXZ>; Wed, 2 Apr 2003 10:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263032AbTDBPXZ>; Wed, 2 Apr 2003 10:23:25 -0500
Received: from franka.aracnet.com ([216.99.193.44]:59102 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263029AbTDBPXX>; Wed, 2 Apr 2003 10:23:23 -0500
Date: Wed, 02 Apr 2003 07:34:31 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.66-mm2
Message-ID: <31520000.1049297670@[10.10.2.4]>
In-Reply-To: <20030401173402.2a6f728f.akpm@digeo.com>
References: <20030401000127.5acba4bc.akpm@digeo.com><151780000.1049245829@flay> <20030401173402.2a6f728f.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Ho hum. All very strange. Kernbench seems to be really behaving itself
>> quite well now, but SDET sucks worse than ever. The usual 16x NUMA-Q 
>> machine .... 
>> 
>> Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
>>                               Elapsed      System        User         CPU
>>                2.5.66-mm2       44.04       81.12      569.40     1476.75
>>           2.5.66-mm2-ext3       44.43       84.10      568.82     1469.00
> 
> Is this ext2 versus ext3?  If so, that's a pretty good result isn't it?  I
> forget what kernbench looked like for stock ext3.

Yes, it's splendid. Used to look more like this:

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
            2.5.61-mjb0.1       46.04      115.46      563.07     1472.25
       2.5.61-mjb0.1-ext3       48.45      143.79      564.14     1459.00

That was before I had noatime though (I think) ...

Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
                              Elapsed      System        User         CPU
              2.5.65-mjb1       43.73       81.69      563.54     1475.00
         2.5.65-mjb1-ext3       44.13       79.77      564.56     1460.25

So I think after noatime, SDET was really the big problem.

>> SDET 32  (see disclaimer)
>>                            Throughput    Std. Dev
>>                2.5.66-mm2       100.0%         0.7%
>>           2.5.66-mm2-ext3         4.7%         1.5%
> 
> Yes, this is presumably a lot more metadata-intensive, so we're just
> hammering the journal semaphore to death.  We're working on it.

Ah, that makes sense, thanks.
 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/benchmarks/2.5.66-mm2-ext3/
> 
> Offtopic, a raw sdet64 profile says:
> 
> 5392317 total
> 4478683 default_idle
> 307163 __down
> 169770 .text.lock.sched
> 106769 schedule
> 88092 __wake_up
> 57280 .text.lock.transaction
> 
> I'm slightly surprised that the high context switch rate is showing up so
> much contention in sched.c.  I'm assuming that it's on the sleep/wakeup path
> and not in the context switch path.  It would be interesting to inline the
> spinlock code and reprofile.

OK, done. diffprofile with an without spinlines below:

    350487   158.8% schedule
     67691     0.6% total
     49184     0.5% default_idle
     43095  1680.1% journal_start
     42048   136.1% do_get_write_access
     34988   638.7% journal_stop
     16813  1527.1% inode_change_ok
      6752     3.6% __wake_up
      5960     0.9% __down
      3942  3718.9% sem_exit
      3323   725.5% inode_setattr
      3191  1470.5% proc_pid_readlink
      1646  2743.3% sys_ioctl
       418    16.8% atomic_dec_and_lock
       408     4.4% journal_add_journal_head
       303   841.7% proc_root_lookup
       258     4.6% __find_get_block
       256    33.0% follow_mount
       245     1.7% journal_dirty_metadata
       223     4.7% __find_get_block_slow
       213  2366.7% chrdev_open
       209  1492.9% proc_root_readdir
       202     2.6% find_get_page
       171     8.8% journal_unlock_journal_head
       146     6.2% kmem_cache_free
       126     2.7% do_anonymous_page
       120     1.3% copy_page_range
       111  1387.5% sys_sysctl
       107    93.9% journal_get_create_access
       106     0.8% cpu_idle
       106   963.6% __posix_lock_file
       101   280.6% put_filp
       100  1666.7% de_put
...
      -102   -13.1% fget
      -118  -100.0% .text.lock.char_dev
      -120    -2.2% block_write_full_page
      -123   -20.0% block_prepare_write
      -127   -93.4% remove_from_page_cache
      -142  -100.0% .text.lock.sysctl
      -167    -1.5% __blk_queue_bounce
      -183   -27.8% do_generic_mapping_read
      -203   -11.7% free_hot_cold_page
      -205  -100.0% .text.lock.dcache
      -211   -13.0% buffered_rmqueue
      -237   -98.8% .text.lock.namei
      -426  -100.0% .text.lock.dec_and_lock
      -458  -100.0% .text.lock.root
      -516    -8.8% __copy_to_user_ll
      -781  -100.0% .text.lock.journal
     -1696  -100.0% .text.lock.ioctl
     -3123  -100.0% .text.lock.base
     -4048  -100.0% .text.lock.sem
    -19538  -100.0% .text.lock.attr
   -117523   -99.9% .text.lock.transaction
   -347530  -100.0% .text.lock.sched

Thanks, 

M.

