Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbVCXNbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbVCXNbt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 08:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVCXNbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 08:31:49 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:47031 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S262455AbVCXNbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 08:31:45 -0500
Date: Thu, 24 Mar 2005 14:32:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 2/9] s390: signal stack bug.
Message-ID: <20050324133200.GB5002@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/9] s390: signal stack bug.

From: Bodo Stroesser <bstroesser@fijitsu-siemens.com>

If a signal handler is set to use the signal stack (SA_ONSTACK), but
the signal stack is disabled, the signal frame should be written to
the current stack without stack switching.

The reason for the bug is get_sigframe() using on_sig_stack() instead
of sas_ss_flags(), which would be ok.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2005-03-24 14:02:44.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2005-03-24 14:03:00.000000000 +0100
@@ -282,7 +282,7 @@ get_sigframe(struct k_sigaction *ka, str
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (! on_sig_stack(sp))
+		if (! sas_ss_flags(sp))
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
