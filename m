Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030345AbWI1SQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWI1SQS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 14:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWI1SQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 14:16:17 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:51650 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751979AbWI1SQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 14:16:15 -0400
Message-Id: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       dhollis@davehollis.com, Jason Lunz <lunz@falooley.org>
Subject: [PATCH 2/2] UML - Don't roll my own random MAC generator
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Sep 2006 14:14:54 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing random_ether_addr() instead of cooking up my own
version.  Pointed out by Dave Hollis and Jason Lunz.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---

 arch/um/drivers/net_kern.c |    4 +---
 arch/um/drivers/net_user.c |   29 -----------------------------
 arch/um/include/net_user.h |    2 --
 3 files changed, 1 insertion(+), 34 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_kern.c	2006-09-28 12:51:50.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/net_kern.c	2006-09-28 13:00:58.000000000 -0400
@@ -309,9 +309,7 @@ static void setup_etheraddr(char *str, u
 	return;
 
 random:
-	addr[0] = 0xfe;
-	addr[1] = 0xfd;
-	random_mac(addr);
+	random_ether_addr(addr)
 }
 
 static DEFINE_SPINLOCK(devices_lock);
Index: linux-2.6.18-mm/arch/um/drivers/net_user.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/net_user.c	2006-09-28 12:51:50.000000000 -0400
+++ linux-2.6.18-mm/arch/um/drivers/net_user.c	2006-09-28 13:00:06.000000000 -0400
@@ -259,32 +259,3 @@ char *split_if_spec(char *str, ...)
 	va_end(ap);
 	return str;
 }
-
-void random_mac(unsigned char *addr)
-{
-	struct timeval tv;
-	long n;
-	unsigned int seed;
-
-	gettimeofday(&tv, NULL);
-
-	/* Assume that 20 bits of microseconds and 12 bits of the pid are
-	 * reasonably unpredictable.
-	 */
-	seed = tv.tv_usec | (os_getpid() << 20);
-	srandom(seed);
-
-	/* Don't care about endianness here - switching endianness
-	 * just rearranges what are hopefully random numbers.
-	 *
-	 * Assume that RAND_MAX > 65536, so random is called twice and
-	 * we use 16 bits of the result.
-	 */
-	n = random();
-	addr[2] = (n >> 8) & 255;
-	addr[3] = n % 255;
-
-	n = random();
-	addr[4] = (n >> 8) & 255;
-	addr[5] = n % 255;
-}
Index: linux-2.6.18-mm/arch/um/include/net_user.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/net_user.h	2006-09-28 12:15:48.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/net_user.h	2006-09-28 13:01:51.000000000 -0400
@@ -50,6 +50,4 @@ extern char *split_if_spec(char *str, ..
 
 extern int dev_netmask(void *d, void *m);
 
-extern void random_mac(unsigned char *addr);
-
 #endif

