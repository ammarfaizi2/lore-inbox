Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUIDNjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUIDNjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUIDNjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:39:11 -0400
Received: from lists.us.dell.com ([143.166.224.162]:58947 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S261375AbUIDNhx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:37:53 -0400
Date: Sat, 4 Sep 2004 08:37:34 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: always store MODULE_VERSION("") data?
Message-ID: <20040904133734.GA13331@lists.us.dell.com>
References: <20040427145812.GA20421@lists.us.dell.com> <1083200122.9669.16.camel@bach> <20040430025558.GA26551@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430025558.GA26551@lists.us.dell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 09:55:58PM -0500, Matt Domsch wrote:
> On Thu, Apr 29, 2004 at 10:55:22AM +1000, Rusty Russell wrote:
> > On Wed, 2004-04-28 at 00:58, Matt Domsch wrote:
> > > How hard would it be to always include the space for the
> > > MODULE_VERSION("") data rather than specifying it in each file that
> > > doesn't care, and only modules with their own versioning could put
> > > MODULE_VERSION("myversion") to override the default?
> > 
> > 	If this is desirable, I would prefer to separate "version" and
> > "srcversion" (or some other name).  This is done in the following patch
> > (we still mangle RCS-style version strings), for all modules using
> > MODULE_VERSION, and adds CONFIG_MODULE_SRCVERSION_ALL if you want it in
> > all modules.
> > 
> > Works here, but these changes tend to break things...
> 
> Works for me too.  All modules regardless if if they have a
> MODULE_VERSION() entry get the srcversion field in .modinfo.  If they
> also have a MODULE_VERSION(), that data shows up in .modinfo also.
> This is exactly what I wanted.

Rusty, digging up the long forgotten past here.  This works for me.  I
re-diffed your patch to 2.6.9-rc, updated patch attached.  Please
review and submit.

Signed-off-by: Matt Domsch

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

===== include/linux/module.h 1.79 vs edited =====
--- 1.79/include/linux/module.h	2004-06-27 02:19:28 -05:00
+++ edited/include/linux/module.h	2004-09-03 17:04:05 -05:00
@@ -141,11 +141,9 @@
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
===== init/Kconfig 1.48 vs edited =====
--- 1.48/init/Kconfig	2004-08-31 03:00:08 -05:00
+++ edited/init/Kconfig	2004-09-03 17:01:00 -05:00
@@ -360,6 +360,18 @@
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
===== scripts/Makefile.modpost 1.13 vs edited =====
--- 1.13/scripts/Makefile.modpost	2004-08-15 04:54:12 -05:00
+++ edited/scripts/Makefile.modpost	2004-09-03 16:48:05 -05:00
@@ -52,6 +52,7 @@
 quiet_cmd_modpost = MODPOST
       cmd_modpost = scripts/mod/modpost            \
         $(if $(CONFIG_MODVERSIONS),-m)             \
+	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a,)  \
 	$(if $(KBUILD_EXTMOD),-i,-o) $(symverfile) \
 	$(filter-out FORCE,$^)
 
===== scripts/mod/modpost.c 1.32 vs edited =====
--- 1.32/scripts/mod/modpost.c	2004-08-15 04:54:12 -05:00
+++ edited/scripts/mod/modpost.c	2004-09-03 16:44:19 -05:00
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
@@ -393,10 +395,44 @@
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
@@ -423,8 +459,15 @@
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
@@ -574,6 +617,16 @@
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
@@ -694,7 +747,7 @@
 	char *dump_read = NULL, *dump_write = NULL;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "i:mo:")) != -1) {
+	while ((opt = getopt(argc, argv, "i:mo:a")) != -1) {
 		switch(opt) {
 			case 'i':
 				dump_read = optarg;
@@ -705,6 +758,9 @@
 			case 'o':
 				dump_write = optarg;
 				break;
+			case 'a':
+				all_versions = 1;
+				break;
 			default:
 				exit(1);
 		}
@@ -727,6 +783,7 @@
 		add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
+		add_srcversion(&buf, mod);
 
 		sprintf(fname, "%s.mod.c", mod->name);
 		write_if_changed(&buf, fname);
===== scripts/mod/modpost.h 1.7 vs edited =====
--- 1.7/scripts/mod/modpost.h	2004-07-22 17:51:17 -05:00
+++ edited/scripts/mod/modpost.h	2004-09-03 16:45:05 -05:00
@@ -75,6 +75,7 @@
 	int seen;
 	int skip;
 	struct buffer dev_table_buf;
+	char	     srcversion[25];
 };
 
 struct elf_info {
@@ -93,10 +94,11 @@
 
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
===== scripts/mod/sumversion.c 1.6 vs edited =====
--- 1.6/scripts/mod/sumversion.c	2004-08-24 04:08:48 -05:00
+++ edited/scripts/mod/sumversion.c	2004-09-03 16:43:33 -05:00
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
@@ -404,11 +371,11 @@
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
@@ -428,7 +395,7 @@
 	if (!file) {
 		fprintf(stderr, "Warning: could not find versions for %s\n",
 			filelist);
-		return 0;
+		return;
 	}
 
 	sources = strchr(file, '\n');
@@ -453,12 +420,9 @@
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
@@ -488,12 +452,12 @@
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
@@ -514,31 +478,15 @@
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
