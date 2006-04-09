Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWDIP2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWDIP2I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 11:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWDIP2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 11:28:07 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30634 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750778AbWDIP2F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 11:28:05 -0400
Date: Sun, 9 Apr 2006 17:28:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 6/19] kconfig: fix .config dependencies
Message-ID: <Pine.LNX.4.64.0604091727460.23128@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes one of the worst kbuild warts left - the broken dependencies
used to check and regenerate the .config file. This was done via an
indirect dependency and the .config itself had an empty command, which
can cause make not to reread the changed .config file.
Instead of this we generate now a new file include/config/auto.conf from
.config, which is used for kbuild and has the proper dependencies. It's
also the main make target now for all files generated during this step
(and thus replaces include/linux/autoconf.h).
This also means we can now relax the syntax requirements for the .config
file and we don't have to rewrite it all the time, i.e. silentoldconfig
only writes .config now when it's necessary to keep it in sync with the
Kconfig files and even this can be suppressed by setting the environment
variable KCONFIG_NOSILENTUPDATE, so the update can (and must) be done
manually.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 Makefile                    |   27 ++----
 scripts/Makefile.build      |    2 
 scripts/Makefile.modpost    |    2 
 scripts/kconfig/conf.c      |   16 +++
 scripts/kconfig/confdata.c  |  177 ++++++++++++++++++++++++++++++--------------
 scripts/kconfig/lkc_proto.h |    1 
 scripts/kconfig/util.c      |    4 
 7 files changed, 156 insertions(+), 73 deletions(-)

Index: linux-2.6-git/Makefile
===================================================================
--- linux-2.6-git.orig/Makefile
+++ linux-2.6-git/Makefile
@@ -406,7 +406,7 @@ include $(srctree)/arch/$(ARCH)/Makefile
 export KBUILD_DEFCONFIG
 
 config %config: scripts_basic outputmakefile FORCE
-	$(Q)mkdir -p include/linux
+	$(Q)mkdir -p include/linux include/config
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
 	$(Q)$(MAKE) -C $(srctree) KBUILD_SRC= .kernelrelease
 
@@ -423,8 +423,6 @@ PHONY += scripts
 scripts: scripts_basic include/config/MARKER
 	$(Q)$(MAKE) $(build)=$(@)
 
-scripts_basic: include/linux/autoconf.h
-
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
 drivers-y	:= drivers/ sound/
@@ -438,25 +436,22 @@ ifeq ($(dot-config),1)
 
 # Read in dependencies to all Kconfig* files, make sure to run
 # oldconfig if changes are detected.
--include .kconfig.d
-
-include .config
+-include include/config/auto.conf.cmd
+-include include/config/auto.conf
 
-# If .config needs to be updated, it will be done via the dependency
-# that autoconf has on .config.
 # To avoid any implicit rule to kick in, define an empty command
-.config .kconfig.d: ;
+.config include/config/auto.conf.cmd: ;
 
-# If .config is newer than include/linux/autoconf.h, someone tinkered
+# If .config is newer than include/config/auto.conf, someone tinkered
 # with it and forgot to run make oldconfig.
-# If kconfig.d is missing then we are probarly in a cleaned tree so
+# if auto.conf.cmd is missing then we are probarly in a cleaned tree so
 # we execute the config step to be sure to catch updated Kconfig files
-include/linux/autoconf.h: .kconfig.d .config
-	$(Q)mkdir -p include/linux
+include/config/auto.conf: .config include/config/auto.conf.cmd
 	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
+
 else
 # Dummy target needed, because used as prerequisite
-include/linux/autoconf.h: ;
+include/config/auto.conf: ;
 endif
 
 # The all: target is the default when no target is given on the
@@ -781,7 +776,7 @@ PHONY += prepare-all
 prepare3: .kernelrelease
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
-	$(Q)if [ -f $(srctree)/.config ]; then \
+	$(Q)if [ -f $(srctree)/.config -o -d $(srctree)/include/config ]; then \
 		echo "  $(srctree) is not clean, please run 'make mrproper'";\
 		echo "  in the '$(srctree)' directory.";\
 		/bin/false; \
