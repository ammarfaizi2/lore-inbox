Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316359AbSETU1E>; Mon, 20 May 2002 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316360AbSETU1E>; Mon, 20 May 2002 16:27:04 -0400
Received: from sol.mixi.net ([208.131.233.11]:25005 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S316359AbSETU1B>;
	Mon, 20 May 2002 16:27:01 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.23568.756199.612888@rtfm.ofc.tekinteractive.com>
Date: Mon, 20 May 2002 15:26:56 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
In-Reply-To: <20020520170059.GA2046@holomorphy.com>
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>On Mon, May 20, 2002 at 07:58:25AM -0500, Todd R. Eigenschink wrote:
>> I'm going to run memtest86 on it for a while after it gets done with
>> its morning processing, although this failure seems a little too
>> consistent to be memory related.
>
>I hope I didn't say that.

Someone else had suggested testing the memory and power supply.
memtest86 is easy to run, so I'll try that.  It'll have to be tonight,
now.


>The __wake_up()/unlock_page() isn't the interesting part of the call
>chain, the parts from end_buffer_io_async() to ide_dma_intr() are.
>
>Any chance you can list them in gdb?

Well, after my posting from earlier today, I recompiled the kernel
after stripping some more stuff.  I just induced an oops in that one,
so I can list the call stack for it.

No IDE stuff this time; this looks a lot like most of the other ones
I've seen.  This morning was the first time I've ever seen IDE stuff
in the post-oops call stack.

It seems I can pretty much induce them at will, now.  I started up
four simultaneous Webtrends sessions, which grow fairly quickly to
400-600 MB each, give or take.  (The machine has 2 GB of RAM, so it
only swaps a little, sometimes.)  Within half an hour, it fell over.

Here's the oops itself, then the gdb output.


----------------------------------------------------------------------
Oops: 0000
CPU:    1
EIP:    0010:[<c0116363>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: c2802db4   ebx: c2002db4   ecx: 00000000   edx: 00000003
esi: c2802db0   edi: c2802db0   ebp: f7bf3ee8   esp: f7bf3ecc
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=f7bf3000)
Stack: c133d790 c2802db0 c02acbf4 c2802db4 00000000 00000282 00000003 d911d9f0
       c0129b19 0076eb00 c133d790 f7bf3f4c c0130817 00000000 c12e9ca0 00000020
       00008efe 81e65000 81a7d000 1147d047 00000009 81c00000 f6c99818 81c00000
Call Trace: [<c0129b19>] [<c0130817>] [<c0130ca7>] [<c0130ea0>] [<c0130efc>]
   [<c0130f97>] [<c0130ff6>] [<c0131107>] [<c010712c>]
Code: 8b 01 85 45 fc 74 66 31 d2 9c 5e fa f0 fe 0d 80 99 30 c0 0f


>>EIP; c0116363 <__wake_up+3b/c0>   <=====

>>eax; c2802db4 <END_OF_CODE+249b758/????>
>>ebx; c2002db4 <END_OF_CODE+1c9b758/????>
>>esi; c2802db0 <END_OF_CODE+249b754/????>
>>edi; c2802db0 <END_OF_CODE+249b754/????>
>>ebp; f7bf3ee8 <END_OF_CODE+3788c88c/????>
>>esp; f7bf3ecc <END_OF_CODE+3788c870/????>

Trace; c0129b19 <unlock_page+81/88>
Trace; c0130817 <swap_out+347/4b4>
Trace; c0130ca7 <shrink_cache+323/3cc>
Trace; c0130ea0 <shrink_caches+5c/84>
Trace; c0130efc <try_to_free_pages+34/54>
Trace; c0130f97 <kswapd_balance_pgdat+47/90>
Trace; c0130ff6 <kswapd_balance+16/2c>
Trace; c0131107 <kswapd+9b/b6>
Trace; c010712c <kernel_thread+28/38>

Code;  c0116363 <__wake_up+3b/c0>
00000000 <_EIP>:
Code;  c0116363 <__wake_up+3b/c0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0116365 <__wake_up+3d/c0>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c0116368 <__wake_up+40/c0>
   5:   74 66                     je     6d <_EIP+0x6d> c01163d0 <__wake_up+a8/c
0>
Code;  c011636a <__wake_up+42/c0>
   7:   31 d2                     xor    %edx,%edx
Code;  c011636c <__wake_up+44/c0>
   9:   9c                        pushf  
Code;  c011636d <__wake_up+45/c0>
   a:   5e                        pop    %esi
Code;  c011636e <__wake_up+46/c0>
   b:   fa                        cli    
Code;  c011636f <__wake_up+47/c0>
   c:   f0 fe 0d 80 99 30 c0      lock decb 0xc0309980
Code;  c0116376 <__wake_up+4e/c0>
  13:   0f 00 00                  sldtl  (%eax)


----------------------------------------------------------------------

(gdb) list *__wake_up+0x3b
0x973 is in __wake_up (sched.c:731).
726                     unsigned int state;
727                     wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
728
729                     CHECK_MAGIC(curr->__magic);
730                     p = curr->task;
731                     state = p->state;
732                     if (state & mode) {
733                             WQ_NOTE_WAKER(curr);
734                             if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
735                                     break;


(gdb) list *unlock_page+0x81
0xcf9 is in unlock_page (filemap.c:845).
840             smp_mb__before_clear_bit();
841             if (!test_and_clear_bit(PG_locked, &(page)->flags))
842                     BUG();
843             smp_mb__after_clear_bit(); 
844             if (waitqueue_active(waitqueue))
845                     wake_up_all(waitqueue);
846     }
847
848     /*
849      * Get a lock on the page, assuming we need to sleep



(gdb) list *swap_out+0x347
No source file for address 0x347.

(gdb) list *swap_out
0x0 is in kswapd_init (vmscan.c:750).
745             }
746     }
747
748     static int __init kswapd_init(void)
749     {
750             printk("Starting kswapd\n");
751             swap_setup();
752             kernel_thread(kswapd, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGNAL);
753             return 0;
754     }


(I'm fuzzzy on swap_out...can I not see the code because it's a static
function?)



(gdb) list *shrink_cache+0x323
0x7d7 is in shrink_cache (vmscan.c:483).
478                              * Alert! We've found too many mapped pages on the
479                              * inactive list, so we start swapping out now!
480                              */
481                             spin_unlock(&pagemap_lru_lock);
482                             swap_out(priority, gfp_mask, classzone);
483                             return nr_pages;
484                     }
485
486                     /*
487                      * It is critical to check PageDirty _after_ we made sure


(gdb) list *shrink_caches+0x5c
0x9d0 is in shrink_caches (vmscan.c:571).
566             nr_pages = chunk_size;
567             /* try to keep the active list 2/3 of the size of the cache */
568             ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
569             refill_inactive(ratio);
570
571             nr_pages = shrink_cache(nr_pages, classzone, gfp_mask, priority);
572             if (nr_pages <= 0)
573                     return 0;
574
575             shrink_dcache_memory(priority, gfp_mask);


