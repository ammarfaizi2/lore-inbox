Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUFXHKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUFXHKJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 03:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbUFXHKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 03:10:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:30177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263309AbUFXHKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 03:10:01 -0400
Date: Thu, 24 Jun 2004 09:09:36 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: using gcc built-ins for bitops?
Message-ID: <20040624070936.GB30057@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

gcc 3.4 gained support for several typical bitops as builtin directives.
Using these over inline asm has a few advantages:
* gcc can optimize constants into these better
* gcc can reorder and schedule the code better
* gcc can allocate registers etc better for the code

The question is if we consider it desirable to go down this road or not. In
order to help that discussion I've attached a patch below that switches the
i386 ffz() function to the gcc builtin version, conditional on gcc having
support for this. Before I go down the road of converting more functions
and/or architectures.... is this worth doing?

Greetings,
   Arjan van de Ven


--- linux-2.6.7/include/asm-i386/bitops.h~	2004-06-23 23:45:06.048614387 +0200
+++ linux-2.6.7/include/asm-i386/bitops.h	2004-06-23 23:45:06.048614387 +0200
@@ -344,6 +344,8 @@
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
+ 
+#ifndef HAVE_BUILTIN_CTZL
 static inline unsigned long ffz(unsigned long word)
 {
 	__asm__("bsfl %1,%0"
@@ -351,6 +353,12 @@
 		:"r" (~word));
 	return word;
 }
+#else
+static inline unsigned long ffz (unsigned long word) 
+{ 
+	return __builtin_ctzl (~word); 
+}
+#endif
 
 /**
  * __ffs - find first bit in word.
--- linux-2.6.7/include/linux/compiler-gcc3.h~	2004-06-24 09:26:04.123455290 +0200
+++ linux-2.6.7/include/linux/compiler-gcc3.h	2004-06-24 09:26:04.123455290 +0200
@@ -19,6 +19,11 @@
 # define __attribute_used__	__attribute__((__unused__))
 #endif
 
+#if __GNUC_MINOR__ >= 4
+#define HAVE_BUILTIN_CTZL
+#endif
+
+
 #define __attribute_pure__	__attribute__((pure))
 #define __attribute_const__	__attribute__((__const__))
 
