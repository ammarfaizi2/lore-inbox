Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318835AbSHETDZ>; Mon, 5 Aug 2002 15:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318838AbSHETDZ>; Mon, 5 Aug 2002 15:03:25 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:36871 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S318835AbSHETDT>; Mon, 5 Aug 2002 15:03:19 -0400
Message-ID: <3D4ECC69.F0084A2C@linux-m68k.org>
Date: Mon, 05 Aug 2002 21:05:13 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] automatic module_init ordering
References: <20020805062048.E41684273@lists.samba.org>
Content-Type: multipart/mixed;
 boundary="------------654CFCA0A5D397BE60D130DD"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------654CFCA0A5D397BE60D130DD
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

Rusty Russell wrote:

> 1) Rename build-initcalls to build-module-initcalls
> 2) Generate explicit calls, which is clearer than an array.
> 3) Simplify (and hopefully speed up) by calling $(NM) once for all files.
> 4) Call initcalls from init/main.c rather then kernel/module.c
> 
> There seems to be a problem in that .allbuiltin_mods doesn't include
> stuff in net/ipv4/netfilter/.builtin_mods for example (set
> CONFIG_NETFILTER=y, CONFIG_IP_NF_IPTABLES=y, everything else there to Y).

Are you sure sent the right patch? This one misses a few changes.
Anyway, I stole all the good ideas and integrated them into my patch. :)
- I use a separate initcall for the module initialization, that's the
only way I can solve my IDE problems.
- I put the initcall for that directly into the generated file.
- raid autodetect became a late_initcall()
- I don't use trap to clean up, so people can send us the temporary
files, if something should go wrong. These files will be removed by a
normal 'make clean' anyway.

bye, Roman
--------------654CFCA0A5D397BE60D130DD
Content-Type: text/plain; charset=us-ascii;
 name="modinit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modinit.diff"

diff -Nur linux-modname/Makefile linux-modinit/Makefile
--- linux-modname/Makefile	Sun Aug  4 02:33:23 2002
+++ linux-modinit/Makefile	Mon Aug  5 20:30:36 2002
@@ -268,6 +268,7 @@
 		$(DRIVERS) \
 		$(NETWORKS) \
 		--end-group \
+		init/generated-initcalls.o \
 		-o vmlinux
 
 #	set -e makes the rule exit immediately on error
@@ -283,13 +284,29 @@
 	$(NM) vmlinux | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > System.map
 endef
 
-vmlinux: $(vmlinux-objs) FORCE
+vmlinux: $(vmlinux-objs) init/generated-initcalls.o FORCE
 	$(call if_changed_rule,link_vmlinux)
 
+#	.builtin_mods contains a list of objects with module_init() calls
+#	sort these calls into the right order similiar to depmod
+
+builtin_mods := $(addsuffix .builtin_mods,$(sort $(dir $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS))))
+
+quiet_cmd_gen_initcalls = GEN    $@
+cmd_gen_initcalls = $(CONFIG_SHELL) scripts/build-module-initcalls > $@ $(builtin_mods)
+
+define rule_gen_initcalls
+	$(call cmd,gen_initcalls)
+	@echo 'cmd_$(notdir $@) := $(cmd_gen_initcalls)' > .$(notdir $@).cmd
+endef
+
+init/generated-initcalls.c: $(builtin_mods) scripts/build-module-initcalls FORCE
+	$(call if_changed_rule,gen_initcalls)
+
 #	The actual objects are generated when descending, 
 #	make sure no implicit rule kicks in
 
-$(sort $(vmlinux-objs)): $(SUBDIRS) ;
+$(sort $(vmlinux-objs)) $(builtin_mods): $(SUBDIRS) ;
 
 # 	Handle descending into subdirectories listed in $(SUBDIRS)
 
@@ -585,7 +602,7 @@
 
 #	files removed with 'make clean'
 CLEAN_FILES += \
-	include/linux/compile.h \
+	include/linux/compile.h init/generated-initcalls.c \
 	vmlinux System.map \
 	drivers/char/consolemap_deftbl.c drivers/video/promcon_tbl.c \
 	drivers/char/conmakehash \
