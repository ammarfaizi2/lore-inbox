Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVDETRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVDETRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVDETPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:15:54 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12518 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261947AbVDETKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:10:14 -0400
Date: Tue, 5 Apr 2005 14:10:03 -0500
From: Greg Edwards <edwardsg@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CON_CONSDEV bit not set correctly on last console
Message-ID: <20050405191003.GO21725@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to include/linux/console.h, CON_CONSDEV flag should be set on
the last console specified on the boot command line:

     86 #define CON_PRINTBUFFER (1)
     87 #define CON_CONSDEV     (2) /* Last on the command line */
     88 #define CON_ENABLED     (4)
     89 #define CON_BOOT        (8)

This does not currently happen if there is more than one console specified
on the boot commandline.  Instead, it gets set on the first console on the
command line.  This can cause problems for things like kdb that look for
the CON_CONSDEV flag to see if the console is valid.

Additionaly, it doesn't look like CON_CONSDEV is reassigned to the next
preferred console at unregister time if the console being unregistered
currently has that bit set.

Example (from sn2 ia64):

elilo vmlinuz root=<dev> console=ttyS0 console=ttySG0

in this case, the flags on ttySG console struct will be 0x4 (should be
0x6).

Attached patch against bk fixes both issues for the cases I looked at.  It
uses selected_console (which gets incremented for each console specified
on the command line) as the indicator of which console to set CON_CONSDEV
on.  When adding the console to the list, if the previous one had
CON_CONSDEV set, it masks it out.  Tested on ia64 and x86.

Signed-off-by: Greg Edwards <edwardsg@sgi.com>


 printk.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

Index: bk-2.6/kernel/printk.c
===================================================================
--- bk-2.6.orig/kernel/printk.c	2005-04-05 10:55:19.258081161 -0500
+++ bk-2.6/kernel/printk.c	2005-04-05 11:50:16.949394443 -0500
@@ -861,8 +861,10 @@ void register_console(struct console * c
 			break;
 		console->flags |= CON_ENABLED;
 		console->index = console_cmdline[i].index;
-		if (i == preferred_console)
+		if (i == selected_console) {
 			console->flags |= CON_CONSDEV;
+			preferred_console = selected_console;
+		}
 		break;
 	}
 
@@ -882,6 +884,8 @@ void register_console(struct console * c
 	if ((console->flags & CON_CONSDEV) || console_drivers == NULL) {
 		console->next = console_drivers;
 		console_drivers = console;
+		if (console->next)
+			console->next->flags &= ~CON_CONSDEV;
 	} else {
 		console->next = console_drivers->next;
 		console_drivers->next = console;
@@ -922,10 +926,14 @@ int unregister_console(struct console * 
 	/* If last console is removed, we re-enable picking the first
 	 * one that gets registered. Without that, pmac early boot console
 	 * would prevent fbcon from taking over.
+	 *
+	 * If this isn't the last console and it has CON_CONSDEV set, we
+	 * need to set it on the next preferred console.
 	 */
 	if (console_drivers == NULL)
 		preferred_console = selected_console;
-		
+	else if (console->flags & CON_CONSDEV)
+		console_drivers->flags |= CON_CONSDEV;
 
 	release_console_sem();
 	return res;
