Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWGGRNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWGGRNP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWGGRNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 13:13:15 -0400
Received: from mga03.intel.com ([143.182.124.21]:11341 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932197AbWGGRNO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 13:13:14 -0400
X-IronPort-AV: i="4.06,218,1149490800"; 
   d="scan'208"; a="62718745:sNHT9580022291"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Date: Fri, 7 Jul 2006 10:10:39 -0700
Message-ID: <617E1C2C70743745A92448908E030B2A300BEC@scsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Thread-Index: AcahdpcdJ0jzipOIQDWW1pdLF8Ht5wAb8IDQ
From: "Luck, Tony" <tony.luck@intel.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, "Adrian Bunk" <bunk@stusta.de>
Cc: <kai@germaschewski.name>, <linux-kernel@vger.kernel.org>,
       "Dave Jones" <davej@redhat.com>, <linux-arch@vger.kernel.org>
X-OriginalArrivalTime: 07 Jul 2006 17:10:41.0154 (UTC) FILETIME=[465BBE20:01C6A1E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch broke (-rc1):
> 
> sparc allnoconfig build
> ia64 allnoconfig build
> ppc64 allnoconfig build

ia64 allnoconfig is (and has been for a while) broken for other reasons.

Almost all of the real configurations still build.  The only error
that adding this turned up was building a generic uniprocessor config.

smp_call_function_single() is used without a prototype by
arch/ia64/sn/kernel/sn2/sn_hwperf.c:sn_hwperf_op_cpu()

This isn't a real error because this function actually does return
an "int", so the complier default is correct (plus the caller doesn't
look at the return value, plus on a UP we'd never be able to get to
this call-site because it is in the "else" !!!).

But I'll fix it anyway.

diff --git a/include/asm-ia64/smp.h b/include/asm-ia64/smp.h
index 719ff30..949e3a2 100644
--- a/include/asm-ia64/smp.h
+++ b/include/asm-ia64/smp.h
@@ -133,6 +133,7 @@ #else
 
 #define cpu_logical_id(i)		0
 #define cpu_physical_id(i)		ia64_get_lid()
+#define smp_call_function_single(cpuid, func, info, retry, wait) 0
 
 #endif /* CONFIG_SMP */
 #endif /* _ASM_IA64_SMP_H */

-Tony
