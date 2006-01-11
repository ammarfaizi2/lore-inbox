Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWAKKwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWAKKwe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 05:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWAKKwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 05:52:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20394 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750919AbWAKKwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 05:52:33 -0500
Date: Wed, 11 Jan 2006 11:52:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>,
       PPC64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-ID: <20060111105213.GA3717@elte.hu>
References: <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com> <20060108094839.GA16887@elte.hu> <43C435B9.5080409@austin.ibm.com> <20060110230917.GA25285@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110230917.GA25285@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.1 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> ok. I'll really need to look at "vmstat" output from these. We could 
> easily make the mutex slowpath behave like ppc64 semaphores, via the 
> attached (untested) patch, but i really think it's the wrong thing to 
> do, because it overloads the system with runnable tasks in an 
> essentially unlimited fashion [== overscheduling] - they'll all 
> contend for the same single mutex.

find the working patch below. (the previous one had a syntax error)

	Ingo

Index: linux/kernel/mutex.c
===================================================================
--- linux.orig/kernel/mutex.c
+++ linux/kernel/mutex.c
@@ -227,6 +227,9 @@ __mutex_unlock_slowpath(atomic_t *lock_c
 		debug_mutex_wake_waiter(lock, waiter);
 
 		wake_up_process(waiter->task);
+
+		/* be (much) more agressive about wakeups: */
+		list_move_tail(&waiter->list, &lock->wait_list);
 	}
 
 	debug_mutex_clear_owner(lock);
