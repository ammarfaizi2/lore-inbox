Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVAOIKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVAOIKn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 03:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVAOIKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 03:10:43 -0500
Received: from cc15144-a.groni1.gr.home.nl ([217.120.147.78]:12411 "HELO
	boetes.org") by vger.kernel.org with SMTP id S262145AbVAOIK2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 03:10:28 -0500
Date: Sat, 15 Jan 2005 09:10:21 +0100
From: Han Boetes <han@mijncomputer.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: propolice support for linux
Message-ID: <20050115081043.GO14127@boetes.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050113134620.GA14127@boetes.org> <20050113140446.GA22381@infradead.org> <20050113163733.GB14127@boetes.org> <20050114042542.GB64314@gaz.sfgoth.com> <20050114103051.GJ14127@boetes.org> <20050115022540.GA85319@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050115022540.GA85319@gaz.sfgoth.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> Last nitpicks, I swear:

*g* Would we have created the perfect code ;-)

> Han Boetes wrote:
> > +    panic("propolice detects %x at function %s.\n", damaged, func);
>
> You don't need the "\n" at the end - panic() already includes a
> newline Most panic() messages don't seem to have punctuation
> either so you can probably lose the "." too.
>
> Also it's nice to use "0x%X" to print hex numbers so they don't
> ever get misinterpreted as decimals.

Ok, here goes the final version, dear mailinglist-archive-delver.
I hope you found this version and didn't stop looking at the first
hit you found on google. Do read the whole thread, there are some
very knowledgeable people giving their opinion.


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
--- linux-2.6.9/lib/propolice.c.orig	2005-01-13 17:08:49.920963760 +0100
+++ linux-2.6.9/lib/propolice.c	2005-01-14 11:23:14.786142384 +0100
@@ -0,0 +1,22 @@
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
+unsigned char __guard[sizeof(int)] = {'\0', '\0', '\n', (unsigned char) -1};
+EXPORT_SYMBOL(__guard);
+
+void __stack_smash_handler(unsigned int damaged, const char *func)
+{
+    panic("propolice detects 0x%X at function %s", damaged, func);
+}
+EXPORT_SYMBOL(__stack_smash_handler);



# Han
