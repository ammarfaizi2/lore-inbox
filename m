Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbTALW6g>; Sun, 12 Jan 2003 17:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267620AbTALW6g>; Sun, 12 Jan 2003 17:58:36 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:7623 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267621AbTALW5h> convert rfc822-to-8bit; Sun, 12 Jan 2003 17:57:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: robw@optonline.net, Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: any chance of 2.6.0-test*?
Date: Mon, 13 Jan 2003 00:06:14 +0100
User-Agent: KMail/1.4.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <20030112221802.GN31238@vitelus.com> <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
In-Reply-To: <1042410897.1209.165.camel@RobsPC.RobertWilkens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301130006.14180.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 12. Januar 2003 23:34 schrieb Rob Wilkens:
> On Sun, 2003-01-12 at 17:18, Aaron Lehmann wrote:
> > These are usually error conditions. If you inline them, you will have
> > to jump *over* them as part of the normal code path. You don't save
>
> You're wrong.  You wouldn't have to jump over them any more than you
> have to jump over the "goto" statement.  They would be where the goto
> statement is.  Instead of the goto you would have the function.

That exactly is the problem. If they are where the goto would be
they needlessly fill the CPU's pipeline, take up space in L1 and use
up bandwidth on the busses.
A goto is much shorter than a cleanup.

And you would have to jump. Any control structure will result in one
or more conditional jumps in the assembler code (or conditional instructions)

Turning "if (a) goto b;"  into a single branch instruction is trivial.
The best the compiler can do with
if (a) {
	cleanup();
	return err;
}
is putting the conditional code on the end of the function.

So in the best case the compiler can generate almost equivalent code
at a cost of maintainability.

> > any instructions, and you end up with a kernel which has much more
> > duplicated code and thus thrashes the cache more. It also makes the
>
> If that argument was taken to it's logical conclusion (and I did, in my
> mind just now), no one should add any code the grows the kernel at all.

Correct. If you mean that literally, you've grasped an important concept.
You grow the kernel only with good cause.

And you look where you add the code. Additional device drivers don't hurt.
A computed jump is still only one computed jump. Additional code in common
code paths of the core hurts a lot.
For the inner loops of core code there are two considerations, size and
reducing jumps.

	Regards
		Oliver

