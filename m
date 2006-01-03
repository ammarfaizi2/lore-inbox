Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWACNdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWACNdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWACNdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:33:43 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27909 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932340AbWACNZe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:34 -0500
Subject: [PATCH 04/26] kconfig: Add print_title helper in lxdialog
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947251067@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1132439886 +0100

Simplify check for long title and use a helper function in util.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/lxdialog/checklist.c |   15 +--------------
 scripts/lxdialog/dialog.h    |    1 +
 scripts/lxdialog/inputbox.c  |   15 +--------------
 scripts/lxdialog/menubox.c   |   15 +--------------
 scripts/lxdialog/msgbox.c    |   14 +-------------
 scripts/lxdialog/textbox.c   |   14 +-------------
 scripts/lxdialog/util.c      |   14 ++++++++++++++
 scripts/lxdialog/yesno.c     |   15 +--------------
 8 files changed, 21 insertions(+), 82 deletions(-)

fa7009d5b59b8acd8071f7b3057d36eeeaf08146
diff --git a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
index ae40a2b..3fb681f 100644
--- a/scripts/lxdialog/checklist.c
+++ b/scripts/lxdialog/checklist.c
@@ -158,20 +158,7 @@ int dialog_checklist(const char *title, 
 	wattrset(dialog, dialog_attr);
 	waddch(dialog, ACS_RTEE);
 
-	if (title != NULL && strlen(title) >= width - 2) {
-		/* truncate long title -- mec */
-		char *title2 = malloc(width - 2 + 1);
-		memcpy(title2, title, width - 2);
-		title2[width - 2] = '\0';
-		title = title2;
-	}
-
-	if (title != NULL) {
-		wattrset(dialog, title_attr);
-		mvwaddch(dialog, 0, (width - strlen(title)) / 2 - 1, ' ');
-		waddstr(dialog, (char *)title);
-		waddch(dialog, ' ');
-	}
+	print_title(dialog, title, width);
 
 	wattrset(dialog, dialog_attr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
diff --git a/scripts/lxdialog/dialog.h b/scripts/lxdialog/dialog.h
index 3cf3d35..f882204 100644
--- a/scripts/lxdialog/dialog.h
+++ b/scripts/lxdialog/dialog.h
@@ -145,6 +145,7 @@ void dialog_clear(void);
 void color_setup(void);
 void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
 void print_button(WINDOW * win, const char *label, int y, int x, int selected);
+void print_title(WINDOW *dialog, const char *title, int width);
 void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
 	      chtype border);
 void draw_shadow(WINDOW * win, int y, int x, int height, int width);
diff --git a/scripts/lxdialog/inputbox.c b/scripts/lxdialog/inputbox.c
index bc135c7..7795037 100644
--- a/scripts/lxdialog/inputbox.c
+++ b/scripts/lxdialog/inputbox.c
@@ -66,20 +66,7 @@ int dialog_inputbox(const char *title, c
 	wattrset(dialog, dialog_attr);
 	waddch(dialog, ACS_RTEE);
 
-	if (title != NULL && strlen(title) >= width - 2) {
-		/* truncate long title -- mec */
-		char *title2 = malloc(width - 2 + 1);
-		memcpy(title2, title, width - 2);
-		title2[width - 2] = '\0';
-		title = title2;
-	}
-
-	if (title != NULL) {
-		wattrset(dialog, title_attr);
-		mvwaddch(dialog, 0, (width - strlen(title)) / 2 - 1, ' ');
-		waddstr(dialog, (char *)title);
-		waddch(dialog, ' ');
-	}
+	print_title(dialog, title, width);
 
 	wattrset(dialog, dialog_attr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index ff3a617..ebfe6a3 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -189,20 +189,7 @@ int dialog_menu(const char *title, const
 	wbkgdset(dialog, dialog_attr & A_COLOR);
 	waddch(dialog, ACS_RTEE);
 
-	if (title != NULL && strlen(title) >= width - 2) {
-		/* truncate long title -- mec */
-		char *title2 = malloc(width - 2 + 1);
-		memcpy(title2, title, width - 2);
-		title2[width - 2] = '\0';
-		title = title2;
-	}
-
-	if (title != NULL) {
-		wattrset(dialog, title_attr);
-		mvwaddch(dialog, 0, (width - strlen(title)) / 2 - 1, ' ');
-		waddstr(dialog, (char *)title);
-		waddch(dialog, ' ');
-	}
+	print_title(dialog, title, width);
 
 	wattrset(dialog, dialog_attr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
diff --git a/scripts/lxdialog/msgbox.c b/scripts/lxdialog/msgbox.c
index b394057..7323f54 100644
--- a/scripts/lxdialog/msgbox.c
+++ b/scripts/lxdialog/msgbox.c
@@ -42,20 +42,8 @@ int dialog_msgbox(const char *title, con
 
 	draw_box(dialog, 0, 0, height, width, dialog_attr, border_attr);
 
-	if (title != NULL && strlen(title) >= width - 2) {
-		/* truncate long title -- mec */
-		char *title2 = malloc(width - 2 + 1);
-		memcpy(title2, title, width - 2);
-		title2[width - 2] = '\0';
-		title = title2;
-	}
+	print_title(dialog, title, width);
 
-	if (title != NULL) {
-		wattrset(dialog, title_attr);
-		mvwaddch(dialog, 0, (width - strlen(title)) / 2 - 1, ' ');
-		waddstr(dialog, (char *)title);
-		waddch(dialog, ' ');
-	}
 	wattrset(dialog, dialog_attr);
 	print_autowrap(dialog, prompt, width - 2, 1, 2);
 
diff --git a/scripts/lxdialog/textbox.c b/scripts/lxdialog/textbox.c
index fa8d92e..77848bb 100644
--- a/scripts/lxdialog/textbox.c
+++ b/scripts/lxdialog/textbox.c
@@ -103,20 +103,8 @@ int dialog_textbox(const char *title, co
 	wbkgdset(dialog, dialog_attr & A_COLOR);
 	waddch(dialog, ACS_RTEE);
 
-	if (title != NULL && strlen(title) >= width - 2) {
-		/* truncate long title -- mec */
-		char *title2 = malloc(width - 2 + 1);
-		memcpy(title2, title, width - 2);
-		title2[width - 2] = '\0';
-		title = title2;
-	}
+	print_title(dialog, title, width);
 
-	if (title != NULL) {
-		wattrset(dialog, title_attr);
-		mvwaddch(dialog, 0, (width - strlen(title)) / 2 - 1, ' ');
-		waddstr(dialog, (char *)title);
-		waddch(dialog, ' ');
-	}
 	print_button(dialog, " Exit ", height - 2, width / 2 - 4, TRUE);
 	wnoutrefresh(dialog);
 	getyx(dialog, cur_y, cur_x);	/* Save cursor position */
diff --git a/scripts/lxdialog/util.c b/scripts/lxdialog/util.c
index ce41147..f82cebb 100644
--- a/scripts/lxdialog/util.c
+++ b/scripts/lxdialog/util.c
@@ -177,6 +177,20 @@ void end_dialog(void)
 	endwin();
 }
 
+/* Print the title of the dialog. Center the title and truncate
+ * tile if wider than dialog (- 2 chars).
+ **/
+void print_title(WINDOW *dialog, const char *title, int width)
+{
+	if (title) {
+		int tlen = MIN(width - 2, strlen(title));
+		wattrset(dialog, title_attr);
+		mvwaddch(dialog, 0, (width - tlen) / 2 - 1, ' ');
+		mvwaddnstr(dialog, 0, (width - tlen)/2, title, tlen);
+		waddch(dialog, ' ');
+	}
+}
+
 /*
  * Print a string of text in a window, automatically wrap around to the
  * next line if the string is too long to fit on one line. Newline
diff --git a/scripts/lxdialog/yesno.c b/scripts/lxdialog/yesno.c
index 84f3e8e..cb2568a 100644
--- a/scripts/lxdialog/yesno.c
+++ b/scripts/lxdialog/yesno.c
@@ -61,20 +61,7 @@ int dialog_yesno(const char *title, cons
 	wattrset(dialog, dialog_attr);
 	waddch(dialog, ACS_RTEE);
 
-	if (title != NULL && strlen(title) >= width - 2) {
-		/* truncate long title -- mec */
-		char *title2 = malloc(width - 2 + 1);
-		memcpy(title2, title, width - 2);
-		title2[width - 2] = '\0';
-		title = title2;
-	}
-
-	if (title != NULL) {
-		wattrset(dialog, title_attr);
-		mvwaddch(dialog, 0, (width - strlen(title)) / 2 - 1, ' ');
-		waddstr(dialog, (char *)title);
-		waddch(dialog, ' ');
-	}
+	print_title(dialog, title, width);
 
 	wattrset(dialog, dialog_attr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
-- 
1.0.6

