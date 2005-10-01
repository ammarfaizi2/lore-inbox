Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVJAMEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVJAMEt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 08:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVJAMEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 08:04:49 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:23259
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750802AbVJAMEt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 08:04:49 -0400
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, Andrew Morton <akpm@osdl.org>,
       george@mvista.com, johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
In-Reply-To: <Pine.LNX.4.61.0509301825290.3728@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de>
	 <Pine.LNX.4.61.0509301825290.3728@scrub.home>
Content-Type: multipart/mixed; boundary="=-lYK2I8+Z4raSvEKhyr60"
Organization: linutronix
Date: Sat, 01 Oct 2005 14:05:44 +0200
Message-Id: <1128168344.15115.496.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lYK2I8+Z4raSvEKhyr60
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Roman,

On Sat, 2005-10-01 at 03:03 +0200, Roman Zippel wrote:

> Your patch introduces some whitespace damage, search for "^\+  " in your 
> patch.

Ok.

> > ktimers seperate the "timer API" from the "timeout API". 
> I'm not really happy with these names, timeouts are what timers do, so 
> these names don't tell at all, what the difference is.

There is a clear distinction between timers and timeouts.

>From IT-dictonary:

"Timeout is a specified period of time that will be allowed to elapse in
a system before a specified event is to take place, unless another
specified event occurs first; in either case, the period is terminated
when either event takes place."

"A timer is a specialized type of clock. A timer can be used to control
the sequence of an event or process."

> Calling them "process timer" and "kernel timer" would include their main 
> usage, although that also means ptimer were the more correct abbreviation.

As said before I think the disctinction between timers and timeouts
makes perfectly sense and ktimers are _not_ restricted to process
timers. 

> > +#ifndef KTIME_IS_SCALAR
> > +typedef union {
> > +	s64	tv64;
> > +	struct {
> > +#ifdef __BIG_ENDIAN
> > +	s32	sec, nsec;
> > +#else
> > +	s32	nsec, sec;
> > +#endif
> > +	} tv;
> > +} ktime_t;
> > +
> > +#else
> > +
> > +typedef s64 ktime_t;
> > +
> > +#endif
> 
> Making the union unconditional, would make tv64 always available and a lot 
> of macros unnessary.

nsec,sec storage format is essentially different to the scalar storage
format and has to be handled different.

The above gives a clear distinction between scalar and sec/nsec based
cases. So you cannot mess up without notice. 

I prefer having a lot more macros / inlines around rather than tracking
down _one_ single bug which happens by a non clearly seperated
implementation.

> > +struct ktimer {
> > +	struct rb_node		node;
> > +	struct list_head	list;
> > +	ktime_t			expires;
> > +	ktime_t			expired;
> > +	ktime_t			interval;
> > +	int 	 	 	overrun;
> > +	unsigned long		status;
> > +	void 			(*function)(void *);
> > +	void			*data;
> > +	struct ktimer_base 	*base;
> > +};
> 
> This structure is rather large and I think a lot can be avoided.
> - list: AFAICT it's only used by run_ktimer_queue() to get the first 
> pending entry. This can also be done by keeping track of the first entry 
> in the base structure (useful in other places as well).

You are right that the list is not necessary for the plain integration
into the current system, but it is necessary once you start to upgrade
to high resolution timers.

> - expired: can be replaced by base->last_expired (may also be useful in 
> other places)

How gives base->last_expired a per timer expired information? And where
would it be useful ?

> - status: only user is ktimer_active(), the same test can be done by 
> testing node.rb_parent.

Uurg. Been there and discarded the idea, because its ugly and clashes
with further extensibilty requirements e.g. high resolution timers,
where we have more than two states. 

Having status information bound to arbitrary pointers is trading a
variable against flexibility, cleanliness and maintainability. 

> - interval/overrun: this is only needed by itimers and I think it's 
> possible to leave it there. Main change would be to let 'function' return 
> a value indicating whether to rearm the timer or not (this includes 
> expires is updated).

It is also used by the posix timer code and I plan to do another round
of simplification also there.


