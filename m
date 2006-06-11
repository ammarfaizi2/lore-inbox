Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWFKMKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWFKMKU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 08:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWFKMKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 08:10:20 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:13458 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751237AbWFKMKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 08:10:20 -0400
Date: Sun, 11 Jun 2006 14:10:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: David Woodhouse <dwmw2@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] header install: cosmetic cleanups to kbuild infrastructure
Message-ID: <20060611121005.GA1342@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A set of cosmetic cleanups for the header install kbuild infrastructure:

o Use consistent style for PHONY target in top-lvel Makefile
o Avoid '@', we want $(Q) so command is visible with make V=1
o Makefile.headerinst now fits within my 80 coloumn window
o Only accept Kbuild as input filename. This is new stuff so no
  need to be backward compatible here.
o A small comment in the top of the Makefile.headerinst file to
  explain variable usage. More is needed.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

This is on top of hdrinstall-2.6.git as of yesterday.

	Sam

diff --git a/Makefile b/Makefile
index 8d92d78..0d372a6 100644
--- a/Makefile
+++ b/Makefile
@@ -862,13 +862,13 @@ # Kernel headers
 INSTALL_HDR_PATH=$(MODLIB)/abi
 export INSTALL_HDR_PATH
 
-.PHONY: headers_install
-headers_install: include/linux/version.h
-	@unifdef -Ux /dev/null
-	@rm -rf $(INSTALL_HDR_PATH)/include
+PHONY += headers_install
+headers_install: prepare
+	$(Q)unifdef -Ux /dev/null
+	$(Q)rm -rf $(INSTALL_HDR_PATH)/include
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include
 
-.PHONY: headers_check
+PHONY += headers_check
 headers_check: headers_install
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include HDRCHECK=1
 
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index e653334..4e1f973 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -1,5 +1,10 @@
 # ==========================================================================
 # Installing headers
+#
+# header-y files will be installed verbatim
+# unifdef-y are the files where unifdef will be run before installing files
+# objhdr-y are generated files that will be installed verbatim
+#
 # ==========================================================================
 
 UNIFDEF := unifdef -U__KERNEL__
@@ -19,10 +24,10 @@ # use '-include'.
 GENASM := 1
 archasm	   := $(subst include/asm,asm-$(ARCH),$(obj))
 altarchasm := $(subst include/asm,asm-$(ALTARCH),$(obj))
--include $(if $(wildcard $(srctree)/include/$(archasm)/Kbuild), include/$(archasm)/Kbuild, include/$(archasm)/Makefile)
--include $(if $(wildcard $(srctree)/include/$(altarchasm)/Kbuild), include/$(altarchasm)/Kbuild, include/$(altarchasm)/Makefile)
+-include $(srctree)/include/$(archasm)/Kbuild
+-include $(srctree)/include/$(altarchasm)/Kbuild
 else
-include $(if $(wildcard $(srctree)/$(obj)/Kbuild), $(obj)/Kbuild, $(obj)/Makefile)
+include $(srctree)/$(obj)/Kbuild
 endif
 
 include scripts/Kbuild.include
@@ -45,47 +50,55 @@ altarch-y	:= altarch-dir
 endif
 endif
 
+# Make the definitions visible for recursive make invocations
 export ALTARCH
 export ARCHDEF
 export ALTARCHDEF
 
-quiet_cmd_o_hdr_install   = INSTALL_O $(_dst)/$@
+quiet_cmd_o_hdr_install   = INSTALL $(_dst)/$@
       cmd_o_hdr_install   = cp $(objtree)/$(obj)/$@ $(INSTALL_HDR_PATH)/$(_dst)
 
 quiet_cmd_headers_install = INSTALL $(_dst)/$@
       cmd_headers_install = cp $(srctree)/$(obj)/$@ $(INSTALL_HDR_PATH)/$(_dst)
 
 quiet_cmd_unifdef	  = UNIFDEF $(_dst)/$@
-      cmd_unifdef	  = $(UNIFDEF) $(srctree)/$(obj)/$@ > $(INSTALL_HDR_PATH)/$(_dst)/$@ || :
+      cmd_unifdef	  = $(UNIFDEF) $(srctree)/$(obj)/$@          \
+                            > $(INSTALL_HDR_PATH)/$(_dst)/$@ || :
 
