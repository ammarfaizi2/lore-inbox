Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261629AbULBOJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbULBOJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 09:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbULBOJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 09:09:17 -0500
Received: from linaeum.absolutedigital.net ([63.87.232.45]:34455 "EHLO
	linaeum.absolutedigital.net") by vger.kernel.org with ESMTP
	id S261634AbULBOIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 09:08:17 -0500
Date: Thu, 2 Dec 2004 09:08:16 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] extend menuconfig help text
Message-ID: <Pine.LNX.4.61.0412020852550.25332@linaeum.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman et al.,

This patch expands on Yuval Turgeman's excellent patch that added 
searching abilities to menuconfig. It takes the depends/selects/selected 
by text that appears after each search match and adds it to the bottom of 
a specific config option's help text. Quite handy IMO :-)

Please consider for application.

thanks,

-- Cal

Signed-off-by: Cal Peake <cp@absolutedigital.net>

diff -Nru linux-2.6.10-rc2-bk15x/scripts/kconfig/mconf.c linux-2.6.10-rc2-bk15x-1/scripts/kconfig/mconf.c
--- linux-2.6.10-rc2-bk15x/scripts/kconfig/mconf.c	2004-12-02 08:40:09.000000000 -0500
+++ linux-2.6.10-rc2-bk15x-1/scripts/kconfig/mconf.c	2004-12-02 08:37:49.000000000 -0500
@@ -105,6 +105,7 @@
 static void show_readme(void);
 static void show_file(const char *filename, const char *title, int r, int c);
 static void show_expr(struct menu *menu, FILE *fp);
+static char *get_expr(struct menu *menu);
 static void search_conf(char *pattern);
 static int regex_match(const char *string, regex_t *re);
 
@@ -322,6 +323,44 @@
 	}
 }
 
+static char *get_expr(struct menu *menu)
+{
+	FILE *fp;
+	int f;
+	off_t size;
+	char *text = NULL;
+
+	fp = fopen(".expr.tmp", "w+");
+
+	if(!fp){
+		perror("fopen");
+		return NULL;
+	}
+
+	show_expr(menu, fp);
+
+	fflush(fp);
+	rewind(fp);
+	f = fileno(fp);
+
+	size = lseek(f, 0, SEEK_END);
+	lseek(f, 0, SEEK_SET);
+
+	text = malloc(sizeof(char) * (size + 1));
+
+	if(!text)
+		goto exit;
+
+	read(f, text, size);
+
+	text[size] = '\0';
+exit:
+	fclose(fp);
+	unlink(".expr.tmp");
+
+	return text;
+}
+
 static void search_conf(char *pattern)
 {
 	struct symbol *sym = NULL;
@@ -692,17 +731,21 @@
 static void show_help(struct menu *menu)
 {
 	const char *help;
-	char *helptext;
+	char *helptext, *exprtext;
 	struct symbol *sym = menu->sym;
 
 	help = sym->help;
 	if (!help)
 		help = nohelp_text;
 	if (sym->name) {
-		helptext = malloc(strlen(sym->name) + strlen(help) + 16);
-		sprintf(helptext, "CONFIG_%s:\n\n%s", sym->name, help);
+		exprtext = get_expr(menu);
+		helptext = malloc(strlen(sym->name) + strlen(help) +
+				   strlen(exprtext) + 16);
+		sprintf(helptext, "CONFIG_%s:\n\n%s\n%s", sym->name, help,
+			exprtext);
 		show_helptext(menu_get_prompt(menu), helptext);
 		free(helptext);
+		free(exprtext);
 	} else
 		show_helptext(menu_get_prompt(menu), help);
 }
