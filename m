Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUA0Qz3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 11:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbUA0Qz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 11:55:28 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:43160 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S261152AbUA0Qz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 11:55:27 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: kai@germaschewski.name, sam@ravnborg.org
Subject: [PATCH] fix menuconfig choice item help display
Date: Tue, 27 Jan 2004 09:55:24 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401270955.24371.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.2-rc2 fixes menuconfig so it can display
help text for individual choice group config entries.

Previously it would only display the help text attached to the
"choice" item.  There was no way to display the help attached to
individual config entries inside the choice group.  Typically,
the "choice" item has no help text, and all the useful help is
attached to the individual entries, so this was a bit of a
problem.

===== scripts/kconfig/mconf.c 1.10 vs edited =====
--- 1.10/scripts/kconfig/mconf.c	Mon Jan 19 16:38:08 2004
+++ edited/scripts/kconfig/mconf.c	Tue Jan 27 09:44:30 2004
@@ -635,7 +635,9 @@
 			sym_set_tristate_value(menu->sym, yes);
 			return;
 		case 1:
-			show_help(menu);
+			if (sscanf(input_buf, "%p", &child) != 1)
+				break;
+			show_help(child);
 			break;
 		case 255:
 			return;
===== scripts/lxdialog/checklist.c 1.3 vs edited =====
--- 1.3/scripts/lxdialog/checklist.c	Tue Feb  5 00:39:14 2002
+++ edited/scripts/lxdialog/checklist.c	Tue Jan 27 09:35:44 2004
@@ -303,6 +303,9 @@
 	case 'h':
 	case '?':
 	    delwin (dialog);
+	    fprintf(stderr, "%s \"%s\"\n",
+		    items[(scroll + choice) * 3],
+		    items[(scroll + choice) * 3 + 1]);
 	    free (status);
 	    return 1;
 	case TAB:
@@ -318,7 +321,11 @@
 	case 's':
 	case ' ':
 	case '\n':
-	    if (!button) {
+	    if (button)
+		    fprintf(stderr, "%s \"%s\"\n",
+			    items[(scroll + choice) * 3],
+			    items[(scroll + choice) * 3 + 1]);
+	    else {
 		if (flag == FLAG_CHECK) {
 		    status[scroll + choice] = !status[scroll + choice];
 		    wmove (list, choice, check_x);

