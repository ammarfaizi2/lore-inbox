Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271824AbTHHTl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271834AbTHHTl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 15:41:26 -0400
Received: from sponsa.its.uu.se ([130.238.7.36]:60056 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id S271824AbTHHTlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 15:41:21 -0400
Date: Fri, 8 Aug 2003 21:41:13 +0200 (MEST)
Message-Id: <200308081941.h78JfDKa029002@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: jgarzik@pobox.com
Subject: Re: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Aug 2003 09:15:03 -0400, Jeff Garzik wrote:
>> If you change NCAPINTS you also have to change the hardcoded
>> struct offset X86_VENDOR_ID in arch/i386/kernel/head.S. Otherwise
>> nasty stuff happen at boot since boot_cpu_data gets broken.
>
>
>hmmm, reality doesn't seem to bear that out...  I made the same change 
>to 2.6, without touching head.S, and life continues without "nasty 
>stuff" AFAICS.
>
>Do both 2.4 and 2.6 need this change?  And, why didn't 2.6 break?

2.4.21-rc1 with NCAPINTS==6 hangs at boot in the local
APIC timer calibration step; before that it detected a
0MHz bus clock and the local APIC NMI watchdog was stuck.
Correcting head.S:X86_VENDOR_ID fixes these problems.

Without correcting head.S:X86_VENDOR_ID, head.S will store
the vendor id partly in the capabilities array. This breaks
both the capabilities and the vendor id. I can't say why 2.6
works, but obviously the CPU setup code has changed since 2.4.

BTW, the patch below should be applied to 2.6.

/Mikael

--- linux-2.6.0-test2/arch/i386/kernel/head.S.~1~	2003-05-28 22:15:58.000000000 +0200
+++ linux-2.6.0-test2/arch/i386/kernel/head.S	2003-08-08 21:12:42.000000000 +0200
@@ -35,7 +35,7 @@
 #define X86_HARD_MATH	CPU_PARAMS+6
 #define X86_CPUID	CPU_PARAMS+8
 #define X86_CAPABILITY	CPU_PARAMS+12
-#define X86_VENDOR_ID	CPU_PARAMS+28
+#define X86_VENDOR_ID	CPU_PARAMS+36
 
 /*
  * Initialize page tables
