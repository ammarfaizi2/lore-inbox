Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbUBXLHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 06:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUBXLHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 06:07:43 -0500
Received: from dp.samba.org ([66.70.73.150]:58572 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262223AbUBXLHN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 06:07:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Brian King <brking@us.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Question on MODULE_VERSION macro 
In-reply-to: Your message of "Mon, 23 Feb 2004 22:17:18 BST."
             <20040223211718.GA7610@mars.ravnborg.org> 
Date: Tue, 24 Feb 2004 17:13:40 +1100
Message-Id: <20040224110724.0FA0D2C0CE@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040223211718.GA7610@mars.ravnborg.org> you write:
> But this information is already available in the .module.o.cmd file,
> so no reason to parse that information up from the .c file -
> and eventually having troubles with .s files.
> 
> You can get rid of parse_cpp_line(), include_file(),
> and some of the helpers when implementing this algorithm. So all
> in all a good simplification.

Yep, fixed this, and fixed the broken modules_install for Andrew.
This one actually boot tested.

> Note also that in the original implementation you have missed
> release_file() in a few places. But when you implement the above
> you will hit them.

Fixed them too.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Add a MODULE_VERSION macro
Author: Rusty Russell
Status: Tested on 2.6.3-bk4

At the kernel summit, various people asked for a MODULE_VERSION
macro to store module strings (for later access through sysfs).
A simple md4 is needed to identify changes in modules which,
inevitably, do not update the version.  It skips whitespace and
comments, and includes #includes which are in the same dir.

The module versions should be set according to this definition,
based on the RPM one, or CVS Revision tags.  Violators will be shot.

 [<epoch>`:']<version>[`-'<extraversion>]
 <epoch>: A (small) unsigned integer which allows you to start versions
          anew. If not mentioned, it's zero.  eg. "2:1.0" is after
     "1:2.0".
 <version>: The <version> may contain only alphanumerics.
 <extraversion>: Like <version>, but inserted for local
          customizations, eg "rh3" or "rusty1".

Comparison of two versions (assuming same epoch):

Split each into all-digit and all-alphabetical parts.  Compare each
one one at a time: digit parts numerically, alphabetical in ASCII
order.  So 0.10 comes after 0.9.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/include/linux/module.h .29265-linux-2.6.3-bk4.updated/include/linux/module.h
--- .29265-linux-2.6.3-bk4/include/linux/module.h	2004-02-04 15:39:14.000000000 +1100
+++ .29265-linux-2.6.3-bk4.updated/include/linux/module.h	2004-02-24 13:31:33.000000000 +1100
@@ -127,6 +127,24 @@ extern const struct gtype##_id __mod_##g
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
 
+/* Version of form [<epoch>:]<version>[-<extra-version>].
+   Or for CVS/RCS ID version, everything but the number is stripped.
+  <epoch>: A (small) unsigned integer which allows you to start versions
+           anew. If not mentioned, it's zero.  eg. "2:1.0" is after
+	   "1:2.0".
+  <version>: The <version> may contain only alphanumerics and the
+           character `.'.  Ordered by numeric sort for numeric parts,
+	   ascii sort for ascii parts (as per RPM or DEB algorithm).
+  <extraversion>: Like <version>, but inserted for local
+           customizations, eg "rh3" or "rusty1".
+
+  Using this automatically adds a checksum of the .c files and the
+  local headers to the end.  Use MODULE_VERSION("") if you want just
+  this.  Macro includes room for this.
+*/
+#define MODULE_VERSION(_version) \
+  MODULE_INFO(version, _version "\0xxxxxxxxxxxxxxxxxxxxxxxx")
+
 /* Given an address, look for it in the exception tables */
 const struct exception_table_entry *search_exception_tables(unsigned long add);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/scripts/Makefile .29265-linux-2.6.3-bk4.updated/scripts/Makefile
--- .29265-linux-2.6.3-bk4/scripts/Makefile	2003-09-29 10:26:16.000000000 +1000
+++ .29265-linux-2.6.3-bk4.updated/scripts/Makefile	2004-02-24 13:31:33.000000000 +1100
@@ -12,7 +12,7 @@ host-progs	:= fixdep split-include conma
 		   mk_elfconfig pnmtologo bin2c
 always		:= $(host-progs) empty.o
 
-modpost-objs	:= modpost.o file2alias.o
+modpost-objs	:= modpost.o file2alias.o sumversion.o
 
 subdir-$(CONFIG_MODVERSIONS)	+= genksyms
 
@@ -24,7 +24,7 @@ $(addprefix $(obj)/,$(filter-out fixdep,
 
 # dependencies on generated files need to be listed explicitly
 
-$(obj)/modpost.o $(obj)/file2alias.o: $(obj)/elfconfig.h
+$(obj)/modpost.o $(obj)/file2alias.o $(obj)/sumversion.o: $(obj)/elfconfig.h
 
 quiet_cmd_elfconfig = MKELF   $@
       cmd_elfconfig = $(obj)/mk_elfconfig $(ARCH) < $< > $@
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/scripts/Makefile.build .29265-linux-2.6.3-bk4.updated/scripts/Makefile.build
--- .29265-linux-2.6.3-bk4/scripts/Makefile.build	2003-10-09 18:03:05.000000000 +1000
+++ .29265-linux-2.6.3-bk4.updated/scripts/Makefile.build	2004-02-24 13:31:33.000000000 +1100
@@ -64,8 +64,6 @@ endif
 
 # We keep a list of all modules in $(MODVERDIR)
 
-touch-module = @echo $(@:.o=.ko) > $(MODVERDIR)/$(@F:.o=.mod)
-
 __build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
 	 $(if $(KBUILD_MODULES),$(obj-m)) \
 	 $(subdir-ym) $(always)
@@ -178,7 +176,7 @@ endef
 
 $(single-used-m): %.o: %.c FORCE
 	$(call if_changed_rule,cc_o_c)
-	$(touch-module)
+	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
 
 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
@@ -273,7 +271,7 @@ $(multi-used-y) : %.o: $(multi-objs-y) F
 
 $(multi-used-m) : %.o: $(multi-objs-m) FORCE
 	$(call if_changed,link_multi-m)
-	$(touch-module)
+	@{ echo $(@:.o=.ko); echo $(link_multi_deps); } > $(MODVERDIR)/$(@F:.o=.mod)
 
 targets += $(multi-used-y) $(multi-used-m)
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/scripts/Makefile.modinst .29265-linux-2.6.3-bk4.updated/scripts/Makefile.modinst
--- .29265-linux-2.6.3-bk4/scripts/Makefile.modinst	2003-09-22 10:04:52.000000000 +1000
+++ .29265-linux-2.6.3-bk4.updated/scripts/Makefile.modinst	2004-02-24 13:31:33.000000000 +1100
@@ -9,7 +9,7 @@ include scripts/Makefile.lib
 
 #
 
-__modules := $(shell cat /dev/null $(wildcard $(MODVERDIR)/*.mod))
+__modules := $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
 ifneq ($(filter-out $(modules),$(__modules)),)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/scripts/Makefile.modpost .29265-linux-2.6.3-bk4.updated/scripts/Makefile.modpost
--- .29265-linux-2.6.3-bk4/scripts/Makefile.modpost	2003-09-29 10:26:16.000000000 +1000
+++ .29265-linux-2.6.3-bk4.updated/scripts/Makefile.modpost	2004-02-24 13:31:33.000000000 +1100
@@ -10,10 +10,11 @@ include scripts/Makefile.lib
 
 #
 
-__modules := $(shell cat /dev/null $(wildcard $(MODVERDIR)/*.mod))
+__modules := $(shell head -q -n1 /dev/null $(wildcard $(MODVERDIR)/*.mod))
 modules := $(patsubst %.o,%.ko,$(wildcard $(__modules:.ko=.o)))
 
 ifneq ($(filter-out $(modules),$(__modules)),)
+  $(warning Trouble: $(__modules) )
   $(warning *** Uh-oh, you have stale module entries. You messed with SUBDIRS,)
   $(warning     do not complain if something goes wrong.)
 endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/scripts/modpost.c .29265-linux-2.6.3-bk4.updated/scripts/modpost.c
--- .29265-linux-2.6.3-bk4/scripts/modpost.c	2004-02-18 23:54:38.000000000 +1100
+++ .29265-linux-2.6.3-bk4.updated/scripts/modpost.c	2004-02-24 13:31:33.000000000 +1100
@@ -65,15 +65,15 @@ new_module(char *modname)
 	struct module *mod;
 	char *p;
 	
+	mod = NOFAIL(malloc(sizeof(*mod)));
+	memset(mod, 0, sizeof(*mod));
+	mod->name = NOFAIL(strdup(modname));
+
 	/* strip trailing .o */
-	p = strstr(modname, ".o");
+	p = strstr(mod->name, ".o");
 	if (p)
 		*p = 0;
 
-	mod = NOFAIL(malloc(sizeof(*mod)));
-	memset(mod, 0, sizeof(*mod));
-	mod->name = modname;
-
 	/* add to list */
 	mod->next = modules;
 	modules = mod;
@@ -194,26 +194,25 @@ grab_file(const char *filename, unsigned
 	int fd;
 
 	fd = open(filename, O_RDONLY);
-	if (fd < 0) {
-		perror(filename);
-		abort();
-	}
-	if (fstat(fd, &st) != 0) {
-		perror(filename);
-		abort();
-	}
+	if (fstat(fd, &st) != 0)
+		return NULL;
 
 	*size = st.st_size;
 	map = mmap(NULL, *size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
-	if (map == MAP_FAILED) {
-		perror(filename);
-		abort();
-	}
 	close(fd);
+
+	if (map == MAP_FAILED)
+		return NULL;
 	return map;
 }
 
 void
+release_file(void *file, unsigned long size)
+{
+	munmap(file, size);
+}
+
+void
 parse_elf(struct elf_info *info, const char *filename)
 {
 	unsigned int i;
@@ -222,6 +221,10 @@ parse_elf(struct elf_info *info, const c
 	Elf_Sym  *sym;
 
 	hdr = grab_file(filename, &info->size);
+	if (!hdr) {
+		perror(filename);
+		abort();
+	}
 	info->hdr = hdr;
 	if (info->size < sizeof(*hdr))
 		goto truncated;
@@ -239,11 +242,19 @@ parse_elf(struct elf_info *info, const c
 		sechdrs[i].sh_offset = TO_NATIVE(sechdrs[i].sh_offset);
 		sechdrs[i].sh_size   = TO_NATIVE(sechdrs[i].sh_size);
 		sechdrs[i].sh_link   = TO_NATIVE(sechdrs[i].sh_link);
+		sechdrs[i].sh_name   = TO_NATIVE(sechdrs[i].sh_name);
 	}
 	/* Find symbol table. */
 	for (i = 1; i < hdr->e_shnum; i++) {
+		const char *secstrings
+			= (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
 		if (sechdrs[i].sh_offset > info->size)
 			goto truncated;
+		if (strcmp(secstrings+sechdrs[i].sh_name, ".modinfo") == 0) {
+			info->modinfo = (void *)hdr + sechdrs[i].sh_offset;
+			info->modinfo_len = sechdrs[i].sh_size;
+		}
 		if (sechdrs[i].sh_type != SHT_SYMTAB)
 			continue;
 
@@ -274,7 +285,7 @@ parse_elf(struct elf_info *info, const c
 void
 parse_elf_finish(struct elf_info *info)
 {
-	munmap(info->hdr, info->size);
+	release_file(info->hdr, info->size);
 }
 
 #define CRC_PFX     MODULE_SYMBOL_PREFIX "__crc_"
@@ -372,6 +383,8 @@ read_symbols(char *modname)
 		handle_modversions(mod, &info, sym, symname);
 		handle_moddevtable(mod, &info, sym, symname);
 	}
+	maybe_frob_version(modname, info.modinfo, info.modinfo_len,
+			   (void *)info.modinfo - (void *)info.hdr);
 	parse_elf_finish(&info);
 
 	/* Our trick to get versioning for struct_module - it's
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/scripts/modpost.h .29265-linux-2.6.3-bk4.updated/scripts/modpost.h
--- .29265-linux-2.6.3-bk4/scripts/modpost.h	2003-09-22 10:06:44.000000000 +1000
+++ .29265-linux-2.6.3-bk4.updated/scripts/modpost.h	2004-02-24 13:31:33.000000000 +1100
@@ -80,9 +80,19 @@ struct elf_info {
 	Elf_Sym      *symtab_start;
 	Elf_Sym      *symtab_stop;
 	const char   *strtab;
+	char	     *modinfo;
+	unsigned int modinfo_len;
 };
 
 void handle_moddevtable(struct module *mod, struct elf_info *info,
 			Elf_Sym *sym, const char *symname);
 
 void add_moddevtable(struct buffer *buf, struct module *mod);
+
+void maybe_frob_version(const char *modfilename,
+			void *modinfo,
+			unsigned long modinfo_len,
+			unsigned long modinfo_offset);
+
+void *grab_file(const char *filename, unsigned long *size);
+void release_file(void *file, unsigned long size);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .29265-linux-2.6.3-bk4/scripts/sumversion.c .29265-linux-2.6.3-bk4.updated/scripts/sumversion.c
--- .29265-linux-2.6.3-bk4/scripts/sumversion.c	1970-01-01 10:00:00.000000000 +1000
+++ .29265-linux-2.6.3-bk4.updated/scripts/sumversion.c	2004-02-24 13:32:58.000000000 +1100
@@ -0,0 +1,550 @@
+#include <netinet/in.h>
+#include <stdint.h>
+#include <ctype.h>
+#include <errno.h>
+#include <string.h>
+#include "modpost.h"
+
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
+/* 
+ * Stolen form Cryptographic API.
+ *
+ * MD4 Message Digest Algorithm (RFC1320).
+ *
+ * Implementation derived from Andrew Tridgell and Steve French's
+ * CIFS MD4 implementation, and the cryptoapi implementation
+ * originally based on the public domain implementation written
+ * by Colin Plumb in 1993.
+ *
+ * Copyright (c) Andrew Tridgell 1997-1998.
+ * Modified by Steve French (sfrench@us.ibm.com) 2002
+ * Copyright (c) Cryptoapi developers.
+ * Copyright (c) 2002 David S. Miller (davem@redhat.com)
+ * Copyright (c) 2002 James Morris <jmorris@intercode.com.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+#define MD4_DIGEST_SIZE		16
+#define MD4_HMAC_BLOCK_SIZE	64
+#define MD4_BLOCK_WORDS		16
+#define MD4_HASH_WORDS		4
+
+struct md4_ctx {
+	uint32_t hash[MD4_HASH_WORDS];
+	uint32_t block[MD4_BLOCK_WORDS];
+	uint64_t byte_count;
+};
+
+static inline uint32_t lshift(uint32_t x, unsigned int s)
+{
+	x &= 0xFFFFFFFF;
+	return ((x << s) & 0xFFFFFFFF) | (x >> (32 - s));
+}
+
+static inline uint32_t F(uint32_t x, uint32_t y, uint32_t z)
+{
+	return (x & y) | ((~x) & z);
+}
+
+static inline uint32_t G(uint32_t x, uint32_t y, uint32_t z)
+{
+	return (x & y) | (x & z) | (y & z);
+}
+
+static inline uint32_t H(uint32_t x, uint32_t y, uint32_t z)
+{
+	return x ^ y ^ z;
+}
+                        
+#define ROUND1(a,b,c,d,k,s) (a = lshift(a + F(b,c,d) + k, s))
+#define ROUND2(a,b,c,d,k,s) (a = lshift(a + G(b,c,d) + k + (uint32_t)0x5A827999,s))
+#define ROUND3(a,b,c,d,k,s) (a = lshift(a + H(b,c,d) + k + (uint32_t)0x6ED9EBA1,s))
+
+/* XXX: this stuff can be optimized */
+static inline void le32_to_cpu_array(uint32_t *buf, unsigned int words)
+{
+	while (words--) {
+		*buf = ntohl(*buf);
+		buf++;
+	}
+}
+
+static inline void cpu_to_le32_array(uint32_t *buf, unsigned int words)
+{
+	while (words--) {
+		*buf = htonl(*buf);
+		buf++;
+	}
+}
+
+static void md4_transform(uint32_t *hash, uint32_t const *in)
+{
+	uint32_t a, b, c, d;
+
+	a = hash[0];
+	b = hash[1];
+	c = hash[2];
+	d = hash[3];
+
+	ROUND1(a, b, c, d, in[0], 3);
+	ROUND1(d, a, b, c, in[1], 7);
+	ROUND1(c, d, a, b, in[2], 11);
+	ROUND1(b, c, d, a, in[3], 19);
+	ROUND1(a, b, c, d, in[4], 3);
+	ROUND1(d, a, b, c, in[5], 7);
+	ROUND1(c, d, a, b, in[6], 11);
+	ROUND1(b, c, d, a, in[7], 19);
+	ROUND1(a, b, c, d, in[8], 3);
+	ROUND1(d, a, b, c, in[9], 7);
+	ROUND1(c, d, a, b, in[10], 11);
+	ROUND1(b, c, d, a, in[11], 19);
+	ROUND1(a, b, c, d, in[12], 3);
+	ROUND1(d, a, b, c, in[13], 7);
+	ROUND1(c, d, a, b, in[14], 11);
+	ROUND1(b, c, d, a, in[15], 19);
+
+	ROUND2(a, b, c, d,in[ 0], 3);
+	ROUND2(d, a, b, c, in[4], 5);
+	ROUND2(c, d, a, b, in[8], 9);
+	ROUND2(b, c, d, a, in[12], 13);
+	ROUND2(a, b, c, d, in[1], 3);
+	ROUND2(d, a, b, c, in[5], 5);
+	ROUND2(c, d, a, b, in[9], 9);
+	ROUND2(b, c, d, a, in[13], 13);
+	ROUND2(a, b, c, d, in[2], 3);
+	ROUND2(d, a, b, c, in[6], 5);
+	ROUND2(c, d, a, b, in[10], 9);
+	ROUND2(b, c, d, a, in[14], 13);
+	ROUND2(a, b, c, d, in[3], 3);
+	ROUND2(d, a, b, c, in[7], 5);
+	ROUND2(c, d, a, b, in[11], 9);
+	ROUND2(b, c, d, a, in[15], 13);
+
+	ROUND3(a, b, c, d,in[ 0], 3);
+	ROUND3(d, a, b, c, in[8], 9);
+	ROUND3(c, d, a, b, in[4], 11);
+	ROUND3(b, c, d, a, in[12], 15);
+	ROUND3(a, b, c, d, in[2], 3);
+	ROUND3(d, a, b, c, in[10], 9);
+	ROUND3(c, d, a, b, in[6], 11);
+	ROUND3(b, c, d, a, in[14], 15);
+	ROUND3(a, b, c, d, in[1], 3);
+	ROUND3(d, a, b, c, in[9], 9);
+	ROUND3(c, d, a, b, in[5], 11);
+	ROUND3(b, c, d, a, in[13], 15);
+	ROUND3(a, b, c, d, in[3], 3);
+	ROUND3(d, a, b, c, in[11], 9);
+	ROUND3(c, d, a, b, in[7], 11);
+	ROUND3(b, c, d, a, in[15], 15);
+
+	hash[0] += a;
+	hash[1] += b;
+	hash[2] += c;
+	hash[3] += d;
+}
+
+static inline void md4_transform_helper(struct md4_ctx *ctx)
+{
+	le32_to_cpu_array(ctx->block, sizeof(ctx->block) / sizeof(uint32_t));
+	md4_transform(ctx->hash, ctx->block);
+}
+
+static void md4_init(struct md4_ctx *mctx)
+{
+	mctx->hash[0] = 0x67452301;
+	mctx->hash[1] = 0xefcdab89;
+	mctx->hash[2] = 0x98badcfe;
+	mctx->hash[3] = 0x10325476;
+	mctx->byte_count = 0;
+}
+
+static void md4_update(struct md4_ctx *mctx,
+		       const unsigned char *data, unsigned int len)
+{
+	const uint32_t avail = sizeof(mctx->block) - (mctx->byte_count & 0x3f);
+
+	mctx->byte_count += len;
+
+	if (avail > len) {
+		memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
+		       data, len);
+		return;
+	}
+
+	memcpy((char *)mctx->block + (sizeof(mctx->block) - avail),
+	       data, avail);
+
+	md4_transform_helper(mctx);
+	data += avail;
+	len -= avail;
+
+	while (len >= sizeof(mctx->block)) {
+		memcpy(mctx->block, data, sizeof(mctx->block));
+		md4_transform_helper(mctx);
+		data += sizeof(mctx->block);
+		len -= sizeof(mctx->block);
+	}
+
+	memcpy(mctx->block, data, len);
+}
+
+static void md4_final_ascii(struct md4_ctx *mctx, char *out, unsigned int len)
+{
+	const unsigned int offset = mctx->byte_count & 0x3f;
+	char *p = (char *)mctx->block + offset;
+	int padding = 56 - (offset + 1);
+
+	*p++ = 0x80;
+	if (padding < 0) {
+		memset(p, 0x00, padding + sizeof (uint64_t));
+		md4_transform_helper(mctx);
+		p = (char *)mctx->block;
+		padding = 56;
+	}
+
+	memset(p, 0, padding);
+	mctx->block[14] = mctx->byte_count << 3;
+	mctx->block[15] = mctx->byte_count >> 29;
+	le32_to_cpu_array(mctx->block, (sizeof(mctx->block) -
+	                  sizeof(uint64_t)) / sizeof(uint32_t));
+	md4_transform(mctx->hash, mctx->block);
+	cpu_to_le32_array(mctx->hash, sizeof(mctx->hash) / sizeof(uint32_t));
+	
+	snprintf(out, len, "%08X%08X%08X%08X",
+		 mctx->hash[0], mctx->hash[1], mctx->hash[2], mctx->hash[3]);
+}
+
+static inline void add_char(unsigned char c, struct md4_ctx *md)
+{
+	md4_update(md, &c, 1);
+}
+
+static int parse_string(const char *file, unsigned long len,
+			struct md4_ctx *md)
+{
+	unsigned long i;
+
+	add_char(file[0], md);
+	for (i = 1; i < len; i++) {
+		add_char(file[i], md);
+		if (file[i] == '"' && file[i-1] != '\\')
+			break;
+	}
+	return i;
+}
+
+static int parse_comment(const char *file, unsigned long len)
+{
+	unsigned long i;
+
+	for (i = 2; i < len; i++) {
+		if (file[i-1] == '*' && file[i] == '/')
+			break;
+	}
+	return i;
+}
+
+/* FIXME: Handle .s files differently (eg. # starts comments) --RR */
+static int parse_file(const char *fname, struct md4_ctx *md)
+{
+	char *file;
+	unsigned long i, len;
+
+	file = grab_file(fname, &len);
+	if (!file)
+		return 0;
+
+	for (i = 0; i < len; i++) {
+		/* Collapse and ignore \ and CR. */
+		if (file[i] == '\\' && (i+1 < len) && file[i+1] == '\n') {
+			i++;
+			continue;
+		}
+
+		/* Ignore whitespace */
+		if (isspace(file[i]))
+			continue;
+
+		/* Handle strings as whole units */
+		if (file[i] == '"') {
+			i += parse_string(file+i, len - i, md);
+			continue;
+		}
+
+		/* Comments: ignore */
+		if (file[i] == '/' && file[i+1] == '*') {
+			i += parse_comment(file+i, len - i);
+			continue;
+		}
+
+		add_char(file[i], md);
+	}
+	release_file(file, len);
+	return 1;
+}
+
+/* We have dir/file.o.  Open dir/.file.o.cmd, look for deps_ line to
+ * figure out source file. */
+static int parse_source_files(const char *objfile, struct md4_ctx *md)
+{
+	char *cmd, *file, *p, *end;
+	const char *base;
+	unsigned long flen;
+	int dirlen, ret = 0;
+
+	cmd = malloc(strlen(objfile) + sizeof("..cmd"));
+
+	base = strrchr(objfile, '/');
+	if (base) {
+		base++;
+		dirlen = base - objfile;
+		sprintf(cmd, "%.*s.%s.cmd", dirlen, objfile, base);
+	} else {
+		dirlen = 0;
+		sprintf(cmd, ".%s.cmd", objfile);
+	}
+
+	file = grab_file(cmd, &flen);
+	if (!file) {
+		fprintf(stderr, "Warning: could not find %s for %s\n",
+			cmd, objfile);
+		goto out;
+	}
+
+	/* There will be a line like so:
+		deps_drivers/net/dummy.o := \
+		  drivers/net/dummy.c \
+		    $(wildcard include/config/net/fastroute.h) \
+		  include/linux/config.h \
+		    $(wildcard include/config/h.h) \
+		  include/linux/module.h \
+
+	   Sum all files in the same dir or subdirs.
+	*/
+	/* Strictly illegal: file is not nul terminated. */
+	p = strstr(file, "\ndeps_");
+	if (!p) {
+		fprintf(stderr, "Warning: could not find deps_ line in %s\n",
+			cmd);
+		goto out_file;
+	}
+	p = strstr(p, ":=");
+	if (!p) {
+		fprintf(stderr, "Warning: could not find := line in %s\n",
+			cmd);
+		goto out_file;
+	}
+	p += strlen(":=");
+	p += strspn(p, " \\\n");
+
+	end = strstr(p, "\n\n");
+	if (!end) {
+		fprintf(stderr, "Warning: could not find end line in %s\n",
+			cmd);
+		goto out_file;
+	}
+
+	while (p < end) {
+		unsigned int len;
+
+		len = strcspn(p, " \\\n");
+		if (memcmp(objfile, p, dirlen) == 0) {
+			char source[len + 1];
+
+			memcpy(source, p, len);
+			source[len] = '\0';
+			printf("parsing %s\n", source);
+			if (!parse_file(source, md)) {
+				fprintf(stderr,
+					"Warning: could not open %s: %s\n",
+					source, strerror(errno));
+				goto out_file;
+			}
+		}
+		p += len;
+		p += strspn(p, " \\\n");
+	}
+
+	/* Everyone parsed OK */
+	ret = 1;
+out_file:
+	release_file(file, flen);
+out:
+	free(cmd);
+	return ret;
+}
+
+static int get_version(const char *modname, char sum[])
+{
+	void *file;
+	unsigned long len;
+	int ret = 0;
+	struct md4_ctx md;
+	char *sources, *end, *fname;
+	const char *basename;
+	char filelist[sizeof(".tmp_versions/%s.mod") + strlen(modname)];
+
+	/* Source files for module are in .tmp_versions/modname.mod,
+	   after the first line. */
+	if (strrchr(modname, '/'))
+		basename = strrchr(modname, '/') + 1;
+	else
+		basename = modname;
+	sprintf(filelist, ".tmp_versions/%s", basename);
+	/* Truncate .o, add .mod */
+	strcpy(filelist + strlen(filelist)-2, ".mod");
+
+	file = grab_file(filelist, &len);
+	if (!file) {
+		fprintf(stderr, "Warning: could not find versions for %s\n",
+			filelist);
+		return 0;
+	}
+
+	sources = strchr(file, '\n');
+	if (!sources) {
+		fprintf(stderr, "Warning: malformed versions file for %s\n",
+			modname);
+		goto release;
+	}
+
+	sources++;
+	end = strchr(sources, '\n');
+	if (!end) {
+		fprintf(stderr, "Warning: bad ending versions file for %s\n",
+			modname);
+		goto release;
+	}
+	*end = '\0';
+
+	md4_init(&md);
+	for (fname = strtok(sources, " "); fname; fname = strtok(NULL, " ")) {
+		if (!parse_source_files(fname, &md))
+			goto release;
+	}
+
+	/* sum is of form \0<padding>. */ 
+	md4_final_ascii(&md, sum, 1 + strlen(sum+1));
+	ret = 1;
+release:
+	release_file(file, len);
+	return ret;
+}
+
+static void write_version(const char *filename, const char *sum,
+			  unsigned long offset)
+{
+	int fd;
+
+	fd = open(filename, O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "Warning: changing sum in %s failed: %s\n",
+			filename, strerror(errno));
+		return;
+	}
+
+	if (lseek(fd, offset, SEEK_SET) == (off_t)-1) {
+		fprintf(stderr, "Warning: changing sum in %s:%lu failed: %s\n",
+			filename, offset, strerror(errno));
+		goto out;
+	}
+
+	if (write(fd, sum, strlen(sum)+1) != strlen(sum)+1) {
+		fprintf(stderr, "Warning: writing sum in %s failed: %s\n",
+			filename, strerror(errno));
+		goto out;
+	}
+out:
+	close(fd);
+}
+
+void strip_rcs_crap(char *version)
+{
+	unsigned int len, full_len;
+
+	if (strncmp(version, "$Revision", strlen("$Revision")) != 0)
+		return;
+
+	/* Space for version string follows. */
+	full_len = strlen(version) + strlen(version + strlen(version) + 1) + 2;
+
+	/* Move string to start with version number: prefix will be
+	 * $Revision$ or $Revision: */
+	len = strlen("$Revision");
+	if (version[len] == ':' || version[len] == '$')
+		len++;
+	while (isspace(version[len])) 
+		len++;
+	memmove(version, version+len, full_len-len);
+	full_len -= len;
+
+	/* Preserve up to next whitespace. */
+	len = 0;
+	while (version[len] && !isspace(version[len]))
+		len++;
+	memmove(version + len, version + strlen(version),
+		full_len - strlen(version));
+}
+
+/* If the modinfo contains a "version" value, then set this. */
+void maybe_frob_version(const char *modfilename,
+			void *modinfo,
+			unsigned long modinfo_len,
+			unsigned long modinfo_offset)
+{
+	char *version, *csum;
+
+	version = get_modinfo(modinfo, modinfo_len, "version");
+	if (!version)
+		return;
+
+	/* RCS $Revision gets stripped out. */
+	strip_rcs_crap(version);
+
+	/* Check against double sumversion */
+	if (strchr(version, ' '))
+		return;
+
+	/* Version contains embedded NUL: second half has space for checksum */
+	csum = version + strlen(version);
+	*(csum++) = ' ';
+	if (get_version(modfilename, csum))
+		write_version(modfilename, version,
+			      modinfo_offset + (version - (char *)modinfo));
+}
