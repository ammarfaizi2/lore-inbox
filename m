Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265838AbTGACK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 22:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbTGACK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 22:10:59 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:11268 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S265838AbTGACK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 22:10:29 -0400
Subject: Re: [PATCH] fix for kallsyms module symbol resolution problem
From: James Bottomley <James.Bottomley@steeleye.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030630074948.8F43D2C0A7@lists.samba.org>
References: <20030630074948.8F43D2C0A7@lists.samba.org>
Content-Type: multipart/mixed; boundary="=-f9V9lKd+cVFuXVxNK60J"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 30 Jun 2003 21:24:35 -0500
Message-Id: <1057026277.2069.80.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f9V9lKd+cVFuXVxNK60J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2003-06-30 at 01:17, Rusty Russell wrote:
> Yeah, but I was trying to get you to do more work.  And if the names
> resulting are useless anyway, why apply the patch?

OK, how about the attached.  I think it solves the module_text_address()
problem too.

James


--=-f9V9lKd+cVFuXVxNK60J
Content-Disposition: inline; filename=tmp.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=tmp.diff; charset=ISO-8859-1

=3D=3D=3D=3D=3D include/linux/module.h 1.65 vs edited =3D=3D=3D=3D=3D
--- 1.65/include/linux/module.h	Fri Jun  6 00:54:38 2003
+++ edited/include/linux/module.h	Mon Jun 30 15:47:27 2003
@@ -217,6 +217,9 @@
 	/* Here are the sizes of the init and core sections */
 	unsigned long init_size, core_size;
=20
+	/* The size of the code in each section.  */
+	unsigned long init_code_size, core_code_size;
+
 	/* Arch-specific module values */
 	struct mod_arch_specific arch;
=20
=3D=3D=3D=3D=3D kernel/module.c 1.86 vs edited =3D=3D=3D=3D=3D
--- 1.86/kernel/module.c	Wed Jun 11 00:55:09 2003
+++ edited/kernel/module.c	Mon Jun 30 21:18:17 2003
@@ -1176,6 +1176,9 @@
 			    const char *secstrings)
 {
 	static unsigned long const masks[][2] =3D {
+		/* NOTE: code must be the first and only section
+		 * in this array; otherwise modify the code_size
+		 * finder in the two loops below */
 		{ SHF_EXECINSTR | SHF_ALLOC, ARCH_SHF_SMALL },
 		{ SHF_ALLOC, SHF_WRITE | ARCH_SHF_SMALL },
 		{ SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
@@ -1198,6 +1201,8 @@
 				continue;
 			s->sh_entsize =3D get_offset(&mod->core_size, s);
 			DEBUGP("\t%s\n", secstrings + s->sh_name);
+			if(m =3D=3D 0)
+				mod->core_code_size =3D mod->core_size;
 		}
 	}
=20
@@ -1214,6 +1219,8 @@
 			s->sh_entsize =3D (get_offset(&mod->init_size, s)
 					 | INIT_OFFSET_MASK);
 			DEBUGP("\t%s\n", secstrings + s->sh_name);
+			if(m =3D=3D 0)
+				mod->init_code_size =3D mod->init_size;
 		}
 	}
 }
@@ -1726,6 +1733,7 @@
 	module_free(mod, mod->module_init);
 	mod->module_init =3D NULL;
 	mod->init_size =3D 0;
+	mod->init_code_size =3D 0;
 	up(&module_mutex);
=20
 	return 0;
@@ -1747,9 +1755,11 @@
=20
 	/* At worse, next value is at end of module */
 	if (within(addr, mod->module_init, mod->init_size))
-		nextval =3D (unsigned long)mod->module_init + mod->init_size;
+		nextval =3D (unsigned long)mod->module_init
+			+ mod->init_code_size;
 	else=20
-		nextval =3D (unsigned long)mod->module_core + mod->core_size;
+		nextval =3D (unsigned long)mod->module_core
+			+ mod->core_code_size;
=20
 	/* Scan for closest preceeding symbol, and next symbol. (ELF
            starts real symbols at 1). */
@@ -1758,10 +1768,12 @@
 			continue;
=20
 		if (mod->symtab[i].st_value <=3D addr
-		    && mod->symtab[i].st_value > mod->symtab[best].st_value)
+		    && mod->symtab[i].st_value > mod->symtab[best].st_value
+		    && *(mod->strtab + mod->symtab[i].st_name) !=3D '\0' )
 			best =3D i;
 		if (mod->symtab[i].st_value > addr
-		    && mod->symtab[i].st_value < nextval)
+		    && mod->symtab[i].st_value < nextval
+		    && *(mod->strtab + mod->symtab[i].st_name) !=3D '\0')
 			nextval =3D mod->symtab[i].st_value;
 	}
=20
@@ -1910,8 +1922,8 @@
 	struct module *mod;
=20
 	list_for_each_entry(mod, &modules, list)
-		if (within(addr, mod->module_init, mod->init_size)
-		    || within(addr, mod->module_core, mod->core_size))
+		if (within(addr, mod->module_init, mod->init_code_size)
+		    || within(addr, mod->module_core, mod->core_code_size))
 			return mod;
 	return NULL;
 }

--=-f9V9lKd+cVFuXVxNK60J--

