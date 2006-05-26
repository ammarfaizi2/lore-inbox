Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWEZKgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWEZKgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 06:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWEZKgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 06:36:41 -0400
Received: from mail.suse.de ([195.135.220.2]:50404 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751381AbWEZKgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 06:36:40 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [RFC] [PATCH] Double syscall exit traces on x86_64
Date: Fri, 26 May 2006 12:36:26 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       User-mode-linux-devel@lists.sourceforge.net,
       Steven James <pyro@linuxlabs.com>, Roland McGrath <roland@redhat.com>,
       Blaisorblade <blaisorblade@yahoo.it>
References: <20060526032424.GA8283@ccure.user-mode-linux.org>
In-Reply-To: <20060526032424.GA8283@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261236.26814.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 05:24, Jeff Dike wrote:
> We are seeing double ptrace notifications of system call returns on recent
> x86_64 kernels.  This breaks UML and at least one other app.

I believe this patch is the correct fix. Can you confirm it works for you? 

-Andi

Don't do syscall exit tracing twice

int_ret_from_syscall already does syscall exit tracing, so 
no need to do it again in the caller.

This caused problems for UML and some other special programs doing
syscall interception.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -282,12 +282,7 @@ tracesys:			 
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
