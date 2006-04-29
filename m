Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWD2I1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWD2I1E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWD2I1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:27:03 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:21650 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751110AbWD2I1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:27:01 -0400
Date: Sat, 29 Apr 2006 10:26:59 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/2] s390: bug in setup_rt_frame
Message-ID: <20060429082659.GC9463@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Consider return value of __put_user() when setting up a signal frame instead
of ignoring it.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

Second version of this patch. This time without replacing __NR_rt_sigreturn
with __NR_sigreturn...

 arch/s390/kernel/signal.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index ae1927e..d48cfc7 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -358,8 +358,9 @@ static int setup_rt_frame(int sig, struc
 	} else {
                 regs->gprs[14] = (unsigned long)
 			frame->retcode | PSW_ADDR_AMODE;
-		err |= __put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
-	                          (u16 __user *)(frame->retcode));
+		if (__put_user(S390_SYSCALL_OPCODE | __NR_rt_sigreturn,
+			       (u16 __user *)(frame->retcode)))
+			goto give_sigsegv;
 	}
 
 	/* Set up backchain. */
