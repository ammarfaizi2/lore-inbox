Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268248AbUJLBsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268248AbUJLBsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268323AbUJLBsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:48:21 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4356 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268248AbUJLBr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:47:59 -0400
Date: Tue, 12 Oct 2004 02:47:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4: "console=" parameter ignored
Message-ID: <Pine.LNX.4.58L.0410120132390.27716@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I've noticed that under specific circumstances the "console=" kernel 
parameter is ignored.  This happens when EARLY_PRINTK is enabled and the 
serial console is the only available.  In this case unregister_console() 
when called for the early console sets preferred_console back to -1 
replacing the value that was recorded by console_setup() -- the order of 
calls is as follows:

1. register_console() -- for the early console,

2. console_setup() -- recording the console index for the real console,

3. unregister_console() -- for the early console, erasing the console
   index recorded above,

4. register_console() -- for the real console, picking up the first device
   available, instead of the selected one.

I've observed this problem with a DECstation system using ttyS3 -- its
default console device from the firmware's point of view.

 The solution is to restore the setting of "console=" upon
unregister_console().  Here is a patch that works for me -- run-time
tested with a snapshot of 2.4.26.  I've prepared a coresponding patch for
2.6, that I'll send separately.

 Please apply.

  Maciej

patch-mips-2.4.26-20040809-console-0
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/kernel/printk.c linux-mips-2.4.26-20040809/kernel/printk.c
--- linux-mips-2.4.26-20040809.macro/kernel/printk.c	2003-12-18 03:57:27.000000000 +0000
+++ linux-mips-2.4.26-20040809/kernel/printk.c	2004-09-25 20:54:21.000000000 +0000
@@ -95,6 +95,7 @@ static unsigned long log_end;			/* Index
 static unsigned long logged_chars;		/* Number of chars produced since last read+clear operation */
 
 struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
+static int selected_console = -1;
 static int preferred_console = -1;
 
 /* Flag: console code may call schedule() */
@@ -140,12 +141,12 @@ static int __init console_setup(char *st
 	for(i = 0; i < MAX_CMDLINECONSOLES && console_cmdline[i].name[0]; i++)
 		if (strcmp(console_cmdline[i].name, name) == 0 &&
 			  console_cmdline[i].index == idx) {
-				preferred_console = i;
+				selected_console = i;
 				return 1;
 		}
 	if (i == MAX_CMDLINECONSOLES)
 		return 1;
-	preferred_console = i;
+	selected_console = i;
 	c = &console_cmdline[i];
 	memcpy(c->name, name, sizeof(c->name));
 	c->options = options;
@@ -586,6 +587,9 @@ void register_console(struct console * c
 	int     i;
 	unsigned long flags;
 
+	if (preferred_console < 0)
+		preferred_console = selected_console;
+
 	/*
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
@@ -675,7 +679,7 @@ int unregister_console(struct console * 
 	 * would prevent fbcon from taking over.
 	 */
 	if (console_drivers == NULL)
-		preferred_console = -1;
+		preferred_console = selected_console;
 		
 
 	release_console_sem();
