Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318216AbSGWVjG>; Tue, 23 Jul 2002 17:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318217AbSGWVjG>; Tue, 23 Jul 2002 17:39:06 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:60684 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S318216AbSGWViy>;
	Tue, 23 Jul 2002 17:38:54 -0400
Date: Tue, 23 Jul 2002 23:49:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Cc: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: [PATCH] DocBook Makefile&Friends cleanup
Message-ID: <20020723234913.A27379@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started looking at the Makefile for DocBook, and felt a little attention was needed.
This is what the clen-up resulted in.

When doing "make pdfdocs" a lot of errors/warnings are still present. I did not
try to address this, a challenge for a DocBook expert?

Also the output from scripts/kernel-doc is not that helpful - as posted earlier.


>From the changeset:
# o Massive clean-up of makefile
#   - Removed the call to scripts/Makefile, hereby eliminating the doc-progs target
# o Removed the need for gen-all-syms and docgen, functionality included in docproc
# o Deleted gen-all-syms and docgen
# o docproc extended to generate dependency information, no need to specify all
#   dependencies in the makefile
# o htmldocs now generate a small .html file in Documentation/DocBook that
#   points to the book1.html for the book in question
# o Added a new directive for file inclusion !D, to cover symbols
#   defined in kernel/ksyms.c and similar
# o Updated documentation (kernel-doc-nano-HOWTO.txt)
# o Updated kernel-api.tmpl and parportbook.tmpl, they need to specify files
#   to search for EXPORT_SYMBOL explicit. Previously this was done on
#   the commandline in the makefile.

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.737   -> 1.738  
#	Documentation/DocBook/kernel-api.tmpl	1.15    -> 1.16   
#	Documentation/DocBook/parportbook.tmpl	1.5     -> 1.6    
#	scripts/gen-all-syms	1.2     ->         (deleted)      
#	            Makefile	1.274   -> 1.275  
#	   scripts/docproc.c	1.2     -> 1.3    
#	      scripts/docgen	1.3     ->         (deleted)      
#	Documentation/kernel-doc-nano-HOWTO.txt	1.3     -> 1.4    
#	Documentation/DocBook/Makefile	1.27    -> 1.28   
#	    scripts/Makefile	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/23	sam@mars.ravnborg.org	1.738
# o Massive clean-up of makefile
#   - Removed the call to scripts/Makefile, hereby eliminating the doc-progs target
# o Removed the need for gen-all-syms and docgen, functionality included in docproc
# o Deleted gen-all-syms and docgen
# o docproc extended to generate dependency information, no need to specify all
#   dependencies in the makefile
# o htmldocs now generate a small .html file in Documentation/DocBook that
#   points to the book1.html for the book in question
# o Added a new directive for file inclusion !D, to cover symbols
#   defined in kernel/ksyms.c and similar
# o Updated documentation (kernel-doc-nano-HOWTO.txt)
# o Updated kernel-api.tmpl and parportbook.tmpl, they need to specify files
#   to search for EXPORT_SYMBOL explicit. Previously this was done on
#   the commandline in the makefile.
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Tue Jul 23 23:41:24 2002
+++ b/Documentation/DocBook/Makefile	Tue Jul 23 23:41:24 2002
@@ -1,169 +1,162 @@
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
-		$(TOPDIR)/drivers/char/serial.c \
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
@@ -176,37 +169,7 @@
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
 
diff -Nru a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
--- a/Documentation/DocBook/kernel-api.tmpl	Tue Jul 23 23:41:23 2002
+++ b/Documentation/DocBook/kernel-api.tmpl	Tue Jul 23 23:41:23 2002
@@ -50,7 +50,7 @@
   kernel/sched.c has no docs, which stuffs up the sgml.  Comment
   out until somebody adds docs.  KAO
      <sect1><title>Delaying, scheduling, and timer routines</title>
-!Ekernel/sched.c
+X!Ekernel/sched.c
      </sect1>
 KAO -->
   </chapter>
@@ -366,7 +366,7 @@
   drivers/video/fbgen.c has no docs, which stuffs up the sgml.  Comment
   out until somebody adds docs.  KAO
      <sect1><title>Frame Buffer Generic Functions</title>
