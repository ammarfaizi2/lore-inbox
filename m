Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262909AbTJZEJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 00:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTJZEJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 00:09:56 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45012
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262909AbTJZEJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 00:09:54 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Sam Ravnborg <sam@ravnborg.org>
Subject: [patch] make Kconfig choice menu help text work in -test8
Date: Sat, 25 Oct 2003 22:16:02 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
References: <200310250244.56881.rob@landley.net> <200310251624.07665.rob@landley.net> <20031025213027.GB2249@mars.ravnborg.org>
In-Reply-To: <20031025213027.GB2249@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310252216.08065.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > (Looking at the patch, it prints stuff to stderr, adds adds a "selected"
> > case to something that was previously on/off...  I don't think it's
> > really addressing this issue...)
>
> That explains why Roman Zippel did not apply it - thanks for the testing.
>
> 	Sam

I had a spare couple of hours this evening, so I whipped up a patch of my
own to actually fix the thing, working from first principles and tracing
through yacc and lexx code at one point.

With the benefit of hindsight, it turns out the other patch wasn't actually
that far off.  I only noticed that just now, I had to figure out how mconf.c
was shelling out to lxdialog and getting data back on stderr first to
realize that yes, printing stuff to stderr is in fact an important part of
getting this to work. :)

Here's the fix.  Go to into "processor type and features" from the main
menu, then the "subarchitecture" menu at the top of that, and notice the
entries in it now have help options.

Rob

diff -ru linux-2.6.0-test8/scripts/kconfig/mconf.c linux-test8-new/scripts/kconfig/mconf.c
--- linux-2.6.0-test8/scripts/kconfig/mconf.c	2003-10-17 16:42:56.000000000 -0500
+++ linux-test8-new/scripts/kconfig/mconf.c	2003-10-25 21:59:31.000000000 -0500
@@ -635,7 +635,9 @@
 			sym_set_tristate_value(menu->sym, yes);
 			return;
 		case 1:
-			show_help(menu);
+			if(sscanf(input_buf, "%p", &child) != 1)
+				break;
+			show_help(child);
 			break;
 		case 255:
 			return;
diff -ru linux-2.6.0-test8/scripts/lxdialog/checklist.c linux-test8-new/scripts/lxdialog/checklist.c
--- linux-2.6.0-test8/scripts/lxdialog/checklist.c	2003-10-17 16:43:10.000000000 -0500
+++ linux-test8-new/scripts/lxdialog/checklist.c	2003-10-25 21:56:04.000000000 -0500
@@ -299,12 +299,6 @@
 	    continue;		/* wait for another key press */
 	}
 	switch (key) {
-	case 'H':
-	case 'h':
-	case '?':
-	    delwin (dialog);
-	    free (status);
-	    return 1;
 	case TAB:
 	case KEY_LEFT:
 	case KEY_RIGHT:
@@ -314,6 +308,11 @@
 	    print_buttons(dialog, height, width, button);
 	    wrefresh (dialog);
 	    break;
+	case 'H':
+	case 'h':
+	case '?':
+	    button=1;
+	    /* Fall through */
 	case 'S':
 	case 's':
 	case ' ':
@@ -347,7 +346,9 @@
 
 		    }
 		}
-            }
+            } else {
+		fprintf(stderr,"%s",items[choice * 3]);
+	    }
 	    delwin (dialog);
 	    free (status);
 	    return button;

