Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbTIGSgs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 14:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbTIGSgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 14:36:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34538 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261209AbTIGSgq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 14:36:46 -0400
Subject: [PATCH] fix Summit srat.h includes
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Patricia Gaughen <gone@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-khFaeiwQK9hvqPYua3pK"
Organization: 
Message-Id: <1062959739.27214.2174.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Sep 2003 11:35:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-khFaeiwQK9hvqPYua3pK
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I was compiling for my plain 'ol PC, and was getting unresolved symbols
for get_memcfg_from_srat() and get_zholes_size().  The CONFIG_NUMA
definition right now allows it to be turned on for plain old X86_PC. 
Does anyone know why this is?  

depends on SMP && HIGHMEM64G && 
          (X86_PC || X86_NUMAQ || X86_GENERICARCH || 
                  (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))

In any case, the summit code incorrectly assumes in at least 2 places
that NUMA && !NUMAQ means summit.  Someone was evidently trying to cover
the generic subarch case, but that's already taken care of by the lovely
config system and CONFIG_ACPI_SRAT.  This patch fixes those assumptions
and adds a nice little warning for people that try to #include srat.h
without having srat support turned on.  

-- 
Dave Hansen
haveblue@us.ibm.com

--=-khFaeiwQK9hvqPYua3pK
Content-Disposition: attachment; filename=srat-include-2.6.0-test4-0.patch
Content-Type: text/x-patch; name=srat-include-2.6.0-test4-0.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

diff -ru linux-2.6.0-test4/include/asm-i386/mmzone.h linux-2.6.0-test4-srat/include/asm-i386/mmzone.h
--- linux-2.6.0-test4/include/asm-i386/mmzone.h	2003-08-22 16:56:14.000000000 -0700
+++ linux-2.6.0-test4-srat/include/asm-i386/mmzone.h	2003-09-15 08:22:32.000000000 -0700
@@ -119,7 +119,7 @@
 
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
-#elif CONFIG_NUMA	/* summit or generic arch */
+#elif CONFIG_ACPI_SRAT
 #include <asm/srat.h>
 #elif CONFIG_X86_PC
 #define get_memcfg_numa get_memcfg_numa_flat
diff -ru linux-2.6.0-test4/include/asm-i386/numnodes.h linux-2.6.0-test4-srat/include/asm-i386/numnodes.h
--- linux-2.6.0-test4/include/asm-i386/numnodes.h	2003-08-22 16:52:57.000000000 -0700
+++ linux-2.6.0-test4-srat/include/asm-i386/numnodes.h	2003-09-15 08:22:50.000000000 -0700
@@ -5,7 +5,7 @@
 
 #ifdef CONFIG_X86_NUMAQ
 #include <asm/numaq.h>
-#elif CONFIG_NUMA
+#elif CONFIG_ACPI_SRAT
 #include <asm/srat.h>
 #else
 #define MAX_NUMNODES	1
diff -ru linux-2.6.0-test4/include/asm-i386/srat.h linux-2.6.0-test4-srat/include/asm-i386/srat.h
--- linux-2.6.0-test4/include/asm-i386/srat.h	2003-08-22 16:53:43.000000000 -0700
+++ linux-2.6.0-test4-srat/include/asm-i386/srat.h	2003-09-15 08:20:49.000000000 -0700
@@ -27,6 +27,10 @@
 #ifndef _ASM_SRAT_H_
 #define _ASM_SRAT_H_
 
+#ifndef CONFIG_ACPI_SRAT
+#error CONFIG_ACPI_SRAT not defined, and srat.h header has been included
+#endif
+
 #define MAX_NUMNODES		8
 extern void get_memcfg_from_srat(void);
 extern unsigned long *get_zholes_size(int);

--=-khFaeiwQK9hvqPYua3pK--

