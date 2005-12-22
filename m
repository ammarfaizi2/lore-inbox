Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030356AbVLVXF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030356AbVLVXF0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVLVXF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:05:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57562 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030356AbVLVXFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:05:25 -0500
Date: Fri, 23 Dec 2005 00:04:38 +0100
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
Subject: [patch 0/8] mutex subsystem, -V6
Message-ID: <20051222230438.GA13302@elte.hu>
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

this is verion -V6 of the generic mutex subsystem. It consists of the 
following patches:

  add-atomic-xchg.patch
  mutex-generic-asm-implementations.patch
  mutex-arch-mutex-h.patch
  mutex-core.patch
  mutex-docs.patch
  mutex-debug.patch
  mutex-debug-more.patch
  xfs-mutex-namespace-collision-fix.patch

the patches are against Linus' latest GIT tree, and they should work 
fine on every Linux architecture.

the delta since -V5:

  53 files changed, 718 insertions(+), 454 deletions(-)

this release picks up Arjan's asm/mutex.h implementation, which adds 
asm-generic/mutex-dec.h, asm-generic/mutex-xchg.h for architectures to 
pick up. i386 and x86_64 use their own optimized version already, the 
other architectures default to mutex-xchg.h. Architectures specify the 
following functions:

 -------------------------------------------------------------------
 *  __mutex_fastpath_lock - try to take the lock by moving the count
 *                          from 1 to a 0 value
 *  @count: pointer of type atomic_t
 *  @fn: function to call if the original value was not 1
 -------------------------------------------------------------------
 *  __mutex_fastpath_lock_retval - try to take the lock by moving the count
 *                                 from 1 to a 0 value
 *  @count: pointer of type atomic_t
 *  @fn: function to call if the original value was not 1
 -------------------------------------------------------------------
 *  __mutex_fastpath_unlock - try to promote the mutex from 0 to 1
 *  @count: pointer of type atomic_t
 *  @fn: function to call if the original value was not 1
 -------------------------------------------------------------------

and __mutex_slowpath_needs_to_unlock(), to specify whether the fastpath 
has touched the count or not.

i have tested this on x86, and i have booted all 4 variants: 
mutex-xchg.h, mutex-dec.h, asm-i386/mutex.h and the debug version. (in 
MUTEX_DEBUG_FULL mode, i.e. with the mutexes in real use.)

Nico, Christoph, does this approach work for you? Nico, you might want 
to try an ARM-specific mutex.h implementation.

	Ingo
