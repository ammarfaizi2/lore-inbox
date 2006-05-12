Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWELLlS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWELLlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 07:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWELLlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 07:41:18 -0400
Received: from ns2.suse.de ([195.135.220.15]:52970 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751239AbWELLlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 07:41:17 -0400
Message-ID: <44647454.3050800@suse.de>
Date: Fri, 12 May 2006 13:41:08 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SMP alternatives: skip with UP kernels.
References: <4461341B.7050602@keyaccess.nl> <4461B24A.7050805@suse.de> <4461D16A.3000301@keyaccess.nl> <44632A62.2020505@suse.de> <4463A78F.5030703@keyaccess.nl>
In-Reply-To: <4463A78F.5030703@keyaccess.nl>
Content-Type: multipart/mixed;
 boundary="------------040102010707080205010104"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040102010707080205010104
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit

>> Patch below.  It simply returns in case the tables are empty and nothing
>> is do to, thus avoids printing the confusing message.
> 
> It does avoid the message but well, that's also _all_ it avoids. Why do
> you want to do it this way?  [ ... patch ... ]
> 
> Yes, the #ifdef in arch/i386/kernel/module.c is a bit clumsy.

Yep, thats why.  I wanted avoid exactly that.  Having some code need to
know that function foobar() is only available with CONFIG_BAZ is set is
really ugly ...

The attached patch hides the magic in alternative.h and provides some
dummy inline functions for the UP case (gcc should manage to optimize
away these calls).  No changes in module.c.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
Erst mal heiraten, ein, zwei Kinder, und wenn alles läuft
geh' ich nach drei Jahren mit der Familie an die Börse.
http://www.suse.de/~kraxel/julika-dora.jpeg

--------------040102010707080205010104
Content-Type: text/plain;
 name="ifdef-smp-alts"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ifdef-smp-alts"

Index: vanilla-2.6.17-rc3-mm1/arch/i386/kernel/alternative.c
===================================================================
--- vanilla-2.6.17-rc3-mm1.orig/arch/i386/kernel/alternative.c	2006-05-10 12:25:39.000000000 +0200
+++ vanilla-2.6.17-rc3-mm1/arch/i386/kernel/alternative.c	2006-05-12 10:03:40.000000000 +0200
@@ -168,6 +168,8 @@ void apply_alternatives(struct alt_instr
 	}
 }
 
+#ifdef CONFIG_SMP
+
 static void alternatives_smp_save(struct alt_instr *start, struct alt_instr *end)
 {
 	struct alt_instr *a;
@@ -328,6 +330,8 @@ void alternatives_smp_switch(int smp)
 	spin_unlock_irqrestore(&smp_alt, flags);
 }
 
+#endif
+
 void __init alternative_instructions(void)
 {
 	if (no_replacement) {
@@ -349,6 +353,7 @@ void __init alternative_instructions(voi
 	smp_alt_once = 1;
 #endif
 
+#ifdef CONFIG_SMP
 	if (smp_alt_once) {
 		if (1 == num_possible_cpus()) {
 			printk(KERN_INFO "SMP alternatives: switching to UP code\n");
@@ -370,4 +375,5 @@ void __init alternative_instructions(voi
 					    _text, _etext);
 		alternatives_smp_switch(0);
 	}
+#endif
 }
Index: vanilla-2.6.17-rc3-mm1/include/asm-i386/alternative.h
===================================================================
--- vanilla-2.6.17-rc3-mm1.orig/include/asm-i386/alternative.h	2006-05-09 18:56:14.000000000 +0200
+++ vanilla-2.6.17-rc3-mm1/include/asm-i386/alternative.h	2006-05-12 10:06:28.000000000 +0200
@@ -17,11 +17,19 @@ struct alt_instr {
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 
 struct module;
+#ifdef CONFIG_SMP
 extern void alternatives_smp_module_add(struct module *mod, char *name,
 					void *locks, void *locks_end,
 					void *text, void *text_end);
 extern void alternatives_smp_module_del(struct module *mod);
 extern void alternatives_smp_switch(int smp);
+#else
+static inline void alternatives_smp_module_add(struct module *mod, char *name,
+					void *locks, void *locks_end,
+					void *text, void *text_end) {}
+static inline void alternatives_smp_module_del(struct module *mod) {}
+static inline void alternatives_smp_switch(int smp) {}
+#endif
 
 #endif
 
Index: vanilla-2.6.17-rc3-mm1/include/asm-x86_64/alternative.h
===================================================================
--- vanilla-2.6.17-rc3-mm1.orig/include/asm-x86_64/alternative.h	2006-05-09 18:56:14.000000000 +0200
+++ vanilla-2.6.17-rc3-mm1/include/asm-x86_64/alternative.h	2006-05-12 10:05:26.000000000 +0200
@@ -17,11 +17,20 @@ struct alt_instr {
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 
 struct module;
+
+#ifdef CONFIG_SMP
 extern void alternatives_smp_module_add(struct module *mod, char *name,
 					void *locks, void *locks_end,
 					void *text, void *text_end);
 extern void alternatives_smp_module_del(struct module *mod);
 extern void alternatives_smp_switch(int smp);
+#else
+static inline void alternatives_smp_module_add(struct module *mod, char *name,
+					void *locks, void *locks_end,
+					void *text, void *text_end) {}
+static inline void alternatives_smp_module_del(struct module *mod) {}
+static inline void alternatives_smp_switch(int smp) {}
+#endif
 
 #endif
 

--------------040102010707080205010104--
