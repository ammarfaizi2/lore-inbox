Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWF0SlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWF0SlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWF0SlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:41:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030256AbWF0SlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:41:01 -0400
Date: Tue, 27 Jun 2006 14:40:54 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: don't print out SMP info on UP kernels.
Message-ID: <20060627184054.GD7914@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On UP kernels, it's silly to print out info about SMP alternatives..

 SMP alternatives: switching to UP code
 Freeing SMP alternatives: 0k freed

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/arch/i386/kernel/alternative.c~	2006-06-20 13:44:40.000000000 -0400
+++ linux-2.6.17.noarch/arch/i386/kernel/alternative.c	2006-06-20 13:46:33.000000000 -0400
@@ -118,6 +118,7 @@ void apply_alternatives(struct alt_instr
 	}
 }
 
+#ifdef CONFIG_SMP
 static void alternatives_smp_save(struct alt_instr *start, struct alt_instr *end)
 {
 	struct alt_instr *a;
@@ -282,6 +283,8 @@ void alternatives_smp_switch(int smp)
 	}
 	spin_unlock_irqrestore(&smp_alt, flags);
 }
+#endif
+
 
 void __init alternative_instructions(void)
 {
@@ -290,6 +290,8 @@ void __init alternative_instructions(voi
 {
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
+#ifdef CONFIG_SMP
+
 	/* switch to patch-once-at-boottime-only mode and free the
 	 * tables in case we know the number of CPUs will never ever
 	 * change */
@@ -318,4 +322,5 @@ void __init alternative_instructions(voi
 					    _text, _etext);
 		alternatives_smp_switch(0);
 	}
+#endif
 }
--- linux-2.6.17.noarch/arch/i386/kernel/module.c~	2006-06-20 14:08:15.000000000 -0400
+++ linux-2.6.17.noarch/arch/i386/kernel/module.c	2006-06-20 14:08:56.000000000 -0400
@@ -125,6 +125,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		void *aseg = (void *)alt->sh_addr;
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
+#ifdef CONFIG_SMP
 	if (locks && text) {
 		void *lseg = (void *)locks->sh_addr;
 		void *tseg = (void *)text->sh_addr;
@@ -132,10 +133,13 @@ int module_finalize(const Elf_Ehdr *hdr,
 					    lseg, lseg + locks->sh_size,
 					    tseg, tseg + text->sh_size);
 	}
+#endif
 	return 0;
 }
 
 void module_arch_cleanup(struct module *mod)
 {
+#ifdef CONFIG_SMP
 	alternatives_smp_module_del(mod);
+#endif
 }

-- 
http://www.codemonkey.org.uk
