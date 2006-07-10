Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWGJL0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWGJL0K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 07:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGJL0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 07:26:10 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:63996 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751334AbWGJL0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 07:26:09 -0400
Date: Mon, 10 Jul 2006 13:25:25 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, drepper@redhat.com
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
Message-ID: <20060710132525.4d0042ed@cad-250-152.norway.atmel.com>
In-Reply-To: <1152525453.3373.9.camel@pmac.infradead.org>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	<20060706021906.1af7ffa3.akpm@osdl.org>
	<20060706120319.26b35798@cad-250-152.norway.atmel.com>
	<20060706031416.33415696.akpm@osdl.org>
	<20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
	<1152525453.3373.9.camel@pmac.infradead.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.3.1 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2006 10:57:33 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> On Mon, 2006-07-10 at 11:03 +0200, Haavard Skinnemoen wrote:
> +	.global	__sys_pselect6
> +	.type	__sys_pselect6,@function
> +__sys_pselect6:
> +	pushm	lr
> +	st.w	--sp, ARG6
> +	rcall	sys_pselect6
> +	sub	sp, -4
> +	popm	pc
> 
> 
> sys_pselect6() is just a hackish workaround for the fact that most
> architectures don't allow seven-argument syscalls. Having your own
> workaround in assembly, which then calls sys_pselect6(), seems a
> little odd -- why not call sys_pselect7() directly instead from your
> assembly wrapper?

Good point. The reason I did it this way is because I haven't written a
_syscall7() stub for uClibc yet, but I guess I should probably get that
done. I did a quick grep through include/asm-* and didn't find any
other architectures defining __NR_pselect7...

> Stop a moment and work out precisely what the best way to pass the
> arguments _is_ if you have only 5 registers and the stack, perhaps.

The regular AVR32 call convention uses r12-r8 to pass up to 5 arguments
in registers, while any additional arguments are pushed on the stack.

For syscalls, I've modified this to pass the syscall number in r8 and
no arguments on the stack. arg5 is passed in r5 and moved to r8 by the
low-level syscall handler, while arg6 is passed through r3 and pushed
on the stack only if necessary.

So the best way to implement pselect7 is probably to pass the seventh
argument through r2 -- or maybe r4.

> ¹ Note that I'm just _asking_ -- the answer "Uli doesn't want to
> support anything but the basic 6-argument sys_pselect6() in glibc" is
> an acceptable answer on your part.

Well, we haven't actually ported glibc yet. But if 7-argument syscalls
is going to cause problems later, we should probably not do it...

Håvard
