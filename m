Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261159AbUEZWu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbUEZWu6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 18:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUEZWur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 18:50:47 -0400
Received: from tmpsys.etnus.com ([68.162.234.181]:55480 "EHLO
	service0.etnus.com") by vger.kernel.org with ESMTP id S261606AbUEZWuO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 18:50:14 -0400
Date: Wed, 26 May 2004 18:50:11 -0400 (EDT)
From: Chris Gottbrath <chrisg@etnus.com>
Reply-To: Chris.Gottbrath@etnus.com
To: Andi Kleen <ak@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, John DelSignore <jdelsign@etnus.com>
Subject: [PATCH] x86-64 only: ia32entry.S reg changes dropped during debugging
Message-ID: <Pine.LNX.4.58.0405261822370.8575@papua.etnus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi, 

We develop a debugger for linux x86-64 called TotalView. We have 
recently tracked down a problem to the fact that some register changes
made by the debugger in the target are getting discarded. This is only 
happening with the 2.4.x kernels on x86-64. It appears that the 
bug may have been fixed as a side effect of some other change in 2.6.x.

The scenario is that the debugger uses ptrace(PTRACE_SYSCALL,) and 
changes some registers in the process while it is stopped in a
system call. We are finding that the system call entry code discards 
changes to R15, R14, R13, R12, RBP, and RBX.

The following patch is against arch/x86_64/ia32/ia32entry.S in 2.4.26.

--- ia32entry.S.orig	2004-02-18 08:36:31.000000000 -0500
+++ ia32entry.S	2004-05-19 17:39:22.000000000 -0400
@@ -71,7 +71,7 @@
 	movq %rsp,%rdi        /* &pt_regs -> arg1 */
 	call syscall_trace
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
-	addq $ARGOFFSET,%rsp	
+	RESTORE_REST
 	cmpl $(IA32_NR_syscalls),%eax
 	jae  1f
 	IA32_ARG_FIXUP
@@ -81,7 +81,7 @@
 1:	SAVE_REST
 	movq %rsp,%rdi		/* &pt_regs -> arg1 */ 
 	call syscall_trace
-	addq $ARGOFFSET,%rsp
+	RESTORE_REST
 	jmp int_ret_from_sys_call
 		
 ia32_badsys:


Please CC me with any feedback. 

Cheers,
Chris


--
Chris Gottbrath
Partner Technologies Engineer    Etnus, LLC
Chris.Gottbrath@etnus.com        http://www.etnus.com/
Voice: 508-652-7700 x7735        Fax: 508-652-7787
