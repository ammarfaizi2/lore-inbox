Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbUEWRyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUEWRyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 13:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUEWRyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 13:54:55 -0400
Received: from gprs214-26.eurotel.cz ([160.218.214.26]:24448 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263199AbUEWRyw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 13:54:52 -0400
Date: Sun, 23 May 2004 19:54:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp: fix swsusp with intel-agp
Message-ID: <20040523175444.GE804@elf.ucw.cz>
References: <20040521100734.GA31550@elf.ucw.cz> <20040521162044.7ad42db2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521162044.7ad42db2.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >
> > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > +	{
> > +		extern char swsusp_pg_dir[PAGE_SIZE];
> > +		memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
> > +	}
> > +#endif
> 
> Please move the declaration of swsusp_pg_dir[] to a header file where it is
> visible to both the users and the definition site, then resend.

Hmm, on second thought, it is accessed from one C file and once from
assembly => prototype should not be needed.

Upon popular request I made it depend on CONFIG_PM (pmdisk will need
it, too, and suspend2 wants it also). If you don't like that please
simply replace CONFIG_PM with CONFIG_SOFTWARE_SUSPEND...

								Pavel

--- clean/arch/i386/power/swsusp.S	2004-05-20 23:08:05.000000000 +0200
+++ linux/arch/i386/power/swsusp.S	2004-05-20 23:11:05.000000000 +0200
@@ -36,7 +38,7 @@
 	jmp .L1449
 	.p2align 4,,7
 .L1450:
-	movl $swapper_pg_dir-__PAGE_OFFSET,%ecx
+	movl $swsusp_pg_dir-__PAGE_OFFSET,%ecx
 	movl %ecx,%cr3
 
 	call do_magic_resume_1
--- clean/arch/i386/mm/init.c	2004-05-20 23:08:05.000000000 +0200
+++ linux/arch/i386/mm/init.c	2004-05-23 19:43:22.000000000 +0200
@@ -328,9 +328,20 @@
 #endif
 }
 
+#ifdef CONFIG_PM
+/* Swap suspend & friends need this for resume */
+char __nosavedata swsusp_pg_dir[PAGE_SIZE] 
+	__attribute__ ((aligned (PAGE_SIZE)));
+#endif
+
 void zap_low_mappings (void)
 {
 	int i;
+
+#ifdef CONFIG_PM
+	memcpy(swsusp_pg_dir, swapper_pg_dir, PAGE_SIZE);
+#endif
+
 	/*
 	 * Zap initial low-memory mappings.
 	 *


-- 
934a471f20d6580d5aad759bf0d97ddc
