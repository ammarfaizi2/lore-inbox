Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964770AbVLVLxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964770AbVLVLxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbVLVLxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:53:34 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6547 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964770AbVLVLxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:53:33 -0500
Date: Thu, 22 Dec 2005 11:53:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222115329.GA30964@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>, Andi Kleen <ak@suse.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>
References: <20051222114147.GA18878@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222114147.GA18878@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 12:41:47PM +0100, Ingo Molnar wrote:
> this is the -V4 of the mutex subsystem patch-queue. It consists of the 
> following patches:
> 
>   add-atomic-xchg.patch
>   add-atomic-call-func-i386.patch
>   add-atomic-call-func-x86_64.patch
>   add-atomic-call-wrappers-rest.patch
>   mutex-core.patch
>   mutex-switch-arm-to-xchg.patch
>   mutex-debug.patch
>   mutex-debug-more.patch
>   xfs-mutex-namespace-collision-fix.patch
> 
> the patches are against Linus' latest GIT tree, and they should work 
> fine on every Linux architecture.
> 
> Changes since -V3:
> 
> - imlemented an atomic_xchg() based mutex implementation. It integrated
>   pretty nicely into the generic code, and most of the code is still
>   shared.
> 
> - added __ARCH_WANT_XCHG_BASED_ATOMICS: if an architecture defines 
>   this then the generic mutex code will switch to the atomic_xchg() 
>   implementation.
> 
>   This should be conceptually equivalent to the variant Nicolas Pitre 
>   posted - Nicolas, could you check out this one? It's much easier to 
>   provide this in the generic implementation, and the code ends up 
>   looking cleaner.
> 
> - eliminated ARCH_IMPLEMENTS_MUTEX_FASTPATH: there's no need for 
>   architectures to override the generic code anymore, with the 
>   introduction of __ARCH_WANT_XCHG_BASED_ATOMICS.
> 
> - ARM: enable __ARCH_WANT_XCHG_BASED_ATOMICS.

I must admit I really really hat __ARCH_ stuff if we can avoid it.
An <asm/mutex.h> that usually includes two asm-generic variants is probably
a much better choice.

Actually just havign asm/mutex.h implement the faspath per-arch and get
rid of all the oddball atomic.h additions would be even better.  While
this means we need per-arch code it also means the code is a lot easier
understandable, and we don't add odd public APIs.

