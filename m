Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129504AbQKHSLc>; Wed, 8 Nov 2000 13:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129547AbQKHSLW>; Wed, 8 Nov 2000 13:11:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:2572 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129386AbQKHSLG>; Wed, 8 Nov 2000 13:11:06 -0500
Date: Wed, 8 Nov 2000 10:10:45 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium 4 and 2.4/2.5
In-Reply-To: <E13tZMe-0000F8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10011080953130.16579-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2000, Alan Cox wrote:
> > unless that CPU is also SMP-capable).  It's documented by intel these
> > days, and it works on all CPU's I've ever heard of, and it even makes
> > sense to me (*).
> 
> Do the intel docs guarantee it works on i486 and higher, if so SMP athlon
> will be the only check needed for the SMP users. You work for an x86 chip
> cloning company so if you say it works I trust you 8)

Well, we don't make low-power SMP laptops, so as such Transmeta doesn't
much care. It will work, though. And yes, as far as I know Intel made it
an "architecture feature", meaning that they claim it work son all their
ia32 chips.

Now, I could imagine that Intel would select an instruction that didn't
work on Athlon on purpose, but I really don't think they did.  I don't
have an athlon to test.

It's easy enough to generate a test-program. If the following works,
you're pretty much guaranteed that it's ok

	int main()
	{
		printf("Testing 'rep nop' ... ");
		asm volatile("rep ; nop");
		printf("okey-dokey\n"); 
		return 0;
	}

(there's not much a "rep nop" _can_ do, after all - the most likely CPU
extension would be to raise an "Illegal Opcode" fault).

> > Also, at least part of the reason Intel removed the TSC check was that
> > Linux actually seems to get the extended CPU capability flags wrong,
> > overwriting the _real_ capability flags which in turn caused the TSC
> > check on Linux to simply not work.  Peter Anvin is working on fixing
> > this. I suspect that Linux-2.2 has the same problem.
> 
> I've not seen incorrect TSC detection in 2.2, do you know the precise
> circumstances this occurs and I'll check over them. I've also got no
> bug reports of this failing.

It won't fail on other CPU's. The bug is, as far as I can tell, in
get_model_name(),

	cpuid(0x80000001, &dummy, &dummy, &dummy, &(c->x86_capability));

Notice how we overwrite the x86_capability state with whatever we read
from the extended register 0x80000001. So we overwrite the _real_
capabilities that we got the right way in head.S.

This is wrong. It just happens to work on other, non-Pentium IV,
processors. The extended capabilities are an _extention_, not replacement,
for the regular capabilities.

> check_config would also panic with the 'Kernel compiled for ..' message 
> if it occurred.

Which is what it apparently does, if you compile for TSC. Even though very
obviously a Pentium IV _does_ have a TSC.

NOTE! I don't actually have access to a Pentium IV myself yet, although
I'm promised one soon enough. So I've only got second-hand reports on the
cpuid thing so far.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
