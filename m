Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267183AbSLRG3I>; Wed, 18 Dec 2002 01:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSLRG3H>; Wed, 18 Dec 2002 01:29:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57863 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267183AbSLRG3F>; Wed, 18 Dec 2002 01:29:05 -0500
Date: Tue, 17 Dec 2002 22:38:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212172043540.1749-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212172225410.1368-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Linus Torvalds wrote:
>
> Which is ok for a regular fast system call (ebp will get restored
> immediately), but it is NOT ok for the system call restart case, since in
> that case we want %ebp to contain the old stack pointer, not the sixth
> argument.

I came up with an absolutely wonderfully _disgusting_ solution for this.

The thing to realize on how to solve this is that since "sysenter" loses
track of EIP, there's really no real reason to try to return directly
after the "sysenter" instruction anyway. The return point is really
totally arbitrary, after all.

Now, couple this with the fact that system call restarting will always
just subtract two from the "return point" aka saved EIP value (that's the
size of an "int 0x80" instruction), and what you can do is to make the
kernel point the sysexit return point not at just past the "sysenter", but
instead make it point to just past a totally unrelated 2-byte jump
instruction.

With that in mind, I made the sysentry trampoline look like this:

        static const char sysent[] = {
                0x51,                   /* push %ecx */
                0x52,                   /* push %edx */
                0x55,                   /* push %ebp */
                0x89, 0xe5,             /* movl %esp,%ebp */
                0x0f, 0x34,             /* sysenter */
        /* System call restart point is here! (SYSENTER_RETURN - 2) */
                0xeb, 0xfa,             /* jmp to "movl %esp,%ebp" */
        /* System call normal return point is here! (SYSENTER_RETURN in entry.S) */
                0x5d,                   /* pop %ebp */
                0x5a,                   /* pop %edx */
                0x59,                   /* pop %ecx */
                0xc3                    /* ret */
        };

which does the right thing for a "restarted" system call (ie when it
restarts, it won't re-do just the sysenter instruction, it will really
restart at the backwards jump, and thus re-start the "movl %esp,%ebp"
too).

Which means that now the kernel can happily trash %ebp as part of the
sixth argument setup, since system call restarting will re-initialize it
to point to the user-level stack that we need in %ebp because otherwise it
gets totally lost.

I'm a disgusting pig, and proud of it to boot.

			Linus

