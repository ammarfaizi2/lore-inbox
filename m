Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265115AbUANIbh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUANIbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:31:37 -0500
Received: from pD9E5637F.dip.t-dialin.net ([217.229.99.127]:14208 "EHLO
	averell.firstfloor.org") by vger.kernel.org with ESMTP
	id S265115AbUANIbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:31:32 -0500
Date: Wed, 14 Jan 2004 09:31:14 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org, jh@suse.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Add noinline attribute
Message-ID: <20040114083114.GA1784@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


do_test_wp_bit cannot be inlined, otherwise the kernel doesn't boot
because the exception tables get reordered. 

Add a new noinline attribute to compiler.h and use it.

This patch is needed for the next unit-at-a-time patch. 

-Andi

diff -u linux-34/arch/i386/mm/init.c-o linux-34/arch/i386/mm/init.c
--- linux-34/arch/i386/mm/init.c-o	2004-01-09 09:27:09.000000000 +0100
+++ linux-34/arch/i386/mm/init.c	2004-01-13 22:19:19.000000000 +0100
@@ -555,7 +555,7 @@
  * This function cannot be __init, since exceptions don't work in that
  * section.  Put this after the callers, so that it cannot be inlined.
  */
-static int do_test_wp_bit(void)
+static int noinline do_test_wp_bit(void)
 {
 	char tmp_reg;
 	int flag;
diff -u linux-34/include/linux/compiler.h-o linux-34/include/linux/compiler.h
--- linux-34/include/linux/compiler.h-o	2003-11-24 04:46:36.000000000 +0100
+++ linux-34/include/linux/compiler.h	2004-01-13 22:17:26.000000000 +0100
@@ -76,6 +76,10 @@
 # define __attribute_pure__	/* unimplemented */
 #endif
 
+#ifndef noinline
+#define noinline
+#endif
+
 /* Optimization barrier */
 #ifndef barrier
 # define barrier() __memory_barrier()
diff -u linux-34/include/linux/compiler-gcc3.h-o linux-34/include/linux/compiler-gcc3.h
--- linux-34/include/linux/compiler-gcc3.h-o	2003-09-28 10:53:23.000000000 +0200
+++ linux-34/include/linux/compiler-gcc3.h	2004-01-13 22:36:22.000000000 +0100
@@ -20,3 +22,7 @@
 #endif
 
 #define __attribute_pure__	__attribute__((pure))
+
+#if __GNUC_MINOR__ >= 1
+#define  noinline __attribute__((noinline))
+#endif
