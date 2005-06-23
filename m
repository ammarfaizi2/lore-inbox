Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262674AbVFWJnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbVFWJnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVFWJir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:38:47 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:16568 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S262269AbVFWJhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:37:32 -0400
Message-ID: <42BA82E4.3040801@cosmosbay.com>
Date: Thu, 23 Jun 2005 11:37:40 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 prefetchw() function can take into account CONFIG_MK8
 / CONFIG_MPSC
References: <20050622.132241.21929037.davem@davemloft.net> <200506222242.j5MMgbxS009935@guinness.s2io.com> <20050622231300.GC14251@wotan.suse.de> <42BA81B2.4070108@cosmosbay.com>
In-Reply-To: <42BA81B2.4070108@cosmosbay.com>
Content-Type: multipart/mixed;
 boundary="------------000902070703080901010100"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 23 Jun 2005 11:37:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000902070703080901010100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

If we build a x86_64 kernel for an AMD64 or for an Intel EMT64, no need to use alternative_input.
Reserve alternative_input only for a generic kernel.

Thank you

Eric Dumazet

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>


--------------000902070703080901010100
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

--------------000902070703080901010100--
