Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWAIXkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWAIXkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 18:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWAIXkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 18:40:05 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:4900 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751644AbWAIXkD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 18:40:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Nl7JKOZpP3svvGcQ1OTaMSQs+4PF7j6xdreMRqTfgRHd+TnkNLnUBPI8YffiSrTk7r378nvJxWQiEK+ug9QfamkyF2Y2kXsHziHlqXMdo+XScfH2fFhbDu8YdR783BpLWBiGQ5xCtMb3Yxsao7S+pou8MTinU+4lxEAAQ+19pdg=
Date: Tue, 10 Jan 2006 02:39:41 +0300
From: Stanislav Maslovski <stanislav.maslovski@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] Re: i8254 and TSC related code
Message-ID: <20060109233941.GA6899@shota.mine.nu>
Mail-Followup-To: Stanislav Maslovski <stanislav.maslovski@gmail.com>,
	john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20060104211827.GA8723@shota.mine.nu> <1136585651.10357.61.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1136585651.10357.61.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

> I'm glad to see your interest in timekeeping! Its a area that could use
> more review.

Thank you for the reply! My comments follow below.

>> It seems that linux assumes a different behaviour in mode 2.
>> For example, delay_at_last_interrupt is calculated as
>>
>>         count = ((LATCH-1) - count) * TICK_SIZE;
>>         delay_at_last_interrupt = (count + LATCH/2) / LATCH;
>>
>> The first line suggests that "count" is assumed to change in
>> the [ LATCH-1; 0 ] range, does not it? In 2.4.32 there is even
>> a piece of code in timer.c:timer_interrupt() that checks for
>> the condition "count == LATCH" and does "count--" if
>> this condition is true. The comment to this piece of code says:
>>
>>         /* Some i8253 clones hold the LATCH value visible
>>            momentarily as they flip back to zero */
>>
>> which explicitly contradicts the Intel docs.
>
> Hmmm. That logic is as old as the hills, but from your description it
> does seem that if the PIT goes from [LATCH, 1] the logic should be
> (LATCH - count)*...
>
> Thoughts from anyone else?

While waiting for an answer from someone else, I programmed a simple bootable
tester for the PIT (attached). It can do 3 tests: range test, latency test and
sequence test. The range test polls PIT for some time to determine the range
of count values. The latency test prints PIT readouts obtained immediately on
entering the interrupt handler. The sequence test polls PIT as fast as it can
around the point of underflow when the LATCH value gets reloaded
(you should run it several times to see what happens).

You will need nasm to compile the code (see the file for instructions) and
a diskette to boot it from.

On my two machines, for LATCH=1000h the results are (hex):
range: 0001 1000
latency: 0FFE, 0FFD ... about these values
LATCH and 1 can be seen in the sequence, but never 0 or anything > LATCH.


[ skipped some discussion of pit_latch_buggy ]

> It does seem odd. While the notion that it takes the middle of the last
> three latched PIT values, to insure you have a sane value. The value
> selected may not have much to do with the current interrupt handler
> latency (which is why we touch the PIT at all here).
>
> Someone familiar w/ the Cyrix 5510/5520 should comment here since that
> is what it has been added for.

It would be nice if somebody could run my test on this platform.


[ skipped ]

>> For the values read from TSC and PIT to be
>> corresponding the reads must happen almost
>> at the same time (even the comment in the code says so ;-))
>>
>> I would place read_tsc() immediately after the latching
>> operation "outb_p(0x00, PIT_MODE);"
>> It is better to have it immediately after it and not
>> immediately before it also because the actual write to
>> a register of an i/o device happens at the end of the
>> bus cycle, but not at the beginning.
>
>
> I'd not be opposed to this, or at least pulling the rdtsc inside the
> spinlock should be fine.

After investigating it for some more time I found that it is rather better
to have rdtsc operation immediately before PIT latching, inside the spin lock.
My original reasoning did not take into account a delaying "out" which is
added on i386 after the the latching "out" (in outb_p()).


>> I think that such a
>> change will also make redundant the "corner case correction"
>> done at the end of mark_offset_tsc():
>>
>>        if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
>>                jiffies_64++;
>
> I need to think it through a bit more, but it seems there is the
> potential for the inverse of this corner case, where the PIT is latched
> just before it triggers another interrupt, and the TSC is read after the
> interrupt signal with a value greater then one interrupt. So while this
> check might be made unnecessary, additional logic could be needed.
>

I see. Below I will give some more thoughts on the corner case.


