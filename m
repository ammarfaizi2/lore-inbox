Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbUKXQyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbUKXQyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 11:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbUKXQxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 11:53:19 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:49567 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261486AbUKXQug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 11:50:36 -0500
Subject: [PATCH] Work around for periodic do_gettimeofday hang
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Nov 2004 10:49:42 -0600
Message-Id: <1101314988.1714.194.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the voyager systems particularly (but also on some of my slower
parisc boxes) I periodically get hangs where the system just seems to
stop (although it does remain able to execute alt-sysrq).  The traces
always seem to implicate do_gettimeofday in the xtime seqlock.

I've not been able to trace an exact cause for this, but it does seem to
be pretty much eliminated by lowering the clock speed to 100HZ.  I
propose the following patch to do this for the slower intel processors
(basically pentiums and below)

James

--

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

===== include/asm-i386/param.h 1.6 vs edited =====
--- 1.6/include/asm-i386/param.h	2004-06-24 03:55:46 -05:00
+++ edited/include/asm-i386/param.h	2004-11-22 18:36:42 -06:00
@@ -1,8 +1,15 @@
 #ifndef _ASMi386_PARAM_H
 #define _ASMi386_PARAM_H
 
+#include <linux/config.h>
+
 #ifdef __KERNEL__
-# define HZ		1000		/* Internal kernel timer frequency */
+# if defined(CONFIG_M386) || defined(CONFIG_M486) || defined(CONFIG_M586) \
+     || defined(CONFIG_M586TSC) || defined(CONFIG_M586MMX)
+#  define HZ		100
+# else
+#  define HZ		1000		/* Internal kernel timer frequency */
+# endif
 # define USER_HZ	100		/* .. some user interfaces are in "ticks" */
 # define CLOCKS_PER_SEC		(USER_HZ)	/* like times() */
 #endif

