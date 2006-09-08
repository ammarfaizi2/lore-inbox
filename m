Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWIHW4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWIHW4A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWIHWzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:36 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:20619 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751247AbWIHWz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:55:29 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225529.9340.75338.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 10/10] check pr_debug() arguments
Date: Fri,  8 Sep 2006 15:55:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

check pr_debug() arguments

When DEBUG isn't defined pr_debug() is defined away as an empty macro.  By
throwing away the arguments we allow completely incorrect code to build.

Instead let's make it an empty inline which checks arguments and mark it so gcc
can check the format specification.

This results in a seemingly insignificant code size increase.  A x86-64
allyesconfig:

   text    data     bss     dec     hex filename
25354768        7191098 4854720 37400586        23ab00a vmlinux.before
25354945        7191138 4854720 37400803        23ab0e3 vmlinux

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 include/linux/kernel.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: 2.6.18-rc6-debug-args/include/linux/kernel.h
===================================================================
--- 2.6.18-rc6-debug-args.orig/include/linux/kernel.h
+++ 2.6.18-rc6-debug-args/include/linux/kernel.h
@@ -214,8 +214,10 @@ extern void dump_stack(void);
 #define pr_debug(fmt,arg...) \
 	printk(KERN_DEBUG fmt,##arg)
 #else
-#define pr_debug(fmt,arg...) \
-	do { } while (0)
+static inline int __attribute__ ((format (printf, 1, 2))) pr_debug(const char * fmt, ...)
+{
+	return 0;
+}
 #endif
 
 #define pr_info(fmt,arg...) \