@@ -824,7 +819,7 @@ include/asm:
 
 # 	Split autoconf.h into include/linux/config/*
 
-include/config/MARKER: scripts/basic/split-include include/linux/autoconf.h
+include/config/MARKER: scripts/basic/split-include include/config/auto.conf
 	@echo '  SPLIT   include/linux/autoconf.h -> include/config/*'
 	@scripts/basic/split-include include/linux/autoconf.h include/config
 	@touch $@
Index: linux-2.6-git/scripts/Makefile.build
===================================================================
--- linux-2.6-git.orig/scripts/Makefile.build
+++ linux-2.6-git/scripts/Makefile.build
@@ -8,7 +8,7 @@ PHONY := __build
 __build:
 
 # Read .config if it exist, otherwise ignore
--include .config
+-include include/config/auto.conf
 
 include scripts/Kbuild.include
 
Index: linux-2.6-git/scripts/Makefile.modpost
===================================================================
--- linux-2.6-git.orig/scripts/Makefile.modpost
+++ linux-2.6-git/scripts/Makefile.modpost
@@ -35,7 +35,7 @@
 PHONY := _modpost
 _modpost: __modpost
 
-include .config
+include include/config/auto.conf
 include scripts/Kbuild.include
 include scripts/Makefile.lib
 
Index: linux-2.6-git/scripts/kconfig/conf.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/conf.c
+++ linux-2.6-git/scripts/kconfig/conf.c
@@ -598,7 +598,15 @@ int main(int ac, char **av)
 			input_mode = ask_silent;
 			valid_stdin = 1;
 		}
-	}
+	} else if (sym_change_count) {
+		name = getenv("KCONFIG_NOSILENTUPDATE");
+		if (name && *name) {
+			fprintf(stderr, _("\n*** Kernel configuration requires explicit update.\n\n"));
+			return 1;
+		}
+	} else
+		goto skip_check;
+
 	do {
 		conf_cnt = 0;
 		check_conf(&rootmenu);
@@ -607,5 +615,11 @@ int main(int ac, char **av)
 		fprintf(stderr, _("\n*** Error during writing of the kernel configuration.\n\n"));
 		return 1;
 	}
+skip_check:
+	if (input_mode == ask_silent && conf_write_autoconf()) {
+		fprintf(stderr, _("\n*** Error during writing of the kernel configuration.\n\n"));
+		return 1;
+	}
+
 	return 0;
 }
Index: linux-2.6-git/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/confdata.c
+++ linux-2.6-git/scripts/kconfig/confdata.c
@@ -339,7 +339,7 @@ int conf_read(const char *name)
 
 int conf_write(const char *name)
 {
-	FILE *out, *out_h;
+	FILE *out;
 	struct symbol *sym;
 	struct menu *menu;
 	const char *basename;
@@ -376,13 +376,6 @@ int conf_write(const char *name)
 	out = fopen(newname, "w");
 	if (!out)
 		return 1;
-	out_h = NULL;
-	if (!name) {
-		out_h = fopen(".tmpconfig.h", "w");
-		if (!out_h)
-			return 1;
-		file_write_dep(NULL);
-	}
 	sym = sym_lookup("KERNELVERSION", 0);
 	sym_calc_value(sym);
 	time(&now);
@@ -398,16 +391,6 @@ int conf_write(const char *name)
 		     sym_get_string_value(sym),
 		     use_timestamp ? "# " : "",
 		     use_timestamp ? ctime(&now) : "");
-	if (out_h)
-		fprintf(out_h, "/*\n"
-			       " * Automatically generated C config: don't edit\n"
-			       " * Linux kernel version: %s\n"
-			       "%s%s"
-			       " */\n"
-			       "#define AUTOCONF_INCLUDED\n",
-			       sym_get_string_value(sym),
-			       use_timestamp ? " * " : "",
-			       use_timestamp ? ctime(&now) : "");
 
 	if (!sym_change_count)
 		sym_clear_all_valid();
@@ -423,11 +406,6 @@ int conf_write(const char *name)
 				     "#\n"
 				     "# %s\n"
 				     "#\n", str);
