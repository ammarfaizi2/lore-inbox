Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUCPOis (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUCPOih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:38:37 -0500
Received: from styx.suse.cz ([82.208.2.94]:64385 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S261930AbUCPOTn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 09:19:43 -0500
Content-Transfer-Encoding: 7BIT
Message-Id: <10794467773559@twilight.ucw.cz>
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 22/44] Create __obsolete_setup() macro to warn users about obsolete kernel params
X-Mailer: gregkh_patchbomb_levon_offspring
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 15:19:37 +0100
In-Reply-To: <10794467771448@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1608.54.8, 2004-03-03 00:35:47-05:00, dtor_core@ameritech.net
  Setup: introduce __obsolete_setup macro to denote truly obsolete
         parameters. Whenever such parameter is specified kernel
         will complain that "Parameter %s is obsolete, ignored"


 include/linux/init.h |   22 +++++++++++++++++-----
 init/main.c          |    7 +++++--
 2 files changed, 22 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Tue Mar 16 13:18:44 2004
+++ b/include/linux/init.h	Tue Mar 16 13:18:44 2004
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
--- a/init/main.c	Tue Mar 16 13:18:44 2004
+++ b/init/main.c	Tue Mar 16 13:18:44 2004
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

