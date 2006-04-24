Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWDXPDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWDXPDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWDXPDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:03:35 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:9922 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750853AbWDXPD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:03:28 -0400
Date: Mon, 24 Apr 2006 17:03:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, meyerlau@fr.ibm.com
Subject: [patch 4/13] s390: alternate signal stack handling bug.
Message-ID: <20060424150330.GE15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Meyer <meyerlau@fr.ibm.com>

[patch 4/13] s390: alternate signal stack handling bug.

If a signal handler has been established with the SA_ONSTACK option
but no alternate stack is provided with sigaltstack(), the kernel
still tries to install the alternate stack. Also when setting an
alternate stack with sigalstack() and the SS_DISABLE flag, the
kernel tries to install the alternate stack on signal delivery.
Use the correct conditions sas_ss_flags() to check if the alternate
stack has to be used.

Signed-off-by: Laurent Meyer <meyerlau@fr.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-patched/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/compat_signal.c	2006-04-24 16:47:21.000000000 +0200
@@ -430,7 +430,7 @@ get_sigframe(struct k_sigaction *ka, str
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (! on_sig_stack(sp))
+		if (! sas_ss_flags(sp))
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
 