-!Idrivers/video/fbgen.c
+X!Idrivers/video/fbgen.c
      </sect1>
 KAO -->
      <sect1><title>Frame Buffer Video Mode Database</title>
@@ -380,5 +380,9 @@
 !Idrivers/video/fonts.c
      </sect1>
   </chapter>
-
+<!-- Needs ksyms to list additional exported symbols, but no specific doc.
+     docproc do not care about sgml commants.
+!Dkernel/ksyms.c
+!Dnet/netsyms.c
+-->
 </book>
diff -Nru a/Documentation/DocBook/parportbook.tmpl b/Documentation/DocBook/parportbook.tmpl
--- a/Documentation/DocBook/parportbook.tmpl	Tue Jul 23 23:41:23 2002
+++ b/Documentation/DocBook/parportbook.tmpl	Tue Jul 23 23:41:23 2002
@@ -2729,7 +2729,9 @@
  </appendix>
 
 </book>
-
+<!-- Additional function to be documented:
+!Ddrivers/parport/init.c
+-->
 <!-- Local Variables: -->
 <!-- sgml-indent-step: 1 -->
 <!-- sgml-indent-data: 1 -->
diff -Nru a/Documentation/kernel-doc-nano-HOWTO.txt b/Documentation/kernel-doc-nano-HOWTO.txt
--- a/Documentation/kernel-doc-nano-HOWTO.txt	Tue Jul 23 23:41:24 2002
+++ b/Documentation/kernel-doc-nano-HOWTO.txt	Tue Jul 23 23:41:24 2002
@@ -20,18 +20,14 @@
 - scripts/docproc.c
 
   This is a program for converting SGML template files into SGML
-  files.  It invokes kernel-doc, giving it the list of functions that
+  files. When a file is referenced it is searched for symbols
+  exported (EXPORT_SYMBOL), to be able to distingush between internal
+  and external functions.
+  It invokes kernel-doc, giving it the list of functions that
   are to be documented.
-
-- scripts/gen-all-syms
-
-  This is a script that lists the EXPORT_SYMBOL symbols in a list of C
-  files.
-
-- scripts/docgen
-
-  This script invokes docproc, telling it which functions are to be
-  documented (this list comes from gen-all-syms).
+  Additionally it is used to scan the SGML template files to locate
+  all the files referenced herein. This is used to generate dependency
+  information as used by make.
 
 - Makefile
 
@@ -141,6 +137,10 @@
 
 !I<filename> is replaced by the documentation for functions that are
 _not_ exported using EXPORT_SYMBOL.
+
+!D<filename> is used to name additional files to search for functions
+exported using EXPORT_SYMBOL. For example many symbols are only exported
+in kernel/ksyms.c, therefore kernel-api.sgml include this file with !D.
 
 !F<filename> <function [functions...]> is replaced by the
 documentation, in <filename>, for the functions listed.
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Tue Jul 23 23:41:23 2002
+++ b/Makefile	Tue Jul 23 23:41:23 2002
@@ -165,6 +165,15 @@
 		    help tags TAGS sgmldocs psdocs pdfdocs htmldocs \
 		    checkconfig checkhelp checkincludes
 
+# Helpers built in scripts/
+# ---------------------------------------------------------------------------
+
+scripts/docproc scripts/fixdep scripts/split-include : scripts ;
+
+.PHONY: scripts
+scripts:
+	@$(MAKE) -C scripts
+
 ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
 
 # Here goes the main Makefile
@@ -356,15 +365,6 @@
 	) > $@.tmp
 	@$(update-if-changed)
 
-# Helpers built in scripts/
-# ---------------------------------------------------------------------------
-
-scripts/fixdep scripts/split-include : scripts ;
-
-.PHONY: scripts
-scripts:
-	@$(MAKE) -C scripts
-
 # Generate module versions
 # ---------------------------------------------------------------------------
 
@@ -649,7 +649,7 @@
 		-name .\*.tmp -o -name .\*.d \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
-	@$(MAKE) -C Documentation/DocBook clean
+	@$(MAKE) -f Documentation/DocBook/Makefile clean
 
 mrproper: clean archmrproper
 	@echo 'Making mrproper'
@@ -658,7 +658,7 @@
 		-type f -print | xargs rm -f
 	@rm -f $(MRPROPER_FILES)
 	@rm -rf $(MRPROPER_DIRS)
