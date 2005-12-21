Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbVLUPzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbVLUPzI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 10:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbVLUPzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 10:55:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:5293 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932452AbVLUPzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 10:55:07 -0500
Date: Wed, 21 Dec 2005 16:54:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: [patch 0/8] mutex subsystem, ANNOUNCE
Message-ID: <20051221155411.GA7243@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is the latest version of the mutex subsystem patch-queue. It 
consists of the following patches:

 xfs-mutex-namespace-collision-fix.patch
 add-atomic-xchg.patch
 add-atomic-call-func-i386.patch
 add-atomic-call-func-x86_64.patch
 add-atomic-call-wrappers-rest.patch
 mutex-core.patch
 mutex-debug.patch
 mutex-debug-more.patch

the patches are against Linus' latest tree, and were tested on i386, 
x86_64 and ia64. [the tests were also done in DEBUG_MUTEX_FULL mode, to 
make sure the code works fine. MUTEX_FULL support is not included in 
this patchqueue].

The patches can also be downloaded from:

  http://redhat.com/~mingo/generic-mutex-subsystem/

Changes since the previous version:

- dropped the semaphore-renaming and migration-helper patches. The 
  patches now contain only the pure mutex subsystem, nothing more.

- removed the fastpath dependency on __HAVE_ARCH_CMPXCHG: now every 
  architecture is able to use the generic mutex_lock/mutex_unlock 
  lockless fastpath. The quality of the fastpath is still as good as in 
  the previous version.

- added ARCH_IMPLEMENTS_MUTEX_FASTPATH for architectures that want to 
  hand-code their own fastpath. The mutex_lock_slowpath,
  mutex_unlock_slowpath and mutex_lock_interruptible_slowpath global
  functions can be used by such architectures in this case, and they 
  should implement the mutex_lock(), mutex_unlock() and
  mutex_lock_interruptible() functions themselves. I have tested this
  mechanism on x86. (but x86 wants to use the generic functions 
  otherwise, so those changes are not included in this patchqueue.)

- fixed the x86_64 register-clobber bug noticed by Zwane Mwaikambo

- XFS namespace collision fixes from Jes Sorensen

- lots of cleanups to "hide" the debugging code, it should now be much 
  less intrusive visually - kernel/mutex.c is now both smaller and 
  easier to read. There's no reduction in debugging functionality.

- cleaned up the debugging code

- unified all the externally visible debugging functions around the 
  mutex_debug_ prefix.

- added the proper atomic ops to every architecture - so in theory 
  mutexes should now work on every architectures. i386, x86_64 and ia64 
  was tested.

- created mutex-debug.h to hide some of the debugging details. Moved the 
  mm.h and sched.h debug-function declarations into this file.

- documentation updates

- eliminated the ->file, ->line debugging variant - __FUNCTION__ is good
  enough and resulted in nicer code.

- properly check for held locks in kfree() too, if DEBUG.

- check for held-lock reinitialization via mutex_init(), if DEBUG.

- more micro-optimizations: eliminated an extra spinlock drop/reacquire 
  in the slowpath.

- dropped waiter->woken, profiles showed that it triggered very rarely.

- dropped the timeout/timer bits - nothing is using them right now, we 
  can add them back later.

- new mutex_trylock() optimization on architectures that support cmpxchg.

- marked ->name as const

- fixed typo: CONFIG_DEBUG_MUTEXESS -> CONFIG_DEBUG_MUTEXES

- mb() -> smp_mb() in mutex_is_locked()

- mutex_trylock doesnt need __sched

comments, fixes, bugreports are welcome,

	Ingo
