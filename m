Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267239AbUBNBBT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 20:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267237AbUBNBBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 20:01:19 -0500
Received: from palrel13.hp.com ([156.153.255.238]:61649 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S267248AbUBNA67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 19:58:59 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16429.29392.529575.21798@napali.hpl.hp.com>
Date: Fri, 13 Feb 2004 16:58:56 -0800
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org,
       wilson@specifixinc.com
Subject: Re: Kernel Cross Compiling
In-Reply-To: <20040213214420.GA32006@MAIL.13thfloor.at>
References: <20040213205743.GA30245@MAIL.13thfloor.at>
	<16429.16944.521739.223708@napali.hpl.hp.com>
	<20040213214420.GA32006@MAIL.13thfloor.at>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 13 Feb 2004 22:44:20 +0100, Herbert Poetzl <herbert@13thfloor.at> said:

  >> A recipe for building ia32->ia64 cross-toolchain on Debian can be
  >> found here:

  >> http://www.gelato.unsw.edu.au/IA64wiki/CrossCompilation

  Herbert> that might work with the ia64 libraries and headers, but it
  Herbert> seems to fail, with the headers included in the gcc
  Herbert> tarball, for cross compiling, if you get it to compile
  Herbert> without (g)libc which should not be required to build the
  Herbert> crossgcc and the kernel, I would be very interested ...

Ah, I see now what you mean.  I suspect that's a setup that's rarely
tested, so I'm not surprised to see some breakage.

Having said that, I got gcc v3.3.3 20031212 (prerelease) to build with
minor tweaks (see patch below).  I'm no GCC-built-environment expert
and I'm quite certain that the patch isn't totally correct, but all
the unwind-related stuff isn't really needed in your case, because
that code only comes into play for exception-handling and C cleanup
handlers.

The unwind-sjlj.c problem should occur on most other platforms too, so
I don't think that problem is ia64-specific.

	--david

Index: gcc/unwind-sjlj.c
===================================================================
RCS file: /cvs/gcc/gcc/gcc/unwind-sjlj.c,v
retrieving revision 1.11.2.2
diff -u -r1.11.2.2 unwind-sjlj.c
--- gcc/unwind-sjlj.c	2 May 2003 21:01:21 -0000	1.11.2.2
+++ gcc/unwind-sjlj.c	14 Feb 2004 00:50:33 -0000
@@ -22,7 +22,9 @@
 #include "tconfig.h"
 #include "tsystem.h"
 #include "unwind.h"
+#ifndef inhibit_libc
 #include "gthr.h"
+#endif
 
 #ifdef __USING_SJLJ_EXCEPTIONS__
 
Index: gcc/unwind.h
===================================================================
RCS file: /cvs/gcc/gcc/gcc/unwind.h,v
retrieving revision 1.7.2.6
diff -u -r1.7.2.6 unwind.h
--- gcc/unwind.h	4 Sep 2003 09:39:44 -0000	1.7.2.6
+++ gcc/unwind.h	14 Feb 2004 00:50:33 -0000
@@ -195,7 +195,9 @@
    compatible with the standard ABI for IA-64, we inline these.  */
 
 #ifdef __ia64__
-#include <stdlib.h>
+# ifndef inhibit_libc
+#  include <stdlib.h>
+# endif
 
 static inline _Unwind_Ptr
 _Unwind_GetDataRelBase (struct _Unwind_Context *_C)
Index: gcc/config/ia64/fde-glibc.c
===================================================================
RCS file: /cvs/gcc/gcc/gcc/config/ia64/fde-glibc.c,v
retrieving revision 1.5
diff -u -r1.5 fde-glibc.c
--- gcc/config/ia64/fde-glibc.c	15 Dec 2001 11:46:51 -0000	1.5
+++ gcc/config/ia64/fde-glibc.c	14 Feb 2004 00:50:34 -0000
@@ -31,6 +31,9 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
+
+#ifndef inhibit_libc
+
 #include "config.h"
 #include <stddef.h>
 #include <stdlib.h>
@@ -162,3 +165,5 @@
 
   return data.ret;
 }
+
+#endif
Index: gcc/config/ia64/linux.h
===================================================================
RCS file: /cvs/gcc/gcc/gcc/config/ia64/linux.h,v
retrieving revision 1.23
diff -u -r1.23 linux.h
--- gcc/config/ia64/linux.h	3 Sep 2002 21:09:54 -0000	1.23
+++ gcc/config/ia64/linux.h	14 Feb 2004 00:50:34 -0000
@@ -58,7 +58,7 @@
 /* Do code reading to identify a signal frame, and set the frame
    state data appropriately.  See unwind-dw2.c for the structs.  */
 
-#ifdef IN_LIBGCC2
+#ifdef x_IN_LIBGCC2
 #include <signal.h>
 #include <sys/ucontext.h>
 
