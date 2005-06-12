Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVFLLVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVFLLVT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 07:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262205AbVFLLVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 07:21:18 -0400
Received: from aun.it.uu.se ([130.238.12.36]:40675 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261940AbVFLLRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 07:17:22 -0400
Date: Sun, 12 Jun 2005 13:17:01 +0200 (MEST)
Message-Id: <200506121117.j5CBH1hZ019692@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH 2.4.31 1/9] gcc4: fix incomplete array errors
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 generates lots of compile-time errors like:

/tmp/linux-2.4.31/include/asm/processor.h:75: error: array type has incomplete element type
make: *** [init/main.o] Error 1

This is because arrays of incomplete element types are invalid C,
and gcc4 now enforces that.

The fixes in most cases is to reorder declarations or to add
missing #includes (icmp.h and ipv6.h).

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 include/asm-i386/processor.h   |    3 ++-
 include/asm-m68k/setup.h       |    3 ++-
 include/asm-x86_64/processor.h |    3 ++-
 include/net/icmp.h             |    1 +
 include/net/ipv6.h             |    1 +
 5 files changed, 8 insertions(+), 3 deletions(-)

diff -rupN linux-2.4.31/include/asm-i386/processor.h linux-2.4.31.gcc4-incomplete-array-errors/include/asm-i386/processor.h
--- linux-2.4.31/include/asm-i386/processor.h	2004-02-18 15:16:24.000000000 +0100
+++ linux-2.4.31.gcc4-incomplete-array-errors/include/asm-i386/processor.h	2005-06-12 11:41:04.000000000 +0200
@@ -72,7 +72,6 @@ struct cpuinfo_x86 {
  */
 
 extern struct cpuinfo_x86 boot_cpu_data;
-extern struct tss_struct init_tss[NR_CPUS];
 
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
@@ -357,6 +356,8 @@ struct tss_struct {
 	unsigned long __cacheline_filler[5];
 };
 
+extern struct tss_struct init_tss[NR_CPUS];
+
 struct thread_struct {
 	unsigned long	esp0;
 	unsigned long	eip;
diff -rupN linux-2.4.31/include/asm-m68k/setup.h linux-2.4.31.gcc4-incomplete-array-errors/include/asm-m68k/setup.h
--- linux-2.4.31/include/asm-m68k/setup.h	2000-01-29 13:07:40.000000000 +0100
+++ linux-2.4.31.gcc4-incomplete-array-errors/include/asm-m68k/setup.h	2005-06-12 11:41:04.000000000 +0200
@@ -361,12 +361,13 @@ extern int m68k_is040or060;
 #ifndef __ASSEMBLY__
 extern int m68k_num_memory;		/* # of memory blocks found (and used) */
 extern int m68k_realnum_memory;		/* real # of memory blocks found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 
 struct mem_info {
 	unsigned long addr;		/* physical address of memory chunk */
 	unsigned long size;		/* length of memory chunk (in bytes) */
 };
+
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 #endif
 
 #endif /* __KERNEL__ */
diff -rupN linux-2.4.31/include/asm-x86_64/processor.h linux-2.4.31.gcc4-incomplete-array-errors/include/asm-x86_64/processor.h
--- linux-2.4.31/include/asm-x86_64/processor.h	2004-04-14 20:22:21.000000000 +0200
+++ linux-2.4.31.gcc4-incomplete-array-errors/include/asm-x86_64/processor.h	2005-06-12 11:41:04.000000000 +0200
@@ -68,7 +68,6 @@ struct cpuinfo_x86 {
 #define X86_VENDOR_UNKNOWN 0xff
 
 extern struct cpuinfo_x86 boot_cpu_data;
-extern struct tss_struct init_tss[NR_CPUS];
 
 #ifdef CONFIG_SMP
 extern struct cpuinfo_x86 cpu_data[];
@@ -299,6 +298,8 @@ struct tss_struct {
 	u32 io_bitmap[IO_BITMAP_SIZE];
 } __attribute__((packed)) ____cacheline_aligned;
 
+extern struct tss_struct init_tss[NR_CPUS];
+
 struct thread_struct {
 	unsigned long	rsp0;
 	unsigned long	rip;
diff -rupN linux-2.4.31/include/net/icmp.h linux-2.4.31.gcc4-incomplete-array-errors/include/net/icmp.h
--- linux-2.4.31/include/net/icmp.h	2001-04-28 12:35:26.000000000 +0200
+++ linux-2.4.31.gcc4-incomplete-array-errors/include/net/icmp.h	2005-06-12 11:41:04.000000000 +0200
@@ -23,6 +23,7 @@
 
 #include <net/sock.h>
 #include <net/protocol.h>
+#include <net/snmp.h>
 
 struct icmp_err {
   int		errno;
diff -rupN linux-2.4.31/include/net/ipv6.h linux-2.4.31.gcc4-incomplete-array-errors/include/net/ipv6.h
--- linux-2.4.31/include/net/ipv6.h	2004-11-17 18:36:43.000000000 +0100
+++ linux-2.4.31.gcc4-incomplete-array-errors/include/net/ipv6.h	2005-06-12 11:41:04.000000000 +0200
@@ -101,6 +101,7 @@ struct frag_hdr {
 #ifdef __KERNEL__
 
 #include <net/sock.h>
+#include <net/snmp.h>
 
 /* sysctls */
 extern int sysctl_ipv6_bindv6only;
