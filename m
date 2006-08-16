Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWHPMJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWHPMJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 08:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWHPMJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 08:09:51 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:62585 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751134AbWHPMJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 08:09:50 -0400
Date: Wed, 16 Aug 2006 14:09:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: fix syscall restart handling.
Message-ID: <20060816120947.GG24551@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] fix syscall restart handling.

If do_signal() gets called several times before returning to user space
and no signal is pending (e.g. cancelled by a debugger) syscall restart
handling could be done several times. This would change the user space
PSW to an address prior to the syscall instruction.
Fix this by making sure that syscall restart handling is only done once.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/signal.c |    1 +
 1 files changed, 1 insertion(+)

diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2006-08-16 13:35:54.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2006-08-16 13:36:51.000000000 +0200
@@ -457,6 +457,7 @@ void do_signal(struct pt_regs *regs)
 		case -ERESTART_RESTARTBLOCK:
 			regs->gprs[2] = -EINTR;
 		}
+		regs->trap = -1;	/* Don't deal with this again. */
 	}
 
 	/* Get signal to deliver.  When running under ptrace, at this point
