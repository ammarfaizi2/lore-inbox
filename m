Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWGYHC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWGYHC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWGYHC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:02:29 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:15546 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751479AbWGYHC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:02:28 -0400
Date: Tue, 25 Jul 2006 09:02:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH v2 2/3] kconfig/lxdialog: add support for color themes and add blackbg theme
Message-ID: <20060725070207.GB3033@mars.ravnborg.org>
References: <20060725065640.GA2685@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060725065640.GA2685@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From cd0125d4c9bc9c2192a265989b1c60e94cd398b3 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: Mon, 24 Jul 2006 22:04:04 +0200
Subject: [PATCH] kconfig/lxdialog: add support for color themes and add blackbg theme

The blackbg theme was originally made by: Han Boetes
It was copied from a patch by "Randy.Dunlap" <rdunlap@xenotime.net>
which was also the inspiration source for the color theme support.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 scripts/kconfig/lxdialog/util.c |   73 ++++++++++++++++++++++++++++++++++++---
 scripts/kconfig/mconf.c         |   15 +++++++-
 2 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/scripts/kconfig/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
index 08f98b1..358f9cc 100644
--- a/scripts/kconfig/lxdialog/util.c
+++ b/scripts/kconfig/lxdialog/util.c
@@ -96,6 +96,66 @@ static void set_classic_theme(void)
 	DLG_COLOR(darrow,                COLOR_GREEN,  COLOR_WHITE,  true);
 }
 
+static void set_blackbg_theme(void)
+{
+	DLG_COLOR(screen, COLOR_RED,   COLOR_BLACK, true);
+	DLG_COLOR(shadow, COLOR_BLACK, COLOR_BLACK, false);
+	DLG_COLOR(dialog, COLOR_WHITE, COLOR_BLACK, false);
+	DLG_COLOR(title,  COLOR_RED,   COLOR_BLACK, false);
+	DLG_COLOR(border, COLOR_BLACK, COLOR_BLACK, true);
+
+	DLG_COLOR(button_active,         COLOR_YELLOW, COLOR_RED,   false);
+	DLG_COLOR(button_inactive,       COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(button_key_active,     COLOR_YELLOW, COLOR_RED,   true);
+	DLG_COLOR(button_key_inactive,   COLOR_RED,    COLOR_BLACK, false);
+	DLG_COLOR(button_label_active,   COLOR_WHITE,  COLOR_RED,   false);
+	DLG_COLOR(button_label_inactive, COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_COLOR(inputbox,         COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(inputbox_border,  COLOR_YELLOW, COLOR_BLACK, false);
+
+	DLG_COLOR(searchbox,        COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(searchbox_title,  COLOR_YELLOW, COLOR_BLACK, true);
+	DLG_COLOR(searchbox_border, COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_COLOR(position_indicator, COLOR_RED, COLOR_BLACK,  false);
+
+	DLG_COLOR(menubox,          COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(menubox_border,   COLOR_BLACK,  COLOR_BLACK, true);
+
+	DLG_COLOR(item,             COLOR_WHITE, COLOR_BLACK, false);
+	DLG_COLOR(item_selected,    COLOR_WHITE, COLOR_RED,   false);
+
+	DLG_COLOR(tag,              COLOR_RED,    COLOR_BLACK, false);
+	DLG_COLOR(tag_selected,     COLOR_YELLOW, COLOR_RED,   true);
+	DLG_COLOR(tag_key,          COLOR_RED,    COLOR_BLACK, false);
+	DLG_COLOR(tag_key_selected, COLOR_YELLOW, COLOR_RED,   true);
+
+	DLG_COLOR(check,            COLOR_YELLOW, COLOR_BLACK, false);
+	DLG_COLOR(check_selected,   COLOR_YELLOW, COLOR_RED,   true);
+
+	DLG_COLOR(uarrow, COLOR_RED, COLOR_BLACK, false);
+	DLG_COLOR(darrow, COLOR_RED, COLOR_BLACK, false);
+}
+
+/*
+ * Select color theme
+ */
+static int set_theme(const char *theme)
+{
+	int use_color = 1;
+	if (!theme)
+		set_classic_theme();
+	else if (strcmp(theme, "classic") == 0)
+		set_classic_theme();
+	else if (strcmp(theme, "blackbg") == 0)
+		set_blackbg_theme();
+	else if (strcmp(theme, "mono") == 0)
+		use_color = 0;
+
+	return use_color;
+}
+
 static void init_one_color(struct dialog_color *color)
 {
 	static int pair = 0;
@@ -144,12 +204,13 @@ static void init_dialog_colors(void)
 /*
  * Setup for color display
  */
-static void color_setup(void)
+static void color_setup(const char *theme)
 {
-	if (has_colors()) {	/* Terminal supports color? */
-		start_color();
-		set_classic_theme();
-		init_dialog_colors();
+	if (set_theme(theme)) {
+		if (has_colors()) {	/* Terminal supports color? */
+			start_color();
+			init_dialog_colors();
+		}
 	}
 	else
 	{
@@ -198,7 +259,7 @@ void init_dialog(void)
 	keypad(stdscr, TRUE);
 	cbreak();
 	noecho();
-	color_setup();
+	color_setup(getenv("MENUCONFIG_COLOR"));
 	dialog_clear();
 }
 
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 7f97319..ed22b13 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -159,7 +159,20 @@ static const char mconf_readme[] = N_(
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
+" mono       => selects colors suitable for monochrome displays\n"
+" blackbg    => selects a color scheme with black background\n"
+" classic    => theme with blue background. The classic look. (default)\n"
+"\n"),
 menu_instructions[] = N_(
 	"Arrow keys navigate the menu.  "
 	"<Enter> selects submenus --->.  "
-- 
1.4.1.rc2.gfc04

