Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbVKCPH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbVKCPH1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVKCPHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:07:25 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:27849 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030258AbVKCPHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:07:23 -0500
Date: Thu, 3 Nov 2005 16:07:20 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] kconfig: preset config during all*config
Message-ID: <Pine.LNX.4.61.0511031606530.2501@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allow to force setting of config variables during 
all{no,mod,yes,random}config to a specific value. For that conf first 
checks the KCONFIG_ALLCONFIG environment variable for a file name, 
otherwise it checks for all{no,mod,yes,random}.config and all.config. The 
file is a normal config file, which presets the config variables, but they 
are still subject to normal dependency checks.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 scripts/kconfig/conf.c      |   30 ++++++++++++++++++++++++++++++
 scripts/kconfig/confdata.c  |   17 ++++++++++++++---
 scripts/kconfig/lkc_proto.h |    1 +
 3 files changed, 45 insertions(+), 3 deletions(-)

Index: linux-2.6/scripts/kconfig/conf.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/conf.c	2005-11-03 13:22:59.000000000 +0100
+++ linux-2.6/scripts/kconfig/conf.c	2005-11-03 13:23:06.000000000 +0100
@@ -82,6 +82,15 @@ static void conf_askvalue(struct symbol 
 	}
 
 	switch (input_mode) {
+	case set_no:
+	case set_mod:
+	case set_yes:
+	case set_random:
+		if (sym_has_value(sym)) {
+			printf("%s\n", def);
+			return;
+		}
+		break;
 	case ask_new:
 	case ask_silent:
 		if (sym_has_value(sym)) {
@@ -560,6 +569,27 @@ int main(int ac, char **av)
 	case ask_new:
 		conf_read(NULL);
 		break;
+	case set_no:
+	case set_mod:
+	case set_yes:
+	case set_random:
+		name = getenv("KCONFIG_ALLCONFIG");
+		if (name && !stat(name, &tmpstat)) {
+			conf_read_simple(name);
+			break;
+		}
+		switch (input_mode) {
+		case set_no:	 name = "allno.config"; break;
+		case set_mod:	 name = "allmod.config"; break;
+		case set_yes:	 name = "allyes.config"; break;
+		case set_random: name = "allrandom.config"; break;
+		default: break;
+		}
+		if (!stat(name, &tmpstat))
+			conf_read_simple(name);
+		else if (!stat("all.config", &tmpstat))
+			conf_read_simple("all.config");
+		break;
 	default:
 		break;
 	}
Index: linux-2.6/scripts/kconfig/confdata.c
===================================================================
--- linux-2.6.orig/scripts/kconfig/confdata.c	2005-11-03 13:19:34.000000000 +0100
+++ linux-2.6/scripts/kconfig/confdata.c	2005-11-03 13:23:06.000000000 +0100
@@ -69,15 +69,13 @@ char *conf_get_default_confname(void)
 	return name;
 }
 
-int conf_read(const char *name)
+int conf_read_simple(const char *name)
 {
 	FILE *in = NULL;
 	char line[1024];
 	char *p, *p2;
 	int lineno = 0;
 	struct symbol *sym;
-	struct property *prop;
-	struct expr *e;
 	int i;
 
 	if (name) {
@@ -232,6 +230,19 @@ int conf_read(const char *name)
 
 	if (modules_sym)
 		sym_calc_value(modules_sym);
+	return 0;
+}
+
+int conf_read(const char *name)
+{
+	struct symbol *sym;
+	struct property *prop;
+	struct expr *e;
+	int i;
+
+	if (conf_read_simple(name))
+		return 1;
+
 	for_all_symbols(i, sym) {
 		sym_calc_value(sym);
 		if (sym_has_value(sym) && !sym_is_choice_value(sym)) {
Index: linux-2.6/scripts/kconfig/lkc_proto.h
===================================================================
--- linux-2.6.orig/scripts/kconfig/lkc_proto.h	2005-11-03 13:19:34.000000000 +0100
+++ linux-2.6/scripts/kconfig/lkc_proto.h	2005-11-03 13:23:06.000000000 +0100
@@ -2,6 +2,7 @@
 /* confdata.c */
 P(conf_parse,void,(const char *name));
 P(conf_read,int,(const char *name));
+P(conf_read_simple,int,(const char *name));
 P(conf_write,int,(const char *name));
 
 /* menu.c */
