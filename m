Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965592AbVKGW4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965592AbVKGW4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965588AbVKGW4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:56:15 -0500
Received: from admingilde.org ([213.95.32.146]:47497 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S965232AbVKGW4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:56:08 -0500
Message-Id: <20051107225606.073925000@admingilde.org>
References: <20051107225408.911193000@admingilde.org>
Date: Mon, 07 Nov 2005 23:54:13 +0100
From: Martin Waitz <tali@admingilde.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 4/4] DocBook: revert xmlto use for .ps and .pdf documentation
Content-Disposition: inline; filename=docbook-dont-depend-on-xmlto.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: revert xmlto use for .ps and .pdf documentation

As xmlto doesn't work for print documentation, we need docbook-utils again for
these targets.
This patch allows the user to choose the method he wants to use.
(I'm still hoping that someone will fix passivetex ;-)

Signed-off-by: Martin Waitz <tali@admingilde.org>

---
 Documentation/DocBook/Makefile |   48 ++++++++++++++++++++++++++++-------------
 1 files changed, 33 insertions(+), 15 deletions(-)

Index: linux-docbook/Documentation/DocBook/Makefile
===================================================================
--- linux-docbook.orig/Documentation/DocBook/Makefile	2005-10-28 00:01:54.000000000 +0200
+++ linux-docbook/Documentation/DocBook/Makefile	2005-11-04 22:18:00.092944116 +0100
@@ -20,6 +20,12 @@ DOCBOOKS := wanbook.xml z8530book.xml mc
 #                        +--> DIR=file  (htmldocs)
 #                        +--> man/      (mandocs)
 
+
+# for PDF and PS output you can choose between xmlto and docbook-utils tools
+PDF_METHOD	= $(prefer-db2x)
+PS_METHOD	= $(prefer-db2x)
+
+
 ###
 # The targets that may be used.
 .PHONY:	xmldocs sgmldocs psdocs pdfdocs htmldocs mandocs installmandocs
@@ -93,27 +99,39 @@ C-procfs-example = procfs_example.xml
 C-procfs-example2 = $(addprefix $(obj)/,$(C-procfs-example))
 $(obj)/procfs-guide.xml: $(C-procfs-example2)
 
-###
-# Rules to generate postscript, PDF and HTML
-# db2html creates a directory. Generate a html file used for timestamp
+notfoundtemplate = echo "*** You have to install docbook-utils or xmlto ***"; \
+		   exit 1
+db2xtemplate = db2TYPE -o $(dir $@) $<
+xmltotemplate = xmlto TYPE $(XMLTOFLAGS) -o $(dir $@) $<
+
+# determine which methods are available
+ifeq ($(shell which db2ps >/dev/null 2>&1 && echo found),found)
+	use-db2x = db2x
+	prefer-db2x = db2x
+else
+	use-db2x = notfound
+	prefer-db2x = $(use-xmlto)
+endif
+ifeq ($(shell which xmlto >/dev/null 2>&1 && echo found),found)
+	use-xmlto = xmlto
+	prefer-xmlto = xmlto
+else
+	use-xmlto = notfound
+	prefer-xmlto = $(use-db2x)
+endif
 
-quiet_cmd_db2ps = XMLTO    $@
-      cmd_db2ps = xmlto ps $(XMLTOFLAGS) -o $(dir $@) $<
+# the commands, generated from the chosen template
+quiet_cmd_db2ps = PS      $@
+      cmd_db2ps = $(subst TYPE,ps, $($(PS_METHOD)template))
 %.ps : %.xml
-	@(which xmlto > /dev/null 2>&1) || \
-	 (echo "*** You need to install xmlto ***"; \
-	  exit 1)
 	$(call cmd,db2ps)
 
-quiet_cmd_db2pdf = XMLTO   $@
-      cmd_db2pdf = xmlto pdf $(XMLTOFLAGS) -o $(dir $@) $<
+quiet_cmd_db2pdf = PDF      $@
+      cmd_db2pdf = $(subst TYPE,pdf, $($(PDF_METHOD)template))
 %.pdf : %.xml
-	@(which xmlto > /dev/null 2>&1) || \
-	 (echo "*** You need to install xmlto ***"; \
-	  exit 1)
 	$(call cmd,db2pdf)
 
-quiet_cmd_db2html = XMLTO  $@
+quiet_cmd_db2html = HTML   $@
       cmd_db2html = xmlto xhtml $(XMLTOFLAGS) -o $(patsubst %.html,%,$@) $< && \
 		echo '<a HREF="$(patsubst %.html,%,$(notdir $@))/index.html"> \
          Goto $(patsubst %.html,%,$(notdir $@))</a><p>' > $@
@@ -127,7 +145,7 @@ quiet_cmd_db2html = XMLTO  $@
 	@if [ ! -z "$(PNG-$(basename $(notdir $@)))" ]; then \
             cp $(PNG-$(basename $(notdir $@))) $(patsubst %.html,%,$@); fi
 
-quiet_cmd_db2man = XMLTO   $@
+quiet_cmd_db2man = MAN     $@
       cmd_db2man = if grep -q refentry $<; then xmlto man $(XMLTOFLAGS) -o $(obj)/man $< ; gzip -f $(obj)/man/*.9; fi
 %.9 : %.xml
 	@(which xmlto > /dev/null 2>&1) || \

--
Martin Waitz
