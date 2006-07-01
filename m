Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWGAK6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWGAK6i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 06:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbWGAK6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 06:58:38 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:37308 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932452AbWGAK6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 06:58:37 -0400
Date: Sat, 1 Jul 2006 12:58:32 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PATCH] kbuild updates
Message-ID: <20060701105832.GA16563@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

It contains a few fixes and enhancements.
With this ia64 now builds cleanly again - and this fix may also help others since arguments specified by CFLAGS_file.o := xxx is now processed correct
in all cases. Previously it could cause problems when full path was specified.

It also introduces a nice modpost enhancement so we now warn if a module
uses a symbol that is marked UNUSED.

note - the changes in arch/um/ is related to the 'ia64' fix.

There are a few kbuild issues to be sorted out but that will be after
-rc1. The list as I recall it atm:
- kconfig is not preperly rebuild when kconfig changes
- A few more section checks needs to be introduced as per akpm request
- a few bugzilla entries needs to be addressed
- initramfs is attempted build when usign an external file as input
- mrproper left-overs in arch/arm (akpm)
- fix __FILE__ gets expanded to absolute pathname

	Sam

Sam Ravnborg:
      kbuild: fix ia64 breakage after introducing make -rR
      kbuild: fix segv in modpost
      kbuild: warn when a moduled uses a symbol marked UNUSED

Samuel Thibault:
      kconfig: enhancing accessibility of lxdialog

 Makefile                             |    2 -
 arch/um/scripts/Makefile.rules       |    4 +
 scripts/Kbuild.include               |    4 +
 scripts/Makefile.build               |    2 -
 scripts/Makefile.host                |    6 +-
 scripts/Makefile.lib                 |    6 +-
 scripts/Makefile.modpost             |    2 -
 scripts/kconfig/lxdialog/checklist.c |    7 ++-
 scripts/mod/modpost.c                |   94 +++++++++++++++++++++++++---------
 scripts/mod/modpost.h                |    2 +
 10 files changed, 91 insertions(+), 38 deletions(-)

Since all patches has been on lkml before as individual patches here is
a combined diff.


diff --git a/Makefile b/Makefile
index e9560c6..935a9d6 100644
--- a/Makefile
+++ b/Makefile
@@ -1352,7 +1352,7 @@ quiet_cmd_rmfiles = $(if $(wildcard $(rm
 
 a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(AFLAGS_KERNEL) \
 	  $(NOSTDINC_FLAGS) $(CPPFLAGS) \
-	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 
 quiet_cmd_as_o_S = AS      $@
 cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index 1347dc6..813077f 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -8,7 +8,7 @@ USER_OBJS += $(filter %_user.o,$(obj-y) 
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
 $(USER_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(*F).o)
+	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(basetarget).o)
 $(USER_OBJS) : CHECKFLAGS := -D__linux__ -Dlinux -D__STDC__ \
 	-Dunix -D__unix__ -D__$(SUBARCH)__
 
@@ -17,7 +17,7 @@ # using it directly.
 UNPROFILE_OBJS := $(foreach file,$(UNPROFILE_OBJS),$(obj)/$(file))
 
 $(UNPROFILE_OBJS:.o=.%): \
-	c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS)) $(CFLAGS_$(*F).o)
+	c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS)) $(CFLAGS_$(basetarget).o)
 $(UNPROFILE_OBJS) : CHECKFLAGS := -D__linux__ -Dlinux -D__STDC__ \
 	-Dunix -D__unix__ -D__$(SUBARCH)__
 
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index b0d067b..2180c88 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -13,6 +13,10 @@ # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
 ###
+# filename of target with directory and extension stripped
+basetarget = $(basename $(notdir $@))
+
+###
 # Escape single quote for use in echo statements
 escsq = $(subst $(squote),'\$(squote)',$1)
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 02a7eea..3cb445c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -117,7 +117,7 @@ quiet_modtag := $(empty)   $(empty)
 $(obj-m)              : quiet_modtag := [M]
 
 # Default for not multi-part modules
-modname = $(*F)
+modname = $(basetarget)
 
 $(multi-objs-m)         : modname = $(modname-multi)
 $(multi-objs-m:.o=.i)   : modname = $(modname-multi)
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index 2b066d1..18ecd4d 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -80,8 +80,10 @@ obj-dirs += $(host-objdirs)
 #####
 # Handle options to gcc. Support building with separate output directory
 
