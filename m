Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSFXBXN>; Sun, 23 Jun 2002 21:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSFXBXM>; Sun, 23 Jun 2002 21:23:12 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:29824 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S317214AbSFXBXI>; Sun, 23 Jun 2002 21:23:08 -0400
Date: Sun, 23 Jun 2002 20:22:51 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild fixes and more
In-Reply-To: <20020624000500.A11471@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0206232009270.24916-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jun 2002, Sam Ravnborg wrote:

> 1) Tried "make clean"
> In the end it gave the following result:
> make -C arch/i386/lib clean
> Cleaning up
> /home/sam/src/linux/kernel/bk/local/Rules.make:134: warning: overriding commands for target `clean'
> Makefile:168: warning: ignoring old commands for target `clean'
> 
> make clean is too verbose now, especially taken KBUILD_VERBOSE= in consideration.

Yeah, that's the "rough edges" I was refering to.

> 2) While doing a clean build I spotted:
>   LD     drivers/char/pcmcia/built-in.o
>   LD     drivers/char/built-in.o
> rm defkeymap.c
>   CC     drivers/ide/device.o
>   CC     drivers/ide/ide-taskfile.o
> This rm looks wrong to me.
> Btw. I did not use -j and on UP.

That's not so nice, it's caused by make considering defkeymap.c an 
intermediate file, and thus removing it when it's no longer necessary. 
That's not so good, though, since it causes unnecessary rebuilds. Fixed by
adding explicit

	$(obj)/defkeymap.o: $(obj)/defkeymap.c

rules.

> 3) ChangeSet@1.490.1.62
> Within Rules.make in section "Commands useful for boot image"
> In the lines
> #	target: source(s) FORCE
> -#		$(if_changed,ld/objcopy)
> +#              $(if_changed,ld/objcopy/gzip)

Okay ;)

> 4)  Clean up arch/i386
> I miss $(obj) in front of tools/build
> zImage: bootsect setup vmlinux.bin tools/build
> -	tools/build bootsect setup vmlinux.bin $(ROOT_DEV) > $@
> +	$(obj)/tools/build bootsect setup vmlinux.bin $(ROOT_DEV) > $@
> 
> 
> bzImage: bbootsect bsetup bvmlinux.bin tools/build
> -	tools/build -b bbootsect bsetup bvmlinux.bin $(ROOT_DEV) > $@
> +	$(obj)/tools/build -b bbootsect bsetup bvmlinux.bin $(ROOT_DEV) > $@
> 
> Reading through the 4 patches I miss $(obj) in many places.
> In generally all temporary and final target needs $(obj)

Yes, I just didn't add those, yet.

> 5) jobserver unavailable

> I've started too see this when I execute "make -j2":
> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
> Dunno if this is my local setup??

No, though I think this one has been there forever, it just doesn't 
surface when not using "make -jX bzImage". Added a + as suggested ;)

Patch with these various improvements is appended. BTW, this whole series
will need to be redone cleanly before it's ready to be submitted to Linus,
so if you're using bk, throw away the clone of my tree before pulling from
Linus' tree again.

--Kai

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.610   -> 1.611  
#	drivers/acorn/char/Makefile	1.7     -> 1.8    
#	            Makefile	1.273   -> 1.274  
#	 drivers/tc/Makefile	1.5     -> 1.6    
#	  arch/i386/Makefile	1.15    -> 1.16   
#	          Rules.make	1.69    -> 1.70   
#	drivers/char/Makefile	1.25    -> 1.26   
#	Documentation/DocBook/Makefile	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/23	kai@tp1.ruhr-uni-bochum.de	1.611
# kbuild: assorted small fixes / cosmetics
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Sun Jun 23 20:19:30 2002
+++ b/Documentation/DocBook/Makefile	Sun Jun 23 20:19:30 2002
@@ -26,7 +26,7 @@
 $(BOOKS): $(TOPDIR)/scripts/docgen $(TOPDIR)/scripts/gen-all-syms \
 	  $(TOPDIR)/scripts/kernel-doc $(TOPDIR)/scripts/docproc
 
