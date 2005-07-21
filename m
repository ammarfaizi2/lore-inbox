Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVGUKnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVGUKnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 06:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbVGUKnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 06:43:55 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:55556 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261736AbVGUKny
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 06:43:54 -0400
Message-ID: <42DF7C52.4020907@stud.feec.vutbr.cz>
Date: Thu, 21 Jul 2005 12:43:30 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, Andreas Steinmetz <ast@domdv.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
References: <42DD67D9.60201@stud.feec.vutbr.cz> <42DD6AA7.40409@domdv.de> <42DD7011.6080201@stud.feec.vutbr.cz> <200507201115.08733.rjw@sisk.pl> <42DECB21.5020903@stud.feec.vutbr.cz> <20050721053126.GB5230@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050721053126.GB5230@atrey.karlin.mff.cuni.cz>
Content-Type: multipart/mixed;
 boundary="------------040706070800070802000904"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040706070800070802000904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> Long time ago there were i386 problems because we assumed that kernel
> is mapped in one big mapping and agp broke that assumption. Copying
> pages backwards "fixed" it (and then we done proper fix). It should
> not be, but it seems similar to this problem....

Do you mean this patch of yours?:
http://www.ussg.iu.edu/hypermail/linux/kernel/0404.3/0640.html

I'm trying to do something similar for x86_64. See the attached patch.
Unfortunately, it doesn't help. The behaviour seems unchanged (resume 
still works iff amd64-agp wasn't loaded before suspend).

Michal

--------------040706070800070802000904
Content-Type: text/x-patch;
 name="swsusp-amd64-pgdir.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="swsusp-amd64-pgdir.diff"

diff -Nurp -X dontdiff.new linux-mm/arch/x86_64/kernel/suspend_asm.S linux-mm.mich/arch/x86_64/kernel/suspend_asm.S
--- linux-mm/arch/x86_64/kernel/suspend_asm.S	2005-06-30 01:00:53.000000000 +0200
+++ linux-mm.mich/arch/x86_64/kernel/suspend_asm.S	2005-07-21 11:53:17.000000000 +0200
@@ -41,7 +41,7 @@ ENTRY(swsusp_arch_suspend)
 
 ENTRY(swsusp_arch_resume)
 	/* set up cr3 */	
-	leaq	init_level4_pgt(%rip),%rax
+	leaq	swsusp_level4_pgt(%rip),%rax
 	subq	$__START_KERNEL_map,%rax
 	movq	%rax,%cr3
 
diff -Nurp -X dontdiff.new linux-mm/arch/x86_64/mm/init.c linux-mm.mich/arch/x86_64/mm/init.c
--- linux-mm/arch/x86_64/mm/init.c	2005-07-18 19:48:12.000000000 +0200
+++ linux-mm.mich/arch/x86_64/mm/init.c	2005-07-21 11:21:36.000000000 +0200
@@ -310,10 +310,32 @@ void __init init_memory_mapping(unsigned
 
 extern struct x8664_pda cpu_pda[NR_CPUS];
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/*
+ * Swap suspend & friends need this for resume because things like the intel-agp
+ * driver might have split up a kernel 4MB mapping.
+ */
+char __nosavedata swsusp_level4_pgt[PAGE_SIZE]
+	__attribute__ ((aligned (PAGE_SIZE)));
+
+static inline void save_pg_dir(void)
+{
+	memcpy(swsusp_level4_pgt, init_level4_pgt, PAGE_SIZE);
+}
+#else
+static inline void save_pg_dir(void)
+{
+}
+#endif
+
 /* Assumes all CPUs still execute in init_mm */
 void zap_low_mappings(void)
 {
-	pgd_t *pgd = pgd_offset_k(0UL);
+	pgd_t *pgd;
+
+	save_pg_dir();
+
+	pgd = pgd_offset_k(0UL);
 	pgd_clear(pgd);
 	flush_tlb_all();
 }

--------------040706070800070802000904--
