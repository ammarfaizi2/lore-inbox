Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312691AbSEHKYw>; Wed, 8 May 2002 06:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312718AbSEHKYv>; Wed, 8 May 2002 06:24:51 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:43524 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S312691AbSEHKYs>;
	Wed, 8 May 2002 06:24:48 -0400
Date: Wed, 8 May 2002 14:29:33 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] __init and friends support for loadable modules
Message-ID: <20020508102933.GA574@pazke.ipt>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

attached patch adds support for	freeing .init sections of loadable modules
after init_module() function exits. Modutils have support for this since 19=
98,
but kernel support didn't exist.

All architectures that use vmalloc/vfree for module_map/unmap should work.

Patch contains three major part:
	- shrink_vm_area() function for reducing size of vmalloc'ed area;
	- init.h changes to allow .init sections in modules;
	- change in kernel/module.c.

Comments, suggestions ?


Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-module-init
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-alpha/module.h l=
inux/include/asm-alpha/module.h
--- linux.vanilla/include/asm-alpha/module.h	Wed May  8 10:01:53 2002
+++ linux/include/asm-alpha/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	alpha_module_init(x)
 #define arch_init_modules(x)	alpha_init_modules(x)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-arm/module.h lin=
ux/include/asm-arm/module.h
--- linux.vanilla/include/asm-arm/module.h	Wed May  8 10:01:57 2002
+++ linux/include/asm-arm/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-cris/module.h li=
nux/include/asm-cris/module.h
--- linux.vanilla/include/asm-cris/module.h	Wed May  8 10:02:01 2002
+++ linux/include/asm-cris/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)    do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-i386/module.h li=
nux/include/asm-i386/module.h
--- linux.vanilla/include/asm-i386/module.h	Wed May  8 10:01:52 2002
+++ linux/include/asm-i386/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-ia64/module.h li=
nux/include/asm-ia64/module.h
--- linux.vanilla/include/asm-ia64/module.h	Wed May  8 10:01:58 2002
+++ linux/include/asm-ia64/module.h	Wed May  8 10:06:36 2002
@@ -13,6 +13,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		ia64_module_unmap(x)
+#define module_remap(ptr, size)	(-ENOSYS)
 #define module_arch_init(x)	ia64_module_init(x)
=20
 /*
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-m68k/module.h li=
nux/include/asm-m68k/module.h
--- linux.vanilla/include/asm-m68k/module.h	Wed May  8 10:01:53 2002
+++ linux/include/asm-m68k/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-mips/module.h li=
nux/include/asm-mips/module.h
--- linux.vanilla/include/asm-mips/module.h	Wed May  8 10:01:52 2002
+++ linux/include/asm-mips/module.h	Wed May  8 10:06:36 2002
@@ -9,6 +9,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	mips_module_init(x)
 #define arch_init_modules(x)	mips_init_modules(x)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-mips64/module.h =
linux/include/asm-mips64/module.h
--- linux.vanilla/include/asm-mips64/module.h	Wed May  8 10:02:01 2002
+++ linux/include/asm-mips64/module.h	Wed May  8 10:06:36 2002
@@ -9,6 +9,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	mips64_module_init(x)
 #define arch_init_modules(x)	mips64_init_modules(x)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-ppc/module.h lin=
ux/include/asm-ppc/module.h
--- linux.vanilla/include/asm-ppc/module.h	Wed May  8 10:01:55 2002
+++ linux/include/asm-ppc/module.h	Wed May  8 10:06:36 2002
@@ -9,6 +9,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-ppc64/module.h l=
inux/include/asm-ppc64/module.h
--- linux.vanilla/include/asm-ppc64/module.h	Wed May  8 10:02:04 2002
+++ linux/include/asm-ppc64/module.h	Wed May  8 10:06:36 2002
@@ -13,6 +13,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define arch_init_modules(x)	do { } while (0)
 #define module_arch_init(x)  (0)
 #endif /* _ASM_PPC64_MODULE_H */
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-s390/module.h li=
nux/include/asm-s390/module.h
--- linux.vanilla/include/asm-s390/module.h	Wed May  8 10:02:01 2002
+++ linux/include/asm-s390/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-s390x/module.h l=
inux/include/asm-s390x/module.h
--- linux.vanilla/include/asm-s390x/module.h	Wed May  8 10:02:03 2002
+++ linux/include/asm-s390x/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-sh/module.h linu=
x/include/asm-sh/module.h
--- linux.vanilla/include/asm-sh/module.h	Wed May  8 10:01:58 2002
+++ linux/include/asm-sh/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-sparc/module.h l=
inux/include/asm-sparc/module.h
--- linux.vanilla/include/asm-sparc/module.h	Wed May  8 10:01:54 2002
+++ linux/include/asm-sparc/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 #define module_map(x)		vmalloc(x)
 #define module_unmap(x)		vfree(x)
