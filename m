Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265072AbTGKS7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTGKS7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:59:08 -0400
Received: from mako.theneteffect.com ([63.97.58.10]:267 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id S265100AbTGKSwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:52:55 -0400
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200307111907.h6BJ7bY19821@mako.theneteffect.com>
Subject: [PATCH] fix menuconfig help for "choice" groups
To: linux-kernel@vger.kernel.org
Date: Fri, 11 Jul 2003 14:07:37 -0500 (CDT)
Cc: torvalds@osdl.org, zippel@linux-m68k.org
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following patch fixes menuconfig so that it shows the help entries for
items inside a "choice" group.  (an example of this choice group is
Processor type and features -> Processor family -- try to select
help for one of the processors in there and you'll see...)

I've been hawking this patch since 2.5.64...  it's fairly trivial and
don't we want working Help for the poor souls jumping into 2.6-pre
for the first time? :)

	M


diff -urN linux-2.5.75/scripts/kconfig/mconf.c linux-2.5.75-mod/scripts/kconfig/mconf.c
--- linux-2.5.75/scripts/kconfig/mconf.c	Fri Jul 11 12:17:22 2003
+++ linux-2.5.75-mod/scripts/kconfig/mconf.c	Fri Jul 11 12:24:01 2003
@@ -635,7 +635,8 @@
 			sym_set_tristate_value(menu->sym, yes);
 			return;
 		case 1:
-			show_help(menu);
+			if (sscanf(input_buf, "%p", &child) == 1)
+				show_help(child);
 			break;
 		case 255:
 			return;
diff -urN linux-2.5.75/scripts/lxdialog/checklist.c linux-2.5.75-mod/scripts/lxdialog/checklist.c
--- linux-2.5.75/scripts/lxdialog/checklist.c	Tue Mar  4 21:29:18 2003
+++ linux-2.5.75-mod/scripts/lxdialog/checklist.c	Fri Jul 11 12:24:01 2003
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
