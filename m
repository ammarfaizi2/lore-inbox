Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTDHXRW (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 19:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbTDHXRW (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 19:17:22 -0400
Received: from mako.theneteffect.com ([63.97.58.10]:51718 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id S262577AbTDHXRO (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 19:17:14 -0400
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200304082328.h38NSj423007@mako.theneteffect.com>
Subject: [PATCH] fix menuconfig help for choice menus
To: torvalds@transmeta.com
Date: Tue, 8 Apr 2003 18:28:44 -0500 (CDT)
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Menuconfig currently doesn't show the help texts that go along with config
options inside a choice menu.  (A good example is the "Processor family"
submenu - none of the per-processor help texts show up.)

The following patch fixes this - menuconfig now shows the help text for
the config option under the cursor.

	M


diff -urN linux-2.5.67/scripts/kconfig/mconf.c linux-2.5.67-mod/scripts/kconfig/mconf.c
--- linux-2.5.67/scripts/kconfig/mconf.c	Fri Mar 21 13:25:48 2003
+++ linux-2.5.67-mod/scripts/kconfig/mconf.c	Tue Apr  8 15:34:00 2003
@@ -627,7 +627,8 @@
 			sym_set_tristate_value(menu->sym, yes);
 			return;
 		case 1:
-			show_help(menu);
+			if (sscanf(input_buf, "%p", &child) == 1)
+				show_help(child);
 			break;
 		case 255:
 			return;
diff -urN linux-2.5.67/scripts/lxdialog/checklist.c linux-2.5.67-mod/scripts/lxdialog/checklist.c
--- linux-2.5.67/scripts/lxdialog/checklist.c	Tue Mar  4 21:29:18 2003
+++ linux-2.5.67-mod/scripts/lxdialog/checklist.c	Tue Apr  8 17:52:03 2003
@@ -302,6 +302,21 @@
 	case 'H':
 	case 'h':
 	case '?':
+	    if (!status[scroll + choice]) {
+		for (i = 0; i < item_no; i++)
+		    status[i] = 0;
+		status[scroll + choice] = 1;
+		for (i = 0; i < max_choice; i++)
+		    print_item (list, items[(scroll + i) * 3 + 1],
+				status[scroll + i], i, i == choice);
+	    }
+	    wnoutrefresh (list);
+	    wrefresh (dialog);
+
+	    for (i = 0; i < item_no; i++) {
+		if (status[i])
+		    fprintf (stderr, "%s", items[i * 3]);
+	    }
 	    delwin (dialog);
 	    free (status);
 	    return 1;
@@ -318,36 +333,33 @@
 	case 's':
 	case ' ':
 	case '\n':
-	    if (!button) {
-		if (flag == FLAG_CHECK) {
-		    status[scroll + choice] = !status[scroll + choice];
-		    wmove (list, choice, check_x);
-		    wattrset (list, check_selected_attr);
-		    wprintw (list, "[%c]", status[scroll + choice] ? 'X' : ' ');
-		} else {
-		    if (!status[scroll + choice]) {
-			for (i = 0; i < item_no; i++)
-			    status[i] = 0;
-			status[scroll + choice] = 1;
-			for (i = 0; i < max_choice; i++)
-			    print_item (list, items[(scroll + i) * 3 + 1],
-					status[scroll + i], i, i == choice);
-		    }
+	    if (flag == FLAG_CHECK) {
+		status[scroll + choice] = !status[scroll + choice];
+		wmove (list, choice, check_x);
+		wattrset (list, check_selected_attr);
+		wprintw (list, "[%c]", status[scroll + choice] ? 'X' : ' ');
+	    } else {
+		if (!status[scroll + choice]) {
+		    for (i = 0; i < item_no; i++)
+			status[i] = 0;
+		    status[scroll + choice] = 1;
+		    for (i = 0; i < max_choice; i++)
+			print_item (list, items[(scroll + i) * 3 + 1],
+				    status[scroll + i], i, i == choice);
 		}
-		wnoutrefresh (list);
-		wrefresh (dialog);
-            
-		for (i = 0; i < item_no; i++) {
-		    if (status[i]) {
-			if (flag == FLAG_CHECK) {
-			    fprintf (stderr, "\"%s\" ", items[i * 3]);
-			} else {
-			    fprintf (stderr, "%s", items[i * 3]);
-			}
+	    }
+	    wnoutrefresh (list);
+	    wrefresh (dialog);
 
+	    for (i = 0; i < item_no; i++) {
+		if (status[i]) {
+		    if (flag == FLAG_CHECK) {
+			fprintf (stderr, "\"%s\" ", items[i * 3]);
+		    } else {
+			fprintf (stderr, "%s", items[i * 3]);
 		    }
 		}
-            }
+	    }
 	    delwin (dialog);
 	    free (status);
 	    return button;