-.PHONY:	sgmldocs psdocs pdfdocs htmldocs clean mrproper
+.PHONY:	sgmldocs psdocs pdfdocs htmldocs mrproper
 
 sgmldocs: $(BOOKS)
 
@@ -164,22 +164,6 @@
 LOG	:=	$(patsubst %.sgml, %.log, $(BOOKS))
 OUT	:=	$(patsubst %.sgml, %.out, $(BOOKS))
 
-clean:
-	@echo 'Cleaning up (DocBook)'
-	@rm -f core *~
-	@rm -f $(BOOKS)
-	@rm -f $(DVI) $(AUX) $(TEX) $(LOG) $(OUT)
-	@rm -f $(PNG-parportbook) $(EPS-parportbook)
-	@rm -f $(C-procfs-example)
-
-mrproper:
-	@echo 'Making mrproper (DocBook)'
-	@rm -f $(PS) $(PDF)
-	@rm -f -r $(HTML)
-	@rm -f .depend
-	@rm -f $(TOPDIR)/scripts/mkdep-docbook
-	@rm -rf DBTOHTML_OUTPUT*
-
 %.ps : %.sgml
 	@(which db2ps > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
@@ -200,12 +184,9 @@
 	db2html $<
 	if [ ! -z "$(PNG-$@)" ]; then cp $(PNG-$@) $@; fi
 
-#
-# we could have our own dependency generator
-#
-#
-# .depend: $(TOPDIR)/scripts/mkdep-docbook
-#	$(TOPDIR)/scripts/mkdep-docbook $(wildcard *.tmpl) > .depend
+clean-files := $(BOOKS) $(DVI) $(AUX) $(TEX) $(LOG) $(OUT) \
+	       $(PNG-parportbook) $(EPS-parportbook) $(C-procfs-example) \
+	       $(PS) $(PDF) $(HTML) DBTOHTML_OUTPUT*
 
 include $(TOPDIR)/Rules.make
 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Sun Jun 23 20:19:30 2002
+++ b/Makefile	Sun Jun 23 20:19:30 2002
@@ -250,7 +250,7 @@
 
 vmlinux-objs := $(HEAD) $(INIT) $(CORE_FILES) $(LIBS) $(DRIVERS) $(NETWORKS)
 
-quiet_cmd_link_vmlinux = LD     $@
+quiet_cmd_link_vmlinux = LD      $@
 cmd_link_vmlinux = $(LD) $(LDFLAGS) $(LDFLAGS_$(@F)) $(HEAD) $(INIT) \
 		--start-group \
 		$(CORE_FILES) \
@@ -611,35 +611,47 @@
 
 include arch/$(ARCH)/Makefile
 
-$(addprefix _clean_,$(SUBDIRS)):
-	make -C $(patsubst _clean_%,%,$@) clean
+CLEAN_SUBDIRS := $(SUBDIRS) Documentation/DocBook
 
-clean: $(addprefix _clean_,$(SUBDIRS))
-	@echo 'Cleaning up'
-	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
+$(addprefix _clean_,$(CLEAN_SUBDIRS)):
+	@make -C $(patsubst _clean_%,%,$@) clean
+
+quiet_cmd_clean = CLEAN (TOPDIR)
+define cmd_clean 
+	find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name \*.[oas] -o -name core -o -name .\*.cmd -o \
 		-name .\*.tmp -o -name .\*.d \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
-	@rm -f $(CLEAN_FILES)
-	@$(MAKE) -C Documentation/DocBook clean
+	rm -f $(CLEAN_FILES)
+endef
 
-mrproper: clean archmrproper
-	@echo 'Making mrproper'
-	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
+clean: $(addprefix _clean_,$(CLEAN_SUBDIRS))
+	$(call cmd,clean)
+
+quiet_cmd_mrproper = MRPROPER
+define cmd_mrproper
+	find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -name .depend -o -name .\*.cmd \) \
 		-type f -print | xargs rm -f
-	@rm -f $(MRPROPER_FILES)
-	@rm -rf $(MRPROPER_DIRS)
-	@$(MAKE) -C Documentation/DocBook mrproper
+	rm -f $(MRPROPER_FILES)
+	rm -rf $(MRPROPER_DIRS)
+endef
 
