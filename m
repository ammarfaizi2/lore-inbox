Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVAMQho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVAMQho (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 11:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVAMQhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 11:37:43 -0500
Received: from cc15144-a.groni1.gr.home.nl ([217.120.147.78]:25762 "HELO
	boetes.org") by vger.kernel.org with SMTP id S261175AbVAMQhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 11:37:13 -0500
Date: Thu, 13 Jan 2005 17:37:11 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050113163733.GB14127@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050113134620.GA14127@boetes.org> <20050113140446.GA22381@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113140446.GA22381@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for your comments! This wasn't my patch, just the closed
thing to something working I could find. Here is my version.

Now all I wonder about is what the _NOVERS should become, since
Arjen pointed it it `was dead,' since I don't really understand
what he means with that.

Perhaps I should also add some additional comment about how little
effect this extension resorts on kernel-level.

And I got two warnings about `int __guard = '\0\0\n\777';'

lib/propolice.c:15:15: warning: octal escape sequence out of range
lib/propolice.c:15:15: warning: multi-character character constant



--- linux-2.6.9/lib/propolice.c.orig	2005-01-13 17:08:49.920963760 +0100
+++ linux-2.6.9/lib/propolice.c	2005-01-13 16:46:48.939783424 +0100
@@ -0,0 +1,24 @@
+/*
+ * Copyright 2005, Han Boetes <han@boetes.org>
+ *
+ * This code adds support for the propolice stacksmashing
+ * extension for gcc.
+ * http://www.research.ibm.com/trl/projects/security/ssp/
+ *
+ * This source code is licensed under the GNU General Public
+ * License, Version 2. See the file COPYING for more details.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+int __guard = '\0\0\n\777';
+EXPORT_SYMBOL_NOVERS(__guard);
+
+static const char message[] = "propolice detects %x at function %s.\n";
+
+void __stack_smash_handler(int damaged, char func[])
+{
+    panic(message, damaged, func);
+}
+EXPORT_SYMBOL_NOVERS(__stack_smash_handler);
--- linux-2.6.9/lib/Makefile.orig	2005-01-13 16:47:58.564198904 +0100
+++ linux-2.6.9/lib/Makefile	2005-01-13 17:06:29.124368096 +0100
@@ -23,6 +23,8 @@ obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_ZLIB_INFLATE) += zlib_inflate/
 obj-$(CONFIG_ZLIB_DEFLATE) += zlib_deflate/
 
+obj-$(CONFIG_PROPOLICE) += propolice.o
+
 hostprogs-y	:= gen_crc32table
 clean-files	:= crc32table.h
 
--- linux-2.6.9/security/Kconfig.orig	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6.9/security/Kconfig	2005-01-13 16:57:23.130371800 +0100
@@ -44,6 +44,18 @@ config SECURITY_ROOTPLUG
 	  
 	  If you are unsure how to answer this question, answer N.
 
+config PROPOLICE
+       bool 'GCC ProPolice SSP build support'
+       help
+         This enables kernel building with stack-smashing protection
+         via the -fstack-protector GCC flag, if you have GCC build with
+	 propolice.
+
+	 See <http://www.research.ibm.com/trl/projects/security/ssp/> for
+	 more information about this compiler-extension.
+
+	 If you are unsure how to answer this question, answer N.
+
 source security/selinux/Kconfig
 
 endmenu
--- linux-2.6.9/Makefile.orig	2005-01-13 16:38:39.479192744 +0100
+++ linux-2.6.9/Makefile	2005-01-13 16:40:45.139089536 +0100
@@ -490,6 +490,10 @@ ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
 
+ifdef CONFIG_PROPOLICE
+CFLAGS		+= -fstack-protector
+endif
+
 ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif




# Han