@@ -646,7 +663,7 @@
 	@echo 'Cleaning up'
 	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
-		-name .\*.tmp -o -name .\*.d \) -type f -print \
+		-name .\*.tmp -o -name .\*.d -o -name .builtin_mods \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
 	@$(MAKE) -f Documentation/DocBook/Makefile clean
diff -Nur linux-modname/Rules.make linux-modinit/Rules.make
--- linux-modname/Rules.make	Mon Aug  5 19:54:16 2002
+++ linux-modinit/Rules.make	Mon Aug  5 19:55:47 2002
@@ -109,7 +109,8 @@
 subdir-obj-y := $(foreach o,$(obj-y),$(if $(filter-out $(o),$(notdir $(o))),$(o)))
 
 # Replace multi-part objects by their individual parts, look at local dir only
-real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
+local-objs-y := $(filter-out $(subdir-obj-y), $(obj-y))
+real-objs-y := $(foreach m, $(local-objs-y), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m))) $(EXTRA_TARGETS)
 real-objs-m := $(foreach m, $(obj-m), $(if $($(m:.o=-objs)),$($(m:.o=-objs)),$(m)))
 
 # Only build module versions for files which are selected to be built
@@ -268,7 +269,7 @@
 #	The echo suppresses the "Nothing to be done for first_rule"
 first_rule: $(if $(KBUILD_BUILTIN),$(O_TARGET) $(L_TARGET) $(EXTRA_TARGETS)) \
 	    $(if $(KBUILD_MODULES),$(obj-m)) \
-	    sub_dirs
+	    sub_dirs .builtin_mods
 	@echo -n
 
 # Compile C sources (.c)
@@ -319,6 +320,25 @@
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
 
@@ -342,7 +362,7 @@
 %.o: %.S FORCE
 	$(call if_changed_dep,as_o_S)
 
-targets += $(real-objs-y) $(real-objs-m) $(EXTRA_TARGETS) $(MAKECMDGOALS)
+targets += $(real-objs-y) $(real-objs-m) $(EXTRA_TARGETS) $(MAKECMDGOALS) .builtin_mods
 
 # Build the compiled-in targets
 # ---------------------------------------------------------------------------
@@ -547,7 +567,7 @@
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
 	$(cmd_$(1)); \
-	echo 'cmd_$@ := $(cmd_$(1))' > $(@D)/.$(@F).cmd)
+	echo 'cmd_$@ := $(subst $$,$$$$,$(cmd_$(1)))' > $(@D)/.$(@F).cmd)
 
 
 # execute the command and also postprocess generated .d dependencies
@@ -559,7 +579,7 @@
 	@set -e; \
 	$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) \
 	$(cmd_$(1)); \
-	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(cmd_$(1))' > $(@D)/.$(@F).tmp; \
+	$(TOPDIR)/scripts/fixdep $(depfile) $@ $(TOPDIR) '$(subst $$,$$$$,$(cmd_$(1)))' > $(@D)/.$(@F).tmp; \
 	rm -f $(depfile); \
 	mv -f $(@D)/.$(@F).tmp $(@D)/.$(@F).cmd)
 
diff -Nur linux-modname/arch/alpha/vmlinux.lds.in linux-modinit/arch/alpha/vmlinux.lds.in
--- linux-modname/arch/alpha/vmlinux.lds.in	Sun Aug  4 15:10:23 2002
+++ linux-modinit/arch/alpha/vmlinux.lds.in	Mon Aug  5 19:55:47 2002
@@ -55,6 +55,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
 	__initcall_end = .;
   }
 
diff -Nur linux-modname/arch/arm/vmlinux-armo.lds.in linux-modinit/arch/arm/vmlinux-armo.lds.in
--- linux-modname/arch/arm/vmlinux-armo.lds.in	Sun Aug  4 15:10:25 2002
+++ linux-modinit/arch/arm/vmlinux-armo.lds.in	Mon Aug  5 19:55:47 2002
@@ -34,6 +34,7 @@
 			*(.initcall5.init)
 			*(.initcall6.init)
 			*(.initcall7.init)
