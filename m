Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264040AbUD0Msz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbUD0Msz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 08:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbUD0Msz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 08:48:55 -0400
Received: from gprs214-177.eurotel.cz ([160.218.214.177]:21377 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S264040AbUD0Msw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 08:48:52 -0400
Date: Tue, 27 Apr 2004 14:48:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>, seife@suse.de
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Nigel Cunningham <ncunningham@linuxmail.com>,
       Roland Stigge <stigge@antcom.de>, 234976@bugs.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug#234976: kernel-source-2.6.4: Software Suspend doesn't work
Message-ID: <20040427124837.GK10593@elf.ucw.cz>
References: <1080317555.12244.5.camel@atari.stigge.org> <20040326161717.GE291@elf.ucw.cz> <1080325072.2112.89.camel@atari.stigge.org> <20040426094834.GA4901@gondor.apana.org.au> <20040426104015.GA5772@gondor.apana.org.au> <opr6193np1ruvnp2@laptop-linux.wpcb.org.au> <20040426131152.GN2595@openzaurus.ucw.cz> <1083048985.12517.21.camel@gaston> <20040427102127.GB10593@elf.ucw.cz> <20040427102344.GA24313@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427102344.GA24313@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This should be better solution, could anyone test it? [It compiles,
and I'm out of time now].

							Pavel

--- tmp/linux/arch/i386/mm/init.c	2004-04-05 10:45:11.000000000 +0200
+++ linux/arch/i386/mm/init.c	2004-04-27 14:44:00.000000000 +0200
@@ -343,6 +343,12 @@
 #else
 		set_pgd(swapper_pg_dir+i, __pgd(0));
 #endif
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	{
+		extern char swsusp_pg_dir[PAGE_SIZE];
+		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
+	}
+#endif
 	flush_tlb_all();
 }
 
--- tmp/linux/arch/i386/power/cpu.c	2003-09-28 22:05:30.000000000 +0200
+++ linux/arch/i386/power/cpu.c	2004-04-27 14:44:03.000000000 +0200
@@ -35,6 +35,9 @@
 unsigned long saved_context_esi, saved_context_edi;
 unsigned long saved_context_eflags;
 
+/* Special page directory for resume */
+char swsusp_pg_dir[PAGE_SIZE];
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

-- 
934a471f20d6580d5aad759bf0d97ddc
