Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317865AbSHDP2M>; Sun, 4 Aug 2002 11:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSHDP2M>; Sun, 4 Aug 2002 11:28:12 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:45831 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317865AbSHDP2I>; Sun, 4 Aug 2002 11:28:08 -0400
Message-ID: <3D4D48A7.6BA919D2@linux-m68k.org>
Date: Sun, 04 Aug 2002 17:30:47 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       martin@dalecki.de
Subject: Re: [PATCH] automatic module_init ordering
References: <20020802232232.A25583@mars.ravnborg.org> <Pine.LNX.4.44.0208022011490.24984-100000@chaos.physics.uiowa.edu> <20020804001147.A9226@mars.ravnborg.org>
Content-Type: multipart/mixed;
 boundary="------------1DE308EBBE4BDFDF2C2CF45F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1DE308EBBE4BDFDF2C2CF45F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Martin, could you please check the ide initialization? Why are device
type driver initialized twice? If I try to remove one of them, one
machine here doesn't boot anymore.

Sam Ravnborg wrote:

> Another issue that I noticed after submitting the patch was that
> due to the fact the 'echo' in gen_build... always create a .builtin_mods
> file, there appear a number of lines only listing an empty directory
> witin .allbuiltin_mods.

.builtin_mods should be empty in this case.

> 2) to do something like this in the Makefile:
> init/generated-initcalls.c: $(wildcard $(addsuffix /.builtin_mods,\
> $(dir $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)))
>         $(CONFIG_SHELL) -e scripts/build-initcalls $< $^ $@
> And then move the contatenation of the .builtin_mods files to
> build-initcalls.

Nice idea. Done.

> Another issue:
> If I do:
> $> find -name '.builtin_mods' | xargs rm -f
> $> make
> the .builtin_mods files are not regenerated. Some rule are missing...

Could you try the attached patch? It should fix all the mentioned
problems. Files are now regenerated only if something really changed.
if_changed needed a fix to correctly save the command line and
dependencies should be correct now.

bye, Roman
--------------1DE308EBBE4BDFDF2C2CF45F
Content-Type: text/plain; charset=us-ascii;
 name="initcall.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="initcall.diff"

diff -Nur -X /opt/home/roman/nodiff linux-2.5/Makefile linux-initcall/Makefile
--- linux-2.5/Makefile	Sun Aug  4 02:33:23 2002
+++ linux-initcall/Makefile	Sun Aug  4 15:01:11 2002
@@ -268,6 +268,7 @@
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -283,13 +284,26 @@
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
+builtin_mods := $(addsuffix .builtin_mods,$(sort $(dir $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS))))
+
+quiet_cmd_gen_initcalls = GEN    $@
+cmd_gen_initcalls = $(CONFIG_SHELL) -e scripts/build-initcalls $@ $(builtin_mods)
+
+define rule_gen_initcalls
+	$(call cmd,gen_initcalls)
+	@echo 'cmd_$(@F) := $(cmd_gen_initcalls)' > .$(@F).cmd
+endef
+
+init/generated-initcalls.c: $(builtin_mods) FORCE
+	$(call if_changed_rule,gen_initcalls)
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
-$(sort $(vmlinux-objs)): $(SUBDIRS) ;
+$(sort $(vmlinux-objs)) $(builtin_mods): $(SUBDIRS) ;
 
 # 	Handle descending into subdirectories listed in $(SUBDIRS)
 
@@ -585,7 +599,7 @@
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
-	include/linux/compile.h \
+	include/linux/compile.h init/generated-initcalls.c \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
 	drivers/char/conmakehash \
@@ -646,7 +660,7 @@
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name .builtin_mods \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -f Documentation/DocBook/Makefile clean
diff -Nur -X /opt/home/roman/nodiff linux-2.5/Rules.make linux-initcall/Rules.make
--- linux-2.5/Rules.make	Sun Aug  4 15:10:11 2002
+++ linux-initcall/Rules.make	Sun Aug  4 02:34:52 2002
@@ -95,17 +95,22 @@
 multi-used-y := $(filter-out $(list-multi),$(__multi-used-y))
 multi-used-m := $(filter-out $(list-multi),$(__multi-used-m))
 
+multi-used   := $(multi-used-y) $(multi-used-m)
+
 # Build list of the parts of our composite objects, our composite
 # objects depend on those (obviously)
 multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)))
 multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)))
 
