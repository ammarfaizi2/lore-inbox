Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422691AbWG2HUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422691AbWG2HUi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWG2HUB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:20:01 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:31616 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1422686AbWG2HTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:19:55 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH] kbuild: improve error from file2alias
Reply-To: sam@ravnborg.org
Date: Sat, 29 Jul 2006 09:19:36 +0200
Message-Id: <1154157581409-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1.rc2.gfc04
In-Reply-To: <11541575811267-git-send-email-sam@ravnborg.org>
References: <20060729071540.GA6738@mars.ravnborg.org> <11541575812597-git-send-email-sam@ravnborg.org> <11541575813716-git-send-email-sam@ravnborg.org> <11541575811267-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

The original errormessage was just plain unreadable.

Sample error message after this update (not for real - I provoked it):

FATAL: drivers/net/s2io: sizeof(struct pci_device_id)=33 is not a modulo of the
size of section __mod_pci_device_table=160.
Fix definition of struct pci_device_id in mod_devicetable.h

Before a warning was generated - this is now a fatal error.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/mod/file2alias.c |   62 ++++++++++++++++++++++++++++++++--------------
 1 files changed, 43 insertions(+), 19 deletions(-)

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
 
-- 
1.4.1.rc2.gfc04

