Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289109AbSAJBJ7>; Wed, 9 Jan 2002 20:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289107AbSAJBJt>; Wed, 9 Jan 2002 20:09:49 -0500
Received: from are.twiddle.net ([64.81.246.98]:32900 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S289111AbSAJBJh>;
	Wed, 9 Jan 2002 20:09:37 -0500
Date: Wed, 9 Jan 2002 17:09:28 -0800
From: Richard Henderson <rth@twiddle.net>
To: Anton Blanchard <anton@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020109170928.A4365@twiddle.net>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020108114355.GA25718@krispykreme> <Pine.LNX.4.33.0201081533270.7255-100000@localhost.localdomain> <20020109231513.GA10002@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020109231513.GA10002@krispykreme>; from anton@samba.org on Thu, Jan 10, 2002 at 10:15:14AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2002 at 10:15:14AM +1100, Anton Blanchard wrote:
> I expect most architectures have a reasonably fast find_first_zero_bit
> so they can simply do:
> 
> static inline int sched_find_first_zero_bit(unsigned long *bitmap)
> {
> 	return find_first_zero_bit(bitmap, MAX_PRIO);
> }

Careful.  The following is really quite a bit better on Alpha:

static inline int
sched_find_first_zero_bit(unsigned long *bitmap)
{
        unsigned long b0 = bitmap[0];
        unsigned long b1 = bitmap[1];
        unsigned long b2 = bitmap[2];
        unsigned long ofs = MAX_RT_PRIO;

        if (unlikely(~(b0 & b1) != 0)) {
                b2 = (~b0 == 0 ? b0 : b1);
                ofs = (~b0 == 0 ? 0 : 64);
        }

        return ffz(b2) + ofs;
}

It compiles down to 

        ldq $2,0($16)
        ldq $3,8($16)
        lda $5,128($31)
        ldq $0,16($16)
        and $2,$3,$1
        ornot $31,$2,$4
        ornot $31,$1,$1
        bne $1,$L8
$L2:
        ornot $31,$0,$0
        cttz $0,$0
        addl $0,$5,$0
        ret $31,($26),1
$L8:
        mov $2,$0
        cmpult $31,$4,$5
        cmovne $4,$3,$0
        sll $5,6,$5
        br $31,$L2

which is a fair bit better than find_first_zero_bit if for
no other reason than we collect all the memory accesses
right up at the beginning.

While we're on the subject of sched_find_first_zero_bit, I'd 
like to complain about Ingo's choice of header file.  Why in
the world did you choose mmu_context.h?  Invent a new asm/sched.h
if you must, but please don't choose headers at random.


r~
