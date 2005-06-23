Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVFWJss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVFWJss (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVFWJpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:45:04 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:44471 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262627AbVFWJci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:32:38 -0400
Message-ID: <42BA81B2.4070108@cosmosbay.com>
Date: Thu, 23 Jun 2005 11:32:34 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 prefetchw() function can take into account CONFIG_MK8
 / CONFIG_MPSC 
References: <20050622.132241.21929037.davem@davemloft.net> <200506222242.j5MMgbxS009935@guinness.s2io.com> <20050622231300.GC14251@wotan.suse.de>
In-Reply-To: <20050622231300.GC14251@wotan.suse.de>
Content-Type: multipart/mixed;
 boundary="------------080701060704080303000906"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 23 Jun 2005 11:32:22 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080701060704080303000906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If we build a x86_64 kernel for an AMD64 or for an Intel EMT64, no need to use alternative_input.
Reserve alternative_input only for a generic kernel.





--------------080701060704080303000906
Content-Type: text/plain;
 name="patch.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.2"

diff -Nru linux-2.6.12/include/asm-x86_64/processor.h linux-2.6.12-orig/include/asm-x86_64/processor.h
--- linux-2.6.12-orig/include/asm-x86_64/processor.h 2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.12/include/asm-x86_64/processor.h       2005-06-23 11:20:08.000000000 +0200
@@ -389,10 +389,21 @@
 #define ARCH_HAS_PREFETCHW 1
 static inline void prefetchw(void *x)
 {
+#if defined(CONFIG_MK8)
+       /* AMD64 / MK8 has 3DNOW, we can emit a true prefetchw, using a "m" in the asm input */
+       asm volatile("prefetchw %0" :: "m" (*(unsigned long *)x));
+#elif defined(CONFIG_MPSC)
+       /* Intel EMT64 does not have 3DNOW, no prefetchw instruction */
+#else
+       /* If we build a generic X86_64 kernel,
+        * we must use alternative_input() and a "r" asm constraint to make sure
+        * the size of the instruction will be <= 5
+        */
        alternative_input(ASM_NOP5,
                          "prefetchw (%1)",
                          X86_FEATURE_3DNOW,
                          "r" (x));
+#endif
 }

 #define ARCH_HAS_SPINLOCK_PREFETCH 1

--------------080701060704080303000906--
