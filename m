Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262327AbSITMFD>; Fri, 20 Sep 2002 08:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262331AbSITMFD>; Fri, 20 Sep 2002 08:05:03 -0400
Received: from holomorphy.com ([66.224.33.161]:63623 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262327AbSITMFB>;
	Fri, 20 Sep 2002 08:05:01 -0400
Date: Fri, 20 Sep 2002 05:03:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: 2.5.36-mm1 dbench 512 profiles
Message-ID: <20020920120358.GV28202@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, viro@math.psu.edu
References: <20020919223007.GP28202@holomorphy.com> <68630000.1032477517@w-hlinder> <3D8A5FE6.4C5DE189@digeo.com> <20020920000815.GC3530@holomorphy.com> <200209200747.g8K7la9B174532@northrelay01.pok.ibm.com> <20020920080628.GK3530@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020920080628.GK3530@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 01:29:28PM +0530, Maneesh Soni wrote:
>> For a 32-way system fastwalk will perform badly from dcache_lock
>> point of view, basically due to increased lock hold time.
>> dcache_rcu-12 should reduce dcache_lock contention and hold time. The
>> patch uses RCU infrastructer patch and read_barrier_depends patch.
>> The patches are available in Read-Copy-Update section on lse site at
>> http://sourceforge.net/projects/lse

On Fri, Sep 20, 2002 at 01:06:28AM -0700, William Lee Irwin III wrote:
> ISTR Hubertus mentioning this at OLS, and it sounded like a problem to
> me. I'm doing some runs with this to see if it fixes the problem.

AFAICT, with one bottleneck out of the way, a new one merely arises to
take its place. Ugly. OTOH the qualitative difference is striking. The
interactive responsiveness of the machine, even when entirely unloaded,
is drastically improved, along with such nice things as init scripts
and kernel compiles also markedly faster. I suspect this is just the
wrong benchmark to show throughput benefits with.

Also notable is that the system time was significantly reduced though
I didn't log it. Essentially a long period of 100% system time is
entered after a certain point in the benchmark, during which there are
few (around 60 or 70) context switches in a second, and the duration
of this period was shortened.

The results here contradict my prior conclusions wrt. HZ 100 vs. 1000.

IMHO this worked and the stuff aroung generic_file_write_nolock(),
file_read_actor(), whatever is hammering semaphore.c, and reducing
blk_queue_bounce() traffic are the next issues to address. Any ideas?


dcache_rcu, HZ == 1000:
Throughput 36.5059 MB/sec (NB=45.6324 MB/sec  365.059 MBit/sec)  512 procs
---------------------------------------------------------------------------
c01053dc 320521015 90.6236     poll_idle
c0114ab8 13559139 3.83369     load_balance
c0114f30 3146028  0.889502    scheduler_tick
c011751d 2702819  0.76419     .text.lock.sched
c0131110 2534516  0.716605    file_read_actor
c0131bf4 1307874  0.369786    generic_file_write_nolock
c0111798 1243507  0.351587    smp_apic_timer_interrupt
c01066a8 1108969  0.313548    .text.lock.semaphore
c013fc0c 772807   0.218502    blk_queue_bounce
c01152e4 559869   0.158296    do_schedule
c0114628 323975   0.0916001   try_to_wake_up
c010d9d8 304144   0.0859931   timer_interrupt
c01062dc 271440   0.0767465   __down
c013feb4 240824   0.0680902   .text.lock.highmem
c01450b0 224874   0.0635805   generic_file_llseek
c019f55b 214729   0.0607121   .text.lock.dec_and_lock
c0136b7c 208790   0.0590329   .text.lock.slab
c0122ef4 185013   0.0523103   update_one_process
c0146dee 135391   0.0382802   .text.lock.file_table
c01472dc 127782   0.0361289   __find_get_block_slow
c015ba4c 122577   0.0346572   d_lookup
c0173cd0 115446   0.032641    ext2_new_block
c0132958 114472   0.0323656   generic_file_write


dcache_rcu, HZ == 100:
Throughput 39.1471 MB/sec (NB=48.9339 MB/sec  391.471 MBit/sec)  512 procs
--------------------------------------------------------------------------
c01053dc 331775731 95.9799     poll_idle
c0131be4 3310063  0.957573    generic_file_write_nolock
c0131100 1552058  0.448997    file_read_actor
c0114a98 1491802  0.431565    load_balance
c01066a8 1048138  0.303217    .text.lock.semaphore
c013fbec 570986   0.165181    blk_queue_bounce
c0114f10 532451   0.154033    scheduler_tick
c01152c8 311667   0.0901626   do_schedule
c013fe94 239497   0.0692844   .text.lock.highmem
c0114628 222569   0.0643873   try_to_wake_up
c019f36b 220632   0.0638269   .text.lock.dec_and_lock
c01062dc 191477   0.0553926   __down
c0136b6c 164682   0.0476411   .text.lock.slab
c011750d 160221   0.0463506   .text.lock.sched
c014729c 123385   0.0356942   __find_get_block_slow
c0173b00 120967   0.0349947   ext2_new_block
c01387f0 111699   0.0323136   __free_pages_ok
c0146dae 104794   0.030316    .text.lock.file_table
c019f2f0 102715   0.0297146   atomic_dec_and_lock
c0145070 96505    0.0279181   generic_file_llseek
c01367c4 95436    0.0276088   s_show
c0138b24 91321    0.0264184   rmqueue
c01523a8 87421    0.0252901   path_lookup

mm1, HZ == 1000:
Throughput 36.3452 MB/sec (NB=45.4315 MB/sec  363.452 MBit/sec)  512 procs
--------------------------------------------------------------------------
c01053dc 291824934 78.5936     poll_idle
c0114ab8 15361229 4.13705     load_balance
c01053a4 14040139 3.78126     default_idle
c015c5c6 7489522  2.01706     .text.lock.dcache
c01317f4 5707336  1.53709     generic_file_write_nolock
c0114f30 5425740  1.46125     scheduler_tick
c0130d10 5397721  1.4537      file_read_actor
c0154b83 3917278  1.05499     .text.lock.namei
c011749d 3508427  0.944882    .text.lock.sched
c019f8ab 2415903  0.650646    .text.lock.dec_and_lock
c01066a8 1615952  0.435205    .text.lock.semaphore
c0111798 1461670  0.393654    smp_apic_timer_interrupt
c013f81c 1330609  0.358357    blk_queue_bounce
c015ba5c 780847   0.210296    d_lookup
c013fac4 578235   0.155729    .text.lock.highmem
c0115274 542453   0.146092    do_schedule
c0114628 441528   0.118911    try_to_wake_up
c010d9d8 437417   0.117804    timer_interrupt
c01523b8 399484   0.107588    path_lookup
c01062dc 362925   0.0977422   __down
c019f830 275515   0.0742011   atomic_dec_and_lock
c0122e94 271817   0.0732051   update_one_process
c0144e00 260097   0.0700487   generic_file_llseek

mm1, HZ == 100:
Throughput 39.0368 MB/sec (NB=48.796 MB/sec  390.368 MBit/sec)  512 procs
-------------------------------------------------------------------------
c01053dc 572091962 84.309      poll_idle
c01053a4 20974286 3.09097     default_idle
c015c586 17014849 2.50747     .text.lock.dcache
c0154b43 16074116 2.36884     .text.lock.namei
c01317e4 14653053 2.15942     generic_file_write_nolock
c0130d00 5295158  0.780346    file_read_actor
c0114a98 3437483  0.506581    load_balance
c019f6bb 2455126  0.361811    .text.lock.dec_and_lock
c013f7fc 2428344  0.357864    blk_queue_bounce
c01066a8 2379650  0.350688    .text.lock.semaphore
c019f640 1525996  0.224886    atomic_dec_and_lock
c0114f10 1328712  0.195812    scheduler_tick
c0152378 923439   0.136087    path_lookup
c0144dc0 692727   0.102087    generic_file_llseek
c0115258 599269   0.0883141   do_schedule
c0114628 593380   0.0874462   try_to_wake_up
c011748d 574637   0.0846841   .text.lock.sched
c015adf0 516917   0.0761779   prune_dcache
c013676c 496571   0.0731795   .text.lock.slab
c013faa4 471971   0.0695542   .text.lock.highmem
c015b6d4 444406   0.065492    d_instantiate
c01062dc 436983   0.064398    __down
c014675c 420142   0.0619162   __fput