+			*(.initcall8.init)
 		__initcall_end = .;
 		. = ALIGN(32768);
 		__init_end = .;
diff -Nur linux-modname/arch/arm/vmlinux-armv.lds.in linux-modinit/arch/arm/vmlinux-armv.lds.in
--- linux-modname/arch/arm/vmlinux-armv.lds.in	Sun Aug  4 15:10:25 2002
+++ linux-modinit/arch/arm/vmlinux-armv.lds.in	Mon Aug  5 19:55:47 2002
@@ -34,6 +34,7 @@
 			*(.initcall5.init)
 			*(.initcall6.init)
 			*(.initcall7.init)
+			*(.initcall8.init)
 		__initcall_end = .;
 		. = ALIGN(4096);
 		__init_end = .;
diff -Nur linux-modname/arch/cris/cris.ld linux-modinit/arch/cris/cris.ld
--- linux-modname/arch/cris/cris.ld	Sun Aug  4 15:10:36 2002
+++ linux-modinit/arch/cris/cris.ld	Mon Aug  5 19:55:47 2002
@@ -70,6 +70,7 @@
 		*(.initcall5.init);
 		*(.initcall6.init);
 		*(.initcall7.init);
+		*(.initcall8.init);
 		__initcall_end = .;
 
 		/* We fill to the next page, so we can discard all init
diff -Nur linux-modname/arch/i386/vmlinux.lds linux-modinit/arch/i386/vmlinux.lds
--- linux-modname/arch/i386/vmlinux.lds	Sun Aug  4 15:10:37 2002
+++ linux-modinit/arch/i386/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -56,6 +56,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(32);
diff -Nur linux-modname/arch/ia64/vmlinux.lds.S linux-modinit/arch/ia64/vmlinux.lds.S
--- linux-modname/arch/ia64/vmlinux.lds.S	Sun Aug  4 15:10:39 2002
+++ linux-modinit/arch/ia64/vmlinux.lds.S	Mon Aug  5 19:55:47 2002
@@ -108,6 +108,7 @@
 		*(.initcall5.init)
 		*(.initcall6.init)
 		*(.initcall7.init)
+		*(.initcall8.init)
 	}
   __initcall_end = .;
   . = ALIGN(PAGE_SIZE);
diff -Nur linux-modname/arch/m68k/vmlinux-sun3.lds linux-modinit/arch/m68k/vmlinux-sun3.lds
--- linux-modname/arch/m68k/vmlinux-sun3.lds	Sun Aug  4 15:10:45 2002
+++ linux-modinit/arch/m68k/vmlinux-sun3.lds	Mon Aug  5 19:55:47 2002
@@ -51,6 +51,7 @@
 		*(.initcall5.init) 
 		*(.initcall6.init) 
 		*(.initcall7.init)
+		*(.initcall8.init)
 	}
 	__initcall_end = .;
 	. = ALIGN(8192);
diff -Nur linux-modname/arch/m68k/vmlinux.lds linux-modinit/arch/m68k/vmlinux.lds
--- linux-modname/arch/m68k/vmlinux.lds	Sun Aug  4 15:10:45 2002
+++ linux-modinit/arch/m68k/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -55,6 +55,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(8192);
diff -Nur linux-modname/arch/mips/ld.script.in linux-modinit/arch/mips/ld.script.in
--- linux-modname/arch/mips/ld.script.in	Sun Aug  4 15:10:51 2002
+++ linux-modinit/arch/mips/ld.script.in	Mon Aug  5 19:55:47 2002
@@ -52,6 +52,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(4096);	/* Align double page for init_task_union */
diff -Nur linux-modname/arch/mips64/ld.script.elf32.S linux-modinit/arch/mips64/ld.script.elf32.S
--- linux-modname/arch/mips64/ld.script.elf32.S	Sun Aug  4 15:10:59 2002
+++ linux-modinit/arch/mips64/ld.script.elf32.S	Mon Aug  5 19:55:47 2002
@@ -48,6 +48,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(4096);	/* Align double page for init_task_union */
diff -Nur linux-modname/arch/mips64/ld.script.elf64 linux-modinit/arch/mips64/ld.script.elf64
--- linux-modname/arch/mips64/ld.script.elf64	Sun Aug  4 15:10:59 2002
+++ linux-modinit/arch/mips64/ld.script.elf64	Mon Aug  5 19:55:47 2002
@@ -58,6 +58,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(4096);	/* Align double page for init_task_union */
diff -Nur linux-modname/arch/parisc/vmlinux.lds linux-modinit/arch/parisc/vmlinux.lds
--- linux-modname/arch/parisc/vmlinux.lds	Sun Aug  4 15:11:01 2002
+++ linux-modinit/arch/parisc/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -60,6 +60,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   __init_end = .;
diff -Nur linux-modname/arch/ppc/vmlinux.lds linux-modinit/arch/ppc/vmlinux.lds
--- linux-modname/arch/ppc/vmlinux.lds	Sun Aug  4 15:11:01 2002
+++ linux-modinit/arch/ppc/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -110,6 +110,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(32);
diff -Nur linux-modname/arch/ppc64/vmlinux.lds linux-modinit/arch/ppc64/vmlinux.lds
--- linux-modname/arch/ppc64/vmlinux.lds	Sun Aug  4 15:11:07 2002
+++ linux-modinit/arch/ppc64/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -108,6 +108,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(32);
diff -Nur linux-modname/arch/s390/vmlinux-shared.lds linux-modinit/arch/s390/vmlinux-shared.lds
--- linux-modname/arch/s390/vmlinux-shared.lds	Sun Aug  4 15:11:11 2002
+++ linux-modinit/arch/s390/vmlinux-shared.lds	Mon Aug  5 19:55:47 2002
@@ -60,6 +60,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(256);
diff -Nur linux-modname/arch/s390/vmlinux.lds linux-modinit/arch/s390/vmlinux.lds
--- linux-modname/arch/s390/vmlinux.lds	Sun Aug  4 15:11:11 2002
+++ linux-modinit/arch/s390/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -56,6 +56,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(256);
diff -Nur linux-modname/arch/s390x/vmlinux-shared.lds linux-modinit/arch/s390x/vmlinux-shared.lds
--- linux-modname/arch/s390x/vmlinux-shared.lds	Sun Aug  4 15:11:12 2002
+++ linux-modinit/arch/s390x/vmlinux-shared.lds	Mon Aug  5 19:55:47 2002
@@ -60,6 +60,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(256);
diff -Nur linux-modname/arch/s390x/vmlinux.lds linux-modinit/arch/s390x/vmlinux.lds
--- linux-modname/arch/s390x/vmlinux.lds	Sun Aug  4 15:11:12 2002
+++ linux-modinit/arch/s390x/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -56,6 +56,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(256);
diff -Nur linux-modname/arch/sh/vmlinux.lds.S linux-modinit/arch/sh/vmlinux.lds.S
--- linux-modname/arch/sh/vmlinux.lds.S	Sun Aug  4 15:11:12 2002
+++ linux-modinit/arch/sh/vmlinux.lds.S	Mon Aug  5 19:55:47 2002
@@ -72,6 +72,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   __machvec_start = .;
diff -Nur linux-modname/arch/sparc/vmlinux.lds linux-modinit/arch/sparc/vmlinux.lds
--- linux-modname/arch/sparc/vmlinux.lds	Sun Aug  4 15:11:17 2002
+++ linux-modinit/arch/sparc/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -54,6 +54,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(32);
diff -Nur linux-modname/arch/sparc64/vmlinux.lds linux-modinit/arch/sparc64/vmlinux.lds
--- linux-modname/arch/sparc64/vmlinux.lds	Sun Aug  4 15:11:19 2002
+++ linux-modinit/arch/sparc64/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -55,6 +55,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(32);
diff -Nur linux-modname/arch/x86_64/vmlinux.lds linux-modinit/arch/x86_64/vmlinux.lds
--- linux-modname/arch/x86_64/vmlinux.lds	Sun Aug  4 15:11:21 2002
+++ linux-modinit/arch/x86_64/vmlinux.lds	Mon Aug  5 19:55:47 2002
@@ -96,6 +96,7 @@
 	*(.initcall5.init) 
 	*(.initcall6.init) 
 	*(.initcall7.init)
