Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030336AbWCUQ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWCUQ0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWCUQVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28684 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932389AbWCUQVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:12 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 04/46] kbuild: improved modversioning support for external modules
In-Reply-To: <11429580543482-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:54 +0100
Message-Id: <11429580542480-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With following patch a second option is enabled to obtain
symbol information from a second external module when a
external module is build.
The recommended approach is to use a common kbuild file but
that may be impractical in certain cases.
With this patch one can copy over a Module.symvers from one
external module to make symbols (and symbol versions) available
for another external module.

Updated documentation in Documentation/kbuild/modules.txt

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Documentation/kbuild/modules.txt |   87 +++++++++++++++++++++++++--
 scripts/Makefile.modpost         |    7 ++
 scripts/mod/modpost.c            |  123 +++++++++++++++++++++++---------------
 3 files changed, 158 insertions(+), 59 deletions(-)

040fcc819a2e7783a570f4bdcdd1f2a7f5f06837
diff --git a/Documentation/kbuild/modules.txt b/Documentation/kbuild/modules.txt
index 87d858d..fcccf24 100644
--- a/Documentation/kbuild/modules.txt
+++ b/Documentation/kbuild/modules.txt
@@ -23,7 +23,10 @@ In this document you will find informati
 	=== 6. Module installation
 	   --- 6.1 INSTALL_MOD_PATH
 	   --- 6.2 INSTALL_MOD_DIR
-	=== 7. Module versioning
+	=== 7. Module versioning & Module.symvers
+	   --- 7.1 Symbols fron the kernel (vmlinux + modules)
+	   --- 7.2 Symbols and external modules
+	   --- 7.3 Symbols from another external module
 	=== 8. Tips & Tricks
 	   --- 8.1 Testing for CONFIG_FOO_BAR
 
@@ -89,7 +92,8 @@ when building an external module.
 	make -C $KDIR M=$PWD modules_install
 		Install the external module(s).
 		Installation default is in /lib/modules/<kernel-version>/extra,
-		but may be prefixed with INSTALL_MOD_PATH - see separate chapter.
+		but may be prefixed with INSTALL_MOD_PATH - see separate
+		chapter.
 
 	make -C $KDIR M=$PWD clean
 		Remove all generated files for the module - the kernel
@@ -433,7 +437,7 @@ External modules are installed in the di
 		=> Install dir: /lib/modules/$(KERNELRELEASE)/gandalf
 
 
-=== 7. Module versioning
+=== 7. Module versioning & Module.symvers
 
 Module versioning is enabled by the CONFIG_MODVERSIONS tag.
 
@@ -443,11 +447,80 @@ when a module is loaded/used then the CR
 compared with similar values in the module. If they are not equal then the
 kernel refuses to load the module.
 
-During a kernel build a file named Module.symvers will be generated. This
-file includes the symbol version of all symbols within the kernel. If the 
-Module.symvers file is saved from the last full kernel compile one does not
-have to do a full kernel compile to build a module version's compatible module.
+Module.symvers contains a list of all exported symbols from a kernel build.
 
+--- 7.1 Symbols fron the kernel (vmlinux + modules)
+
+	During a kernel build a file named Module.symvers will be generated.
+	Module.symvers contains all exported symbols from the kernel and
+	compiled modules. For each symbols the corresponding CRC value
+	is stored too.
+
+	The syntax of the Module.symvers file is:
+		<CRC>       <Symbol>           <module>
+	Sample:
+		0x2d036834  scsi_remove_host   drivers/scsi/scsi_mod
+
+	For a kernel build without CONFIG_MODVERSIONING enabled the crc
+	would read: 0x00000000
+
+	Module.symvers serve two purposes.
+	1) It list all exported symbols both from vmlinux and all modules
+	2) It list CRC if CONFIG_MODVERSION is enabled
+
+--- 7.2 Symbols and external modules
+
+	When building an external module the build system needs access to
+	the symbols from the kernel to check if all external symbols are
+	defined. This is done in the MODPOST step and to obtain all
+	symbols modpost reads Module.symvers from the kernel.
+	If a Module.symvers file is present in the directory where
+	the external module is being build this file will be read too.
+	During the MODPOST step a new Module.symvers file will be written
+	containing all exported symbols that was not defined in the kernel.
+	
+--- 7.3 Symbols from another external module
+
+	Sometimes one external module uses exported symbols from another
+	external module. Kbuild needs to have full knowledge on all symbols
+	to avoid spitting out warnings about undefined symbols.
+	Two solutions exist to let kbuild know all symbols of more than
+	one external module.
+	The method with a top-level kbuild file is recommended but may be
+	impractical in certain situations.
+
+	Use a top-level Kbuild file
+		If you have two modules: 'foo', 'bar' and 'foo' needs symbols
+		from 'bar' then one can use a common top-level kbuild file so
+		both modules are compiled in same build.
+
+		Consider following directory layout:
+		./foo/ <= contains the foo module
+		./bar/ <= contains the bar module
+		The top-level Kbuild file would then look like:
+		
+		#./Kbuild: (this file may also be named Makefile)
+			obj-y := foo/ bar/
+
+		Executing:
+			make -C $KDIR M=`pwd`
+
+		will then do the expected and compile both modules with full
+		knowledge on symbols from both modules.
+
+	Use an extra Module.symvers file
+		When an external module is build a Module.symvers file is
+		generated containing all exported symbols which are not
+		defined in the kernel.
+		To get access to symbols from module 'bar' one can copy the
+		Module.symvers file from the compilation of the 'bar' module
+		to the directory where the 'foo' module is build.
+		During the module build kbuild will read the Module.symvers
+		file in the directory of the external module and when the
+		build is finished a new Module.symvers file is created
+		containing the sum of all symbols defined and not part of the
+		kernel.
+		
 === 8. Tips & Tricks
 
 --- 8.1 Testing for CONFIG_FOO_BAR
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index bf96a61..563e3c5 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -39,7 +39,8 @@ include .config
 include scripts/Kbuild.include
 include scripts/Makefile.lib
 
