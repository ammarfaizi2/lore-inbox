Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbTJAS4U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbTJAS4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:56:20 -0400
Received: from codepoet.org ([166.70.99.138]:29111 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262196AbTJAS4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:56:14 -0400
Date: Wed, 1 Oct 2003 12:56:13 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix 2.4.x incorrect argv[0] for init
Message-ID: <20031001185613.GA13945@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310011434400.6488-100000@dmt.cyclades>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4.x when someone specifies "init=/bin/foo" to select an
alternative binary to run instead of /sbin/init, argv[0] is not
to the correct value.  This is a problem for programs such as
busybox that multiplex applications based on the value of
argv[0].  For example, even if you specify init=/bin/sh" on the
kernel command line, busybox will still receive "/sbin/init" as
argv[0], and will therefore run init rather than /bin/sh...

This problem was recently fixed in 2.6.x.  This patch applies
the same fix to 2.4.x.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


--- orig/init/main.c	2003-08-30 10:50:15.000000000 -0600
+++ linux-2.4.22/init/main.c	2003-08-30 10:50:15.000000000 -0600
@@ -545,6 +545,12 @@
 #endif
 }
 
+static void run_init_process(char *init_filename)
+{
+	argv_init[0] = init_filename;
+	execve(init_filename, argv_init, envp_init);
+}
+
 extern void prepare_namespace(void);
 
 static int init(void * unused)
@@ -587,10 +593,12 @@
 	 */
 
 	if (execute_command)
-		execve(execute_command,argv_init,envp_init);
-	execve("/sbin/init",argv_init,envp_init);
-	execve("/etc/init",argv_init,envp_init);
-	execve("/bin/init",argv_init,envp_init);
-	execve("/bin/sh",argv_init,envp_init);
+		run_init_process(execute_command);
+
+	run_init_process("/sbin/init");
+	run_init_process("/etc/init");
+	run_init_process("/bin/init");
+	run_init_process("/bin/sh");
+
 	panic("No init found.  Try passing init= option to kernel.");
 }