-			if (out_h)
-				fprintf(out_h, "\n"
-					       "/*\n"
-					       " * %s\n"
-					       " */\n", str);
 		} else if (!(sym->flags & SYMBOL_CHOICE)) {
 			sym_calc_value(sym);
 			if (!(sym->flags & SYMBOL_WRITE))
@@ -445,59 +423,39 @@ int conf_write(const char *name)
 				switch (sym_get_tristate_value(sym)) {
 				case no:
 					fprintf(out, "# CONFIG_%s is not set\n", sym->name);
-					if (out_h)
-						fprintf(out_h, "#undef CONFIG_%s\n", sym->name);
 					break;
 				case mod:
 					fprintf(out, "CONFIG_%s=m\n", sym->name);
-					if (out_h)
-						fprintf(out_h, "#define CONFIG_%s_MODULE 1\n", sym->name);
 					break;
 				case yes:
 					fprintf(out, "CONFIG_%s=y\n", sym->name);
-					if (out_h)
-						fprintf(out_h, "#define CONFIG_%s 1\n", sym->name);
 					break;
 				}
 				break;
 			case S_STRING:
-				// fix me
 				str = sym_get_string_value(sym);
 				fprintf(out, "CONFIG_%s=\"", sym->name);
-				if (out_h)
-					fprintf(out_h, "#define CONFIG_%s \"", sym->name);
-				do {
+				while (1) {
 					l = strcspn(str, "\"\\");
 					if (l) {
 						fwrite(str, l, 1, out);
-						if (out_h)
-							fwrite(str, l, 1, out_h);
-					}
-					str += l;
-					while (*str == '\\' || *str == '"') {
-						fprintf(out, "\\%c", *str);
-						if (out_h)
-							fprintf(out_h, "\\%c", *str);
-						str++;
+						str += l;
 					}
-				} while (*str);
+					if (!*str)
+						break;
+					fprintf(out, "\\%c", *str++);
+				}
 				fputs("\"\n", out);
-				if (out_h)
-					fputs("\"\n", out_h);
 				break;
 			case S_HEX:
 				str = sym_get_string_value(sym);
 				if (str[0] != '0' || (str[1] != 'x' && str[1] != 'X')) {
 					fprintf(out, "CONFIG_%s=%s\n", sym->name, str);
-					if (out_h)
-						fprintf(out_h, "#define CONFIG_%s 0x%s\n", sym->name, str);
 					break;
 				}
 			case S_INT:
 				str = sym_get_string_value(sym);
 				fprintf(out, "CONFIG_%s=%s\n", sym->name, str);
-				if (out_h)
-					fprintf(out_h, "#define CONFIG_%s %s\n", sym->name, str);
 				break;
 			}
 		}
@@ -517,10 +475,6 @@ int conf_write(const char *name)
 		}
 	}
 	fclose(out);
-	if (out_h) {
-		fclose(out_h);
-		rename(".tmpconfig.h", "include/linux/autoconf.h");
-	}
 	if (!name || basename != conf_def_filename) {
 		if (!name)
 			name = conf_def_filename;
@@ -539,3 +493,120 @@ int conf_write(const char *name)
 
 	return 0;
 }