+	*(.initcall8.init)
   }
   __initcall_end = .;
   . = ALIGN(32);
diff -Nur linux-modname/drivers/md/md.c linux-modinit/drivers/md/md.c
--- linux-modname/drivers/md/md.c	Sun Aug  4 15:11:53 2002
+++ linux-modinit/drivers/md/md.c	Mon Aug  5 19:55:47 2002
@@ -3237,6 +3237,29 @@
 	return (0);
 }
 
+void __exit md_exit(void)
+{
+	md_unregister_thread(md_recovery_thread);
+	devfs_unregister(devfs_handle);
+
+	unregister_blkdev(MAJOR_NR,"md");
+	unregister_reboot_notifier(&md_notifier);
+	unregister_sysctl_table(raid_table_header);
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("mdstat", NULL);
+#endif
+
+	del_gendisk(&md_gendisk);
+	blk_dev[MAJOR_NR].queue = NULL;
+	blk_clear(MAJOR_NR);
+
+	while (!list_empty(&device_names)) {
+		dev_name_t *tmp = list_entry(device_names.next,
+					     dev_name_t, list);
+		list_del(&tmp->list);
+		kfree(tmp);
+	}
+}
 
 #ifndef MODULE
 
@@ -3539,46 +3562,12 @@
 __setup("raid=", raid_setup);
 __setup("md=", md_setup);
 