-quiet_cmd_check		  = CHECK $(_dst)/$@
-      cmd_check		  = $(srctree)/scripts/hdrcheck.sh $(INSTALL_HDR_PATH)/include $(INSTALL_HDR_PATH)/$(_dst)/$@
+quiet_cmd_check		  = CHECK   $(_dst)/$@
+      cmd_check		  = $(srctree)/scripts/hdrcheck.sh           \
+                              $(INSTALL_HDR_PATH)/include            \
+			      $(INSTALL_HDR_PATH)/$(_dst)/$@
 
-quiet_cmd_mkdir		  = MKDIR $@
+quiet_cmd_mkdir		  = MKDIR   $@
       cmd_mkdir		  = mkdir -p $(INSTALL_HDR_PATH)/$@
 
-quiet_cmd_gen		  = GEN $(_dst)/$@
-      cmd_gen		  = STUBDEF=__ASM_STUB_`echo $@ | tr a-z. A-Z_` ;					\
-			    ( echo "/* File autogenerated by 'make headers_install' */"	;			\
-			    echo "\#ifndef $$STUBDEF" ;								\
-			    echo "\#define $$STUBDEF" ;								\
-			    echo "\# if $(ARCHDEF)" ;								\
-			    if [ -r $(srctree)/include/$(archasm)/$@ ]; then					\
-			       echo "\#  include <$(archasm)/$@>" ;						\
-			    else										\
-			       echo "\#  error $(archasm)/$@ does not exist in the $(ARCH) architecture" ;	\
-			    fi ;										\
-			    echo "\# elif $(ALTARCHDEF)" ;							\
-			    if [ -r $(srctree)/include/$(altarchasm)/$@ ]; then					\
-			       echo "\#  include <$(altarchasm)/$@>" ;						\
-			    else										\
-			       echo "\#  error $(altarchasm)/$@ does not exist in the $(ALTARCH) architecture" ;	\
-			    fi ;										\
-			    echo "\# else" ;									\
-			    echo "\#  warning This machine appears to be neither $(ARCH) nor $(ALTARCH)." ;	\
-			    echo "\# endif" ;									\
-			    echo "\#endif /* $$STUBDEF */" ;							\
-			    	 ) > $(INSTALL_HDR_PATH)/$(_dst)/$@
+quiet_cmd_gen		  = GEN     $(_dst)/$@
+      cmd_gen		  = \
+STUBDEF=__ASM_STUB_`echo $@ | tr a-z. A-Z_`;				\
+(echo "/* File autogenerated by 'make headers_install' */" ;		\
+echo "\#ifndef $$STUBDEF" ;						\
+echo "\#define $$STUBDEF" ;						\
+echo "\# if $(ARCHDEF)" ;						\
+if [ -r $(srctree)/include/$(archasm)/$@ ]; then			\
+	echo "\#  include <$(archasm)/$@>" ;				\
+else									\
+	echo "\#  error $(archasm)/$@ does not exist in"		\
+			"the $(ARCH) architecture" ;			\
+fi ;									\
+echo "\# elif $(ALTARCHDEF)" ;						\
+if [ -r $(srctree)/include/$(altarchasm)/$@ ]; then			\
+	echo "\#  include <$(altarchasm)/$@>" ;				\
+else									\
+	echo "\#  error $(altarchasm)/$@ does not exist in"		\
+			"the $(ALTARCH) architecture" ;			\
+fi ;									\
+echo "\# else" ;							\
+echo "\#  warning This machine appears to be"				\
+		 "neither $(ARCH) nor $(ALTARCH)." ;			\
+echo "\# endif" ;							\
+echo "\#endif /* $$STUBDEF */" ;					\
+) > $(INSTALL_HDR_PATH)/$(_dst)/$@
 
 __headersinst: $(subdir-y) $(header-y) $(unifdef-y) $(altarch-y) $(objhdr-y)
 
@@ -120,11 +133,13 @@ else
 endif
 endif
 
+hdrinst := -rR -f $(srctree)/scripts/Makefile.headersinst obj
+
 .PHONY: altarch-dir
 altarch-dir:
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include/asm-$(ALTARCH) dst=include/asm-$(ALTARCH)
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include/asm dst=include/asm
+	$(Q)$(MAKE) $(hdrinst)=include/asm-$(ALTARCH) dst=include/asm-$(ALTARCH)
+	$(Q)$(MAKE) $(hdrinst)=include/asm dst=include/asm
 
 # Recursion
 $(subdir-y):
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=$(obj)/$@ dst=$(_dst)/$@ rel=../$(rel)
+	$(Q)$(MAKE) $(hdrinst)=$(obj)/$@ dst=$(_dst)/$@ rel=../$(rel)