(gdb) list *try_to_free_pages+0x34
0xa2c is in try_to_free_pages (vmscan.c:591).
586             int priority = DEF_PRIORITY;
587             int nr_pages = SWAP_CLUSTER_MAX;
588
589             gfp_mask = pf_gfp_mask(gfp_mask);
590             do {
591                     nr_pages = shrink_caches(classzone, priority, gfp_mask, nr_pages);
592                     if (nr_pages <= 0)
593                             return 1;
594             } while (--priority);
595


(gdb) list *kswapd_balance_pgdat+0x47
0xac7 is in kswapd_balance_pgdat (vmscan.c:630).
625                     zone = pgdat->node_zones + i;
626                     if (unlikely(current->need_resched))
627                             schedule();
628                     if (!zone->need_balance)
629                             continue;
630                     if (!try_to_free_pages(zone, GFP_KSWAPD, 0)) {
631                             zone->need_balance = 0;
632                             __set_current_state(TASK_INTERRUPTIBLE);
633                             schedule_timeout(HZ);
634                             continue;


(gdb) list *kswapd_balance+0x16
0xb26 is in kswapd_balance (vmscan.c:655).
650             do {
651                     need_more_balance = 0;
652                     pgdat = pgdat_list;
653                     do
654                             need_more_balance |= kswapd_balance_pgdat(pgdat);
655                     while ((pgdat = pgdat->node_next));
656             } while (need_more_balance);
657     }
658
659     static int kswapd_can_sleep_pgdat(pg_data_t * pgdat)


(gdb) list *kswapd+0x9b
0xc37 is in kswapd (/src/linux-2.4.19-pre8/include/linux/tqueue.h:121).
116
117     extern void __run_task_queue(task_queue *list);
118
119     static inline void run_task_queue(task_queue *list)
120     {
121             if (TQ_ACTIVE(*list))
122                     __run_task_queue(list);
123     }
124
125     #endif /* _LINUX_TQUEUE_H */


(gdb) list *kernel_thread+0x28
0x3fc is in kernel_thread (process.c:492).
487      */
488     int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
489     {
490             long retval, d0;
491
492             __asm__ __volatile__(
493                     "movl %%esp,%%esi\n\t"
494                     "int $0x80\n\t"         /* Linux/i386 system call */
495                     "cmpl %%esp,%%esi\n\t"  /* child or parent? */
496                     "je 1f\n\t"             /* parent - jump */

----------------------------------------------------------------------

