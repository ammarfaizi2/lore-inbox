Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVDMUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVDMUFL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 16:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVDMUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 16:05:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33426 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261158AbVDMUE6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 16:04:58 -0400
Date: Wed, 13 Apr 2005 22:04:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm3
Message-ID: <20050413200426.GA27088@elte.hu>
References: <425D66B0.7030601@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425D66B0.7030601@aknet.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Stas Sergeev <stsp@aknet.ru> wrote:

> Hi Ingo.
> 
> I have some programs that crash
> in 2.6.12-rc2-mm3. After seeing this:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0504.1/1091.html

does the patch below fix the problem for you? (already in Andrew's tree, 
should be in the next -mm patch)

	Ingo

--

delay the reloading of segment registers into switch_mm(), so that if
the LDT size changes we dont get a (silent) fault and a zeroed selector
register upon reloading.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/process.c.orig
+++ linux/arch/i386/kernel/process.c
@@ -612,12 +612,12 @@ struct task_struct fastcall * __switch_t
 	asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
 
 	/*
-	 * Restore %fs and %gs if needed.
+	 * Clear selectors if needed:
 	 */
-	if (unlikely(prev->fs | prev->gs | next->fs | next->gs)) {
-		loadsegment(fs, next->fs);
-		loadsegment(gs, next->gs);
-	}
+        if (unlikely((prev->fs | prev->gs) && !(next->fs | next->gs))) {
+                loadsegment(fs, next->fs);
+                loadsegment(gs, next->gs);
+        }
 
 	/*
 	 * Now maybe reload the debug registers
--- linux/include/asm-i386/mmu_context.h.orig
+++ linux/include/asm-i386/mmu_context.h
@@ -61,6 +61,13 @@ static inline void switch_mm(struct mm_s
 		}
 	}
 #endif
+	/*
+	 * Now that we've switched the LDT, load segments:
+	 */
+	if (unlikely(current->thread.fs | current->thread.gs)) {
+		loadsegment(fs, current->thread.fs);
+		loadsegment(gs, current->thread.gs);
+	}
 }
 
 #define deactivate_mm(tsk, mm) \

