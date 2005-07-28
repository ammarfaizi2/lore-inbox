Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVG1RMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVG1RMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVG1RMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:12:32 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:29320 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261696AbVG1RKv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:10:51 -0400
Message-ID: <42E91191.60603@cosmosbay.com>
Date: Thu, 28 Jul 2005 19:10:41 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64 : prefetchw() can fall back to prefetch() if !3DNOW
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com> <86802c44050728092275e28a9a@mail.gmail.com>
In-Reply-To: <86802c44050728092275e28a9a@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------000207070800090802020608"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Thu, 28 Jul 2005 19:10:40 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000207070800090802020608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] x86_64 : prefetchw() can fall back to prefetch() if !3DNOW

If the cpu lacks 3DNOW feature, we can use a normal prefetcht0 instruction instead of NOP5.
"prefetchw (%rxx)" and "prefetcht0 (%rxx)" have the same length, ranging from 3 to 5 bytes
depending on the register. So this patch even helps AMD64, shortening the length of the code.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------000207070800090802020608
Content-Type: text/plain;
 name="x86_64.prefetchw"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x86_64.prefetchw"

--- linux-2.6.13-rc3/include/asm-x86_64/processor.h	2005-07-13 06:46:46.000000000 +0200
+++ linux-2.6.13-rc3-ed/include/asm-x86_64/processor.h	2005-07-28 18:47:39.000000000 +0200
@@ -398,7 +398,7 @@
 #define ARCH_HAS_PREFETCHW 1
 static inline void prefetchw(void *x) 
 { 
-	alternative_input(ASM_NOP5,
+	alternative_input("prefetcht0 (%1)",
 			  "prefetchw (%1)",
 			  X86_FEATURE_3DNOW,
 			  "r" (x));

--------------000207070800090802020608--
