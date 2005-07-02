Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVGBC7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVGBC7S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 22:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVGBC7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 22:59:18 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:12760 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S261698AbVGBC7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 22:59:08 -0400
Date: Fri, 1 Jul 2005 22:57:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC] exit_thread() speedups in x86 process.c
To: "cutaway@bellsouth.net" <cutaway@bellsouth.net>,
       "Denis Vlasenko" <vda@ilport.com.ua>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Coywolf Qi Hunt" <coywolf@gmail.com>
Message-ID: <200507012258_MC3-1-A340-3A81@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jun 2005 at 04:41:47 -0400, cutaway wrote:

> The compilers got tweaked to be able to emit
> function code to different text sections and a massive system wide code
> triage was undertaken based on "common usage scenario" profiling run data
> from the perf analysis group.

  Linux scheduler code is in its own text section already, but
that might be for profiling the code instead of for performance.
(Look for "__sched" in the source code.)

  The gains may not be as much as you think since on X86 and at least
some other archs the entire kernel is in one large page.  Still, it's
got to make some kind of sense to put infrequently-used code in its
own section just to reduce cache pollution.

  I came up with this but only the "__slow" part really makes sense:


--- 2.6.12.1/arch/i386/kernel/vmlinux.lds.S     2004-09-03 19:55:27.000000000 -0400
+++ 2.6.12.1-ce1/arch/i386/kernel/vmlinux.lds.S 2005-06-26 01:48:23.770212000 -0400
@@ -16,9 +16,11 @@ SECTIONS
   /* read-only */
   _text = .;                   /* Text and read-only data */
   .text : {
+       *(.fast.text)
        *(.text)
        SCHED_TEXT
        LOCK_TEXT
+       *(.slow.text)
        *(.fixup)
        *(.gnu.warning)
        } = 0x9090
--- 2.6.12.1/arch/x86_64/kernel/vmlinux.lds.S   2005-06-24 00:50:21.180212000 -0400
+++ 2.6.12.1-ce1/arch/x86_64/kernel/vmlinux.lds.S       2005-06-26 01:50:09.100212000 -0400
@@ -15,9 +15,11 @@ SECTIONS
   phys_startup_64 = startup_64 - LOAD_OFFSET;
   _text = .;                   /* Text and read-only data */
   .text : {
+       *(.fast.text)
        *(.text)
        SCHED_TEXT
        LOCK_TEXT
+       *(.slow.text)
        *(.fixup)
        *(.gnu.warning)
        } = 0x9090
--- 2.6.12.1/include/linux/init.h       2005-01-04 21:48:02.000000000 -0500
+++ 2.6.12.1-ce1/include/linux/init.h   2005-06-26 01:59:29.580212000 -0400
@@ -46,6 +46,17 @@
 #define __exitdata     __attribute__ ((__section__(".exit.data")))
 #define __exit_call    __attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
+/*
+ * Probably belongs in some other header (compiler.h?)
+ */
+#ifdef CONFIG_X86
+#define __fast         __attribute__ ((__section__(".fast.text")))
+#define __slow         __attribute__ ((__section__(".slow.text")))
+#else
+#define __fast
+#define __slow
+#endif
+
 #ifdef MODULE
 #define __exit         __attribute__ ((__section__(".exit.text")))
 #else

--
Chuck