-distclean: mrproper
-	@echo 'Making distclean'
-	@find . -name SCCS -prune -o -name BitKeeper -prune -o \
+mrproper: clean archmrproper
+	$(call cmd,mrproper)
+
+quiet_cmd_distclean = DISTCLEAN
+define cmd_distclean
+	find . -name SCCS -prune -o -name BitKeeper -prune -o \
 		\( -not -type d \) -and \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
 	 	-o -name '.*.rej' -o -name '.SUMS' -o -size 0 \) -type f \
 		-print | xargs rm -f
+endef
+
+distclean: mrproper
+	$(call cmd,distclean)
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------
diff -Nru a/Rules.make b/Rules.make
--- a/Rules.make	Sun Jun 23 20:19:30 2002
+++ b/Rules.make	Sun Jun 23 20:19:30 2002
@@ -130,11 +130,13 @@
 
 .PHONY: clean
 
+quiet_cmd_clean = $(if $(strip $(clean-files) $(host-progs)),CLEAN  $(RELDIR))
+cmd_clean = rm -f $(addprefix $(obj)/,$(clean-files) $(host-progs))
+
+
 clean: $(subdir-ymn)
-	$(if $(strip $(clean-files) $(host-progs)), \
-	     rm -f $(addprefix $(obj)/,$(clean-files) $(host-progs)))
+	$(call cmd,clean)
 	$(clean-rule)
-	@/bin/true
 
 else
 ifeq ($(MAKECMDGOALS),fastdep)
@@ -186,7 +188,7 @@
 # files (fix-dep filters them), so touch modversions.h if any of the .ver
 # files changes
 
-quiet_cmd_cc_ver_c = MKVER  include/linux/modules/$(RELDIR)/$*.ver
+quiet_cmd_cc_ver_c = MKVER   include/linux/modules/$(RELDIR)/$*.ver
 cmd_cc_ver_c = $(CPP) $(c_flags) $< | $(GENKSYMS) $(genksyms_smp_prefix) \
 		 -k $(VERSION).$(PATCHLEVEL).$(SUBLEVEL) > $@.tmp
 
@@ -283,26 +285,26 @@
 	  -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) \
 	  $(export_flags) 
 
-quiet_cmd_cc_s_c = CC     $(echo_target)
+quiet_cmd_cc_s_c = CC      $(echo_target)
 cmd_cc_s_c       = $(CC) $(c_flags) -S -o $@ $< 
 
 %.s: %.c FORCE
 	$(call if_changed_dep,cc_s_c)
 
-quiet_cmd_cc_i_c = CPP    $(echo_target)
+quiet_cmd_cc_i_c = CPP     $(echo_target)
 cmd_cc_i_c       = $(CPP) $(c_flags)   -o $@ $<
 
 %.i: %.c FORCE
 	$(call if_changed_dep,cc_i_c)
 
-quiet_cmd_cc_o_c = CC     $(echo_target)
+quiet_cmd_cc_o_c = CC      $(echo_target)
 cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
 
 %.o: %.c FORCE
 	$(call if_changed_dep,cc_o_c)
 
-quiet_cmd_cc_lst_c = '  Generating $(echo_target)'
-cmd_cc_lst_c     = $(CC) $(c_flags) -g -c -o $*.o $< && $(TOPDIR)/scripts/makelst $*.o $(TOPDIR)/System.map $(OBJDUMP) > $@
+quiet_cmd_cc_lst_c = MKLST   $(echo_target)
+cmd_cc_lst_c       = $(CC) $(c_flags) -g -c -o $*.o $< && $(TOPDIR)/scripts/makelst $*.o $(TOPDIR)/System.map $(OBJDUMP) > $@
 
 %.lst: %.c FORCE
 	$(call if_changed_dep,cc_lst_c)
@@ -318,13 +320,13 @@
 a_flags = -Wp,-MD,$(depfile) $(AFLAGS) $(NOSTDINC_FLAGS) \
 	  $(modkern_aflags) $(EXTRA_AFLAGS) $(AFLAGS_$(*F).o)
 
