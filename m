Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWGXLiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWGXLiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 07:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWGXLiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 07:38:55 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:41446 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932119AbWGXLiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 07:38:54 -0400
Date: Mon, 24 Jul 2006 13:38:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/3] kconfig/lxdialog: add support for color themes and add blackbg theme
Message-ID: <20060724113833.GC22806@mars.ravnborg.org>
References: <20060724113641.GA22806@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060724113641.GA22806@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 7ba8d280514c5caf48d36c0f02d9be139ec71e58 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Mon, 24 Jul 2006 12:55:29 +0200
Subject: [PATCH] kconfig/lxdialog: add support for color themes and add blackbg theme

The blackbg color scheme is made by: Han Boetes
To use the blackbg color theme use:
make MENUCONFIG_COLOR=blackbg menuconfig

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/dialog.h |    2 -
 scripts/kconfig/lxdialog/util.c   |   85 ++++++++++++++++++++++++++++++-------
 scripts/kconfig/mconf.c           |   14 ++++++
 3 files changed, 82 insertions(+), 19 deletions(-)

diff --git a/scripts/kconfig/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
index aee89b3..d16bd6e 100644
--- a/scripts/kconfig/lxdialog/dialog.h
+++ b/scripts/kconfig/lxdialog/dialog.h
@@ -135,7 +135,6 @@ extern struct dlg_clr dlg_clr;
 /*
  * Global variables
  */
-extern bool use_colors;
 extern bool use_shadow;
 
 extern const char *backtitle;
@@ -150,7 +149,6 @@ void init_dialog(void);
 void end_dialog(void);
 void attr_clear(WINDOW * win, int height, int width, chtype attr);
 void dialog_clear(void);
-void color_setup(void);
 void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
 void print_button(WINDOW * win, const char *label, int y, int x, int selected);
 void print_title(WINDOW *dialog, const char *title, int width);
diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index b3cb449..e3b1462 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -21,9 +21,6 @@
 
 #include "dialog.h"
 
-/* use colors by default? */
-bool use_colors = 1;
-
 const char *backtitle = NULL;
 
 /* Default color scheme. atr is set for mono display */
@@ -60,6 +57,51 @@ struct dlg_clr dlg_clr = {
  .darrow                = DLG_CLR(A_BOLD,    COLOR_GREEN,  COLOR_WHITE,  true),
 };
 
+#define DLG_MODIFY(dlg,f,b,h) dlg_clr.dlg.fg = f; dlg_clr.dlg.bg = b; \
+                              dlg_clr.dlg.hl = h;
+/* Modify dlg_clr to selected theme */
+static void set_blackbg_theme(void)
+{
+	DLG_MODIFY(screen, COLOR_RED,   COLOR_BLACK, true);
+	DLG_MODIFY(shadow, COLOR_BLACK, COLOR_BLACK, false);
+	DLG_MODIFY(dialog, COLOR_WHITE, COLOR_BLACK, false);
+	DLG_MODIFY(title,  COLOR_RED,   COLOR_BLACK, false);
+	DLG_MODIFY(border, COLOR_BLACK, COLOR_BLACK, true);
+
+	DLG_MODIFY(button_active,         COLOR_YELLOW, COLOR_RED,   false);
+	DLG_MODIFY(button_inactive,       COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_MODIFY(button_key_active,     COLOR_YELLOW, COLOR_RED,   true);
+	DLG_MODIFY(button_key_inactive,   COLOR_RED,    COLOR_BLACK, false);
+	DLG_MODIFY(button_label_active,   COLOR_WHITE,  COLOR_RED,   false);
+	DLG_MODIFY(button_label_inactive, COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_MODIFY(inputbox,         COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_MODIFY(inputbox_border,  COLOR_YELLOW, COLOR_BLACK, false);
+
+	DLG_MODIFY(searchbox,        COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_MODIFY(searchbox_title,  COLOR_YELLOW, COLOR_BLACK, true);
+	DLG_MODIFY(searchbox_border, COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_MODIFY(position_indicator, COLOR_RED, COLOR_BLACK,  false);
+
+	DLG_MODIFY(menubox,          COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_MODIFY(menubox_border,   COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_MODIFY(item,             COLOR_WHITE, COLOR_BLACK, false);
+	DLG_MODIFY(item_selected,    COLOR_WHITE, COLOR_RED,   false);
+
+	DLG_MODIFY(tag,              COLOR_RED,    COLOR_BLACK, false);
+	DLG_MODIFY(tag_selected,     COLOR_YELLOW, COLOR_RED,   true);
+	DLG_MODIFY(tag_key,          COLOR_RED,    COLOR_BLACK, false);
+	DLG_MODIFY(tag_key_selected, COLOR_YELLOW, COLOR_RED,   true);
+
+	DLG_MODIFY(check,            COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_MODIFY(check_selected,   COLOR_YELLOW, COLOR_RED,   true);
+
+	DLG_MODIFY(uarrow, COLOR_RED, COLOR_BLACK, false);
+	DLG_MODIFY(darrow, COLOR_RED, COLOR_BLACK, false);
+}
+
 static void init_one_color(struct dialog_color *color)
 {
 	static int pair = 0;
@@ -106,6 +148,29 @@ static void init_dialog_colors(void)
 	init_one_color(&dlg_clr.darrow);
 }
 
+static int set_color_theme(const char *theme)
+{
+	int use_color = 1;
+	if (!strncasecmp (theme, "blackbg", sizeof("blackbg")))
+		set_blackbg_theme();
+	else if (!strncasecmp(theme, "mono", sizeof("mono")))
+		use_color = 0;
+	return use_color;
+}
+
+/*
+ * Setup for color display
+ */
+static void color_setup(const char *theme)
+{
+	if (set_color_theme(theme))
+		if (has_colors()) {	/* Terminal supports color? */
+			start_color();
+			init_dialog_colors();
+		}
+}
+
+
 /*
  * Set window to attribute 'attr'
  */
@@ -148,24 +213,12 @@ void init_dialog(void)
 	cbreak();
 	noecho();
 
-	if (use_colors)		/* Set up colors */
-		color_setup();
+	color_setup(getenv("MENUCONFIG_COLOR"));
 
 	dialog_clear();
 }
 
 /*
- * Setup for color display
- */
-void color_setup(void)
-{
-	if (has_colors()) {	/* Terminal supports color? */
-		start_color();
-		init_dialog_colors();
-	}
-}
-
-/*
  * End using dialog functions.
  */
 void end_dialog(void)
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 7f97319..d518161 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -159,7 +159,19 @@ static const char mconf_readme[] = N_(
 "\n"
 "Note that this mode can eventually be a little more CPU expensive\n"
 "(especially with a larger number of unrolled categories) than the\n"
-"default mode.\n"),
+"default mode.\n"
+"\n"
+"Different color themes available\n"
+"--------------------------------\n"
+"It is possible to select different color themes using the variable\n"
+"MENUCONFIG_COLOR. To select a theme use:\n"
+"\n"
+"make MENUCONFIG_COLOR=<theme> menuconfig\n"
+"\n"
+"Available themes are\n"
+" mono    => selects colors suitable for monochrome displays\n"
+" blackbg => selects a color scheme with black background\n"
+"\n"),
 menu_instructions[] = N_(
 	"Arrow keys navigate the menu.  "
 	"<Enter> selects submenus --->.  "
-- 
1.4.1.rc2.gfc04

