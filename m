Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030435AbVKCSye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbVKCSye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVKCSye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:54:34 -0500
Received: from mail.capitalgenomix.com ([143.247.20.203]:23229 "EHLO
	mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S1030435AbVKCSyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:54:33 -0500
Date: Thu, 3 Nov 2005 13:55:08 -0500
From: sean.fao@capitalgenomix.com
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kconfig and lxdialog, kernel 2.6.14
Message-ID: <20051103185508.GB11390@cgx-mail.capitalgenomix.com>
References: <4360FB41.8070403@capitalgenomix.com> <Pine.LNX.4.61.0510272312380.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="lxdialog.patch"
In-Reply-To: <Pine.LNX.4.61.0510272312380.1386@scrub.home>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 11:20:31PM +0200, Roman Zippel wrote:
> > @@ -92,14 +96,22 @@ int dialog_yesno(const char *title, cons
> >         case 'n':
> >             delwin(dialog);
> >             return 1;
> > -
> > +    case 'A':
> > +    case 'a':
> > +      if (btn_t == YESNOABORT)
> > +      {
> > +        delwin(dialog);
> > +        return 2;
> > +      }
> > +      break;
>
> Actually it's already possible to abort the dialog by pressing Esc. I
> don't mind the abort button, but please match the Esc behaviour and return
> -1.

Advise taken.  Personally, I don't like "magic numbers", so I'd prefer
to return an enumerated type (DIALOG_RESULT), if you don't mind.

Signed-off-by: Sean Fao <sean.fao@capitalgenomix.com>

---

diff -up linux-2.6.14/scripts/lxdialog/dialog.h linux/scripts/lxdialog/dialog.h
--- linux-2.6.14/scripts/lxdialog/dialog.h	2005-11-03 10:59:40.000000000 -0500
+++ linux/scripts/lxdialog/dialog.h	2005-11-03 10:48:51.000000000 -0500
@@ -123,6 +123,19 @@
 /* number of attributes */
 #define ATTRIBUTE_COUNT               29
 
+/* enum types */
+typedef enum {
+  YESNO,
+  YESNOABORT
+} BUTTONTYPE;
+
+typedef enum
+{
+  ABORT = -1,
+  YES,
+  NO
+} DIALOG_RESULT;
+
 /*
  * Global variables
  */
@@ -151,7 +164,8 @@ void draw_box(WINDOW * win, int y, int x
 void draw_shadow(WINDOW * win, int y, int x, int height, int width);
 
 int first_alpha(const char *string, const char *exempt);
-int dialog_yesno(const char *title, const char *prompt, int height, int width);
+int dialog_yesnoabort(const char *title, const char *prompt, int height,
+                      int width, BUTTONTYPE button_t);
 int dialog_msgbox(const char *title, const char *prompt, int height,
 		  int width, int pause);
 int dialog_textbox(const char *title, const char *file, int height, int width);
diff -up linux-2.6.14/scripts/lxdialog/lxdialog.c linux/scripts/lxdialog/lxdialog.c
--- linux-2.6.14/scripts/lxdialog/lxdialog.c	2005-11-03 10:59:38.000000000 -0500
+++ linux/scripts/lxdialog/lxdialog.c	2005-11-03 10:48:51.000000000 -0500
@@ -31,7 +31,8 @@ struct Mode {
 	jumperFn *jumper;
 };
 
-jumperFn j_menu, j_checklist, j_radiolist, j_yesno, j_textbox, j_inputbox;
+jumperFn j_menu, j_checklist, j_radiolist, j_yesno, j_yesnoabort, j_textbox,
+         j_inputbox;
 jumperFn j_msgbox, j_infobox;
 
 static struct Mode modes[] = {
@@ -39,6 +40,7 @@ static struct Mode modes[] = {
 	{"--checklist", 9, 0, 3, j_checklist},
 	{"--radiolist", 9, 0, 3, j_radiolist},
 	{"--yesno", 5, 5, 1, j_yesno},
+  {"--yesnoabort", 5, 5, 1, j_yesnoabort},
 	{"--textbox", 5, 5, 1, j_textbox},
 	{"--inputbox", 5, 6, 1, j_inputbox},
 	{"--msgbox", 5, 5, 1, j_msgbox},
@@ -150,12 +152,13 @@ static void Usage(const char *name)
 \n\
 \nBox options:\
 \n\
-\n  --menu      <text> <height> <width> <menu height> <tag1> <item1>...\
-\n  --checklist <text> <height> <width> <list height> <tag1> <item1> <status1>...\
-\n  --radiolist <text> <height> <width> <list height> <tag1> <item1> <status1>...\
-\n  --textbox   <file> <height> <width>\
-\n  --inputbox  <text> <height> <width> [<init>]\
-\n  --yesno     <text> <height> <width>\
+\n  --menu       <text> <height> <width> <menu height> <tag1> <item1>...\
+\n  --checklist  <text> <height> <width> <list height> <tag1> <item1> <status1>...\
+\n  --radiolist  <text> <height> <width> <list height> <tag1> <item1> <status1>...\
+\n  --textbox    <file> <height> <width>\
+\n  --inputbox   <text> <height> <width> [<init>]\
+\n  --yesno      <text> <height> <width>\
+\n  --yesnoabort <text> <height> <width>\
 \n", name, name);
 	exit(-1);
 }
@@ -189,7 +192,12 @@ int j_textbox(const char *t, int ac, con
 
 int j_yesno(const char *t, int ac, const char *const *av)
 {
-	return dialog_yesno(t, av[2], atoi(av[3]), atoi(av[4]));
+	return dialog_yesnoabort(t, av[2], atoi(av[3]), atoi(av[4]), YESNO);
+}
+
+int j_yesnoabort(const char *t, int ac, const char *const *av)
+{
+	return dialog_yesnoabort(t, av[2], atoi(av[3]), atoi(av[4]), YESNOABORT);
 }
 
 int j_inputbox(const char *t, int ac, const char *const *av)
diff -up linux-2.6.14/scripts/lxdialog/menubox.c linux/scripts/lxdialog/menubox.c
--- linux-2.6.14/scripts/lxdialog/menubox.c	2005-11-03 10:59:38.000000000 -0500
+++ linux/scripts/lxdialog/menubox.c	2005-11-03 10:48:56.000000000 -0500
@@ -222,7 +222,7 @@ dialog_menu(const char *title, const cha
 
 	/*
 	 * Find length of longest item in order to center menu.
-	 * Set 'choice' to default item. 
+	 * Set 'choice' to default item.
 	 */
 	item_x = 0;
 	for (i = 0; i < item_no; i++) {
Only in linux/scripts/lxdialog/: menubox.c.orig
diff -up linux-2.6.14/scripts/lxdialog/yesno.c linux/scripts/lxdialog/yesno.c
--- linux-2.6.14/scripts/lxdialog/yesno.c	2005-11-03 10:59:38.000000000 -0500
+++ linux/scripts/lxdialog/yesno.c	2005-11-03 10:48:56.000000000 -0500
@@ -24,22 +24,31 @@
 /*
  * Display termination buttons
  */
-static void print_buttons(WINDOW * dialog, int height, int width, int selected)
+static void print_buttons(WINDOW * dialog, int height, int width, int selected,
+                          BUTTONTYPE btn_t)
 {
-	int x = width / 2 - 10;
+  int x;
 	int y = height - 2;
 
+  if (btn_t == YESNO)
+    x = width / 2 - 10;
+  else
+    x = width / 3 - 7;
+
 	print_button(dialog, " Yes ", y, x, selected == 0);
 	print_button(dialog, "  No  ", y, x + 13, selected == 1);
+  if (btn_t == YESNOABORT)
+    print_button(dialog, " Abort ", y, x + 26, selected == 2);
 
 	wmove(dialog, y, x + 1 + 13 * selected);
 	wrefresh(dialog);
 }
 
 /*
- * Display a dialog box with two buttons - Yes and No
+ * Display a dialog box with specified button types
  */
-int dialog_yesno(const char *title, const char *prompt, int height, int width)
+int dialog_yesnoabort(const char *title, const char *prompt, int height,
+                      int width, BUTTONTYPE btn_t)
 {
 	int i, x, y, key = 0, button = 0;
 	WINDOW *dialog;
@@ -79,7 +88,7 @@ int dialog_yesno(const char *title, cons
 	wattrset(dialog, dialog_attr);
 	print_autowrap(dialog, prompt, width - 2, 1, 3);
 
-	print_buttons(dialog, height, width, 0);
+	print_buttons(dialog, height, width, 0, btn_t);
 
 	while (key != ESC) {
 		key = wgetch(dialog);
@@ -87,19 +96,27 @@ int dialog_yesno(const char *title, cons
 		case 'Y':
 		case 'y':
 			delwin(dialog);
-			return 0;
+			return YES;
 		case 'N':
 		case 'n':
 			delwin(dialog);
-			return 1;
-
+			return NO;
+    case 'A':
+    case 'a':
+      if (btn_t == YESNOABORT)
+      {
+        delwin(dialog);
+        return ABORT;
+      }
+      break;
 		case TAB:
 		case KEY_LEFT:
 		case KEY_RIGHT:
+      /* Selections available are based on # of buttons on dialog */
 			button = ((key == KEY_LEFT ? --button : ++button) < 0)
-			    ? 1 : (button > 1 ? 0 : button);
+			    ? (btn_t + 1) : (button > (btn_t + 1) ? 0 : button);
 
-			print_buttons(dialog, height, width, button);
+			print_buttons(dialog, height, width, button, btn_t);
 			wrefresh(dialog);
 			break;
 		case ' ':
@@ -112,5 +129,5 @@ int dialog_yesno(const char *title, cons
 	}
 
 	delwin(dialog);
-	return -1;		/* ESC pressed */
+	return ABORT;		/* ESC pressed */
 }