+multi-objs   := $(multi-objs-y) $(multi-objs-m)
+
 # $(subdir-obj-y) is the list of objects in $(obj-y) which do not live
 # in the local directory
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
 
 # Replace multi-part objects by their individual parts, look at local dir only
-real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
+local-objs-y := $(filter-out $(subdir-obj-y), $(obj-y))
+real-objs-y := $(foreach m, $(local-objs-y), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
 real-objs-m := $(foreach m, $(obj-m), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m)))
 
 # Only build module versions for files which are selected to be built
@@ -115,6 +120,23 @@
 # contain a comma
 depfile = $(subst $(comma),_,$(@D)/.$(@F).d)
 
+# These flags are needed for modversions and compiling, so we define them here
+# already
+# $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will 
+# end up in (or would, if it gets compiled in)
+# Note: It's possible that one object gets potentially linked into more
+#       than one module. In that case KBUILD_MODNAME will be set to foo_bar,
+#       where foo and bar are the name of the modules.
+basename_flags = -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F)))
+modname_flags  = -DKBUILD_MODNAME=$(subst $(comma),_,$(subst -,_,$(modname)))
+c_flags        = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
+	         $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
+	         $(basename_flags) $(modname_flags) $(export_flags) 
+
+# Finds the multi-part object the current object will be linked into
+modname-multi = $(subst $(space),_,$(strip $(foreach m,$(multi-used),\
+		$(if $(filter $(*F).o,$($(m:.o=-objs))),$(m:.o=)))))
+
 # We're called for one of three purposes:
 # o fastdep: build module version files (.ver) for $(export-objs) in
 #   the current directory
@@ -164,11 +186,10 @@
 $(addprefix $(MODVERDIR)/,$(real-objs-y:.o=.ver)): modkern_cflags := $(CFLAGS_KERNEL)
 $(addprefix $(MODVERDIR)/,$(real-objs-m:.o=.ver)): modkern_cflags := $(CFLAGS_MODULE)
 $(addprefix $(MODVERDIR)/,$(export-objs:.o=.ver)): export_flags   := -D__GENKSYMS__
+# Default for not multi-part modules
+modname = $(*F)
 
-c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
-	  $(export_flags) 
+$(addprefix $(MODVERDIR)/,$(multi-objs:.o=.ver)) : modname = $(modname-multi)
 
 # Our objects only depend on modversions.h, not on the individual .ver
 # files (fix-dep filters them), so touch modversions.h if any of the .ver
@@ -248,7 +269,7 @@
 #	The echo suppresses the "Nothing to be done for first_rule"
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
 	    $(if $(KBUILD_MODULES),$(obj-m)) \
-	    sub_dirs
+	    sub_dirs .builtin_mods
 	@echo -n
 
 # Compile C sources (.c)
@@ -259,6 +280,7 @@
 
 $(real-objs-m)        : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.i)  : modkern_cflags := $(CFLAGS_MODULE)
+$(real-objs-m:.o=.s)  : modkern_cflags := $(CFLAGS_MODULE)
 $(real-objs-m:.o=.lst): modkern_cflags := $(CFLAGS_MODULE)
 
 $(export-objs)        : export_flags   := $(EXPORT_FLAGS)
@@ -266,10 +288,13 @@
 $(export-objs:.o=.s)  : export_flags   := $(EXPORT_FLAGS)
 $(export-objs:.o=.lst): export_flags   := $(EXPORT_FLAGS)
 
-c_flags = -Wp,-MD,$(depfile) $(CFLAGS) $(NOSTDINC_FLAGS) \
-	  $(modkern_cflags) $(EXTRA_CFLAGS) $(CFLAGS_$(*F).o) \
-	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
-	  $(export_flags) 
+# Default for not multi-part modules
+modname = $(*F)
+
+$(multi-objs)         : modname = $(modname-multi)
+$(multi-objs:.o=.i)   : modname = $(modname-multi)
+$(multi-objs:.o=.s)   : modname = $(modname-multi)
+$(multi-objs:.o=.lst) : modname = $(modname-multi)
 
 quiet_cmd_cc_s_c = CC     $(echo_target)
 cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
@@ -295,6 +320,25 @@
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
 
