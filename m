Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162226AbWKPCqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162226AbWKPCqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162254AbWKPCqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:46:07 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:656 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162253AbWKPCp7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:45:59 -0500
Message-Id: <20061116024659.390275000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:48 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>, jbeulich@novell.com
Subject: [patch 16/30] x86_64: Fix FPU corruption
Content-Disposition: inline; filename=x86_64-fix-fpu-corruption.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andi Kleen <ak@suse.de>

This reverts an earlier patch that was found to cause FPU
state corruption. I think the corruption happens because
unlazy_fpu() can cause FPU exceptions and when it happens
after the current switch some processing would affect
the state in the wrong process.

Thanks to  Douglas Crosher and Tom Hughes for testing.

Cc: jbeulich@novell.com
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/x86_64/kernel/process.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- linux-2.6.18.2.orig/arch/x86_64/kernel/process.c
+++ linux-2.6.18.2/arch/x86_64/kernel/process.c
@@ -571,6 +571,9 @@ __switch_to(struct task_struct *prev_p, 
 		prev->gsindex = gsindex;
 	}
 
+	/* Must be after DS reload */
+	unlazy_fpu(prev_p);
+
 	/* 
 	 * Switch the PDA and FPU contexts.
 	 */
@@ -578,10 +581,6 @@ __switch_to(struct task_struct *prev_p, 
 	write_pda(oldrsp, next->userrsp); 
 	write_pda(pcurrent, next_p); 
 
-	/* This must be here to ensure both math_state_restore() and
-	   kernel_fpu_begin() work consistently. 
-	   And the AMD workaround requires it to be after DS reload. */
-	unlazy_fpu(prev_p);
 	write_pda(kernelstack,
 		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
 

--
