Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSKUPcs>; Thu, 21 Nov 2002 10:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266755AbSKUPcs>; Thu, 21 Nov 2002 10:32:48 -0500
Received: from h-64-105-34-70.SNVACAID.covad.net ([64.105.34.70]:39590 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266749AbSKUPcU>; Thu, 21 Nov 2002 10:32:20 -0500
Date: Thu, 21 Nov 2002 07:39:12 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: rusty@rustcorp.com.au
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org
Subject: Patch?: module-init-tools/modprobe.c - use modules.dep
Message-ID: <20021121073912.A15349@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The following patch changes modprobe in module-init-tools-0.8
to use modules.dep.

	Benefits:

	- deletes a net of 594 lines of source code

	- shrinks modprobe from 14kB to 10kB (stripped, dynamically linked),
	  which is useful for boot images

	- should make modprobe as fast on systems with a lot of modules as
	  it was with the user level module loader,

	- Restores the "include" command to the aliases file, which makes
	  it simpler to have separate files for automatically generated
	  aliases and user customizations.

	- minor: eliminates ELF dependence from modprobe user level code


	Drawbacks:

	- It makes modprobe require that depmod had been run at some
	  point (although it isn't necessary to put depmod on a boot
	  image to use modprobe; you just need it when you want to add
	  a module that you want modprobe to know about).  The current
	  depmod implementation is bigger than 594 lines of code, but
	  also generates hardware device tables, so systems that do
	  hardware autoconfiguration this way currently need depmod anyhow.

	- I have not tested these changes much, because the in-kernel
	  module loader reports "memory allocation failure" for many
	  modules that I try to load.  This does not appear to be
	  related to my changes.

	- I do not currently see a positive balance of real benefits
	  to putting the module linker in unswappable kernel memory.
	  If you're running a system with a user level module loader,
	  you are probably better off staying with that.

	Note to lmkl readers: this patch is again
module-init-tools-0.8.dwmw2, which is a modification done by David
Woodhouse of module-init-tools-0.7.  It is not an official release,
and it requires a kernel patch which changes the system call interface
for loading modules (to pass the module name).  I am posting a patch
against it instead of 0.7 because I don't want people applying this
patch and then breaking their systems due to the interface change.  I
am also attaching David's patches to this message (after checking with
him by email), but please do not refer to David's changes or mine as
releases of module-init-tools, as they both depend on David's kernel
changes, which may or may not be integrated into Linus's future
releases.

-- 
Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mod-init-tools.diff"

diff -u -r --new-file module-init-tools-0.8/Makefile.in module-init-tools-0.9.ajr/Makefile.in
--- module-init-tools-0.8/Makefile.in	2002-11-13 18:09:56.000000000 -0800
+++ module-init-tools-0.9.ajr/Makefile.in	2002-11-21 05:55:06.000000000 -0800
@@ -5,8 +5,8 @@
 
 default: insmod rmmod lsmod modprobe
 
-insmod.o rmmod.o lsmod.o: backwards_compat.c
-modprobe.o: backwards_compat.c mod32.c mod64.c mod_types.h
+insmod.o rmmod.o lsmod.o: backwards_compat.c mod_types.h
+modprobe.o: backwards_compat.c mod_types.h
 
 # Moving a link lsmod -> insmod requires two moves.
 %.old:
