Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVLVLme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVLVLme (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 06:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVLVLmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 06:42:33 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:16258 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932068AbVLVLmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 06:42:33 -0500
Date: Thu, 22 Dec 2005 12:41:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051222114147.GA18878@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

this is the -V4 of the mutex subsystem patch-queue. It consists of the 
following patches:

  add-atomic-xchg.patch
  add-atomic-call-func-i386.patch
  add-atomic-call-func-x86_64.patch
  add-atomic-call-wrappers-rest.patch
  mutex-core.patch
  mutex-switch-arm-to-xchg.patch
  mutex-debug.patch
  mutex-debug-more.patch
  xfs-mutex-namespace-collision-fix.patch

the patches are against Linus' latest GIT tree, and they should work 
fine on every Linux architecture.

Changes since -V3:

- imlemented an atomic_xchg() based mutex implementation. It integrated
  pretty nicely into the generic code, and most of the code is still
  shared.

- added __ARCH_WANT_XCHG_BASED_ATOMICS: if an architecture defines 
  this then the generic mutex code will switch to the atomic_xchg() 
  implementation.

  This should be conceptually equivalent to the variant Nicolas Pitre 
  posted - Nicolas, could you check out this one? It's much easier to 
  provide this in the generic implementation, and the code ends up 
  looking cleaner.

- eliminated ARCH_IMPLEMENTS_MUTEX_FASTPATH: there's no need for 
  architectures to override the generic code anymore, with the 
  introduction of __ARCH_WANT_XCHG_BASED_ATOMICS.

- ARM: enable __ARCH_WANT_XCHG_BASED_ATOMICS.

- ARM buildfix: move the new atomic primitives to the correct place.
  (Nicolas Pitre)

- optimization: unlock the mutex outside of the spinlock (suggested by 
  Nicolas Pitre)

- removed leftover arch_semaphore reference from the XFS patch. (noticed
  by Arjan van de Ven)

- better document the fact that mutex_trylock() follows spin_trylock() 
  semantics, not sem_trylock() semantics.

- cleanup: got rid of the MUTEX_LOCKLESS_FASTPATH define. (in -V3 this
  became equivalent to DEBUG_MUTEXES, via the elimination of the
  __HAVE_ARCH_CMPXCHG dependency on the fastpath.)

- further simplified and unified mutex_trylock().

- DocBook entries, and more documentation of internals.

- dropped the spinlock-debug fix, Linus merged it.

	Ingo
