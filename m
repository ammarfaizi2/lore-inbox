Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751450AbWIUSsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWIUSsR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWIUSsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:48:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48859 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751450AbWIUSsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:48:15 -0400
Subject: [PATCH] Dependencies for headers_install, 'make
	headers_install_all'
From: David Woodhouse <dwmw2@infradead.org>
To: akpm@osdl.org, sam@ravnborg.org
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 21 Sep 2006 19:48:09 +0100
Message-Id: <1158864489.24527.611.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements (hopefully) sane dependencies for installing
headers, so we don't just remove the entire export directory and start
again each time. It should handle removing of files which are no longer
exported, and re-exporting anything which might have changed.

It also implements a 'make headers_install_all' which exports headers
for _all_ architectures, which is suitable for making a tarball of
kernel headers.

It will allow us to also use similar dependencies for _checking_ headers
only when they change, although that is not yet fully implemented.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/Makefile b/Makefile
index 33074e8..fa72626 100644
--- a/Makefile
+++ b/Makefile
@@ -892,18 +892,26 @@ # Kernel headers
 INSTALL_HDR_PATH=$(objtree)/usr
 export INSTALL_HDR_PATH
 
+HDRARCHES=$(filter-out generic,$(patsubst $(srctree)/include/asm-%/Kbuild,%,$(wildcard $(srctree)/include/asm-*/Kbuild)))
+
+PHONY += headers_install_all
+headers_install_all: include/linux/version.h
+	$(Q)unifdef -Ux /dev/null
+	$(Q)for arch in $(HDRARCHES); do \
+	 $(MAKE) ARCH=$$arch -rR -f $(srctree)/scripts/Makefile.headersinst obj=include BIASMDIR=-bi-$$arch __headersinst ;\
+	 done
+
 PHONY += headers_install
 headers_install: include/linux/version.h
 	@if [ ! -r include/asm-$(ARCH)/Kbuild ]; then \
 	  echo '*** Error: Headers not exportable for this architecture ($(ARCH))'; \
 	  exit 1 ; fi
 	$(Q)unifdef -Ux /dev/null
-	$(Q)rm -rf $(INSTALL_HDR_PATH)/include
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include __headersinst
 
 PHONY += headers_check
 headers_check: headers_install
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include HDRCHECK=1
+	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include __headerscheck
 
 # ---------------------------------------------------------------------------
 # Modules
b/include/asm-x86_64/Kbuild
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 12e1daf..f7ade05 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -23,30 +23,30 @@ HDRSED  := sed 	-e "s/ inline / __inline
 
 _dst := $(if $(dst),$(dst),$(obj))
 
-.PHONY: __headersinst
-__headersinst:
-
-
 ifeq (,$(patsubst include/asm/%,,$(obj)/))
 # For producing the generated stuff in include/asm for biarch builds, include
 # both sets of Kbuild files; we'll generate anything which is mentioned in
 # _either_ arch, and recurse into subdirectories which are mentioned in either
 # arch. Since some directories may exist in one but not the other, we must
-# use '-include'.
+# use $(wildcard...). 
 GENASM := 1
 archasm	   := $(subst include/asm,asm-$(ARCH),$(obj))
 altarchasm := $(subst include/asm,asm-$(ALTARCH),$(obj))
--include $(srctree)/include/$(archasm)/Kbuild
--include $(srctree)/include/$(altarchasm)/Kbuild
+KBUILDFILES := $(wildcard $(srctree)/include/$(archasm)/Kbuild $(srctree)/include/$(altarchasm)/Kbuild)
 else
-include $(srctree)/$(obj)/Kbuild
+KBUILDFILES := $(srctree)/$(obj)/Kbuild
 endif
 
-include scripts/Kbuild.include
+include $(KBUILDFILES)
+
+include scripts/Kbuild.include $(wildcard $(INSTALL_HDR_PATH)/$(_dst)/.check.*.h)
 
 # If this is include/asm-$(ARCH) and there's no $(ALTARCH), then
 # override $(_dst) so that we install to include/asm directly.
-ifeq ($(obj)$(ALTARCH),include/asm-$(ARCH))
+# Unless $(BIASMDIR) is set, in which case we're probably doing
+# a 'headers_install_all' build and we should keep the -$(ARCH)
+# in the directory name.
+ifeq ($(obj)$(ALTARCH),include/asm-$(ARCH)$(BIASMDIR))
      _dst := include/asm
 endif
 
