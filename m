Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261769AbVAMWAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbVAMWAZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVAMWAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:00:22 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:51973 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261769AbVAMV6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 16:58:35 -0500
Subject: [patch 03/11] uml: fix some UML own initcall macros
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Thu, 13 Jan 2005 22:00:53 +0100
Message-Id: <20050113210053.ED4D0B0F7@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


UML has his own initcall mechanism to handle his special userspace
initialization (they are called in different moments, so they are indeed
different).

It must also duplicate some definition for the benefit of userspace code - but
those definition weren't in sync with the main code. Also, the UML own macros
missed __attribute_used__. Both problems are fixed by this patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.11-paolo/arch/um/include/init.h |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff -puN arch/um/include/init.h~uml-init_h-fix arch/um/include/init.h
--- linux-2.6.11/arch/um/include/init.h~uml-init_h-fix	2005-01-13 02:55:49.051805472 +0100
+++ linux-2.6.11-paolo/arch/um/include/init.h	2005-01-13 02:55:49.088799848 +0100
@@ -40,9 +40,18 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-#define __init          __attribute__ ((__section__ (".text.init")))
-#define __exit          __attribute__ ((unused, __section__(".text.exit")))
-#define __initdata      __attribute__ ((__section__ (".data.init")))
+/* These are for everybody (although not all archs will actually
+   discard it in modules) */
+#define __init		__attribute__ ((__section__ (".init.text")))
+#define __initdata	__attribute__ ((__section__ (".init.data")))
+#define __exitdata	__attribute__ ((__section__(".exit.data")))
+#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
+
+#ifdef MODULE
+#define __exit		__attribute__ ((__section__(".exit.text")))
+#else
+#define __exit		__attribute_used__ __attribute__ ((__section__(".exit.text")))
+#endif
 
 #endif
 
@@ -94,11 +103,11 @@ extern struct uml_param __uml_setup_star
  * Mark functions and data as being only used at initialization
  * or exit time.
  */
-#define __uml_init_setup	__attribute__ ((unused,__section__ (".uml.setup.init")))
-#define __uml_setup_help	__attribute__ ((unused,__section__ (".uml.help.init")))
-#define __uml_init_call		__attribute__ ((unused,__section__ (".uml.initcall.init")))
-#define __uml_postsetup_call	__attribute__ ((unused,__section__ (".uml.postsetup.init")))
-#define __uml_exit_call		__attribute__ ((unused,__section__ (".uml.exitcall.exit")))
+#define __uml_init_setup	__attribute_used__ __attribute__ ((__section__ (".uml.setup.init")))
+#define __uml_setup_help	__attribute_used__ __attribute__ ((__section__ (".uml.help.init")))
+#define __uml_init_call		__attribute_used__ __attribute__ ((__section__ (".uml.initcall.init")))
+#define __uml_postsetup_call	__attribute_used__ __attribute__ ((__section__ (".uml.postsetup.init")))
+#define __uml_exit_call		__attribute_used__ __attribute__ ((__section__ (".uml.exitcall.exit")))
 
 #endif /* _LINUX_UML_INIT_H */
 
_
