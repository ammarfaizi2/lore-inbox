Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUECCVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUECCVk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263484AbUECCVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:21:40 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:27036 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263475AbUECCVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:21:05 -0400
Subject: Re: always store MODULE_VERSION("") data?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Matt Domsch <Matt_Domsch@dell.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040502183158.GA2136@mars.ravnborg.org>
References: <20040427145812.GA20421@lists.us.dell.com>
	 <1083200122.9669.16.camel@bach>  <20040502183158.GA2136@mars.ravnborg.org>
Content-Type: text/plain
Message-Id: <1083550817.7971.147.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 12:20:19 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-05-03 at 04:31, Sam Ravnborg wrote:
> On Thu, Apr 29, 2004 at 10:55:22AM +1000, Rusty Russell wrote:
> >  
> > +config MODULE_SRCVERSION_ALL
> > +	bool "Source checksum for all modules"
> > +	depends on MODULES
> > +	help
> > +	  Modules which contain a MODULE_VERSION get an extra "srcversion"
> > +	  field inserting into their modinfo section, which contains a
> > +    	  sum of the source files which made it.  This helps maintainers
> > +	  see exactly which source was used to build a module (since
> > +	  others sometimes change the module source without updating
> > +	  the version).  With this option, such a "srcversion" field
> > +	  will be created for all modules.  If unsure, say N.
> 
> I had to read the above twice to get the fact that it was added to all modules regardless.
> Move the second last sentence first, so the explanation comes after?
> Any reason not to enable it pr. default, at least to give it some exposure?

Good question.  I didn't want to slow the build process, but measuring
here gives no real difference.  My original feeling was that if the
author doesn't care enough to put a version string in, then usually
they're relying on the "oh, you're using 2.6.5" method and won't use
srcversion either.

Patch below makes it unconditional.

Name: Put Module Source Checksum In "srcversion"
Status: Booted on 2.6.6-rc3-bk4

Matt Domsch <Matt_Domsch@dell.com> writes:
> How hard would it be to always include the space for the
> MODULE_VERSION("") data rather than specifying it in each file that
> doesn't care, and only modules with their own versioning could put
> MODULE_VERSION("myversion") to override the default?

Actually, it's probably best to separate the source checksum from the
rest of the version, and do it for all modules: it's so fast it has no
measurable effect on build times here.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27380-linux-2.6.6-rc2-bk5/include/linux/module.h .27380-linux-2.6.6-rc2-bk5.updated/include/linux/module.h
--- .27380-linux-2.6.6-rc2-bk5/include/linux/module.h	2004-04-22 08:03:55.000000000 +1000
+++ .27380-linux-2.6.6-rc2-bk5.updated/include/linux/module.h	2004-04-28 15:16:34.000000000 +1000
@@ -140,11 +140,9 @@ extern struct module __this_module;
            customizations, eg "rh3" or "rusty1".
 
-  Using this automatically adds a checksum of the .c files and the
-  local headers to the end.  Use MODULE_VERSION("") if you want just
-  this.  Macro includes room for this.
+  Note that the checksum of the .c file and local headers is always
+  included in a modules "srcversion" modinfo field.
 */
-#define MODULE_VERSION(_version) \
-  MODULE_INFO(version, _version "\0xxxxxxxxxxxxxxxxxxxxxxxx")
+#define MODULE_VERSION(_version) MODULE_INFO(version, _version)
 
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
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
+	if (!is_vmlinux(modname))
+		get_src_version(modname, mod->srcversion,
+				sizeof(mod->srcversion)-1);
+
 	parse_elf_finish(&info);
 
 	/* Our trick to get versioning for struct_module - it's
@@ -574,6 +617,14 @@ add_depends(struct buffer *b, struct mod
 }
 
 void
+add_srcversion(struct buffer *b, struct module *mod)
+{
+	buf_printf(b, "\n");
+	buf_printf(b, "MODULE_INFO(srcversion, \"%s\");\n",
+		   mod->srcversion);
+}
+
+void
 write_if_changed(struct buffer *b, const char *fname)
 {
 	char *tmp;
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

