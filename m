Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289546AbSAJRF1>; Thu, 10 Jan 2002 12:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289547AbSAJRFR>; Thu, 10 Jan 2002 12:05:17 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:54020 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S289546AbSAJRFG>; Thu, 10 Jan 2002 12:05:06 -0500
Date: Thu, 10 Jan 2002 20:04:46 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020110200446.A695@jurassic.park.msu.ru>
In-Reply-To: <20020108114355.GA25718@krispykreme> <Pine.LNX.4.33.0201081533270.7255-100000@localhost.localdomain> <20020109231513.GA10002@krispykreme> <20020109170928.A4365@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020109170928.A4365@twiddle.net>; from rth@twiddle.net on Wed, Jan 09, 2002 at 05:09:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 05:09:28PM -0800, Richard Henderson wrote:
> Careful.  The following is really quite a bit better on Alpha:
> 
> static inline int
> sched_find_first_zero_bit(unsigned long *bitmap)
> {
>         unsigned long b0 = bitmap[0];
>         unsigned long b1 = bitmap[1];
>         unsigned long b2 = bitmap[2];
>         unsigned long ofs = MAX_RT_PRIO;
> 
>         if (unlikely(~(b0 & b1) != 0)) {
>                 b2 = (~b0 == 0 ? b0 : b1);
>                 ofs = (~b0 == 0 ? 0 : 64);
>         }
> 
>         return ffz(b2) + ofs;
> }

True. Minor correction:
-               b2 = (~b0 == 0 ? b0 : b1);
-               ofs = (~b0 == 0 ? 0 : 64);
+		b2 = (~b0 ? b0 : b1);
+		ofs = (~b0 ? 0 : 64);

Note that comment for this function is a bit confusing:
 * ... It's the fastest
 * way of searching a 168-bit bitmap where the first 128 bits are
 * unlikely to be set.

s/set/cleared/

> While we're on the subject of sched_find_first_zero_bit, I'd 
> like to complain about Ingo's choice of header file.  Why in
> the world did you choose mmu_context.h?  Invent a new asm/sched.h
> if you must, but please don't choose headers at random.

Agreed. Apparently asm/bitops.h?

Ivan.
