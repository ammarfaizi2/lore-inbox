Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261979AbSIPOWE>; Mon, 16 Sep 2002 10:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261994AbSIPOWD>; Mon, 16 Sep 2002 10:22:03 -0400
Received: from smtpout.mac.com ([204.179.120.85]:16333 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261979AbSIPOVy>;
	Mon, 16 Sep 2002 10:21:54 -0400
Date: Mon, 16 Sep 2002 16:25:03 +0200
Subject: Oops in sched.c on PPro SMP
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
Cc: andrea@suse.de, mingo@redhat.com
To: linux-kernel@vger.kernel.org
From: Peter Waechtler <pwaechtler@mac.com>
Content-Transfer-Encoding: 7bit
Message-Id: <174178B9-C980-11D6-8873-00039387C942@mac.com>
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suffered from lockups on PPro SMP as I switched from 2.4.18-SuSE
to 2.4.19 and 2.4.20-pre7

First I thought it was caused by bttv, overheat or stack overflow -
but to make it short: I think it's a bug in schedule() or
something broken with  CONFIG_X86_PPRO_FENCE

I fetched three Oopses at exactly the same instruction
ksymoops 2.4.3 on i686 2.4.20-pre7.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.20-pre7/ (default)
      -m /boot/System.map-2.4.20-pre7 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 
00000020
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117f10>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210207
eax: 00000005   ebx: 00000014   ecx: 00000000   edx: 00000006
esi: c0be0000   edi: c51d803c   ebp: c0be1fbc   esp: c0be1f8c
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 4674, stackpage=c0be1000)
Stack: c0be0000 000040b1 000040b0 cd406ea0 c02c1400 00000000 00000001 
00000001
00000000 00000000 c0be0000 c03079c0 bffff0cc c0108d09 00000000 0000000c
409d0040 000040b1 000040b0 bffff0cc 000c40b1 0000002b 0020002b ffffffef
Call Trace:    [<c0108d09>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

 >>EIP; c0117f10 <schedule+248/550>   <=====
Trace; c0108d08 <reschedule+4/c>
Code;  c0117f10 <schedule+248/550>
00000000 <_EIP>:
Code;  c0117f10 <schedule+248/550>   <=====
    0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0117f12 <schedule+24a/550>
    3:   d1 fa                     sar    %edx
Code;  c0117f14 <schedule+24c/550>
    5:   89 d8                     mov    %ebx,%eax
Code;  c0117f16 <schedule+24e/550>
    7:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0117f1a <schedule+252/550>
    a:   c1 f8 02                  sar    $0x2,%eax
Code;  c0117f1c <schedule+254/550>
    d:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0117f20 <schedule+258/550>
   11:   89 51 20                  mov    %edx,0x20(%ecx)

---------- Oops 2 -------------
ksymoops 2.4.3 on i686 2.4.19.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.19/ (default)
      -m /boot/System.map-2.4.19 (default)

Unable to handle kernel NULL pointer dereference at virtual address 
00000020
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0117f80>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210207
eax: 00000005   ebx: 00000014   ecx: 00000000   edx: 00000006
esi: c6d82000   edi: c6d8203c   ebp: c6d83fbc   esp: c6d83f8c
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 2005, stackpage=c6d83000)
Stack: c6d82000 40ef2040 0000013c c7125080 c02b9900 00000004 c011590f 
00000002
00000000 00000001 c6d82000 c02ff9e0 bffff05c c0108a99 40efa2fc 40ef7874
40ef4ed4 40ef2040 0000013c bffff05c 00000000 c010002b 0000002b ffffffef
Call Trace:    [<c011590f>] [<c0108a99>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

 >>EIP; c0117f80 <schedule+228/530>   <=====
Trace; c011590e <smp_apic_timer_interrupt+f2/114>
Trace; c0108a98 <reschedule+4/c>
Code;  c0117f80 <schedule+228/530>
00000000 <_EIP>:
Code;  c0117f80 <schedule+228/530>   <=====
    0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
---------- Oops 3 (not sure about kernel version) -------------
Unable to handle kernel NULL pointer dereference at virtual address 
00000020
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0117f80>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210207
eax: 00000005   ebx: 00000014   ecx: 00000000   edx: 00000006
esi: c529a000   edi: c529a03c   ebp: c529bfbc   esp: c529bf8c
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 2001, stackpage=c529b000)
Stack: c529a000 000c2703 00184e08 cd43a7a0 c02b9900 00000004 c011590f 
00000002
        00000000 00000001 c529a000 c02ff9e0 bffff0bc c0108a99 00184e06 
