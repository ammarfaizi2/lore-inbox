Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751898AbWFVVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbWFVVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 17:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWFVVH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 17:07:26 -0400
Received: from 1wt.eu ([62.212.114.60]:11273 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751895AbWFVVHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 17:07:23 -0400
Date: Thu, 22 Jun 2006 23:06:57 +0200
From: Willy Tarreau <w@1wt.eu>
To: marcelo@kvack.org, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, pageexec@freemail.hu
Subject: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Message-ID: <20060622210657.GA1221@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been reported by the PaX Team that the following fix left a
small hole :

[PATCH] Always check that RIPs are canonical during signal handling

+	if (regs->rip >= TASK_SIZE && regs->rip < VSYSCALL_START) {
+		regs->rip = 0;
+		return -EFAULT;
+	}

...

+	if (regs->rip >= TASK_SIZE) {
+		if (sig == SIGSEGV)
+			ka->sa.sa_handler = SIG_DFL;
+		regs->rip = 0;
+	}

"the wrong part is regs->rip=0, i guess the intention was to cause a
 SIGSEGV upon returning to userland, but 0 is a valid userland address,
 an application may very well have something mapped there. the correct
 value would be ~0UL as it's guaranteed to fault on linux."

This explanation makes sense, so here's the patch. Andi, would you please
review and confirm ? Thanks in advance.

      Acked-By: Pax Team
      Signed-off-by: Willy Tarreau <w@1wt.eu>

---

 arch/x86_64/kernel/signal.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

a408e3e80854d04915969fe3ae05152bedf99c79
diff --git a/arch/x86_64/kernel/signal.c b/arch/x86_64/kernel/signal.c
index 8bc844f..f3eff11 100644
--- a/arch/x86_64/kernel/signal.c
+++ b/arch/x86_64/kernel/signal.c
@@ -144,7 +144,7 @@ #define COPY(x)		err |= __get_user(regs-
 	COPY(rdx); COPY(rcx); 
 	COPY(rip);
 	if (regs->rip >= TASK_SIZE && regs->rip < VSYSCALL_START) { 
-		regs->rip = 0;
+		regs->rip = ~0UL; /* force the application to fault */
 		return -EFAULT;
 	}
 	COPY(r8);
@@ -361,7 +361,7 @@ #endif
 	if (regs->rip >= TASK_SIZE) { 
 		if (sig == SIGSEGV)
 			ka->sa.sa_handler = SIG_DFL;
-		regs->rip = 0;
+		regs->rip = ~0UL; /* force the application to fault */
 	}
 	regs->cs = __USER_CS;
 	regs->ss = __USER_DS; 
-- 
1.3.3