diff -u -r --new-file module-init-tools-0.8/mod32.c module-init-tools-0.9.ajr/mod32.c
--- module-init-tools-0.8/mod32.c	2002-11-13 18:15:24.000000000 -0800
+++ module-init-tools-0.9.ajr/mod32.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,158 +0,0 @@
-static void *load_section32(int fd, unsigned long shdroff,
-			    unsigned int num_secs,
-			    unsigned int secnamesec,
-			    const char *secname,
-			    unsigned long *size)
-{
-	Elf32_Shdr sechdrs[num_secs];
-	unsigned int i;
-	char *secnames;
-
-	/* Grab headers. */
-	lseek(fd, shdroff, SEEK_SET);
-	if (read(fd, sechdrs, sizeof(sechdrs)) != sizeof(sechdrs))
-		return (void*)-1;
-
-	/* Grab strings so we can tell who is who */
-	secnames = malloc(sechdrs[secnamesec].sh_size);
-	lseek(fd, sechdrs[secnamesec].sh_offset, SEEK_SET);
-	if (read(fd, secnames, sechdrs[secnamesec].sh_size)
-	    != sechdrs[secnamesec].sh_size) {
-		free(secnames);
-		return (void*)-1;
-	}
-
-
-	/* Find the section they want */
-	for (i = 1; i < num_secs; i++) {
-		if (strcmp(secnames+sechdrs[i].sh_name, secname) == 0) {
-			void *buf;
-
-			free(secnames);
-			*size = sechdrs[i].sh_size;
-			buf = malloc(*size);
-			if (lseek(fd, sechdrs[i].sh_offset, SEEK_SET) == -1
-			    || read(fd, buf, *size) != *size) {
-				free(buf);
-				return (void *)-1;
-			}
-			return buf;
-		}
-	}
-	free(secnames);
-	return NULL;
-}
-
-static void *map_exports32(int fd,
-			   unsigned long shdroff,
-			   unsigned int num_secs,
-			   unsigned int secnamesec,
-			   const char *name,
-			   unsigned int *num_exports)
-{
-	struct kernel_symbol32 *syms;
-	unsigned long size;
-
-	syms = load_section32(fd, shdroff, num_secs, secnamesec, "__ksymtab",
-			      &size);
-	*num_exports = 0;
-	if (syms == (void*)-1) {
-		warn("Error finding exports for module %s\n", name);
-		syms = NULL;
-	} else if (syms)
-		*num_exports = size / sizeof(struct kernel_symbol32);
-	return syms;
-}
-
-static int export_name_cmp32(struct module *m, int index, const char *name)
-{
-	return strcmp(m->u.exports32[index].name, name);
-}
-
-static struct module *add_module32(int fd, struct module *new,
-				   struct module *last,
-				   struct alias **aliases)
-{
-	Elf32_Ehdr hdr;
-
-	if (read(fd, &hdr, sizeof(hdr)) != sizeof(hdr)) {
-		warn("Error reading module %s\n", new->name);
-		free(new);
-		close(fd);
-		return last;
-	}
-
-	/* Map the section table */
-	new->u.ptr = mops->map_exports(fd, hdr.e_shoff, hdr.e_shnum,
-				       hdr.e_shstrndx, new->name,
-				       &new->num_exports);
-
-	/* Add in any aliases */
-	*aliases = add_aliases(fd, hdr.e_shoff, hdr.e_shnum,
-			       hdr.e_shstrndx, new, *aliases);
-
-	close(fd);
-	return new;
-}
-
-/* Analyse this module to see if it needs others. */
-static int get_deps32(unsigned int order,
-		      const char *dirname,
-		      const char *modname,
-		      struct module *modules,
-		      int verbose)
-{
-	unsigned int i;
-	unsigned long size;
-	Elf32_Ehdr hdr;
-	int fd;
-	char *strings;
-	Elf32_Sym *syms;
-	int needed = 0;
-	char modpath[strlen(dirname) + strlen(modname)
-		    + sizeof(MODULE_EXTENSION)];
-
-	sprintf(modpath, "%s%s%s", dirname, modname, MODULE_EXTENSION);
-	fd = open(modpath, O_RDONLY);
-	if (fd < 0)
-		fatal("Can't open module %s: %s\n", modpath, strerror(errno));
-
-	if (read(fd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		fatal("Error reading module %s\n", modpath);
-
-	strings = mops->load_section(fd, hdr.e_shoff, hdr.e_shnum,
-				     hdr.e_shstrndx, ".strtab", &size);
-	syms = mops->load_section(fd, hdr.e_shoff, hdr.e_shnum,
-				  hdr.e_shstrndx, ".symtab", &size);
-	if (!strings || strings == (void *)-1
-	    || !syms || syms == (void *)-1) {
-		fatal("Could not load strings and symbol table from %s\n",
-		      modpath);
-	}
-
-	/* Now establish which modules we need */
-	for (i = 0; i < size / sizeof(syms[0]); i++) {
-		if (syms[i].st_shndx == SHN_UNDEF) {
-			/* Look for symbol */
-			const char *name = strings + syms[i].st_name;
-
-			if (strcmp(name, "") == 0)
-				continue;
-
-			/* Did this pull in a new module? */
-			if (need_symbol(order, name, modules,
-					verbose ? modpath : NULL))
-				needed = 1;
-		}
-	}
-	close(fd);
-	return needed;
-}
-
-static struct mod_ops mod32_ops = {
-	.load_section		=	load_section32,
-	.map_exports		=	map_exports32,
-	.export_name_cmp	=	export_name_cmp32,
-	.add_module		=	add_module32,
-	.get_deps		=	get_deps32,
-};
diff -u -r --new-file module-init-tools-0.8/mod64.c module-init-tools-0.9.ajr/mod64.c
--- module-init-tools-0.8/mod64.c	2002-11-13 18:15:57.000000000 -0800
+++ module-init-tools-0.9.ajr/mod64.c	1969-12-31 16:00:00.000000000 -0800
@@ -1,158 +0,0 @@
-static void *load_section64(int fd, unsigned long shdroff,
-			    unsigned int num_secs,
-			    unsigned int secnamesec,
-			    const char *secname,
-			    unsigned long *size)
-{
-	Elf64_Shdr sechdrs[num_secs];
-	unsigned int i;
-	char *secnames;
-
-	/* Grab headers. */
-	lseek(fd, shdroff, SEEK_SET);
-	if (read(fd, sechdrs, sizeof(sechdrs)) != sizeof(sechdrs))
-		return (void*)-1;
-
-	/* Grab strings so we can tell who is who */
-	secnames = malloc(sechdrs[secnamesec].sh_size);
-	lseek(fd, sechdrs[secnamesec].sh_offset, SEEK_SET);
-	if (read(fd, secnames, sechdrs[secnamesec].sh_size)
-	    != sechdrs[secnamesec].sh_size) {
-		free(secnames);
-		return (void*)-1;
-	}
-
-
-	/* Find the section they want */
-	for (i = 1; i < num_secs; i++) {
-		if (strcmp(secnames+sechdrs[i].sh_name, secname) == 0) {
-			void *buf;
-
-			free(secnames);
-			*size = sechdrs[i].sh_size;
-			buf = malloc(*size);
-			if (lseek(fd, sechdrs[i].sh_offset, SEEK_SET) == -1
-			    || read(fd, buf, *size) != *size) {
-				free(buf);
-				return (void *)-1;
-			}
-			return buf;
-		}
-	}
-	free(secnames);
-	return NULL;
-}
-
-static void *map_exports64(int fd,
-			   unsigned long shdroff,
-			   unsigned int num_secs,
-			   unsigned int secnamesec,
-			   const char *name,
-			   unsigned int *num_exports)
-{
-	struct kernel_symbol64 *syms;
-	unsigned long size;
-
-	syms = load_section64(fd, shdroff, num_secs, secnamesec, "__ksymtab",
-			      &size);
-	*num_exports = 0;
-	if (syms == (void*)-1) {
-		warn("Error finding exports for module %s\n", name);
-		syms = NULL;
-	} else if (syms)
-		*num_exports = size / sizeof(struct kernel_symbol64);
-	return syms;
-}
-
-static int export_name_cmp64(struct module *m, int index, const char *name)
-{
-	return strcmp(m->u.exports64[index].name, name);
-}
-
-static struct module *add_module64(int fd, struct module *new,
-				   struct module *last,
-				   struct alias **aliases)
-{
-	Elf64_Ehdr hdr;
-
-	if (read(fd, &hdr, sizeof(hdr)) != sizeof(hdr)) {
-		warn("Error reading module %s\n", new->name);
-		free(new);
-		close(fd);
-		return last;
-	}
-
-	/* Map the section table */
-	new->u.ptr = mops->map_exports(fd, hdr.e_shoff, hdr.e_shnum,
-				       hdr.e_shstrndx, new->name,
-				       &new->num_exports);
-	/* Add in any aliases */
-	*aliases = add_aliases(fd, hdr.e_shoff, hdr.e_shnum,
-			       hdr.e_shstrndx, new, *aliases);
-
-	close(fd);
-	return new;
-}
-
-/* Analyse this module to see if it needs others. */
-static int get_deps64(unsigned int order,
-		      const char *dirname,
-		      const char *modname,
-		      struct module *modules,
-		      int verbose)
-{
-	unsigned int i;
-	unsigned long size;
-	Elf64_Ehdr hdr;
-	int fd;
-	char *strings;
-	Elf64_Sym *syms;
-	int needed = 0;
-	char modpath[strlen(dirname) + strlen(modname)
-		    + sizeof(MODULE_EXTENSION)];
-
-	sprintf(modpath, "%s%s%s", dirname, modname, MODULE_EXTENSION);
-
-	fd = open(modpath, O_RDONLY);
-	if (fd < 0)
-		fatal("Can't open module %s: %s\n", modpath, strerror(errno));
-
-	if (read(fd, &hdr, sizeof(hdr)) != sizeof(hdr))
-		fatal("Error reading module %s\n", modpath);
-
-	strings = mops->load_section(fd, hdr.e_shoff, hdr.e_shnum,
-				     hdr.e_shstrndx, ".strtab", &size);
-	syms = mops->load_section(fd, hdr.e_shoff, hdr.e_shnum,
-				  hdr.e_shstrndx, ".symtab", &size);
-	if (!strings || strings == (void *)-1
-	    || !syms || syms == (void *)-1) {
-		fatal("Could not load strings and symbol table from %s\n",
-		      modpath);
-	}
-
-	/* Now establish which modules we need */
-	for (i = 0; i < size / sizeof(syms[0]); i++) {
-		if (syms[i].st_shndx == SHN_UNDEF) {
-			/* Look for symbol */
-			const char *name = strings + syms[i].st_name;
-
-			if (strcmp(name, "") == 0)
-				continue;
-
-			/* Did this pull in a new module? */
-			if (need_symbol(order, name, modules,
-					verbose ? modpath : NULL))
-				needed = 1;
-		}
-	}
-	close(fd);
-	return needed;
-}
-
-static struct mod_ops mod64_ops = {
-	.load_section		=	load_section64,
-	.map_exports		=	map_exports64,
-	.export_name_cmp	=	export_name_cmp64,
-	.add_module		=	add_module64,
-	.get_deps		=	get_deps64,
-};
diff -u -r --new-file module-init-tools-0.8/mod_types.h module-init-tools-0.9.ajr/mod_types.h
--- module-init-tools-0.8/mod_types.h	2002-11-13 18:14:41.000000000 -0800
+++ module-init-tools-0.9.ajr/mod_types.h	2002-11-21 05:13:16.000000000 -0800
@@ -1,65 +1 @@
-struct kernel_symbol32 {
-	char value[4];
-	char name[64 - 4];
-};
-
-struct kernel_symbol64 {
-	char value[8];
-	char name[64 - 8];
-};
-
-/* All the modules kept in this list */
-struct module
-{
-	struct module *next;
-
-	/* mmaped export symbols area */
-	unsigned int num_exports;
-	union {
-		struct kernel_symbol32 *exports32;
-		struct kernel_symbol64 *exports64;
-		void *ptr;
-	} u;
-
-	/* What order it has to be loaded (0 = never). */
-	unsigned int order;
-
-	/* full path name */
-	char name[0];
-};
-
-struct alias
-{
-	struct alias *next;
-	/* One of these two is set. */
-	struct module *module;
-	struct alias *alias;
-	/* Line in config where this was defined */
-	int config_line;
-	char name[0];
-};
-
-struct mod_ops {
-	struct module *(*add_module)(int fd, struct module *new,
-				     struct module *last,
-				     struct alias **aliases);
-	void *(*load_section)(int fd, unsigned long shdroff,
-			      unsigned int num_secs,
-			      unsigned int secnamesec,
-			      const char *secname,
-			      unsigned long *size);
-	void *(*map_exports)(int fd,
-			     unsigned long shdroff,
-			     unsigned int num_secs,
-			     unsigned int secnamesec,
-			     const char *name,
-			     unsigned int *num_exports);
-	int (*export_name_cmp)(struct module *m, int index, const char *name);
-	int (*get_deps)(unsigned int order,
-			const char *dirname,
-			const char *modname,
-			struct module *modules,
-			int verbose);
-};
-
 #define MODULE_EXTENSION ".o"
diff -u -r --new-file module-init-tools-0.8/modprobe.c module-init-tools-0.9.ajr/modprobe.c
--- module-init-tools-0.8/modprobe.c	2002-11-20 14:30:32.000000000 -0800
+++ module-init-tools-0.9.ajr/modprobe.c	2002-11-21 05:37:16.000000000 -0800
@@ -39,11 +39,21 @@
 
 #include "mod_types.h"
 
-#define MODULE_DIR "/lib/modules/%s/kernel/"
+struct module_list;
 
-/* We decide when we hit the first module whether we are 32 or 64-bit,
-   and set this. */
-static struct mod_ops *mops;
+struct module {
+	struct module		*next;
+	struct module_list	*dependencies;
+	enum { NOT_LOADED = 0, BEING_LOADED, LOADED } state;
+	char			filename[0];
+};
+
+struct module_list {
+	struct module		*module;
+	struct module_list	*next;
+};
+
+#define MODULE_DIR "/lib/modules"
 
 static void fatal(const char *fmt, ...)
 __attribute__ ((noreturn, format (printf, 1, 2)));
@@ -75,20 +85,16 @@
 	va_end(arglist);
 }
 
-static struct alias *add_aliases(int fd,
-				 unsigned long shdroff,
-				 unsigned int num_secs,
-				 unsigned int secnamesec,
-				 struct module *mod,
-				 struct alias *last);
-
-static int need_symbol(unsigned int order,
-		       const char *name,
-		       struct module *modules,
-		       const char *modname);
+static void *do_nofail(void *ptr, const char *file, int line, const char *expr)
+{
+	if (!ptr) {
+		fatal("Memory allocation failure %s line %d: %s.\n",
+		      file, line, expr);
+	}
+	return ptr;
+}
 
-#include "mod32.c"
-#include "mod64.c"
+#define NOFAIL(ptr)	do_nofail((ptr), __FILE__, __LINE__, #ptr)
 
 static void print_usage(const char *progname)
 {
@@ -98,185 +104,122 @@
 	exit(1);
 }
 
-static int ends_in(const char *name, const char *ext)
+static int fgetc_wrapped(FILE *file)
 {
-	unsigned int namelen, extlen, i;
-
-	/* Grab lengths */
-	namelen = strlen(name);
-	extlen = strlen(ext);
-
-	if (namelen < extlen) return 0;
-
-	/* Look backwards */
-	for (i = 0; i < extlen; i++)
-		if (name[namelen - i] != ext[extlen - i]) return 0;
-
-	return 1;
+	for (;;) {
+	  	int ch = fgetc(file);
+		if (ch != '\\')
+			return ch;
+		ch = fgetc(file);
+		if (ch != '\n')
+			return ch;
+	}
 }
 
-/* FIXME: Loop detect. */
-static struct alias *find_alias(const char *name, struct alias *aliases)
-{
-	struct alias *i;
-
-	for (i = aliases; i; i = i->next)
-		if (fnmatch(i->name, name, 0) == 0) {
-			/* Chase down alias to aliases */
-			while (i->alias)
-				i = i->alias;
-			return i;
+static char *getline_wrapped(FILE *file)
+{
+	int size = 1024;
+	int i = 0;
+	char *buf = NOFAIL(malloc(size));
+	for(;;) {
+		int ch = fgetc_wrapped(file);
+		if (i == size) {
+			size *= 2;
+			buf = NOFAIL(realloc(buf, size));
 		}
-
-	return NULL;
+		if (ch < 0 || ch == '\n') {
+			if (ch < 0 && i == 0) {
+				free(buf);
+				return NULL;
+			}
+			buf[i] = '\0';
+			return NOFAIL(realloc(buf, i+1));
+		}
+		buf[i++] = ch;
+	}
 }
 
-static struct alias *add_alias(struct alias *last,
-			       const char *aliasname,
-			       struct module *mod,
-			       struct alias *alias,
-			       int linenum)
-{
-	struct alias *newalias;
-
-	newalias = malloc(sizeof *newalias + strlen(aliasname) + 1);
-	strcpy(newalias->name, aliasname);
-	newalias->config_line = linenum;
-	newalias->module = mod;
-	newalias->alias = alias;
+struct module *modules;		/* = NULL */
 
-	newalias->next = last;
-	return newalias;
-}
-
-static struct alias *add_aliases(int fd,
-				 unsigned long shdroff,
-				 unsigned int num_secs,
-				 unsigned int secnamesec,
-				 struct module *mod,
-				 struct alias *last)
+struct module *get_module(char *filename, int namelen)
 {
-	char *aliases;
-	unsigned long size, i;
-
-	aliases = mops->load_section(fd, shdroff, num_secs, secnamesec,
-				     ".modalias",  &size);
-	if (aliases == (void *)-1) {
-		warn("Error loading aliases from module %s\n", mod->name);
-		return last;
+	struct module *mod;
+	for (mod = modules; mod; mod = mod->next) {
+		if (strlen(mod->filename) == namelen &&
+		    memcmp(mod->filename, filename, namelen) == 0)
+			return mod;
 	}
 
-	if (aliases) {
-		for (i = 0; i < size; i += strlen(aliases+i)+1)
-			last = add_alias(last, aliases+i, mod, NULL, 0);
-		free(aliases);
-	}
-	return last;
+	/* No match.  Make a new module. */
+	mod = NOFAIL(malloc(sizeof(struct module) + namelen + 1));
+	memset(mod, 0, sizeof(struct module));
+	memcpy(mod->filename, filename, namelen);
+	mod->filename[namelen] = '\0';
+	mod->next = modules;
+	modules = mod;
+	return mod;
 }
 
-static struct module *add_module(const char *dirname, const char *entry,
-				 struct module *last, struct alias **aliases)
+static void add_modules_dep_line(char *line, const char *start_name,
+				 struct module **start)
 {
-	int fd;
-	struct module *new;
-	char pathname[strlen(dirname) + strlen(entry) + 1];
+	struct module_list *dep;
+	char *dep_start;
+	struct module *mod, *dep_mod;
+	char *ptr;
+	int len;
+	char *modname;
 
-	new = malloc(sizeof(*new) + strlen(entry) + 1);
-	strcpy(new->name, entry);
-	/* Truncate extension */
-	new->name[strlen(new->name) - strlen(MODULE_EXTENSION)] = '\0';
-	new->order = 0;
-	new->next = last;
+	ptr = index(line, ':');
+	if (ptr == NULL || line[0] == '#')
+		return;
 
-	sprintf(pathname, "%s%s", dirname, entry);
-	fd = open(pathname, O_RDONLY);
-	if (fd < 0) {
-		warn("Can't read module %s: %s\n", pathname, strerror(errno));
-		free(new);
-		return last;
-	}
+	mod = get_module(line, ptr - line);
 
-	/* First call initializes this. */
-	if (!mops) {
-		/* "\177ELF" <byte> where byte = 001 for 32-bit, 002 for 64 */
-		char ident[EI_NIDENT];
+	modname = rindex(mod->filename, '/') + 1;
+	len = strlen(modname) - sizeof(MODULE_EXTENSION) + 1;
 
-		if (read(fd, ident, EI_NIDENT) != EI_NIDENT) {
-			warn("Can't read module %s elf identifier: %s\n",
-			     pathname, strerror(errno));
-			free(new);
-			return last;
-		}
-		switch (ident[EI_CLASS]) {
-		case ELFCLASS32:
-			mops = &mod32_ops;
-			break;
-		case ELFCLASS64:
-			mops = &mod64_ops;
+	if (len == strlen(start_name) && !strncmp(modname, start_name, len))
+		*start = mod;
+
+	ptr++;
+	for(;;) {
+		ptr += strspn(ptr, " \t");
+		if (*ptr == '\0')
 			break;
-		default:
-			warn("Module %s has elf unknown identifier %i\n",
-			     pathname, ident[EI_CLASS]);
-			free(new);
-			return last;
-		}
-		lseek(fd, 0, SEEK_SET);
+		dep_start = ptr;
+		ptr += strcspn(ptr, " \t");
+		dep_mod = get_module(dep_start, ptr - dep_start);
+		fflush(stdout);
+		dep = NOFAIL(malloc(sizeof(*dep)));
+		dep->module = dep_mod;
+		dep->next = mod->dependencies;
+		mod->dependencies = dep;
 	}
-
-	return mops->add_module(fd, new, last, aliases);
 }
 
-static struct module *load_all_modules(const char *dirname,
-				       struct alias **aliases)
+static void load_all_modules(const char *dirname,
+			     const char *start_name,
+			     struct module **start)
 {
-	struct module *mods = NULL;
-	struct dirent *dirent;
-	DIR *dir;
+	char modules_dep_name[strlen(dirname) + sizeof("modules.dep") + 1];
+	char *line;
+	FILE *modules_dep;
 
-	dir = opendir(dirname);
-	if (dir) {
-		while ((dirent = readdir(dir)) != NULL) {
-			/* Is it a .o file? */
-			if (ends_in(dirent->d_name, MODULE_EXTENSION))
-				mods = add_module(dirname, dirent->d_name,
-						  mods, aliases);
-		}
-		closedir(dir);
+	*start = NULL;
+	sprintf(modules_dep_name, "%s/%s", dirname, "modules.dep");
+	modules_dep = fopen(modules_dep_name, "r");
+	if (!modules_dep) {
+		perror(modules_dep_name);
+		exit(1);
 	}
-	return mods;
-}
 
-static int need_symbol(unsigned int order,
-		       const char *name,
-		       struct module *modules,
-		       const char *modname)
-{
-	struct module *m;
-	struct module *found = NULL;
-
-	for (m = modules; m; m = m->next) {
-		unsigned int i;
-		for (i = 0; i < m->num_exports; i++) {
-			if (mops->export_name_cmp(m, i, name) == 0) {
-				if (found) {
-					warn("%s supplied by %s and %s:"
-					     " picking neither\n",
-					     name, m->name, found->name);
-					/* Noone chosen */
-					return 0;
-				}
-				if (modname)
-					printf("%s needs %s: found in %s\n",
-					       modname, name, m->name);
-				found = m;
-				/* If we didn't need to load it
-                                   already, we do now. */
-				found->order = order;
-			}
-		}
+	while((line = getline_wrapped(modules_dep)) != NULL) {
+		add_modules_dep_line(line, start_name, start);
+		free(line);
 	}
-	if (found) return 1;
-	else return 0;
+
+	fclose(modules_dep);
 }
 
 /* We use error numbers in a loose translation... */
@@ -292,308 +235,150 @@
 	}
 }
 
+static int
+module_in_kernel(const char *modname)
+{
+	FILE *proc_modules;
+	char *line;
+	const int modname_len = strlen(modname);
+	
+	proc_modules = fopen("/proc/modules", "r");
+	if (proc_modules == NULL)
+		fatal("Error reading /proc/modules: %s\n", strerror(errno));
+
+	while ((line = getline_wrapped(proc_modules)) != NULL) {
+		if (strncmp(line, modname, modname_len) == 0 &&
+		    isspace(line[modname_len])) {
+			free(line);
+			fclose(proc_modules);
+			return 1;
+		}
+		free(line);
+	}
+	fclose(proc_modules);
+	return 0;
+}
+
 /* Actually do the insert. */
-static void insmod(const char *dirname,
-		   const char *filename,
-		   const char *options,
-		   int dont_fail)
+static void insmod(struct module *mod, const char *options, int dont_fail,
+		   struct module_list *caller)
 {
 	int fd, ret;
 	struct stat st;
 	unsigned long len;
 	void *map;
-	char modpath[strlen(dirname) + strlen(filename)
-		    + sizeof(MODULE_EXTENSION)];
+	struct module_list *dep;
+	unsigned int i;
+	char modname[strlen(strrchr(mod->filename, '/'))];
+	struct module_list call_history, *modlist;
+
+	if (mod->state == LOADED)
+		return;
+
+	call_history.next = caller;
+	call_history.module = mod;
+
+	if (mod->state == BEING_LOADED) {
+		fprintf (stderr, "FATAL: recursive dependency loop:\n");
+		modlist = &call_history;
+		do {
+			fprintf(stderr, "\t%s\n", modlist->module->filename);
+			modlist = modlist->next;
+		} while (modlist != NULL);
+		exit(1);
+	}
 
-	/* FIXME: Look in module for name. --RR */
-	sprintf(modpath, "%s%s%s", dirname, filename, MODULE_EXTENSION);
+	mod->state = BEING_LOADED;
+
+	for(dep = mod->dependencies; dep != NULL; dep = dep->next)
+		insmod(dep->module, options, 0, &call_history);
+
+	/* If we fail to load after this piont, we abort the whole program. */
+	mod->state = LOADED;
 
 	/* Now, it may already be loaded: check /proc/modules */
-	fd = open("/proc/modules", O_RDONLY);
-	if (fd < 0) {
-		warn("Cannot open /proc/modules:"
-		     " assuming no modules loaded.\n");
-	} else {
-		char *buf;
-		unsigned int fill, size = 1024;
-
-		buf = malloc(size+1);
-		buf[0] = '\n';
-		fill = 1;
 
-		while ((ret = read(fd, buf+fill, size - fill)) > 0) {
-			size *= 2;
-			buf = realloc(buf, size+1);
-			fill += ret;
-		}
-		if (ret < 0)
-			fatal("Error reading /proc/modules: %s\n",
-			      strerror(errno));
-		else {
-			char *ptr;
-			unsigned int i;
-			char name_with_ret[strlen(strrchr(modpath, '/')) + 2];
-
-			buf[fill+1] = '\0';
-			/* Must appear at start of line. */
-			name_with_ret[0] = '\n';
-			strcpy(name_with_ret + 1, strrchr(modpath, '/') + 1);
+	strcpy(modname, strrchr(mod->filename, '/') + 1);
 			
-			/* Convert to underscores */
-			for (i = 0; name_with_ret[i]; i++)
-				if (name_with_ret[i] == '-')
-					name_with_ret[i] = '_';
-
-			for (ptr = buf;
-			     (ptr = strstr(ptr, name_with_ret)) != NULL;
-			     ptr++) {
-				if (!isspace(ptr[strlen(name_with_ret)]))
-					continue;
-				/* Found: don't try to load again */
-				if (dont_fail)
-					fatal("Module %s already loaded\n",
-					      name_with_ret+1);
-				close(fd);
-				free(buf);
-				return;
-			}
-		}
-		close(fd);
-		free(buf);
-	}
-	close(fd);
+	/* Convert to underscores */
+	for (i = 0; modname[i]; i++)
+		if (modname[i] == '-')
+			modname[i] = '_';
+
+	modname[strlen(modname) - sizeof(MODULE_EXTENSION) + 1] = '\0';
+	if (module_in_kernel(modname))
+		return;
 
-	fd = open(modpath, O_RDONLY);
+	fd = open(mod->filename, O_RDONLY);
 	if (fd < 0)
-		fatal("Could not open `%s': %s\n", modpath, strerror(errno));
+		fatal("Could not open `%s': %s\n", mod->filename, strerror(errno));
 
 	fstat(fd, &st);
 	len = st.st_size;
 	map = mmap(NULL, len, PROT_READ, MAP_SHARED, fd, 0);
 	if (map == MAP_FAILED)
-		fatal("Can't map `%s': %s\n", modpath, strerror(errno));
+		fatal("Can't map `%s': %s\n", mod->filename, strerror(errno));
 
-	ret = syscall(__NR_init_module, filename, map, len, options);
+	ret = syscall(__NR_init_module, modname, map, len, options);
 	if (ret != 0) {
 		if (dont_fail)
-			fatal("Error inserting %s: %s\n",
-			      modpath, moderror(errno));
+			fatal("Error inserting %s (%s): %s\n",
+			      modname, mod->filename, moderror(errno));
 		else
-			warn("Error inserting %s: %s\n",
-			     modpath, moderror(errno));
+			warn("Error inserting %s (%s): %s\n",
+			     modname, mod->filename, moderror(errno));
 	}
 	close(fd);
 }
 
-/* Read one line into the buffer */
-static char *read_line(FILE *f)
-{
-	int size = 80;
-	char *result = malloc(size);
-
-	result[0] = '\0';
-	while (fgets(result + strlen(result), size - strlen(result), f)) {
-		char *nl = strchr(result, '\n');
-		if (nl) {
-			*nl = '\0';
-			return result;
-		}
-		size *= 2;
-		result = realloc(result, size);
-	}
-	if (strlen(result)) {
-		warn("Unexpected error reading config file: %s\n",
-		     strerror(errno));
-		return result;
-	}
-	free(result);
-	return NULL;
-}
-
-static struct module *find_module(const char *name, struct module *modules)
-{
-	struct module *m;
-
-	for (m = modules; m; m = m->next)
-		if (strcmp(name, m->name) == 0)
-			return m;
-	return NULL;
-}
-
-static char *get_word(const char **line)
+static char *strsep_skipspace(char **string, char *delim)
 {
-	size_t len;
-	char *word = NULL;
-
-	*line += strspn(*line, "\t ");
-	len = strcspn(*line, "\t ");
-	if (**line) {
-		word = strdup(*line);
-		word[len] = '\0';
-	}
-	*line += len;
-
-	return word;
-}
-
-/* alias newname oldname */
-static struct alias *parse_alias(struct alias *last, const char *line,
-				 int linenum,
-				 struct module *modules)
-{
-	char *newname, *oldname;
-	struct alias *aliasto;
-	struct module *moduleto = NULL;
-
-	newname = get_word(&line);
-	if (!newname) {
-		warn("Config line %i missing first arg\n", linenum);
-		return last;
-	}
-	oldname = get_word(&line);
-	if (!oldname) {
-		warn("Config line %i missing second arg\n", linenum);
-		free(newname);
-		return last;
-	}
-
-	aliasto = find_alias(oldname, last);
-	if (aliasto || (moduleto = find_module(oldname, modules)))
-		last = add_alias(last, newname, moduleto, aliasto, linenum);
-	else
-		warn("Config line %i aliases to unknown module %s\n",
-		     linenum, oldname);
-
-	free(oldname);
-	free(newname);
-	return last;
-}
-
-static int keyword(const char *line, const char *keyword)
-{
-	size_t len = strcspn(line, "\t ");
-
-	if (len == strlen(keyword)
-	    && memcmp(line, keyword, len) == 0)
-		return 1;
-	return 0;
+	*string += strspn(*string, delim);
+	return strsep(string, delim);
 }
 
 /* Simple format, ignore lines starting with #, one command per line */
-static void load_config_file(const char *filename, int mustload,
-			     struct module *modules,
-			     struct alias **aliases)
+static char *get_alias(const char *filename, int mustload, char *name)
 {
 	FILE *cfile;
 	char *line;
-	int linenum = 1;
+	char *result = NULL;
 
 	cfile = fopen(filename, "r");
 	if (!cfile) {
 		if (mustload)
 			fatal("Failed to open config file %s: %s\n",
 			      filename, strerror(errno));
-		return;
-	}
-
-	while ((line = read_line(cfile)) != NULL) {
-		size_t len;
-		len = strspn(line, "\t ");
-		/* Comment or blank? */
-		if (line[len] == '#' || line[len] == '\0')
-			goto next;
-		else if (keyword(line+len, "alias"))
-			*aliases = parse_alias(*aliases, line+len+strlen("alias"),
-					       linenum, modules);
-		else
-			fatal("Unknown line %s in config file\n", line);
-	next:
-		free(line);
-		linenum++;
+		return NOFAIL(strdup(name));
 	}
-}
 
-static char *resolve_alias(const char *name,
-			   struct module *modules,
-			   struct alias *aliases)
-{
-	struct module *m;
-	struct alias *a;
+	while ((line = getline_wrapped(cfile)) != NULL) {
+		char *ptr = line;
+		char *cmd = strsep_skipspace(&ptr, "\t ");
 
-	a = find_alias(name, aliases);
-	if (a)
-		return a->module->name;
+		if (cmd == NULL)
+			continue;
 
-	m = find_module(name, modules);
-	if (m)
-		return m->name;
+		if (strcmp(cmd, "alias") == 0) {
+			char *fakename = strsep_skipspace(&ptr, "\t ");
+			char *realname = strsep_skipspace(&ptr, "\t ");
 
-	fatal("Could not find a module or alias named %s\n",
-	      name);
-}
-
-static void load_symbol(const char *dirname,
-			const char *symname,
-			struct module *modules,
-			const char *options,
-			int verbose)
-{
-	struct module *i;
-
-	if (!need_symbol(1, symname, modules, verbose?"symbol request":NULL))
-		fatal("Could not find module with symbol %s\n", symname);
-
-	for (i = modules; i; i = i->next) {
-		if (i->order) {
-			if (verbose) printf("Loading %s\n", i->name);
-			insmod(dirname, i->name, options, 1);
-		}
-	}
-}
-
-static void load(const char *dirname, const char *modname,
-		 struct module *modules,
-		 struct alias *aliases,
-		 const char *options,
-		 int verbose)
-{
-	unsigned int order;
-	struct module *i;
-	char *realname;
-
-	realname = resolve_alias(modname, modules, aliases);
-
-	order = 1;
-	if (mops->get_deps(order, dirname, realname, modules, verbose)) {
-		/* We need some other modules. */
-		int more_needed;
-
-		do {
-			more_needed = 0;
-			for (i = modules; i; i = i->next) {
-				if (i->order == order) {
-					if (mops->get_deps(order + 1, dirname,
-							   i->name,
-							   modules, verbose))
-						more_needed = 1;
-				}
-			}
-			order++;
-		} while (more_needed);
-	}
-
-	/* Now, walk back through orders, loading */
-	for (; order > 0; order--) {
-		for (i = modules; i; i = i->next) {
-			if (i->order == order) {
-				if (verbose) printf("Loading %s\n", i->name);
-				insmod(dirname, i->name, "", 0);
+			if (fakename && realname && !strcmp(fakename, name)) {
+				result = NOFAIL(strdup(realname));
+				free(line);
+				break;
 			}
 		}
+		else if (strcmp(cmd, "include") == 0) {
+			filename = strsep(&ptr, "\t ");
+			result = get_alias(filename, 0, name);
+			if (result)
+				break;
+		}
+		free(line);
 	}
-	if (verbose)
-		printf("Loading %s%s%s\n", dirname, realname,MODULE_EXTENSION);
-	insmod(dirname, realname, options, 1);
+	fclose(cfile);
+	return result;
 }
 
 static struct option options[] = { { "verbose", 0, NULL, 'v' },
@@ -608,10 +393,10 @@
 	struct utsname buf;
 	int opt;
 	int verbose = 0;
-	struct alias *aliases = NULL;
-	struct module *modules;
 	const char *config = NULL;
-	char *dirname, *optstring = strdup("");
+	char *dirname, *optstring = NOFAIL(strdup(""));
+	char *modname;
+	struct module *start;
 
 	try_old_version("modprobe", argv);
 
@@ -651,22 +436,23 @@
 	}
 
 	uname(&buf);
-	dirname = malloc(strlen(buf.release) + sizeof(MODULE_DIR));
-	sprintf(dirname, MODULE_DIR, buf.release);
+	dirname = malloc(strlen(buf.release) + sizeof(MODULE_DIR) + 1);
+	sprintf(dirname, "%s/%s", MODULE_DIR, buf.release);
 
-	/* Suck up the modules */
-	modules = load_all_modules(dirname, &aliases);
+	modname = get_alias(config ?: DEFAULT_CONFIG, config ? 1 : 0,
+			    argv[optind]);
 
-	/* No config file specified?  Don't worry if it doesn't exist. */
-	load_config_file(config ?: DEFAULT_CONFIG, config ? 1 : 0,
-			 modules, &aliases);
-
-	/* Special case for "symbol:" */
-	if (strncmp(argv[optind], "symbol:", strlen("symbol:")) == 0)
-		load_symbol(dirname, argv[optind] + strlen("symbol:"), 
-			    modules, optstring, verbose);
-	else
-		load(dirname, argv[optind], modules, aliases, optstring,
-		     verbose);
-	exit(0);
+	if (modname == NULL)
+		modname = argv[optind];
+
+	load_all_modules(dirname, modname, &start);
+	if (start == NULL) {
+		fprintf (stderr, "Module %s not found.\n", modname);
+		exit(1);
+	}
+
+	insmod(start, optstring, 1, NULL);
+
+	/* free(modname);	-- Comment out.  We're just going to exit. */
+	return 0;
 }

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dwmw2-module-init-tools.patch"

diff -ur module-init-tools-0.7/CHANGES module-init-tools-0.8/CHANGES
--- module-init-tools-0.7/CHANGES	Thu Nov 14 02:09:28 2002
+++ module-init-tools-0.8/CHANGES	Wed Nov 20 13:32:39 2002
@@ -1,3 +1,4 @@
+o Add module name argument to sys_init_module()
 o 64/32 bit autodetection thanks to Dave Miller
 o Preliminary alias support.
 o Very primitive /etc/modprobe.conf support
diff -ur module-init-tools-0.7/insmod.c module-init-tools-0.8/insmod.c
--- module-init-tools-0.7/insmod.c	Wed Nov 13 22:33:32 2002
+++ module-init-tools-0.8/insmod.c	Wed Nov 20 13:32:05 2002
@@ -28,6 +28,7 @@
 #include <errno.h>
 #include <asm/unistd.h>
 
+#include "mod_types.h"
 #include "backwards_compat.c"
 
 static void print_usage(const char *progname)
@@ -62,15 +63,22 @@
 	unsigned long len;
 	void *map;
 	char *filename, *options = strdup("");
+	char *modname = NULL;
 
 	try_old_version("insmod", argv);
 
-	filename = argv[1];
+	i = 1;
+	if (argc > 3 && !strcmp(argv[1], "-o")) {
+		modname = argv[2];
+		i = 3;
+	}
+	
+	filename = argv[i++];
 	if (!filename)
 		print_usage(argv[0]);
 
 	/* Rest is options */
-	for (i = 2; i < argc; i++) {
+	for ( ; i < argc; i++) {
 		options = realloc(options,
 				  strlen(options) + 2 + strlen(argv[i]) + 2);
 		/* Spaces handled by "" pairs, but no way of escaping
@@ -99,7 +107,20 @@
 		exit(1);
 	}
 
-	ret = syscall(__NR_init_module, map, len, options);
+	if (!modname) {
+		char *ext;
+		modname = strrchr(filename, '/');
+		if (modname)
+			modname++;
+		else
+			modname = filename;
+
+		ext = strrchr(modname, '.');
+		if (ext && !strcmp(ext, MODULE_EXTENSION))
+			*ext = 0;
+	}
+		
+	ret = syscall(__NR_init_module, modname, map, len, options);
 	if (ret != 0) {
 		fprintf(stderr, "Error inserting `%s': %li %s\n",
 			filename, ret, moderror(errno));
diff -ur module-init-tools-0.7/modprobe.c module-init-tools-0.8/modprobe.c
--- module-init-tools-0.7/modprobe.c	Thu Nov 14 02:29:24 2002
+++ module-init-tools-0.8/modprobe.c	Wed Nov 20 13:32:00 2002
@@ -373,7 +373,7 @@
 	if (map == MAP_FAILED)
 		fatal("Can't map `%s': %s\n", modpath, strerror(errno));
 
-	ret = syscall(__NR_init_module, map, len, options);
+	ret = syscall(__NR_init_module, filename, map, len, options);
 	if (ret != 0) {
 		if (dont_fail)
 			fatal("Error inserting %s: %s\n",


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dwmw2-kernel.patch"

--- 1.17/include/linux/init.h	Sat Nov  9 04:08:33 2002
+++ edited/include/linux/init.h	Wed Nov 20 10:48:28 2002
@@ -125,14 +125,6 @@
  */
 #define module_exit(x)	__exitcall(x);
 
-/**
- * no_module_init - code needs no initialization.
- *
- * The equivalent of declaring an empty init function which returns 0.
- * Every module must have exactly one module_init() or no_module_init
- * invocation.  */
-#define no_module_init
-
 #else /* MODULE */
 
 /* Don't use these in modules, but some people do... */
@@ -144,10 +136,6 @@
 #define device_initcall(fn)		module_init(fn)
 #define late_initcall(fn)		module_init(fn)
 
-/* Each module knows its own name. */
-#define __DEFINE_MODULE_NAME						\
-	char __module_name[] __attribute__((section(".modulename"))) =	\
-	__stringify(KBUILD_MODNAME)
 
 /* These macros create a dummy inline: gcc 2.9x does not count alias
  as usage, hence the `unused function' warning when __init functions
@@ -155,14 +143,11 @@
  both to kill the warning and check the type of the init/cleanup
  function. */
 
-/* Each module must use one module_init(), or one no_module_init */
+/* Each module must use no more than one module_init() */
 #define module_init(initfn)					\
-	__DEFINE_MODULE_NAME;					\
 	static inline initcall_t __inittest(void)		\
 	{ return initfn; }					\
 	int __initfn(void) __attribute__((alias(#initfn)));
-
-#define no_module_init __DEFINE_MODULE_NAME
 
 /* This is only required if you want to be unloadable. */
 #define module_exit(exitfn)					\
===== include/linux/module.h 1.25 vs edited =====
--- 1.25/include/linux/module.h	Tue Nov 19 04:51:14 2002
+++ edited/include/linux/module.h	Wed Nov 20 10:08:30 2002
@@ -297,8 +297,6 @@
 /* Used as "int init_module(void) { ... }".  Get funky to insert modname. */
 #define init_module(voidarg)						\
 	__initfn(void);							\
-	char __module_name[] __attribute__((section(".modulename"))) =	\
-	__stringify(KBUILD_MODNAME);					\
 	int __initfn(void)
 #define cleanup_module(voidarg) __exitfn(void)
 #endif
===== kernel/module.c 1.25 vs edited =====
--- 1.25/kernel/module.c	Tue Nov 19 04:51:14 2002
+++ edited/kernel/module.c	Wed Nov 20 10:54:47 2002
@@ -800,15 +800,15 @@
 }
 
 /* Allocate and load the module */
-static struct module *load_module(void *umod,
+static struct module *load_module(const char *modname,
+				  void *umod,
 				  unsigned long len,
 				  const char *uargs)
 {
 	Elf_Ehdr *hdr;
 	Elf_Shdr *sechdrs;
 	char *secstrings;
-	unsigned int i, symindex, exportindex, strindex, setupindex, exindex,
-		modnameindex;
+	unsigned int i, symindex, exportindex, strindex, setupindex, exindex;
 	long arglen;
 	unsigned long common_length;
 	struct sizes sizes, used;
@@ -816,8 +816,8 @@
 	long err = 0;
 	void *ptr = NULL; /* Stops spurious gcc uninitialized warning */
 
-	DEBUGP("load_module: umod=%p, len=%lu, uargs=%p\n",
-	       umod, len, uargs);
+	DEBUGP("load_module: modname=%p, umod=%p, len=%lu, uargs=%p\n",
+	       modname, umod, len, uargs);
 	if (len < sizeof(*hdr))
 		return ERR_PTR(-ENOEXEC);
 
@@ -849,7 +849,7 @@
 	exportindex = setupindex = 0;
 
 	/* And these should exist, but gcc whinges if we don't init them */
-	symindex = strindex = exindex = modnameindex = 0;
+	symindex = strindex = exindex = 0;
 
 	/* Find where important sections are */
 	for (i = 1; i < hdr->e_shnum; i++) {
@@ -857,11 +857,6 @@
 			/* Internal symbols */
 			DEBUGP("Symbol table in section %u\n", i);
 			symindex = i;
-		} else if (strcmp(secstrings+sechdrs[i].sh_name, ".modulename")
-			   == 0) {
-			/* This module's name */
-			DEBUGP("Module name in section %u\n", i);
-			modnameindex = i;
 		} else if (strcmp(secstrings+sechdrs[i].sh_name, "__ksymtab")
 			   == 0) {
 			/* Exported symbols. */
@@ -895,12 +890,6 @@
 #endif
 	}
 
-	if (!modnameindex) {
-		DEBUGP("Module has no name!\n");
-		err = -ENOEXEC;
-		goto free_hdr;
-	}
-
 	/* Now allocate space for the module proper, and copy name and args. */
 	err = strlen_user(uargs);
 	if (err < 0)
@@ -917,8 +906,9 @@
 		err = -EFAULT;
 		goto free_mod;
 	}
-	strncpy(mod->name, (char *)hdr + sechdrs[modnameindex].sh_offset,
-		sizeof(mod->name)-1);
+	strncpy_from_user(mod->name, modname, sizeof(mod->name)-1);
+	/* strncpy doesn't NUL-terminate when it runs out of space */
+	mod->name[sizeof(mod->name)-1] = 0;
 
 	if (find_module(mod->name)) {
 		err = -EEXIST;
@@ -1058,7 +1048,8 @@
 
 /* This is where the real work happens */
 asmlinkage long
-sys_init_module(void *umod,
+sys_init_module(const char *modname,
+		void *umod,
 		unsigned long len,
 		const char *uargs)
 {
@@ -1074,7 +1065,7 @@
 		return -EINTR;
 
 	/* Do all the hard work */
-	mod = load_module(umod, len, uargs);
+	mod = load_module(modname, umod, len, uargs);
 	if (IS_ERR(mod)) {
 		up(&module_mutex);
 		return PTR_ERR(mod);
===== lib/zlib_deflate/deflate_syms.c 1.2 vs edited =====
--- 1.2/lib/zlib_deflate/deflate_syms.c	Sat Nov  9 04:08:33 2002
+++ edited/lib/zlib_deflate/deflate_syms.c	Wed Nov 20 10:45:43 2002
@@ -19,5 +19,3 @@
 EXPORT_SYMBOL(zlib_deflateCopy);
 EXPORT_SYMBOL(zlib_deflateParams);
 MODULE_LICENSE("GPL");
-
-no_module_init;
===== lib/zlib_inflate/inflate_syms.c 1.3 vs edited =====
--- 1.3/lib/zlib_inflate/inflate_syms.c	Sat Nov  9 04:08:33 2002
+++ edited/lib/zlib_inflate/inflate_syms.c	Wed Nov 20 10:51:40 2002
@@ -20,5 +20,3 @@
 EXPORT_SYMBOL(zlib_inflateSyncPoint);
 EXPORT_SYMBOL(zlib_inflateIncomp); 
 MODULE_LICENSE("GPL");
-
-no_module_init;





--xHFwDpU9dbj6ez1V--
