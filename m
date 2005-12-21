Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVLUWhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVLUWhh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbVLUWhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:37:37 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:7125 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964855AbVLUWhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:37:36 -0500
Date: Wed, 21 Dec 2005 23:36:46 +0100
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
Message-ID: <20051221223646.GA4960@elte.hu>
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
	1.0 AWL                    AWL: From: address is in the auto white-list
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

the patches are against Linus' latest tree.

Changes since the previous version:

- fixed the %eax clobber bug noticed by Linus. Also fixed a similar bug
  in the x86_64 assembly routine. Ended up solving this by marking the 
  register clobbered - the function-always-returns change resulted in 
  worse code. (usually the slowpath functions dont have the atomic-lock 
  parameter ready at the end of the function, so they have to do extra 
  work to return it.)

- implemented Oleg's suggestion of doing the xchg() before adding the 
  waiter to the queue.

- optimization: in the xchg() case we can avoid hitting the slowpath 
  when releasing the lock later on, by setting the count to 0 if the 
  wait-list is otherwise empty. This is the common-case for wakeups.

- bugfix: forgot to take a spinlock in the signal-return path.

- added a couple of likely/unlikely modifiers, based on profile output.

- inline the trylock fastpath into the mutex_trylock() function.

- move the waiter->lock field into the debug path - nothing in the 
  non-debug case was using it. This is also a small optimization for 
  the slowpath.

- optimization: do a cheaper list_del in the non-debug case. This also 
  enabled the removal of debug_remove_waiter().

- fix for the debugging branch: initialize the wait->list to empty.

	Ingo
