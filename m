Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUD2A51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUD2A51 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUD2A51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:57:27 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:7920 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S262347AbUD2A4U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:56:20 -0400
Subject: Re: always store MODULE_VERSION("") data?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20040427145812.GA20421@lists.us.dell.com>
References: <20040427145812.GA20421@lists.us.dell.com>
Content-Type: text/plain
Message-Id: <1083200122.9669.16.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 10:55:22 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-28 at 00:58, Matt Domsch wrote:
> Rusty,
> 
> I started going through the kernel, adding MODULE_VERSION("foo")
> everywhere, but there are a lot of modules which are not separately
> versioned, and a value of MODULE_VERSION("") would be appropriate.
> 
> How hard would it be to always include the space for the
> MODULE_VERSION("") data rather than specifying it in each file that
> doesn't care, and only modules with their own versioning could put
> MODULE_VERSION("myversion") to override the default?

Hi Matt,

	If this is desirable, I would prefer to separate "version" and
"srcversion" (or some other name).  This is done in the following patch
(we still mangle RCS-style version strings), for all modules using
MODULE_VERSION, and adds CONFIG_MODULE_SRCVERSION_ALL if you want it in
all modules.

Works here, but these changes tend to break things...
Rusty.

Name: Put Module Source Checksum In "srcversion"
Status: Tested on 2.6.6-rc2-bk5

Matt Domsch <Matt_Domsch@dell.com> writes:
> How hard would it be to always include the space for the
> MODULE_VERSION("") data rather than specifying it in each file that
> doesn't care, and only modules with their own versioning could put
> MODULE_VERSION("myversion") to override the default?

Actually, it's probably best to separate the source checksum from the
rest of the version in this case.  Then a config option will turn them
on for all modules (usually it's only for modules with MODULE_VERSION()).

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27380-linux-2.6.6-rc2-bk5/include/linux/module.h .27380-linux-2.6.6-rc2-bk5.updated/include/linux/module.h
--- .27380-linux-2.6.6-rc2-bk5/include/linux/module.h	2004-04-22 08:03:55.000000000 +1000
+++ .27380-linux-2.6.6-rc2-bk5.updated/include/linux/module.h	2004-04-28 15:16:34.000000000 +1000
@@ -140,11 +140,9 @@ extern struct module __this_module;
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27380-linux-2.6.6-rc2-bk5/init/Kconfig .27380-linux-2.6.6-rc2-bk5.updated/init/Kconfig
--- .27380-linux-2.6.6-rc2-bk5/init/Kconfig	2004-04-28 08:53:11.000000000 +1000
+++ .27380-linux-2.6.6-rc2-bk5.updated/init/Kconfig	2004-04-28 16:15:57.000000000 +1000
@@ -329,6 +329,18 @@ config MODVERSIONS
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27380-linux-2.6.6-rc2-bk5/scripts/Makefile.modpost .27380-linux-2.6.6-rc2-bk5.updated/scripts/Makefile.modpost
--- .27380-linux-2.6.6-rc2-bk5/scripts/Makefile.modpost	2004-04-28 08:53:14.000000000 +1000
+++ .27380-linux-2.6.6-rc2-bk5.updated/scripts/Makefile.modpost	2004-04-28 15:40:57.000000000 +1000
@@ -51,6 +51,7 @@ _modpost: $(modules)
 #  Includes step 3,4
 quiet_cmd_modpost = MODPOST
       cmd_modpost = scripts/modpost \
+	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a,) \
 	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
 	$(filter-out FORCE,$^)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27380-linux-2.6.6-rc2-bk5/scripts/modpost.c .27380-linux-2.6.6-rc2-bk5.updated/scripts/modpost.c
--- .27380-linux-2.6.6-rc2-bk5/scripts/modpost.c	2004-04-28 08:53:14.000000000 +1000
+++ .27380-linux-2.6.6-rc2-bk5.updated/scripts/modpost.c	2004-04-28 16:18:08.000000000 +1000
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
@@ -393,10 +395,44 @@ is_vmlinux(const char *modname)
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
@@ -423,8 +459,15 @@ read_symbols(char *modname)
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
@@ -574,6 +617,16 @@ add_depends(struct buffer *b, struct mod
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
@@ -695,7 +748,7 @@ main(int argc, char **argv)
 	char *dump_read = NULL, *dump_write = NULL;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "i:o:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:o:a")) != -1) {
 		switch(opt) {
 			case 'i':
 				dump_read = optarg;
@@ -703,6 +756,9 @@ main(int argc, char **argv)
 			case 'o':
 				dump_write = optarg;
 				break;
+			case 'a':
+				all_versions = 1;
+				break;
 			default:
 				exit(1);
 		}
@@ -725,6 +781,7 @@ main(int argc, char **argv)
 		add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
+		add_srcversion(&buf, mod);
 
 		sprintf(fname, "%s.mod.c", mod->name);
 		write_if_changed(&buf, fname);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27380-linux-2.6.6-rc2-bk5/scripts/modpost.h .27380-linux-2.6.6-rc2-bk5.updated/scripts/modpost.h
--- .27380-linux-2.6.6-rc2-bk5/scripts/modpost.h	2004-04-22 08:04:10.000000000 +1000
+++ .27380-linux-2.6.6-rc2-bk5.updated/scripts/modpost.h	2004-04-28 15:39:00.000000000 +1000
@@ -75,6 +75,7 @@ struct module {
 	int seen;
 	int skip;
 	struct buffer dev_table_buf;
+	char	     srcversion[25];
 };
 
 struct elf_info {
@@ -93,10 +94,11 @@ void handle_moddevtable(struct module *m
 
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27380-linux-2.6.6-rc2-bk5/scripts/sumversion.c .27380-linux-2.6.6-rc2-bk5.updated/scripts/sumversion.c
--- .27380-linux-2.6.6-rc2-bk5/scripts/sumversion.c	2004-04-05 09:04:50.000000000 +1000
+++ .27380-linux-2.6.6-rc2-bk5.updated/scripts/sumversion.c	2004-04-28 15:39:17.000000000 +1000
@@ -5,39 +5,6 @@
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
@@ -404,11 +370,11 @@ out:
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
@@ -428,7 +394,7 @@ static int get_version(const char *modna
 	if (!file) {
 		fprintf(stderr, "Warning: could not find versions for %s\n",
 			filelist);
-		return 0;
+		return;
 	}
 
 	sources = strchr(file, '\n');
@@ -453,12 +419,9 @@ static int get_version(const char *modna
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
@@ -488,12 +451,12 @@ out:
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
@@ -514,31 +477,15 @@ void strip_rcs_crap(char *version)
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

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

