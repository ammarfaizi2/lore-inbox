Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWIEHWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWIEHWM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 03:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbWIEHWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 03:22:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38027 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750756AbWIEHWK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 03:22:10 -0400
Date: Tue, 5 Sep 2006 09:15:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Voluspa <lista1@comhem.se>, arjan@linux.intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: disable lock debugging when kernel state becomes untrusted
Message-ID: <20060905071501.GA2765@elte.hu>
References: <20060814030954.c3a57e05.lista1@comhem.se> <20060813184159.b536736f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060813184159.b536736f.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> That would appear to be a bug.  debug_locks_off() is running 
> console_verbose() waaaay after the locking selftest code has 
> completed.

debug_locks_off() should only be used when a real bug is being displayed 
- which isnt the case when we call add_taint(). The patch below should 
fix this.

	Ingo

---------------->
Subject: lockdep: do not touch console state when tainting the kernel
From: Ingo Molnar <mingo@elte.hu>

Remove an unintended console_verbose() side-effect from add_taint().

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/panic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/kernel/panic.c
===================================================================
--- linux.orig/kernel/panic.c
+++ linux/kernel/panic.c
@@ -173,7 +173,7 @@ const char *print_tainted(void)
 
 void add_taint(unsigned flag)
 {
-	debug_locks_off(); /* can't trust the integrity of the kernel anymore */
+	debug_locks = 0; /* can't trust the integrity of the kernel anymore */
 	tainted |= flag;
 }
 EXPORT_SYMBOL(add_taint);