-symverfile := $(objtree)/Module.symvers
+kernelsymfile := $(objtree)/Module.symvers
+modulesymfile := $(KBUILD_EXTMOD)/Modules.symvers
 
 # Step 1), find all modules listed in $(MODVERDIR)/
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
@@ -54,7 +55,9 @@ quiet_cmd_modpost = MODPOST
       cmd_modpost = scripts/mod/modpost            \
         $(if $(CONFIG_MODVERSIONS),-m)             \
 	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a,)  \
-	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
+	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile) \
+	$(if $(KBUILD_EXTMOD),-I $(modulesymfile)) \
+	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
 	$(filter-out FORCE,$^)
 
 .PHONY: __modpost
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4a2f2e3..976adf1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -20,6 +20,8 @@ int modversions = 0;
 int have_vmlinux = 0;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
 static int all_versions = 0;
+/* If we are modposting external module set to 1 */
+static int external_module = 0;
 
 void fatal(const char *fmt, ...)
 {
@@ -45,6 +47,18 @@ void warn(const char *fmt, ...)
 	va_end(arglist);
 }
 
+static int is_vmlinux(const char *modname)
+{
+	const char *myname;
+
+	if ((myname = strrchr(modname, '/')))
+		myname++;
+	else
+		myname = modname;
+
+	return strcmp(myname, "vmlinux") == 0;
+}
+
 void *do_nofail(void *ptr, const char *expr)
 {
 	if (!ptr) {
@@ -100,6 +114,9 @@ struct symbol {
 	unsigned int crc;
 	int crc_valid;
 	unsigned int weak:1;
+	unsigned int vmlinux:1;    /* 1 if symbol is defined in vmlinux */
+	unsigned int kernel:1;     /* 1 if symbol is from kernel
+				    *  (only for external modules) **/
 	char name[0];
 };
 
@@ -135,8 +152,7 @@ static struct symbol *alloc_symbol(const
 }
 
 /* For the hash of exported symbols */
-static void new_symbol(const char *name, struct module *module,
-		       unsigned int *crc)
+static struct symbol *new_symbol(const char *name, struct module *module)
 {
 	unsigned int hash;
 	struct symbol *new;
@@ -144,10 +160,7 @@ static void new_symbol(const char *name,
 	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
 	new = symbolhash[hash] = alloc_symbol(name, 0, symbolhash[hash]);
 	new->module = module;
-	if (crc) {
-		new->crc = *crc;
-		new->crc_valid = 1;
-	}
+	return new;
 }
 
 static struct symbol *find_symbol(const char *name)
@@ -169,19 +182,27 @@ static struct symbol *find_symbol(const 
  * Add an exported symbol - it may have already been added without a
  * CRC, in this case just update the CRC
  **/
-static void add_exported_symbol(const char *name, struct module *module,
-				unsigned int *crc)
+static struct symbol *sym_add_exported(const char *name, struct module *mod)
 {
 	struct symbol *s = find_symbol(name);
 
-	if (!s) {
-		new_symbol(name, module, crc);
-		return;
-	}
-	if (crc) {
-		s->crc = *crc;
-		s->crc_valid = 1;
-	}
+	if (!s)
+		s = new_symbol(name, mod);
+
+	s->vmlinux   = is_vmlinux(mod->name);
+	s->kernel    = 0;
+	return s;
+}
+
+static void sym_update_crc(const char *name, struct module *mod,
+			   unsigned int crc)
+{
+	struct symbol *s = find_symbol(name);
+
+	if (!s)
+		s = new_symbol(name, mod);
+	s->crc = crc;
+	s->crc_valid = 1;
 }
 
 void *grab_file(const char *filename, unsigned long *size)
@@ -332,8 +353,7 @@ static void handle_modversions(struct mo
 		/* CRC'd symbol */
 		if (memcmp(symname, CRC_PFX, strlen(CRC_PFX)) == 0) {
 			crc = (unsigned int) sym->st_value;
-			add_exported_symbol(symname + strlen(CRC_PFX),
-					    mod, &crc);
+			sym_update_crc(symname + strlen(CRC_PFX), mod, crc);
 		}
 		break;
 	case SHN_UNDEF:
@@ -377,8 +397,7 @@ static void handle_modversions(struct mo
 	default:
 		/* All exported symbols */
 		if (memcmp(symname, KSYMTAB_PFX, strlen(KSYMTAB_PFX)) == 0) {
-			add_exported_symbol(symname + strlen(KSYMTAB_PFX),
-					    mod, NULL);
+			sym_add_exported(symname + strlen(KSYMTAB_PFX), mod);
 		}
 		if (strcmp(symname, MODULE_SYMBOL_PREFIX "init_module") == 0)
 			mod->has_init = 1;
@@ -388,18 +407,6 @@ static void handle_modversions(struct mo
 	}
 }
 
-static int is_vmlinux(const char *modname)
-{
-	const char *myname;
-
-	if ((myname = strrchr(modname, '/')))
-		myname++;
-	else
-		myname = modname;
-
-	return strcmp(myname, "vmlinux") == 0;
-}
-
 /**
  * Parse tag=value strings from .modinfo section
  **/
@@ -450,9 +457,7 @@ static void read_symbols(char *modname)
 	/* When there's no vmlinux, don't print warnings about
 	 * unresolved symbols (since there'll be too many ;) */
 	if (is_vmlinux(modname)) {
-		unsigned int fake_crc = 0;
 		have_vmlinux = 1;
-		add_exported_symbol("struct_module", mod, &fake_crc);
 		mod->skip = 1;
 	}
 
@@ -665,7 +670,7 @@ static void write_if_changed(struct buff
 	fclose(file);
 }
 
-static void read_dump(const char *fname)
+static void read_dump(const char *fname, unsigned int kernel)
 {
 	unsigned long size, pos = 0;
 	void *file = grab_file(fname, &size);
@@ -679,6 +684,7 @@ static void read_dump(const char *fname)
 		char *symname, *modname, *d;
 		unsigned int crc;
 		struct module *mod;
+		struct symbol *s;
 
 		if (!(symname = strchr(line, '\t')))
 			goto fail;
@@ -699,13 +705,28 @@ static void read_dump(const char *fname)
 			mod = new_module(NOFAIL(strdup(modname)));
 			mod->skip = 1;
 		}
-		add_exported_symbol(symname, mod, &crc);
+		s = sym_add_exported(symname, mod);
+		s->kernel = kernel;
+		sym_update_crc(symname, mod, crc);
 	}
 	return;
 fail:
 	fatal("parse error in symbol dump file\n");
 }
 
+/* For normal builds always dump all symbols.
+ * For external modules only dump symbols
+ * that are not read from kernel Module.symvers.
+ **/
+static int dump_sym(struct symbol *sym)
+{
+	if (!external_module)
+		return 1;
+	if (sym->vmlinux || sym->kernel)
+		return 0;
+	return 1;
+}
+		
 static void write_dump(const char *fname)
 {
 	struct buffer buf = { };
@@ -715,15 +736,10 @@ static void write_dump(const char *fname
 	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
 		symbol = symbolhash[n];
 		while (symbol) {
-			symbol = symbol->next;
-		}
-	}
-
-	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
-		symbol = symbolhash[n];
-		while (symbol) {
-			buf_printf(&buf, "0x%08x\t%s\t%s\n", symbol->crc,
-				symbol->name, symbol->module->name);
+			if (dump_sym(symbol))
+				buf_printf(&buf, "0x%08x\t%s\t%s\n",
+					symbol->crc, symbol->name, 
+					symbol->module->name);
 			symbol = symbol->next;
 		}
 	}
@@ -735,13 +751,18 @@ int main(int argc, char **argv)
 	struct module *mod;
 	struct buffer buf = { };
 	char fname[SZ];
-	char *dump_read = NULL, *dump_write = NULL;
+	char *kernel_read = NULL, *module_read = NULL;
+	char *dump_write = NULL;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "i:mo:a")) != -1) {
+	while ((opt = getopt(argc, argv, "i:I:mo:a")) != -1) {
 		switch(opt) {
 			case 'i':
-				dump_read = optarg;
+				kernel_read = optarg;
+				break;
+			case 'I':
+				module_read = optarg;
+				external_module = 1;
 				break;
 			case 'm':
 				modversions = 1;
@@ -757,8 +778,10 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (dump_read)
-		read_dump(dump_read);
+	if (kernel_read)
+		read_dump(kernel_read, 1);
+	if (module_read)
+		read_dump(module_read, 0);
 
 	while (optind < argc) {
 		read_symbols(argv[optind++]);
-- 
1.0.GIT


