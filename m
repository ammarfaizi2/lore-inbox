Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUB2HhO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 02:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUB2HhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 02:37:13 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:17755 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262006AbUB2HhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 02:37:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 8/9] introduce __obsolete_setup
Date: Sun, 29 Feb 2004 02:02:09 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
References: <200402290153.08798.dtor_core@ameritech.net> <200402290200.07447.dtor_core@ameritech.net> <200402290201.15611.dtor_core@ameritech.net>
In-Reply-To: <200402290201.15611.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290202.11245.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1692, 2004-02-28 00:49:41-05:00, dtor_core@ameritech.net
  Setup: introduce __obsolete_setup macro to denote truly obsolete
         parameters. Whenever such parameter is specified kernel
         will comlain that "Parameter %s is obsolete, ignored"


 include/linux/init.h |   22 +++++++++++++++++-----
 init/main.c          |    7 +++++--
 2 files changed, 22 insertions(+), 7 deletions(-)


===================================================================



diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Sun Feb 29 01:19:55 2004
+++ b/include/linux/init.h	Sun Feb 29 01:19:55 2004
@@ -110,12 +110,21 @@
 };
 
 /* OBSOLETE: see moduleparam.h for the right way. */
-#define __setup(str, fn)					\
-	static char __setup_str_##fn[] __initdata = str;	\
-	static struct obs_kernel_param __setup_##fn		\
+#define __setup_param(str, unique_id, fn)			\
+	static char __setup_str_##unique_id[] __initdata = str;	\
+	static struct obs_kernel_param __setup_##unique_id	\
 		 __attribute_used__				\
 		 __attribute__((__section__(".init.setup")))	\
-		= { __setup_str_##fn, fn }
+		= { __setup_str_##unique_id, fn }
+
+#define __setup_null_param(str, unique_id)			\
+	__setup_param(str, unique_id, NULL)
+
+#define __setup(str, fn)					\
+	__setup_param(str, fn, fn)
+
+#define __obsolete_setup(str)					\
+	__setup_null_param(str, __LINE__)
 
 #endif /* __ASSEMBLY__ */
 
@@ -172,7 +181,10 @@
 	{ return exitfn; }					\
 	void cleanup_module(void) __attribute__((alias(#exitfn)));
 
-#define __setup(str,func) /* nothing */
+#define __setup_param(str, unique_id, fn)	/* nothing */
+#define __setup_null_param(str, unique_id) 	/* nothing */
+#define __setup(str, func) 			/* nothing */
+#define __obsolete_setup(str) 			/* nothing */
 #endif
 
 /* Data marked not to be saved by software_suspend() */
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Sun Feb 29 01:19:55 2004
+++ b/init/main.c	Sun Feb 29 01:19:55 2004
@@ -155,8 +155,11 @@
 	p = &__setup_start;
 	do {
 		int n = strlen(p->str);
-		if (!strncmp(line,p->str,n)) {
-			if (p->setup_func(line+n))
+		if (!strncmp(line, p->str, n)) {
+			if (!p->setup_func) {
+				printk(KERN_WARNING "Parameter %s is obsolete, ignored\n", p->str);
+				return 1;
+			} else if (p->setup_func(line + n))
 				return 1;
 		}
 		p++;
