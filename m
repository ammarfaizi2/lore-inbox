Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVLSRoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVLSRoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 12:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbVLSRoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 12:44:15 -0500
Received: from fsmlabs.com ([168.103.115.128]:30444 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932289AbVLSRoO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 12:44:14 -0500
X-ASG-Debug-ID: 1135014248-12064-71-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Mon, 19 Dec 2005 09:49:32 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
X-ASG-Orig-Subj: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
In-Reply-To: <20051219013507.GE27658@elte.hu>
Message-ID: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
References: <20051219013507.GE27658@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.60
X-Barracuda-Spam-Status: No, SCORE=0.60 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6435
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.60 MARKETING_SUBJECT      Subject contains popular marketing words
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2005, Ingo Molnar wrote:

> +#define atomic_dec_call_if_negative(v, fn_name)				\
> +do {									\
> +	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
> +									\
> +	(void)__tmp;							\
> +	typecheck(atomic_t *, v);					\
> +									\
> +	__asm__ __volatile__(						\
> +		LOCK "decl (%%rdi)\n"  					\
> +		"js 2f\n"						\
> +		"1:\n"							\
> +		LOCK_SECTION_START("")					\
> +		"2: call "#fn_name"\n\t"				\
> +		"jmp 1b\n"						\
> +		LOCK_SECTION_END					\
> +		:							\
> +		:"D" (v)						\
> +		:"memory");						\
> +} while (0)

Hi Ingo,
	Doesn't this corrupt caller saved registers?