-__initcall(md_init);
-__initcall(md_run_setup);
-
-#else /* It is a MODULE */
-
-int init_module(void)
-{
-	return md_init();
-}
-
-static void free_device_names(void)
-{
-	while (!list_empty(&device_names)) {
-		dev_name_t *tmp = list_entry(device_names.next,
-					     dev_name_t, list);
-		list_del(&tmp->list);
-		kfree(tmp);
-	}
-}
+late_initcall(md_run_setup);
 
-
-void cleanup_module(void)
-{
-	md_unregister_thread(md_recovery_thread);
-	devfs_unregister(devfs_handle);
-
-	unregister_blkdev(MAJOR_NR,"md");
-	unregister_reboot_notifier(&md_notifier);
-	unregister_sysctl_table(raid_table_header);
-#ifdef CONFIG_PROC_FS
-	remove_proc_entry("mdstat", NULL);
 #endif
 
-	del_gendisk(&md_gendisk);
-	blk_dev[MAJOR_NR].queue = NULL;
-	blk_clear(MAJOR_NR);
-	
-	free_device_names();
-}
-#endif
+module_init(md_init);
+module_exit(md_exit);
 
 EXPORT_SYMBOL(md_size);
 EXPORT_SYMBOL(register_md_personality);
diff -Nur linux-modname/fs/dnotify.c linux-modinit/fs/dnotify.c
--- linux-modname/fs/dnotify.c	Sun Aug  4 02:33:23 2002
+++ linux-modinit/fs/dnotify.c	Mon Aug  5 19:55:47 2002
@@ -155,4 +155,4 @@
 	return 0;
 }
 
-module_init(dnotify_init)
+fs_initcall(dnotify_init);
diff -Nur linux-modname/fs/fcntl.c linux-modinit/fs/fcntl.c
--- linux-modname/fs/fcntl.c	Sun Aug  4 02:33:23 2002
+++ linux-modinit/fs/fcntl.c	Mon Aug  5 19:55:47 2002
@@ -568,4 +568,4 @@
 	return 0;
 }
 