This implementation is chosen to be flexible and easy exstensible for
use cases like high resolution timers. 


I do not want to end up with a next round of discussion there about
either introducing tons of new ifdefs, macros or redesigning the code
base another time. 

As others have stated too, we have to wage the tradeoff between 

simplicity, flexibility, maintainability 
vs.
size and performance impacts

Performance is definitely an important issue and was accepted and
addressed.

The tradeoff of the size in question is not a valid argument to give up
a clear, flexible and maintainable design.

> > +#define DEFINE_KTIME(k) ktime_t k = {.tv64 = 0LL }
> > +
> > +#define ktime_cmp(a,op,b) ((a).tv64 op (b).tv64)
> > +#define ktime_cmp_val(a, op, b) ((a).tv64 op b)
> 
> A union ktime would especially avoid this.

See above

> > +static inline ktime_t ktime_sub(ktime_t a, ktime_t b)
> > +{
> > +	ktime_t res;
> > +
> > +	res.tv64 = a.tv64 - b.tv64;
> > +	if (res.tv.nsec < 0)
> > +		res.tv.nsec += NSEC_PER_SEC;
> > +
> > +	return res;
> > +}
> > +
> > +static inline ktime_t ktime_add(ktime_t a, ktime_t b)
> > +{
> > +	ktime_t res;
> > +
> > +	res.tv64 = a.tv64 + b.tv64;
> > +	if (res.tv.nsec >= NSEC_PER_SEC) {
> > +		res.tv.nsec -= NSEC_PER_SEC;
> > +		res.tv.sec++;
> > +	}
> > +	return res;
> > +}
> 
> Not using 64bit math here allows gcc to generate better code, e.g. gcc 
> has to add another test for "nsec < 0" because the condition code is 
> already used for the overflow, adding the "sec--" instead is IMO faster 
> (i.e. less likely).

i686
DOADD32         00000048
DOADD64         0000002a
DOSUB32         00000060
DOSUB64         0000002f
arm
DOADD32         0000004c
DOADD64         0000004c
DOSUB32         00000040
DOSUB64         00000038
m68k
DOADD32         0000003c
DOADD64         0000002e
DOSUB32         00000036
DOSUB64         00000028
powerpc
DOADD32         00000040
DOADD64         00000044
DOSUB32         00000044
DOSUB64         00000044
m68k
DOADD32         0000003c
DOADD64         0000002e
DOSUB32         00000036
DOSUB64         00000028

Please do not tell me that size does not matter. :)

I attached the assembler dumps, so you can have a look yourself. I did
these tests during the implementation and decided on the results rather
than on assumptions about gcc.


> Could you explain a little the resolution handling behind in your patch?
> If I read SUS correctly clock resolution and timer resolution don't have 
> to be the same, the first is returned by clock_getres() and the latter 
> only documented somewhere (and AFAICT our implementation always returned 
> the wrong value).

As far as I understand SUS timer resolution is equal to clock resolution
and the timer value/interval is rounded up to the resolution.

> IMO this also means we can don't have to make the rounding that 
> complicated. Actually it could be done automatically by the timer, e.g. 
> interval timer are reprogrammed at (now + interval) and the timer 
> resolution will automatically round it up.

Reprogramming interval timers by now + interval is completely wrong.
Reprogramming has to be 
timer->expires + interval and nothing else. 

Doing real rounding in the reprogramming code would be a performance
impact.

> > +	/* Get current time */
> > +	now = base->get_time();
> 
> As get_time() is not necessarily cheap, it can be avoided for nonrelative 
> timers by comparing it with the first pending timer. Maintaining a pointer 
> to the first timer here, avoids the timer list and is a simple check 
> whether the time source needs any reprogramming later.