>> By the way (and this is my last question for now) the test for this correction
>> is buggy because in the current implementation "lost" does not account
>> for the lost ticks but for the really_lost + 1. This is seen from the
>> code some lines above:
>>
>>        lost = delta/(1000000/HZ);
>>        delay = delta%(1000000/HZ);
>>        if (lost >= 2) {
>>                jiffies_64 += lost-1;
>>
>> At the beginning of this code delta is normally slightly above 1000000/HZ
>> so that lost == 1 even if there was not a really lost tick. This was taken
>> into account in the increment for jiffies but was not in the "corner case"
>> correction...
>
> Actually, that should be ok since we're trying to avoid doing any math
> if the interrupt is early, although I admit it is confusing.
>
> So imagine the following:
>
> 0      1      2      3      4      5      6      7
> |-+----|--+---|+-----|-----+|------|------|+----+|
>  A       B    C           D               E    F
>
> Where the numbered "|"s are the interrupt signals and lettered "+"s are
> the interrupt handlers.
>
> So, at at interrupt handler B:
>
>>From the last interrupt handler A, we've stored the time between 0 and A
> as delay_at_last_interrupt.
>
> We enter mark_offset_tsc() and calculate the time from B to A using the
> TSC, saving it in delta. We also store count from the PIT which we will
> use later.
>
> We add delay_at_last_interrupt to delta to give us the full interval
> from 0 to B. We divide this interval by the interrupt frequency and save
> that as lost (which should store the value 1).
>
> We use an estimate of where 1 should be to calculate the distance from 1
> to B and store this in delay.
>
> Since lost is less then 2, no lost tick compensation occurs.
>
> We use the value count, stored earlier from the PIT, to calculate the
> interval from 1 to B and store it delay_at_last_interrupt.

Up to this point my understanding of the code fully agrees with yours ;)


> Then assuming a full tick has occurred (ie: lost is 1), we double check
> our math for the interval 1 to B so the PIT based delay_at_last
> interrupt is close enough to the mixed PIT/TSC value delay calculated
> earlier.
>
> That's the easy case (no early or late ticks) but you can go head and
> work out the others in your head.
>
> It is quite ugly, so I might be missing your point. Please clarify if
> so.

Mmm. Is a hardware interrupt really lost when your lost == 1 and we are
in the corner case? Do we need to increment jiffies here?

It seems that the low-level linux interrupt handler ACKs the interrups early
enough. If I am not mistaken the following (i removed some levels of
indirection) sequence of calls happens when satisfying IRQ 0:
(-> mean calls, {} mean call contexts, kernel 2.6.15)

