Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWGPDZJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWGPDZJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 23:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWGPDZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 23:25:09 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:23748 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964828AbWGPDZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 23:25:07 -0400
Date: Sat, 15 Jul 2006 23:24:40 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] UML - fix utsname build breakage
Message-ID: <20060716032440.GA5126@ccure.user-mode-linux.org>
References: <200607141952.k6EJqOtL005577@ccure.user-mode-linux.org> <44B996B2.8040202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B996B2.8040202@garzik.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 15, 2006 at 09:30:26PM -0400, Jeff Garzik wrote:
> I can't find any 'JB_' symbols on my computer, except for the uses in 
> your source code.   :(

In libc, there used to be.

A quick and dirty patch, unsuitable for mainline is this:

Newer libcs don't define the JB_* jmp_buf access macros.  If this is
the case, we provide values ourselves.

Index: linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-i386/registers.c	2006-02-13 13:00:06.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sys-i386/registers.c	2006-02-13 13:04:07.000000000 -0500
@@ -130,6 +130,12 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 5
+#define JB_SP 4
+#define JB_BP 3
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;
Index: linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-13 13:00:06.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/sys-x86_64/registers.c	2006-02-13 13:04:07.000000000 -0500
@@ -78,6 +78,12 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
+#ifndef JB_PC
+#define JB_PC 7
+#define JB_RSP 6
+#define JB_RBP 1
+#endif
+
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
 	struct __jmp_buf_tag *jmpbuf = buffer;

I have a couple other patches, which may be better for mainline, which
take klibc's setjmp implementation.  My -mm patch grabs the
appropriate klibc header and object, and my mainline patch simply
copies the klibc sources into the UML tree.  If you want either of
those, let me know.

				Jeff
