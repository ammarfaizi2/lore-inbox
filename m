Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160999AbWHAJlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160999AbWHAJlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161005AbWHAJlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:41:19 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:37053 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1160999AbWHAJlS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:41:18 -0400
Date: Tue, 1 Aug 2006 11:40:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] kbuild fixes
Message-ID: <20060801094056.GA1058@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Following is a minimum set of kbuild fixes for 2.6.18.
The other kbuild patches previously sent is now queued for 2.6.19.
All patches below has been in -mm for a while.
Please apply.

	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-2.6.18.git

Shotlog, diffstat and diff all inline.

	Sam


Dave Jones:
      kbuild: fix typo in modpost

Qi Yong:
      gitignore: gitignore quilt's files

Roman Zippel:
      kconfig: correct oldconfig for unset choice options

Sam Ravnborg:
      kbuild: hardcode value of YACC&LEX for aic7-triple-x
      kbuild: version.h and new headers_* targets does not require a kernel config
      kbuild: .gitignore utsrelease.h
      kbuild: improve error from file2alias
      kbuild: -fno-stack-protector is not good
      kbuild: always use $(CC) for $(call cc-version)

 .gitignore                           |    5 +++
 Makefile                             |    5 ++-
 drivers/scsi/aic7xxx/aicasm/Makefile |    2 +
 scripts/Kbuild.include               |    3 +-
 scripts/Makefile.modpost             |    2 +
 scripts/kconfig/confdata.c           |    2 +
 scripts/mod/file2alias.c             |   62 ++++++++++++++++++++++++----------
 7 files changed, 56 insertions(+), 25 deletions(-)
diff --git a/.gitignore b/.gitignore
index 27fd376..b1f5b9d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -30,6 +30,11 @@ include/config
 include/linux/autoconf.h
 include/linux/compile.h
 include/linux/version.h
+include/linux/utsrelease.h
 
 # stgit generated dirs
 patches-*
