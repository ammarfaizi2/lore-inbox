Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUD0Vxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUD0Vxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbUD0VxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 17:53:22 -0400
Received: from gprs214-199.eurotel.cz ([160.218.214.199]:24448 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264371AbUD0VxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 17:53:06 -0400
Date: Tue, 27 Apr 2004 23:52:36 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>, Andrew Morton <akpm@zip.com.au>
Cc: seife@suse.de, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427215236.GA469@elf.ucw.cz>
References: <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au> <20040427124837.GK10593@elf.ucw.cz> <20040427125402.GA16740@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427125402.GA16740@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > --- tmp/linux/arch/i386/power/cpu.c	2003-09-28 22:05:30.000000000 +0200
> > +++ linux/arch/i386/power/cpu.c	2004-04-27 14:44:03.000000000 +0200
> > @@ -35,6 +35,9 @@
> >  unsigned long saved_context_esi, saved_context_edi;
> >  unsigned long saved_context_eflags;
> >  
> > +/* Special page directory for resume */
> > +char swsusp_pg_dir[PAGE_SIZE];
> > +
> 
> You forgot to mark this as nosave.

More importantly, I forgot to mark it as aligned on PAGE_SIZE. Oops
(er... double fault). Here's fixed patch, and this one should work.

Andrew, the crashes with intel-agp were not driver fault after
all. swsusp assumed 4MB pages, and intel-agp driver broke 4MB page
down, resulting in nasty crash.

Herbert's solution was to copy memory backwards, and avoid the crash
by luck (But thanks a lot for explaining me the problem!).

Non-PSE cpus are still not supported; but it should be easier when we
are running in pagedir with identity-mapped pages.

This solution copies page table at boot, where it is "known good",
still 4MB. Could you apply it?

								Pavel

--- tmp/linux/arch/i386/mm/init.c	2004-04-05 10:45:11.000000000 +0200
+++ linux/arch/i386/mm/init.c	2004-04-27 23:39:07.000000000 +0200
@@ -331,6 +331,13 @@
 void zap_low_mappings (void)
 {
 	int i;
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	{
+		extern char swsusp_pg_dir[PAGE_SIZE];
+		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
+	}
+#endif
 	/*
 	 * Zap initial low-memory mappings.
 	 *
--- tmp/linux/arch/i386/power/cpu.c	2003-09-28 22:05:30.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-04-27 23:41:01.000000000 +0200
@@ -35,6 +35,10 @@
 unsigned long saved_context_esi, saved_context_edi;
 unsigned long saved_context_eflags;
 
+/* Special page directory for resume */
+char __nosavedata swsusp_pg_dir[PAGE_SIZE]
+                  __attribute__ ((aligned (PAGE_SIZE)));
+
 extern void enable_sep_cpu(void *);
 
 void save_processor_state(void)
--- tmp/linux/arch/i386/power/swsusp.S	2003-09-28 22:05:30.000000000 +0200
+++ linux/arch/i386/power/swsusp.S	2004-04-27 14:41:54.000000000 +0200
@@ -29,7 +38,7 @@
 	jmp .L1449
 	.p2align 4,,7
 .L1450:
-	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
+	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
 	call do_magic_resume_1
--- tmp/linux/include/asm-i386/suspend.h	2003-09-28 22:06:36.000000000 +0200
+++ linux/include/asm-i386/suspend.h	2004-04-27 23:10:24.000000000 +0200
@@ -9,6 +9,9 @@
 static inline int
 arch_prepare_suspend(void)
 {
+	/* If you want to make non-PSE machine work, turn off paging
+           in do_magic. swsusp_pg_dir should have identity mapping, so
+           it could work...  */
 	if (!cpu_has_pse)
 		return -EPERM;
 	return 0;

-- 
934a471f20d6580d5aad759bf0d97ddc
