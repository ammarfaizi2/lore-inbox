Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUGAGb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUGAGb3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 02:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264113AbUGAGb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 02:31:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:62688 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264097AbUGAGbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 02:31:22 -0400
Date: Thu, 1 Jul 2004 08:32:37 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040701063237.GA16166@elte.hu>
References: <20040630013824.GA24665@mail.shareable.org> <20040630055041.GA16320@elte.hu> <20040630143850.GF29285@mail.shareable.org> <20040701014818.GE32560@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <20040701014818.GE32560@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Jamie Lokier <jamie@shareable.org> wrote:

> Ingo, I think I now know what must be added to your 32-bit NX patch to
> prevent the "infinite loop without a signal" problem.
> 
> It appears the correct way to prevent that one possibility I thought
> of, with no side effects, is to add this test in
> i386/mm/fault.c:is_prefetch():
> 
>         /* Catch an obscure case of prefetch inside an NX page. */
>         if (error_code & 16)
>                 return 0;
> 
> That means that it doesn't count as a prefetch fault if it's an
> _instruction_ fault.  I.e. an instruction fault will always raise a
> signal.  Bit 4 of error_code was kindly added alongside the NX feature
> by AMD.
> 
> (Tweak: Because early Intel 64-bit chips don't have NX, perhaps it
> should say "if ((error_code & 16) && boot_cpu_has(X86_FEATURE_NX))"
> instead -- if we find the bit isn't architecturally set to 0 for those
> chips).

Thanks for the analysis Jamie, this should certainly solve the problem.

I've attached a patch against BK that implements this. I've tested the
patched x86 kernel on an athlon64 box and on a non-NX box - it works
fine. Bit 4 also simplifies the detection of illegal code execution
within the kernel - i retested that too and it still works fine.

	Ingo

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nx-prefetch-fix-2.6.7-A2"


- fix possible prefetch-fault loop on NX page, based on suggestions
  from Jamie Lokier.

- clean up nx feature dependencies

- simplify detection of NX-violations when the kernel executes code

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/mm/fault.c.orig	
+++ linux/arch/i386/mm/fault.c	
@@ -188,11 +188,16 @@ static int __is_prefetch(struct pt_regs 
 	return prefetch;
 }
 
-static inline int is_prefetch(struct pt_regs *regs, unsigned long addr)
+static inline int is_prefetch(struct pt_regs *regs, unsigned long addr,
+			      unsigned long error_code)
 {
 	if (unlikely(boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-		     boot_cpu_data.x86 >= 6))
+		     boot_cpu_data.x86 >= 6)) {
+		/* Catch an obscure case of prefetch inside an NX page. */
+		if (nx_enabled && (error_code & 16))
+			return 0;
 		return __is_prefetch(regs, addr);
+	}
 	return 0;
 } 
 
@@ -374,7 +379,7 @@ bad_area_nosemaphore:
 		 * Valid to do another page fault here because this one came 
 		 * from user space.
 		 */
-		if (is_prefetch(regs, address))
+		if (is_prefetch(regs, address, error_code))
 			return;
 
 		tsk->thread.cr2 = address;
@@ -415,7 +420,7 @@ no_context:
 	 * had been triggered by is_prefetch fixup_exception would have 
 	 * handled it.
 	 */
- 	if (is_prefetch(regs, address))
+ 	if (is_prefetch(regs, address, error_code))
  		return;
 
 /*
@@ -425,21 +430,8 @@ no_context:
 
 	bust_spinlocks(1);
 
-#ifdef CONFIG_X86_PAE
-	{
-		pgd_t *pgd;
-		pmd_t *pmd;
-
-
-
-		pgd = init_mm.pgd + pgd_index(address);
-		if (pgd_present(*pgd)) {
-			pmd = pmd_offset(pgd, address);
-			if (pmd_val(*pmd) & _PAGE_NX)
-				printk(KERN_CRIT "kernel tried to access NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
-		}
-	}
-#endif
+	if (nx_enabled && (error_code & 16))
+		printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
@@ -492,7 +484,7 @@ do_sigbus:
 		goto no_context;
 
 	/* User space => ok to do another page fault */
-	if (is_prefetch(regs, address))
+	if (is_prefetch(regs, address, error_code))
 		return;
 
 	tsk->thread.cr2 = address;
--- linux/arch/i386/mm/init.c.orig	
+++ linux/arch/i386/mm/init.c	
@@ -437,7 +437,7 @@ static int __init noexec_setup(char *str
 __setup("noexec=", noexec_setup);
 
 #ifdef CONFIG_X86_PAE
-static int use_nx = 0;
+int nx_enabled = 0;
 
 static void __init set_nx(void)
 {
@@ -449,7 +449,7 @@ static void __init set_nx(void)
 			rdmsr(MSR_EFER, l, h);
 			l |= EFER_NX;
 			wrmsr(MSR_EFER, l, h);
-			use_nx = 1;
+			nx_enabled = 1;
 			__supported_pte_mask |= _PAGE_NX;
 		}
 	}
@@ -468,7 +468,7 @@ void __init paging_init(void)
 {
 #ifdef CONFIG_X86_PAE
 	set_nx();
-	if (use_nx)
+	if (nx_enabled)
 		printk("NX (Execute Disable) protection: active\n");
 #endif
 
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -41,6 +41,7 @@
  */
 #ifdef CONFIG_X86_PAE
 extern unsigned long long __supported_pte_mask;
+extern int nx_enabled;
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
@@ -48,6 +49,7 @@ typedef struct { unsigned long long pgpr
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define HPAGE_SHIFT	21
 #else
+#define nx_enabled 0
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;

--DBIVS5p969aUjpLe--
