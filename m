Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316435AbSETXHT>; Mon, 20 May 2002 19:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSETXHS>; Mon, 20 May 2002 19:07:18 -0400
Received: from sol.mixi.net ([208.131.233.11]:33463 "EHLO sol.mixi.net")
	by vger.kernel.org with ESMTP id <S316435AbSETXHO>;
	Mon, 20 May 2002 19:07:14 -0400
X-Envelope-From: <todd@tekinteractive.com>
X-Mailer: emacs 21.1.95.1 (via feedmail 8 I);
	VM 7.05 under Emacs 21.1.95.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15593.33184.251533.467574@rtfm.ofc.tekinteractive.com>
Date: Mon, 20 May 2002 18:07:12 -0500
From: "Todd R. Eigenschink" <todd@tekinteractive.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: kswapd OOPS under 2.4.19-pre8 (ext3, Reiserfs + (soft)raid0)
In-Reply-To: <20020520223613.GD2046@holomorphy.com>
Reply-To: todd@tekinteractive.com
X-RAVMilter-Version: 8.3.1(snapshot 20020108) (sol)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>Bitflips are usually things where a pointer turns up invalid (or
>non-NULL) and the difference between it and a valid pointer (or NULL)
>is one bit. I don't see that here and don't like blaming hardware.

Good point.


>Nice, I presume you've got -g there? Any chance of doing something like
>objdump --disassemble --source vmlinux and sending me the annotated
>disassembly of __wake_up()? I want to doublecheck something...

Everything's compiled with -g at the moment.  In fact, I tried
compiling without the -O2, but found out pretty quickly that You Can't
Do That. :) The disassembly is included below.  It's not too big.

I was upstairs rebooting from another oops when your mail arrived,
just a few hours after the last oops.  (Same workload, continuing
where it left off before.)  It was identical apart from trivialities,
and of course %ecx was 0.


>                                          The objdump --disassemble
>--source stuff is just to have the assembly and source next to each
>other for a "more convincing" demonstration, not that this isn't already
>pretty good as it stands. Of course, finding the offender will be painful.

I'll be glad to do whatever I can to help.  If four jobs crashes it in
a couple hours, 20 will probably crash it a lot sooner. :)


For whatever this may be worth--probably nothing--I have softdog
compiled in, but it has only successfully rebooted after an oops maybe
twice out of 20 or more oopsen.  On a bunch of them, the message has
come out to the serial console that it was initiating a reboot (but it
didn't).  Most of the time, it's just the oops and then...darkness.

Also, on the off chance that this is a code generation problem, this
is gcc 2.95.3.  I actually was about to say 3.0.4 and wait for the
slaps-upside-the-head, but I just checked and realized I haven't
upgraded this box.


Todd


Partial disassembly follows.  If for some strange reason you want the
whole thing, it's ~5MB and at
http://www.mixi.net/~eigenstr/vmlinux.disassembly.bz2 .

----------------------------------------------------------------------

c0116328 <__wake_up>:

/*
 * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just wake everything
 * up.  If it's an exclusive wakeup (nr_exclusive == small +ve number) then we wake all the
 * non-exclusive tasks and one exclusive task.
 *
 * There are circumstances in which we can try to wake a task which has already
 * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns zero
 * in this (rare) case, and we handle it by contonuing to scan the queue.
 */
static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
			 	     int nr_exclusive, const int sync)
{
	struct list_head *tmp;
	struct task_struct *p;

	CHECK_MAGIC_WQHEAD(q);
	WQ_CHECK_LIST_HEAD(&q->task_list);
	
	list_for_each(tmp,&q->task_list) {
		unsigned int state;
                wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);

		CHECK_MAGIC(curr->__magic);
		p = curr->task;
		state = p->state;
		if (state & mode) {
			WQ_NOTE_WAKER(curr);
			if (try_to_wake_up(p, sync) && (curr->flags&WQ_FLAG_EXCLUSIVE) && !--nr_exclusive)
				break;
		}
	}
}

