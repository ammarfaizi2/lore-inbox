Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTEXRYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 13:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbTEXRYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 13:24:09 -0400
Received: from verein.lst.de ([212.34.189.10]:50562 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262331AbTEXRYI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 13:24:08 -0400
Date: Sat, 24 May 2003 19:37:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make vt_ioctl ix86isms explicit
Message-ID: <20030524173713.GA4939@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_ioperm is only implemented on x86 (i386/x86_64).  Make the
ifdefs in vt_ioctl.c more explicit so the other architectures can
get rid of their stubs in favour of just using sys_ni_syscall in
the syscall table.  (Personally I still wonder why they added it
at all but that's another question..)


--- 1.23/drivers/char/vt_ioctl.c	Mon May 12 16:12:47 2003
+++ edited/drivers/char/vt_ioctl.c	Fri May 23 21:27:46 2003
@@ -59,7 +59,7 @@
  */
 unsigned char keyboard_type = KB_101;
 
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__mips__) && !defined(__arm__) && !defined(__sh__)
+#ifdef CONFIG_X86
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 #endif
 
@@ -424,11 +424,13 @@
 		ucval = keyboard_type;
 		goto setchar;
 
-#if !defined(__alpha__) && !defined(__ia64__) && !defined(__mips__) && !defined(__arm__) && !defined(__sh__)
 		/*
 		 * These cannot be implemented on any machine that implements
-		 * ioperm() in user level (such as Alpha PCs).
+		 * ioperm() in user level (such as Alpha PCs) or not at all.
+		 *
+		 * XXX: you should never use these, just call ioperm directly..
 		 */
+#ifdef CONFIG_X86
 	case KDADDIO:
 	case KDDELIO:
 		/*
