Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264815AbSLMPZt>; Fri, 13 Dec 2002 10:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSLMPZt>; Fri, 13 Dec 2002 10:25:49 -0500
Received: from studi.informatik.uni-stuttgart.de ([129.69.212.4]:46249 "EHLO
	studi.informatik.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S264815AbSLMPZs>; Fri, 13 Dec 2002 10:25:48 -0500
Date: Fri, 13 Dec 2002 16:32:57 +0100 (CET)
From: Steffen Maier <Steffen.Maier@studserv.uni-stuttgart.de>
X-X-Sender: maiersn@marvin.informatik.uni-stuttgart.de
To: system_lists@nullzone.org
cc: linux-kernel@vger.kernel.org
Subject: Re: Compilation problems with local APIC for uniprocessors in  linux
 2.4.20-ac2
In-Reply-To: <fa.frihumv.5jq19j@ifi.uio.no>
Message-ID: <Pine.LNX.4.44.0212131629410.23314-100000@marvin.informatik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002, system_lists@nullzone.org wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20-ac2/include 
> -I/usr/lib/gcc-lib/i386-linux/3.2.2/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
> -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix 
> include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
> mpparse.c:75: `dest_LowestPrio' undeclared here (not in a function)
> mpparse.c: In function `smp_read_mpc':
> mpparse.c:607: `dest_Fixed' undeclared (first use in this function)
> mpparse.c:607: (Each undeclared identifier is reported only once
> mpparse.c:607: for each function it appears in.)
> mpparse.c:607: `dest_LowestPrio' undeclared (first use in this function)
> make[1]: *** [mpparse.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.20-ac2/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2

I just bumped into the same error using 2.4.20-ac1 and came up with the 
appended short term fix.

HTH,
Steffen.


diff -ur linux-2.4.20-ac1_orig/arch/i386/kernel/mpparse.c linux-2.4.20-ac1/arch/i386/kernel/mpparse.c
--- linux-2.4.20-ac1_orig/arch/i386/kernel/mpparse.c	Fri Dec 13 16:24:47 2002
+++ linux-2.4.20-ac1/arch/i386/kernel/mpparse.c	Fri Dec 13 16:22:01 2002
@@ -28,6 +28,7 @@
 #include <asm/mpspec.h>
 #include <asm/pgalloc.h>
 #include <asm/smpboot.h>
+#include <asm/io_apic.h>
 
 /* Have we found an MP table */
 int smp_found_config;
diff -ur linux-2.4.20-ac1_orig/include/asm/io_apic.h linux-2.4.20-ac1/include/asm/io_apic.h
--- linux-2.4.20-ac1_orig/include/asm/io_apic.h	Fri Dec 13 16:24:39 2002
+++ linux-2.4.20-ac1/include/asm/io_apic.h	Fri Dec 13 16:27:35 2002
@@ -47,17 +47,6 @@
 extern int nr_ioapics;
 extern int nr_ioapic_registers[MAX_IO_APICS];
 
-enum ioapic_irq_destination_types {
-	dest_Fixed = 0,
-	dest_LowestPrio = 1,
-	dest_SMI = 2,
-	dest__reserved_1 = 3,
-	dest_NMI = 4,
-	dest_INIT = 5,
-	dest__reserved_2 = 6,
-	dest_ExtINT = 7
-};
-
 struct IO_APIC_route_entry {
 	__u32	vector		:  8,
 		delivery_mode	:  3,	/* 000: FIXED
@@ -147,4 +136,15 @@
 #define io_apic_assign_pci_irqs 0
 #endif
 
+enum ioapic_irq_destination_types {
+	dest_Fixed = 0,
+	dest_LowestPrio = 1,
+	dest_SMI = 2,
+	dest__reserved_1 = 3,
+	dest_NMI = 4,
+	dest_INIT = 5,
+	dest__reserved_2 = 6,
+	dest_ExtINT = 7
+};
+
 #endif