-module_init(fasync_init)
+fs_initcall(fasync_init);
diff -Nur linux-modname/fs/locks.c linux-modinit/fs/locks.c
--- linux-modname/fs/locks.c	Sun Aug  4 02:33:23 2002
+++ linux-modinit/fs/locks.c	Mon Aug  5 19:55:47 2002
@@ -1890,4 +1890,4 @@
 	return 0;
 }
 
-module_init(filelock_init)
+fs_initcall(filelock_init);
diff -Nur linux-modname/include/linux/init.h linux-modinit/include/linux/init.h
--- linux-modname/include/linux/init.h	Sun Aug  4 02:33:23 2002
+++ linux-modinit/include/linux/init.h	Mon Aug  5 19:55:47 2002
@@ -66,7 +66,8 @@
 #define subsys_initcall(fn)		__define_initcall("4",fn)
 #define fs_initcall(fn)			__define_initcall("5",fn)
 #define device_initcall(fn)		__define_initcall("6",fn)
-#define late_initcall(fn)		__define_initcall("7",fn)
+#define module_initcall(fn)		__define_initcall("7",fn)
+#define late_initcall(fn)		__define_initcall("8",fn)
 
 #define __initcall(fn) device_initcall(fn)
 
@@ -106,6 +107,9 @@
 #define __FINIT		.previous
 #define __INITDATA	.section	".data.init","aw"
 
+#define ___concat(a,b)	a##b
+#define __concat(a,b)	___concat(a,b)
+
 /**
  * module_init() - driver initialization entry point
  * @x: function to be run at kernel boot time or module insertion
@@ -116,7 +120,10 @@
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
diff -Nur linux-modname/net/unix/af_unix.c linux-modinit/net/unix/af_unix.c
--- linux-modname/net/unix/af_unix.c	Sun Aug  4 02:33:23 2002
+++ linux-modinit/net/unix/af_unix.c	Mon Aug  5 19:55:47 2002
@@ -79,6 +79,8 @@
  *		  with BSD names.
  */
 
+#undef unix	/* KBUILD_MODNAME */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
diff -Nur linux-modname/scripts/build-module-initcalls linux-modinit/scripts/build-module-initcalls
--- linux-modname/scripts/build-module-initcalls	Thu Jan  1 01:00:00 1970
+++ linux-modinit/scripts/build-module-initcalls	Mon Aug  5 19:55:47 2002
@@ -0,0 +1,37 @@
+#! /bin/sh
+# Given a list of module objects, spit out C code to call all the inits
+# in order, based on dependencies.
+
+set -e
+
+# initialize files
+echo -n > .undefined.tmp
+echo -n > .defined.tmp
+
+# get all global defined/undefined symbols and sort them into the right files
+for file in $@; do
+  sed "s;^;$(dirname $file)/;" < $file
+done > .all.tmp
+xargs $NM -A < .all.tmp |
+awk -F "[ :	]*" \
+  '$2 == "U" { print $3 " " $1 | "sort -u > .undefined.tmp" }
+   $3 ~ /[TD]/ { print $4 " " $1 | "sort -u > .defined.tmp" }'
+
+# topological sort objects and append all independent objects
+join -o "1.2 2.2" .defined.tmp .undefined.tmp | sort -u | tsort > .sorted.tmp
+grep -v -f .sorted.tmp < .all.tmp > .other.tmp || true
+
+# extract init function calls and write them
+echo "/* Builtin module initcalls: autogenerated by $0 */"
+echo "#include <linux/init.h>"
+echo "static int __init init_builtin_modules(void)"
+echo "{"
+cat .sorted.tmp .other.tmp |
+xargs $OBJDUMP -t |
+awk '/F \.initcall\.module/ { print "  { extern int " $6 "(void);\n    " $6 "(); }" }'
+echo "  return 0;"
+echo "}"
+echo "module_initcall(init_builtin_modules);"
+
+# clean up
+rm .undefined.tmp .defined.tmp .all.tmp .sorted.tmp .other.tmp

--------------654CFCA0A5D397BE60D130DD--


