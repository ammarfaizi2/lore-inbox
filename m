Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbVLUWnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbVLUWnd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVLUWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:43:33 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53961 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964887AbVLUWnc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:43:32 -0500
Date: Wed, 21 Dec 2005 17:43:30 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
In-reply-to: <20051221155411.GA7243@elte.hu>
X-X-Sender: nico@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512211654320.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051221155411.GA7243@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Dec 2005, Ingo Molnar wrote:

> Changes since the previous version:
> 
> - removed the fastpath dependency on __HAVE_ARCH_CMPXCHG: now every 
>   architecture is able to use the generic mutex_lock/mutex_unlock 
>   lockless fastpath. The quality of the fastpath is still as good as in 
>   the previous version.
> 
> - added ARCH_IMPLEMENTS_MUTEX_FASTPATH for architectures that want to 
>   hand-code their own fastpath. The mutex_lock_slowpath,
>   mutex_unlock_slowpath and mutex_lock_interruptible_slowpath global
>   functions can be used by such architectures in this case, and they 
>   should implement the mutex_lock(), mutex_unlock() and
>   mutex_lock_interruptible() functions themselves. I have tested this
>   mechanism on x86. (but x86 wants to use the generic functions 
>   otherwise, so those changes are not included in this patchqueue.)

This is a good step in the right direction for ARM, but not quite there 
yet.

As it is, the core mutex code is still relying on atomic 
decrement/increment to work properly.  What would be extremely 
beneficial on ARM is to be able to use (variants of) atomic_xchg 
everywhere.  And the semantics of a mutex allows that where a semaphore 
doesn't (which is why I see big benefits for ARM with mutexes).

I even forsee a fast path implementation on ARMv6 that would use an 
hybrid approach which will be less instructions and cycles than a 
standard atomic decrement/increment (they are available only on ARM 
version 6 and above).

What we'd need is a bit more  flexibility but only at the low level.  No 
need to reimplement the whole of mutex_lock(), mutex_unlock(), and 
friends.

Please consider the 3 following patches that already bring an immediate 
benefit on ARM, even if the fast path isn't inlined yet.


Nicolas
