Return-Path: <linux-kernel-owner+w=401wt.eu-S1161003AbWLTXKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161003AbWLTXKc (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161008AbWLTXKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:10:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:60497 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161003AbWLTXKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:10:31 -0500
Subject: Re: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to
	Power4 crashes... and power5 too, actually
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Bergner <bergner@vnet.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061220230342.GC16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com>
	 <1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com>
	 <1166650134.6673.9.camel@localhost.localdomain>
	 <20061220230342.GC16860@austin.ibm.com>
Content-Type: text/plain
Date: Thu, 21 Dec 2006 10:09:55 +1100
Message-Id: <1166656195.6673.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This also doesn't explain the bizarre form of the failure on
> power4 ... does power4 mishandle twi somehow? Will investigate
> next. 

Or you hit it before you have a console ?

Ben.

> --linas
> 
> p.s. To recap: above report is for linux-2.6.20-rc1-git6
> 
> I get the following on power5:
> 
> 97742.318323]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok |failed|failed|failed|
> [97742.318352]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok |failed|failed|failed|
> [97742.318380]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok |failed|failed|failed|
> [97742.318408]                     double unlock:  ok  |  ok |failed|<0>------------[ cut here ]------------
> [97742.318440] Kernel BUG at c00000000007d574 [verbose debug info
> unavailable]
> cpu 0x0: Vector: 700 (Program Check) at [c0000000007a3980]
>     pc: c00000000007d574: .debug_mutex_unlock+0x5c/0x118
>     lr: c000000000468068: .__mutex_unlock_slowpath+0x104/0x198
>     sp: c0000000007a3c00
>    msr: 8000000000029032
>   current = 0xc000000000663690
>   paca    = 0xc000000000663f80
>     pid   = 0, comm = swapper
> enter ? for help
> [c0000000007a3c80] c000000000468068 .__mutex_unlock_slowpath+0x104/0x198
> [c0000000007a3d20] c000000000231da8 .double_unlock_mutex+0x3c/0x58
> [c0000000007a3db0] c00000000023b47c .dotest+0x5c/0x370
> [c0000000007a3e50] c00000000023bc0c .locking_selftest+0x47c/0x17fc
> [c0000000007a3ef0] c0000000005f06ec .start_kernel+0x1e4/0x344
> [c0000000007a3f90] c0000000000084c8 .start_here_common+0x54/0x8c
> 0:mon>
> 0:mon> r
> 
> 0:mon> di c00000000007d518
> c00000000007d518  7c0802a6      mflr    r0
> c00000000007d51c  fbc1fff0      std     r30,-16(r1)
> c00000000007d520  fbe1fff8      std     r31,-8(r1)
> c00000000007d524  ebc2d708      ld      r30,-10488(r2)
> c00000000007d528  7c7f1b78      mr      r31,r3
> c00000000007d52c  f8010010      std     r0,16(r1)
> c00000000007d530  f821ff81      stdu    r1,-128(r1)
> c00000000007d534  e93e8008      ld      r9,-32760(r30)
>   r9 = toc ptr debug_locks
> c00000000007d538  80090000      lwz     r0,0(r9)
> c00000000007d53c  2f800000      cmpwi   cr7,r0,0
> c00000000007d540  419e00d8      beq     cr7,c00000000007d618    # .debug_mutex_unlock+0x100/0x118
>    if (unlikely(!debug_locks)) return;
> 
> c00000000007d544  e8030030      ld      r0,48(r3)
>   r0 = lock-> owner  == NULL
> c00000000007d548  78290464      rldicr  r9,r1,0,49
>   r9 = bottom 14 bits lopped off of stack pointer, giving current ptr
> 
> c00000000007d54c  7fa04800      cmpd    cr7,r0,r9
> c00000000007d550  41be0028      beq     cr7,c00000000007d578    # .debug_mutex_unlock+0x60/0x118
> c00000000007d554  e93e8000      ld      r9,-32768(r30)
> c00000000007d558  80090000      lwz     r0,0(r9)
> c00000000007d55c  2f800000      cmpwi   cr7,r0,0
> c00000000007d560  409e0014      bne     cr7,c00000000007d574    # .debug_mutex_unlock+0x5c/0x118
> c00000000007d564  481b1f4d      bl      c00000000022f4b0        # .debug_locks_off+0x0/0x64
> c00000000007d568  60000000      nop
> c00000000007d56c  2fa30000      cmpdi   cr7,r3,0
> c00000000007d570  419e0008      beq     cr7,c00000000007d578    # .debug_mutex_unlock+0x60/0x118
> c00000000007d574  0fe00000      twi     31,r0,0
> 
> crash here
> 
> void debug_mutex_unlock(struct mutex *lock)
> {
>    if (unlikely(!debug_locks))
>       return;
> 
>    DEBUG_LOCKS_WARN_ON(lock->owner != current_thread_info());
>    DEBUG_LOCKS_WARN_ON(lock->magic != lock);
>    DEBUG_LOCKS_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
>    DEBUG_LOCKS_WARN_ON(lock->owner != current_thread_info());
> }
> 
> r3 is struct mutex, which is
> 
> 0:mon> d c0000000006c12c0
> c0000000006c12c0 0000000100000000 80000000dead4ead  |..............N.|
> c0000000006c12d0 ffffffff00000000 ffffffffffffffff  |................|
> c0000000006c12e0 c0000000006c12e0 c0000000006c12e0  |.....l.......l..|
> c0000000006c12f0 0000000000000000 0000000000000000  |................|
> c0000000006c1300 c0000000006c12c0 0000000000000000  |.....l..........|
> c0000000006c1310 00000000dead4ead ffffffff00000000  |......N.........|
> c0000000006c1320 ffffffffffffffff c0000000006c1328  |.............l.(|
> c0000000006c1330 c0000000006c1328 0000000100000000  |.....l.(........|
> 
> struct mutex {
>    /* 1: unlocked, 0: locked, negative: locked, possible waiters */
>    atomic_t    count;                   // 1
>    spinlock_t     wait_lock;            // 80000000dead4ead ffffffff00000000  ffffffffffffffff
>    struct list_head  wait_list;         // c0000000006c12e0 c0000000006c12e0
> #ifdef CONFIG_DEBUG_MUTEXES
>    struct thread_info   *owner;         // 0000000000000000
>    const char     *name;                // 0000000000000000
>    void        *magic;                  // c0000000006c12c0
> #endif
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
>    struct lockdep_map   dep_map;
> #endif
> };
> 
> typedef struct {
>    raw_spinlock_t raw_lock;         // 80000000
> #if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)  // # CONFIG_PREEMPT
> is not set
>    unsigned int break_lock;
> #endif
> #ifdef CONFIG_DEBUG_SPINLOCK
>    unsigned int magic, owner_cpu;   // dead4ead  ffffffff
>    void *owner;                     // ffffffffffffffff
> #endif
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
>    struct lockdep_map dep_map;
> #endif
> } spinlock_t;