-quiet_cmd_as_s_S = CPP    $(echo_target)
+quiet_cmd_as_s_S = CPP     $(echo_target)
 cmd_as_s_S       = $(CPP) $(a_flags)   -o $@ $< 
 
 %.s: %.S FORCE
 	$(call if_changed_dep,as_s_S)
 
-quiet_cmd_as_o_S = AS     $(echo_target)
+quiet_cmd_as_o_S = AS      $(echo_target)
 cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
 
 %.o: %.S FORCE
@@ -342,7 +344,7 @@
 # Rule to compile a set of .o files into one .o file
 #
 ifdef O_TARGET
-quiet_cmd_link_o_target = LD     $(echo_target)
+quiet_cmd_link_o_target = LD      $(echo_target)
 # If the list of objects to link is empty, just create an empty O_TARGET
 cmd_link_o_target = $(if $(strip $(obj-y)),\
 		      $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(obj-y), $^),\
@@ -358,7 +360,7 @@
 # Rule to compile a set of .o files into one .a file
 #
 ifdef L_TARGET
-quiet_cmd_link_l_target = AR     $(echo_target)
+quiet_cmd_link_l_target = AR      $(echo_target)
 cmd_link_l_target = rm -f $@; $(AR) $(EXTRA_ARFLAGS) rcs $@ $(obj-y)
 
 $(L_TARGET): $(obj-y) FORCE
@@ -371,7 +373,7 @@
 # Rule to link composite objects
 #
 
-quiet_cmd_link_multi = LD     $(echo_target)
+quiet_cmd_link_multi = LD      $(echo_target)
 cmd_link_multi = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $($(basename $@)-objs),$^)
 
 # We would rather have a list of rules like
@@ -393,7 +395,7 @@
 host-progs-multi      := $(foreach m,$(host-progs),$(if $($(m)-objs),$(m)))
 host-progs-multi-objs := $(foreach m,$(host-progs-multi),$($(m)-objs))
 
-quiet_cmd_host_cc__c  = HOSTCC $(echo_target)
+quiet_cmd_host_cc__c  = HOSTCC  $(echo_target)
 cmd_host_cc__c        = $(HOSTCC) -Wp,-MD,$(depfile) \
 			$(HOSTCFLAGS) $(HOST_EXTRACFLAGS) \
 			$(HOST_LOADLIBES) -o $@ $<
@@ -401,14 +403,14 @@
 $(host-progs-single): %: %.c FORCE
 	$(call if_changed_dep,host_cc__c)
 
-quiet_cmd_host_cc_o_c = HOSTCC $(echo_target)
+quiet_cmd_host_cc_o_c = HOSTCC  $(echo_target)
 cmd_host_cc_o_c       = $(HOSTCC) -Wp,-MD,$(depfile) \
 			$(HOSTCFLAGS) $(HOST_EXTRACFLAGS) -c -o $@ $<
 
 $(host-progs-multi-objs): %.o: %.c FORCE
 	$(call if_changed_dep,host_cc_o_c)
 
-quiet_cmd_host_cc__o  = HOSTLD $(echo_target)
+quiet_cmd_host_cc__o  = HOSTLD  $(echo_target)
 cmd_host_cc__o        = $(HOSTCC) $(HOSTLDFLAGS) -o $@ $($@-objs) \
 			$(HOST_LOADLIBES)
 
@@ -424,9 +426,11 @@
 # Shipped files
 # ===========================================================================
 
+quiet_cmd_shipped = SHIPPED $(echo_target)
+cmd_shipped = cp $< $@
+
 %:: %_shipped
-	@echo '  CP     $(echo_target)'
-	@cp $< $@
+	$(call cmd,shipped)
 
 # Commands useful for building a boot image
 # ===========================================================================
@@ -434,7 +438,7 @@
 #	Use as following:
 #
 #	target: source(s) FORCE
-#		$(if_changed,ld/objcopy)
+#		$(if_changed,ld/objcopy/gzip)
 #
 #	and add target to EXTRA_TARGETS so that we know we have to
 #	read in the saved command line
@@ -442,20 +446,20 @@
 # Linking
 # ---------------------------------------------------------------------------
 
