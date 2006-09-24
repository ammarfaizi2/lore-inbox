Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWIXVT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWIXVT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWIXVRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:17:47 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:8082 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932142AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@openvz.org>, Andrey Mirkin <amirkin@sw.ru>,
       Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 18/28] kbuild: fail kernel compilation in case of unresolved module symbols
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:14 +0200
Message-Id: <1159132706174-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327061320-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kirill Korotaev <dev@openvz.org>

At stage 2 modpost utility is used to check modules.  In case of unresolved
symbols modpost only prints warning.

IMHO it is a good idea to fail compilation process in case of unresolved
symbols (at least in modules coming with kernel), since usually such errors
are left unnoticed, but kernel modules are broken.

- new option '-w' is added to modpost:
  if option is specified, modpost only warns about unresolved symbols

- modpost is called with '-w' for external modules in Makefile.modpost

Signed-off-by: Andrey Mirkin <amirkin@sw.ru>
Signed-off-by: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/Makefile.modpost |    1 +
 scripts/mod/modpost.c    |   25 +++++++++++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 9137df2..4b2721c 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -58,6 +58,7 @@ quiet_cmd_modpost = MODPOST $(words $(fi
 	$(if $(KBUILD_EXTMOD),-i,-o) $(kernelsymfile) \
 	$(if $(KBUILD_EXTMOD),-I $(modulesymfile)) \
 	$(if $(KBUILD_EXTMOD),-o $(modulesymfile)) \
+	$(if $(KBUILD_EXTMOD),-w) \
 	$(wildcard vmlinux) $(filter-out FORCE,$^)
 
 PHONY += __modpost
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 16a1935..4127796 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -23,6 +23,8 @@ int have_vmlinux = 0;
 static int all_versions = 0;
 /* If we are modposting external module set to 1 */
 static int external_module = 0;
+/* Only warn about unresolved symbols */
+static int warn_unresolved = 0;
 /* How a symbol is exported */
 enum export {
 	export_plain,      export_unused,     export_gpl,
@@ -1196,16 +1198,19 @@ static void add_header(struct buffer *b,
 /**
  * Record CRCs for unresolved symbols
  **/
-static void add_versions(struct buffer *b, struct module *mod)
+static int add_versions(struct buffer *b, struct module *mod)
 {
 	struct symbol *s, *exp;
+	int err = 0;
 
 	for (s = mod->unres; s; s = s->next) {
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod) {
-			if (have_vmlinux && !s->weak)
+			if (have_vmlinux && !s->weak) {
 				warn("\"%s\" [%s.ko] undefined!\n",
 				     s->name, mod->name);
+				err = warn_unresolved ? 0 : 1;
+			}
 			continue;
 		}
 		s->module = exp->module;
@@ -1214,7 +1219,7 @@ static void add_versions(struct buffer *
 	}
 
 	if (!modversions)
-		return;
+		return err;
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const struct modversion_info ____versions[]\n");
@@ -1234,6 +1239,8 @@ static void add_versions(struct buffer *
 	}
 
 	buf_printf(b, "};\n");
+
+	return err;
 }
 
 static void add_depends(struct buffer *b, struct module *mod,
@@ -1411,8 +1418,9 @@ int main(int argc, char **argv)
 	char *kernel_read = NULL, *module_read = NULL;
 	char *dump_write = NULL;
 	int opt;
+	int err;
 
-	while ((opt = getopt(argc, argv, "i:I:mo:a")) != -1) {
+	while ((opt = getopt(argc, argv, "i:I:mo:aw")) != -1) {
 		switch(opt) {
 			case 'i':
 				kernel_read = optarg;
@@ -1430,6 +1438,9 @@ int main(int argc, char **argv)
 			case 'a':
 				all_versions = 1;
 				break;
+			case 'w':
+				warn_unresolved = 1;
+				break;
 			default:
 				exit(1);
 		}
@@ -1450,6 +1461,8 @@ int main(int argc, char **argv)
 		check_exports(mod);
 	}
 
+	err = 0;
+
 	for (mod = modules; mod; mod = mod->next) {
 		if (mod->skip)
 			continue;
@@ -1457,7 +1470,7 @@ int main(int argc, char **argv)
 		buf.pos = 0;
 
 		add_header(&buf, mod);
-		add_versions(&buf, mod);
+		err |= add_versions(&buf, mod);
 		add_depends(&buf, mod, modules);
 		add_moddevtable(&buf, mod);
 		add_srcversion(&buf, mod);
@@ -1469,5 +1482,5 @@ int main(int argc, char **argv)
 	if (dump_write)
 		write_dump(dump_write);
 
-	return 0;
+	return err;
 }
-- 
1.4.1