-	@$(MAKE) -C Documentation/DocBook mrproper
+	@$(MAKE) -f Documentation/DocBook/Makefile mrproper
 
 distclean: mrproper
 	@echo 'Making distclean'
@@ -731,10 +731,8 @@
 
 # Documentation targets
 # ---------------------------------------------------------------------------
-
-sgmldocs psdocs pdfdocs htmldocs:
-	@$(MAKE) -C Documentation/DocBook $@
-
+sgmldocs psdocs pdfdocs htmldocs: scripts
+	@$(MAKE) -f Documentation/DocBook/Makefile $@
 
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
diff -Nru a/scripts/Makefile b/scripts/Makefile
--- a/scripts/Makefile	Tue Jul 23 23:41:24 2002
+++ b/scripts/Makefile	Tue Jul 23 23:41:24 2002
@@ -7,7 +7,7 @@
 # can't do it
 CHMOD_FILES := docgen gen-all-syms kernel-doc mkcompile_h makelst
 
-all: fixdep split-include $(CHMOD_FILES)
+all: fixdep split-include docproc $(CHMOD_FILES)
 
 $(CHMOD_FILES): FORCE
 	@chmod a+x $@
@@ -36,11 +36,6 @@
 	  cat $(TAIL)                                           \
 	) > $@
 	chmod 755 $@
-
-# DocBook stuff
-# ---------------------------------------------------------------------------
-
-doc-progs: docproc
 
 # ---------------------------------------------------------------------------
 
diff -Nru a/scripts/docgen b/scripts/docgen
--- a/scripts/docgen	Tue Jul 23 23:41:24 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,10 +0,0 @@
-#!/bin/sh
-set -e
-if [ -z "$scripts_objtree" ]
-then
-	X=`$TOPDIR/scripts/gen-all-syms "$*"`
-	$TOPDIR/scripts/docproc $X
-else
-	X=`${scripts_objtree}gen-all-syms "$*"`
-	TOPDIR=. ${scripts_objtree}docproc $X
-fi
diff -Nru a/scripts/docproc.c b/scripts/docproc.c
--- a/scripts/docproc.c	Tue Jul 23 23:41:23 2002
+++ b/scripts/docproc.c	Tue Jul 23 23:41:24 2002
@@ -1,104 +1,387 @@
+/*
+ *	docproc is a simple preprocessor for the template files
+ *      used as placeholders for the kernel internal documentation.
+ *	docproc is used for documentation-frontend and
+ *      dependency-generator.
+ *	The two usages have in common that they require
+ *	some knowledge of the .tmpl syntax, therefore they
+ *	are kept together.
+ *
+ *	documentation-frontend
+ *		Scans the template file and call kernel-doc for
+ *		all occurrences of ![EIF]file
+ *		Beforehand each referenced file are scanned for
+ *		any exported sympols "EXPORT_SYMBOL()" statements.
+ *		This is used to create proper -function and
+ *		-nofunction arguments in calls to kernel-doc.
+ *		Usage: docproc doc file.tmpl
+ *
+ *	dependency-generator:
+ *		Scans the template file and list all files
+ *		referenced in a format recognized by make.
+ *		Usage:	docproc depend file.tmpl
+ *		Writes dependency information to stdout
+ *		in the following format:
+ *		file.tmpl src.c	src2.c
+ *		The filenames are obtained from the following constructs:
+ *		!Efilename
+ *		!Ifilename
+ *		!Dfilename
+ *		!Ffilename
+ *		
+ */
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <ctype.h>
 #include <unistd.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
+/* exitstatus is used to keep track of any failing calls to kernel-doc,
+ * but execution continues. */
+int exitstatus = 0;
+
+typedef void DFL(char *);
+DFL *defaultline;
+
+typedef void FILEONLY(char * file);
+FILEONLY *internalfunctions;
+FILEONLY *externalfunctions;
+FILEONLY *symbolsonly;
+
+typedef void FILELINE(char * file, char * line);
+FILELINE * singlefunctions;
+FILELINE * entity_system;
+
+#define MAXLINESZ     2048
+#define MAXFILES      250
+#define KERNELDOCPATH "scripts/"
+#define KERNELDOC     "kernel-doc"
+#define DOCBOOK       "-docbook"
+#define FUNCTION      "-function"
+#define NOFUNCTION    "-nofunction"
+
+void usage (void)
+{
+	fprintf(stderr, "Usage: docproc {doc|depend} file\n");
+	fprintf(stderr, "Input is read from file.tmpl. Output is sent to stdout\n");
+	fprintf(stderr, "doc: frontend when generating kernel documentation\n");
+	fprintf(stderr, "depend: generate list of files referenced within file\n");
+}
+
 /*
- *	A simple filter for the templates
+ * Execute kernel-doc with parameters givin in svec
  */
