Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUKRJZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUKRJZe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 04:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUKRJZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 04:25:34 -0500
Received: from mx1.elte.hu ([157.181.1.137]:30149 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262574AbUKRJZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 04:25:24 -0500
Date: Thu, 18 Nov 2004 11:27:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: cliffw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5 - badness in enable_irg, BUG
Message-ID: <20041118102709.GA20901@elte.hu>
References: <20041115093759.721ac964.cliffw@osdl.org> <20041117210219.43a36302.akpm@osdl.org> <20041118095253.GA16054@elte.hu> <20041118011504.7dc87fe6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118011504.7dc87fe6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Well can we at least stick a comment in there explaining to the
> long-suffering reader what the difference is between
> smp_processor_id(), _smp_processor_id() and __smp_processor_id()?  And
> what the architecture's options are?

doc-patch against -rc2-mm1 attached.

> Or should we go through every arch and rename their smp_processor_id()
> to __smp_processor_id()?  That would make sense, and would simplify
> that piece of code.

initially the rate of false positives is like 90%, so there would only
be annoyance coming out of this patch. Arch maintainers should have the
ability to enable this on their own pace i think. Once the majority of 
arches have enabled this we can force it on for all architectures.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/smp.h.orig
+++ linux/include/linux/smp.h
@@ -109,12 +109,24 @@ static inline void smp_send_reschedule(i
 
 #endif /* !SMP */
 
+/*
+ * DEBUG_PREEMPT support: check whether smp_processor_id() is being
+ * used in a preemption-safe way.
+ *
+ * An architecture has to enable this debugging code explicitly.
+ * It can do so by renaming the smp_processor_id() macro to
+ * __smp_processor_id().  This should only be done after some minimal
+ * testingy, because usually there are a number of false positives
+ * that an architecture will trigger.
+ *
+ * To fix a false positives (i.e. smp_processor_id() use that the
+ * debugging code reports but which use for some reason is legal),
+ * change the smp_processor_id() reference to _smp_processor_id(),
+ * which is the nondebug variant.  NOTE: dont use this to hack around
+ * real bugs.
+ */
 #ifdef __smp_processor_id
 # if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_PREEMPT)
-  /*
-   * temporary debugging check detecting places that use
-   * smp_processor_id() in a potentially unsafe way:
-   */
    extern unsigned int smp_processor_id(void);
 # else
 #  define smp_processor_id() __smp_processor_id()
