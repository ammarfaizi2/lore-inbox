Return-Path: <linux-kernel-owner+w=401wt.eu-S1161006AbWLTXDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWLTXDq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWLTXDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:03:45 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43233 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161006AbWLTXDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:03:45 -0500
Date: Wed, 20 Dec 2006 17:03:42 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Ingo Molnar <mingo@redhat.com>
Cc: Peter Bergner <bergner@vnet.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Mutex debug lock failure [was Re: Bad gcc-4.1.0 leads to Power4 crashes... and power5 too, actually
Message-ID: <20061220230342.GC16860@austin.ibm.com>
References: <20061220004653.GL5506@austin.ibm.com> <1166579210.4963.15.camel@otta> <20061220211931.GB16860@austin.ibm.com> <1166650134.6673.9.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166650134.6673.9.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 08:28:54AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2006-12-20 at 15:19 -0600, Linas Vepstas wrote:
> > On Tue, Dec 19, 2006 at 07:46:50PM -0600, Peter Bergner wrote:
> > 
> > I'm trying to figure out how to try a different compiler,
> > I'm hoping that 3.3 can still compile new kernels.
> > 
> > I'll try to stare at the dump a bit too, now.
> 
> I've been using 4.1.2 from debian/ubuntu happily lately.

Do you have mutex debugging turned on?

It doesn't seem to be a compiler bug. Fails in the same place,
when compiled with gcc-3.3

Reading the code, it looks like the test case double_unlock_mutex() 
fails, because the mutex lock->owner  == NULL.  
whereas, in kernel/mutex-debug.c, it wanted 

void debug_mutex_unlock(struct mutex *lock) {
   DEBUG_LOCKS_WARN_ON(lock->owner != current_thread_info());

This is called from 
lib/locking-selftest.c  circa line 490
#include "locking-selftest-mutex.h"
GENERATE_TESTCASE(double_unlock_mutex)

This may be because include/linux/mutex-debug.h which has
 __DEBUG_MUTEX_INITIALIZER in it, failes to set .owner to
any interesting value.

WHile I desperately want to conclude that the mutex lock debug 
code is broken, it seems to be unchanged fron 2.6.19
(and seems to work fine in 2.6.19-git7), so I am confused.

This also doesn't explain the bizarre form of the failure on
power4 ... does power4 mishandle twi somehow? Will investigate
next. 

--linas

p.s. To recap: above report is for linux-2.6.20-rc1-git6

I get the following on power5:

97742.318323]          A-B-B-C-C-D-D-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318352]          A-B-C-D-B-D-D-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318380]          A-B-C-D-B-C-D-A deadlock:failed|failed|  ok |failed|failed|failed|
[97742.318408]                     double unlock:  ok  |  ok |failed|<0>------------[ cut here ]------------
[97742.318440] Kernel BUG at c00000000007d574 [verbose debug info
unavailable]
cpu 0x0: Vector: 700 (Program Check) at [c0000000007a3980]
    pc: c00000000007d574: .debug_mutex_unlock+0x5c/0x118
    lr: c000000000468068: .__mutex_unlock_slowpath+0x104/0x198
    sp: c0000000007a3c00
   msr: 8000000000029032
  current = 0xc000000000663690
  paca    = 0xc000000000663f80
    pid   = 0, comm = swapper
enter ? for help
[c0000000007a3c80] c000000000468068 .__mutex_unlock_slowpath+0x104/0x198
[c0000000007a3d20] c000000000231da8 .double_unlock_mutex+0x3c/0x58
[c0000000007a3db0] c00000000023b47c .dotest+0x5c/0x370
[c0000000007a3e50] c00000000023bc0c .locking_selftest+0x47c/0x17fc
[c0000000007a3ef0] c0000000005f06ec .start_kernel+0x1e4/0x344
[c0000000007a3f90] c0000000000084c8 .start_here_common+0x54/0x8c
0:mon>
0:mon> r

0:mon> di c00000000007d518
c00000000007d518  7c0802a6      mflr    r0
c00000000007d51c  fbc1fff0      std     r30,-16(r1)
c00000000007d520  fbe1fff8      std     r31,-8(r1)
c00000000007d524  ebc2d708      ld      r30,-10488(r2)
c00000000007d528  7c7f1b78      mr      r31,r3
c00000000007d52c  f8010010      std     r0,16(r1)
c00000000007d530  f821ff81      stdu    r1,-128(r1)
c00000000007d534  e93e8008      ld      r9,-32760(r30)
  r9 = toc ptr debug_locks