+
+int conf_write_autoconf(void)
+{
+	struct symbol *sym;
+	const char *str;
+	char *name;
+	FILE *out, *out_h;
+	time_t now;
+	int i, l;
+
+	file_write_dep("include/config/auto.conf.cmd");
+
+	out = fopen(".tmpconfig", "w");
+	if (!out)
+		return 1;
+
+	out_h = fopen(".tmpconfig.h", "w");
+	if (!out_h) {
+		fclose(out);
+		return 1;
+	}
+
+	sym = sym_lookup("KERNELVERSION", 0);
+	sym_calc_value(sym);
+	time(&now);
+	fprintf(out, "#\n"
+		     "# Automatically generated make config: don't edit\n"
+		     "# Linux kernel version: %s\n"
+		     "# %s"
+		     "#\n",
+		     sym_get_string_value(sym), ctime(&now));
+	fprintf(out_h, "/*\n"
+		       " * Automatically generated C config: don't edit\n"
+		       " * Linux kernel version: %s\n"
+		       " * %s"
+		       " */\n"
+		       "#define AUTOCONF_INCLUDED\n",
+		       sym_get_string_value(sym), ctime(&now));
+
+	sym_clear_all_valid();
+
+	for_all_symbols(i, sym) {
+		sym_calc_value(sym);
+		if (!(sym->flags & SYMBOL_WRITE) || !sym->name)
+			continue;
+		switch (sym->type) {
+		case S_BOOLEAN:
+		case S_TRISTATE:
+			switch (sym_get_tristate_value(sym)) {
+			case no:
+				break;
+			case mod:
+				fprintf(out, "CONFIG_%s=m\n", sym->name);
+				fprintf(out_h, "#define CONFIG_%s_MODULE 1\n", sym->name);
+				break;
+			case yes:
+				fprintf(out, "CONFIG_%s=y\n", sym->name);
+				fprintf(out_h, "#define CONFIG_%s 1\n", sym->name);
+				break;
+			}
+			break;
+		case S_STRING:
+			str = sym_get_string_value(sym);
+			fprintf(out, "CONFIG_%s=\"", sym->name);
+			fprintf(out_h, "#define CONFIG_%s \"", sym->name);
+			while (1) {
+				l = strcspn(str, "\"\\");
+				if (l) {
+					fwrite(str, l, 1, out);
+					fwrite(str, l, 1, out_h);
+					str += l;
+				}
+				if (!*str)
+					break;
+				fprintf(out, "\\%c", *str);
+				fprintf(out_h, "\\%c", *str);
+				str++;
+			}
+			fputs("\"\n", out);
+			fputs("\"\n", out_h);
+			break;
+		case S_HEX:
+			str = sym_get_string_value(sym);
+			if (str[0] != '0' || (str[1] != 'x' && str[1] != 'X')) {
+				fprintf(out, "CONFIG_%s=%s\n", sym->name, str);
+				fprintf(out_h, "#define CONFIG_%s 0x%s\n", sym->name, str);
+				break;
+			}
+		case S_INT:
+			str = sym_get_string_value(sym);
+			fprintf(out, "CONFIG_%s=%s\n", sym->name, str);
+			fprintf(out_h, "#define CONFIG_%s %s\n", sym->name, str);
+			break;
+		default:
+			break;
+		}
+	}
+	fclose(out);
+	fclose(out_h);
+
+	name = getenv("KCONFIG_AUTOHEADER");
+	if (!name)
+		name = "include/linux/autoconf.h";
+	if (rename(".tmpconfig.h", name))
+		return 1;
+	name = getenv("KCONFIG_AUTOCONFIG");
+	if (!name)
+		name = "include/config/auto.conf";
+	/*
+	 * This must be the last step, kbuild has a dependency on auto.conf
+	 * and this marks the successful completion of the previous steps.
+	 */
+	if (rename(".tmpconfig", name))
+		return 1;
+
+	return 0;
+}
Index: linux-2.6-git/scripts/kconfig/lkc_proto.h
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/lkc_proto.h
+++ linux-2.6-git/scripts/kconfig/lkc_proto.h
@@ -4,6 +4,7 @@ P(conf_parse,void,(const char *name));
 P(conf_read,int,(const char *name));
 P(conf_read_simple,int,(const char *name));
 P(conf_write,int,(const char *name));
+P(conf_write_autoconf,int,(void));
 
 /* menu.c */
 P(rootmenu,struct menu,);
Index: linux-2.6-git/scripts/kconfig/util.c
===================================================================
--- linux-2.6-git.orig/scripts/kconfig/util.c
+++ linux-2.6-git/scripts/kconfig/util.c
@@ -44,7 +44,9 @@ int file_write_dep(const char *name)
 		else
 			fprintf(out, "\t%s\n", file->name);
 	}
-	fprintf(out, "\n.config include/linux/autoconf.h: $(deps_config)\n\n$(deps_config):\n");
+	fprintf(out, "\ninclude/config/auto.conf: \\\n"
+		     "\t$(deps_config)\n\n"
+		     "$(deps_config): ;\n");
 	fclose(out);
 	rename("..config.tmp", name);
 	return 0;
