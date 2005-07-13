Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVGMRGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVGMRGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMRGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:06:41 -0400
Received: from mta02.mail.t-online.hu ([195.228.240.51]:52459 "EHLO
	mta02.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261465AbVGMREz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:04:55 -0400
Subject: [PATCH 1/19] Kconfig I18N: sublocale
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:04:52 +0200
Message-Id: <1121274292.2975.9.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The external store of .mo files are unfrendly and binary .mo 
files are ungly in the source code. This patch creates a temporary 
locale directory on build time in <kernel_source>/.locale/ 
directory instead of /usr/share/locale/ and compiles the 
necessary source language files from the <kernel_source>/po/ directory.

Without installed gettext package the configuration interfaces remain 
in english.

This patch contains too a hook for additional patches. If one or more 
po/*-po directories exist (ex. po/grsecurity-po/) then the content of 
them will merged into the temporary locale directory. In this way the 
configuration interface of external patches will be localisable.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 Makefile                      |    1 
 scripts/kconfig/Makefile      |    7 +++
 scripts/kconfig/lkc.h         |    2 
 scripts/kconfig/set_locale.sh |   93 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 1 deletion(-)

diff -puN Makefile~kconfig-i18n-01-sublocale Makefile
--- linux-2.6.13-rc3-i18n-kconfig/Makefile~kconfig-i18n-01-sublocale	2005-07-13 18:32:15.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/Makefile	2005-07-13 18:32:15.000000000 +0200
@@ -948,6 +948,7 @@ endef
 
 # Directories & files removed with 'make clean'
 CLEAN_DIRS  += $(MODVERDIR)
+CLEAN_DIRS  += .locale
 CLEAN_FILES +=	vmlinux System.map \
                 .tmp_kallsyms* .tmp_version .tmp_vmlinux* .tmp_System.map
 
diff -puN scripts/kconfig/lkc.h~kconfig-i18n-01-sublocale scripts/kconfig/lkc.h
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/lkc.h~kconfig-i18n-01-sublocale	2005-07-13 18:32:15.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/lkc.h	2005-07-13 18:32:15.000000000 +0200
@@ -26,7 +26,7 @@ extern "C" {
 #define SRCTREE "srctree"
 
 #define PACKAGE "linux"
-#define LOCALEDIR "/usr/share/locale"
+#define LOCALEDIR ".locale"
 
 #define _(text) gettext(text)
 #define N_(text) (text)
diff -puN scripts/kconfig/Makefile~kconfig-i18n-01-sublocale scripts/kconfig/Makefile
--- linux-2.6.13-rc3-i18n-kconfig/scripts/kconfig/Makefile~kconfig-i18n-01-sublocale	2005-07-13 18:32:15.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/Makefile	2005-07-13 18:36:54.000000000 +0200
@@ -5,22 +5,28 @@
 .PHONY: oldconfig xconfig gconfig menuconfig config silentoldconfig update-po-config
 
 xconfig: $(obj)/qconf
+	$(Q)sh $(obj)/set_locale.sh
 	$< arch/$(ARCH)/Kconfig
 
 gconfig: $(obj)/gconf
+	$(Q)sh $(obj)/set_locale.sh
 	$< arch/$(ARCH)/Kconfig
 
 menuconfig: $(obj)/mconf
 	$(Q)$(MAKE) $(build)=scripts/lxdialog
+	$(Q)sh $(obj)/set_locale.sh
 	$< arch/$(ARCH)/Kconfig
 
 config: $(obj)/conf
+	$(Q)sh $(obj)/set_locale.sh
 	$< arch/$(ARCH)/Kconfig
 
 oldconfig: $(obj)/conf
+	$(Q)sh $(obj)/set_locale.sh
 	$< -o arch/$(ARCH)/Kconfig
 
 silentoldconfig: $(obj)/conf
+	$(Q)sh $(obj)/set_locale.sh
 	$< -s arch/$(ARCH)/Kconfig
 
 update-po-config: $(obj)/kxgettext
@@ -214,3 +220,4 @@ lex.%.c: %.l
 	flex -P$(notdir $*) -o$@ $<
 
 endif
+
diff -puN /dev/null scripts/kconfig/set_locale.sh
--- /dev/null	2005-07-13 15:43:03.451152136 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/kconfig/set_locale.sh	2005-07-13 18:32:15.000000000 +0200
@@ -0,0 +1,93 @@
+#!/bin/sh
+
+#
+# This script detects language and compiles the language binary files
+#
+
+# Check the po/ directory
+if [ ! -d po/ ]
+then
+	exit 0
+fi
+
+# Set language code
+if test "x$LANG" == "x"
+then
+        if test "x$LC_ALL" == "x"
+	then
+		exit 0
+	else
+		MYLC=$LC_ALL
+	fi
+else
+	MYLC=$LANG
+fi
+
+# If don't need the translation
+if test "x$MYLC" == "xC"
+then
+	exit 0
+fi
+
+MYLCTEST=$(echo $MYLC|cut -b 1-5)
+
+# Find Kconfig's .po
+POFILES=$(find po/ -maxdepth 1 -type f -name ${MYLCTEST}.po)
+if test "x$POFILES" != "x"
+then
+	MYLC=$MYLCTEST
+else
+	MYLCTEST=$(echo $MYLC|cut -b 1-2)
+	POFILES=$(find po/ -maxdepth 1 -type f -name ${MYLCTEST}.po)
+	if test "x$POFILES" != "x"
+        then
+		MYLC=$MYLCTEST
+	else
+		#echo "Your language ($MYLC) is not supported."
+		exit 0
+	fi
+fi
+
+if [ -f .locale/$MYLC/LC_MESSAGES/linux.mo ]
+then
+	exit 0
+fi
+
+echo -n "  LOCALE ($MYLC)... "
+
+# Find additional .po files
+# This is a hook for external patches
+for i in $(find po/ -maxdepth 1 -type d -path '*-po')
+do
+	if [ -f $i/$MYLC.po ]
+	then
+		POFILES="$POFILES $i/$MYLC.po"
+		NEED_CAT=1
+	fi
+done
+
+# Trying msgfmt... and no returning error if it doesn't exist
+msgfmt -V &>/dev/null || {
+	echo "msgfmt doesn't exist, please install gettext";
+	exit 0;
+}
+
+# Do translation...
+mkdir -p .locale/$MYLC/LC_MESSAGES/
+if test "x$NEED_CAT" == "x1"
+then
+	# Trying msgcat and no returning error if it doesn't exist
+	msgcat -V &>/dev/null || {
+		echo "msgcat doesn't exist, please install gettext 0.12 or newer";
+		exit 0;
+	}
+	msgcat --output=.locale/$MYLC/LC_MESSAGES/__tmp.po --use-first $POFILES
+	msgfmt .locale/$MYLC/LC_MESSAGES/__tmp.po --output=.locale/$MYLC/LC_MESSAGES/linux.mo
+	rm -f .locale/$MYLC/LC_MESSAGES/__tmp.po
+else
+	msgfmt $POFILES --output=.locale/$MYLC/LC_MESSAGES/linux.mo
+fi
+
+# Done
+echo " done"
+
_


