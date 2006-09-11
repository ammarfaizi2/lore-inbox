Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWIKFdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWIKFdJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 01:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIKFdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 01:33:09 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9696 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964867AbWIKFdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 01:33:07 -0400
Date: Mon, 11 Sep 2006 07:25:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: [patch] i386-PDA, lockdep: fix %gs restore
Message-ID: <20060911052527.GA12301@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450499D3.5010903@goop.org>
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


Jeremy,

could you back out Andi's patch and try the patch below, does it fix the 
crash too?

	Ingo

--------------->
Subject: [patch] i386-PDA, lockdep: fix %gs restore
From: Ingo Molnar <mingo@elte.hu>

in the syscall exit path the %gs selector has to be restored _after_ the
last kernel function has been called. If lockdep is enabled then this
kernel function is TRACE_IRQS_ON.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/i386/kernel/entry.S |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -326,11 +326,12 @@ sysenter_past_esp:
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
 /* if something modifies registers it must also disable sysexit */
-1:	mov  PT_GS(%esp), %gs
+1:
+	TRACE_IRQS_ON
+	mov  PT_GS(%esp), %gs
 	movl PT_EIP(%esp), %edx
 	movl PT_OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
-	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS_SYSEXIT
 	CFI_ENDPROC
 .pushsection .fixup,"ax";	\
