Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUDCBb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 20:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbUDCBb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 20:31:59 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:58052 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261530AbUDCBb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 20:31:57 -0500
Date: Fri, 2 Apr 2004 20:32:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, trini@kernel.crashing.org
Subject: [PATCH][2.6-mm] early_param console_setup clobbers commandline
Message-ID: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

console_setup clobbers the argument it's passed, resulting in
the commandline being chopped (it inserts a '\0'). A sample command line
would be;

ro root=/dev/hda1 profile=2 debug console=tty0 console=ttyS0,38400 hugepages=20 nmi_watchdog=2

would end up like;

ro root=/dev/hda1 profile=2 debug console=tty0 console=ttyS0

I believe this may be the only setup call which clobbers the argument, so
how about we pass a copy (i wasn't sure about what would be a decent
argument length so i just went with COMMAND_LINE_SIZE (ugly, yes)?
Something like the following tested patch;

Index: linux-2.6.5-rc3-mm4/init/main.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.5-rc3-mm4/init/main.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 main.c
--- linux-2.6.5-rc3-mm4/init/main.c	2 Apr 2004 03:55:28 -0000	1.1.1.1
+++ linux-2.6.5-rc3-mm4/init/main.c	3 Apr 2004 01:21:34 -0000
@@ -410,6 +410,7 @@ void __init parse_early_options(char **c
 	char *from = *cmdline_p;	/* Original. */
 	char c = ' ', *to = tmp_command_line;	/* Parsed. */
 	int len = 0;
+	char arg[COMMAND_LINE_SIZE];

 	/* Save it, if we need to. */
 	if (*cmdline_p != saved_command_line)
@@ -431,7 +432,10 @@ void __init parse_early_options(char **c
 					/* Find the end of this arg, and
 					 * no spaces allowed in an arg. */
 					after = strchr(from, ' ');
-					if (p->fn(from) < 0) {
+					if (after)
+						*after = '\0';
+					strncpy(arg, from, sizeof(arg)-1);
+					if (p->fn(arg) < 0) {
 						from = before;
 						break;
 					}
