Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSGXV0F>; Wed, 24 Jul 2002 17:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317636AbSGXV0F>; Wed, 24 Jul 2002 17:26:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:34574 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317633AbSGXVZw>;
	Wed, 24 Jul 2002 17:25:52 -0400
Date: Wed, 24 Jul 2002 23:36:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docbook: Makefile cleanup [6/9]
Message-ID: <20020724233613.E12782@mars.ravnborg.org>
References: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724232021.A12622@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jul 24, 2002 at 11:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.436   -> 1.437  
#	Documentation/DocBook/Makefile	1.28    -> 1.29   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.437
# [PATCH] docbook: Makefile cleanup [6/9]
# Massive cleanup of makefile.
# Comments added as well.
# Enabled by the new functionality provided by docproc
# When generating HTML locate a new file in DocBook dir that points to
# the book in question.
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Wed Jul 24 22:59:49 2002
+++ b/Documentation/DocBook/Makefile	Wed Jul 24 22:59:49 2002
@@ -1,170 +1,161 @@
-BOOKS	:= wanbook.sgml z8530book.sgml mcabook.sgml videobook.sgml \
-	   kernel-api.sgml parportbook.sgml kernel-hacking.sgml \
-	   kernel-locking.sgml via-audio.sgml mousedrivers.sgml sis900.sgml \
-	   deviceiobook.sgml procfs-guide.sgml tulip-user.sgml \
-	   writing_usb_driver.sgml scsidrivers.sgml
-
-PS	:=	$(patsubst %.sgml, %.ps, $(BOOKS))
-PDF	:=	$(patsubst %.sgml, %.pdf, $(BOOKS))
-HTML    :=      $(patsubst %.sgml, %, $(BOOKS))
-IMG-parportbook := parport-share.fig parport-multi.fig parport-structure.fig
-EPS-parportbook := $(patsubst %.fig, %.eps, $(IMG-parportbook))
-PNG-parportbook := $(patsubst %.fig, %.png, $(IMG-parportbook))
-C-procfs-example = procfs_example.sgml
-
-$(TOPDIR)/scripts/docgen $(TOPDIR)/scripts/gen-all-syms \
-$(TOPDIR)/scripts/kernel-doc $(TOPDIR)/scripts/docproc: doc-progs ;
-
-dochelp:
-	@echo  '  Linux kernel internal documentation in different formats:'
-	@echo  '  sgmldocs (SGML), psdocs (Postscript), pdfdocs (PDF), htmldocs (HTML)'
-
-.PHONY: doc-progs
-doc-progs:
-	@$(MAKE) -C $(TOPDIR)/scripts doc-progs
-
-$(BOOKS): $(TOPDIR)/scripts/docgen $(TOPDIR)/scripts/gen-all-syms \
-	  $(TOPDIR)/scripts/kernel-doc $(TOPDIR)/scripts/docproc
+###
+# This makefile is used to generate the kernel documentation,
+# primarily based on in-line comments in various source files.
+# See Documentation/kernel-doc-nano-HOWTO.txt for instruction in how
+# to ducument the SRC - and how to read it.
+# To add a new book the only step required is to add the book to the
+# list of DOCBOOKS.
+
+DOCBOOKS := wanbook.sgml z8530book.sgml mcabook.sgml videobook.sgml \
+	    parportbook.sgml kernel-hacking.sgml \
+	    kernel-locking.sgml via-audio.sgml mousedrivers.sgml \
+	    deviceiobook.sgml procfs-guide.sgml tulip-user.sgml \
+	    writing_usb_driver.sgml scsidrivers.sgml sis900.sgml \
+	    kernel-api.sgml
+
+###
+# The build process is as follows (targets):
+#              (sgmldocs)
+# file.tmpl --> file.sgml +--> file.ps  (psdocs)
+#                         +--> file.pdf  (pdfdocs)
+#                         +--> DIR=file  (htmldocs)
 
+###
+# The targets that may be used.
 .PHONY:	sgmldocs psdocs pdfdocs htmldocs clean mrproper
 
+BOOKS := $(addprefix Documentation/DocBook/,$(DOCBOOKS))
 sgmldocs: $(BOOKS)
 
+PS := $(patsubst %.sgml, %.ps, $(BOOKS))
 psdocs: $(PS)
 
+PDF := $(patsubst %.sgml, %.pdf, $(BOOKS))
 pdfdocs: $(PDF)
 
+HTML := $(patsubst %.sgml, %.html, $(BOOKS))
 htmldocs: $(HTML)
 
