Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVCODeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVCODeG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVCODeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:34:06 -0500
Received: from gate.crashing.org ([63.228.1.57]:44701 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262223AbVCODdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:33:42 -0500
Subject: Re: swsusp_restore crap
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1110857069.29123.5.camel@gaston>
References: <1110857069.29123.5.camel@gaston>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 14:31:56 +1100
Message-Id: <1110857516.29138.9.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-15 at 14:24 +1100, Benjamin Herrenschmidt wrote:
> Hi Pavel !
> 
> Please kill that swsusp_restore() call that itself calls
> flush_tlb_global(), it's junk. First, the flush_tlb_global() thing is
> arch specific, and that's all swsusp_restore() does. Then, the asm just
> calls this before returning to C code, so it makes no sense to have a
> hook there. The x86 asm can have it's own call to some arch stuff if it
> wants or just do the tlb flush in asm...

Better, here is a patch... (note: flush_tlb_global() is an x86'ism,
doesn't exist on ppc, thus breaks compile, and that has nothing to do in
the generic code imho, it should be clearly defined as the
responsibility of the asm code).

--

This patch removes the quite x86-specific swsusp_restore() hook from the
generic swsusp code and moves it to arch/i386. This also fixes build on
ppc with swsusp enabled.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/i386/power/swsusp.S
===================================================================
--- linux-work.orig/arch/i386/power/swsusp.S	2005-03-15 11:56:17.000000000 +1100
+++ linux-work/arch/i386/power/swsusp.S	2005-03-15 14:29:09.000000000 +1100
@@ -58,5 +58,5 @@
 	movl saved_context_edi, %edi
 
 	pushl saved_context_eflags ; popfl
-	call swsusp_restore
+	call __swsusp_flush_tlb
 	ret
Index: linux-work/arch/i386/power/cpu.c
===================================================================
--- linux-work.orig/arch/i386/power/cpu.c	2005-03-15 11:56:17.000000000 +1100
+++ linux-work/arch/i386/power/cpu.c	2005-03-15 14:28:26.000000000 +1100
@@ -147,6 +147,15 @@
 	__restore_processor_state(&saved_context);
 }
 
+asmlinkage int __swsusp_flush_tlb(void)
+{
+	BUG_ON (nr_copy_pages_check != nr_copy_pages);
+	
+	/* Even mappings of "global" things (vmalloc) need to be fixed */
+	__flush_tlb_global();
+	return 0;
+}
+
 /* Needed by apm.c */
 EXPORT_SYMBOL(save_processor_state);
 EXPORT_SYMBOL(restore_processor_state);
Index: linux-work/kernel/power/swsusp.c
===================================================================
--- linux-work.orig/kernel/power/swsusp.c	2005-03-15 12:00:13.000000000 +1100
+++ linux-work/kernel/power/swsusp.c	2005-03-15 14:29:19.000000000 +1100
@@ -907,15 +907,6 @@
 }
 
 
-asmlinkage int swsusp_restore(void)
-{
-	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	
-	/* Even mappings of "global" things (vmalloc) need to be fixed */
-	__flush_tlb_global();
-	return 0;
-}
-
 int swsusp_resume(void)
 {
 	int error;