c00000000007d538  80090000      lwz     r0,0(r9)
c00000000007d53c  2f800000      cmpwi   cr7,r0,0
c00000000007d540  419e00d8      beq     cr7,c00000000007d618    # .debug_mutex_unlock+0x100/0x118
   if (unlikely(!debug_locks)) return;

c00000000007d544  e8030030      ld      r0,48(r3)
  r0 = lock-> owner  == NULL
c00000000007d548  78290464      rldicr  r9,r1,0,49
  r9 = bottom 14 bits lopped off of stack pointer, giving current ptr

c00000000007d54c  7fa04800      cmpd    cr7,r0,r9
c00000000007d550  41be0028      beq     cr7,c00000000007d578    # .debug_mutex_unlock+0x60/0x118
c00000000007d554  e93e8000      ld      r9,-32768(r30)
c00000000007d558  80090000      lwz     r0,0(r9)
c00000000007d55c  2f800000      cmpwi   cr7,r0,0
c00000000007d560  409e0014      bne     cr7,c00000000007d574    # .debug_mutex_unlock+0x5c/0x118
c00000000007d564  481b1f4d      bl      c00000000022f4b0        # .debug_locks_off+0x0/0x64
c00000000007d568  60000000      nop
c00000000007d56c  2fa30000      cmpdi   cr7,r3,0
c00000000007d570  419e0008      beq     cr7,c00000000007d578    # .debug_mutex_unlock+0x60/0x118
c00000000007d574  0fe00000      twi     31,r0,0

crash here

void debug_mutex_unlock(struct mutex *lock)
{
   if (unlikely(!debug_locks))
      return;

   DEBUG_LOCKS_WARN_ON(lock->owner != current_thread_info());
   DEBUG_LOCKS_WARN_ON(lock->magic != lock);
   DEBUG_LOCKS_WARN_ON(!lock->wait_list.prev && !lock->wait_list.next);
   DEBUG_LOCKS_WARN_ON(lock->owner != current_thread_info());
}

r3 is struct mutex, which is

0:mon> d c0000000006c12c0
c0000000006c12c0 0000000100000000 80000000dead4ead  |..............N.|
c0000000006c12d0 ffffffff00000000 ffffffffffffffff  |................|
c0000000006c12e0 c0000000006c12e0 c0000000006c12e0  |.....l.......l..|
c0000000006c12f0 0000000000000000 0000000000000000  |................|
c0000000006c1300 c0000000006c12c0 0000000000000000  |.....l..........|
c0000000006c1310 00000000dead4ead ffffffff00000000  |......N.........|
c0000000006c1320 ffffffffffffffff c0000000006c1328  |.............l.(|
c0000000006c1330 c0000000006c1328 0000000100000000  |.....l.(........|

struct mutex {
   /* 1: unlocked, 0: locked, negative: locked, possible waiters */
   atomic_t    count;                   // 1
   spinlock_t     wait_lock;            // 80000000dead4ead ffffffff00000000  ffffffffffffffff
   struct list_head  wait_list;         // c0000000006c12e0 c0000000006c12e0
#ifdef CONFIG_DEBUG_MUTEXES
   struct thread_info   *owner;         // 0000000000000000
   const char     *name;                // 0000000000000000
   void        *magic;                  // c0000000006c12c0
#endif
#ifdef CONFIG_DEBUG_LOCK_ALLOC
   struct lockdep_map   dep_map;
#endif
};

typedef struct {
   raw_spinlock_t raw_lock;         // 80000000
#if defined(CONFIG_PREEMPT) && defined(CONFIG_SMP)  // # CONFIG_PREEMPT
is not set
   unsigned int break_lock;
#endif
#ifdef CONFIG_DEBUG_SPINLOCK
   unsigned int magic, owner_cpu;   // dead4ead  ffffffff
   void *owner;                     // ffffffffffffffff
#endif
#ifdef CONFIG_DEBUG_LOCK_ALLOC
   struct lockdep_map dep_map;
#endif
} spinlock_t;

