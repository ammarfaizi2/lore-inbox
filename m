Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbTABKmX>; Thu, 2 Jan 2003 05:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261321AbTABKmX>; Thu, 2 Jan 2003 05:42:23 -0500
Received: from dp.samba.org ([66.70.73.150]:35049 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261302AbTABKmU>;
	Thu, 2 Jan 2003 05:42:20 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] Modules 3/3: Sort sections 
In-reply-to: Your message of "Wed, 01 Jan 2003 20:54:04 -0800."
             <20030101205404.B30272@twiddle.net> 
Date: Thu, 02 Jan 2003 21:48:42 +1100
Message-Id: <20030102105049.E532D2C267@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030101205404.B30272@twiddle.net> you write:
> On Thu, Jan 02, 2003 at 02:00:27PM +1100, Rusty Russell wrote:
> > +	/* Find .plt and .pltinit sections */
> 
> Typo.
> 
> > +/* Make empty sections for module_frob_arch_sections to expand. */
> > +#ifdef MODULE
> > +asm(".section .plt,\"aws\",@nobits; .align 3; .previous");
> > +asm(".section .plt.init,\"aws\",@nobits; .align 3; .previous");
> 
> Should use "ax", do make the plt sections executable,
> since the plt section contains code that branches.
> Additionally, this will place the .plt section next
> to .text, which improves icache usage, and minimizes
> the branch distance.

OK, and I've renamed it to .init.plt, too.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.54/arch/ppc/kernel/module.c working-2.5.54-ppcfix/arch/ppc/kernel/module.c
--- linux-2.5.54/arch/ppc/kernel/module.c	2003-01-02 14:47:57.000000000 +1100
+++ working-2.5.54-ppcfix/arch/ppc/kernel/module.c	2003-01-02 21:46:31.000000000 +1100
@@ -108,15 +108,15 @@ int module_frob_arch_sections(Elf32_Ehdr
 {
 	unsigned int i;
 
-	/* Find .plt and .pltinit sections */
+	/* Find .plt and .init.plt sections */
 	for (i = 0; i < hdr->e_shnum; i++) {
-		if (strcmp(secstrings + sechdrs[i].sh_name, ".plt.init") == 0)
+		if (strcmp(secstrings + sechdrs[i].sh_name, ".init.plt") == 0)
 			me->arch.init_plt_section = i;
 		else if (strcmp(secstrings + sechdrs[i].sh_name, ".plt") == 0)
 			me->arch.core_plt_section = i;
 	}
 	if (!me->arch.core_plt_section || !me->arch.init_plt_section) {
-		printk("Module doesn't contain .plt or .plt.init sections.\n");
+		printk("Module doesn't contain .plt or .init.plt sections.\n");
 		return -ENOEXEC;
 	}
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.54/include/asm-ppc/module.h working-2.5.54-ppcfix/include/asm-ppc/module.h
--- linux-2.5.54/include/asm-ppc/module.h	2003-01-02 14:48:00.000000000 +1100
+++ working-2.5.54-ppcfix/include/asm-ppc/module.h	2003-01-02 21:46:38.000000000 +1100
@@ -28,7 +28,7 @@ struct mod_arch_specific
 
 /* Make empty sections for module_frob_arch_sections to expand. */
 #ifdef MODULE
-asm(".section .plt,\"aws\",@nobits; .align 3; .previous");
-asm(".section .plt.init,\"aws\",@nobits; .align 3; .previous");
+asm(".section .plt,\"ax\",@nobits; .align 3; .previous");
+asm(".section .init.plt,\"ax\",@nobits; .align 3; .previous");
 #endif
 #endif /* _ASM_PPC_MODULE_H */
