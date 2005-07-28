Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262105AbVG1TVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262105AbVG1TVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbVG1TSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:18:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2241 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262105AbVG1TSU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:18:20 -0400
Subject: [PATCH] re-disable TSC on NUMAQ
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-rKLyw7FX67ojKHzWT6Uo"
Date: Thu, 28 Jul 2005 12:18:13 -0700
Message-Id: <1122578293.20800.42.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rKLyw7FX67ojKHzWT6Uo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Somewhere recently, the TSC got re-enabled for timekeeping on NUMAQ
machines.  However, the hardware makes these get unsynchronized quite
badly.  So badly, in fact, that the code to fix up the skew can just
hang on boot.

This patch re-disables them.  It's nicely confined to the numaq.c file.
It would be great if this could make it into 2.6.13, I think it counts
as a bugfix.

Tested on a 16-proc 4-node NUMAQ.

-- Dave

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

 memhotplug-dave/arch/i386/kernel/numaq.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN arch/i386/mach-default/setup.c~numaq-tsc-disable arch/i386/mach-default/setup.c
diff -L arch/i386/mach-default/setup.c.orig -puN /dev/null /dev/null
diff -L p -puN /dev/null /dev/null
diff -puN arch/i386/kernel/numaq.c~numaq-tsc-disable arch/i386/kernel/numaq.c
--- memhotplug/arch/i386/kernel/numaq.c~numaq-tsc-disable	2005-07-28 11:40:51.000000000 -0700
+++ memhotplug-dave/arch/i386/kernel/numaq.c	2005-07-28 11:50:59.000000000 -0700
@@ -31,6 +31,7 @@
 #include <linux/nodemask.h>
 #include <asm/numaq.h>
 #include <asm/topology.h>
+#include <asm/processor.h>
 
 #define	MB_TO_PAGES(addr) ((addr) << (20 - PAGE_SHIFT))
 
@@ -77,3 +78,11 @@ int __init get_memcfg_numaq(void)
 	smp_dump_qct();
 	return 1;
 }
+
+static int __init numaq_dsc_disable(void)
+{
+	printk(KERN_DEBUG "NUMAQ: disabling TSC\n");
+	tsc_disable = 1;
+	return 0;
+}
+core_initcall(numaq_dsc_disable);
_


--=-rKLyw7FX67ojKHzWT6Uo
Content-Disposition: attachment; filename=numaq-tsc-disable.patch
Content-Type: text/x-patch; name=numaq-tsc-disable.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- linux-2.6/arch/i386/mach-default/setup.c.orig	2005-07-28 11:34:27.000000000 -0700
+++ linux-2.6/arch/i386/mach-default/setup.c	2005-07-28 11:35:33.000000000 -0700
@@ -66,6 +66,9 @@
  **/
 void __init pre_setup_arch_hook(void)
 {
+#ifdef CONFIG_X86_NUMAQ
+	tsc_disable = 1;
+#endif
 }
 
 /**

--=-rKLyw7FX67ojKHzWT6Uo--

