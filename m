Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVAMSZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVAMSZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVAMSXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:23:12 -0500
Received: from cc15144-a.groni1.gr.home.nl ([217.120.147.78]:13208 "HELO
	boetes.org") by vger.kernel.org with SMTP id S261402AbVAMSRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:17:30 -0500
Date: Thu, 13 Jan 2005 19:17:23 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050113181744.GD14127@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050113134620.GA14127@boetes.org> <20050113140446.GA22381@infradead.org> <20050113163733.GB14127@boetes.org> <Pine.LNX.4.61.0501131057350.24811@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501131057350.24811@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Thu, 13 Jan 2005, Han Boetes wrote:
> > Now all I wonder about is what the _NOVERS should become, since
> > Arjen pointed it it `was dead,' since I don't really understand
> > what he means with that.
>
> Just use the normal EXPORT_SYMBOL it has the same effect.

Thank you, much appreciated.

Here is the latest version of the patch:

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
+int __guard = '\0\0\n\377';
+EXPORT_SYMBOL(__guard);
+
+static const char message[] = "propolice detects %x at function %s.\n";
+
+void __stack_smash_handler(int damaged, char func[])
+{
+    panic(message, damaged, func);
+}
+EXPORT_SYMBOL(__stack_smash_handler);
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
