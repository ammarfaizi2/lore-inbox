Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSG1Mzn>; Sun, 28 Jul 2002 08:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSG1Mzm>; Sun, 28 Jul 2002 08:55:42 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:32007 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316397AbSG1Mzl>;
	Sun, 28 Jul 2002 08:55:41 -0400
Date: Sun, 28 Jul 2002 15:06:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docbook: parportbook dependencies and do_cmd
Message-ID: <20020728150640.C8414@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

o Corrected dependencies for parportbook
o Introduced do_cmd, thus adhering to KBUILD_VERBOSE and make -s

	Sam

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.478   -> 1.479  
#	Documentation/DocBook/Makefile	1.29    -> 1.30   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/28	sam@mars.ravnborg.org	1.479
# [PATCH] docbook: parport dependencies and do_cmd
# o Corrected dependencies for parportbook
# o Introduced do_cmd, thus adhering to KBUILD_VERBOSE and make -s
# --------------------------------------------
#
diff -Nru a/Documentation/DocBook/Makefile b/Documentation/DocBook/Makefile
--- a/Documentation/DocBook/Makefile	Sun Jul 28 14:20:49 2002
+++ b/Documentation/DocBook/Makefile	Sun Jul 28 14:20:49 2002
@@ -88,9 +88,9 @@
 IMG-parportbook2 := $(addprefix Documentation/DocBook/,$(IMG-parportbook))
 EPS-parportbook := $(patsubst %.fig,%.eps, $(IMG-parportbook2))
 PNG-parportbook := $(patsubst %.fig,%.png, $(IMG-parportbook2))
-Documentation/DocBook/parportbook.ps: $(EPS-parportbook)
-Documentation/DocBook/parportbook.html Documentation/DocBook/parportbook.pdf:\
-	$(PNG-parportbook)
+Documentation/DocBook/parportbook.html:	$(PNG-parportbook)
+Documentation/DocBook/parportbook.ps Documentation/DocBook/parportbook.pdf:\
+	$(EPS-parportbook)
 
 ###
 # Rules to generate postscript, PDF and HTML
@@ -99,48 +99,44 @@
 	@(which db2ps > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
-	@echo '  DB2PS   $@'
-	@db2ps -o $(dir $@) $<
+	$(call do_cmd,DB2PS   $@,db2ps -o $(dir $@) $<)
 
 %.pdf : %.sgml
 	@(which db2pdf > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
-	@echo '  DB2PDF  $@'
-	@db2pdf -o $(dir $@) $<
+	$(call do_cmd,DB2PDF  $@,db2pdf -o $(dir $@) $<)
 
 %.html:	%.sgml
 	@(which db2html > /dev/null 2>&1) || \
 	 (echo "*** You need to install DocBook stylesheets ***"; \
 	  exit 1)
 	@rm -rf $@ $(patsubst %.html,%,$@)
-	@echo '  DB2HTML $@'
-	@db2html -o $(patsubst %.html,%,$@) $< && \
+	$(call do_cmd,DB2HTML $@,db2html -o $(patsubst %.html,%,$@) $< && \
          echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/book1.html">\
-         Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
+         Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@)
 	@if [ ! -z "$(PNG-$(basename $(notdir $@)))" ]; then \
             cp $(PNG-$(basename $(notdir $@))) $(patsubst %.html,%,$@); fi
 
 ###
 # Rules to generate postscripts and PNG imgages from .fig format files
 %.eps: %.fig
-	@echo '  FIG2DEV -Leps $@'
-	@fig2dev -Leps $< $@
+	$(call do_cmd,FIG2DEV -Leps $@,fig2dev -Leps $< $@)
 
 %.png: %.fig
-	@echo '  FIG2DEV -Lpng $@'
-	fig2dev -Lpng $< $@
+	$(call do_cmd,FIG2DEV -Lpng $@,fig2dev -Lpng $< $@)
 
 ###
 # Rule to convert a .c file to inline SGML documentation
 %.sgml: %.c
 	@echo '  Generating $@'
-	@echo "<programlisting>" > $@
-	@expand --tabs=8 < $< | \
-	sed -e "s/&/\\&amp;/g" \
-	     -e "s/</\\&lt;/g" \
-	     -e "s/>/\\&gt;/g" >> $@
-	@echo "</programlisting>" >> $@
+	@(                            \
+	   echo "<programlisting>";   \
+	   expand --tabs=8 < $< |     \
+	   sed -e "s/&/\\&amp;/g"     \
+	       -e "s/</\\&lt;/g"      \
+	       -e "s/>/\\&gt;/g";     \
+	   echo "</programlisting>")  > $@
 
 ###
 # Help targets as used by the top-level makefile