+###
+#External programs used
+KERNELDOC=$(objtree)/scripts/kernel-doc
+DOCPROC=$(objtree)/scripts/docproc
+
+###
+# DOCPROC is used for two purposes:
+# 1) To generate a dependency list for a .tmpl file
+# 2) To preprocess a .tmpl file and call kernel-doc with
+#     appropriate parameters.
+# The following rules are used to generate the .sgml documentation
+# required to generate the final targets. (ps, pdf, html).
+quiet_cmd_docproc = DOCPROC $@
+cmd_docproc = $(DOCPROC) doc $< >$@
+define rule_docproc
+	set -e
+        $(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))';) 
+        $(cmd_$(1)); \
+        ( \
+          echo 'cmd_$@ := $(cmd_$(1))'; \
+          echo $@: `$(DOCPROC) depend $<`; \
+        ) > $(dir $@).$(notdir $@).cmd
+endef
+
+%.sgml: %.tmpl FORCE
+	$(call if_changed_rule,docproc)
+
+###
+#Read in all saved dependency files 
+cmd_files := $(wildcard $(foreach f,$(BOOKS),$(dir $(f)).$(notdir $(f)).cmd))
+
+ifneq ($(cmd_files),)
+  include $(cmd_files)
+endif
+
+###
+# Changes in kernel-doc force a rebuild of all documentation
+$(BOOKS): $(KERNELDOC)
+
+###
+# procfs guide uses a .c file as example code.
+# This requires an explicit dependency
+C-procfs-example = Documentation/DocBook/procfs_example.sgml
+Documentation/DocBook/procfs-guide.sgml: $(C-procfs-example)
+
+###
+# The parportbook includes a few images.
+# Force them to be build before the books 
+IMG-parportbook := parport-share.fig parport-multi.fig parport-structure.fig
+IMG-parportbook2 := $(addprefix Documentation/DocBook/,$(IMG-parportbook))
+EPS-parportbook := $(patsubst %.fig,%.eps, $(IMG-parportbook2))
+PNG-parportbook := $(patsubst %.fig,%.png, $(IMG-parportbook2))
+Documentation/DocBook/parportbook.ps: $(EPS-parportbook)
+Documentation/DocBook/parportbook.html Documentation/DocBook/parportbook.pdf:\
+	$(PNG-parportbook)
+
+###
+# Rules to generate postscript, PDF and HTML
+# db2html creates a directory. Generate a html file used for timestamp
+%.ps : %.sgml
+	@(which db2ps > /dev/null 2>&1) || \
+	 (echo "*** You need to install DocBook stylesheets ***"; \
+	  exit 1)
+	@echo '  DB2PS   $@'
+	@db2ps -o $(dir $@) $<
+
+%.pdf : %.sgml
+	@(which db2pdf > /dev/null 2>&1) || \
+	 (echo "*** You need to install DocBook stylesheets ***"; \
+	  exit 1)
+	@echo '  DB2PDF  $@'
+	@db2pdf -o $(dir $@) $<
+
+%.html:	%.sgml
+	@(which db2html > /dev/null 2>&1) || \
+	 (echo "*** You need to install DocBook stylesheets ***"; \
+	  exit 1)
+	@rm -rf $@ $(patsubst %.html,%,$@)
+	@echo '  DB2HTML $@'
+	@db2html -o $(patsubst %.html,%,$@) $< && \
+         echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/book1.html">\
+         Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
+	@if [ ! -z "$(PNG-$(basename $(notdir $@)))" ]; then \
+            cp $(PNG-$(basename $(notdir $@))) $(patsubst %.html,%,$@); fi
+
+###
+# Rules to generate postscripts and PNG imgages from .fig format files
 %.eps: %.fig
-	fig2dev -Leps $< $@
+	@echo '  FIG2DEV -Leps $@'
+	@fig2dev -Leps $< $@
 
 %.png: %.fig
+	@echo '  FIG2DEV -Lpng $@'
 	fig2dev -Lpng $< $@
 
+###
+# Rule to convert a .c file to inline SGML documentation
 %.sgml: %.c
-	echo "<programlisting>" > $@
-	expand --tabs=8 < $< | \
+	@echo '  Generating $@'
+	@echo "<programlisting>" > $@
+	@expand --tabs=8 < $< | \
 	sed -e "s/&/\\&amp;/g" \
