Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262911AbTHUUw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbTHUUw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:52:29 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:10133 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262911AbTHUUwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:52:25 -0400
Subject: [PATCH] Pentium Pro - sysenter - doublefault
From: Jim Houston <jim.houston@comcast.net>
Reply-To: jim.houston@comcast.net
To: linux-kernel@vger.kernel.org
Cc: jim.houston@ccur.com
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1061498486.3072.308.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Aug 2003 16:41:26 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I upgraded my Pentium Pro system to Redhat 9, installed a
linux-2.6.0-test3 kernel, and it fails with a double-fault when
init starts.

The code which decides if it is o.k. to use sysenter is broken for
some Pentium Pro cpus ,in particular, this bit of code from
arch/i386/kernel/cpu/intel.c:

	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
	if ( c->x86 == 6 && c->x86_model < 3 && c->x86_mask < 3 )
		clear_bit(X86_FEATURE_SEP, c->x86_capability);

On my cpu model=1 and mask=9, it doesn't clear 86_FEATURE_SEP.
This results in a double-fault when init starts.  The double-fault
happens on the sysexit.  The new double-fault handler caught this
nicely, and I was able to debug this with kgdb.

The logic above is exactly what Intel says to do in "IA-32 Intel®
Architecture Software Developer's Manual, Volume 2: Instruction Set
Reference" on page 3-767.  It also says that sysenter was added to the
Pentium II.

I checked the Pentium Pro and Pentium II Specifications Update manuals
hoping to find the details to justify the "mask < 3" portion of the test
above. They both describe sysenter related errata but none which was
fixed in mask 3.

The attached patch avoids using sysenter on all Pentium Pro systems.

Jim Houston - Concurrent Computer Corp.


diff -urN linux-2.6.0-test3.orig/arch/i386/kernel/cpu/intel.c
linux-2.6.0-test3.new/arch/i386/kernel/cpu/intel.c
--- linux-2.6.0-test3.orig/arch/i386/kernel/cpu/intel.c	2003-08-20
10:30:14.000000000 -0400
+++ linux-2.6.0-test3.new/arch/i386/kernel/cpu/intel.c	2003-08-21
14:39:35.000000000 -0400
@@ -246,7 +246,7 @@
 	}
 
 	/* SEP CPUID bug: Pentium Pro reports SEP but doesn't have it */
-	if ( c->x86 == 6 && c->x86_model < 3 && c->x86_mask < 3 )
+	if ( c->x86 == 6 && c->x86_model < 3)
 		clear_bit(X86_FEATURE_SEP, c->x86_capability);
 	
 	/* Names for the Pentium II/Celeron processors 




