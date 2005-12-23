Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbVLWHqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbVLWHqF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 02:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbVLWHqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 02:46:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:9902 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030429AbVLWHqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 02:46:01 -0500
Date: Fri, 23 Dec 2005 08:45:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2/8] mutex subsystem, add asm-generic/mutex-[dec|xchg].h implementations
Message-ID: <20051223074506.GA9043@elte.hu>
References: <20051222230451.GC13302@elte.hu> <Pine.LNX.4.64.0512221550290.14098@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512221550290.14098@g5.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> On Fri, 23 Dec 2005, Ingo Molnar wrote:
> >
> > add the two generic mutex fastpath implementations.
> 
> Now this looks more like it. This is readable code without any #ifdef's in 
> the middle.
> 
> Now the only #ifdef's seem to be for mutex debugging. Might it be 
> worthwhile to have a generic debugging, that just uses spinlocks and 
> just accept that it's going to be slow, but shared across absolutely 
> all architectures?

yeah, that's how it's working right now - the debugging variant still 
includes the arch header, but ignores it, and always does the slowpath.  
That's one of the advantages of the arch defining the fastpath, but not 
the API! Debugging needs to set up more state so it needs the spinlock 
all the time.

> 	obj$(CONFIG_MUTEX_DEBUG) += mutex-debug.c
> 
> in the kernel/ subdirectory? That way you could _really_ have a clean 
> separation, with absolutely zero pollution of any architecture mess or 
> debugging #ifdef's in any implementation code.

i think we are quite close to this already. We still want to share the 
slowpath because we want to debug it. I'll try to put the mutex-debug.c 
functions into a separate object file, but that introduces more 
interfaces between the two than i wanted to - even if debugging is slow, 
mutexes with full debugging are still faster in the VFS test than 
semaphores ;) I also wanted to introduce a lighter mode of debugging 
that could have the fastpath enabled, and which distributions could 
enable by default in their QA phase. (just like SPINLOCK_DEBUG)

	Ingo
