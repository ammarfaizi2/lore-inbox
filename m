Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVLUS4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVLUS4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 13:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbVLUS4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 13:56:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751183AbVLUS4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 13:56:43 -0500
Date: Wed, 21 Dec 2005 10:54:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 3/8] mutex subsystem, add atomic_*_call_if_*() to i386
In-Reply-To: <20051221155442.GD7243@elte.hu>
Message-ID: <Pine.LNX.4.64.0512211044240.4827@g5.osdl.org>
References: <20051221155442.GD7243@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Dec 2005, Ingo Molnar wrote:
>
> add two new atomic ops to i386: atomic_dec_call_if_negative() and
> atomic_inc_call_if_nonpositive(), which are conditional-call-if
> atomic operations. Needed by the new mutex code.

Umm. This asm is broken. It doesn't mark %eax as changed, so this is only 
reliable if the function you call is

 - a "fastcall" one
 - always returns as its return value the pointer to the atomic count

which is not true (you verify that it's a fastcall, but it's of type 
"void").

Now, it's entirely possible that it's only used in situations where the 
compiler doesn't rely on the value of %eax after the asm anyway, but 
that's just praying. Either mark the value as being changed, or just 
save/restore the registers. Ie either something like

	__asm__ __volatile__(
		LOCK "decl (%0)\n\t"
		"js 2f\n"
		"1:\n"
		LOCK_SECTION_START("")
		"2: call "#fn_name"\n\t"
		"jmp 1b\n"
		LOCK_SECTION_END
		:"=a" (dummy)
		:"0" (v)
		:"memory","cx","dx");

or just do

	__asm__ __volatile__(
		LOCK "decl (%0)\n\t"
		"js 2f\n"
		"1:\n"
		LOCK_SECTION_START("")
		"pushl %%ebx\n\t"
		"pushl %%ecx\n\t"
		"pushl %%eax\n\t"
		"call "#fn_name"\n\t"
		"popl %%eax\n\t"
		"popl %%ecx\n\t"
		"popl %%ebx\n\t"
		"jmp 1b\n"
		LOCK_SECTION_END
		:/* no outputs */
		:"a" (v)
		:"memory");

or some in-between thing (that saves only part of the registers).

The above has not been tested in any way, shape or form. But you get the idea.

		Linus
