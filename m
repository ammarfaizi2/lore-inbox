Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266170AbUJEWCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266170AbUJEWCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 18:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUJEWCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 18:02:47 -0400
Received: from linux.us.dell.com ([143.166.224.162]:15223 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266170AbUJEWCa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 18:02:30 -0400
Date: Tue, 5 Oct 2004 17:02:11 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: akpm@osdl.org, Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.9-rc3] modules: put srcversion checksum in each modinfo section
Message-ID: <20041005220211.GA15666@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the module source and header checksum into a separate modinfo field srcversion.
With CONFIG_MODULE_SRCVERSION_ALL=y, put srcversion into every module,
not just those with MODULE_VERSION("something").

Patch by Rusty Russell, trivial merging and testing by Matt Domsch

Signed-off-by: Matt Domsch <Matt_Domsch@dell.com>

 include/linux/module.h   |    6 +--
 init/Kconfig             |   12 +++++++
 scripts/Makefile.modpost |    1 
 scripts/mod/modpost.c    |   65 +++++++++++++++++++++++++++++++++++---
 scripts/mod/modpost.h    |   10 +++--
 scripts/mod/sumversion.c |   80 ++++++++---------------------------------------
 6 files changed, 96 insertions, 78 deletions

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -urNp --exclude-from=/home/mdomsch/excludes --minimal ../linux-2.5/include/linux/module.h linux-2.6-modversions/include/linux/module.h
--- ../linux-2.5/include/linux/module.h	Tue Oct  5 16:45:47 2004
+++ linux-2.6-modversions/include/linux/module.h	Tue Oct  5 16:37:56 2004
@@ -141,11 +141,9 @@ extern struct module __this_module;
            customizations, eg "rh3" or "rusty1".
 
   Using this automatically adds a checksum of the .c files and the
-  local headers to the end.  Use MODULE_VERSION("") if you want just
-  this.  Macro includes room for this.
+  local headers in "srcversion".
 */
-#define MODULE_VERSION(_version) \
-  MODULE_INFO(version, _version "\0xxxxxxxxxxxxxxxxxxxxxxxx")
+#define MODULE_VERSION(_version) MODULE_INFO(version, _version)
 
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
diff -urNp --exclude-from=/home/mdomsch/excludes --minimal ../linux-2.5/init/Kconfig linux-2.6-modversions/init/Kconfig
--- ../linux-2.5/init/Kconfig	Tue Oct  5 16:45:49 2004
+++ linux-2.6-modversions/init/Kconfig	Tue Oct  5 16:37:58 2004
@@ -370,6 +370,18 @@ config MODVERSIONS
 	  make them incompatible with the kernel you are running.  If
 	  unsure, say N.
 
+config MODULE_SRCVERSION_ALL
+	bool "Source checksum for all modules"
+	depends on MODULES
+	help
+	  Modules which contain a MODULE_VERSION get an extra "srcversion"
+	  field inserting into their modinfo section, which contains a
+    	  sum of the source files which made it.  This helps maintainers
+	  see exactly which source was used to build a module (since
+	  others sometimes change the module source without updating
+	  the version).  With this option, such a "srcversion" field
+	  will be created for all modules.  If unsure, say N.
+
 config KMOD
 	bool "Automatic kernel module loading"
 	depends on MODULES
diff -urNp --exclude-from=/home/mdomsch/excludes --minimal ../linux-2.5/scripts/Makefile.modpost linux-2.6-modversions/scripts/Makefile.modpost
--- ../linux-2.5/scripts/Makefile.modpost	Tue Oct  5 16:45:52 2004
+++ linux-2.6-modversions/scripts/Makefile.modpost	Tue Oct  5 16:38:01 2004
@@ -52,6 +52,7 @@ _modpost: $(modules)
 quiet_cmd_modpost = MODPOST
       cmd_modpost = scripts/mod/modpost            \
         $(if $(CONFIG_MODVERSIONS),-m)             \
+	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a,)  \
 	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
 	$(filter-out FORCE,$^)
 
diff -urNp --exclude-from=/home/mdomsch/excludes --minimal ../linux-2.5/scripts/mod/modpost.c linux-2.6-modversions/scripts/mod/modpost.c
--- ../linux-2.5/scripts/mod/modpost.c	Tue Oct  5 16:45:53 2004
+++ linux-2.6-modversions/scripts/mod/modpost.c	Tue Oct  5 16:38:02 2004
@@ -1,7 +1,7 @@
 /* Postprocess module symbol versions
  *
  * Copyright 2003       Kai Germaschewski
- *           2002-2003  Rusty Russell, IBM Corporation
+ * Copyright 2002-2004  Rusty Russell, IBM Corporation
  *
  * Based in part on module-init-tools/depmod.c,file2alias
  *
@@ -18,6 +18,8 @@
 int modversions = 0;
 /* Warn about undefined symbols? (do so if we have vmlinux) */
 int have_vmlinux = 0;
