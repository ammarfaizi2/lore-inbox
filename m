Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUBIHYG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 02:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUBIHYG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 02:24:06 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:44193 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264941AbUBIHX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 02:23:59 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] __obsolete_setup macro
Date: Mon, 9 Feb 2004 02:23:50 -0500
User-Agent: KMail/1.6
Cc: Rusty Russell <rusty@rustcorp.com.au>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402090223.51829.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Not long ago Andi Kleen complained that some psmouse parameters have been
yanked out (by me) without any warning and that if user specifies an old
parameter on the kernel command line it is ignored without any warning.

I was going to re-introduce the old parameters and have their __setup's
point to one "complaining" function. Unfortunately __setup macro does not
allow using the same function for multiple parameters as it relies on
uniqueness of the function name when building the data structures. And I
am not really want to repeat the exactly same stupid function X number of
times. So here is an attempt to avoid it.

__obsolete_setup allows to specify a truly obsolete kernel parameter.
Whenever it is specified on the kernel line the kernel will complain that
the parameter is obsolete, like this:

Kernel command line: ro root=/dev/hdc5 vga=791 atkbd.softrepeat=1 atkbd_set=2
Parameter atkbd_set= is obsolete, ignored

I am planning to use it in the input modules to document now-gone options.
What do you think?

-- 
Dmitry


===================================================================


ChangeSet@1.1591, 2004-02-09 02:07:50-05:00, dtor_core@ameritech.net
  Setup: introduce __obsolete_setup macro to denote truly obsolete parameters.
         Whenever such parameter is specified kernel will comlain that
         "Parameter %s is obsolete, ignored"


 include/linux/init.h |   17 +++++++++++++----
 init/main.c          |    7 +++++--
 2 files changed, 18 insertions(+), 6 deletions(-)


===================================================================



diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Mon Feb  9 02:20:51 2004
+++ b/include/linux/init.h	Mon Feb  9 02:20:51 2004
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
 
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	Mon Feb  9 02:20:51 2004
+++ b/init/main.c	Mon Feb  9 02:20:51 2004
@@ -152,8 +152,11 @@
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