+subdir-builtin_mods := $(addsuffix /.builtin_mods,$(subdir-y))
+
+$(subdir-builtin_mods): sub_dirs
+
+quiet_cmd_gen_builtin_mod = MOD    $(echo_target)
+define cmd_gen_builtin_mod
+	objs="$(sort $(local-objs-y))"; for o in $$objs; do \
+	  if [ -n "$$($(OBJDUMP) -h $$o | grep .initcall.module)" ]; then \
+	    echo $$o; \
+	  fi \
+	done > $@; \
+	dirs="$(sort $(subdir-y))"; for d in $$dirs; do \
+	  sed "s,^,$$d/," < $$d/.builtin_mods; \
+	done >> $@
+endef
+
+.builtin_mods: $(local-objs-y) $(subdir-builtin_mods) FORCE
+	$(call if_changed,gen_builtin_mod)
+
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------
 
@@ -318,7 +362,7 @@
 %.o: %.S FORCE
 	$(call if_changed_dep,as_o_S)
 
-targets += $(real-objs-y) $(real-objs-m) $(EXTRA_TARGETS) $(MAKECMDGOALS)
+targets += $(real-objs-y) $(real-objs-m) $(EXTRA_TARGETS) $(MAKECMDGOALS) .builtin_mods
 
 # Build the compiled-in targets
 # ---------------------------------------------------------------------------
@@ -523,7 +567,7 @@
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
 	$(cmd_$(1)); \
-	echo 'cmd_$@ := $(cmd_$(1))' > $(@D)/.$(@F).cmd)
+	echo 'cmd_$@ := $(subst $$,$$$$,$(cmd_$(1)))' > $(@D)/.$(@F).cmd)
 
 
 # execute the command and also postprocess generated .d dependencies
@@ -535,7 +579,7 @@
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
 	$(cmd_$(1)); \
-	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
+	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(subst $$,$$$$,$(cmd_$(1)))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
 
diff -Nur -X /opt/home/roman/nodiff linux-2.5/drivers/ide/main.c linux-initcall/drivers/ide/main.c
--- linux-2.5/drivers/ide/main.c	Sun Aug  4 02:33:23 2002
+++ linux-initcall/drivers/ide/main.c	Sun Aug  4 02:34:52 2002
@@ -1417,23 +1417,6 @@
 	}
 # endif
 #endif
-
-	/*
-	 * Initialize all device type driver modules.
-	 */
-#ifdef CONFIG_BLK_DEV_IDEDISK
-	idedisk_init();
-#endif
-#ifdef CONFIG_BLK_DEV_IDECD
-	ide_cdrom_init();
-#endif
-#ifdef CONFIG_BLK_DEV_IDETAPE
-	idetape_init();
-#endif
-#ifdef CONFIG_BLK_DEV_IDEFLOPPY
-	idefloppy_init();
-#endif
-
 	initializing = 0;
 
 	register_reboot_notifier(&ata_notifier);
diff -Nur -X /opt/home/roman/nodiff linux-2.5/fs/dnotify.c linux-initcall/fs/dnotify.c
--- linux-2.5/fs/dnotify.c	Sun Aug  4 02:33:23 2002
+++ linux-initcall/fs/dnotify.c	Sun Aug  4 02:34:52 2002
@@ -155,4 +155,4 @@
 	return 0;
 }
 
-module_init(dnotify_init)
+fs_initcall(dnotify_init);
diff -Nur -X /opt/home/roman/nodiff linux-2.5/fs/fcntl.c linux-initcall/fs/fcntl.c
--- linux-2.5/fs/fcntl.c	Sun Aug  4 02:33:23 2002
+++ linux-initcall/fs/fcntl.c	Sun Aug  4 02:34:52 2002
@@ -568,4 +568,4 @@
 	return 0;
 }
 
-module_init(fasync_init)
+fs_initcall(fasync_init);
diff -Nur -X /opt/home/roman/nodiff linux-2.5/fs/locks.c linux-initcall/fs/locks.c
--- linux-2.5/fs/locks.c	Sun Aug  4 02:33:23 2002
+++ linux-initcall/fs/locks.c	Sun Aug  4 02:34:52 2002
@@ -1890,4 +1890,4 @@
 	return 0;
 }
 
