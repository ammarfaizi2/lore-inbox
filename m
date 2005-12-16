Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVLPPx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVLPPx7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 10:53:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbVLPPx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 10:53:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17580 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932291AbVLPPx6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 10:53:58 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <43A2BE49.4000102@yahoo.com.au> 
References: <43A2BE49.4000102@yahoo.com.au>  <43A08D50.30707@yahoo.com.au> <439FFF63.6020105@yahoo.com.au> <439F6EAB.6030903@yahoo.com.au> <439E122E.3080902@yahoo.com.au> <dhowells1134431145@warthog.cambridge.redhat.com> <22479.1134467689@warthog.cambridge.redhat.com> <13613.1134557656@warthog.cambridge.redhat.com> <15157.1134560767@warthog.cambridge.redhat.com> <12832.1134734438@warthog.cambridge.redhat.com> 
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, arjan@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation 
X-Mailer: MH-E 7.84; nmh 1.1; GNU Emacs 22.0.50.1
Date: Fri, 16 Dec 2005 15:53:51 +0000
Message-ID: <20220.1134748431@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Yes, the architecture code knows whether or not it implements atomic ops
> with spinlocks, so that architecture is in the position to decide to override
> the mutex implementation. *generic* code shouldn't worry about that, it should
> use the interfaces available, and if that isn't optimal on some architecture
> then that architecture can override it.

However, a number of generic templates can be provided if it makes things
easier for the arches because all they need to is:

	[arch/wibble/Kconfig]
	config MUTEX_TYPE_FOO
		bool
		default y

	[include/asm-wibble/system.h]
	#define __mutex_foo_this() { ... }
	#define __mutex_foo_that() { ... }

The unconditional two-state exchange I think will be a useful template for a
number of archs that don't have anything more advanced than XCHG/TAS/BSET/SWAP.

> It is not even clear that any ll/sc based architectures would need to override
> an atomic_cmpxchg variant at all because you can assume an unlocked fastpath

That's irrelevant. Any arch that has LL/SC almost certainly emulates CMPXCHG
with LL/SC.

> and not do the additional initial load to prime the cmpxchg.

Two points:

 (1) LL/SC does not require an additional initial load.

 (2) CMPXCHG does an implicit load; how else can it compare?

LL/SC can never be worse than CMPXCHG, if only because you're very unlikely to
have both, but it can be better.

David
