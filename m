Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVKUWjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVKUWjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVKUWjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:39:20 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:48226 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1751191AbVKUWjS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:39:18 -0500
Date: Mon, 21 Nov 2005 23:39:24 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: [3/7] kconfig: Add print_title helper in lxdialog
Message-ID: <20051121223924.GD19157@mars.ravnborg.org>
References: <20051121223702.GA19157@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121223702.GA19157@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    kconfig: Add print_title helper in lxdialog
    
    Simplify check for long title and use a helper function in util.c
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/scripts/lxdialog/checklist.c b/scripts/lxdialog/checklist.c
index ae40a2b..3fb681f 100644
--- a/scripts/lxdialog/checklist.c
+++ b/scripts/lxdialog/checklist.c
@@ -156,24 +156,11 @@ int dialog_checklist(const char *title, 
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
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
 
 	list_width = width - 6;
diff --git a/scripts/lxdialog/dialog.h b/scripts/lxdialog/dialog.h
index 3cf3d35..f882204 100644
--- a/scripts/lxdialog/dialog.h
+++ b/scripts/lxdialog/dialog.h
@@ -143,10 +143,11 @@ void end_dialog(void);
 void attr_clear(WINDOW * win, int height, int width, chtype attr);
 void dialog_clear(void);
 void color_setup(void);
 void print_autowrap(WINDOW * win, const char *prompt, int width, int y, int x);
 void print_button(WINDOW * win, const char *label, int y, int x, int selected);
+void print_title(WINDOW *dialog, const char *title, int width);
 void draw_box(WINDOW * win, int y, int x, int height, int width, chtype box,
 	      chtype border);
 void draw_shadow(WINDOW * win, int y, int x, int height, int width);
 
 int first_alpha(const char *string, const char *exempt);
diff --git a/scripts/lxdialog/inputbox.c b/scripts/lxdialog/inputbox.c
index bc135c7..7795037 100644
--- a/scripts/lxdialog/inputbox.c
+++ b/scripts/lxdialog/inputbox.c
@@ -64,24 +64,11 @@ int dialog_inputbox(const char *title, c
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
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
 
 	/* Draw the input field box */
diff --git a/scripts/lxdialog/menubox.c b/scripts/lxdialog/menubox.c
index ff3a617..ebfe6a3 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/lxdialog/menubox.c
@@ -187,24 +187,11 @@ int dialog_menu(const char *title, const
 		waddch(dialog, ACS_HLINE);
 	wattrset(dialog, dialog_attr);
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
 
 	menu_width = width - 6;
diff --git a/scripts/lxdialog/msgbox.c b/scripts/lxdialog/msgbox.c
index b394057..7323f54 100644
--- a/scripts/lxdialog/msgbox.c
+++ b/scripts/lxdialog/msgbox.c
@@ -40,24 +40,12 @@ int dialog_msgbox(const char *title, con
 	dialog = newwin(height, width, y, x);
 	keypad(dialog, TRUE);
 
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
 
 	if (pause) {
 		wattrset(dialog, border_attr);
diff --git a/scripts/lxdialog/textbox.c b/scripts/lxdialog/textbox.c
index fa8d92e..77848bb 100644
--- a/scripts/lxdialog/textbox.c
+++ b/scripts/lxdialog/textbox.c
@@ -101,24 +101,12 @@ int dialog_textbox(const char *title, co
 		waddch(dialog, ACS_HLINE);
 	wattrset(dialog, dialog_attr);
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
 
 	/* Print first page of text */
diff --git a/scripts/lxdialog/util.c b/scripts/lxdialog/util.c
index ce41147..f82cebb 100644
--- a/scripts/lxdialog/util.c
+++ b/scripts/lxdialog/util.c
@@ -175,10 +175,24 @@ void color_setup(void)
 void end_dialog(void)
 {
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
  * characters '\n' are replaced by spaces.  We start on a new line
  * if there is no room for at least 4 nonblanks following a double-space.
diff --git a/scripts/lxdialog/yesno.c b/scripts/lxdialog/yesno.c
index 84f3e8e..cb2568a 100644
--- a/scripts/lxdialog/yesno.c
+++ b/scripts/lxdialog/yesno.c
@@ -59,24 +59,11 @@ int dialog_yesno(const char *title, cons
 	for (i = 0; i < width - 2; i++)
 		waddch(dialog, ACS_HLINE);
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
 
 	print_buttons(dialog, height, width, 0);