-quiet_cmd_ld = LD     $(echo_target)
+quiet_cmd_ld = LD      $(echo_target)
 cmd_ld = $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) $(LDFLAGS_$@) \
 	       $(filter-out FORCE,$^) -o $@ 
 
 # Objcopy
 # ---------------------------------------------------------------------------
 
-quiet_cmd_objcopy = OBJCPY $(echo_target)
+quiet_cmd_objcopy = OBJCOPY $(echo_target)
 cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $< $@
 
 # Gzip
 # ---------------------------------------------------------------------------
 
-quiet_cmd_gzip = GZIP   $(echo_target)
+quiet_cmd_gzip = GZIP    $(echo_target)
 cmd_gzip = gzip -f -9 < $< > $@
 
 # ===========================================================================
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Sun Jun 23 20:19:30 2002
+++ b/arch/i386/Makefile	Sun Jun 23 20:19:30 2002
@@ -102,7 +102,7 @@
 DRIVERS	+= arch/i386/pci/pci.o
 endif
 
-MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
+MAKEBOOT = +$(MAKE) -C arch/$(ARCH)/boot
 
 vmlinux: arch/i386/vmlinux.lds
 
diff -Nru a/drivers/acorn/char/Makefile b/drivers/acorn/char/Makefile
--- a/drivers/acorn/char/Makefile	Sun Jun 23 20:19:30 2002
+++ b/drivers/acorn/char/Makefile	Sun Jun 23 20:19:30 2002
@@ -20,6 +20,8 @@
 
 include $(TOPDIR)/Rules.make
 
+$(obj)/defkeymap-acorn.o: $(obj)/defkeymap-acorn.c
+
 # Uncomment if you're changing the keymap and have an appropriate
 # loadkeys version for the map. By default, we'll use the shipped
 # versions.
@@ -28,6 +30,6 @@
 ifdef GENERATE_KEYMAP
 
 $(obj)/defkeymap-acorn.c: $(obj)/%.c: $(src)/%.map
-	$(LOADKEYS) --mktable $< > $@
+	loadkeys --mktable $< > $@
 
 endif
diff -Nru a/drivers/char/Makefile b/drivers/char/Makefile
--- a/drivers/char/Makefile	Sun Jun 23 20:19:30 2002
+++ b/drivers/char/Makefile	Sun Jun 23 20:19:30 2002
@@ -220,6 +220,10 @@
 $(obj)/consolemap_deftbl.c: $(src)/$(FONTMAPFILE) $(obj)/conmakehash
 	$(obj)/conmakehash $< > $@
 
+$(obj)/defkeymap.o:  $(obj)/defkeymap.c
+
+$(obj)/qtronixmap.o: $(obj)/qtronixmap.c
+
 # Uncomment if you're changing the keymap and have an appropriate
 # loadkeys version for the map. By default, we'll use the shipped
 # versions.
@@ -228,7 +232,7 @@
 ifdef GENERATE_KEYMAP
 
 $(obj)/defkeymap.c $(obj)/qtronixmap.c: $(obj)/%.c: $(src)/%.map
-	$(LOADKEYS) --mktable $< > $@.tmp
+	loadkeys --mktable $< > $@.tmp
 	sed -e 's/^static *//' $@.tmp > $@
 	rm $@.tmp
 
diff -Nru a/drivers/tc/Makefile b/drivers/tc/Makefile
--- a/drivers/tc/Makefile	Sun Jun 23 20:19:30 2002
+++ b/drivers/tc/Makefile	Sun Jun 23 20:19:30 2002
@@ -15,6 +15,8 @@
 
 include $(TOPDIR)/Rules.make
 
+$(obj)/lk201-map.o: $(obj)/lk201-map.c
+
 # Uncomment if you're changing the keymap and have an appropriate
 # loadkeys version for the map. By default, we'll use the shipped
 # versions.
@@ -23,6 +25,6 @@
 ifdef GENERATE_KEYMAP
 
 $(obj)/lk201-map.c: $(obj)/%.c: $(src)/%.map
-	$(LOADKEYS) --mktable $< > $@
+	loadkeys --mktable $< > $@
 
 endif

