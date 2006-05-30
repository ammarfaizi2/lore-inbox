Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWE3Usl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWE3Usl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWE3Usl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 16:48:41 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:19587 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932410AbWE3Usk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 16:48:40 -0400
Date: Tue, 30 May 2006 22:49:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch, -rc5-mm1] lock validator: fix RT_HASH_LOCK_SZ
Message-ID: <20060530204901.GA27645@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org> <adaac8z70yc.fsf@cisco.com> <20060530202654.GA25720@elte.hu> <ada1wub6y6b.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada1wub6y6b.fsf@cisco.com>
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


* Roland Dreier <rdreier@cisco.com> wrote:

>  > on lockdep we have a quite big spinlock_t, so keep the size down.
> 
> Yes, that builds fine.
> 
> However the kernel won't boot for me... it oopses early on in 
> save_stack_trace().  I'm attaching a bootlog, plus another try booting 
> with nmi_watchdog=0, plus my config.

there's some bad interaction between the new dwarf2 unwind info 
stackframe walker code in mm1 and lockdep's stacktrace code on x86_64. 
I'm investigating this currently, meanwhile you can try the quick hack 
below.

	Ingo

Index: linux/arch/x86_64/kernel/stacktrace.c
===================================================================
--- linux.orig/arch/x86_64/kernel/stacktrace.c
+++ linux/arch/x86_64/kernel/stacktrace.c
@@ -127,7 +127,8 @@ save_context_stack(struct stack_trace *t
 			skip--;
 		if (trace->nr_entries >= trace->max_entries)
 			break;
-		if (!addr)
+#warning fixme
+//		if (!addr)
 			return 0;
 		/*
 		 * Stack frames must go forwards (otherwise a loop could
