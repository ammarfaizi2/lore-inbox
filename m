Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262205AbTCPCzt>; Sat, 15 Mar 2003 21:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbTCPCzt>; Sat, 15 Mar 2003 21:55:49 -0500
Received: from mako.theneteffect.com ([63.97.58.10]:56840 "EHLO
	mako.theneteffect.com") by vger.kernel.org with ESMTP
	id <S262205AbTCPCzr>; Sat, 15 Mar 2003 21:55:47 -0500
From: Mitch Adair <mitch@theneteffect.com>
Message-Id: <200303160306.h2G36RD22163@mako.theneteffect.com>
Subject: Re: [PATCH] Re: 2.5.64: menuconfig: help within choice blocks doesn't show?
To: pasky@ucw.cz (Petr Baudis)
Date: Sat, 15 Mar 2003 21:06:26 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030315202528.GA31875@pasky.ji.cz> from "Petr Baudis" at Mar 15, 2003 09:25:28 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> will show help for P4 even if the cursor is now at i486. Unfortunately with the
> current output of lxdialog we can't do it in the right way, one more reason for
> me to finally finish the lxdialog integration ;-). In the meantime, if anyone
> wants to, he might hack lxdialog and mconf together and provide sufficient
> output to implement this in the right way. Let this be the inspiration.

I was inspired enough to do the following quick band-aid.  It compiles and
follows the bouncing cursor.  Works For Me.  Other testers welcome...

I tried to maintin the lxdialog heinous spacing practices BTW... that a
carry-over from the original?

	M


diff -urN linux-2.5.64/scripts/kconfig/mconf.c linux-2.5.64-mconf/scripts/kconfig/mconf.c
--- linux-2.5.64/scripts/kconfig/mconf.c	Tue Mar  4 21:29:03 2003
+++ linux-2.5.64-mconf/scripts/kconfig/mconf.c	Sat Mar 15 20:45:40 2003
@@ -618,7 +618,15 @@
 			sym_set_tristate_value(menu->sym, yes);
 			return;
 		case 1:
-			show_help(menu);
+			if (sscanf(input_buf, "%p", &child) != 1) {
+				while(child) {
+					if(child->sym == active)
+						show_help(child);
+					child = child->next;
+				}
+			} else {
+				show_help(child);
+			}
 			break;
 		case 255:
 			return;
diff -urN linux-2.5.64/scripts/lxdialog/checklist.c linux-2.5.64-mconf/scripts/lxdialog/checklist.c
--- linux-2.5.64/scripts/lxdialog/checklist.c	Tue Mar  4 21:29:18 2003
+++ linux-2.5.64-mconf/scripts/lxdialog/checklist.c	Sat Mar 15 20:42:50 2003
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
+	    	    fprintf (stderr, "%s", items[i * 3]);
+	    }
 	    delwin (dialog);
 	    free (status);
 	    return 1;
@@ -318,36 +333,34 @@
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
+	    }
+	    wnoutrefresh (list);
+	    wrefresh (dialog);
             
-		for (i = 0; i < item_no; i++) {
-		    if (status[i]) {
-			if (flag == FLAG_CHECK) {
-			    fprintf (stderr, "\"%s\" ", items[i * 3]);
-			} else {
-			    fprintf (stderr, "%s", items[i * 3]);
-			}
-
+	    for (i = 0; i < item_no; i++) {
+		if (status[i]) {
+		    if (flag == FLAG_CHECK) {
+			fprintf (stderr, "\"%s\" ", items[i * 3]);
+		    } else {
+			fprintf (stderr, "%s", items[i * 3]);
 		    }
+
 		}
-            }
+	    }
 	    delwin (dialog);
 	    free (status);
 	    return button;
