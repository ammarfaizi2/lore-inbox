Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVBICQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVBICQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbVBICQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:16:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:26812 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261747AbVBICQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:16:19 -0500
Date: Tue, 8 Feb 2005 18:16:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Richard Henderson <rth@twiddle.net>
cc: Ingo Molnar <mingo@elte.hu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: out-of-line x86 "put_user()" implementation
In-Reply-To: <20050209012741.GB13802@twiddle.net>
Message-ID: <Pine.LNX.4.58.0502081808410.2165@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org>
 <20050207114415.GA22948@elte.hu> <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
 <20050209012741.GB13802@twiddle.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Feb 2005, Richard Henderson wrote:
>
> On Mon, Feb 07, 2005 at 05:20:06PM -0800, Linus Torvalds wrote:
> > +#define __put_user_8(x, ptr) __asm__ __volatile__("call __put_user_8":"=A" (__ret_pu):"0" ((typeof(*(ptr)))(x)), "c" (ptr))
> 
> This is not constrained enough.  The compiler could choose to put the
> return value in edx.  You want
> 
>   __asm__ __volatile__("call __put_user_8":"=a" (__ret_pu)
> 			: "A" ((typeof(*(ptr)))(x)), "c" (ptr))

Hmm.. I always thought "A" was the _pairing_ of %eax/%edx, not "eax or
edx"?

IOW, as far as I know, I'm telling the compiler that the asm is writing a
64-bit value into %eax:%edx, and that that __ret_pu gets that 64-bit value 
assigned to it (and truncated, at that point). No?

Note that he code that actually writes to the register is the assembly 
code, and that one always writes to %eax. So the compiler doesn't get to 
"put the return value" anywhere. It gets told where it is.

I'd happily use your version, but I thought that some versions of gcc
require that input output registers cannot overlap, and would refuse to do 
that thing? But if you tell me differently..

			Linus
