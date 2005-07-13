Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVGMRQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVGMRQe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVGMROS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:14:18 -0400
Received: from mta03.mail.t-online.hu ([195.228.240.56]:21743 "EHLO
	mta03.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S261289AbVGMRNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:13:12 -0400
Subject: [PATCH 5/19] Kconfig I18N: lxdialog: answering
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Massimo Maiurana <maiurana@inwind.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       KernelFR <kernelfr@traduc.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
In-Reply-To: <1121273456.2975.3.camel@spirit>
References: <1121273456.2975.3.camel@spirit>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 19:13:09 +0200
Message-Id: <1121274790.2975.20.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I18N support for answering in lxdialog. This patch is useful for 
non-latin based languages.

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>
---

 scripts/lxdialog/menubox.c |   33 ++++++++++++++++++++++++++++++++-
 scripts/lxdialog/yesno.c   |   33 +++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 3 deletions(-)

diff -puN scripts/lxdialog/yesno.c~kconfig-i18n-05-lxdialog-key scripts/lxdialog/yesno.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/yesno.c~kconfig-i18n-05-lxdialog-key	2005-07-13 18:32:17.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/yesno.c	2005-07-13 18:32:17.000000000 +0200
@@ -43,10 +43,12 @@ print_buttons(WINDOW *dialog, int height
 int
 dialog_yesno (const char *title, const char *prompt, int height, int width)
 {
-    int i, x, y, key = 0, button = 0;
+    int i, x, y, key = 0, answer = 0, button = 0;
     WINDOW *dialog;
 #ifdef USE_WIDE_CURSES
-    wchar_t *wtitle;
+    wchar_t *wtitle, *yes, *Yes, *no, *No;
+#else /* USE_WIDE_CURSES */
+    const char *yes, *Yes, *no, *No;
 #endif /* USE_WIDE_CURSES */
 
     /* center dialog box on screen */
@@ -107,6 +109,33 @@ dialog_yesno (const char *title, const c
 
     while (key != ESC) {
 	key = wgetch (dialog);
+#ifdef USE_WIDE_CURSES
+	yes = to_wchar (_("y"));
+	Yes = to_wchar (_("Y"));
+	no = to_wchar (_("n"));
+	No = to_wchar (_("N"));
+#else /* USE_WIDE_CURSES */
+	yes = _("y");
+	Yes = _("Y");
+	no = _("n");
+	No = _("N");
+#endif /* USE_WIDE_CURSES */
+	if (yes && (yes[0] == key))
+	    answer = 'y';
+	if (Yes && (Yes[0] == key))
+	    answer = 'Y';
+	if (no && (no[0] == key))
+	    answer = 'n';
+	if (No && (No[0] == key))
+	    answer = 'N';
+#ifdef USE_WIDE_CURSES
+	free (yes);
+	free (Yes);
+	free (no);
+	free (No);
+#endif /* USE_WIDE_CURSES */
+	if (answer)
+	    key = answer;
 	switch (key) {
 	case 'Y':
 	case 'y':
diff -puN scripts/lxdialog/menubox.c~kconfig-i18n-05-lxdialog-key scripts/lxdialog/menubox.c
--- linux-2.6.13-rc3-i18n-kconfig/scripts/lxdialog/menubox.c~kconfig-i18n-05-lxdialog-key	2005-07-13 18:32:17.000000000 +0200
+++ linux-2.6.13-rc3-i18n-kconfig-gabaman/scripts/lxdialog/menubox.c	2005-07-13 18:32:17.000000000 +0200
@@ -189,10 +189,14 @@ dialog_menu (const char *title, const ch
 {
     int i, j, x, y, box_x, box_y;
     int key = 0, button = 0, scroll = 0, choice = 0, first_item = 0, max_choice;
+    int answer = 0;
     WINDOW *dialog, *menu;
     FILE *f;
 #ifdef USE_WIDE_CURSES
     wchar_t *wtitle, *witems, *witem2, *wcurrent;
+    wchar_t *yes, *Yes, *no, *No;
+#else /* USE_WIDE_CURSES */
+    const char *yes, *Yes, *no, *No;
 #endif /* USE_WIDE_CURSES */
 
     max_choice = MIN (menu_height, item_no);
@@ -541,7 +545,34 @@ dialog_menu (const char *title, const ch
 	    continue;		/* wait for another key press */
         }
 
-	switch (key) {
+#ifdef USE_WIDE_CURSES
+	yes = to_wchar (_("y"));
+	Yes = to_wchar (_("Y"));
+	no = to_wchar (_("n"));
+	No = to_wchar (_("N"));
+#else /* USE_WIDE_CURSES */
+	yes = _("y");
+	Yes = _("Y");
+	no = _("n");
+	No = _("N");
+#endif /* USE_WIDE_CURSES */
+	if (yes && (yes[0] == key))
+	    answer = 'y';
+	if (Yes && (Yes[0] == key))
+	    answer = 'Y';
+	if (no && (no[0] == key))
+	    answer = 'n';
+	if (No && (No[0] == key))
+	    answer = 'N';
+#ifdef USE_WIDE_CURSES
+        free (yes);
+        free (Yes);
+        free (no);
+        free (No);
+#endif /* USE_WIDE_CURSES */
+	if (answer)
+	    key = answer;
+    	switch (key) {
 	case KEY_LEFT:
 	case TAB:
 	case KEY_RIGHT:
_


