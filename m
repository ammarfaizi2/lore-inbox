Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWHJUOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWHJUOV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWHJTf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:35:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:11499 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932375AbWHJTfj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:39 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [25/145] x86_64: Add macros for rdtscp
Message-Id: <20060810193538.6CF9913B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:38 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Vojtech Pavlik <vojtech@suse.cz>
This patch adds macros for reading tsc via the RDTSCP instruction, as well
as writing the auxilliary MSR read by RDTSCP to msr.h

[AK: changed rdtscp definition for old binutils]

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 include/asm-x86_64/msr.h |   11 +++++++++++
 1 files changed, 11 insertions(+)

Index: linux/include/asm-x86_64/msr.h
===================================================================
--- linux.orig/include/asm-x86_64/msr.h
+++ linux/include/asm-x86_64/msr.h
@@ -66,14 +66,25 @@
 #define rdtscl(low) \
      __asm__ __volatile__ ("rdtsc" : "=a" (low) : : "edx")
 
+#define rdtscp(low,high,aux) \
+     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (low), "=d" (high), "=c" (aux))
+
 #define rdtscll(val) do { \
      unsigned int __a,__d; \
      asm volatile("rdtsc" : "=a" (__a), "=d" (__d)); \
      (val) = ((unsigned long)__a) | (((unsigned long)__d)<<32); \
 } while(0)
 
+#define rdtscpll(val, aux) do { \
+     unsigned long __a, __d; \
+     asm volatile (".byte 0x0f,0x01,0xf9" : "=a" (__a), "=d" (__d), "=c" (aux)); \
+     (val) = (__d << 32) | __a; \
+} while (0)
+
 #define write_tsc(val1,val2) wrmsr(0x10, val1, val2)
 
+#define write_rdtscp_aux(val) wrmsr(0xc0000103, val, 0)
+
 #define rdpmc(counter,low,high) \
      __asm__ __volatile__("rdpmc" \
 			  : "=a" (low), "=d" (high) \
