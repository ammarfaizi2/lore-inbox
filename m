Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWEKVHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWEKVHa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 17:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWEKVHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 17:07:30 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:11152 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1750717AbWEKVH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 17:07:29 -0400
Message-ID: <4463A78F.5030703@keyaccess.nl>
Date: Thu, 11 May 2006 23:07:27 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Gerd Hoffmann <kraxel@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SMP alternatives: skip with UP kernels.
References: <4461341B.7050602@keyaccess.nl> <4461B24A.7050805@suse.de> <4461D16A.3000301@keyaccess.nl> <44632A62.2020505@suse.de>
In-Reply-To: <44632A62.2020505@suse.de>
Content-Type: multipart/mixed;
 boundary="------------090608090409000108060703"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090608090409000108060703
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Gerd Hoffmann wrote:

[ depending on CONFIG_SMP ]

>> Okay, thanks. Yes, I agree such would make sense.
> 
> Patch below.  It simply returns in case the tables are empty and nothing
> is do to, thus avoids printing the confusing message.

It does avoid the message but well, that's also _all_ it avoids. Why do 
you want to do it this way? If I apply the attached, things compile and 
work fine which seems to confirm that, yes, all this smp_alternatives 
code is simply dead baggage on !CONFIG_SMP.

Yes, the #ifdef in arch/i386/kernel/module.c is a bit clumsy. Just proof 
of concept, might be abstracted out a bit better. It does lose most of 
alternatives.c which would seem to be good thing.

Unless I'm missing some points, I believe this code should not be 
compiled in for !CONFIG_SMP.

One other point, although probably not a relevant one. Your changes in 
module_finalize() potentially change behaviour. It used to be:

for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
	void *seg;
	if (strcmp(".altinstructions", secstrings + s->sh_name))
		continue;
	seg = (void *)s->sh_addr;
	apply_alternatives(seg, seg + s->sh_size);
}

which means that any .altinstructions section would be patched. It's now:

for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
	...
	if (!strcmp(".altinstructions", secstrings + s->sh_name))
		alt = s;
	...
}
if (alt) {
	/* patch .altinstructions */
	void *aseg = (void *)alt->sh_addr;
	apply_alternatives(aseg, aseg + alt->sh_size);
}

which means that only the last such section would. I suppose there's 
only one such section anyway, but not seeing a break in the original 
does make me wonder if this was originally done on purpose.

Rene.


--------------090608090409000108060703
Content-Type: text/plain;
 name="alternatives_no_smp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alternatives_no_smp.diff"

Index: local/arch/i386/kernel/alternative.c
===================================================================
--- local.orig/arch/i386/kernel/alternative.c	2006-05-11 20:28:56.000000000 +0200
+++ local/arch/i386/kernel/alternative.c	2006-05-11 20:32:24.000000000 +0200
@@ -118,6 +118,8 @@ void apply_alternatives(struct alt_instr
 	}
 }
 
+#ifdef CONFIG_SMP
+
 static void alternatives_smp_save(struct alt_instr *start, struct alt_instr *end)
 {
 	struct alt_instr *a;
@@ -283,10 +285,13 @@ void alternatives_smp_switch(int smp)
 	spin_unlock_irqrestore(&smp_alt, flags);
 }
 
+#endif /* CONFIG_SMP */
+
 void __init alternative_instructions(void)
 {
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
+#ifdef CONFIG_SMP
 	/* switch to patch-once-at-boottime-only mode and free the
 	 * tables in case we know the number of CPUs will never ever
 	 * change */
@@ -318,4 +323,5 @@ void __init alternative_instructions(voi
 					    _text, _etext);
 		alternatives_smp_switch(0);
 	}
+#endif
 }
Index: local/arch/i386/kernel/module.c
===================================================================
--- local.orig/arch/i386/kernel/module.c	2006-05-11 20:28:56.000000000 +0200
+++ local/arch/i386/kernel/module.c	2006-05-11 20:29:00.000000000 +0200
@@ -112,12 +112,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) { 
-		if (!strcmp(".text", secstrings + s->sh_name))
-			text = s;
 		if (!strcmp(".altinstructions", secstrings + s->sh_name))
 			alt = s;
+#ifdef CONFIG_SMP
 		if (!strcmp(".smp_locks", secstrings + s->sh_name))
 			locks= s;
+		if (!strcmp(".text", secstrings + s->sh_name))
+			text = s;
+#endif
 	}
 
 	if (alt) {
@@ -126,16 +128,20 @@ int module_finalize(const Elf_Ehdr *hdr,
 		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
 	if (locks && text) {
+#ifdef CONFIG_SMP
 		void *lseg = (void *)locks->sh_addr;
 		void *tseg = (void *)text->sh_addr;
 		alternatives_smp_module_add(me, me->name,
 					    lseg, lseg + locks->sh_size,
 					    tseg, tseg + text->sh_size);
+#endif
 	}
 	return 0;
 }
 
 void module_arch_cleanup(struct module *mod)
 {
+#ifdef CONFIG_SMP
 	alternatives_smp_module_del(mod);
+#endif
 }

--------------090608090409000108060703--
