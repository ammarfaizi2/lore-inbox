Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVCOLsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVCOLsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 06:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVCOLsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 06:48:25 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:55513 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261171AbVCOLsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 06:48:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp_restore crap
Date: Tue, 15 Mar 2005 12:51:00 +0100
User-Agent: KMail/1.7.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1110857069.29123.5.camel@gaston> <1110857516.29138.9.camel@gaston> <20050315110309.GA1344@elf.ucw.cz>
In-Reply-To: <20050315110309.GA1344@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503151251.01109.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 15 of March 2005 12:03, Pavel Machek wrote:
> On Út 15-03-05 14:31:56, Benjamin Herrenschmidt wrote:
> > On Tue, 2005-03-15 at 14:24 +1100, Benjamin Herrenschmidt wrote:
> > > Hi Pavel !
> > > 
> > > Please kill that swsusp_restore() call that itself calls
> > > flush_tlb_global(), it's junk. First, the flush_tlb_global() thing is
> > > arch specific, and that's all swsusp_restore() does. Then, the asm just
> > > calls this before returning to C code, so it makes no sense to have a
> > > hook there. The x86 asm can have it's own call to some arch stuff if it
> > > wants or just do the tlb flush in asm...
> > 
> > Better, here is a patch... (note: flush_tlb_global() is an x86'ism,
> > doesn't exist on ppc, thus breaks compile, and that has nothing to do in
> > the generic code imho, it should be clearly defined as the
> > responsibility of the asm code).
> 
> x86-64 needs this, too.... Otherwise it looks okay.

It breaks compilation on i386 either, because nr_copy_pages_check
is static in swsusp.c.  May I propose the following patch instead (tested on
x86-64 and i386)?

Greets,
Rafael

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nrup linux-2.6.11-bk10-a/arch/i386/power/cpu.c linux-2.6.11-bk10-b/arch/i386/power/cpu.c
--- linux-2.6.11-bk10-a/arch/i386/power/cpu.c	2005-03-15 09:20:53.000000000 +0100
+++ linux-2.6.11-bk10-b/arch/i386/power/cpu.c	2005-03-15 12:16:57.000000000 +0100
@@ -147,6 +147,15 @@ void restore_processor_state(void)
 	__restore_processor_state(&saved_context);
 }
 
+asmlinkage int __swsusp_flush_tlb(void)
+{
+	swsusp_restore_check();
+
+	/* Even mappings of "global" things (vmalloc) need to be fixed */
+	__flush_tlb_global();
+	return 0;
+}
+
 /* Needed by apm.c */
 EXPORT_SYMBOL(save_processor_state);
 EXPORT_SYMBOL(restore_processor_state);
diff -Nrup linux-2.6.11-bk10-a/arch/i386/power/swsusp.S linux-2.6.11-bk10-b/arch/i386/power/swsusp.S
--- linux-2.6.11-bk10-a/arch/i386/power/swsusp.S	2005-03-15 09:20:53.000000000 +0100
+++ linux-2.6.11-bk10-b/arch/i386/power/swsusp.S	2005-03-15 12:16:28.000000000 +0100
@@ -58,5 +58,6 @@ done:
 	movl saved_context_edi, %edi
 
 	pushl saved_context_eflags ; popfl
-	call swsusp_restore
+
+	call	__swsusp_flush_tlb
 	ret
diff -Nrup linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend_asm.S	2005-03-15 09:20:53.000000000 +0100
+++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend_asm.S	2005-03-15 12:14:47.000000000 +0100
@@ -89,5 +89,6 @@ done:
 	movq saved_context_r14(%rip), %r14
 	movq saved_context_r15(%rip), %r15
 	pushq saved_context_eflags(%rip) ; popfq
-	call	swsusp_restore
+
+	call	__swsusp_flush_tlb
 	ret
diff -Nrup linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend.c linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend.c
--- linux-2.6.11-bk10-a/arch/x86_64/kernel/suspend.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11-bk10-b/arch/x86_64/kernel/suspend.c	2005-03-15 12:15:25.000000000 +0100
@@ -154,4 +154,11 @@ void fix_processor_context(void)
 
 }
 
+int __swsusp_flush_tlb(void)
+{
+	swsusp_restore_check();
 
+	/* Even mappings of "global" things (vmalloc) need to be fixed */
+	__flush_tlb_global();
+	return 0;
+}
diff -Nrup linux-2.6.11-bk10-a/include/linux/suspend.h linux-2.6.11-bk10-b/include/linux/suspend.h
--- linux-2.6.11-bk10-a/include/linux/suspend.h	2005-03-15 09:21:23.000000000 +0100
+++ linux-2.6.11-bk10-b/include/linux/suspend.h	2005-03-15 12:20:06.000000000 +0100
@@ -68,6 +68,8 @@ static inline void disable_nonboot_cpus(
 static inline void enable_nonboot_cpus(void) {}
 #endif
 
+void swsusp_restore_check(void);
+
 void save_processor_state(void);
 void restore_processor_state(void);
 struct saved_context;
diff -Nrup linux-2.6.11-bk10-a/kernel/power/swsusp.c linux-2.6.11-bk10-b/kernel/power/swsusp.c
--- linux-2.6.11-bk10-a/kernel/power/swsusp.c	2005-03-15 09:21:23.000000000 +0100
+++ linux-2.6.11-bk10-b/kernel/power/swsusp.c	2005-03-15 12:18:36.000000000 +0100
@@ -906,14 +906,9 @@ int swsusp_suspend(void)
 	return error;
 }
 
-
-asmlinkage int swsusp_restore(void)
+void swsusp_restore_check(void)
 {
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);
-	
-	/* Even mappings of "global" things (vmalloc) need to be fixed */
-	__flush_tlb_global();
-	return 0;
 }
 
 int swsusp_resume(void)

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
