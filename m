Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269710AbTGJXgW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269711AbTGJXgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:36:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:16821 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269710AbTGJXgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:36:20 -0400
Message-ID: <3F0DFA3A.10200@us.ibm.com>
Date: Thu, 10 Jul 2003 16:43:54 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [trivial][patch] no more warnings! [1/3] zap_low_mappings
Content-Type: multipart/mixed;
 boundary="------------000508090000070408030004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000508090000070408030004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

acpi_restore_state_mem() in arch/i386/kernel/acpi/sleep.c uses 
zap_low_mappings() and isn't SMP-specific.  zap_low_mappings() is 
extern'd in include/asm-i386/smp.h, but wrapped in CONFIG_SMP ifdefs. 
This should be exported for non-CONFIG_SMP as well.  This patch does that.

Cheers!

-Matt

--------------000508090000070408030004
Content-Type: text/plain;
 name="zap_low_mappings-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zap_low_mappings-warning.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.5.74-vanilla/include/asm-i386/smp.h linux-2.5.74-warnings/include/asm-i386/smp.h
--- linux-2.5.74-vanilla/include/asm-i386/smp.h	Thu Jul 10 11:49:47 2003
+++ linux-2.5.74-warnings/include/asm-i386/smp.h	Thu Jul 10 14:37:35 2003
@@ -8,10 +8,8 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>
-#endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
-#ifndef __ASSEMBLY__
 #include <asm/fixmap.h>
 #include <asm/bitops.h>
 #include <asm/mpspec.h>
@@ -20,7 +18,9 @@
 #endif
 #include <asm/apic.h>
 #endif
-#endif
+
+extern void zap_low_mappings (void);
+#endif /* !__ASSEMBLY__ */
 
 #define BAD_APICID 0xFFu
 #ifdef CONFIG_SMP
@@ -43,7 +43,6 @@ extern void smp_message_irq(int cpl, voi
 extern void smp_send_reschedule(int cpu);
 extern void smp_invalidate_rcv(void);		/* Process an NMI */
 extern void (*mtrr_hook) (void);
-extern void zap_low_mappings (void);
 
 #define MAX_APICID 256
 
@@ -106,8 +105,6 @@ static __inline int logical_smp_processo
 
 #endif
 #endif /* !__ASSEMBLY__ */
-
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
-
-#endif
+#endif /* CONFIG_SMP */
 #endif

--------------000508090000070408030004--