+#define module_remap(ptr, size)	shrink_vm_area(ptr, size)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-sparc64/module.h=
 linux/include/asm-sparc64/module.h
--- linux.vanilla/include/asm-sparc64/module.h	Wed May  8 10:01:56 2002
+++ linux/include/asm-sparc64/module.h	Wed May  8 10:06:36 2002
@@ -6,6 +6,7 @@
=20
 extern void * module_map (unsigned long size);
 extern void module_unmap (void *addr);
+#define module_remap(ptr, size)	(-ENOSYS)
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/asm-x86_64/module.h =
linux/include/asm-x86_64/module.h
--- linux.vanilla/include/asm-x86_64/module.h	Wed May  8 10:02:05 2002
+++ linux/include/asm-x86_64/module.h	Wed May  8 10:06:36 2002
@@ -9,6 +9,8 @@
 extern void *module_map(unsigned long);
 extern void module_unmap(void *);
=20
+#define module_remap(ptr, size)	(-ENOSYS)
+
 #define module_arch_init(x)	(0)
 #define arch_init_modules(x)	do { } while (0)
=20
diff -urN -X /usr/share/dontdiff linux.vanilla/include/linux/init.h linux/i=
nclude/linux/init.h
--- linux.vanilla/include/linux/init.h	Wed May  8 10:01:47 2002
+++ linux/include/linux/init.h	Wed May  8 10:06:36 2002
@@ -38,6 +38,18 @@
  * Also note, that this data cannot be "const".
  */
=20
+/*
+ * Mark functions and data as being only used at initialization
+ * or exit time.
+ */
+#define __init		__attribute__ ((__section__ (".text.init")))
+#define __initdata	__attribute__ ((__section__ (".data.init")))
+
+/* For assembly routines */
+#define __INIT		.section	".text.init","ax"
+#define __FINIT		.previous
+#define __INITDATA	.section	".data.init","aw"
+
 #ifndef MODULE
=20
 #ifndef __ASSEMBLY__
@@ -89,23 +101,12 @@
=20
 #endif /* __ASSEMBLY__ */
=20
-/*
- * Mark functions and data as being only used at initialization
- * or exit time.
- */
-#define __init		__attribute__ ((__section__ (".text.init")))
-#define __exit		__attribute__ ((unused, __section__(".text.exit")))
-#define __initdata	__attribute__ ((__section__ (".data.init")))
-#define __exitdata	__attribute__ ((unused, __section__ (".data.exit")))
 #define __initsetup	__attribute__ ((unused,__section__ (".setup.init")))
 #define __init_call(level)  __attribute__ ((unused,__section__ (".initcall=
" level ".init")))
+#define __exit		__attribute__ ((unused, __section__(".text.exit")))
+#define __exitdata	__attribute__ ((unused, __section__ (".data.exit")))
 #define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
