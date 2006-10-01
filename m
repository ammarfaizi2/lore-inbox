Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751647AbWJAKwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWJAKwv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 06:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWJAKwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 06:52:50 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:10141 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S1751528AbWJAKwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 06:52:49 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2/13] kconfig/lxdialog: add support for color themes and add blackbg theme
Reply-To: sam@ravnborg.org
Date: Sun, 01 Oct 2006 12:52:35 +0200
Message-Id: <1159699967600-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159699966691-git-send-email-sam@ravnborg.org>
References: <1159699966691-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

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
1.4.1