@@ -56,6 +56,23 @@ subdir-y	:= $(patsubst %/,%,$(filter %/,
 header-y	:= $(filter-out %/, $(header-y))
 header-y	:= $(filter-out $(unifdef-y),$(header-y))
 
+# stamp files for header checks
+check-y		:= $(patsubst %,.check.%,$(header-y) $(unifdef-y) $(objhdr-y))
+
+# Work out what needs to be removed
+oldheaders	:= $(patsubst $(INSTALL_HDR_PATH)/$(_dst)/%,%,$(wildcard $(INSTALL_HDR_PATH)/$(_dst)/*.h))
+unwanted	:= $(filter-out $(header-y) $(unifdef-y) $(objhdr-y),$(oldheaders))
+
+oldcheckstamps	:= $(patsubst $(INSTALL_HDR_PATH)/$(_dst)/%,%,$(wildcard $(INSTALL_HDR_PATH)/$(_dst)/.check.*.h))
+unwanted	+= $(filter-out $(check-y),$(oldcheckstamps))
+
+# Prefix them all with full paths to $(INSTALL_HDR_PATH)
+header-y 	:= $(patsubst %,$(INSTALL_HDR_PATH)/$(_dst)/%,$(header-y))
+unifdef-y 	:= $(patsubst %,$(INSTALL_HDR_PATH)/$(_dst)/%,$(unifdef-y))
+objhdr-y 	:= $(patsubst %,$(INSTALL_HDR_PATH)/$(_dst)/%,$(objhdr-y))
+check-y 	:= $(patsubst %,$(INSTALL_HDR_PATH)/$(_dst)/%,$(check-y))
+
+
 ifdef ALTARCH
 ifeq ($(obj),include/asm-$(ARCH))
 altarch-y	:= altarch-dir
@@ -67,43 +84,47 @@ export ALTARCH
 export ARCHDEF
 export ALTARCHDEF
 
-quiet_cmd_o_hdr_install   = INSTALL $(_dst)/$@
-      cmd_o_hdr_install   = cp $(objtree)/$(obj)/$@ $(INSTALL_HDR_PATH)/$(_dst)
+quiet_cmd_o_hdr_install   = INSTALL $(patsubst $(INSTALL_HDR_PATH)/%,%,$@)
+      cmd_o_hdr_install   = cp $(patsubst $(INSTALL_HDR_PATH)/$(_dst)/%,$(objtree)/$(obj)/%,$@) \
+			    $(INSTALL_HDR_PATH)/$(_dst)
 
-quiet_cmd_headers_install = INSTALL $(_dst)/$@
-      cmd_headers_install = $(HDRSED) $(srctree)/$(obj)/$@		\
-			    > $(INSTALL_HDR_PATH)/$(_dst)/$@
+quiet_cmd_headers_install = INSTALL $(patsubst $(INSTALL_HDR_PATH)/%,%,$@)
+      cmd_headers_install = $(HDRSED) $(patsubst $(INSTALL_HDR_PATH)/$(_dst)/%,$(srctree)/$(obj)/%,$@)	\
+			    > $@
 
-quiet_cmd_unifdef	  = UNIFDEF $(_dst)/$@
-      cmd_unifdef	  = $(UNIFDEF) $(srctree)/$(obj)/$@ | $(HDRSED)	\
-                            > $(INSTALL_HDR_PATH)/$(_dst)/$@ || :
+quiet_cmd_unifdef	  = UNIFDEF $(patsubst $(INSTALL_HDR_PATH)/%,%,$@)
+      cmd_unifdef	  = $(UNIFDEF) $(patsubst $(INSTALL_HDR_PATH)/$(_dst)/%,$(srctree)/$(obj)/%,$@) \
+				   | $(HDRSED) > $@ || :
 
-quiet_cmd_check		  = CHECK   $(_dst)/$@
+quiet_cmd_check		  = CHECK   $(patsubst $(INSTALL_HDR_PATH)/$(_dst)/.check.%,$(_dst)/%,$@)
       cmd_check		  = $(srctree)/scripts/hdrcheck.sh		\
-                              $(INSTALL_HDR_PATH)/include		\
-			      $(INSTALL_HDR_PATH)/$(_dst)/$@
+                              $(INSTALL_HDR_PATH)/include $(subst /.check.,/,$@) $@
+
+quiet_cmd_remove	  = REMOVE  $(_dst)/$@
+      cmd_remove	  = rm -f $(INSTALL_HDR_PATH)/$(_dst)/$@
 
-quiet_cmd_mkdir		  = MKDIR   $@
-      cmd_mkdir		  = mkdir -p $(INSTALL_HDR_PATH)/$@
+quiet_cmd_mkdir		  = MKDIR   $(patsubst $(INSTALL_HDR_PATH)/%,%,$@)
+      cmd_mkdir		  = mkdir -p $@
 
-quiet_cmd_gen		  = GEN     $(_dst)/$@
+quiet_cmd_gen		  = GEN     $(patsubst $(INSTALL_HDR_PATH)/%,%,$@)
       cmd_gen		  = \
-STUBDEF=__ASM_STUB_`echo $@ | tr a-z. A-Z_`;				\
+FNAME=$(patsubst $(INSTALL_HDR_PATH)/$(_dst)/%,%,$@)			\
+STUBDEF=__ASM_STUB_`echo $$FNAME | tr a-z. A-Z_`;			\
 (echo "/* File autogenerated by 'make headers_install' */" ;		\
 echo "\#ifndef $$STUBDEF" ;						\
 echo "\#define $$STUBDEF" ;						\
 echo "\# if $(ARCHDEF)" ;						\
-if [ -r $(INSTALL_HDR_PATH)/include/$(archasm)/$@ ]; then		\
-	echo "\#  include <$(archasm)/$@>" ;				\
+if [ -r $(subst /$(_dst)/,/include/$(archasm)/,$@) ]; then		\
+	echo "\#  include <$(archasm)/$$FNAME>" ;			\
 else									\
-	echo "\#  error $(archasm)/$@ does not exist in"		\
+	echo "\#  error $(archasm)/$$FNAME does not exist in"		\
 			"the $(ARCH) architecture" ;			\
 fi ;									\
 echo "\# elif $(ALTARCHDEF)" ;						\
-if [ -r $(INSTALL_HDR_PATH)/include/$(altarchasm)/$@ ]; then		\
-	echo "\#  include <$(altarchasm)/$@>" ;				\
+if [ -r $(subst /$(_dst)/,/include/$(altarchasm)/,$@) ]; then		\
+	echo "\#  include <$(altarchasm)/$$FNAME>" ;			\
 else									\
-	echo "\#  error $(altarchasm)/$@ does not exist in"		\
+	echo "\#  error $(altarchasm)/$$FNAME does not exist in"	\
 			"the $(ALTARCH) architecture" ;			\
 fi ;									\
 echo "\# else" ;							\
@@ -111,39 +132,45 @@ echo "\#  warning This machine appears t
 		 "neither $(ARCH) nor $(ALTARCH)." ;			\
 echo "\# endif" ;							\
 echo "\#endif /* $$STUBDEF */" ;					\
-) > $(INSTALL_HDR_PATH)/$(_dst)/$@
+) > $@
 
+.PHONY: __headersinst __headerscheck
 __headersinst: $(subdir-y) $(header-y) $(unifdef-y) $(altarch-y) $(objhdr-y)
+	@true
 
-.PHONY: $(header-y) $(unifdef-y) $(subdir-y)
+__headerscheck: $(subdir-y) $(check-y)
+	@true
 
-ifdef HDRCHECK
-# Rules for checking headers
-$(objhdr-y) $(header-y) $(unifdef-y):
+# Leave $(check-y) as .PHONY for now till we sort out proper deps for it	
+#.PHONY: $(check-y)
+$(check-y) : $(INSTALL_HDR_PATH)/$(_dst)/.check.%.h : $(INSTALL_HDR_PATH)/$(_dst)/%.h 
 	$(call cmd,check)
-else
+
 # Rules for installing headers
 
-$(objhdr-y) $(subdir-y) $(header-y) $(unifdef-y): $(_dst)
+$(objhdr-y) $(subdir-y) $(header-y) $(unifdef-y): | $(INSTALL_HDR_PATH)/$(_dst) $(unwanted)
 
-.PHONY: $(_dst)
-$(_dst):
+$(INSTALL_HDR_PATH)/$(_dst):
 	$(call cmd,mkdir)
 
+.PHONY: $(unwanted)
+$(unwanted):
+	$(call cmd,remove)
+
 ifdef GENASM
-$(objhdr-y) $(header-y) $(unifdef-y):
+$(objhdr-y) $(header-y) $(unifdef-y): $(KBUILDFILES)
 	$(call cmd,gen)
 
 else
-$(objhdr-y):
+$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)
 	$(call cmd,o_hdr_install)
 
-$(header-y):
+$(header-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)
 	$(call cmd,headers_install)
 
-$(unifdef-y):
+$(unifdef-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)
 	$(call cmd,unifdef)
-endif
+
 endif
 
 hdrinst := -rR -f $(srctree)/scripts/Makefile.headersinst obj
@@ -152,9 +179,10 @@ hdrinst := -rR -f $(srctree)/scripts/Mak
 # All the files in the normal arch dir must be created first, since we test
 # for their existence.
 altarch-dir: $(subdir-y) $(header-y) $(unifdef-y) $(objhdr-y)
-	$(Q)$(MAKE) $(hdrinst)=include/asm-$(ALTARCH) dst=include/asm-$(ALTARCH)
-	$(Q)$(MAKE) $(hdrinst)=include/asm dst=include/asm
+	$(Q)$(MAKE) $(hdrinst)=include/asm-$(ALTARCH) dst=include/asm-$(ALTARCH) $(MAKECMDGOALS)
+	$(Q)$(MAKE) $(hdrinst)=include/asm dst=include/asm$(BIASMDIR) $(MAKECMDGOALS)
 
 # Recursion
+.PHONY: $(subdir-y)
 $(subdir-y):
-	$(Q)$(MAKE) $(hdrinst)=$(obj)/$@ dst=$(_dst)/$@ rel=../$(rel)
+	$(Q)$(MAKE) $(hdrinst)=$(obj)/$@ dst=$(_dst)/$@ rel=../$(rel) $(MAKECMDGOALS)
diff --git a/scripts/hdrcheck.sh b/scripts/hdrcheck.sh
index b5ca35a..3159858 100755
--- a/scripts/hdrcheck.sh
+++ b/scripts/hdrcheck.sh
@@ -6,3 +6,5 @@ for FILE in `grep '^[ \t]*#[ \t]*include
 	exit 1
     fi
 done
+# FIXME: List dependencies into $3
+touch $3

-- 
dwmw2