0807ac20
        0000009f 000c2703 00184e08 bffff0bc 001842f0 c010002b 0000002b 
ffffffef
Call Trace:    [<c011590f>] [<c0108a99>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

 >>EIP; c0117f80 <schedule+2b8/550>   <=====
Trace; c011590e <nmi_watchdog_tick+4e/100>
Trace; c0108a98 <do_signal+22c/294>
Code;  c0117f80 <schedule+2b8/550>
00000000 <_EIP>:
Code;  c0117f80 <schedule+2b8/550>   <=====
    0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
---------- Oops 4 -------------
While typing this: Oops with ecx!=NULL:
Unable to handle kernel paging request< >t rirtial adpress e1170009
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0117f10>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210206
eax: f7e60005   ebx: 00000014   ecx: e9000009   edx: fa345205
esi: c45d2000   edi: c45d203c   ebp: c45d3fbc   esp: c45d3f8c
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 2035, stackpage=c45d3000)
Stack: c45d2000 00013e0c 40ec2040 c26efc20 c02c1400 00000000 00000001 
00000001
00000000 00000000 c45d2000 c03079c0 bfffefec c0108d09 0001360c 0001320c
40f0b870 00013e0c 40ec2040 bfffefec 00012e0c 0000002b 0000002b ffffffef
Call Trace:    [<c0108d09>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

 >>EIP; c0117f10 <schedule+248/550>   <=====
Trace; c0108d08 <reschedule+4/c>
Code;  c0117f10 <schedule+248/550>
00000000 <_EIP>:
Code;  c0117f10 <schedule+248/550>   <=====
    0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
[...]


Here the relevant intermixed assembly/source from objdump:
gcc -I ../include -I ../include/linux -I ../include/asm-i386 \
	-g -O2 -c sched.c -D__KERNEL__
objdump -S sched.o >sched.txt

     /* Do we need to re-calculate counters? */
     if (unlikely(!c)) {
      62d:   83 7d f0 00             cmpl   $0x0,0xfffffff0(%ebp)
      631:   75 6d                   jne    6a0 <schedule+0x290>
         :"0" (oldval) : "memory"

static inline void spin_unlock(spinlock_t *lock)
{
     char oldval = 1;
      633:   b0 01                   mov    $0x1,%al
#if SPINLOCK_DEBUG
     if (lock->magic != SPINLOCK_MAGIC)
         BUG();
     if (!spin_is_locked(lock))
         BUG();
#endif
     __asm__ __volatile__(
      635:   86 05 00 00 00 00       xchg   %al,0x0
         struct task_struct *p;

         spin_unlock_irq(&runqueue_lock);
      63b:   fb                      sti	<===== INTERRUPTS ENABLE
  */
/* the spinlock helpers are in arch/i386/kernel/semaphore.c */
static inline void read_lock(rwlock_t *rw)
{
      63c:   b8 00 00 00 00          mov    $0x0,%eax
#if SPINLOCK_DEBUG
     if (rw->magic != RWLOCK_MAGIC)
         BUG();
#endif
     __build_read_lock(rw, "__read_lock_failed");
      641:   f0 83 28 01             lock subl $0x1,(%eax)
      645:   0f 88 59 13 00 00       js     19a4 <Letext+0x40>
         read_lock(&tasklist_lock);
         for_each_task(p)
      64b:   8b 0d 48 00 00 00       mov    0x48,%ecx
      651:   81 f9 00 00 00 00       cmp    $0x0,%ecx
      657:   74 26                   je     67f <schedule+0x26f>
      659:   bb 14 00 00 00          mov    $0x14,%ebx
      65e:   89 f6                   mov    %esi,%esi
             p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
      660:   8b 51 20                mov    0x20(%ecx),%edx  <= CRASH
      663:   d1 fa                   sar    %edx
      665:   89 d8                   mov    %ebx,%eax
      667:   2b 41 24                sub    0x24(%ecx),%eax
      66a:   c1 f8 02                sar    $0x2,%eax
      66d:   8d 54 10 01             lea    0x1(%eax,%edx,1),%edx
      671:   89 51 20                mov    %edx,0x20(%ecx)
      674:   8b 49 48                mov    0x48(%ecx),%ecx
      677:   81 f9 00 00 00 00       cmp    $0x0,%ecx
      67d:   75 e1                   jne    660 <schedule+0x250>
         read_unlock(&tasklist_lock);
      67f:   f0 ff 05 00 00 00 00    lock incl 0x0
         spin_lock_irq(&runqueue_lock);
      686:   fa                      cli


First I thought the readlocks were broken by the compiler, due
to syntax changes. But staring at the code I wondered how
%ecx can become zero at 660: - from this code it's impossible!
But wait: we allowed interrupts again...

So my explanation is as follows: the scheduler is interrupted
and entry.S calls:

ENTRY(ret_from_intr)
	GET_CURRENT(%ebx)
ret_from_exception:
	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
	movb CS(%esp),%al
	testl $(VM_MASK | 3),%eax	# return to VM86 mode or non-supervisor?
	jne ret_from_sys_call
	jmp restore_all

	ALIGN
reschedule:
	call SYMBOL_NAME(schedule)    # test
	jmp ret_from_sys_call

ENTRY(ret_from_sys_call)
	cli				# need_resched and signals atomic test
	cmpl $0,need_resched(%ebx)
	jne reschedule
	cmpl $0,sigpending(%ebx)
	jne signal_return
restore_all:
	RESTORE_ALL


The spin_unlock_irq(&runqueue_lock); was already there in 2.4.16
I can't check when it was introduced - perhaps since the beginning?
But this explains my former reported crashes in the scheduler half
a year ago - I think it always happened when switching from a SuSE
kernel to Linus tree.

So there are 2 possibilities: the spin_unlock_irq(&runqueue_lock)
is wrong in the scheduler, but this should be noted by more SMP
users then, or the CONFIG_X86_PPRO_FENCE does not work as expected.
I will replace the spin_unlock_irq with spin_unlock for a test spin..


This is a snippet from
diff -Nu linux-2.4.18.SuSE/kernel/sched.c linux-2.4.19/kernel/sched.c

         /* Do we need to re-calculate counters? */
         if (unlikely(!c)) {
-               ++rcl_curr;
-               list_for_each(tmp, numa_runqueue_head(numa_node_id())) {
-                       p = list_entry(tmp, struct task_struct, 
run_list);
-                       p->time_slice = TASK_TIMESLICE(p);
-               }
-#ifdef CONFIG_NUMA_SCHED
-               if (recalculate_all) {
-                       int nid;
-
-                       for (nid = 0; nid < numnodes; nid++) {
-                               if (nid == numa_node_id())
-                                       continue;
-                               list_for_each(tmp, 
numa_runqueue_head(nid)) {
-                                       p = list_entry(tmp, struct 
task_struct,
run_list);
-                                       p->time_slice = 
TASK_TIMESLICE(p);
-                               }
-                       }
-               }
-#endif
+               struct task_struct *p;
+
+               spin_unlock_irq(&runqueue_lock);
+               read_lock(&tasklist_lock);
+               for_each_task(p)
+                       p->counter = (p->counter >> 1) + 
NICE_TO_TICKS(p->nice);
+               read_unlock(&tasklist_lock);
+               spin_lock_irq(&runqueue_lock);
                 goto repeat_schedule;
         }


--- snippet .config ---
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y

--- /proc/cpuinfo ---
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 7
cpu MHz         : 200.457
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
bogomips        : 399.76

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 200.457
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
bogomips        : 400.58