-	    -e "s/</\\&lt;/g" \
-	    -e "s/>/\\&gt;/g" >> $@
-	echo "</programlisting>" >> $@
-
-
-mousedrivers.sgml: mousedrivers.tmpl
-	$(TOPDIR)/scripts/docgen <$< >$@
-
-kernel-hacking.sgml: kernel-hacking.tmpl
-	$(TOPDIR)/scripts/docgen <$< >$@
-
-kernel-locking.sgml: kernel-locking.tmpl
-	$(TOPDIR)/scripts/docgen <$< >$@
-
-wanbook.sgml: wanbook.tmpl $(TOPDIR)/drivers/net/wan/syncppp.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/net/wan/syncppp.c \
-		<wanbook.tmpl >wanbook.sgml
-
-z8530book.sgml: z8530book.tmpl $(TOPDIR)/drivers/net/wan/z85230.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/net/wan/z85230.c \
-		<z8530book.tmpl >z8530book.sgml
-
-via-audio.sgml: via-audio.tmpl $(TOPDIR)/sound/oss/via82cxxx_audio.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/sound/oss/via82cxxx_audio.c \
-		<via-audio.tmpl >via-audio.sgml
-
-tulip-user.sgml: tulip-user.tmpl
-	$(TOPDIR)/scripts/docgen <$< >$@
-
-writing_usb_driver.sgml: writing_usb_driver.tmpl
-	$(TOPDIR)/scripts/docgen <$< >$@
-
-scsidrivers.sgml : scsidrivers.tmpl
-	$(TOPDIR)/scripts/docgen <$< >$@
-
-sis900.sgml: sis900.tmpl $(TOPDIR)/drivers/net/sis900.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/net/sis900.c \
-		<sis900.tmpl >sis900.sgml
-
-deviceiobook.sgml: deviceiobook.tmpl
-	$(TOPDIR)/scripts/docgen <deviceiobook.tmpl >deviceiobook.sgml
-
-mcabook.sgml: mcabook.tmpl $(TOPDIR)/arch/i386/kernel/mca.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/arch/i386/kernel/mca.c \
-		<mcabook.tmpl >mcabook.sgml
-
-videobook.sgml: videobook.tmpl $(TOPDIR)/drivers/media/video/videodev.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/media/video/videodev.c \
-		<videobook.tmpl >videobook.sgml
-
-procfs-guide.sgml:  procfs-guide.tmpl procfs_example.sgml
-	$(TOPDIR)/scripts/docgen < procfs-guide.tmpl >$@
-
-APISOURCES :=	$(TOPDIR)/drivers/media/video/videodev.c \
-		$(TOPDIR)/arch/i386/kernel/irq.c \
-		$(TOPDIR)/arch/i386/kernel/mca.c \
-		$(TOPDIR)/arch/i386/kernel/mtrr.c \
-		$(TOPDIR)/drivers/char/misc.c \
-		$(TOPDIR)/kernel/printk.c \
-		$(TOPDIR)/drivers/net/net_init.c \
-		$(TOPDIR)/drivers/net/8390.c \
-		$(TOPDIR)/drivers/serial/core.c \
-		$(TOPDIR)/drivers/serial/8250.c \
-		$(TOPDIR)/drivers/pci/pci.c \
-		$(TOPDIR)/drivers/hotplug/pci_hotplug_core.c \
-		$(TOPDIR)/drivers/hotplug/pci_hotplug_util.c \
-		$(TOPDIR)/drivers/block/ll_rw_blk.c \
-		$(TOPDIR)/sound/sound_core.c \
-		$(TOPDIR)/sound/sound_firmware.c \
-		$(TOPDIR)/drivers/net/wan/syncppp.c \
-		$(TOPDIR)/drivers/net/wan/z85230.c \
-		$(TOPDIR)/drivers/usb/core/hcd.c \
-		$(TOPDIR)/drivers/usb/core/urb.c \
-		$(TOPDIR)/drivers/usb/core/message.c \
-		$(TOPDIR)/drivers/usb/core/config.c \
-		$(TOPDIR)/drivers/usb/core/file.c \
-		$(TOPDIR)/drivers/usb/core/usb.c \
-		$(TOPDIR)/drivers/video/fbmem.c \
-		$(TOPDIR)/drivers/video/fbcmap.c \
-		$(TOPDIR)/drivers/video/fbcon.c \
-		$(TOPDIR)/drivers/video/fbgen.c \
-		$(TOPDIR)/drivers/video/fonts.c \
-		$(TOPDIR)/drivers/video/macmodes.c \
-		$(TOPDIR)/drivers/video/modedb.c \
-		$(TOPDIR)/fs/devfs/base.c \
-		$(TOPDIR)/fs/locks.c \
-		$(TOPDIR)/fs/bio.c \
-		$(TOPDIR)/include/asm-i386/bitops.h \
-		$(TOPDIR)/include/linux/usb.h \
-		$(TOPDIR)/kernel/pm.c \
-		$(TOPDIR)/kernel/ksyms.c \
-		$(TOPDIR)/kernel/kmod.c \
-		$(TOPDIR)/kernel/module.c \
-		$(TOPDIR)/kernel/printk.c \
-		$(TOPDIR)/kernel/sched.c \
-		$(TOPDIR)/kernel/sysctl.c \
-		$(TOPDIR)/lib/string.c \
-		$(TOPDIR)/lib/vsprintf.c \
-		$(TOPDIR)/net/netsyms.c
-
-kernel-api.sgml: kernel-api.tmpl $(APISOURCES)
-	$(TOPDIR)/scripts/docgen $(APISOURCES) \
-		<kernel-api.tmpl >kernel-api.sgml
-
-kernel-api-man: $(APISOURCES)
-	@rm -rf $(TOPDIR)/Documentation/man
-	$(TOPDIR)/scripts/kernel-doc -man $^ | \
-		$(PERL) $(TOPDIR)/scripts/split-man $(TOPDIR)/Documentation/man
-
-parportbook parportbook.pdf: $(PNG-parportbook)
-parportbook.ps: $(EPS-parportbook)
-parportbook.sgml: parportbook.tmpl $(TOPDIR)/drivers/parport/init.c
-	$(TOPDIR)/scripts/docgen $(TOPDIR)/drivers/parport/init.c <$< >$@
-
-DVI	:=	$(patsubst %.sgml, %.dvi, $(BOOKS))
-AUX	:=	$(patsubst %.sgml, %.aux, $(BOOKS))
-TEX	:=	$(patsubst %.sgml, %.tex, $(BOOKS))
-LOG	:=	$(patsubst %.sgml, %.log, $(BOOKS))
-OUT	:=	$(patsubst %.sgml, %.out, $(BOOKS))
+	     -e "s/</\\&lt;/g" \
+	     -e "s/>/\\&gt;/g" >> $@
+	@echo "</programlisting>" >> $@
+
+###
+# Help targets as used by the top-level makefile
+dochelp:
+	@echo  '  Linux kernel internal documentation in different formats:'
+	@echo  '  sgmldocs (SGML), psdocs (Postscript), pdfdocs (PDF), htmldocs (HTML)'
+
+###
+# clean and mrproper as used by the top-level makefile 
+# Temporary files left by various tools
+DVI     :=      $(patsubst %.sgml, %.dvi, $(BOOKS))
+AUX     :=      $(patsubst %.sgml, %.aux, $(BOOKS))
+TEX     :=      $(patsubst %.sgml, %.tex, $(BOOKS))
+LOG     :=      $(patsubst %.sgml, %.log, $(BOOKS))
+OUT     :=      $(patsubst %.sgml, %.out, $(BOOKS))
 
 clean:
 	@echo 'Cleaning up (DocBook)'
