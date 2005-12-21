Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVLUGVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVLUGVL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 01:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVLUGVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 01:21:11 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:43686 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932241AbVLUGVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 01:21:09 -0500
Date: Wed, 21 Dec 2005 07:20:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Nicolas Pitre <nico@cam.org>, David Woodhouse <dwmw2@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [patch 04/15] Generic Mutex Subsystem, add-atomic-call-func-x86_64.patch
Message-ID: <20051221062025.GA32711@elte.hu>
References: <20051219013507.GE27658@elte.hu> <Pine.LNX.4.64.0512190948410.1678@montezuma.fsmlabs.com> <1135025932.4760.1.camel@localhost.localdomain> <20051220043109.GC32039@elte.hu> <Pine.LNX.4.64.0512192358160.26663@localhost.localdomain> <43A7BCE1.7050401@yahoo.com.au> <Pine.LNX.4.64.0512200909180.26663@localhost.localdomain> <43A81132.8040703@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A81132.8040703@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >>Considering that on UP, the arm should not need to disable interrupts
> >>for this function (or has someone refuted Linus?), how about:
> >
> >Kernel preemption.
> 
> preempt_disable() ?

please take a look at kernel/mutex.c, there's a define at the top of the 
file:

// #define MUTEX_IRQ_SAFE

which, if off, makes the mutex code use preempt_disable() and 
preempt_enable() to make it preemption-safe. If it's on, the mutex 
implementation uses IRQ flags.

in my current tree i've already eliminated this define, and have 
switched the code to use preempt_disable()/preempt_enable() exclusively, 
because preempt_*() is equally fast on all platforms, while IRQ disable 
costs vary largely. (and they are rarely faster than preempt_disable()).

my current tree also provides a mechanism for architectures to hand-code 
the mutex lock and unlock fastpath, if they choose to do so. So i think 
we can really stop the cycle counting.

	Ingo