Would you please care to read the complete related code to find out why
this does not work. This is totaly unrelated to reprogramming of the
time event source in the HRT case.
...
	case KTIMER_FORWARD:
		while ktime_cmp(timer->expires, <= , now) {
...

	case KTIMER_REARM:
		while ktime_cmp(timer->expires, <= , now) {
			timer->expires = ktime_add(timer->expires,

and of course the expiry check below.

> > +	if ktime_cmp(timer->expires, <=, now) {
> > +		timer->expired = now;
> > +		/* The caller takes care of expiry */
> > +		if (!(mode & KTIMER_NOCHECK))
> > +			return -1;
> 
> I think KTIMER_NOFAIL would be better name, for a while that had me 
> confused, as you actually do check the value, but you don't fail it and 
> enqueue it anyway.

It does not fail. It returns in the case that the timer is already
expired. The NOCHECK flag is used to skip the check.

tglx


--=-lYK2I8+Z4raSvEKhyr60
Content-Disposition: attachment; filename=testarchs.dmp
Content-Type: text/plain; name=testarchs.dmp; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



DOADD32

ktime.o:     file format elf32-i386

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 0c             	sub    $0xc,%esp
   6:	89 1c 24             	mov    %ebx,(%esp)
   9:	8b 45 14             	mov    0x14(%ebp),%eax
   c:	8b 5d 10             	mov    0x10(%ebp),%ebx
   f:	89 74 24 04          	mov    %esi,0x4(%esp)
  13:	8b 55 18             	mov    0x18(%ebp),%edx
  16:	89 7c 24 08          	mov    %edi,0x8(%esp)
  1a:	8d 34 03             	lea    (%ebx,%eax,1),%esi
  1d:	81 fe ff c9 9a 3b    	cmp    $0x3b9ac9ff,%esi
  23:	8d 3c 13             	lea    (%ebx,%edx,1),%edi
  26:	7e 07                	jle    2f <ktime_ops+0x2f>
  28:	81 ee 00 ca 9a 3b    	sub    $0x3b9aca00,%esi
  2e:	47                   	inc    %edi
  2f:	8b 45 08             	mov    0x8(%ebp),%eax
  32:	89 30                	mov    %esi,(%eax)
  34:	89 78 04             	mov    %edi,0x4(%eax)
  37:	8b 1c 24             	mov    (%esp),%ebx
  3a:	8b 74 24 04          	mov    0x4(%esp),%esi
  3e:	8b 7c 24 08          	mov    0x8(%esp),%edi
  42:	89 ec                	mov    %ebp,%esp
  44:	5d                   	pop    %ebp
  45:	c2 04 00             	ret    $0x4
-------------------------------------------------------------------------

DOADD64

ktime.o:     file format elf32-i386

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	8b 55 14             	mov    0x14(%ebp),%edx
   6:	03 55 0c             	add    0xc(%ebp),%edx
   9:	8b 4d 18             	mov    0x18(%ebp),%ecx
   c:	8b 45 08             	mov    0x8(%ebp),%eax
   f:	13 4d 10             	adc    0x10(%ebp),%ecx
  12:	81 fa ff c9 9a 3b    	cmp    $0x3b9ac9ff,%edx
  18:	7e 07                	jle    21 <ktime_ops+0x21>
  1a:	81 ea 00 ca 9a 3b    	sub    $0x3b9aca00,%edx
  20:	41                   	inc    %ecx
  21:	89 10                	mov    %edx,(%eax)
  23:	89 48 04             	mov    %ecx,0x4(%eax)
  26:	5d                   	pop    %ebp
  27:	c2 04 00             	ret    $0x4
-------------------------------------------------------------------------

DOSUB32

ktime.o:     file format elf32-i386

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 0c             	sub    $0xc,%esp
   6:	89 74 24 04          	mov    %esi,0x4(%esp)
   a:	89 7c 24 08          	mov    %edi,0x8(%esp)
   e:	89 1c 24             	mov    %ebx,(%esp)
  11:	8b 5d 10             	mov    0x10(%ebp),%ebx
  14:	8b 45 14             	mov    0x14(%ebp),%eax
  17:	8b 55 18             	mov    0x18(%ebp),%edx
  1a:	89 de                	mov    %ebx,%esi
  1c:	89 df                	mov    %ebx,%edi
  1e:	29 c6                	sub    %eax,%esi
  20:	29 d7                	sub    %edx,%edi
  22:	85 f6                	test   %esi,%esi
  24:	78 1a                	js     40 <ktime_ops+0x40>
  26:	8b 45 08             	mov    0x8(%ebp),%eax
  29:	89 30                	mov    %esi,(%eax)
  2b:	89 78 04             	mov    %edi,0x4(%eax)
  2e:	8b 1c 24             	mov    (%esp),%ebx
  31:	8b 74 24 04          	mov    0x4(%esp),%esi
  35:	8b 7c 24 08          	mov    0x8(%esp),%edi
  39:	89 ec                	mov    %ebp,%esp
  3b:	5d                   	pop    %ebp
  3c:	c2 04 00             	ret    $0x4
  3f:	90                   	nop    
  40:	8b 45 08             	mov    0x8(%ebp),%eax
  43:	81 c6 00 ca 9a 3b    	add    $0x3b9aca00,%esi
  49:	4f                   	dec    %edi
  4a:	89 30                	mov    %esi,(%eax)
  4c:	89 78 04             	mov    %edi,0x4(%eax)
  4f:	8b 1c 24             	mov    (%esp),%ebx
  52:	8b 74 24 04          	mov    0x4(%esp),%esi
  56:	8b 7c 24 08          	mov    0x8(%esp),%edi
  5a:	89 ec                	mov    %ebp,%esp
  5c:	5d                   	pop    %ebp
  5d:	c2 04 00             	ret    $0x4
-------------------------------------------------------------------------

DOSUB64

ktime.o:     file format elf32-i386

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	8b 55 0c             	mov    0xc(%ebp),%edx
   6:	2b 55 14             	sub    0x14(%ebp),%edx
   9:	8b 4d 10             	mov    0x10(%ebp),%ecx
   c:	8b 45 08             	mov    0x8(%ebp),%eax
   f:	1b 4d 18             	sbb    0x18(%ebp),%ecx
  12:	85 d2                	test   %edx,%edx
  14:	78 0a                	js     20 <ktime_ops+0x20>
  16:	89 10                	mov    %edx,(%eax)
  18:	89 48 04             	mov    %ecx,0x4(%eax)
  1b:	5d                   	pop    %ebp
  1c:	c2 04 00             	ret    $0x4
  1f:	90                   	nop    
  20:	89 48 04             	mov    %ecx,0x4(%eax)
  23:	81 c2 00 ca 9a 3b    	add    $0x3b9aca00,%edx
  29:	89 10                	mov    %edx,(%eax)
  2b:	5d                   	pop    %ebp
  2c:	c2 04 00             	ret    $0x4
-------------------------------------------------------------------------

DOADD32

ktime.o:     file format elf32-littlearm

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	e24dd004 	sub	sp, sp, #4	; 0x4
   4:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
   8:	e3e0c331 	mvn	ip, #-1006632960	; 0xc4000000
   c:	e24cc865 	sub	ip, ip, #6619136	; 0x650000
  10:	e24ccc36 	sub	ip, ip, #13824	; 0x3600
  14:	e58d3010 	str	r3, [sp, #16]
  18:	e28de010 	add	lr, sp, #16	; 0x10
  1c:	e89e0018 	ldmia	lr, {r3, r4}
  20:	e0825003 	add	r5, r2, r3
  24:	e155000c 	cmp	r5, ip
  28:	c2855331 	addgt	r5, r5, #-1006632960	; 0xc4000000
  2c:	e0826004 	add	r6, r2, r4
  30:	c2855865 	addgt	r5, r5, #6619136	; 0x650000
  34:	c2855c36 	addgt	r5, r5, #13824	; 0x3600
  38:	c2866001 	addgt	r6, r6, #1	; 0x1
  3c:	e8800060 	stmia	r0, {r5, r6}
  40:	e8bd4070 	ldmia	sp!, {r4, r5, r6, lr}
  44:	e28dd004 	add	sp, sp, #4	; 0x4
  48:	e1a0f00e 	mov	pc, lr
-------------------------------------------------------------------------

DOADD64

ktime.o:     file format elf32-littlearm

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	e24dd004 	sub	sp, sp, #4	; 0x4
   4:	e92d4030 	stmdb	sp!, {r4, r5, lr}
   8:	e58d300c 	str	r3, [sp, #12]
   c:	e28de010 	add	lr, sp, #16	; 0x10
  10:	e3e03331 	mvn	r3, #-1006632960	; 0xc4000000
  14:	e2433865 	sub	r3, r3, #6619136	; 0x650000
  18:	e2433c36 	sub	r3, r3, #13824	; 0x3600
  1c:	e81e0030 	ldmda	lr, {r4, r5}
  20:	e0944001 	adds	r4, r4, r1
  24:	e0a55002 	adc	r5, r5, r2
  28:	e1540003 	cmp	r4, r3
  2c:	c2844331 	addgt	r4, r4, #-1006632960	; 0xc4000000
  30:	c2844865 	addgt	r4, r4, #6619136	; 0x650000
  34:	c2844c36 	addgt	r4, r4, #13824	; 0x3600
  38:	c2855001 	addgt	r5, r5, #1	; 0x1
  3c:	e8800030 	stmia	r0, {r4, r5}
  40:	e8bd4030 	ldmia	sp!, {r4, r5, lr}
  44:	e28dd004 	add	sp, sp, #4	; 0x4
  48:	e1a0f00e 	mov	pc, lr
-------------------------------------------------------------------------

DOSUB32

ktime.o:     file format elf32-littlearm

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	e24dd004 	sub	sp, sp, #4	; 0x4
   4:	e92d4070 	stmdb	sp!, {r4, r5, r6, lr}
   8:	e58d3010 	str	r3, [sp, #16]
   c:	e28de010 	add	lr, sp, #16	; 0x10
  10:	e89e0018 	ldmia	lr, {r3, r4}
  14:	e0635002 	rsb	r5, r3, r2
  18:	e3550000 	cmp	r5, #0	; 0x0
  1c:	b28555ee 	addlt	r5, r5, #998244352	; 0x3b800000
  20:	e0646002 	rsb	r6, r4, r2
  24:	b285596b 	addlt	r5, r5, #1753088	; 0x1ac000
  28:	b2855c0a 	addlt	r5, r5, #2560	; 0xa00
  2c:	b2466001 	sublt	r6, r6, #1	; 0x1
  30:	e8800060 	stmia	r0, {r5, r6}
  34:	e8bd4070 	ldmia	sp!, {r4, r5, r6, lr}
  38:	e28dd004 	add	sp, sp, #4	; 0x4
  3c:	e1a0f00e 	mov	pc, lr
-------------------------------------------------------------------------

DOSUB64

ktime.o:     file format elf32-littlearm

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	e24dd004 	sub	sp, sp, #4	; 0x4
   4:	e52d4004 	str	r4, [sp, #-4]!
   8:	e58d3004 	str	r3, [sp, #4]
   c:	e99d0018 	ldmib	sp, {r3, r4}
  10:	e0511003 	subs	r1, r1, r3
  14:	e0c22004 	sbc	r2, r2, r4
  18:	e3510000 	cmp	r1, #0	; 0x0
  1c:	b28115ee 	addlt	r1, r1, #998244352	; 0x3b800000
  20:	b281196b 	addlt	r1, r1, #1753088	; 0x1ac000
  24:	b2811c0a 	addlt	r1, r1, #2560	; 0xa00
  28:	e8800006 	stmia	r0, {r1, r2}
  2c:	e8bd0010 	ldmia	sp!, {r4}
  30:	e28dd004 	add	sp, sp, #4	; 0x4
  34:	e1a0f00e 	mov	pc, lr
-------------------------------------------------------------------------

DOADD32

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f03           	movel %d3,%sp@-
   6:	2f02           	movel %d2,%sp@-
   8:	206e 0008      	moveal %fp@(8),%a0
   c:	226e 000c      	moveal %fp@(12),%a1
  10:	202e 0010      	movel %fp@(16),%d0
  14:	222e 0014      	movel %fp@(20),%d1
  18:	2408           	movel %a0,%d2
  1a:	d480           	addl %d0,%d2
  1c:	2608           	movel %a0,%d3
  1e:	d681           	addl %d1,%d3
  20:	0c83 3b9a c9ff 	cmpil #999999999,%d3
  26:	6f08           	bles 30 <ktime_ops+0x30>
  28:	0683 c465 3600 	addil #-1000000000,%d3
  2e:	5282           	addql #1,%d2
  30:	2002           	movel %d2,%d0
  32:	2203           	movel %d3,%d1
  34:	241f           	movel %sp@+,%d2
  36:	261f           	movel %sp@+,%d3
  38:	4e5e           	unlk %fp
  3a:	4e75           	rts
-------------------------------------------------------------------------

DOADD64

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f02           	movel %d2,%sp@-
   6:	202e 0008      	movel %fp@(8),%d0
   a:	222e 000c      	movel %fp@(12),%d1
   e:	242e 0010      	movel %fp@(16),%d2
  12:	d2ae 0014      	addl %fp@(20),%d1
  16:	d182           	addxl %d2,%d0
  18:	0c81 3b9a c9ff 	cmpil #999999999,%d1
  1e:	6f08           	bles 28 <ktime_ops+0x28>
  20:	0681 c465 3600 	addil #-1000000000,%d1
  26:	5280           	addql #1,%d0
  28:	241f           	movel %sp@+,%d2
  2a:	4e5e           	unlk %fp
  2c:	4e75           	rts
-------------------------------------------------------------------------

DOSUB32

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f03           	movel %d3,%sp@-
   6:	2f02           	movel %d2,%sp@-
   8:	202e 0008      	movel %fp@(8),%d0
   c:	222e 000c      	movel %fp@(12),%d1
  10:	206e 0010      	moveal %fp@(16),%a0
  14:	226e 0014      	moveal %fp@(20),%a1
  18:	2400           	movel %d0,%d2
  1a:	9488           	subl %a0,%d2
  1c:	9089           	subl %a1,%d0
  1e:	2600           	movel %d0,%d3
  20:	6c08           	bges 2a <ktime_ops+0x2a>
  22:	0683 3b9a ca00 	addil #1000000000,%d3
  28:	5382           	subql #1,%d2
  2a:	2002           	movel %d2,%d0
  2c:	2203           	movel %d3,%d1
  2e:	241f           	movel %sp@+,%d2
  30:	261f           	movel %sp@+,%d3
  32:	4e5e           	unlk %fp
  34:	4e75           	rts
-------------------------------------------------------------------------

DOSUB64

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f02           	movel %d2,%sp@-
   6:	202e 0008      	movel %fp@(8),%d0
   a:	222e 000c      	movel %fp@(12),%d1
   e:	242e 0010      	movel %fp@(16),%d2
  12:	92ae 0014      	subl %fp@(20),%d1
  16:	9182           	subxl %d2,%d0
  18:	4a81           	tstl %d1
  1a:	6c06           	bges 22 <ktime_ops+0x22>
  1c:	0681 3b9a ca00 	addil #1000000000,%d1
  22:	241f           	movel %sp@+,%d2
  24:	4e5e           	unlk %fp
  26:	4e75           	rts
-------------------------------------------------------------------------

DOADD32

ktime.o:     file format elf32-powerpc

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	81 64 00 00 	lwz     r11,0(r4)
   4:	3c 00 3b 9a 	lis     r0,15258
   8:	81 45 00 04 	lwz     r10,4(r5)
   c:	60 00 c9 ff 	ori     r0,r0,51711
  10:	81 25 00 00 	lwz     r9,0(r5)
  14:	7d 0b 52 14 	add     r8,r11,r10
  18:	7f 88 00 00 	cmpw    cr7,r8,r0
  1c:	7c eb 4a 14 	add     r7,r11,r9
  20:	3d 68 c4 65 	addis   r11,r8,-15259
  24:	7c 69 1b 78 	mr      r9,r3
  28:	40 9d 00 0c 	ble-    cr7,34 <ktime_ops+0x34>
  2c:	39 0b 36 00 	addi    r8,r11,13824
  30:	38 e7 00 01 	addi    r7,r7,1
  34:	90 e9 00 00 	stw     r7,0(r9)
  38:	91 09 00 04 	stw     r8,4(r9)
  3c:	4e 80 00 20 	blr
-------------------------------------------------------------------------

DOADD64

ktime.o:     file format elf32-powerpc

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	81 25 00 00 	lwz     r9,0(r5)
   4:	3c 00 3b 9a 	lis     r0,15258
   8:	81 45 00 04 	lwz     r10,4(r5)
   c:	60 00 c9 ff 	ori     r0,r0,51711
  10:	81 64 00 00 	lwz     r11,0(r4)
  14:	81 84 00 04 	lwz     r12,4(r4)
  18:	7d 8c 50 14 	addc    r12,r12,r10
  1c:	7d 6b 49 14 	adde    r11,r11,r9
  20:	7c 69 1b 78 	mr      r9,r3
  24:	7f 8c 00 00 	cmpw    cr7,r12,r0
  28:	3d 4c c4 65 	addis   r10,r12,-15259
  2c:	40 9d 00 0c 	ble-    cr7,38 <ktime_ops+0x38>
  30:	39 8a 36 00 	addi    r12,r10,13824
  34:	39 6b 00 01 	addi    r11,r11,1
  38:	91 69 00 00 	stw     r11,0(r9)
  3c:	91 89 00 04 	stw     r12,4(r9)
  40:	4e 80 00 20 	blr
-------------------------------------------------------------------------

DOSUB32

ktime.o:     file format elf32-powerpc

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	81 24 00 00 	lwz     r9,0(r4)
   4:	81 85 00 04 	lwz     r12,4(r5)
   8:	81 65 00 00 	lwz     r11,0(r5)
   c:	7d 0c 48 50 	subf    r8,r12,r9
  10:	2f 88 00 00 	cmpwi   cr7,r8,0
  14:	7c eb 48 50 	subf    r7,r11,r9
  18:	3d 68 3b 9b 	addis   r11,r8,15259
  1c:	7c 69 1b 78 	mr      r9,r3
  20:	41 9c 00 10 	blt-    cr7,30 <ktime_ops+0x30>
  24:	90 e9 00 00 	stw     r7,0(r9)
  28:	91 09 00 04 	stw     r8,4(r9)
  2c:	4e 80 00 20 	blr
  30:	39 0b ca 00 	addi    r8,r11,-13824
  34:	38 e7 ff ff 	addi    r7,r7,-1
  38:	90 e9 00 00 	stw     r7,0(r9)
  3c:	91 09 00 04 	stw     r8,4(r9)
  40:	4e 80 00 20 	blr
-------------------------------------------------------------------------

DOSUB64

ktime.o:     file format elf32-powerpc

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	81 65 00 00 	lwz     r11,0(r5)
   4:	7c 68 1b 78 	mr      r8,r3
   8:	81 24 00 00 	lwz     r9,0(r4)
   c:	81 44 00 04 	lwz     r10,4(r4)
  10:	81 85 00 04 	lwz     r12,4(r5)
  14:	7d 4c 50 10 	subfc   r10,r12,r10
  18:	7d 2b 49 10 	subfe   r9,r11,r9
  1c:	2f 8a 00 00 	cmpwi   cr7,r10,0
  20:	3d 6a 3b 9b 	addis   r11,r10,15259
  24:	41 9c 00 10 	blt-    cr7,34 <ktime_ops+0x34>
  28:	91 28 00 00 	stw     r9,0(r8)
  2c:	91 48 00 04 	stw     r10,4(r8)
  30:	4e 80 00 20 	blr
  34:	39 4b ca 00 	addi    r10,r11,-13824
  38:	91 28 00 00 	stw     r9,0(r8)
  3c:	91 48 00 04 	stw     r10,4(r8)
  40:	4e 80 00 20 	blr
-------------------------------------------------------------------------

DOADD32

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f03           	movel %d3,%sp@-
   6:	2f02           	movel %d2,%sp@-
   8:	206e 0008      	moveal %fp@(8),%a0
   c:	226e 000c      	moveal %fp@(12),%a1
  10:	202e 0010      	movel %fp@(16),%d0
  14:	222e 0014      	movel %fp@(20),%d1
  18:	2408           	movel %a0,%d2
  1a:	d480           	addl %d0,%d2
  1c:	2608           	movel %a0,%d3
  1e:	d681           	addl %d1,%d3
  20:	0c83 3b9a c9ff 	cmpil #999999999,%d3
  26:	6f08           	bles 30 <ktime_ops+0x30>
  28:	0683 c465 3600 	addil #-1000000000,%d3
  2e:	5282           	addql #1,%d2
  30:	2002           	movel %d2,%d0
  32:	2203           	movel %d3,%d1
  34:	241f           	movel %sp@+,%d2
  36:	261f           	movel %sp@+,%d3
  38:	4e5e           	unlk %fp
  3a:	4e75           	rts
-------------------------------------------------------------------------

DOADD64

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f02           	movel %d2,%sp@-
   6:	202e 0008      	movel %fp@(8),%d0
   a:	222e 000c      	movel %fp@(12),%d1
   e:	242e 0010      	movel %fp@(16),%d2
  12:	d2ae 0014      	addl %fp@(20),%d1
  16:	d182           	addxl %d2,%d0
  18:	0c81 3b9a c9ff 	cmpil #999999999,%d1
  1e:	6f08           	bles 28 <ktime_ops+0x28>
  20:	0681 c465 3600 	addil #-1000000000,%d1
  26:	5280           	addql #1,%d0
  28:	241f           	movel %sp@+,%d2
  2a:	4e5e           	unlk %fp
  2c:	4e75           	rts
-------------------------------------------------------------------------

DOSUB32

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f03           	movel %d3,%sp@-
   6:	2f02           	movel %d2,%sp@-
   8:	202e 0008      	movel %fp@(8),%d0
   c:	222e 000c      	movel %fp@(12),%d1
  10:	206e 0010      	moveal %fp@(16),%a0
  14:	226e 0014      	moveal %fp@(20),%a1
  18:	2400           	movel %d0,%d2
  1a:	9488           	subl %a0,%d2
  1c:	9089           	subl %a1,%d0
  1e:	2600           	movel %d0,%d3
  20:	6c08           	bges 2a <ktime_ops+0x2a>
  22:	0683 3b9a ca00 	addil #1000000000,%d3
  28:	5382           	subql #1,%d2
  2a:	2002           	movel %d2,%d0
  2c:	2203           	movel %d3,%d1
  2e:	241f           	movel %sp@+,%d2
  30:	261f           	movel %sp@+,%d3
  32:	4e5e           	unlk %fp
  34:	4e75           	rts
-------------------------------------------------------------------------

DOSUB64

ktime.o:     file format elf32-m68k

Disassembly of section .text:

00000000 <ktime_ops>:
   0:	4e56 0000      	linkw %fp,#0
   4:	2f02           	movel %d2,%sp@-
   6:	202e 0008      	movel %fp@(8),%d0
   a:	222e 000c      	movel %fp@(12),%d1
   e:	242e 0010      	movel %fp@(16),%d2
  12:	92ae 0014      	subl %fp@(20),%d1
  16:	9182           	subxl %d2,%d0
  18:	4a81           	tstl %d1
  1a:	6c06           	bges 22 <ktime_ops+0x22>
  1c:	0681 3b9a ca00 	addil #1000000000,%d1
  22:	241f           	movel %sp@+,%d2
  24:	4e5e           	unlk %fp
  26:	4e75           	rts
-------------------------------------------------------------------------

--=-lYK2I8+Z4raSvEKhyr60--