gate in arch/i386/kernel/entry.S
  `->__do_IRQ() in kernel/irq/handle.c
       {
           acknowlegde_hw_irq;
           ->timer_interrupt() in arch/i386/kernel/time.c
              {
                 ->mark_offset_tsc()
              1:
                 /* after this point code essentialy does */
                 ++jiffies;
                 update_times;
              }
       }

This means that if we see the corner case inside mark_offset_tsc() then
most likely the hw IRQ that has started us has been ACKed in time. In this case
the interrupt controller will be ready to take the IRQ generated at the
"corner". Immediately after leaving the interrupt handler a new interrupt will
fire at us so that jiffies will be incremented twice.

Please correct me if I am wrong.

By the way, in arch/i386/kernel/timer.c there is another ACK done when
CONFIG_X86_IO_APIC is defined. On my diagram it happens at point 1.
What is the purpose of it?

> The patches are currently in the -rt tree as well as 2.6.15-mm1. So if
> your careful eyes want to read over something else, it would be greatly
> appreciated.

I am willing to do it.

> Additionally, your point that the upcoming rework should not keep bugs
> in the current code from being fix is absolutely right!  So please feel
> free to submit patches to lkml and Andrew fixing any current issues and
> I'll be sure to look them over.

Yup. When I feel I understand the matter enough well ;)

Below goes the test program.

Yours,
Stanislav

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pit.asm"

;   pit.asm: A simple bootable PIT tester.
;   Copyright (c) 2006 Stanislav Maslovski <stanislav.maslovski@gmail.com>
;
;   Compile with nasm, and then put the binary into the boot sector of a diskette:
;   # nasm pit.asm
;   # cat pit >/dev/fd0
;   # reboot
;   When booted use PF keys F1-F3 for tests.
;
;   This program is free software; you can redistribute it and/or modify
;   it under the terms of the GNU General Public License as published by
;   the Free Software Foundation; either version 2 of the License, or
;   (at your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this program; if not, write to the Free Software
;   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;
	cpu	8086
%define delay	jmp short $+2
; *****************************
	section .text
	org	7C00h
v_off	equ	4*08h
v_seg	equ	v_off+2
TRIES	equ	16
LATCH	equ	1000h
tbl	equ	8000h
; here CS:IP = 0000:7C00; 64K of low memory is more than enough for us
start:
; set segregs and stack
	mov	ax, cs
	mov	ds, ax
	mov	es, ax
	cli
	mov	ss, ax
	mov	sp, 7C00h; expands below the code
	sti
; print init message
	call	dnl
	mov	si, init_msg
	call	puts
; reprogram irq 0 vector
	cli
	mov	ax, [v_off]
	mov	[old_vec+0], ax
	mov	ax, [v_seg]
	mov	[old_vec+2], ax
	mov	word [v_off], irq_h
	mov	[v_seg], cs	
; set channel 0 mode 2 r/w 2 bytes, LATCH
	mov	al, 34h
	mov	dx, LATCH
	call	pit_reset
	sti
; catch several interrupts
	mov	cx, 5
	mov	[cnt1], cx
.l1:
	cmp	[cnt1], cx
	jae	.l1
	loop	.l1
	jmp	short main
; main loop
main_dnl:
	call	dnl
main:
; print banner
	mov	si, banner_msg
	call	puts
; wait for a function key pressed
.l2:
	xor	ah, ah
	int	16h
	or	al, al
	jnz	.l2
	mov	cx, TRIES
	mov	di, tbl
; select the test
	sub	ah, 3Bh
	jz	range
	dec	ah
	jz	latency
	dec	ah
	jz	sequence
	jmp	short .l2
dump:
; dumps the table of values
	mov	cx, TRIES
	mov	si, tbl
.l3:
	lodsw
	mov	dx, ax
	call	printw
	loop	.l3
%if (TRIES % 16)
	jmp	short main_dnl
%else
	jmp	short main
%endif

; *****************************
; latency test
; *****************************
latency:
	mov	[cnt1], cx
.l1:
	cmp	[cnt1], cx
	jae	.l1
	mov	ax, [ch0]
	stosw
	loop	.l1
	jmp	short dump
; *****************************	
; sequence test
; *****************************
sequence:
	cli
; catch this value or less
	mov	dx, [seq_st]
.l2
	call	pit_latch
	cmp	ax, dx
	ja	.l2
; read sequence into the table
.l4:
	stosw
.l3:
	call	pit_latch	
	cmp	ax, dx
	je	.l3
	mov	dx, ax
	loop	.l4
; correct the start value (useful at the next test)
	mov	ax, [tbl]
	sub	ax, dx
	add	ax, LATCH
	shr	ax, 1
	mov	[seq_st], ax
	sti
	jmp	short dump
; *****************************
; range test
; *****************************
range:
	cli
	xor	cx, cx
	mov	bx, cx
	mov	dx, cx
	dec	dx
.l3:
	call	pit_latch
	cmp	ax, dx
	jae	.l1
	mov	dx, ax
.l1:
	cmp	ax, bx
	jbe	.l2
	mov	bx, ax
.l2:
	loop	.l3
	sti
	call	printw
	mov	dx, bx
	call	printw
	jmp	main_dnl
; *****************************
irq_h:
	push	ax
; read the PIT count
	call	pit_latch
	mov	[cs:ch0], ax
; update counters
	dec	word [cs:cnt1]
	dec	word [cs:cnt2]
	jnz	.l1
	mov	word [cs:cnt2], 10000h/LATCH
; jump to bios isr
	pop	ax
	jmp	far [cs:old_vec]
.l1:
; ack the interrupt and leave
	mov	al, 20h
	out	20h, al
	pop	ax
	iret
; *****************************
putch:
	push	cx
	mov	cx, 1
	mov	ah, 0Eh
	int	10h
	pop	cx
	ret
; *****************************
dnl:
	mov	al, 0Dh
	call	putch
	mov	al, 0Ah
	call	putch
	ret
; *****************************
puts:
	lodsb
	or	al, al
	jz	.l1
	call	putch
	jmp	short puts
.l1:
	call	dnl
	ret
; *****************************
printw:
	push	cx
	mov	cx, 4
	call	print_hex
	mov	al, ' '
	call	putch
	pop	cx
	ret
; *****************************
print_hex:
.l1:
	rol	dx, 1
	rol	dx, 1
	rol	dx, 1
	rol	dx, 1
	mov	al, dl
	and	al, 0Fh
	add	al, '0'
	cmp	al, '9'
	jbe	.l2
	add	al, 'A'-'9'-1
.l2:
	call	putch
	loop	.l1
	ret
; *****************************
pit_latch:
	xor	al, al
	out	43h, al
	delay
pit_inw:
	in	al, 40h
	delay
	xchg	al, ah
	in	al, 40h
	delay
	xchg	al, ah
	ret
; *****************************
pit_reset:
	out	43h, al
	delay
pit_outw:
	mov	al, dl
	out	40h, al
	delay
	mov	al, dh
	out	40h, al
	delay
	ret
; *****************************
cnt1:
	dw	0
cnt2:
	dw	10000h/LATCH
ch0:
	dw	0
; *****************************
init_msg:
	db	'PIT init: Ch 0 Mod 2 rw 2b LATCH=1000h', 0
banner_msg:
	db	'Test: F1=Range F2=Latency F3=Sequence', 0
old_vec:
	dw	0, 0
seq_st:
	dw	TRIES
; *****************************
; signature
	times 510-($-$$) db 0FFh
	db	55h, 0AAh
; *****************************

--CE+1k2dSO48ffgeK--