-_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   $(HOSTCFLAGS_$(*F).o)
-_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) $(HOSTCXXFLAGS_$(*F).o)
+_hostc_flags   = $(HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
+                 $(HOSTCFLAGS_$(basetarget).o)
+_hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
+                 $(HOSTCXXFLAGS_$(basetarget).o)
 
 ifeq ($(KBUILD_SRC),)
 __hostc_flags	= $(_hostc_flags)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 2cb4935..fc498fe 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -82,12 +82,12 @@ # Note: It's possible that one object ge
 #       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
 #       where foo and bar are the name of the modules.
 name-fix = $(subst $(comma),_,$(subst -,_,$1))
-basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(*F)))"
+basename_flags = -D"KBUILD_BASENAME=KBUILD_STR($(call name-fix,$(basetarget)))"
 modname_flags  = $(if $(filter 1,$(words $(modname))),\
                  -D"KBUILD_MODNAME=KBUILD_STR($(call name-fix,$(modname)))")
 
-_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o)
-_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
+_c_flags       = $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$(basetarget).o)
+_a_flags       = $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$(basetarget).o)
 _cpp_flags     = $(CPPFLAGS) $(EXTRA_CPPFLAGS) $(CPPFLAGS_$(@F))
 
 # If building the kernel in a separate objtree expand all occurrences
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 576cce5..a495502 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -72,7 +72,7 @@ # Declare generated files as targets for
 # Step 5), compile all *.mod.c files
 
 # modname is set to make c_flags define KBUILD_MODNAME
-modname = $(*F)
+modname = $(notdir $(@:.mod.o=))
 
 quiet_cmd_cc_o_c = CC      $@
       cmd_cc_o_c = $(CC) $(c_flags) $(CFLAGS_MODULE)	\
