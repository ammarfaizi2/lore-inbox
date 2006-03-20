Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030536AbWCTWIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030536AbWCTWIP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbWCTWBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:01:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:58553 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030536AbWCTWBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:01:14 -0500
Cc: Sam Ravnborg <sam@ravnborg.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/23] Clean up module.c symbol searching logic
In-Reply-To: <11428920383325-git-send-email-gregkh@suse.de>
X-Mailer: git-send-email
Date: Mon, 20 Mar 2006 14:00:38 -0800
Message-Id: <11428920381135-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg Kroah-Hartman <gregkh@suse.de>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg Kroah-Hartman <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 kernel/module.c |   73 +++++++++++++++++++++++++++++++------------------------
 1 files changed, 41 insertions(+), 32 deletions(-)

3fd6805f4dfb02bcfb5634972eabad0e790f119a
diff --git a/kernel/module.c b/kernel/module.c
index 5aad477..2a892b2 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -135,6 +135,18 @@ extern const unsigned long __start___kcr
 #define symversion(base, idx) ((base) ? ((base) + (idx)) : NULL)
 #endif
 
+/* lookup symbol in given range of kernel_symbols */
+static const struct kernel_symbol *lookup_symbol(const char *name,
+	const struct kernel_symbol *start,
+	const struct kernel_symbol *stop)
+{
+	const struct kernel_symbol *ks = start;
+	for (; ks < stop; ks++)
+		if (strcmp(ks->name, name) == 0)
+			return ks;
+	return NULL;
+}
+
 /* Find a symbol, return value, crc and module which owns it */
 static unsigned long __find_symbol(const char *name,
 				   struct module **owner,
@@ -142,39 +154,41 @@ static unsigned long __find_symbol(const
 				   int gplok)
 {
 	struct module *mod;
-	unsigned int i;
+	const struct kernel_symbol *ks;
 
 	/* Core kernel first. */ 
 	*owner = NULL;
-	for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++) {
-		if (strcmp(__start___ksymtab[i].name, name) == 0) {
-			*crc = symversion(__start___kcrctab, i);
-			return __start___ksymtab[i].value;
-		}
+	ks = lookup_symbol(name, __start___ksymtab, __stop___ksymtab);
+	if (ks) {
+		*crc = symversion(__start___kcrctab, (ks - __start___ksymtab));
+		return ks->value;
 	}
 	if (gplok) {
-		for (i = 0; __start___ksymtab_gpl+i<__stop___ksymtab_gpl; i++)
-			if (strcmp(__start___ksymtab_gpl[i].name, name) == 0) {
-				*crc = symversion(__start___kcrctab_gpl, i);
-				return __start___ksymtab_gpl[i].value;
-			}
+		ks = lookup_symbol(name, __start___ksymtab_gpl,
+					 __stop___ksymtab_gpl);
+		if (ks) {
+			*crc = symversion(__start___kcrctab_gpl,
+					  (ks - __start___ksymtab_gpl));
+			return ks->value;
+		}
 	}
 
 	/* Now try modules. */ 
 	list_for_each_entry(mod, &modules, list) {
 		*owner = mod;
-		for (i = 0; i < mod->num_syms; i++)
-			if (strcmp(mod->syms[i].name, name) == 0) {
-				*crc = symversion(mod->crcs, i);
-				return mod->syms[i].value;
-			}
+		ks = lookup_symbol(name, mod->syms, mod->syms + mod->num_syms);
+		if (ks) {
+			*crc = symversion(mod->crcs, (ks - mod->syms));
+			return ks->value;
+		}
 
 		if (gplok) {
-			for (i = 0; i < mod->num_gpl_syms; i++) {
-				if (strcmp(mod->gpl_syms[i].name, name) == 0) {
-					*crc = symversion(mod->gpl_crcs, i);
-					return mod->gpl_syms[i].value;
-				}
+			ks = lookup_symbol(name, mod->gpl_syms,
+					   mod->gpl_syms + mod->num_gpl_syms);
+			if (ks) {
+				*crc = symversion(mod->gpl_crcs,
+						  (ks - mod->gpl_syms));
+				return ks->value;
 			}
 		}
 	}
@@ -1444,18 +1458,13 @@ static void setup_modinfo(struct module 
 #ifdef CONFIG_KALLSYMS
 int is_exported(const char *name, const struct module *mod)
 {
-	unsigned int i;
-
-	if (!mod) {
-		for (i = 0; __start___ksymtab+i < __stop___ksymtab; i++)
-			if (strcmp(__start___ksymtab[i].name, name) == 0)
-				return 1;
-		return 0;
-	}
-	for (i = 0; i < mod->num_syms; i++)
-		if (strcmp(mod->syms[i].name, name) == 0)
+	if (!mod && lookup_symbol(name, __start___ksymtab, __stop___ksymtab))
+		return 1;
+	else
+		if (lookup_symbol(name, mod->syms, mod->syms + mod->num_syms))
 			return 1;
-	return 0;
+		else
+			return 0;
 }
 
 /* As per nm */
-- 
1.2.4


