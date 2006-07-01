Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWGAI7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWGAI7O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 04:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWGAI7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 04:59:14 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:49319 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932262AbWGAI7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 04:59:14 -0400
Date: Sat, 1 Jul 2006 10:59:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
Subject: kbuild: warn if modules uses symbols marked UNUSED
Message-ID: <20060701085907.GA13792@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We now have infrastructure in place to mark symols as unused.
So we better warn is anyone is using a symbol marked unused.

Following patch extends modpost to warn if a module uses a symbol marked
EXPORT_UNUSED_SYMBOL or EXPORT_UNUSED_SYMBOL_GPL.

	Sam

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6541166..dfde0e8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -24,7 +24,10 @@ static int all_versions = 0;
 /* If we are modposting external module set to 1 */
 static int external_module = 0;
 /* How a symbol is exported */
-enum export {export_plain, export_gpl, export_gpl_future, export_unknown};
+enum export {
+	export_plain,      export_unused,     export_gpl,
+	export_unused_gpl, export_gpl_future, export_unknown
+};
 
 void fatal(const char *fmt, ...)
 {
@@ -191,7 +194,9 @@ static struct {
 	enum export export;
 } export_list[] = {
 	{ .str = "EXPORT_SYMBOL",            .export = export_plain },
+	{ .str = "EXPORT_UNUSED_SYMBOL",     .export = export_unused },
 	{ .str = "EXPORT_SYMBOL_GPL",        .export = export_gpl },
+	{ .str = "EXPORT_UNUSED_SYMBOL_GPL", .export = export_unused_gpl },
 	{ .str = "EXPORT_SYMBOL_GPL_FUTURE", .export = export_gpl_future },
 	{ .str = "(unknown)",                .export = export_unknown },
 };
@@ -218,8 +223,12 @@ static enum export export_from_sec(struc
 {
 	if (sec == elf->export_sec)
 		return export_plain;
+	else if (sec == elf->export_unused_sec)
+		return export_unused;
 	else if (sec == elf->export_gpl_sec)
 		return export_gpl;
+	else if (sec == elf->export_unused_gpl_sec)
+		return export_unused_gpl;
 	else if (sec == elf->export_gpl_future_sec)
 		return export_gpl_future;
 	else
@@ -368,8 +377,12 @@ static void parse_elf(struct elf_info *i
 			info->modinfo_len = sechdrs[i].sh_size;
 		} else if (strcmp(secname, "__ksymtab") == 0)
 			info->export_sec = i;
+		else if (strcmp(secname, "__ksymtab_unused") == 0)
+			info->export_unused_sec = i;
 		else if (strcmp(secname, "__ksymtab_gpl") == 0)
 			info->export_gpl_sec = i;
+		else if (strcmp(secname, "__ksymtab_unused_gpl") == 0)
+			info->export_unused_gpl_sec = i;
 		else if (strcmp(secname, "__ksymtab_gpl_future") == 0)
 			info->export_gpl_future_sec = i;
 
@@ -1087,38 +1100,64 @@ void buf_write(struct buffer *buf, const
 	buf->pos += len;
 }
 
-void check_license(struct module *mod)
+static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
+{
+	const char *e = is_vmlinux(m) ?"":".ko";
+
+	switch (exp) {
+	case export_gpl:
+		fatal("modpost: GPL-incompatible module %s%s "
+		      "uses GPL-only symbol '%s'\n", m, e, s);
+		break;
+	case export_unused_gpl:
+		fatal("modpost: GPL-incompatible module %s%s "
+		      "uses GPL-only symbol marked UNUSED '%s'\n", m, e, s);
+		break;
+	case export_gpl_future:
+		warn("modpost: GPL-incompatible module %s%s "
+		      "uses future GPL-only symbol '%s'\n", m, e, s);
+		break;
+	case export_plain:
+	case export_unused:
+	case export_unknown:
+		/* ignore */
+		break;
+	}
+}
+
+static void check_for_unused(enum export exp, const char* m, const char* s)
+{
+	const char *e = is_vmlinux(m) ?"":".ko";
+
+	switch (exp) {
+	case export_unused:
+	case export_unused_gpl:
+		warn("modpost: module %s%s "
+		      "uses symbol '%s' marked UNUSED\n", m, e, s);
+		break;
+	default:
+		/* ignore */
+		break;
+	}
+}
+
+static void check_exports(struct module *mod)
 {
 	struct symbol *s, *exp;
 
 	for (s = mod->unres; s; s = s->next) {
 		const char *basename;
-		if (mod->gpl_compatible == 1) {
-			/* GPL-compatible modules may use all symbols */
-			continue;
-		}
 		exp = find_symbol(s->name);
 		if (!exp || exp->module == mod)
 			continue;
 		basename = strrchr(mod->name, '/');
 		if (basename)
 			basename++;
-		switch (exp->export) {
-			case export_gpl:
-				fatal("modpost: GPL-incompatible module %s "
-				      "uses GPL-only symbol '%s'\n",
-				 basename ? basename : mod->name,
-				exp->name);
-				break;
-			case export_gpl_future:
-				warn("modpost: GPL-incompatible module %s "
-				      "uses future GPL-only symbol '%s'\n",
-				      basename ? basename : mod->name,
-				      exp->name);
-				break;
-			case export_plain: /* ignore */ break;
-			case export_unknown: /* ignore */ break;
-		}
+		else
+			basename = mod->name;
+		if (!mod->gpl_compatible)
+			check_for_gpl_usage(exp->export, basename, exp->name);
+		check_for_unused(exp->export, basename, exp->name);
         }
 }
 
@@ -1399,7 +1438,7 @@ int main(int argc, char **argv)
 	for (mod = modules; mod; mod = mod->next) {
 		if (mod->skip)
 			continue;
-		check_license(mod);
+		check_exports(mod);
 	}
 
 	for (mod = modules; mod; mod = mod->next) {
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 2b00c60..d398c61 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -117,7 +117,9 @@ struct elf_info {
 	Elf_Sym      *symtab_start;
 	Elf_Sym      *symtab_stop;
 	Elf_Section  export_sec;
+	Elf_Section  export_unused_sec;
 	Elf_Section  export_gpl_sec;
+	Elf_Section  export_unused_gpl_sec;
 	Elf_Section  export_gpl_future_sec;
 	const char   *strtab;
 	char	     *modinfo;
