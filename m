Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264892AbTIIWej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264942AbTIIWej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:34:39 -0400
Received: from codepoet.org ([166.70.99.138]:44715 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264892AbTIIWe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:34:27 -0400
Date: Tue, 9 Sep 2003 16:34:26 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.6.x incorrect argv[0] for init
Message-ID: <20030909223426.GB11277@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In both 2.4.x and in 2.6.x, when someone specifies "init=" to
select an alternative binary to run instead of /sbin/init,
argv[0] is not set correctly.  This is a problem for programs
such as busybox that multiplex applications based on the value of
argv[0].  For example, even if you specify init=/bin/sh" on the
kernel command line, busybox will still receive "/sbin/init" as
argv[0], and will therefore run init rather than /bin/sh...

This patch fixes it.  Please apply,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- linux-2.6.0-test5/init/main.c.orig	2003-09-08 13:49:54.000000000 -0600
+++ linux-2.6.0-test5/init/main.c	2003-09-09 16:28:02.000000000 -0600
@@ -542,6 +542,12 @@
 	spawn_ksoftirqd();
 }
 
+static void run_init_process(char *init_filename)
+{
+	argv_init[0] = init_filename;
+	execve(init_filename, argv_init, envp_init);
+}
+
 extern void prepare_namespace(void);
 
 static int init(void * unused)
@@ -592,10 +598,12 @@
 	 */
 
 	if (execute_command)
-		execve(execute_command,argv_init,envp_init);
-	execve("/sbin/init",argv_init,envp_init);
-	execve("/etc/init",argv_init,envp_init);
-	execve("/bin/init",argv_init,envp_init);
-	execve("/bin/sh",argv_sh,envp_init);
+		run_init_process(execute_command);
+
+	run_init_process("/sbin/init");
+	run_init_process("/etc/init");
+	run_init_process("/bin/init");
+	run_init_process("/bin/sh");
+
 	panic("No init found.  Try passing init= option to kernel.");
 }
