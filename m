Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136306AbRDVWyD>; Sun, 22 Apr 2001 18:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136305AbRDVWxz>; Sun, 22 Apr 2001 18:53:55 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:12480 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S136304AbRDVWxn>;
	Sun, 22 Apr 2001 18:53:43 -0400
Content-Type: Multipart/Mixed;
  charset="iso-8859-1";
  boundary="------------Boundary-00=_H7U7UYK0T7DOAVAKJABQ"
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: andrea@suse.de
Subject: Re: [PATCH] rw_semaphores, optimisations
Date: Sun, 22 Apr 2001 23:52:29 +0100
X-Mailer: KMail [version 1.2]
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, dhowells@redhat.com
MIME-Version: 1.0
Message-Id: <01042223522900.05293@orion.ddi.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_H7U7UYK0T7DOAVAKJABQ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hello Andrea,

Interesting benchmarks... did you compile the test programs with "make 
SCHED=yes" by any chance? Also what other software are you running?

The reason I ask is that running a full blown KDE setup running in the 
background, I get the following numbers on the rwsem-ro test (XADD optimised 
kernel):

    SCHED: 4615646, 4530769, 4534453 and 4628365
    no SCHED: 6311620, 6312776, 6327772 and 6325508

Also quite stable as you can see.

> (ah and btw the machine is a 2-way PII 450mhz). 

Your numbers were "4274607" and "4280280" for this kernel and test This I 
find a little suprising. I'd expect them to be about 10% higher than I get on 
my machine given your faster CPUs.

What compiler are you using? I'm using the following:

   Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
   gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-80)

Something else that I noticed: Playing a music CD appears to improve the 
benchmarks all round:-) Must be some interrupt effect of some sort, or maybe 
they just like the music...

> rwsem-2.4.4-pre6 + my new generic rwsem (fast path in C inlined)

Linus wants out of line generic code only, I believe. Hence why I made my 
generic code out of line.

I have noticed one glaring potential slowdown in my generic code's down 
functions. I've got the following in _both_ fastpaths!:

    struct task_struct *tsk = current;

It shouldn't hurt _too_ much (its only reg->reg anyway), but it will have an 
effect. I'll have to move it and post another patch tomorrow.

I've also been comparing the assembly from the two generic spinlock 
implementations (having out-of-lined yours in what I think is the you'd have 
done it). I've noticed a number of things:

  (1) My fastpaths have slightly fewer instructions in them

  (2) gcc-2.96-20000731 produces what looks like much less efficient code
      than gcc-snapshot-20010409 (to be expected, I suppose).

  (3) Both compilers do insane things to registers (like in one instruction
      moving %eax to %edx and then moving it back again in the next).

  (4) If _any_ inline assembly is used, the compiler grabs extra chunks of
      stack which it does not then use. It will then pop these into registers
      under some circumstances. It'll also save random registers it doesn't
      clobber under others.

(Basically, I had a lot of frustrating fun playing around with the spinlock 
asm constraints trying to avoid the compiler clobbering registers 
unnecessarily because of them).

