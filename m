Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTEWJPK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 05:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTEWJPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 05:15:09 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:62162 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S263976AbTEWJPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 05:15:03 -0400
Subject: Re: [PATCH] Shared crc32 for 2.4.
From: David Woodhouse <dwmw2@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <1053637864.21582.700.camel@imladris.demon.co.uk>
References: <1053193432.9218.13.camel@imladris.demon.co.uk>
	 <20030521235033.GA2470@werewolf.able.es>
	 <1053637864.21582.700.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1053682083.3402.69.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Fri, 23 May 2003 10:28:03 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 22:11, David Woodhouse wrote:
> On Thu, 2003-05-22 at 00:50, J.A. Magallon wrote:
> > This works if crc32.o is compiled as a module, but does not work if it is
> > built into the kernel. For example, crc32_le symbol does not appear
> > in System.map nor vmlinux.
> 
> Oh bollocks; sorry I'd forgotten about that.
> 
> Added to the tree from which Marcelo will pull for 2.4.22-pre1...

I hereby declare myself to be Today's Official Mr Fuck All Good.

On top of that patch which fixes CONFIG_CRC32=y, you'll need this patch
which fixes CONFIG_CRC32=m, newly broken (at least with new modutils) by
the removal of the EXPORT_SYMBOL()s from crc32.o...·

Full patch against 2.4.21-rc3 is in
	ftp://ftp.??.kernel.org/pub/linux/kernel/people/dwmw2/crc32/

(and in master.kernel.org:~dwmw2/BK/crc32-2.4 still)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1216  -> 1.1217 
#	         lib/crc32.c	1.2     -> 1.3    
#	        lib/Makefile	1.11    -> 1.12   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/23	dwmw2@infradead.org	1.1217
# Fix CONFIG_CRC32=m by make crc32.o export its own symbols again in that case.
# --------------------------------------------
#
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Fri May 23 10:09:17 2003
+++ b/lib/Makefile	Fri May 23 10:09:17 2003
@@ -8,7 +8,8 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o rbtree.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o \
+	       rbtree.o crc32.o
 
 obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o \
 	 bust_spinlocks.o rbtree.o dump_stack.o
diff -Nru a/lib/crc32.c b/lib/crc32.c
--- a/lib/crc32.c	Fri May 23 10:09:17 2003
+++ b/lib/crc32.c	Fri May 23 10:09:17 2003
@@ -266,6 +266,13 @@
 	return x;
 }
 
+#ifdef MODULE /* These are exported from kernel/ksyms.c in the non-module
+		 case, to ensure that this file is pulled in from lib/lib.a */
+EXPORT_SYMBOL(crc32_le);
+EXPORT_SYMBOL(crc32_be);
+EXPORT_SYMBOL(bitreverse);
+#endif
+
 /*
  * A brief CRC tutorial.
  *




-- 
dwmw2