-module_init(filelock_init)
+fs_initcall(filelock_init);
diff -Nur -X /opt/home/roman/nodiff linux-2.5/include/linux/init.h linux-initcall/include/linux/init.h
--- linux-2.5/include/linux/init.h	Sun Aug  4 02:33:23 2002
+++ linux-initcall/include/linux/init.h	Sun Aug  4 02:34:52 2002
@@ -106,6 +106,9 @@
 #define __FINIT		.previous
 #define __INITDATA	.section	".data.init","aw"
 
+#define ___concat(a,b)	a##b
+#define __concat(a,b)	___concat(a,b)
+
 /**
  * module_init() - driver initialization entry point
  * @x: function to be run at kernel boot time or module insertion
@@ -116,7 +119,10 @@
  * routine with init_module() which is used by insmod and
  * modprobe when the driver is used as a module.
  */
-#define module_init(x)	__initcall(x);
+#define module_init(x)					\
+int __attribute__((__section__ (".initcall.module")))	\
+__concat(init_module_,KBUILD_MODNAME)(void)		\
+{ return x(); }
 
 /**
  * module_exit() - driver exit entry point
diff -Nur -X /opt/home/roman/nodiff linux-2.5/kernel/module.c linux-initcall/kernel/module.c
--- linux-2.5/kernel/module.c	Sun Aug  4 02:33:23 2002
+++ linux-initcall/kernel/module.c	Sun Aug  4 02:34:52 2002
@@ -252,6 +252,19 @@
 	arch_init_modules(&kernel_module);
 }
 
+extern initcall_t generated_initcalls[];
+
+static int __init init_builtin_modules(void)
+{
+	initcall_t *call;
+
+	for (call = generated_initcalls; *call; call++)
+		(*call)();
+	return 0;
+}
+
+device_initcall(init_builtin_modules);
+
 /*
  * Copy the name of a module from user space.
  */
diff -Nur -X /opt/home/roman/nodiff linux-2.5/net/unix/af_unix.c linux-initcall/net/unix/af_unix.c
--- linux-2.5/net/unix/af_unix.c	Sun Aug  4 02:33:23 2002
+++ linux-initcall/net/unix/af_unix.c	Sun Aug  4 02:34:52 2002
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
diff -Nur -X /opt/home/roman/nodiff linux-2.5/scripts/build-initcalls linux-initcall/scripts/build-initcalls
--- linux-2.5/scripts/build-initcalls	Thu Jan  1 01:00:00 1970
+++ linux-initcall/scripts/build-initcalls	Sun Aug  4 15:00:04 2002
@@ -0,0 +1,45 @@
+initsrc=$1
+shift
+
+# initialize files
+echo -n > .undefined.tmp
+echo -n > .defined.tmp
+echo -n > .all.tmp
+
+# get all global defined/undefined symbols and sort them into the right files
+for file in $@; do
+  sed "s;^;$(dirname $file)/;" < $file |
+  while read obj; do
+    echo $obj >> .all.tmp
+    $NM $obj | sed -n "s;^[0-9a-f ]*\([UTD] .*\);\1 $obj;p"
+  done
+done |
+awk '/^U/ { print $2 " " $3 | "sort -u > .undefined.tmp" }
+     /^[TD]/ { print $2 " " $3 | "sort -u > .defined.tmp" }'
+
+# topological sort objects and append all independent objects
+join -o "1.2 2.2" .defined.tmp .undefined.tmp | sort -u | tsort > .sorted.tmp
+grep -v -f .sorted.tmp < .all.tmp > .other.tmp
+cat .other.tmp >> .sorted.tmp
+
+# extract init function call and prepare declarations and array
+while read obj; do
+  call=$($OBJDUMP -t $obj | awk '/F \.initcall\.module/ { print $6 }')
+  arr="$arr $call"
+done < .sorted.tmp
+
+# finally write it
+(
+  echo "#include <linux/init.h>"
+  for f in $arr; do
+    echo "extern int $f(void);"
+  done
+  echo "initcall_t __initdata generated_initcalls[] = {"
+  for f in $arr; do
+    echo "  $f,"
+  done
+  echo "0 };"
+) > $initsrc
+
+# clean up
+rm .undefined.tmp .defined.tmp .all.tmp .sorted.tmp .other.tmp

--------------1DE308EBBE4BDFDF2C2CF45F--

