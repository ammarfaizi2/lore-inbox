Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbTE1Lq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264694AbTE1Lq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:46:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2319 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264693AbTE1Lpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:45:40 -0400
Date: Wed, 28 May 2003 12:58:53 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [RFC] Two patches - ptrace single stepping + modpost.c
Message-ID: <20030528125853.A30380@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's two patches I'd like to get sorted out and merged into
2.5 or whatever.

The first: add a flag to tsk->ptrace to indicate whether we're
single stepping or not.  This is used by the ARM ptrace code in
arch/arm/kernel/signal.c to decide whether we need to halt the
process for the debugger during signal processing, or remove
and set single stepping breakpoints.

Other architectures which use similar schemes (eg, alpha) might also
like this; it looks like Alpha may be a little buggy; it appears
to carry the single stepping status across signal handling.  What
happens if the debugger decides to disable single stepping when
the debugged process receives a signal?

--- orig/include/linux/ptrace.h	Tue May 27 10:05:43 2003
+++ linux/include/linux/ptrace.h	Tue May 27 10:14:30 2003
@@ -65,6 +65,7 @@
 #define PT_TRACE_EXIT	0x00000200
 
 #define PT_TRACE_MASK	0x000003f4
+#define PT_SINGLESTEP	0x80000000	/* single stepping (used on ARM) */
 
 #include <linux/compiler.h>		/* For unlikely.  */
 #include <linux/sched.h>		/* For struct task_struct.  */


The second: this allows modpost.c to build on ARM.  For some unknown
reason, EM_SPARC* are not present in my system headers.  This isn't
the right solution since it would interfere with cross-building SPARC.
Are EM_SPARC* normally defined as preprocessor macros or enums?

--- orig/scripts/modpost.c	Mon May  5 17:40:29 2003
+++ linux/scripts/modpost.c	Thu May  8 16:40:46 2003
@@ -296,13 +296,14 @@
 		/* ignore global offset table */
 		if (strcmp(symname, "_GLOBAL_OFFSET_TABLE_") == 0)
 			break;
+#if defined(__sparc__) || defined(__sparc_v9__)
 		if (info->hdr->e_machine == EM_SPARC ||
 		    info->hdr->e_machine == EM_SPARCV9) {
 			/* Ignore register directives. */
 			if (ELF_ST_TYPE(sym->st_info) == STT_REGISTER)
 				break;
 		}
-		
+#endif
 		if (memcmp(symname, MODULE_SYMBOL_PREFIX,
 			   strlen(MODULE_SYMBOL_PREFIX)) == 0) {
 			s = alloc_symbol(symname + 

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