+/* Is CONFIG_MODULE_SRCVERSION_ALL set? */
+static int all_versions = 0;
 
 void
 fatal(const char *fmt, ...)
@@ -397,10 +399,44 @@ is_vmlinux(const char *modname)
 	return strcmp(myname, "vmlinux") == 0;
 }
 
+/* Parse tag=value strings from .modinfo section */
+static char *next_string(char *string, unsigned long *secsize)
+{
+	/* Skip non-zero chars */
+	while (string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+
+	/* Skip any zero padding. */
+	while (!string[0]) {
+		string++;
+		if ((*secsize)-- <= 1)
+			return NULL;
+	}
+	return string;
+}
+
+static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
+			 const char *tag)
+{
+	char *p;
+	unsigned int taglen = strlen(tag);
+	unsigned long size = modinfo_len;
+
+	for (p = modinfo; p; p = next_string(p, &size)) {
+		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
+			return p + taglen + 1;
+	}
+	return NULL;
+}
+
 void
 read_symbols(char *modname)
 {
 	const char *symname;
+	char *version;
 	struct module *mod;
 	struct elf_info info = { };
 	Elf_Sym *sym;
@@ -424,8 +460,15 @@ read_symbols(char *modname)
 		handle_modversions(mod, &info, sym, symname);
 		handle_moddevtable(mod, &info, sym, symname);
 	}
