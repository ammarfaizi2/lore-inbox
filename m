Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWAJKwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWAJKwi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAJKwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:52:38 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:1198 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932119AbWAJKwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:52:37 -0500
Date: Tue, 10 Jan 2006 11:52:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
Message-ID: <20060110105249.GA1528@elte.hu>
References: <20060107052221.61d0b600.akpm@osdl.org> <43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org> <43C38932.7070302@reub.net> <20060110104759.GA30546@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110104759.GA30546@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> could you please also send me a SysRq-T (showTasks) output? [which 
> will also include all the stacktraces] (Please make sure you have 
> KALLSYMS_ALL enabled.)

a wild guess: could you also apply the debug patch below (and please 
keep CONFIG_DEBUG_MUTEXES enabled) - does it trigger anywhere during 
your bootup sequence? [it doesnt trigger here on an ext3 based bootup 
sequence]

	Ingo

--
check that mutexes are used in TASK_RUNNING state. Using a mutex within
some wait-for-event loop could result in wakeups getting lost.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

----

 kernel/mutex-debug.c |    5 +++++
 1 files changed, 5 insertions(+)

Index: linux/kernel/mutex-debug.c
===================================================================
--- linux.orig/kernel/mutex-debug.c
+++ linux/kernel/mutex-debug.c
@@ -385,6 +385,11 @@ void debug_mutex_init_waiter(struct mute
 	memset(waiter, 0x11, sizeof(*waiter));
 	waiter->magic = waiter;
 	INIT_LIST_HEAD(&waiter->list);
+	/*
+	 * Make sure mutexes are not acquired deep within some
+	 * waitqueue loop - wakeups could get lost:
+	 */
+	DEBUG_WARN_ON(current->state != TASK_RUNNING);
 }
 
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
