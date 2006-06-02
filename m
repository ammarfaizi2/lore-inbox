Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWFBTsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWFBTsP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWFBTqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:42 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15233 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751459AbWFBTqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:16 -0400
Message-Id: <20060602194746.282298000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:10 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Andi Kleen <ak@suse.de>
Subject: [PATCH 10/11] x86_64: Dont do syscall exit tracing twice
Content-Disposition: inline; filename=x86_64-don-t-do-syscall-exit-tracing-twice.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Andi Kleen <ak@suse.de>

This fixes a regression from the earlier DOS fix for non canonical
IRET addresses. It broke UML.

int_ret_from_syscall already does syscall exit tracing, so 
no need to do it again in the caller.

This caused problems for UML and some other special programs doing
syscall interception.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/x86_64/kernel/entry.S |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- linux-2.6.16.19.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.16.19/arch/x86_64/kernel/entry.S
@@ -281,12 +281,7 @@ tracesys:			 
 	ja  1f
 	movq %r10,%rcx	/* fixup for C */
 	call *sys_call_table(,%rax,8)
-	movq %rax,RAX-ARGOFFSET(%rsp)
-1:	SAVE_REST
-	movq %rsp,%rdi
-	call syscall_trace_leave
-	RESTORE_TOP_OF_STACK %rbx
-	RESTORE_REST
+1:	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
 	jmp int_ret_from_sys_call
 	CFI_ENDPROC

--