I've attached the source file I've been playing with and an example 
disassembly dump for your amusement. I used the snapshot gcc to do this (it 
emits conditional chunks of code out of line more intelligently than the 
older one.

It's also interesting that your generic out-of-line semaphores are faster 
given the fact that you muck around with EFLAGS and CLI/STI, and I don't. 
Maybe I'm getting hit by an interrupt. I'll have to play around with it and 
benchmark it again.

David

--------------Boundary-00=_H7U7UYK0T7DOAVAKJABQ
Content-Type: text/x-plain;
  charset="iso-8859-1";
  name="slowpath.c"
Content-Transfer-Encoding: 8bit
Content-Description: rwsem implementations slowpath comparison C source code
Content-Disposition: attachment; filename="slowpath.c"

/* slowpath.c: description
 *
 * Copyright (c) 2001   David Howells (dhowells@redhat.com).
 */
#define __KERNEL__
#include <asm/types.h>
#include <asm/current.h>
#include <asm/system.h>
#include <linux/kernel.h>
#include <linux/list.h>
#include <linux/spinlock.h>

struct rw_semaphore_dwh {
	__u32			active;
	__u32			waiting;
	spinlock_t		wait_lock;
};

extern void FASTCALL(dwh_down_read(struct rw_semaphore_dwh *));
extern void FASTCALL(dwh_up_read(struct rw_semaphore_dwh *));
extern void FASTCALL(dwh_down_read_failed(struct rw_semaphore_dwh *,
					  struct task_struct *));
extern void FASTCALL(dwh__rwsem_do_wake(struct rw_semaphore_dwh *));

struct rw_semaphore_aa {
	spinlock_t lock;
	int count;
	struct list_head wait;
};

#define RWSEM_WAITQUEUE_READ 0

extern void FASTCALL(aa_down_read(struct rw_semaphore_aa *));
extern void FASTCALL(aa_up_read(struct rw_semaphore_aa *));
extern void FASTCALL(aa_down_failed(struct rw_semaphore_aa *, int));
extern void FASTCALL(aa_rwsem_wake(struct rw_semaphore_aa *));

void dwh_down_read(struct rw_semaphore_dwh *sem)
{
	struct task_struct *tsk = current;
	spin_lock(&sem->wait_lock);

	if (sem->waiting) {
		sem->active++;
		spin_unlock(&sem->wait_lock);
		goto out;
	}
	sem->waiting++;
	dwh_down_read_failed(sem,tsk);
	spin_unlock(&sem->wait_lock);
 out:
}

void aa_down_read(struct rw_semaphore_aa *sem)
{
	spin_lock_irq(&sem->lock);
	if (sem->count < 0 || !list_empty(&sem->wait))
		goto slow_path;
	sem->count++;
 out:
	spin_unlock_irq(&sem->lock);
	return;

 slow_path:
	aa_down_failed(sem, RWSEM_WAITQUEUE_READ);
	goto out;
}

void dwh_up_read(struct rw_semaphore_dwh *sem)
{
	spin_lock(&sem->wait_lock);

	if (--sem->active==0 && sem->waiting)
		dwh__rwsem_do_wake(sem);

	spin_unlock(&sem->wait_lock);
}

void aa_up_read(struct rw_semaphore_aa *sem)
{
	unsigned long flags;

	spin_lock_irqsave(&sem->lock, flags);
	if (!--sem->count && !list_empty(&sem->wait))
		aa_rwsem_wake(sem);
	spin_unlock_irqrestore(&sem->lock, flags);
}

--------------Boundary-00=_H7U7UYK0T7DOAVAKJABQ
Content-Type: text/plain;
  charset="iso-8859-1";
  name="slowpath.dis"
Content-Transfer-Encoding: 8bit
Content-Description: disassembly of compiled slowpath.c
Content-Disposition: attachment; filename="slowpath.dis"


slowpath.o:     file format elf32-i386

Disassembly of section .text:

00000000 <dwh_down_read>:
   0:	53                   	push   %ebx
   1:	83 ec 08             	sub    $0x8,%esp
   4:	89 c3                	mov    %eax,%ebx
   6:	ba 00 e0 ff ff       	mov    $0xffffe000,%edx
   b:	21 e2                	and    %esp,%edx
   d:	f0 fe 4b 08          	lock decb 0x8(%ebx)
  11:	0f 88 fc ff ff ff    	js     13 <dwh_down_read+0x13>
  17:	8b 4b 04             	mov    0x4(%ebx),%ecx
  1a:	85 c9                	test   %ecx,%ecx
  1c:	74 0a                	je     28 <dwh_down_read+0x28>
  1e:	ff 03                	incl   (%ebx)
  20:	c6 43 08 01          	movb   $0x1,0x8(%ebx)
  24:	58                   	pop    %eax
  25:	5a                   	pop    %edx
  26:	5b                   	pop    %ebx
  27:	c3                   	ret    
  28:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
  2f:	89 d8                	mov    %ebx,%eax
  31:	e8 fc ff ff ff       	call   32 <dwh_down_read+0x32>
  36:	eb e8                	jmp    20 <dwh_down_read+0x20>

00000038 <aa_down_read>:
  38:	53                   	push   %ebx
  39:	83 ec 08             	sub    $0x8,%esp
  3c:	89 c3                	mov    %eax,%ebx
  3e:	fa                   	cli    
  3f:	f0 fe 0b             	lock decb (%ebx)
  42:	0f 88 09 00 00 00    	js     51 <aa_down_read+0x19>
  48:	8b 53 04             	mov    0x4(%ebx),%edx
  4b:	85 d2                	test   %edx,%edx
  4d:	78 19                	js     68 <aa_down_read+0x30>
  4f:	8d 43 08             	lea    0x8(%ebx),%eax
  52:	39 43 08             	cmp    %eax,0x8(%ebx)
  55:	75 11                	jne    68 <aa_down_read+0x30>
  57:	8d 42 01             	lea    0x1(%edx),%eax
  5a:	89 43 04             	mov    %eax,0x4(%ebx)
  5d:	c6 03 01             	movb   $0x1,(%ebx)
  60:	fb                   	sti    
  61:	5b                   	pop    %ebx
  62:	58                   	pop    %eax
  63:	5b                   	pop    %ebx
  64:	c3                   	ret    
  65:	8d 76 00             	lea    0x0(%esi),%esi
  68:	31 d2                	xor    %edx,%edx
  6a:	89 d8                	mov    %ebx,%eax
  6c:	e8 fc ff ff ff       	call   6d <aa_down_read+0x35>
  71:	eb ea                	jmp    5d <aa_down_read+0x25>
  73:	90                   	nop    

00000074 <dwh_up_read>:
  74:	53                   	push   %ebx
  75:	83 ec 08             	sub    $0x8,%esp
  78:	89 c3                	mov    %eax,%ebx
  7a:	f0 fe 4b 08          	lock decb 0x8(%ebx)
  7e:	0f 88 15 00 00 00    	js     99 <dwh_up_read+0x25>
  84:	8b 03                	mov    (%ebx),%eax
  86:	48                   	dec    %eax
  87:	89 03                	mov    %eax,(%ebx)
  89:	85 c0                	test   %eax,%eax
  8b:	74 0b                	je     98 <dwh_up_read+0x24>
  8d:	c6 43 08 01          	movb   $0x1,0x8(%ebx)
  91:	5a                   	pop    %edx
  92:	59                   	pop    %ecx
  93:	5b                   	pop    %ebx
  94:	c3                   	ret    
  95:	8d 76 00             	lea    0x0(%esi),%esi
  98:	8b 43 04             	mov    0x4(%ebx),%eax
  9b:	85 c0                	test   %eax,%eax
  9d:	74 ee                	je     8d <dwh_up_read+0x19>
  9f:	89 d8                	mov    %ebx,%eax
  a1:	e8 fc ff ff ff       	call   a2 <dwh_up_read+0x2e>
  a6:	eb e5                	jmp    8d <dwh_up_read+0x19>

000000a8 <aa_up_read>:
  a8:	56                   	push   %esi
  a9:	53                   	push   %ebx
  aa:	51                   	push   %ecx
  ab:	89 c3                	mov    %eax,%ebx
  ad:	9c                   	pushf  
  ae:	5e                   	pop    %esi
  af:	fa                   	cli    
  b0:	f0 fe 0b             	lock decb (%ebx)
  b3:	0f 88 22 00 00 00    	js     db <aa_up_read+0x33>
  b9:	8b 43 04             	mov    0x4(%ebx),%eax
  bc:	48                   	dec    %eax
  bd:	89 43 04             	mov    %eax,0x4(%ebx)
  c0:	85 c0                	test   %eax,%eax
  c2:	74 0c                	je     d0 <aa_up_read+0x28>
  c4:	c6 03 01             	movb   $0x1,(%ebx)
  c7:	56                   	push   %esi
  c8:	9d                   	popf   
  c9:	5a                   	pop    %edx
  ca:	5b                   	pop    %ebx
  cb:	5e                   	pop    %esi
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  d0:	8d 43 08             	lea    0x8(%ebx),%eax
  d3:	39 43 08             	cmp    %eax,0x8(%ebx)
  d6:	74 ec                	je     c4 <aa_up_read+0x1c>
  d8:	89 d8                	mov    %ebx,%eax
  da:	e8 fc ff ff ff       	call   db <aa_up_read+0x33>
  df:	eb e3                	jmp    c4 <aa_up_read+0x1c>
Disassembly of section .text.lock:

00000000 <.text.lock>:
   0:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
   4:	f3 90                	repz nop 
   6:	7e f8                	jle    0 <.text.lock>
   8:	e9 09 00 00 00       	jmp    16 <.text.lock+0x16>
   d:	80 3b 00             	cmpb   $0x0,(%ebx)
  10:	f3 90                	repz nop 
  12:	7e f9                	jle    d <.text.lock+0xd>
  14:	e9 3b 00 00 00       	jmp    54 <aa_down_read+0x1c>
  19:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
  1d:	f3 90                	repz nop 
  1f:	7e f8                	jle    19 <.text.lock+0x19>
  21:	e9 76 00 00 00       	jmp    9c <dwh_up_read+0x28>
  26:	80 3b 00             	cmpb   $0x0,(%ebx)
  29:	f3 90                	repz nop 
  2b:	7e f9                	jle    26 <.text.lock+0x26>
  2d:	e9 ac 00 00 00       	jmp    de <aa_up_read+0x36>

--------------Boundary-00=_H7U7UYK0T7DOAVAKJABQ--
