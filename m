Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279842AbRKFRxO>; Tue, 6 Nov 2001 12:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279860AbRKFRxE>; Tue, 6 Nov 2001 12:53:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3339 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279842AbRKFRwv>; Tue, 6 Nov 2001 12:52:51 -0500
Date: Tue, 6 Nov 2001 09:49:15 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Using %cr2 to reference "current"
In-Reply-To: <20011106121313.B16245@redhat.com>
Message-ID: <Pine.LNX.4.33.0111060918380.2194-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 6 Nov 2001, Benjamin LaHaise wrote:
>
> On Tue, Nov 06, 2001 at 05:02:32PM +0000, Linus Torvalds wrote:
> > Which means that the whole approach is just depending on undocumented
> > implementation behaviour. That's asking for trouble.
>
> NetWare uses it and has for a long time.

Does anybody know if WNT uses it? Quite frankly, I don't see Intel
worrying over-much about NetWare compatibility. They've broken small OS's
before (ie older versions of SCO Xenix wouldn't boot on a Pentium MMU
because of some changes to error reporting, if I remember correctly).

That said, how expensive is loading %cr2 anyway? We can do all the same
tricks with a 16kB stack and just playing games with using the higher bits
as the "offset", ie things like

	/* Return "current" in %eax, trash %edx */
	do_get_current:
		movl $0x0003c000,%eax	// 4 bits at bit 14
		movl $-16384,%edx	// remove low 14 bits
		andl $esp,%eax
		andl $esp,%edx
		shrl $7,%eax		// color it by 128 bytes
		addl %edx,%eax
		ret

which is going to be ~5 cycles _without_ doing anything that is
undocumented (add a push/pop to not trash a register, that might be
worthwhile - it makes the function marginally slower but might make
callers happier).

Oh, and call using inline assembly, not a C call (so that gcc can take
advantage of better calling convention, and not think memory is trashed
etc). So

	static inline struct task_struct *get_current(void)
	{
		struct task_struct *tsk;
		asm("call do_get_current":"=a" (tsk)::"dx");
		return tsk;
	}

See? You don't have to play games with control registers.

(actually, entry.S seems to want the return value in %ebx, so change to
taste. Or you could have two different versions of the thing, or even
inline it for any place where that makes sense).

The above also allows you to keep fork with just one allocation, and makes
the stack larger (we steal 2kB for the coloring, but we'd use an order-2
allocation that at least SGI wants to do regardless).

The 2kB is, of course, tunable. The above is with a 128-byte cacheline and
16 colors - that may be overkill. 32-byte increents with 32 colors might
be more appropriate (I don't know what the effect of the P4 half-cacheline
thing is, I don't know if the CPU can have just a 64-byte block coherent,
or what.. But a 32-byte color is fine for _most_ CPU's).

The 32-byte by 32-color thing would just change the bitmasks to 0x0007c000
and the shift to 9 (bit 14+ shifted down to bit 5+).

Note that there are lots of advantages to using simple regular
instructions over using "special" instructions like "move from control
register". Historically, the special instructions tend to always become
slower, while the regular instructions become faster.

I would not be surprised if "mov %cr2,%reg" will break a netburst trace
cache entity, or even cause microcode to be executed. While I _guarantee_
that all future Intel CPU's will continue to be fast at mixtures of simple
arithmetic operations like "add" and "and".

(And I bet that the likelyhood of Intel speeding up shifts in the next P4
derivative is a _lot_ higher than Intel speeding up "mov %cr2,xx"..)

		Linus

