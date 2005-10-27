Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVJ0QK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVJ0QK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 12:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbVJ0QK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 12:10:27 -0400
Received: from mail.capitalgenomix.com ([143.247.20.203]:33249 "EHLO
	mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S1751178AbVJ0QK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 12:10:26 -0400
Message-ID: <4360FB41.8070403@capitalgenomix.com>
Date: Thu, 27 Oct 2005 12:07:29 -0400
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: [PATCH 2/3] kconfig and lxdialog, kernel 2.6.13.4
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a functionality modification to lxdialog to add support 
for an "Abort" button in *addition* to the standard "Yes" and "No" 
buttons on the "yesno" dialog.  The intended purpose of this patch is to 
give users the ability to abort their last requested action.

Signed-off-by: Sean E. Fao <sean.fao@capitalgenomix.com>

diff -up linux-2.6.13.4/scripts/lxdialog/dialog.h 
linux/scripts/lxdialog/dialog.h
--- linux-2.6.13.4/scripts/lxdialog/dialog.h    2005-10-27 
09:21:46.000000000 -0500
+++ linux/scripts/lxdialog/dialog.h    2005-10-26 16:03:24.000000000 -0500
@@ -123,6 +123,12 @@
 /* number of attributes */
 #define ATTRIBUTE_COUNT               29
 
+/* enum types */
+typedef enum {
+  YESNO,
+  YESNOABORT
+} BUTTONTYPE;
+
 /*
  * Global variables
  */
@@ -151,7 +157,8 @@ void draw_box(WINDOW * win, int y, int x
 void draw_shadow(WINDOW * win, int y, int x, int height, int width);
 
 int first_alpha(const char *string, const char *exempt);
-int dialog_yesno(const char *title, const char *prompt, int height, int 
width);
+int dialog_yesnoabort(const char *title, const char *prompt, int height,
+                      int width, BUTTONTYPE button_t);
 int dialog_msgbox(const char *title, const char *prompt, int height,
           int width, int pause);
 int dialog_textbox(const char *title, const char *file, int height, int 
width);
diff -up linux-2.6.13.4/scripts/lxdialog/lxdialog.c 
linux/scripts/lxdialog/lxdialog.c
--- linux-2.6.13.4/scripts/lxdialog/lxdialog.c    2005-10-27 
09:21:45.000000000 -0500
+++ linux/scripts/lxdialog/lxdialog.c    2005-10-26 16:04:54.000000000 -0500
@@ -31,7 +31,8 @@ struct Mode {
     jumperFn *jumper;
 };
 
-jumperFn j_menu, j_checklist, j_radiolist, j_yesno, j_textbox, j_inputbox;
+jumperFn j_menu, j_checklist, j_radiolist, j_yesno, j_yesnoabort, 
j_textbox,
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
-\n  --checklist <text> <height> <width> <list height> <tag1> <item1> 
<status1>...\
-\n  --radiolist <text> <height> <width> <list height> <tag1> <item1> 
<status1>...\
-\n  --textbox   <file> <height> <width>\
-\n  --inputbox  <text> <height> <width> [<init>]\
-\n  --yesno     <text> <height> <width>\
+\n  --menu       <text> <height> <width> <menu height> <tag1> <item1>...\
+\n  --checklist  <text> <height> <width> <list height> <tag1> <item1> 
<status1>...\
+\n  --radiolist  <text> <height> <width> <list height> <tag1> <item1> 
<status1>...\
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
-    return dialog_yesno(t, av[2], atoi(av[3]), atoi(av[4]));
+    return dialog_yesnoabort(t, av[2], atoi(av[3]), atoi(av[4]), YESNO);
+}
+
+int j_yesnoabort(const char *t, int ac, const char *const *av)
+{
+    return dialog_yesnoabort(t, av[2], atoi(av[3]), atoi(av[4]), 
YESNOABORT);
 }
 
 int j_inputbox(const char *t, int ac, const char *const *av)
diff -up linux-2.6.13.4/scripts/lxdialog/yesno.c 
linux/scripts/lxdialog/yesno.c
--- linux-2.6.13.4/scripts/lxdialog/yesno.c    2005-10-27 
09:21:45.000000000 -0500
+++ linux/scripts/lxdialog/yesno.c    2005-10-26 19:18:25.000000000 -0500
@@ -24,22 +24,26 @@
 /*
  * Display termination buttons
  */
-static void print_buttons(WINDOW * dialog, int height, int width, int 
selected)
+static void print_buttons(WINDOW * dialog, int height, int width, int 
selected,
+                          BUTTONTYPE btn_t)
 {
-    int x = width / 2 - 10;
+    int x = width / (btn_t == YESNO ? 2 : 3) - 10;
     int y = height - 2;
 
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
-int dialog_yesno(const char *title, const char *prompt, int height, int 
width)
+int dialog_yesnoabort(const char *title, const char *prompt, int height,
+                      int width, BUTTONTYPE btn_t)
 {
     int i, x, y, key = 0, button = 0;
     WINDOW *dialog;
@@ -79,7 +83,7 @@ int dialog_yesno(const char *title, cons
     wattrset(dialog, dialog_attr);
     print_autowrap(dialog, prompt, width - 2, 1, 3);
 
-    print_buttons(dialog, height, width, 0);
+    print_buttons(dialog, height, width, 0, btn_t);
 
     while (key != ESC) {
         key = wgetch(dialog);
@@ -92,14 +96,22 @@ int dialog_yesno(const char *title, cons
         case 'n':
             delwin(dialog);
             return 1;
-
+    case 'A':
+    case 'a':
+      if (btn_t == YESNOABORT)
+      {
+        delwin(dialog);
+        return 2;
+      }
+      break;
         case TAB:
         case KEY_LEFT:
         case KEY_RIGHT:
+      /* Selections available are based on # of buttons on dialog */
             button = ((key == KEY_LEFT ? --button : ++button) < 0)
-                ? 1 : (button > 1 ? 0 : button);
+                ? (btn_t + 1) : (button > (btn_t + 1) ? 0 : button);
 
-            print_buttons(dialog, height, width, button);
+            print_buttons(dialog, height, width, button, btn_t);
             wrefresh(dialog);
             break;
         case ' ':

-- 
Sean

