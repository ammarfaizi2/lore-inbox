Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbUL3Xwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbUL3Xwy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbUL3Xwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:52:42 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:16983 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261761AbUL3XwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:52:03 -0500
Date: Fri, 31 Dec 2004 00:52:16 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: kconfig: avoid temporary file
Message-ID: <20041230235216.GB9450@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041230235146.GA9450@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 22:30:10+01:00 sam@mars.ravnborg.org 
#   kconfig: avoid temporary file
#   
#   Use a growable string when building up result of searching - avoiding an additional
#   temporary file. A temporary file is still used but on a higher level.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/kconfig/mconf.c
#   2004/12/30 22:29:51+01:00 sam@mars.ravnborg.org +78 -28
#   introduce a general growable string.
#   Allow us to skip one additional temporary file
# 
diff -Nru a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
--- a/scripts/kconfig/mconf.c	2004-12-31 00:45:13 +01:00
+++ b/scripts/kconfig/mconf.c	2004-12-31 00:45:13 +01:00
@@ -104,7 +104,6 @@
 static void show_help(struct menu *menu);
 static void show_readme(void);
 static void show_file(const char *filename, const char *title, int r, int c);
-static void show_expr(struct menu *menu, FILE *fp);
 static void search_conf(char *pattern);
 static int regex_match(const char *string, regex_t *re);
 
@@ -113,6 +112,53 @@
 static void cprint_done(void);
 static int cprint(const char *fmt, ...);
 
+/* Growable string. Allocates memory as needed when string expands */
+struct gstr {
+	char *s;
+	size_t len;
+};
+
+static struct gstr str_init(void)
+{
+	struct gstr gs;
+	gs.s = malloc(sizeof(char) * 16);
+	strcpy(gs.s, "\0");
+	gs.len = 16;
+	return gs;
+}
+
+static void str_del(struct gstr *gs)
+{
+	if (gs->len && gs->s)
+		free(gs->s);
+	gs->s = NULL;
+	gs->len = 0;
+}
+
+static void str_add(struct gstr *gs, const char *s)
+{
+	size_t l = strlen(gs->s) + strlen(s) + 1;
+	if (l >= gs->len)
+		gs->s = realloc(gs->s, l);
+	gs->len = l;
+	strcat(gs->s, s);
+}
+
+static void str_printf(struct gstr *gs, const char *fmt, ...)
+{
+	va_list ap;
+	char s[1024];
+	va_start(ap, fmt);
+	vsnprintf(s, sizeof(s), fmt, ap);
+	str_add(gs, s);
+	va_end(ap);
+}
+
+static const char *str_get(struct gstr *gs)
+{
+	return gs->s;
+}
+
 static void init_wsize(void)
 {
 	struct winsize ws;
@@ -289,36 +335,46 @@
 	return 1;
 }
 
-static void show_expr(struct menu *menu, FILE *fp)
+static void expr_print_str_helper(void *data, const char *str)
+{
+	str_add((struct gstr*)data, str);
+}
+
+static void expr_str(struct expr *e, struct gstr *gs)
+{
+	expr_print(e, expr_print_str_helper, gs, E_NONE);
+}
+
+static void show_expr(struct menu *menu, struct gstr *gs)
 {
 	bool hit = false;
-	fprintf(fp, "Depends:\n ");
+	str_add(gs, "Depends:\n ");
 	if (menu->prompt->visible.expr) {
 		if (!hit)
 			hit = true;
-		expr_fprint(menu->prompt->visible.expr, fp);
+		expr_str(menu->prompt->visible.expr, gs);
 	}
 	if (!hit)
-		fprintf(fp, "None");
+		str_add(gs, "None");
 	if (menu->sym) {
 		struct property *prop;
 		hit = false;
-		fprintf(fp, "\nSelects:\n ");
+		str_add(gs, "\nSelects:\n ");
 		for_all_properties(menu->sym, prop, P_SELECT) {
 			if (!hit)
 				hit = true;
-			expr_fprint(prop->expr, fp);
+			expr_str(prop->expr, gs);
 		}
 		if (!hit)
-			fprintf(fp, "None");
+			str_add(gs, "None");
 		hit = false;
-		fprintf(fp, "\nSelected by:\n ");
+		str_add(gs, "\nSelected by:\n ");
 		if (menu->sym->rev_dep.expr) {
 			hit = true;
-			expr_fprint(menu->sym->rev_dep.expr, fp);
+			expr_str(menu->sym->rev_dep.expr, gs);
 		}
 		if (!hit)
-			fprintf(fp, "None");
+			str_add(gs, "None");
 	}
 }
 
@@ -327,19 +383,13 @@
 	struct symbol *sym = NULL;
 	struct menu *menu[32] = { 0 };
 	struct property *prop = NULL;
-	FILE *fp = NULL;
+	struct gstr str = str_init();
 	bool hit = false;
 	int i, j, k, l;
 	regex_t re;
 
 	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB))
 		return;
-
-	fp = fopen(".search.tmp", "w");
-	if (fp == NULL) {
-		perror("fopen");
-		return;
-	}
 	for_all_symbols(i, sym) {
 		if (!sym->name)
 			continue;
@@ -358,33 +408,33 @@
 			if (j > 0) {
 				if (!hit)
 					hit = true;
-				fprintf(fp, "%s (%s)\n", prop->text, sym->name);
-				fprintf(fp, "Location:\n");
+				str_printf(&str, "%s (%s)\n",
+				           prop->text, sym->name);
+				str_add(&str, "Location:\n");
 			}
 			for (k = j-2, l=1; k > 0; k--, l++) {
 				const char *prompt = menu_get_prompt(menu[k]);
 				if (menu[k]->sym)
-					fprintf(fp, "%*c-> %s (%s)\n",
+					str_printf(&str, "%*c-> %s (%s)\n",
 								l, ' ',
 								prompt,
 								menu[k]->sym->name);
 				else
-					fprintf(fp, "%*c-> %s\n",
+					str_printf(&str, "%*c-> %s\n",
 								l, ' ',
 								prompt);
 			}
 			if (hit) {
-				show_expr(menu[0], fp);
-				fprintf(fp, "\n\n\n");
+				show_expr(menu[0], &str);
+				str_add(&str, "\n\n\n");
 			}
 		}
 	}
 	if (!hit)
-		fprintf(fp, "No matches found.");
+		str_add(&str, "No matches found.");
 	regfree(&re);
-	fclose(fp);
-	show_file(".search.tmp", "Search Results", rows, cols);
-	unlink(".search.tmp");
+	show_textbox("Search Results", str_get(&str), rows, cols);
+	str_del(&str);
 }
 
 static void build_conf(struct menu *menu)
