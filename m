Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264461AbTLQQKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 11:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264462AbTLQQKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 11:10:53 -0500
Received: from smtp.gerdau.com.br ([200.213.29.35]:25102 "EHLO
	smtp.gerdau.com.br") by vger.kernel.org with ESMTP id S264461AbTLQQKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 11:10:34 -0500
Message-ID: <006101c3c4c0$9f9e9140$a91f0a9b@poa.gerdau.net>
From: "Juliano F Silva" <julianofs@pop.com.br>
To: "Rusty Russell" <rusty@rustcorp.com.au>,
       "Tiago Sant' Anna" <sapuglha@yahoo.com.br>
Cc: <sisopiii-l@cscience.org>, <linux-kernel@vger.kernel.org>
References: <20031201091853.2EC342C01B@lists.samba.org>
Subject: [PATCH] Re: New feature: Removal of the exceptions wich belongs to 
	the init section 
Date: Wed, 17 Dec 2003 14:10:08 -0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_005E_01C3C4A7.7A29AD00"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Baseline:47.9668 C:21 M:1 S:5 R:5
X-imss-settings: Clean:1 C:1 M:1 S:4 R:4 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_005E_01C3C4A7.7A29AD00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi Rusty,

Tiago (sapuglha@yahoo.com.br) and I (julianofs@pop.com.br) fixed the patch
as you suggested.

We would like to comment your citation below.

>This code is incorrect. The init section could be before or after the
> core section, meaning that all the init-related exceptions will be at
> the start, or at the end. So, the code would look like this:

In this patch we classify the exception table by an increasing order. So to
verify if an exception belongs to the init section, we consider the address
of the init section (module_init) until module_init + init_size. In this
case, we believe that the address of the core section doesn't intervenes on
the code.

Thanks a lot,

Juliano F. Silva and Tiago S. Silva

----- Original Message ----- 
From: "Rusty Russell" <rusty@rustcorp.com.au>
To: "Tiago Sant' Anna" <sapuglha@yahoo.com.br>
Cc: <sisopiii-l@cscience.org>; <linux-kernel@vger.kernel.org>;
<julianofs@pop.com.br>
Sent: Monday, December 01, 2003 3:03 AM
Subject: Re: New feature: Removal of the exceptions wich belongs to the init
section


> In message <20031128155853.33283fec.sapuglha@yahoo.com.br> you write:
> > Hello Rusty,
>
> Hi,
>
> > We, Juliano (julianofs@pop.com.br) and I (Tiago Sant' Anna
> > (sapuglha@yahoo.com.br) developed this patch.
>
> I've commented on your patch: I hope you find my feedback
> useful.
>
> > diff -Nur linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c
linux-2.6.0-test9-modified/arch/alpha/mm/extable.c
> > --- linux-2.6.0-test9-vanilla/arch/alpha/mm/extable.c 2003-10-25
16:42:52.000000000 -0200
> > +++ linux-2.6.0-test9-modified/arch/alpha/mm/extable.c 2003-11-28
10:43:18.000000000 -0200
> > @@ -27,3 +27,18 @@
> >
> >          return NULL;
> >  }
>
> It's generally not a good idea to write code for architectures which
> you don't have access to, but to leave them for arch maintainers to
> sort out.
>
> > +/* Exception_table_entry Comparison. Only the field insn is considered.
> > +   Results:
> > + equal: 0
> > + ex1 less than ex2: -1
> > + ex1 major than ex2: 1
> > +*/
>
> This comment is a little verbose: I would simply say:
>
> /* Compare two exception table entries: < 0 if ex1 comes before ex2. */
>
> > +int extable_cmp(const struct exception_table_entry ex1, const struct
exception_table_entry ex2) {
> > +
> > + if (ex1.insn < ex2.insn)
> > + return(-1);
> > + else if (ex1.insn > ex2.insn)
> > + return(1);
> > + return(0);
> > +}
>
> And it can be implemented as "return (long)ex1.insn - ex2.insn;",
> making it a candidate for an inline function in the asm/uaccess.h
> header.
>
> > +/* Verify if the addr belongs to the init section */
> > +static inline int within_mod_init_section(unsigned long addr,
> > +                                          void *start, unsigned long
size)
> > +{
> > +     return ((void *)addr >= start && (void *)addr < start + size);
> > +}
> > +
> > +/* Remove exception table entries that point to init area.
> > + * It will be used in the unload of init section.
> > + */
> > +void remove_init_exceptions(struct module *mod) {
>
> This comment is not quite true.  The exception entries themselves are
> in the __ex_table section, which is in the module code.  Some of the
> "insn" pointers are into the module init section, which is to be
> discarded.
>
> This function should be in kernel/extable.c.
>
> > +
> > + static spinlock_t init_ex_remove = SPIN_LOCK_UNLOCKED;
>
> Do not invent your own lock.  You only need to protect against the
> exception table walk by other CPUs, for which modlist_lock is
> sufficient.
>
> > +
> > + const struct exception_table_entry *local;
> > + unsigned int i;
> > + int num_init_ex=0;
> > +
> > +
> > + local = mod->extable;
> > + i = 1;
> > +
> > + while (i <= mod->num_exentries) {
> > + if (within_mod_init_section((unsigned long) local->insn,
mod->module_init, mod->init_size)) {
> > + num_init_ex++;
> > + }
> > + else break;
> > + local = local+1;
> > + i++;
> > + }
> > +
> > + local = mod->extable;
>
> This code is incorrect.  The init section could be before or after the
> core section, meaning that all the init-related exceptions will be at
> the start, or at the end.  So, the code would look like this:
>
> void remove_init_exceptions(struct module *mod)
> {
> int i;
>
> if (!mod->module_init)
> return;
>
> spin_lock(&modlist_lock);
> if (mod->module_init > mod->module_core) {
> /* init exception entries at the end.  Trim */
> for (i = mod->num_exentries-1; i >= 0; i--)
> if (within(mod->extable[i].insn,
>    mod->module_init, mod->init_size))
> mod->num_exentries--;
> } else {
> /* init exception entries at the start.  Move ptr. */
> for (i = 0; i < mod->num_exentries; i++) {
> if (!within(mod->extable[i].insn,
>     mod->module_init, mod->init_size))
> break;
> }
> mod->extable += i;
> mod->num_exentries -= i;
> }
> spin_nulock(&modlist_lock);
> }
>
> > + /* Unload the init exceptions */
> > + for(i=0; i < num_init_ex; ++i)
> > + kfree(local+i);
>
> This doesn't make sense: these are not pointers, but are part of
> module->core!  They will be freed in the normal way.
>
> >  /* Free memory returned from module_alloc */
> >  void module_free(struct module *mod, void *module_region)
> > -{
> > +{
> > + /* Remove exception entries of the init section */
> > + if (module_region == mod->module_init) {
> > + remove_init_exceptions(mod);
> > + }
> > +
>
> Call this from kernel/module.c directly.
>
> > +++ linux-2.6.0-test9-modified/include/linux/extable.h 2003-11-28 10:4
> 0:57.000000000 -0200
> > @@ -0,0 +1,51 @@
> > +#ifndef _EXTABLE_H
> > +#define _EXTABLE_H
> > +
> > +/*
> > + * Functions regarding to exception's table.
> > + *
> > + * * Written by Juliano Silva and Tiago Silva, 2003
> > + *
> > + **/
> > +
> > +
> > +#include <linux/module.h>
> > +#include <asm/uaccess.h>
> > +#include <asm/sections.h>
> > +#include <linux/init.h>
> > +
> > +/* Exception_table_entry Comparison. Only the field insn is considered.
> > + *   Results:
> > + *            equal: 0
> > + *            ex1 less than ex2: -1
> > + *            ex1 major than ex2: 1
> > + *                                                         */
> > +extern int extable_cmp(struct exception_table_entry ex1,
> > +                       struct exception_table_entry ex2);
> > +
> > +/* This code sorts an exception table. It is very used with modules
code
> > + * void __init_or_module sort_ex_table(struct exception_table_entry
*start,
> > + * struct exception_table_entry *finish);
> > + */
> > +void __init_or_module sort_ex_table(struct exception_table_entry
*start, struct exception_table_entry *finish)
>
> Never put non-inline functions in a header file.  And never inline a
> function this large.
>
> Since this is only called from module.c, perhaps put it in
> include/linux/moduleloader.h and the code in extable.c.
>
> Hope that helps,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>

------=_NextPart_000_005E_01C3C4A7.7A29AD00
Content-Type: application/octet-stream;
	name="patch-init_exceptions_removal-version2-test11.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch-init_exceptions_removal-version2-test11.diff"

diff -Nur linux-2.6.0-test11/Makefile =
linux-2.6.0-test11-modified/Makefile
--- linux-2.6.0-test11/Makefile	2003-11-26 18:44:43.000000000 -0200
+++ linux-2.6.0-test11-modified/Makefile	2003-12-02 15:12:34.000000000 =
-0200
@@ -1,7 +1,7 @@
 VERSION =3D 2
 PATCHLEVEL =3D 6
 SUBLEVEL =3D 0
-EXTRAVERSION =3D -test11
+EXTRAVERSION =3D -test11-so3
diff -Nur linux-2.6.0-test11/arch/i386/kernel/module.c =
linux-2.6.0-test11-modified/arch/i386/kernel/module.c
--- linux-2.6.0-test11/arch/i386/kernel/module.c	2003-11-26 =
18:44:07.000000000 -0200
+++ linux-2.6.0-test11-modified/arch/i386/kernel/module.c	2003-12-02 =
15:17:46.000000000 -0200
@@ -35,13 +35,10 @@
 	return vmalloc(size);
 }
=20
-
 /* Free memory returned from module_alloc */
 void module_free(struct module *mod, void *module_region)
-{
+{=09
 	vfree(module_region);
-	/* FIXME: If module_region =3D=3D mod->init_region, trim exception
-           table entries. */
 }
=20
 /* We don't need anything special. */
diff -Nur linux-2.6.0-test11/drivers/base/Kconfig =
linux-2.6.0-test11-modified/drivers/base/Kconfig
--- linux-2.6.0-test11/drivers/base/Kconfig	2003-11-26 =
18:43:09.000000000 -0200
+++ linux-2.6.0-test11-modified/drivers/base/Kconfig	2003-12-02 =
15:10:51.000000000 -0200
@@ -8,4 +8,7 @@
 	  require hotplug firmware loading support, but a module built outside
 	  the kernel tree does.
=20
+config SISOP3
+	tristate "Modulo de SO3"
+
 endmenu
diff -Nur linux-2.6.0-test11/drivers/base/Makefile =
linux-2.6.0-test11-modified/drivers/base/Makefile
--- linux-2.6.0-test11/drivers/base/Makefile	2003-11-26 =
18:45:22.000000000 -0200
+++ linux-2.6.0-test11-modified/drivers/base/Makefile	2003-12-02 =
15:10:51.000000000 -0200
@@ -6,3 +6,4 @@
 obj-y			+=3D power/
 obj-$(CONFIG_FW_LOADER)	+=3D firmware_class.o
 obj-$(CONFIG_NUMA)	+=3D node.o  memblk.o
+obj-$(CONFIG_SISOP3) +=3D sisop3.o
diff -Nur linux-2.6.0-test11/drivers/base/sisop3.c =
linux-2.6.0-test11-modified/drivers/base/sisop3.c
--- linux-2.6.0-test11/drivers/base/sisop3.c	1969-12-31 =
21:00:00.000000000 -0300
+++ linux-2.6.0-test11-modified/drivers/base/sisop3.c	2003-12-02 =
15:10:51.000000000 -0200
@@ -0,0 +1,11 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <asm/uaccess.h>
+
+/* Dummy function in the init section which causes an extable entry */
+int __init function_with_exception_init(void *uaddr, void *addr)
+{
+	return copy_from_user(addr, uaddr, 4);
+}
+
+MODULE_LICENSE("GPL");
diff -Nur linux-2.6.0-test11/include/asm-i386/uaccess.h =
linux-2.6.0-test11-modified/include/asm-i386/uaccess.h
--- linux-2.6.0-test11/include/asm-i386/uaccess.h	2003-11-26 =
18:43:07.000000000 -0200
+++ linux-2.6.0-test11-modified/include/asm-i386/uaccess.h	2003-12-02 =
15:10:52.000000000 -0200
@@ -123,6 +123,15 @@
 	unsigned long insn, fixup;
 };
=20
+/* Compare two exception table entries: < 0 if ex1 comes before ex2 */
+static inline int extable_cmp(const struct exception_table_entry ex1,=20
+                const struct exception_table_entry ex2)
+{
+	return (long)ex1.insn - ex2.insn;
+}          =20
+
+
+
 extern int fixup_exception(struct pt_regs *regs);
=20
 /*
diff -Nur linux-2.6.0-test11/include/linux/moduleloader.h =
linux-2.6.0-test11-modified/include/linux/moduleloader.h
--- linux-2.6.0-test11/include/linux/moduleloader.h	2003-11-26 =
18:43:40.000000000 -0200
+++ linux-2.6.0-test11-modified/include/linux/moduleloader.h	2003-12-02 =
15:10:52.000000000 -0200
@@ -44,4 +44,8 @@
 /* Any cleanup needed when module leaves. */
 void module_arch_cleanup(struct module *mod);
=20
+/* This code sorts an exception table. It is very used with modules =
code */
+void sort_ex_table(struct exception_table_entry *start,
+                   struct exception_table_entry *finish);
+
 #endif
diff -Nur linux-2.6.0-test11/kernel/extable.c =
linux-2.6.0-test11-modified/kernel/extable.c
--- linux-2.6.0-test11/kernel/extable.c	2003-11-26 18:43:32.000000000 =
-0200
+++ linux-2.6.0-test11-modified/kernel/extable.c	2003-12-02 =
15:10:52.000000000 -0200
@@ -19,6 +19,8 @@
 #include <asm/uaccess.h>
 #include <asm/sections.h>
=20
+#include <linux/moduleloader.h>
+
 extern const struct exception_table_entry __start___ex_table[];
 extern const struct exception_table_entry __stop___ex_table[];
=20
@@ -45,3 +47,26 @@
=20
 	return module_text_address(addr) !=3D NULL;
 }
+
+
+void sort_ex_table(struct exception_table_entry *start, struct =
exception_table_entry *finish)
+{
+	struct exception_table_entry el, *p, *q;
+	=09
+	/* insertion sort */
+	for (p =3D start + 1; p < finish; ++p) {
+		/* start .. p-1 is sorted */
+		if (extable_cmp(p[0], p[-1]) =3D=3D -1) {
+		/* move element p down to its right place */
+			el =3D *p;
+			q =3D p;
+			do {
+				/* el comes before q[-1], move q[-1] up one */
+				q[0] =3D q[-1];
+				--q;
+			} while (q > start && extable_cmp(el, q[-1]) =3D=3D -1);
+				*q =3D el;
+		}
+	}
+}
+						=09
diff -Nur linux-2.6.0-test11/kernel/module.c =
linux-2.6.0-test11-modified/kernel/module.c
--- linux-2.6.0-test11/kernel/module.c	2003-11-26 18:44:57.000000000 =
-0200
+++ linux-2.6.0-test11-modified/kernel/module.c	2003-12-02 =
15:10:52.000000000 -0200
@@ -1076,6 +1076,42 @@
 	return ret;
 }
=20
+static inline int within(unsigned long addr, void *start, unsigned long =
size)
+{
+	return ((void *)addr >=3D start && (void *)addr < start + size);
+}
+
+/* Remove exception table entries which belongs to this module's init =
area */
+void remove_init_exceptions(struct module *mod)=20
+{
+	const struct exception_table_entry *local;
+	unsigned int i;
+	int num_init_ex=3D0;
+
+	if (!mod->module_init)
+		return;
+
+	local =3D mod->extable;
+	i =3D 1;
+	while (i <=3D mod->num_exentries) {
+		if (within((unsigned long) local->insn, mod->module_init,=20
+		            mod->init_size)) {
+			num_init_ex++;
+		}
+		else break;
+		local =3D local+1;
+		i++;
+	}
+
+	/* Move the pointer to remove the init exceptions */
+	spin_lock(&modlist_lock);
+		mod->extable +=3D num_init_ex;
+		mod->num_exentries -=3D num_init_ex;
+	spin_unlock(&modlist_lock);
+}
+
+
+
 /* Free a module, remove from lists, etc (must hold module mutex). */
 static void free_module(struct module *mod)
 {
@@ -1615,6 +1651,11 @@
 	mod->num_exentries =3D sechdrs[exindex].sh_size / =
sizeof(*mod->extable);
 	mod->extable =3D (void *)sechdrs[exindex].sh_addr;
=20
+        /* Classifying the exception table */
+        sort_ex_table((struct exception_table_entry *)mod->extable,
+                      (struct exception_table_entry *)mod->extable +
+                                mod->num_exentries);
+
 	/* Now do relocations. */
 	for (i =3D 1; i < hdr->e_shnum; i++) {
 		const char *strtab =3D (char *)sechdrs[strindex].sh_addr;
@@ -1753,6 +1794,7 @@
 	mod->state =3D MODULE_STATE_LIVE;
 	/* Drop initial reference. */
 	module_put(mod);
+	remove_init_exceptions(mod);
 	module_free(mod, mod->module_init);
 	mod->module_init =3D NULL;
 	mod->init_size =3D 0;
@@ -1762,11 +1804,6 @@
 	return 0;
 }
=20
-static inline int within(unsigned long addr, void *start, unsigned long =
size)
-{
-	return ((void *)addr >=3D start && (void *)addr < start + size);
-}
-
 #ifdef CONFIG_KALLSYMS
 static const char *get_ksymbol(struct module *mod,
 			       unsigned long addr,

------=_NextPart_000_005E_01C3C4A7.7A29AD00--

