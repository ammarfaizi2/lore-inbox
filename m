Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262534AbVAQDkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262534AbVAQDkD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVAQDiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:38:00 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:19204
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262534AbVAQDdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:50 -0500
Message-Id: <200501170556.j0H5uJkY006072@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/10] UML - Eliminate unhandled SIGPROF on halt
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the "profiling timer expired" message on shutting down with profiling
enabled.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/kernel/main.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/main.c	2005-01-12 15:43:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/main.c	2005-01-13 17:40:25.000000000 -0500
@@ -154,13 +154,21 @@
 	do_uml_initcalls();
 	ret = linux_main(argc, argv);
 
+	/* Disable SIGPROF - I have no idea why libc doesn't do this or turn
+	 * off the profiling time, but UML dies with a SIGPROF just before
+	 * exiting when profiling is active.
+	 */
+	change_sig(SIGPROF, 0);
+
 	/* Reboot */
 	if(ret){
 		int err;
 
 		printf("\n");
+
 		/* stop timers and set SIG*ALRM to be ignored */
 		disable_timer();
+
 		/* disable SIGIO for the fds and set SIGIO to be ignored */
 		err = deactivate_all_fds();
 		if(err)

