Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUADUlX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 15:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUADUlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 15:41:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:7893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263568AbUADUlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 15:41:21 -0500
Date: Sun, 4 Jan 2004 12:41:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 Heads-up
In-Reply-To: <3FF7A910.40703@tmr.com>
Message-ID: <Pine.LNX.4.58.0401041232440.2162@home.osdl.org>
References: <bsgav5$4qh$1@cesium.transmeta.com> <Pine.LNX.4.58.0312252021540.14874@home.osdl.org>
 <3FF5E952.70308@tmr.com> <m365fsu48n.fsf@defiant.pm.waw.pl> <3FF7A910.40703@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Bill Davidsen wrote:
> 
> Since that's a matter of taste I can't disagree. The point was that the 
> original post used
>    *(a ? &b : &c) = d;
> which generates either warnings or errors if b or c is a register 
> variable, because you are not allowed to take the address of a register. 

The thing is, the above case is the _only_ case where there is any point
to using a conditional expression and an assignment to the result in the
same expression.

If you have local variables (register or not), the sane thing to do is

	if (a)
		b = d;
	else
		c = d;

or variations on that. That's the readable code.

The only case where conditional assignment expressions are useful is when
you are literally trying to avoid doing branches, and the compiler isn't
smart enough to avoid them otherwise. 

Check the compiler output some day. Try out what

	int a, b;

	void test_assignment_1(int val)
	{
		*(val ? &a : &b) = 1;
	}

	void test_assignment_2(int val)
	{
		if (val)
			a = 1;
		else
			b = 1;
	}

	void test_assignment_3(int val)
	{
		(val ? a : b) = 1;
	}

actually generate.

Hint: only the first one generates code without any jumps (on
architectures that have conditional moves and with "normal" compilers).

In short: the "*(a?&b:&c) = x" format actually has some advantages. It 
also happens to be standard C. The "(a ? b : c) = x" format is not only 
not real C code, but it has _zero_ advantages.

		Linus
