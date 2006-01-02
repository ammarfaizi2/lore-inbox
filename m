Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWABQqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWABQqn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 11:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWABQqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 11:46:43 -0500
Received: from cantor2.suse.de ([195.135.220.15]:6113 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750836AbWABQqm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 11:46:42 -0500
Date: Mon, 2 Jan 2006 17:46:06 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 05/19] mutex subsystem, add include/asm-x86_64/mutex.h
Message-ID: <20060102164605.GB7222@wotan.suse.de>
References: <20060102163354.GF31501@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060102163354.GF31501@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 05:33:54PM +0100, Ingo Molnar wrote:
> +	__asm__ __volatile__(						\
> +		LOCK	"   decl (%%rdi)	\n"			\
> +			"   js 2f		\n"			\
> +			"1:			\n"			\
> +									\
> +		LOCK_SECTION_START("")					\
> +			"2: call "#fail_fn"	\n"			\
> +			"   jmp 1b		\n"			\
> +		LOCK_SECTION_END					\
> +									\
> +		:"=D" (dummy)						\
> +		: "D" (v)						\
> +		: "rax", "rsi", "rdx", "rcx",				\
> +		  "r8", "r9", "r10", "r11", "memory");			\

I think it would be still better if you used the stubs in arch/x86_64/lib/thunk.S
and not clobber all the registers.
While it won't make that much difference for the out of line mutexes it will
generate better code for inline mutexes, and if someone ever decides they're
a good idea the code will be ready.

-Andi