@@ -177,37 +168,7 @@
 mrproper:
 	@echo 'Making mrproper (DocBook)'
 	@rm -f $(PS) $(PDF)
-	@rm -f -r $(HTML)
-	@rm -f .depend
-	@rm -f $(TOPDIR)/scripts/mkdep-docbook
-	@rm -rf DBTOHTML_OUTPUT*
-
-%.ps : %.sgml
-	@(which db2ps > /dev/null 2>&1) || \
-	 (echo "*** You need to install DocBook stylesheets ***"; \
-	  exit 1)
-	db2ps $<
-
-%.pdf : %.sgml
-	@(which db2pdf > /dev/null 2>&1) || \
-	 (echo "*** You need to install DocBook stylesheets ***"; \
-	  exit 1)
-	db2pdf $<
-
-%:	%.sgml
-	@(which db2html > /dev/null 2>&1) || \
-	 (echo "*** You need to install DocBook stylesheets ***"; \
-	  exit 1)
-	rm -rf $@
-	db2html $<
-	if [ ! -z "$(PNG-$@)" ]; then cp $(PNG-$@) $@; fi
-
-#
-# we could have our own dependency generator
-#
-#
-# .depend: $(TOPDIR)/scripts/mkdep-docbook
-#	$(TOPDIR)/scripts/mkdep-docbook $(wildcard *.tmpl) > .depend
+	@rm -f -r $(HTML) $(patsubst %.html,%,$(HTML))
 
 include $(TOPDIR)/Rules.make
 