-	maybe_frob_version(modname, info.modinfo, info.modinfo_len,
-			   (void *)info.modinfo - (void *)info.hdr);
+
+	version = get_modinfo(info.modinfo, info.modinfo_len, "version");
+	if (version)
+		maybe_frob_rcs_version(modname, version, info.modinfo,
+				       version - (char *)info.hdr);
+	if (version || (all_versions && !is_vmlinux(modname)))
+		get_src_version(modname, mod->srcversion,
+				sizeof(mod->srcversion)-1);
+
 	parse_elf_finish(&info);
 
 	/* Our trick to get versioning for struct_module - it's
@@ -571,6 +614,16 @@ add_depends(struct buffer *b, struct mod
 }
 
 void
+add_srcversion(struct buffer *b, struct module *mod)
+{
+	if (mod->srcversion[0]) {
+		buf_printf(b, "\n");
+		buf_printf(b, "MODULE_INFO(srcversion, \"%s\");\n",
+			   mod->srcversion);
+	}
+}
+
+void
 write_if_changed(struct buffer *b, const char *fname)
 {
 	char *tmp;
@@ -691,7 +744,7 @@ main(int argc, char **argv)
 	char *dump_read = NULL, *dump_write = NULL;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "i:mo:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:mo:a")) != -1) {
 		switch(opt) {
 			case 'i':
 				dump_read = optarg;
@@ -702,6 +755,9 @@ main(int argc, char **argv)
 			case 'o':
 				dump_write = optarg;
 				break;
+			case 'a':
+				all_versions = 1;
+				break;
 			default:
 				exit(1);
 		}
@@ -724,6 +780,7 @@ main(int argc, char **argv)
 		add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
+		add_srcversion(&buf, mod);
 
 		sprintf(fname, "%s.mod.c", mod->name);
 		write_if_changed(&buf, fname);
diff -urNp --exclude-from=/home/mdomsch/excludes --minimal ../linux-2.5/scripts/mod/modpost.h linux-2.6-modversions/scripts/mod/modpost.h
--- ../linux-2.5/scripts/mod/modpost.h	Tue Oct  5 16:45:53 2004
+++ linux-2.6-modversions/scripts/mod/modpost.h	Tue Oct  5 16:38:02 2004
@@ -77,6 +77,7 @@ struct module {
 	int has_init;
 	int has_cleanup;
 	struct buffer dev_table_buf;
+	char	     srcversion[25];
 };
 
 struct elf_info {
@@ -95,10 +96,11 @@ void handle_moddevtable(struct module *m
 
 void add_moddevtable(struct buffer *buf, struct module *mod);
 
-void maybe_frob_version(const char *modfilename,
-			void *modinfo,
-			unsigned long modinfo_len,
-			unsigned long modinfo_offset);
+void maybe_frob_rcs_version(const char *modfilename,
+			    char *version,
+			    void *modinfo,
+			    unsigned long modinfo_offset);
+void get_src_version(const char *modname, char sum[], unsigned sumlen);
 
 void *grab_file(const char *filename, unsigned long *size);
 char* get_next_line(unsigned long *pos, void *file, unsigned long size);
diff -urNp --exclude-from=/home/mdomsch/excludes --minimal ../linux-2.5/scripts/mod/sumversion.c linux-2.6-modversions/scripts/mod/sumversion.c
--- ../linux-2.5/scripts/mod/sumversion.c	Tue Oct  5 16:45:53 2004
+++ linux-2.6-modversions/scripts/mod/sumversion.c	Tue Oct  5 16:38:02 2004
@@ -9,39 +9,6 @@
 #include <string.h>
 #include "modpost.h"
 
-/* Parse tag=value strings from .modinfo section */
-static char *next_string(char *string, unsigned long *secsize)
-{
-	/* Skip non-zero chars */
-	while (string[0]) {
-		string++;
-		if ((*secsize)-- <= 1)
-			return NULL;
-	}
-
-	/* Skip any zero padding. */
-	while (!string[0]) {
-		string++;
-		if ((*secsize)-- <= 1)
-			return NULL;
-	}
-	return string;
-}
-
-static char *get_modinfo(void *modinfo, unsigned long modinfo_len,
-			 const char *tag)
-{
-	char *p;
-	unsigned int taglen = strlen(tag);
-	unsigned long size = modinfo_len;
-
-	for (p = modinfo; p; p = next_string(p, &size)) {
-		if (strncmp(p, tag, taglen) == 0 && p[taglen] == '=')
-			return p + taglen + 1;
-	}
-	return NULL;
-}
-
 /*
  * Stolen form Cryptographic API.
  *
@@ -408,11 +375,11 @@ out:
 	return ret;
 }
 
-static int get_version(const char *modname, char sum[])
+/* Calc and record src checksum. */
+void get_src_version(const char *modname, char sum[], unsigned sumlen)
 {
 	void *file;
 	unsigned long len;
-	int ret = 0;
 	struct md4_ctx md;
 	char *sources, *end, *fname;
 	const char *basename;
@@ -432,7 +399,7 @@ static int get_version(const char *modna
 	if (!file) {
 		fprintf(stderr, "Warning: could not find versions for %s\n",
 			filelist);
-		return 0;
+		return;
 	}
 
 	sources = strchr(file, '\n');
@@ -457,12 +424,9 @@ static int get_version(const char *modna
 			goto release;
 	}
 
-	/* sum is of form \0<padding>. */
-	md4_final_ascii(&md, sum, 1 + strlen(sum+1));
-	ret = 1;
+	md4_final_ascii(&md, sum, sumlen);
 release:
 	release_file(file, len);
-	return ret;
 }
 
 static void write_version(const char *filename, const char *sum,
@@ -492,12 +456,12 @@ out:
 	close(fd);
 }
 
-void strip_rcs_crap(char *version)
+static int strip_rcs_crap(char *version)
 {
 	unsigned int len, full_len;
 
 	if (strncmp(version, "$Revision", strlen("$Revision")) != 0)
-		return;
+		return 0;
 
 	/* Space for version string follows. */
 	full_len = strlen(version) + strlen(version + strlen(version) + 1) + 2;
@@ -518,31 +482,15 @@ void strip_rcs_crap(char *version)
 		len++;
 	memmove(version + len, version + strlen(version),
 		full_len - strlen(version));
+	return 1;
 }
 
-/* If the modinfo contains a "version" value, then set this. */
-void maybe_frob_version(const char *modfilename,
-			void *modinfo,
-			unsigned long modinfo_len,
-			unsigned long modinfo_offset)
+/* Clean up RCS-style version numbers. */
+void maybe_frob_rcs_version(const char *modfilename,
+			    char *version,
+			    void *modinfo,
+			    unsigned long version_offset)
 {
-	char *version, *csum;
-
-	version = get_modinfo(modinfo, modinfo_len, "version");
-	if (!version)
-		return;
-
-	/* RCS $Revision gets stripped out. */
-	strip_rcs_crap(version);
-
-	/* Check against double sumversion */
-	if (strchr(version, ' '))
-		return;
-
-	/* Version contains embedded NUL: second half has space for checksum */
-	csum = version + strlen(version);
-	*(csum++) = ' ';
-	if (get_version(modfilename, csum))
-		write_version(modfilename, version,
-			      modinfo_offset + (version - (char *)modinfo));
+	if (strip_rcs_crap(version))
+		write_version(modfilename, version, version_offset);
 }
