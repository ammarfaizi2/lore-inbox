Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUJLBtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUJLBtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 21:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUJLBtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 21:49:14 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:59140 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268323AbUJLBtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 21:49:01 -0400
Date: Tue, 12 Oct 2004 02:48:57 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6: "console=" parameter ignored
Message-ID: <Pine.LNX.4.58L.0410120221490.27716@blysk.ds.pg.gda.pl>
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
unregister_console().  This made a snapshot of 2.4.26 work for me.  I
wasn't able to test the changes with 2.6 because DECstation drivers don't
support it yet, but the code responsible for console selection appears
functionally the same.  So I've concluded it needs the same change.  
Here's a patch.

 Please apply.

  Maciej

patch-mips-2.6.9-rc2-20040920-console-0
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/kernel/printk.c linux-mips-2.6.9-rc2-20040920/kernel/printk.c
--- linux-mips-2.6.9-rc2-20040920.macro/kernel/printk.c	2004-08-25 04:01:41.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/kernel/printk.c	2004-10-11 23:31:29.000000000 +0000
@@ -108,6 +108,7 @@ struct console_cmdline
 #define MAX_CMDLINECONSOLES 8
 
 static struct console_cmdline console_cmdline[MAX_CMDLINECONSOLES];
+static int selected_console = -1;
 static int preferred_console = -1;
 
 /* Flag: console code may call schedule() */
@@ -173,12 +174,12 @@ int __init add_preferred_console(char *n
 	for(i = 0; i < MAX_CMDLINECONSOLES && console_cmdline[i].name[0]; i++)
 		if (strcmp(console_cmdline[i].name, name) == 0 &&
 			  console_cmdline[i].index == idx) {
-				preferred_console = i;
+				selected_console = i;
 				return 0;
 		}
 	if (i == MAX_CMDLINECONSOLES)
 		return -E2BIG;
-	preferred_console = i;
+	selected_console = i;
 	c = &console_cmdline[i];
 	memcpy(c->name, name, sizeof(c->name));
 	c->name[sizeof(c->name) - 1] = 0;
@@ -745,6 +746,9 @@ void register_console(struct console * c
 	int     i;
 	unsigned long flags;
 
+	if (preferred_console < 0)
+		preferred_console = selected_console;
+
 	/*
 	 *	See if we want to use this console driver. If we
 	 *	didn't select a console we take the first one
@@ -835,7 +839,7 @@ int unregister_console(struct console * 
 	 * would prevent fbcon from taking over.
 	 */
 	if (console_drivers == NULL)
-		preferred_console = -1;
+		preferred_console = selected_console;
 		
 
 	release_console_sem();