=20
-/* For assembly routines */
-#define __INIT		.section	".text.init","ax"
-#define __FINIT		.previous
-#define __INITDATA	.section	".data.init","aw"
-
 /**
  * module_init() - driver initialization entry point
  * @x: function to be run at kernel boot time or module insertion
@@ -131,15 +132,9 @@
=20
 #else
=20
-#define __init
 #define __exit
-#define __initdata
 #define __exitdata
 #define __initcall(fn)
-/* For assembly routines */
-#define __INIT
-#define __FINIT
-#define __INITDATA
=20
 /* These macros create a dummy inline: gcc 2.9x does not count alias
  as usage, hence the `unused function' warning when __init functions
diff -urN -X /usr/share/dontdiff linux.vanilla/include/linux/vmalloc.h linu=
x/include/linux/vmalloc.h
--- linux.vanilla/include/linux/vmalloc.h	Wed May  8 10:01:48 2002
+++ linux/include/linux/vmalloc.h	Wed May  8 10:34:16 2002
@@ -24,6 +24,7 @@
 extern void vmfree_area_pages(unsigned long address, unsigned long size);
 extern int vmalloc_area_pages(unsigned long address, unsigned long size,
                               int gfp_mask, pgprot_t prot);
+extern int shrink_vm_area(void * addr, unsigned long size);
=20
 /*
  *	Allocate any pages
diff -urN -X /usr/share/dontdiff linux.vanilla/kernel/ksyms.c linux/kernel/=
ksyms.c
--- linux.vanilla/kernel/ksyms.c	Wed May  8 10:01:45 2002
+++ linux/kernel/ksyms.c	Wed May  8 10:06:36 2002
@@ -108,6 +108,7 @@
 EXPORT_SYMBOL(vfree);
 EXPORT_SYMBOL(__vmalloc);
 EXPORT_SYMBOL(vmalloc_to_page);
+EXPORT_SYMBOL(shrink_vm_area);
 EXPORT_SYMBOL(mem_map);
 EXPORT_SYMBOL(remap_page_range);
 EXPORT_SYMBOL(max_mapnr);
diff -urN -X /usr/share/dontdiff linux.vanilla/kernel/module.c linux/kernel=
/module.c
--- linux.vanilla/kernel/module.c	Wed May  8 10:01:45 2002
+++ linux/kernel/module.c	Wed May  8 10:06:36 2002
@@ -558,6 +558,13 @@
 			error =3D -EBUSY;
 		goto err0;
 	}
+=09
+	/* It's time to throw away .init sections */
+	if (mod->runsize) {
+		if (!module_remap(mod, mod->runsize))
+			mod->size =3D mod->runsize;
+	}
+
 	atomic_dec(&mod->uc.usecount);
=20
 	/* And set it running.  */
diff -urN -X /usr/share/dontdiff linux.vanilla/mm/vmalloc.c linux/mm/vmallo=
c.c
--- linux.vanilla/mm/vmalloc.c	Wed May  8 10:01:46 2002
+++ linux/mm/vmalloc.c	Wed May  8 10:06:36 2002
@@ -174,6 +174,44 @@
 	return ret;
 }
=20
+int shrink_vm_area(void * addr, unsigned long size)
+{
+	int ret;
+	struct vm_struct **p, *tmp;
+
+	if (!addr || !(unsigned long)addr & (PAGE_SIZE - 1) || !size)
+		return -EINVAL;
+
+	size =3D PAGE_ALIGN(size) + PAGE_SIZE;
+
+	ret =3D 0;
+	write_lock(&vmlist_lock);
+	for (p =3D &vmlist; (tmp =3D *p) ; p =3D &tmp->next) {
+		if (tmp->addr =3D=3D addr) {
+			int delta;
+			unsigned long end;
+
+			if (size > tmp->size) {
+				ret =3D -EINVAL;
+				break;
+			}
+			if (size =3D=3D tmp->size)
+				break;
+
+			delta =3D tmp->size - size;
+			end =3D (unsigned long) tmp->addr + size - PAGE_SIZE;
+
+			tmp->size =3D size + PAGE_SIZE;
+			vmfree_area_pages(VMALLOC_VMADDR(end), delta);
+
+			break;
+		}
+	}
+
+	write_unlock(&vmlist_lock);
+	return ret;
+}
+
 struct vm_struct * get_vm_area(unsigned long size, unsigned long flags)
 {
 	unsigned long addr;

--i9LlY+UWpKt15+FH--

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE82P4NBm4rlNOo3YgRAquWAJ0X1a1kmJQZC9LJCf3sq5c8zmVFeQCePoBk
3F4tg943so1H7SdwRLX/3rk=
=xGKP
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
