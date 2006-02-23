Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751804AbWBWW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbWBWW5S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751805AbWBWW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:57:18 -0500
Received: from ozlabs.org ([203.10.76.45]:6104 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751804AbWBWW5S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:57:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17406.15816.112314.494845@cargo.ozlabs.ibm.com>
Date: Fri, 24 Feb 2006 09:57:12 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Michael Buesch <mbuesch@freenet.de>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: PowerPC: Sleeping function called from invalid context at emulate_instruction()
In-Reply-To: <7A04DCF5-C5CF-46E2-A133-A7743BD83B17@kernel.crashing.org>
References: <200602222129.31700.mbuesch@freenet.de>
	<7A04DCF5-C5CF-46E2-A133-A7743BD83B17@kernel.crashing.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala writes:

> Last time this was brought up we left it wondering why you had made  
> program_check_exception() run with interrupts disabled.  Any further  
> ideas on that one?

I think it was so that if we are entering the kernel debugger, we do
so on the same cpu that the exception was generated on.  This should
fix it.

Paul.

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 7509aa6..98660ae 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -814,6 +814,8 @@ void __kprobes program_check_exception(s
 		return;
 	}
 
+	local_irq_enable();
+
 	/* Try to emulate it if we should. */
 	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
 		switch (emulate_instruction(regs)) {
