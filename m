Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264473AbTLQRSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 12:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTLQRSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 12:18:18 -0500
Received: from 200-203-041-086.paemt7002.e.brasiltelecom.net.br ([200.203.41.86]:23104
	"EHLO einstein.tteng.com.br") by vger.kernel.org with ESMTP
	id S264473AbTLQRRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 12:17:55 -0500
Date: Wed, 17 Dec 2003 15:17:40 -0200
From: "Tiago Sant' Anna" <sapuglha@yahoo.com.br>
To: "Juliano F Silva" <julianofs@pop.com.br>
Cc: "Rusty Russell" <rusty@rustcorp.com.au>, <sisopiii-l@cscience.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: New feature: Removal of the exceptions wich belongs
 to  the init section
Message-Id: <20031217151740.186a9233.sapuglha@yahoo.com.br>
In-Reply-To: <006101c3c4c0$9f9e9140$a91f0a9b@poa.gerdau.net>
References: <20031201091853.2EC342C01B@lists.samba.org>
	<006101c3c4c0$9f9e9140$a91f0a9b@poa.gerdau.net>
Reply-To: sapuglha@yahoo.com.br
Organization: Mine ;)
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: %(]EDRrq\[:5'@@)M4YF3HZt-<qmLw4tL@[EYs]#%<E<^Z?o@08x]4+tlb8-bTvc4!wba,!Km3_U~LL$7]Kr>"-fMGf'/uJ{0P`JliRLVl+\bLTx}]%TsUA$t(4pi?U|G|!{:L=f94pjRucb^aw!%J;'z_HI9cke=>~h
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__17_Dec_2003_15_17_40_-0200_dn00eglkmge/Q+s+"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__17_Dec_2003_15_17_40_-0200_dn00eglkmge/Q+s+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

We're sorry, the patch sent in the last e-mail contains some debug stuff
inside. This new version is clean.

Maybe on Wed, 17 Dec 2003 14:10:08 -0300
Juliano F Silva wrote:

| Hi Rusty,
| 
| Tiago (sapuglha@yahoo.com.br) and I (julianofs@pop.com.br) fixed the patch
| as you suggested.
| 
| We would like to comment your citation below.
| 
| >This code is incorrect. The init section could be before or after the
| > core section, meaning that all the init-related exceptions will be at
| > the start, or at the end. So, the code would look like this:
| 
| In this patch we classify the exception table by an increasing order. So to
| verify if an exception belongs to the init section, we consider the address
| of the init section (module_init) until module_init + init_size. In this
| case, we believe that the address of the core section doesn't intervenes on
| the code.
| 
| Thanks a lot,
| 
| Juliano F. Silva and Tiago S. Silva
| 
| ----- Original Message ----- 
| From: "Rusty Russell" <rusty@rustcorp.com.au>
| To: "Tiago Sant' Anna" <sapuglha@yahoo.com.br>
| Cc: <sisopiii-l@cscience.org>; <linux-kernel@vger.kernel.org>;
| <julianofs@pop.com.br>
| Sent: Monday, December 01, 2003 3:03 AM
| Subject: Re: New feature: Removal of the exceptions wich belongs to the init
| section
| 
| 
| > In message <20031128155853.33283fec.sapuglha@yahoo.com.br> you write:
| > > Hello Rusty,
| >
| > Hi,
| >
| > > We, Juliano (julianofs@pop.com.br) and I (Tiago Sant' Anna
| > > (sapuglha@yahoo.com.br) developed this patch.
| >
| > I've commented on your patch: I hope you find my feedback
| > useful.
| >
| > > diff -Nur linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c
| linux-2.6.0-test9-modified/arch/alpha/mm/extable.c
| > > --- linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c 2003-10-25
| 16:42:52.000000000 -0200
| > > +++ linux-2.6.0-test9-modified/arch/alpha/mm/extable.c 2003-11-28
| 10:43:18.000000000 -0200
| > > @@ -27,3 +27,18 @@
| > >
| > >          return NULL;
| > >  }
| >
| > It's generally not a good idea to write code for architectures which
| > you don't have access to, but to leave them for arch maintainers to
| > sort out.
| >
| > > +/* Exception_table_entry Comparison. Only the field insn is considered.
| > > +   Results:
| > > + equal: 0
| > > + ex1 less than ex2: -1
| > > + ex1 major than ex2: 1
| > > +*/
| >
| > This comment is a little verbose: I would simply say:
| >
| > /* Compare two exception table entries: < 0 if ex1 comes before ex2. */
| >
| > > +int extable_cmp(const struct exception_table_entry ex1, const struct
| exception_table_entry ex2) {
| > > +
| > > + if (ex1.insn < ex2.insn)
| > > + return(-1);
| > > + else if (ex1.insn > ex2.insn)
| > > + return(1);
| > > + return(0);
| > > +}
| >
| > And it can be implemented as "return (long)ex1.insn - ex2.insn;",
| > making it a candidate for an inline function in the asm/uaccess.h
| > header.
| >
| > > +/* Verify if the addr belongs to the init section */
| > > +static inline int within_mod_init_section(unsigned long addr,
| > > +                                          void *start, unsigned long
| size)
| > > +{
| > > +     return ((void *)addr >= start && (void *)addr < start + size);
| > > +}
| > > +
| > > +/* Remove exception table entries that point to init area.
| > > + * It will be used in the unload of init section.
| > > + */
| > > +void remove_init_exceptions(struct module *mod) {
| >
| > This comment is not quite true.  The exception entries themselves are
| > in the __ex_table section, which is in the module code.  Some of the
| > "insn" pointers are into the module init section, which is to be
| > discarded.
| >
| > This function should be in kernel/extable.c.
| >
| > > +
| > > + static spinlock_t init_ex_remove = SPIN_LOCK_UNLOCKED;
| >
| > Do not invent your own lock.  You only need to protect against the
| > exception table walk by other CPUs, for which modlist_lock is
| > sufficient.
| >
| > > +
| > > + const struct exception_table_entry *local;
| > > + unsigned int i;
| > > + int num_init_ex=0;
| > > +
| > > +
| > > + local = mod->extable;
| > > + i = 1;
| > > +
| > > + while (i <= mod->num_exentries) {
| > > + if (within_mod_init_section((unsigned long) local->insn,
| mod->module_init, mod->init_size)) {
| > > + num_init_ex++;
| > > + }
| > > + else break;
| > > + local = local+1;
| > > + i++;
| > > + }
| > > +
| > > + local = mod->extable;
| >
| > This code is incorrect.  The init section could be before or after the
| > core section, meaning that all the init-related exceptions will be at
| > the start, or at the end.  So, the code would look like this:
| >
| > void remove_init_exceptions(struct module *mod)
| > {
| > int i;
| >
| > if (!mod->module_init)
| > return;
| >
| > spin_lock(&modlist_lock);
| > if (mod->module_init > mod->module_core) {
| > /* init exception entries at the end.  Trim */
| > for (i = mod->num_exentries-1; i >= 0; i--)
| > if (within(mod->extable[i].insn,
| >    mod->module_init, mod->init_size))
| > mod->num_exentries--;
| > } else {
| > /* init exception entries at the start.  Move ptr. */
| > for (i = 0; i < mod->num_exentries; i++) {
| > if (!within(mod->extable[i].insn,
| >     mod->module_init, mod->init_size))
| > break;
| > }
| > mod->extable += i;
| > mod->num_exentries -= i;
| > }
| > spin_nulock(&modlist_lock);
| > }
| >
| > > + /* Unload the init exceptions */
| > > + for(i=0; i < num_init_ex; ++i)
| > > + kfree(local+i);
| >
| > This doesn't make sense: these are not pointers, but are part of
| > module->core!  They will be freed in the normal way.
| >
| > >  /* Free memory returned from module_alloc */
| > >  void module_free(struct module *mod, void *module_region)
| > > -{
| > > +{
| > > + /* Remove exception entries of the init section */
| > > + if (module_region == mod->module_init) {
| > > + remove_init_exceptions(mod);
| > > + }
| > > +
| >
| > Call this from kernel/module.c directly.
| >
| > > +++ linux-2.6.0-test9-modified/include/linux/extable.h 2003-11-28 10:4
| > 0:57.000000000 -0200
| > > @@ -0,0 +1,51 @@
| > > +#ifndef _EXTABLE_H
| > > +#define _EXTABLE_H
| > > +
| > > +/*
| > > + * Functions regarding to exception's table.
| > > + *
| > > + * * Written by Juliano Silva and Tiago Silva, 2003
| > > + *
| > > + **/
| > > +
| > > +
| > > +#include <linux/module.h>
| > > +#include <asm/uaccess.h>
| > > +#include <asm/sections.h>
| > > +#include <linux/init.h>
| > > +
| > > +/* Exception_table_entry Comparison. Only the field insn is considered.
| > > + *   Results:
| > > + *            equal: 0
| > > + *            ex1 less than ex2: -1
| > > + *            ex1 major than ex2: 1
| > > + *                                                         */
| > > +extern int extable_cmp(struct exception_table_entry ex1,
| > > +                       struct exception_table_entry ex2);
| > > +
| > > +/* This code sorts an exception table. It is very used with modules
| code
| > > + * void __init_or_module sort_ex_table(struct exception_table_entry
| *start,
| > > + * struct exception_table_entry *finish);
| > > + */
| > > +void __init_or_module sort_ex_table(struct exception_table_entry
| *start, struct exception_table_entry *finish)
| >
| > Never put non-inline functions in a header file.  And never inline a
| > function this large.
| >
| > Since this is only called from module.c, perhaps put it in
| > include/linux/moduleloader.h and the code in extable.c.
| >
| > Hope that helps,
| > Rusty.
| > --
| >   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
| >
| 


-- 
 
=> Tiago Sant' Anna - UIN: 14252973 - Linux user #136940
	[.. ..]

--Multipart=_Wed__17_Dec_2003_15_17_40_-0200_dn00eglkmge/Q+s+
Content-Type: text/plain;
 name="patch-init_exceptions_removal-version3-test11.diff"
Content-Disposition: attachment;
 filename="patch-init_exceptions_removal-version3-test11.diff"
Content-Transfer-Encoding: 7bit

diff -Nur linux-2.6.0-test11/arch/i386/kernel/module.c linux-2.6.0-test11-modified/arch/i386/kernel/module.c
--- linux-2.6.0-test11/arch/i386/kernel/module.c	2003-11-26 18:44:07.000000000 -0200
+++ linux-2.6.0-test11-modified/arch/i386/kernel/module.c	2003-12-02 15:17:46.000000000 -0200
@@ -35,13 +35,10 @@
 	return vmalloc(size);
 }
 
-
 /* Free memory returned from module_alloc */
 void module_free(struct module *mod, void *module_region)
-{
+{	
 	vfree(module_region);
-	/* FIXME: If module_region == mod->init_region, trim exception
-           table entries. */
 }
 
 /* We don't need anything special. */
diff -Nur linux-2.6.0-test11/include/asm-i386/uaccess.h linux-2.6.0-test11-modified/include/asm-i386/uaccess.h
--- linux-2.6.0-test11/include/asm-i386/uaccess.h	2003-11-26 18:43:07.000000000 -0200
+++ linux-2.6.0-test11-modified/include/asm-i386/uaccess.h	2003-12-02 15:10:52.000000000 -0200
@@ -123,6 +123,15 @@
 	unsigned long insn, fixup;
 };
 
+/* Compare two exception table entries: < 0 if ex1 comes before ex2 */
+static inline int extable_cmp(const struct exception_table_entry ex1, 
+                const struct exception_table_entry ex2)
+{
+	return (long)ex1.insn - ex2.insn;
+}           
+
+
+
 extern int fixup_exception(struct pt_regs *regs);
 
 /*
diff -Nur linux-2.6.0-test11/include/linux/moduleloader.h linux-2.6.0-test11-modified/include/linux/moduleloader.h
--- linux-2.6.0-test11/include/linux/moduleloader.h	2003-11-26 18:43:40.000000000 -0200
+++ linux-2.6.0-test11-modified/include/linux/moduleloader.h	2003-12-02 15:10:52.000000000 -0200
@@ -44,4 +44,8 @@
 /* Any cleanup needed when module leaves. */
 void module_arch_cleanup(struct module *mod);
 
+/* This code sorts an exception table. It is very used with modules code */
+void sort_ex_table(struct exception_table_entry *start,
+                   struct exception_table_entry *finish);
+
 #endif
diff -Nur linux-2.6.0-test11/kernel/extable.c linux-2.6.0-test11-modified/kernel/extable.c
--- linux-2.6.0-test11/kernel/extable.c	2003-11-26 18:43:32.000000000 -0200
+++ linux-2.6.0-test11-modified/kernel/extable.c	2003-12-02 15:10:52.000000000 -0200
@@ -19,6 +19,8 @@
 #include <asm/uaccess.h>
 #include <asm/sections.h>
 
+#include <linux/moduleloader.h>
+
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
 
@@ -45,3 +47,26 @@
 
 	return module_text_address(addr) != NULL;
 }
+
+
+void sort_ex_table(struct exception_table_entry *start, struct exception_table_entry *finish)
+{
+	struct exception_table_entry el, *p, *q;
+		
+	/* insertion sort */
+	for (p = start + 1; p < finish; ++p) {
+		/* start .. p-1 is sorted */
+		if (extable_cmp(p[0], p[-1]) == -1) {
+		/* move element p down to its right place */
+			el = *p;
+			q = p;
+			do {
+				/* el comes before q[-1], move q[-1] up one */
+				q[0] = q[-1];
+				--q;
+			} while (q > start && extable_cmp(el, q[-1]) == -1);
+				*q = el;
+		}
+	}
+}
+							
diff -Nur linux-2.6.0-test11/kernel/module.c linux-2.6.0-test11-modified/kernel/module.c
--- linux-2.6.0-test11/kernel/module.c	2003-11-26 18:44:57.000000000 -0200
+++ linux-2.6.0-test11-modified/kernel/module.c	2003-12-02 15:10:52.000000000 -0200
@@ -1076,6 +1076,42 @@
 	return ret;
 }
 
+static inline int within(unsigned long addr, void *start, unsigned long size)
+{
+	return ((void *)addr >= start && (void *)addr < start + size);
+}
+
+/* Remove exception table entries which belongs to this module's init area */
+void remove_init_exceptions(struct module *mod) 
+{
+	const struct exception_table_entry *local;
+	unsigned int i;
+	int num_init_ex=0;
+
+	if (!mod->module_init)
+		return;
+
+	local = mod->extable;
+	i = 1;
+	while (i <= mod->num_exentries) {
+		if (within((unsigned long) local->insn, mod->module_init, 
+		            mod->init_size)) {
+			num_init_ex++;
+		}
+		else break;
+		local = local+1;
+		i++;
+	}
+
+	/* Move the pointer to remove the init exceptions */
+	spin_lock(&modlist_lock);
+		mod->extable += num_init_ex;
+		mod->num_exentries -= num_init_ex;
+	spin_unlock(&modlist_lock);
+}
+
+
+
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
@@ -1615,6 +1651,11 @@
 	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
 	mod->extable = (void *)sechdrs[exindex].sh_addr;
 
+        /* Classifying the exception table */
+        sort_ex_table((struct exception_table_entry *)mod->extable,
+                      (struct exception_table_entry *)mod->extable +
+                                mod->num_exentries);
+
 	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
 		const char *strtab = (char *)sechdrs[strindex].sh_addr;
@@ -1753,6 +1794,7 @@
 	mod->state = MODULE_STATE_LIVE;
 	/* Drop initial reference. */
 	module_put(mod);
+	remove_init_exceptions(mod);
 	module_free(mod, mod->module_init);
 	mod->module_init = NULL;
 	mod->init_size = 0;
@@ -1762,11 +1804,6 @@
 	return 0;
 }
 
-static inline int within(unsigned long addr, void *start, unsigned long size)
-{
-	return ((void *)addr >= start && (void *)addr < start + size);
-}
-
 #ifdef CONFIG_KALLSYMS
 static const char *get_ksymbol(struct module *mod,
 			       unsigned long addr,

--Multipart=_Wed__17_Dec_2003_15_17_40_-0200_dn00eglkmge/Q+s+--