+
+# quilt's files
+patches
+series
diff --git a/Makefile b/Makefile
index c9b7dbb..110db85 100644
--- a/Makefile
+++ b/Makefile
@@ -310,8 +310,8 @@ CPPFLAGS        := -D__KERNEL__ $(LINUXI
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                    -fno-strict-aliasing -fno-common
 # Force gcc to behave correct even for buggy distributions
-CFLAGS          += $(call cc-option, -fno-stack-protector-all \
-                                     -fno-stack-protector)
+CFLAGS          += $(call cc-option, -fno-stack-protector)
+
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
@@ -368,6 +368,7 @@ # of make so .config is not included in 
 
 no-dot-config-targets := clean mrproper distclean \
 			 cscope TAGS tags help %docs check% \
+			 include/linux/version.h headers_% \
 			 kernelrelease kernelversion
 
 config-targets := 0
diff --git a/drivers/scsi/aic7xxx/aicasm/Makefile b/drivers/scsi/aic7xxx/aicasm/Makefile
index 8c91fda..b98c5c1 100644
--- a/drivers/scsi/aic7xxx/aicasm/Makefile
+++ b/drivers/scsi/aic7xxx/aicasm/Makefile
@@ -14,6 +14,8 @@ LIBS=	-ldb
 clean-files:= ${GENSRCS} ${GENHDRS} $(YSRCS:.y=.output) $(PROG)
 # Override default kernel CFLAGS.  This is a userland app.
 AICASM_CFLAGS:= -I/usr/include -I.
+LEX= flex
+YACC= bison
 YFLAGS= -d
 
 NOMAN=	noman
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index f011322..bb19c15 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -77,8 +77,7 @@ cc-option-align = $(subst -functions=0,,
 
 # cc-version
 # Usage gcc-ver := $(call cc-version, $(CC))
-cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh \
-              $(if $(1), $(1), $(CC)))
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
 
 # cc-ifversion
 # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index a495502..0a64688 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -40,7 +40,7 @@ include scripts/Kbuild.include
 include scripts/Makefile.lib
 
 kernelsymfile := $(objtree)/Module.symvers
-modulesymfile := $(KBUILD_EXTMOD)/Modules.symvers
+modulesymfile := $(KBUILD_EXTMOD)/Module.symvers
 
 # Step 1), find all modules listed in $(MODVERDIR)/
 __modules := $(sort $(shell grep -h '\.ko' /dev/null $(wildcard $(MODVERDIR)/*.mod)))
diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 2ee48c3..a69d8ac 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -357,7 +357,7 @@ int conf_read(const char *name)
 		for (e = prop->expr; e; e = e->left.expr)
 			if (e->right.sym->visible != no)
 				flags &= e->right.sym->flags;
-		sym->flags |= flags & SYMBOL_DEF_USER;
+		sym->flags &= flags | ~SYMBOL_DEF_USER;
 	}
 
 	sym_change_count += conf_warnings || conf_unsaved;
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 37f67c2..4431292 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -52,6 +52,23 @@ do {                                    
                 sprintf(str + strlen(str), "*");                \
 } while(0)
 
+/**
+ * Check that sizeof(device_id type) are consistent with size of section
+ * in .o file. If in-consistent then userspace and kernel does not agree
+ * on actual size which is a bug.
+ **/
+static void device_id_size_check(const char *modname, const char *device_id,
+				 unsigned long size, unsigned long id_size)
+{
+	if (size % id_size || size < id_size) {
+		fatal("%s: sizeof(struct %s_device_id)=%lu is not a modulo "
+		      "of the size of section __mod_%s_device_table=%lu.\n"
+		      "Fix definition of struct %s_device_id "
+		      "in mod_devicetable.h\n",
+		      modname, device_id, id_size, device_id, size, device_id);
+	}
+}
+
 /* USB is special because the bcdDevice can be matched against a numeric range */
 /* Looks like "usb:vNpNdNdcNdscNdpNicNiscNipN" */
 static void do_usb_entry(struct usb_device_id *id,
@@ -152,10 +169,8 @@ static void do_usb_table(void *symval, u
 	unsigned int i;
 	const unsigned long id_size = sizeof(struct usb_device_id);
 
-	if (size % id_size || size < id_size) {
-		warn("%s ids %lu bad size "
-		     "(each on %lu)\n", mod->name, size, id_size);
-	}
+	device_id_size_check(mod->name, "usb", size, id_size);
+
 	/* Leave last one: it's the terminator. */
 	size -= id_size;
 
@@ -434,6 +449,7 @@ static inline int sym_is(const char *sym
 
 static void do_table(void *symval, unsigned long size,
 		     unsigned long id_size,
+		     const char *device_id,
 		     void *function,
 		     struct module *mod)
 {
@@ -441,10 +457,7 @@ static void do_table(void *symval, unsig
 	char alias[500];
 	int (*do_entry)(const char *, void *entry, char *alias) = function;
 
-	if (size % id_size || size < id_size) {
-		warn("%s ids %lu bad size "
-		     "(each on %lu)\n", mod->name, size, id_size);
-	}
+	device_id_size_check(mod->name, device_id, size, id_size);
 	/* Leave last one: it's the terminator. */
 	size -= id_size;
 
@@ -476,40 +489,51 @@ void handle_moddevtable(struct module *m
 		+ sym->st_value;
 
 	if (sym_is(symname, "__mod_pci_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct pci_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct pci_device_id), "pci",
 			 do_pci_entry, mod);
 	else if (sym_is(symname, "__mod_usb_device_table"))
 		/* special case to handle bcdDevice ranges */
 		do_usb_table(symval, sym->st_size, mod);
 	else if (sym_is(symname, "__mod_ieee1394_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct ieee1394_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct ieee1394_device_id), "ieee1394",
 			 do_ieee1394_entry, mod);
 	else if (sym_is(symname, "__mod_ccw_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct ccw_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct ccw_device_id), "ccw",
 			 do_ccw_entry, mod);
 	else if (sym_is(symname, "__mod_serio_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct serio_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct serio_device_id), "serio",
 			 do_serio_entry, mod);
 	else if (sym_is(symname, "__mod_pnp_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct pnp_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct pnp_device_id), "pnp",
 			 do_pnp_entry, mod);
 	else if (sym_is(symname, "__mod_pnp_card_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct pnp_card_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct pnp_card_device_id), "pnp_card",
 			 do_pnp_card_entry, mod);
 	else if (sym_is(symname, "__mod_pcmcia_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct pcmcia_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct pcmcia_device_id), "pcmcia",
 			 do_pcmcia_entry, mod);
         else if (sym_is(symname, "__mod_of_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct of_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct of_device_id), "of",
 			 do_of_entry, mod);
         else if (sym_is(symname, "__mod_vio_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct vio_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct vio_device_id), "vio",
 			 do_vio_entry, mod);
 	else if (sym_is(symname, "__mod_i2c_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct i2c_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct i2c_device_id), "i2c",
 			 do_i2c_entry, mod);
 	else if (sym_is(symname, "__mod_input_device_table"))
-		do_table(symval, sym->st_size, sizeof(struct input_device_id),
+		do_table(symval, sym->st_size,
+			 sizeof(struct input_device_id), "input",
 			 do_input_entry, mod);
 }
 