void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr)
{
c0116328:	55                   	push   %ebp
c0116329:	89 e5                	mov    %esp,%ebp
c011632b:	83 ec 10             	sub    $0x10,%esp
c011632e:	57                   	push   %edi
c011632f:	56                   	push   %esi
c0116330:	53                   	push   %ebx
c0116331:	89 55 fc             	mov    %edx,0xfffffffc(%ebp)
c0116334:	89 c7                	mov    %eax,%edi
	if (q) {
c0116336:	85 ff                	test   %edi,%edi
c0116338:	0f 84 a2 00 00 00    	je     c01163e0 <__wake_up+0xb8>
		unsigned long flags;
		wq_read_lock_irqsave(&q->lock, flags);
c011633e:	9c                   	pushf  
c011633f:	8f 45 f8             	popl   0xfffffff8(%ebp)
c0116342:	fa                   	cli    
printk("eip: %p\n", &&here);
		BUG();
	}
#endif
	__asm__ __volatile__(
c0116343:	f0 fe 0f             	lock decb (%edi)
c0116346:	0f 88 5f 0f 00 00    	js     c01172ab <Letext+0x8a>
c011634c:	89 4d f4             	mov    %ecx,0xfffffff4(%ebp)
c011634f:	8b 5f 04             	mov    0x4(%edi),%ebx
c0116352:	8d 47 04             	lea    0x4(%edi),%eax
c0116355:	89 45 f0             	mov    %eax,0xfffffff0(%ebp)
c0116358:	39 c3                	cmp    %eax,%ebx
c011635a:	74 7b                	je     c01163d7 <__wake_up+0xaf>
c011635c:	8d 74 26 00          	lea    0x0(%esi,1),%esi
c0116360:	8b 4b fc             	mov    0xfffffffc(%ebx),%ecx
c0116363:	8b 01                	mov    (%ecx),%eax
c0116365:	85 45 fc             	test   %eax,0xfffffffc(%ebp)
c0116368:	74 66                	je     c01163d0 <__wake_up+0xa8>
c011636a:	31 d2                	xor    %edx,%edx
c011636c:	9c                   	pushf  
c011636d:	5e                   	pop    %esi
c011636e:	fa                   	cli    
printk("eip: %p\n", &&here);
		BUG();
	}
#endif
	__asm__ __volatile__(
c011636f:	f0 fe 0d 80 99 30 c0 	lock decb 0xc0309980
c0116376:	0f 88 3b 0f 00 00    	js     c01172b7 <Letext+0x96>
c011637c:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
c0116382:	83 79 3c 00          	cmpl   $0x0,0x3c(%ecx)
c0116386:	75 2d                	jne    c01163b5 <__wake_up+0x8d>
 */
static __inline__ void __list_add(struct list_head * new,
	struct list_head * prev,
	struct list_head * next)
{
c0116388:	a1 c0 b5 2a c0       	mov    0xc02ab5c0,%eax
	next->prev = new;
	new->next = next;
	new->prev = prev;
	prev->next = new;
}

/**
 * list_add - add a new entry
 * @new: new entry to be added
 * @head: list head to add it after
 *
 * Insert a new entry after the specified head.
 * This is good for implementing stacks.
 */
static __inline__ void list_add(struct list_head *new, struct list_head *head)
{
c011638d:	8d 51 3c             	lea    0x3c(%ecx),%edx
c0116390:	89 50 04             	mov    %edx,0x4(%eax)
c0116393:	89 41 3c             	mov    %eax,0x3c(%ecx)
c0116396:	c7 42 04 c0 b5 2a c0 	movl   $0xc02ab5c0,0x4(%edx)
c011639d:	89 15 c0 b5 2a c0    	mov    %edx,0xc02ab5c0
c01163a3:	ff 05 60 7a 32 c0    	incl   0xc0327a60
c01163a9:	89 c8                	mov    %ecx,%eax
c01163ab:	e8 48 f6 ff ff       	call   c01159f8 <reschedule_idle>
c01163b0:	ba 01 00 00 00       	mov    $0x1,%edx
		:"0" (oldval) : "memory"

static inline void spin_unlock(spinlock_t *lock)
{
	char oldval = 1;
c01163b5:	b0 01                	mov    $0x1,%al
#if SPINLOCK_DEBUG
	if (lock->magic != SPINLOCK_MAGIC)
		BUG();
	if (!spin_is_locked(lock))
		BUG();
#endif
	__asm__ __volatile__(
c01163b7:	86 05 80 99 30 c0    	xchg   %al,0xc0309980
c01163bd:	56                   	push   %esi
c01163be:	9d                   	popf   
c01163bf:	85 d2                	test   %edx,%edx
c01163c1:	74 0d                	je     c01163d0 <__wake_up+0xa8>
c01163c3:	f6 43 f8 01          	testb  $0x1,0xfffffff8(%ebx)
c01163c7:	74 07                	je     c01163d0 <__wake_up+0xa8>
c01163c9:	ff 4d f4             	decl   0xfffffff4(%ebp)
c01163cc:	74 09                	je     c01163d7 <__wake_up+0xaf>
c01163ce:	89 f6                	mov    %esi,%esi
c01163d0:	8b 1b                	mov    (%ebx),%ebx
c01163d2:	3b 5d f0             	cmp    0xfffffff0(%ebp),%ebx
c01163d5:	75 89                	jne    c0116360 <__wake_up+0x38>
		:"0" (oldval) : "memory"

static inline void spin_unlock(spinlock_t *lock)
{
	char oldval = 1;
c01163d7:	b0 01                	mov    $0x1,%al
#if SPINLOCK_DEBUG
	if (lock->magic != SPINLOCK_MAGIC)
		BUG();
	if (!spin_is_locked(lock))
		BUG();
#endif
	__asm__ __volatile__(
c01163d9:	86 07                	xchg   %al,(%edi)
		__wake_up_common(q, mode, nr, 0);
		wq_read_unlock_irqrestore(&q->lock, flags);
c01163db:	ff 75 f8             	pushl  0xfffffff8(%ebp)
c01163de:	9d                   	popf   
	}
c01163df:	90                   	nop    
c01163e0:	5b                   	pop    %ebx
c01163e1:	5e                   	pop    %esi
c01163e2:	5f                   	pop    %edi
c01163e3:	89 ec                	mov    %ebp,%esp
c01163e5:	5d                   	pop    %ebp
c01163e6:	c3                   	ret    
}
c01163e7:	90                   	nop    

----------------------------------------------------------------------

