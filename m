Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261622AbVAMNrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261622AbVAMNrk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 08:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVAMNri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 08:47:38 -0500
Received: from cc15144-a.groni1.gr.home.nl ([217.120.147.78]:12685 "HELO
	boetes.org") by vger.kernel.org with SMTP id S261622AbVAMNqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 08:46:02 -0500
Date: Thu, 13 Jan 2005 14:45:58 +0059
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: propolice support for linux
Message-ID: <20050113134620.GA14127@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The propolice gcc-extension prevents buffer-overflows in binaries:

  http://www.research.ibm.com/trl/projects/security/ssp/

The effect is that all buffer-overflow exploits are turned into a
-- logged -- Denial of service.

And since most of the security-flaws in linux are buffer-overflows
I would like to request that a patch based on this one is applied
to the kernel so people can use this extension by default.


Note: The propolice-patch for gcc-3.3.2 also applies fine to
      gcc-3.3.5
Note: glibc from CVS already supports propolice.
Note: OpenBSD is fully compiled with propolice.


  http://frogger974.homelinux.org/propolice/linux-2.6.3-ssp-config-1.patch

diff -urN linux-2.6.3/Makefile linux-2.6.3.ssp/Makefile
--- linux-2.6.3/Makefile	2004-02-17 22:58:39.000000000 -0500
+++ linux-2.6.3.ssp/Makefile	2004-03-03 10:20:29.000000000 -0500
@@ -442,6 +442,10 @@
 CFLAGS		+= -fomit-frame-pointer
 endif
 
+ifdef CONFIG_HARDENED_SSP
+CFLAGS += -fstack-protector
+endif
+
 ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
diff -urN linux-2.6.3/include/linux/kernel.h linux-2.6.3.ssp/include/linux/kernel.h
--- linux-2.6.3/include/linux/kernel.h	2004-02-17 22:57:11.000000000 -0500
+++ linux-2.6.3.ssp/include/linux/kernel.h	2004-03-03 10:08:10.000000000 -0500
@@ -115,6 +115,10 @@
 #define TAINT_FORCED_RMMOD		(1<<3)
 
 extern void dump_stack(void);
+#ifdef CONFIG_HARDENED_SSP
+extern int __guard;
+extern void __stack_smash_handler(int, char []);
+#endif
 
 #ifdef DEBUG
 #define pr_debug(fmt,arg...) \
Files linux-2.6.3/lib/.propolice.c.swp and linux-2.6.3.ssp/lib/.propolice.c.swp differ
diff -urN linux-2.6.3/lib/Makefile linux-2.6.3.ssp/lib/Makefile
--- linux-2.6.3/lib/Makefile	2004-02-17 22:57:14.000000000 -0500
+++ linux-2.6.3.ssp/lib/Makefile	2004-03-03 13:47:27.000000000 -0500
@@ -20,6 +20,8 @@
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 
+obj-$(CONFIG_HARDENED_SSP) += propolice.o
+
 host-progs	:= gen_crc32table
 clean-files	:= crc32table.h
 
diff -urN linux-2.6.3/lib/propolice.c linux-2.6.3.ssp/lib/propolice.c
--- linux-2.6.3/lib/propolice.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.3.ssp/lib/propolice.c	2004-03-03 17:52:48.000000000 -0500
@@ -0,0 +1,15 @@
+#include <linux/module.h>
+#include <linux/errno.h>
+
+EXPORT_SYMBOL_NOVERS(__guard);
+EXPORT_SYMBOL_NOVERS(__stack_smash_handler);
+ 
+int __guard = '\0\0\n\777';
+ 
+void 
+__stack_smash_handler (int damaged, char func[])
+{
+	static char *message = "propolice detects %x at function %s.\n" ;
+	panic (message, damaged, func);
+}
+
diff -urN linux-2.6.3/security/Kconfig linux-2.6.3.ssp/security/Kconfig
--- linux-2.6.3/security/Kconfig	2004-02-17 22:58:44.000000000 -0500
+++ linux-2.6.3.ssp/security/Kconfig	2004-03-03 13:50:30.000000000 -0500
@@ -46,5 +46,11 @@
 
 source security/selinux/Kconfig
 
+config HARDENED_SSP
+	bool 'Hardened ProPolice SSP build support'
+	help
+	  This enables kernel building with stack-smashing protection
+	  via the -fstack-protector GCC flag.
+
 endmenu
 


# Han
