Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbSJNW1c>; Mon, 14 Oct 2002 18:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJNW1c>; Mon, 14 Oct 2002 18:27:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:34261 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262415AbSJNW0e>;
	Mon, 14 Oct 2002 18:26:34 -0400
Date: Mon, 14 Oct 2002 15:27:51 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Summit support for 2.5 - now with subarch! [4/5]
Message-ID: <77280000.1034634471@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds detection for summit machines from the MPS tables.
Prints a handy-dandy debug message telling you what kind of twisted
machine the kernel thinks you have.

diff -purN -X /home/mbligh/.diff.exclude subarch-3/arch/i386/kernel/mpparse.c subarch-4/arch/i386/kernel/mpparse.c
--- subarch-3/arch/i386/kernel/mpparse.c	Fri Oct 11 21:21:37 2002
+++ subarch-4/arch/i386/kernel/mpparse.c	Mon Oct 14 11:15:27 2002
@@ -30,6 +30,7 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 #include <asm/io_apic.h>
+#include "mach_apic.h"
 
 /* Have we found an MP table */
 int smp_found_config;
@@ -69,6 +70,8 @@ static unsigned int __initdata num_proce
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
+int summit_x86 = 0;
+
 /*
  * Intel MP BIOS table parsing routines:
  */
@@ -356,6 +359,7 @@ static void __init smp_read_mpc_oem(stru
 static int __init smp_read_mpc(struct mp_config_table *mpc)
 {
 	char str[16];
+	char oem[10];
 	int count=sizeof(*mpc);
 	unsigned char *mpt=((unsigned char *)mpc)+count;
 
@@ -380,14 +384,16 @@ static int __init smp_read_mpc(struct mp
 		printk(KERN_ERR "SMP mptable: null local APIC address!\n");
 		return 0;
 	}
-	memcpy(str,mpc->mpc_oem,8);
-	str[8]=0;
-	printk("OEM ID: %s ",str);
+	memcpy(oem,mpc->mpc_oem,8);
+	oem[8]=0;
+	printk("OEM ID: %s ",oem);
 
 	memcpy(str,mpc->mpc_productid,12);
 	str[12]=0;
 	printk("Product ID: %s ",str);
 
+	summit_check(oem, str);
+
 	printk("APIC at: 0x%lX\n",mpc->mpc_lapic);
 
 	/* 
@@ -465,6 +471,7 @@ static int __init smp_read_mpc(struct mp
 		}
 		++mpc_record;
 	}
+	clustered_apic_check();
 	if (!num_processors)
 		printk(KERN_ERR "SMP mptable: no processors registered!\n");
 	return num_processors;
diff -purN -X /home/mbligh/.diff.exclude subarch-3/arch/i386/mach-generic/mach_apic.h subarch-4/arch/i386/mach-generic/mach_apic.h
--- subarch-3/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 11:00:46 2002
+++ subarch-4/arch/i386/mach-generic/mach_apic.h	Mon Oct 14 11:18:22 2002
@@ -20,4 +20,14 @@ static inline unsigned long calculate_ld
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
 
+static inline void summit_check(char *oem, char *productid) 
+{
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		(clustered_apic_mode ? "NUMA-Q" : "Flat"), nr_ioapics);
+}
+
 #endif /* __ASM_MACH_APIC_H */
diff -purN -X /home/mbligh/.diff.exclude subarch-3/arch/i386/mach-summit/mach_apic.h subarch-4/arch/i386/mach-summit/mach_apic.h
--- subarch-3/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 11:01:00 2002
+++ subarch-4/arch/i386/mach-summit/mach_apic.h	Mon Oct 14 11:18:08 2002
@@ -26,4 +26,16 @@ static inline unsigned long calculate_ld
 #define APIC_BROADCAST_ID     (x86_summit ? 0xFF : 0x0F)
 #define check_apicid_used(bitmap, apicid) (0)
 
+static inline void summit_check(char *oem, char *productid)
+{
+	if (!strncmp(oem, "IBM ENSW", 8) && !strncmp(str, "VIGIL SMP", 9))
+		x86_summit = 1;
+}
+
+static inline void clustered_apic_check(void)
+{
+	printk("Enabling APIC mode:  %s.  Using %d I/O APICs\n",
+		(x86_summit ? "Summit" : "Flat"), nr_ioapics);
+}
+
 #endif /* __ASM_MACH_APIC_H */