+void exec_kernel_doc(char **svec)
+{
+	pid_t pid;
+	int ret;
+	/* Make sure output generated so far are flushed */
+	fflush(stdout);
+	switch(pid=fork()) {
+		case -1:
+			perror("fork");
+			exit(1);
+		case  0:
+			execvp(KERNELDOCPATH KERNELDOC, svec);
+			perror("exec " KERNELDOCPATH KERNELDOC);
+			exit(1);
+		default:
+			waitpid(pid, &ret ,0);
+	}
+	if (WIFEXITED(ret))
+		exitstatus = WEXITSTATUS(ret);
+	else
+		exitstatus = 0xff;
+}
 
-int main(int argc, char *argv[])
+/* Types used to create list of all exported symbols in a number of files */
+struct symbols
+{
+	char *name;
+};
+
+struct symfile
+{
+	char *filename;
+	struct symbols *symbollist;
+	int symbolcnt;
+};
+
+struct symfile symfilelist[MAXFILES];
+int symfilecnt = 0;
+
+void add_new_symbol(struct symfile *sym, char * symname)
+{
+	sym->symbollist =
+          realloc(sym->symbollist, (sym->symbolcnt + 1) * sizeof(char *));
+	sym->symbollist[sym->symbolcnt++].name = strdup(symname);
+}
+
+/* Add a filename to the list */
+struct symfile * add_new_file(char * filename)
+{
+	symfilelist[symfilecnt++].filename = strdup(filename);
+	return &symfilelist[symfilecnt - 1];					
+}
+/* Check if file already are present in the list */
+struct symfile * filename_exist(char * filename)
 {
-	char buf[1024];
-	char *vec[8192];
-	char *fvec[200];
-	char **svec;
-	char type[64];
 	int i;
-	int vp=2;
-	int ret=0;
-	pid_t pid;
+	for (i=0; i < symfilecnt; i++)
+		if (strcmp(symfilelist[i].filename, filename) == 0)
+			return &symfilelist[i];
+	return NULL;
+}
 
+/*
+ * List all files referenced within the template file.
+ * Files are separated by tabs.
+ */
+void adddep(char * file)		   { printf("\t%s", file); }
+void adddep2(char * file, char * line)     { line = line; adddep(file); }
+void noaction(char * line)		   { line = line; }
+void noaction2(char * file, char * line)   { file = file; line = line; }
 
