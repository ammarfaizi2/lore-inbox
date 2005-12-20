Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVLTEas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVLTEas (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 23:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVLTEas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 23:30:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:47044 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750788AbVLTEar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 23:30:47 -0500
Date: Tue, 20 Dec 2005 05:29:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051220042945.GB32039@elte.hu>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.7
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.7 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:

> On Mon, 19 Dec 2005, Ingo Molnar wrote:
> 
> > +#define atomic_dec_call_if_negative(v, fn_name)				\
> > +do {									\
> > +	fastcall void (*__tmp)(atomic_t *) = fn_name;			\
> > +									\
> > +	(void)__tmp;							\
> > +	typecheck(atomic_t *, v);					\
> > +									\
> > +	__asm__ __volatile__(						\
> > +		LOCK "decl (%%rdi)\n"  					\
> > +		"js 2f\n"						\
> > +		"1:\n"							\
> > +		LOCK_SECTION_START("")					\
> > +		"2: call "#fn_name"\n\t"				\
> > +		"jmp 1b\n"						\
> > +		LOCK_SECTION_END					\
> > +		:							\
> > +		:"D" (v)						\
> > +		:"memory");						\
> > +} while (0)
> 
> Hi Ingo,
> 	Doesn't this corrupt caller saved registers?

good catch - i correctly marked them clobbered on i386, but not on 
x86_64. The function using this code uses nothing else, so this bug 
caused no real corruption - but that was just pure luck.

	Ingo
