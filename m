Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261525AbVD0N4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVD0N4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVD0N4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:56:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:11970 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261525AbVD0Nyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:54:53 -0400
Date: Wed, 27 Apr 2005 15:54:52 +0200
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.12-rc3: unkillable java process in TASK_RUNNING on AMD64
Message-ID: <20050427135451.GM13305@wotan.suse.de>
References: <200504271152.15423.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504271152.15423.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does this patch fix the problem?

Initialize workmask correct on interrupt signal handling

Readd missing clis in the interrupt return path.

Signed-off-by: Andi Kleen <ak@suse.de>



diff -u linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o linux-2.6.12rc3/arch/x86_64/kernel/entry.S
--- linux-2.6.12rc3/arch/x86_64/kernel/entry.S-o	2005-04-22 12:48:11.000000000 +0200
+++ linux-2.6.12rc3/arch/x86_64/kernel/entry.S	2005-04-27 15:52:49.305183345 +0200
@@ -296,6 +296,7 @@
 	call syscall_trace_leave
 	popq %rdi
 	andl $~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
+	cli	
 	jmp int_restore_rest
 	
 int_signal:
@@ -307,6 +308,7 @@
 1:	movl $_TIF_NEED_RESCHED,%edi	
 int_restore_rest:
 	RESTORE_REST
+	cli	
 	jmp int_with_check
 	CFI_ENDPROC
 		
@@ -490,7 +492,8 @@
 	call do_notify_resume
 	RESTORE_REST
 	cli
-	GET_THREAD_INFO(%rcx)	
+	GET_THREAD_INFO(%rcx)
+	movl $_TIF_WORK_MASK,%edi	
 	jmp retint_check
 
 #ifdef CONFIG_PREEMPT
