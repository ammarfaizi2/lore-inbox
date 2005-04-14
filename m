Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261256AbVDNAYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261256AbVDNAYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVDNAYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:24:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:50377 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261256AbVDNAVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:21:00 -0400
Date: Wed, 13 Apr 2005 17:20:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm3
Message-Id: <20050413172039.4502b2a9.akpm@osdl.org>
In-Reply-To: <200504132015.49877.tomlins@cam.org>
References: <20050411012532.58593bc1.akpm@osdl.org>
	<200504120732.24440.tomlins@cam.org>
	<20050412043952.0644d4ac.akpm@osdl.org>
	<200504132015.49877.tomlins@cam.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Tomlinson <tomlins@cam.org> wrote:
>
> > Don't think so - it works OK here.  Checked the .config?  Does the serial
>  > port work if you do `echo foo > /dev/ttyS0'?  ACPI?
> 
>  Turned out it was some old ups software that got reactivated on the box displaying the
>  console - was a pain to disable it....

OK.

>  In any case, when the box reboots there are not any messages.  Any ideas on what debug
>  options to enable or suggestions on how we can figure out the cause of the reboots.

There were a few problems in the task switching area - maybe that.




From: Ingo Molnar <mingo@elte.hu>

delay the reloading of segment registers into switch_mm(), so that if
the LDT size changes we dont get a (silent) fault and a zeroed selector
register upon reloading.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/process.c     |   10 +++++-----
 25-akpm/include/asm-i386/mmu_context.h |    7 +++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/process.c~sched-unlocked-context-switches-fix arch/i386/kernel/process.c
--- 25/arch/i386/kernel/process.c~sched-unlocked-context-switches-fix	2005-04-12 03:43:07.254363568 -0700
+++ 25-akpm/arch/i386/kernel/process.c	2005-04-12 03:43:07.259362808 -0700
@@ -653,12 +653,12 @@ struct task_struct fastcall * __switch_t
 	asm volatile("mov %%gs,%0":"=m" (prev->gs));
 
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
diff -puN include/asm-i386/mmu_context.h~sched-unlocked-context-switches-fix include/asm-i386/mmu_context.h
--- 25/include/asm-i386/mmu_context.h~sched-unlocked-context-switches-fix	2005-04-12 03:43:07.256363264 -0700
+++ 25-akpm/include/asm-i386/mmu_context.h	2005-04-12 03:43:07.260362656 -0700
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
_

