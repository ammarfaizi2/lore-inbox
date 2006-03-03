Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWCCK7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWCCK7K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWCCK7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:59:10 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:3315 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751235AbWCCK7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:59:09 -0500
Message-ID: <4408216C.4020205@metro.cx>
Date: Fri, 03 Mar 2006 11:58:52 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 1/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Added s3c2412 detection.

Signed-off-by: Koen Martens <gmc@sonologic.nl>


--- linux-2.6.15.4/arch/arm/mach-s3c2410/cpu.c    2006-02-10 
08:22:48.000000000 +0100
+++ golinux/arch/arm/mach-s3c2410/cpu.c    2006-03-03 11:30:43.000000000 
+0100
@@ -41,6 +41,7 @@
 #include "cpu.h"
 #include "clock.h"
 #include "s3c2410.h"
+#include "s3c2412.h"
 #include "s3c2440.h"
 
 struct cpu_table {
@@ -58,6 +59,7 @@
 static const char name_s3c2410[]  = "S3C2410";
 static const char name_s3c2440[]  = "S3C2440";
 static const char name_s3c2410a[] = "S3C2410A";
+static const char name_s3c2412[]  = "S3C2412";
 static const char name_s3c2440a[] = "S3C2440A";
 
 static struct cpu_table cpu_ids[] __initdata = {
@@ -99,6 +101,19 @@
     }
 };
 
+static struct cpu_table alternative_cpu_ids[] __initdata = {
+       {
+               .idcode         = 0x32410002,
+               .idmask         = 0xffffffff,
+               .map_io         = s3c2412_map_io,
+               .init_clocks    = s3c2412_init_clocks,
+               .init_uarts     = s3c2412_init_uarts,
+               .init           = s3c2412_init,
+               .name           = name_s3c2412
+        }
+};
+
+
 /* minimal IO mapping */
 
 static struct map_desc s3c_iodesc[] __initdata = {
@@ -110,13 +125,16 @@
 
 
 static struct cpu_table *
-s3c_lookup_cpu(unsigned long idcode)
+s3c_lookup_cpu(unsigned long idcode,int alt)
 {
     struct cpu_table *tab;
     int count;
+    int size;
 
-    tab = cpu_ids;
-    for (count = 0; count < ARRAY_SIZE(cpu_ids); count++, tab++) {
+    tab = alt?alternative_cpu_ids:cpu_ids;
+    size = alt?ARRAY_SIZE(alternative_cpu_ids):ARRAY_SIZE(cpu_ids);
+
+    for (count = 0; count < size; count++, tab++) {
         if ((idcode & tab->idmask) == tab->idcode)
             return tab;
     }
@@ -154,7 +172,11 @@
     iotable_init(s3c_iodesc, ARRAY_SIZE(s3c_iodesc));
 
     idcode = __raw_readl(S3C2410_GSTATUS1);
-    cpu = s3c_lookup_cpu(idcode);
+    cpu = s3c_lookup_cpu(idcode,0);
+    if (cpu == NULL) {
+        idcode = __raw_readl(S3C2412_GSTATUS1);
+        cpu = s3c_lookup_cpu(idcode,1);
+    }
 
     if (cpu == NULL) {
         printk(KERN_ERR "Unknown CPU type 0x%08lx\n", idcode);

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