-	if(chdir(getenv("TOPDIR")))
-	{
-		perror("chdir");
-		exit(1);
+/* Echo the line without further action */
+void printline(char * line)               { printf("%s", line); }
+
+/* 
+ * Find all symbols exported with EXPORT_SYMBOL and EXPORT_SYMBOL_GPL 
+ * in filename.
+ * All symbols located are stored in symfilelist.
+ */
+void find_export_symbols(char * filename)
+{
+	FILE * fp;
+	struct symfile *sym;
+	char line[MAXLINESZ];
+	if (filename_exist(filename) == NULL) {
+		sym = add_new_file(filename);
+		fp = fopen(filename, "r");
+		if (fp == NULL)
+		{
+			fprintf(stderr, "docproc: ");
+			perror(filename);
+		}
+		while(fgets(line, MAXLINESZ, fp)) {
+			char *p;
+			char *e;
+			if (((p = strstr(line, "EXPORT_SYMBOL_GPL")) != 0) ||
+                            ((p = strstr(line, "EXPORT_SYMBOL")) != 0)) {
+				/* Skip EXPORT_SYMBOL{_GPL} */
+				while (isalnum(*p) || *p == '_')
+					p++;
+				/* Remove paranteses and additional ws */
+				while (isspace(*p))
+					p++;
+				if (*p != '(')
+					continue; /* Syntax error? */
+				else
+					p++;
+				while (isspace(*p))
+					p++;
+				e = p;
+				while (isalnum(*e) || *e == '_')
+					e++;
+				*e = '\0';
+				add_new_symbol(sym, p);
+			}
+		}
+		fclose(fp);
 	}
+}
+
+/*
+ * Document all external or internal functions in a file.
+ * Call kernel-doc with following parameters:
+ * kernel-doc -docbook -nofunction function_name1 filename
+ * function names are obtained from all the the src files
+ * by find_export_symbols.
+ * intfunc uses -nofunction
+ * extfunc uses -function
+ */
+void docfunctions(char * filename, char * type)
+{
+	int i,j;
+	int symcnt = 0;
+	int idx = 0;
+	char **vec;
 	
-	/*
-	 *	Build the exec array ahead of time.
-	 */
-	vec[0]="kernel-doc";
-	vec[1]="-docbook";
-	for(i=1;vp<8189;i++)
-	{
-		if(argv[i]==NULL)
-			break;
-		vec[vp++]=type;
-		vec[vp++]=argv[i];
+	for (i=0; i <= symfilecnt; i++)
+		symcnt += symfilelist[i].symbolcnt;
+	vec = malloc((2 + 2 * symcnt + 2) * sizeof(char*));
+	if (vec == NULL) {
+		perror("docproc: ");
+		exit(1);
 	}
-	vec[vp++]=buf+2;
-	vec[vp++]=NULL;
-	
-	/*
-	 *	Now process the template
-	 */
-	 
-	while(fgets(buf, 1024, stdin))
-	{
-		if(*buf!='!') {
-			printf("%s", buf);
-			continue;
+	vec[idx++] = KERNELDOC;
+	vec[idx++] = DOCBOOK;
+	for (i=0; i < symfilecnt; i++) {
+		struct symfile * sym = &symfilelist[i];
+		for (j=0; j < sym->symbolcnt; j++) {
+			vec[idx++]     = type;
+			vec[idx++] = sym->symbollist[j].name;
 		}
+	}
+	vec[idx++]     = filename;
+	vec[idx] = NULL;
+	printf("<!-- %s -->\n", filename);
+	exec_kernel_doc(vec);
+	fflush(stdout);
+	free(vec);
+}
+void intfunc(char * filename) {	docfunctions(filename, NOFUNCTION); }
+void extfunc(char * filename) { docfunctions(filename, FUNCTION);   }
 
-		fflush(stdout);
-		svec = vec;
-		if(buf[1]=='E')
-			strcpy(type, "-function");
-		else if(buf[1]=='I')
-			strcpy(type, "-nofunction");	
-		else if(buf[1]=='F') {
-			int snarf = 0;
-			fvec[0] = "kernel-doc";
-			fvec[1] = "-docbook";
-			strcpy (type, "-function");
-			vp = 2;
-			for (i = 2; buf[i]; i++) {
-				if (buf[i] == ' ' || buf[i] == '\n') {
-					buf[i] = '\0';
-					snarf = 1;
-					continue;
-				}
-
-				if (snarf) {
-					snarf = 0;
-					fvec[vp++] = type;
-					fvec[vp++] = &buf[i];
-				}
+/*
+ * Document spåecific function(s) in a file.
+ * Call kernel-doc with the following parameters:
+ * kernel-doc -docbook -function function1 [-function function2]
+ */
+void singfunc(char * filename, char * line)
+{
+	char *vec[200]; /* Enough for specific functions */
+        int i, idx = 0;
+        int startofsym = 1;
+	vec[idx++] = KERNELDOC;
+	vec[idx++] = DOCBOOK;
+
+        /* Split line up in individual parameters preceeded by FUNCTION */        
+        for (i=0; line[i]; i++) {
+                if (isspace(line[i])) {
+                        line[i] = '\0';
+                        startofsym = 1;
+                        continue;
+                }
+                if (startofsym) {
+                        startofsym = 0;
+                        vec[idx++] = FUNCTION;
+                        vec[idx++] = &line[i];
+                }
+        }
+	vec[idx++] = filename;
+	vec[idx] = NULL;
+	exec_kernel_doc(vec);
+}
+
+/*
+ * Parse file, calling action specific functions for:
+ * 1) Lines containing !E
+ * 2) Lines containing !I
+ * 3) Lines containing !D
+ * 4) Lines containing !F
+ * 5) Default lines - lines not matching the above
+ */
+void parse_file(FILE *infile)
+{
+	char line[MAXLINESZ];
+	char * s;
+	while(fgets(line, MAXLINESZ, infile)) {
+		if (line[0] == '!') {
+			s = line + 2;
+			switch (line[1]) {
+				case 'E':
+					while (*s && !isspace(*s)) s++;
+					*s = '\0';
+					externalfunctions(line+2);
+					break;
+				case 'I':
+					while (*s && !isspace(*s)) s++;
+					*s = '\0';
+					internalfunctions(line+2);
+					break;
+				case 'D':
+					while (*s && !isspace(*s)) s++;
+                                        *s = '\0';
+                                        symbolsonly(line+2);
+                                        break;
+				case 'F':
+					/* filename */
+					while (*s && !isspace(*s)) s++;
+					*s++ = '\0';
+                                        /* function names */
+					while (isspace(*s))
+						s++;
+					singlefunctions(line +2, s);
+					break;
+				default:
+					defaultline(line);
 			}
-			fvec[vp++] = &buf[2];
-			fvec[vp] = NULL;
-			svec = fvec;
-		} else
-		{
-			fprintf(stderr, "Unknown ! escape.\n");
-			exit(1);
 		}
-		switch(pid=fork())
-		{
-		case -1:
-			perror("fork");
-			exit(1);
-		case  0:
-			execvp("scripts/kernel-doc", svec);
-			perror("exec scripts/kernel-doc");
-			exit(1);
-		default:
-			waitpid(pid, &ret ,0);
+		else {
+			defaultline(line);
 		}
 	}
-	exit(ret);
+	fflush(stdout);
 }
+		
+
+int main(int argc, char *argv[])
+{
+	FILE * infile;
+	if (argc != 3) {
+		usage();
+		exit(1);
+	}
+	/* Open file, exit on error */
+	infile = fopen(argv[2], "r");
+        if (infile == NULL) {
+                fprintf(stderr, "docproc: ");
+                perror(argv[2]);
+                exit(2);
+        }
+
+	if (strcmp("doc", argv[1]) == 0)
+	{
+		/* Need to do this in two passes.
+		 * First pass is used to collect all symbols exported
+		 * in the various files.
+		 * Second pass generate the documentation.
+		 * This is required because function are declared
+		 * and exported in different files :-((
+		 */
+		/* Collect symbols */
+		defaultline       = noaction;
+		internalfunctions = find_export_symbols;
+		externalfunctions = find_export_symbols;
+		symbolsonly       = find_export_symbols;
+		singlefunctions   = noaction2;
+		parse_file(infile);
+
+		/* Rewind to start from beginning of file again */
+		fseek(infile, 0, SEEK_SET);
+		defaultline       = printline;
+		internalfunctions = intfunc;
+		externalfunctions = extfunc;
+		symbolsonly       = printline;
+		singlefunctions   = singfunc;
+		
+		parse_file(infile);
+	}
+	else if (strcmp("depend", argv[1]) == 0)
+	{
+		/* Create first part of dependency chain
+		 * file.tmpl */
+		printf("%s\t", argv[2]);
+		defaultline       = noaction;
+		internalfunctions = adddep;
+		externalfunctions = adddep;
+		symbolsonly       = adddep;
+		singlefunctions   = adddep2;
+		parse_file(infile);
+		printf("\n");
+	}
+	else
+	{
+		fprintf(stderr, "Unknown option: %s\n", argv[1]);
+		exit(1);
+	}
+	fclose(infile);
+	fflush(stdout);
+	return exitstatus;
+}
+
diff -Nru a/scripts/gen-all-syms b/scripts/gen-all-syms
--- a/scripts/gen-all-syms	Tue Jul 23 23:41:23 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,7 +0,0 @@
-#!/bin/sh
-for i in $*
-do
-	grep "EXPORT_SYMBOL.*(.*)" "$i" \
-		| sed -e "s/EXPORT_SYMBOL.*(/  /" \
-		| sed -e "s/).*$//" | sed -e "s/^  //"
-done
