Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWHVIiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWHVIiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWHVIiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:38:17 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5299 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751362AbWHVIiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:38:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Magnus Damm <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: Reload CS when startup_64 is used.
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	<1156208306.21411.85.camel@localhost>
	<m1u045sagu.fsf@ebiederm.dsl.xmission.com>
	<200608221003.12608.ak@suse.de>
Date: Tue, 22 Aug 2006 02:37:44 -0600
In-Reply-To: <200608221003.12608.ak@suse.de> (Andi Kleen's message of "Tue, 22
	Aug 2006 10:03:12 +0200")
Message-ID: <m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In long mode the %cs is largely a relic.  However there are a few cases
like lret where it matters that we have a valid value.  Without this
patch it is possible to enter the kernel in startup_64 without setting
%cs to a valid value.  With this patch we don't care what %cs value
we enter the kernel with, so long as the cs shadow register indicates
it is a privileged code segment.

Thanks to Magnus Damm for finding this problem and posting the
first workable patch.  I have moved the jump to set %cs down a
few instructions so we don't need to take an extra jump.  Which
keeps the code simpler.

Signed-of-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/head.S |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index 923f080..6c89f6a 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -186,10 +186,13 @@ #define CR0_PAGING 			(1<<31)
 	/* Finally jump to run C code and to be on real kernel address
 	 * Since we are running on identity-mapped space we have to jump
 	 * to the full 64bit address , this is only possible as indirect
-	 * jump
+	 * jump.  In addition we need to ensure %cs is set so we make this
+	 * a far return.	
 	 */
 	movq	initial_code(%rip),%rax
-	jmp	*%rax
+	pushq	$__KERNEL_CS
+	pushq	%rax
+	lretq
 
 	/* SMP bootup changes these two */
 	.align	8
