Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261374AbUKBXsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261374AbUKBXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 18:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbUKBXnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 18:43:41 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:30853
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S261304AbUKBXmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 18:42:46 -0500
Subject: [patch 2/2] kbuild: fix crossbuild base config
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it,
       julian@sektor37.de, mcr@sandelman.ottawa.on.ca, sam@ravnborg.org
From: blaisorblade_spam@yahoo.it
Date: Wed, 03 Nov 2004 00:20:00 +0100
Message-Id: <20041102232001.370174C0BC@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Julian Scheid <julian@sektor37.de>, Michael Richardson <mcr@sandelman.ottawa.on.ca>, Sam Ravnborg <sam@ravnborg.org>

When we are doing "make %config" on a normal build, we search a file to read
default settings from: we take the 1st existing one in a list specified in
scripts/kconfig/confdata.c. This list includes also /boot/config-$VER,
/lib/modules/$VER/.config, which is a wrong choice when we are
cross-compiling. So when cross-compiling we should ignore most files except
.config and arch/$ARCH/defconfig.

This has actually created not-working UML binaries (since UML is always
"cross-compiled" for this purpose), as reported by Julian Scheid.

We all agreed on this kind of general, not UML-only fix, and I (Paolo)
implemented it.

Implementation notes:
- I used a environment var, instead of adding yet another option, because it
  was the least intrusive way. Adding a new option and parsing it in all
  configurators, even the one not yet accepting command line option, was very
  intrusive.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/scripts/kconfig/Makefile   |    8 ++++++++
 vanilla-linux-2.6.9-paolo/scripts/kconfig/confdata.c |   19 +++++++++++++++++--
 vanilla-linux-2.6.9-paolo/scripts/kconfig/lkc.h      |    1 -
 3 files changed, 25 insertions(+), 3 deletions(-)

diff -puN scripts/kconfig/confdata.c~kbuild-fix-crossbuild-defconfig scripts/kconfig/confdata.c
--- vanilla-linux-2.6.9/scripts/kconfig/confdata.c~kbuild-fix-crossbuild-defconfig	2004-11-03 00:18:27.359070256 +0100
+++ vanilla-linux-2.6.9-paolo/scripts/kconfig/confdata.c	2004-11-03 00:18:27.365069344 +0100
@@ -18,7 +18,9 @@ const char conf_def_filename[] = ".confi
 
 const char conf_defname[] = "arch/$ARCH/defconfig";
 
-const char *conf_confnames[] = {
+/*These are used only when conf_read(NULL) is called, i.e. when doing
+ * make config */
+static const char *__conf_confnames[] = {
 	".config",
 	"/lib/modules/$UNAME_RELEASE/.config",
 	"/etc/kernel-config",
@@ -27,6 +29,19 @@ const char *conf_confnames[] = {
 	NULL,
 };
 
+/* If we are doing a cross-compilation, using the host system config is
+ * dangerous (silently broken binaries can be the result).*/
+static const char *__cross_conf_confnames[] = {
+	".config",
+	conf_defname,
+	NULL,
+};
+
+static inline const char **get_conf_confnames(void)
+{
+	return getenv("__KBUILD_CROSS_COMPILING") ? __cross_conf_confnames: __conf_confnames;
+}
+
 static char *conf_expand_value(const signed char *in)
 {
 	struct symbol *sym;
@@ -83,7 +98,7 @@ int conf_read(const char *name)
 	if (name) {
 		in = zconf_fopen(name);
 	} else {
-		const char **names = conf_confnames;
+		const char **names = get_conf_confnames();
 		while ((name = *names++)) {
 			name = conf_expand_value(name);
 			in = zconf_fopen(name);
diff -puN scripts/kconfig/lkc.h~kbuild-fix-crossbuild-defconfig scripts/kconfig/lkc.h
--- vanilla-linux-2.6.9/scripts/kconfig/lkc.h~kbuild-fix-crossbuild-defconfig	2004-11-03 00:18:27.361069952 +0100
+++ vanilla-linux-2.6.9-paolo/scripts/kconfig/lkc.h	2004-11-03 00:18:27.365069344 +0100
@@ -36,7 +36,6 @@ char *zconf_curname(void);
 
 /* confdata.c */
 extern const char conf_def_filename[];
-extern char conf_filename[];
 
 char *conf_get_default_confname(void);
 
diff -puN scripts/kconfig/Makefile~kbuild-fix-crossbuild-defconfig scripts/kconfig/Makefile
--- vanilla-linux-2.6.9/scripts/kconfig/Makefile~kbuild-fix-crossbuild-defconfig	2004-11-03 00:18:27.362069800 +0100
+++ vanilla-linux-2.6.9-paolo/scripts/kconfig/Makefile	2004-11-03 00:18:27.365069344 +0100
@@ -4,6 +4,14 @@
 
 .PHONY: oldconfig xconfig gconfig menuconfig config silentoldconfig
 
+ifneq ($(SUBARCH),$(ARCH))
+  # This is used in scripts/kconfig/confdata.c
+  export __KBUILD_CROSS_COMPILING := 1
+else
+  #Let's prevent interferences from the environment.
+  unexport __KBUILD_CROSS_COMPILING
+endif
+
 xconfig: $(obj)/qconf
 	$< arch/$(ARCH)/Kconfig
 
_
