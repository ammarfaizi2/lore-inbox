Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263592AbTLSUQQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 15:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTLSUQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 15:16:16 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:11968 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263592AbTLSUQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 15:16:11 -0500
Message-ID: <3FE35B86.6090901@us.ibm.com>
Date: Fri, 19 Dec 2003 12:11:50 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com, john stultz <johnstul@us.ibm.com>,
       Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>
Subject: [PATCH] Fix X86_GENERICARCH & NUMA compile error (1/2)
Content-Type: multipart/mixed;
 boundary="------------070105090709020707080800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070105090709020707080800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Trying to build a kernel with both CONFIG_X86_GENERICARCH and 
CONFIG_NUMA on results in a compile error.  This patch fixes that build 
problem by adding a config option for NUMA on Summit which is used to 
correctly conditionally compile arch/i386/kernel/summit.c and properly 
ifdef the function calls used in generic code.  Please apply.

Running make -j24 bzImage
arch/i386/mach-generic/built-in.o: In function `mps_oem_check':
arch/i386/mach-generic/built-in.o(.text+0x3ce): undefined reference to 
`setup_summit'
arch/i386/mach-generic/built-in.o: In function `acpi_madt_oem_check':
arch/i386/mach-generic/built-in.o(.text+0x468): undefined reference to 
`setup_summit'
make: *** [.tmp_vmlinux1] Error 1

Cheers!

-Matt

--------------070105090709020707080800
Content-Type: text/plain;
 name="01-genericarch_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-genericarch_fix.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/arch/i386/Kconfig linux-2.6.0-01/arch/i386/Kconfig
--- linux-2.6.0-vanilla/arch/i386/Kconfig	Wed Dec 17 18:58:16 2003
+++ linux-2.6.0-01/arch/i386/Kconfig	Fri Dec 19 11:35:41 2003
@@ -115,10 +115,15 @@ config ACPI_SRAT
 	default y
 	depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
 
+config X86_SUMMIT_NUMA
+	bool 
+	default y
+	depends on NUMA && (X86_SUMMIT || X86_GENERICARCH)
+
 config X86_CYCLONE_TIMER
-       bool 
-       default y
-       depends on X86_SUMMIT || X86_GENERICARCH
+	bool 
+	default y
+	depends on X86_SUMMIT || X86_GENERICARCH
 
 config ES7000_CLUSTERED_APIC
 	bool
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/arch/i386/kernel/Makefile linux-2.6.0-01/arch/i386/kernel/Makefile
--- linux-2.6.0-vanilla/arch/i386/kernel/Makefile	Wed Dec 17 18:58:16 2003
+++ linux-2.6.0-01/arch/i386/kernel/Makefile	Fri Dec 19 11:35:41 2003
@@ -24,7 +24,7 @@ obj-$(CONFIG_X86_MPPARSE)	+= mpparse.o
 obj-$(CONFIG_X86_LOCAL_APIC)	+= apic.o nmi.o
 obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o
 obj-$(CONFIG_X86_NUMAQ)		+= numaq.o
-obj-$(CONFIG_X86_SUMMIT)	+= summit.o
+obj-$(CONFIG_X86_SUMMIT_NUMA)	+= summit.o
 obj-$(CONFIG_EDD)             	+= edd.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/arch/i386/kernel/summit.c linux-2.6.0-01/arch/i386/kernel/summit.c
--- linux-2.6.0-vanilla/arch/i386/kernel/summit.c	Wed Dec 17 18:58:49 2003
+++ linux-2.6.0-01/arch/i386/kernel/summit.c	Fri Dec 19 11:36:03 2003
@@ -29,9 +29,8 @@
 #include <linux/mm.h>
 #include <linux/init.h>
 #include <asm/io.h>
-#include <mach_mpparse.h>
+#include <asm/mach-summit/mach_mpparse.h>
 
-#ifdef CONFIG_NUMA
 static void __init setup_pci_node_map_for_wpeg(int wpeg_num, struct rio_table_hdr *rth, 
 		struct scal_detail **scal_nodes, struct rio_detail **rio_nodes){
 	int twst_num = 0, node = 0, first_bus = 0;
@@ -169,4 +168,3 @@ void __init setup_summit(void)
 			/* It's a Winnipeg, it's got PCI Busses */
 			setup_pci_node_map_for_wpeg(i, rio_table_hdr, scal_devs, rio_devs);
 }
-#endif /* CONFIG_NUMA */
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/include/asm-i386/mach-summit/mach_mpparse.h linux-2.6.0-01/include/asm-i386/mach-summit/mach_mpparse.h
--- linux-2.6.0-vanilla/include/asm-i386/mach-summit/mach_mpparse.h	Wed Dec 17 18:58:48 2003
+++ linux-2.6.0-01/include/asm-i386/mach-summit/mach_mpparse.h	Fri Dec 19 11:36:03 2003
@@ -5,11 +5,11 @@
 
 extern int use_cyclone;
 
-#ifdef CONFIG_NUMA
+#ifdef CONFIG_X86_SUMMIT_NUMA
 extern void setup_summit(void);
-#else /* !CONFIG_NUMA */
+#else
 #define setup_summit()	{}
-#endif /* CONFIG_NUMA */
+#endif
 
 static inline void mpc_oem_bus_info(struct mpc_config_bus *m, char *name, 
 				struct mpc_config_translation *translation)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.0-vanilla/include/asm-i386/mpspec.h linux-2.6.0-01/include/asm-i386/mpspec.h
--- linux-2.6.0-vanilla/include/asm-i386/mpspec.h	Wed Dec 17 18:57:58 2003
+++ linux-2.6.0-01/include/asm-i386/mpspec.h	Fri Dec 19 11:35:41 2003
@@ -27,10 +27,6 @@ extern unsigned long mp_lapic_addr;
 extern int pic_mode;
 extern int using_apic_timer;
 
-#ifdef CONFIG_X86_SUMMIT
-extern void setup_summit (void);
-#endif
-
 #ifdef CONFIG_ACPI_BOOT
 extern void mp_register_lapic (u8 id, u8 enabled);
 extern void mp_register_lapic_address (u64 address);

--------------070105090709020707080800--