diff --git a/scripts/kconfig/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
index be0200e..7988641 100644
--- a/scripts/kconfig/lxdialog/checklist.c
+++ b/scripts/kconfig/lxdialog/checklist.c
@@ -187,9 +187,12 @@ int dialog_checklist(const char *title, 
 
 	/* Print the list */
 	for (i = 0; i < max_choice; i++) {
-		print_item(list, items[(scroll + i) * 3 + 1],
-			   status[i + scroll], i, i == choice);
+		if (i != choice)
+			print_item(list, items[(scroll + i) * 3 + 1],
+				   status[i + scroll], i, 0);
 	}
+	print_item(list, items[(scroll + choice) * 3 + 1],
+		   status[choice + scroll], choice, 1);
 
 	print_arrows(dialog, choice, item_no, scroll,
 		     box_y, box_x + check_x + 5, list_height);
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0dd1617..dfde0e8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -24,7 +24,10 @@ static int all_versions = 0;
 /* If we are modposting external module set to 1 */
 static int external_module = 0;
 /* How a symbol is exported */
-enum export {export_plain, export_gpl, export_gpl_future, export_unknown};
+enum export {
+	export_plain,      export_unused,     export_gpl,
+	export_unused_gpl, export_gpl_future, export_unknown
+};
 
 void fatal(const char *fmt, ...)
 {
@@ -191,7 +194,9 @@ static struct {
 	enum export export;
 } export_list[] = {
 	{ .str = "EXPORT_SYMBOL",            .export = export_plain },
+	{ .str = "EXPORT_UNUSED_SYMBOL",     .export = export_unused },
 	{ .str = "EXPORT_SYMBOL_GPL",        .export = export_gpl },
+	{ .str = "EXPORT_UNUSED_SYMBOL_GPL", .export = export_unused_gpl },
 	{ .str = "EXPORT_SYMBOL_GPL_FUTURE", .export = export_gpl_future },
 	{ .str = "(unknown)",                .export = export_unknown },
 };
@@ -205,6 +210,8 @@ static const char *export_str(enum expor
 static enum export export_no(const char * s)
 {
 	int i;
+	if (!s)
+		return export_unknown;
 	for (i = 0; export_list[i].export != export_unknown; i++) {
 		if (strcmp(export_list[i].str, s) == 0)
 			return export_list[i].export;
@@ -216,8 +223,12 @@ static enum export export_from_sec(struc
 {
 	if (sec == elf->export_sec)
 		return export_plain;
+	else if (sec == elf->export_unused_sec)
+		return export_unused;
 	else if (sec == elf->export_gpl_sec)
 		return export_gpl;
+	else if (sec == elf->export_unused_gpl_sec)
+		return export_unused_gpl;
 	else if (sec == elf->export_gpl_future_sec)
 		return export_gpl_future;
 	else
@@ -366,8 +377,12 @@ static void parse_elf(struct elf_info *i
 			info->modinfo_len = sechdrs[i].sh_size;
 		} else if (strcmp(secname, "__ksymtab") == 0)
 			info->export_sec = i;
+		else if (strcmp(secname, "__ksymtab_unused") == 0)
+			info->export_unused_sec = i;
 		else if (strcmp(secname, "__ksymtab_gpl") == 0)
 			info->export_gpl_sec = i;
+		else if (strcmp(secname, "__ksymtab_unused_gpl") == 0)
+			info->export_unused_gpl_sec = i;
 		else if (strcmp(secname, "__ksymtab_gpl_future") == 0)
 			info->export_gpl_future_sec = i;
 
@@ -1085,38 +1100,64 @@ void buf_write(struct buffer *buf, const
 	buf->pos += len;
 }
 
-void check_license(struct module *mod)
+static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
+{
+	const char *e = is_vmlinux(m) ?"":".ko";
+
+	switch (exp) {
+	case export_gpl:
+		fatal("modpost: GPL-incompatible module %s%s "
+		      "uses GPL-only symbol '%s'\n", m, e, s);
+		break;
+	case export_unused_gpl:
+		fatal("modpost: GPL-incompatible module %s%s "
+		      "uses GPL-only symbol marked UNUSED '%s'\n", m, e, s);
+		break;
+	case export_gpl_future:
+		warn("modpost: GPL-incompatible module %s%s "
+		      "uses future GPL-only symbol '%s'\n", m, e, s);
+		break;
+	case export_plain:
+	case export_unused:
+	case export_unknown:
+		/* ignore */
+		break;
+	}
+}
+
+static void check_for_unused(enum export exp, const char* m, const char* s)
+{
+	const char *e = is_vmlinux(m) ?"":".ko";
+
+	switch (exp) {
+	case export_unused:
+	case export_unused_gpl:
+		warn("modpost: module %s%s "
+		      "uses symbol '%s' marked UNUSED\n", m, e, s);
+		break;
+	default:
+		/* ignore */
+		break;
+	}
+}
+
+static void check_exports(struct module *mod)
 {
 	struct symbol *s, *exp;
 
 	for (s = mod->unres; s; s = s->next) {
 		const char *basename;
-		if (mod->gpl_compatible == 1) {
-			/* GPL-compatible modules may use all symbols */
-			continue;
-		}
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod)
 			continue;
 		basename = strrchr(mod->name, '/');
 		if (basename)
 			basename++;
-		switch (exp->export) {
-			case export_gpl:
-				fatal("modpost: GPL-incompatible module %s "
-				      "uses GPL-only symbol '%s'\n",
-				 basename ? basename : mod->name,
-				exp->name);
-				break;
-			case export_gpl_future:
-				warn("modpost: GPL-incompatible module %s "
-				      "uses future GPL-only symbol '%s'\n",
-				      basename ? basename : mod->name,
-				      exp->name);
-				break;
-			case export_plain: /* ignore */ break;
-			case export_unknown: /* ignore */ break;
-		}
+		else
+			basename = mod->name;
+		if (!mod->gpl_compatible)
+			check_for_gpl_usage(exp->export, basename, exp->name);
+		check_for_unused(exp->export, basename, exp->name);
         }
 }
 
@@ -1271,7 +1312,7 @@ static void write_if_changed(struct buff
 }
 
 /* parse Module.symvers file. line format:
- * 0x12345678<tab>symbol<tab>module[<tab>export]
+ * 0x12345678<tab>symbol<tab>module[[<tab>export]<tab>something]
  **/
 static void read_dump(const char *fname, unsigned int kernel)
 {
@@ -1284,7 +1325,7 @@ static void read_dump(const char *fname,
 		return;
 
 	while ((line = get_next_line(&pos, file, size))) {
-		char *symname, *modname, *d, *export;
+		char *symname, *modname, *d, *export, *end;
 		unsigned int crc;
 		struct module *mod;
 		struct symbol *s;
@@ -1297,7 +1338,8 @@ static void read_dump(const char *fname,
 		*modname++ = '\0';
 		if ((export = strchr(modname, '\t')) != NULL)
 			*export++ = '\0';
-
+		if (export && ((end = strchr(export, '\t')) != NULL))
+			*end = '\0';
 		crc = strtoul(line, &d, 16);
 		if (*symname == '\0' || *modname == '\0' || *d != '\0')
 			goto fail;
@@ -1396,7 +1438,7 @@ int main(int argc, char **argv)
 	for (mod = modules; mod; mod = mod->next) {
 		if (mod->skip)
 			continue;
-		check_license(mod);
+		check_exports(mod);
 	}
 
 	for (mod = modules; mod; mod = mod->next) {
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 2b00c60..d398c61 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -117,7 +117,9 @@ struct elf_info {
 	Elf_Sym      *symtab_start;
 	Elf_Sym      *symtab_stop;
 	Elf_Section  export_sec;
+	Elf_Section  export_unused_sec;
 	Elf_Section  export_gpl_sec;
+	Elf_Section  export_unused_gpl_sec;
 	Elf_Section  export_gpl_future_sec;
 	const char   *strtab;
 	char	     *modinfo;
