Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWCMSLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWCMSLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWCMSLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:11:32 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:8205 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932256AbWCMSLa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:11:30 -0500
Date: Mon, 13 Mar 2006 10:11:28 -0800
Message-Id: <200603131811.k2DIBS8j005741@zach-dev.vmware.com>
Subject: [RFC, PATCH 16/24] i386 Vmi io header
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:11:29.0119 (UTC) FILETIME=[8CCC06F0:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move I/O instruction building to the sub-arch layer.  Some very crafty
but esoteric macros are used here to get optimized native instructions
for port I/O in Linux be writing raw instruction strings.  Adding a
wrapper layer here is fairly easy, and makes the full range of I/O
instructions available to the VMI interface.

Also, slowing down I/O is not a useful operation in a VM, so there
is a VMI call specifically to allow making it a NOP.  I could find
no place where SLOW_IO_BY_JUMPING is still used, and consider it
obsoleted.  Even on older 386 systems, the I/O delay approximation
by touching the extra page register is likely to better.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/io.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/io.h	2006-03-07 17:02:52.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/io.h	2006-03-08 10:09:24.000000000 -0800
@@ -4,6 +4,7 @@
 #include <linux/config.h>
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <mach_io.h>
 
 /*
  * This file contains the definitions for the x86 IO instructions
@@ -296,19 +297,11 @@ static inline void flush_write_buffers(v
 
 #endif /* __KERNEL__ */
 
-#ifdef SLOW_IO_BY_JUMPING
-#define __SLOW_DOWN_IO "jmp 1f; 1: jmp 1f; 1:"
-#else
-#define __SLOW_DOWN_IO "outb %%al,$0x80;"
-#endif
-
 static inline void slow_down_io(void) {
-	__asm__ __volatile__(
-		__SLOW_DOWN_IO
+	__SLOW_DOWN_IO;
 #ifdef REALLY_SLOW_IO
-		__SLOW_DOWN_IO __SLOW_DOWN_IO __SLOW_DOWN_IO
+	__SLOW_DOWN_IO; __SLOW_DOWN_IO; __SLOW_DOWN_IO;
 #endif
-		: : );
 }
 
 #ifdef CONFIG_X86_NUMAQ
@@ -346,11 +339,11 @@ static inline unsigned type in##bwl(int 
 
 #define BUILDIO(bwl,bw,type) \
 static inline void out##bwl##_local(unsigned type value, int port) { \
-	__asm__ __volatile__("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port)); \
+	__BUILDOUTINST(bwl,bw,value,port); \
 } \
 static inline unsigned type in##bwl##_local(int port) { \
 	unsigned type value; \
-	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port)); \
+	__BUILDININST(bwl,bw,value,port); \
 	return value; \
 } \
 static inline void out##bwl##_local_p(unsigned type value, int port) { \
@@ -373,10 +366,10 @@ static inline unsigned type in##bwl##_p(
 	return value; \
 } \
 static inline void outs##bwl(int port, const void *addr, unsigned long count) { \
-	__asm__ __volatile__("rep; outs" #bwl : "+S"(addr), "+c"(count) : "d"(port)); \
+	__BUILDOUTSINST(bwl,addr,count,port); \
 } \
 static inline void ins##bwl(int port, void *addr, unsigned long count) { \
-	__asm__ __volatile__("rep; ins" #bwl : "+D"(addr), "+c"(count) : "d"(port)); \
+	__BUILDINSINST(bwl,addr,count,port); \
 }
 
 BUILDIO(b,b,char)
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_io.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_io.h	2006-03-08 10:09:24.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_io.h	2006-03-08 10:09:47.000000000 -0800
@@ -0,0 +1,155 @@
+#ifndef _MACH_ASM_IO_H
+#define _MACH_ASM_IO_H
+
+#include <vmi.h>
+
+/*
+ * Note on the VMI calls below; all of them must specify memory
+ * clobber, even output calls.  The reason is that the memory
+ * clobber is not an effect of the VMI call, but is used to
+ * serialize memory writes by the compiler before an I/O
+ * instruction.  In addition, even input operations may clobber
+ * hardware mapped memory.
+ */
+
+static inline void vmi_outl(const VMI_UINT32 value, const VMI_UINT16 port)
+{
+	vmi_wrap_call(
+		OUT, "out %0, %w1",
+		VMI_NO_OUTPUT,
+		2, XCONC("a"(value), "d"(port)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void vmi_outb(const VMI_UINT8 value, const VMI_UINT16 port)
+{
+	vmi_wrap_call(
+		OUTB, "outb %b0, %w1",
+		VMI_NO_OUTPUT,
+		2, XCONC("a"(value), "d"(port)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline void vmi_outw(const VMI_UINT16 value, const VMI_UINT16 port)
+{
+	vmi_wrap_call(
+		OUTW, "outw %w0, %w1",
+		VMI_NO_OUTPUT,
+		2, XCONC("a"(value), "d"(port)),
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "memory"));
+}
+
+static inline VMI_UINT32 vmi_inl(const VMI_UINT16 port)
+{
+	VMI_UINT32 ret;
+	vmi_wrap_call(
+		IN, "in %w0, %%eax",
+		VMI_OREG1(ret),
+		1, XCONC("d"(port)),
+		VMI_CLOBBER_EXTENDED(ONE_RETURN, "memory"));
+	return ret;
+}
+
+static inline VMI_UINT8 vmi_inb(const VMI_UINT16 port)
+{
+	VMI_UINT8 ret;
+	vmi_wrap_call(
+		INB, "inb %w0, %%al",
+		VMI_OREG1(ret),
+		1, XCONC("d"(port)),
+		VMI_CLOBBER_EXTENDED(ONE_RETURN, "memory"));
+	return ret;
+}
+
+static inline VMI_UINT16 vmi_inw(const VMI_UINT16 port)
+{
+	VMI_UINT16 ret;
+	vmi_wrap_call(
+		INW, "inw %w0, %%ax",
+		VMI_OREG1(ret),
+		1, XCONC("d"(port)),
+		VMI_CLOBBER_EXTENDED(ONE_RETURN, "memory"));
+	return ret;
+}
+
+static inline void vmi_outsl(VMI_UINT32 const *addr, const VMI_UINT16 port, VMI_UINT32 count)
+{
+	vmi_wrap_call(
+		OUTS, "rep; outsl",
+		VMI_NO_OUTPUT,
+		3, XCONC("S"(addr), "c"(count), "d"(port)), 
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "esi", "ecx", "memory"));
+}
+
+static inline void vmi_outsb(VMI_UINT8 const *addr, const VMI_UINT16 port, VMI_UINT32 count)
+{
+	vmi_wrap_call(
+		OUTSB, "rep; outsb",
+		VMI_NO_OUTPUT,
+		3, XCONC("S"(addr), "c"(count), "d"(port)), 
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "esi", "ecx", "memory"));
+}
+
+static inline void vmi_outsw(VMI_UINT16 const *addr, const VMI_UINT16 port, VMI_UINT32 count)
+{
+	vmi_wrap_call(
+		OUTSW, "rep; outsw",
+		VMI_NO_OUTPUT,
+		3, XCONC("S"(addr), "c"(count), "d"(port)), 
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "esi", "ecx", "memory"));
+}
+
+static inline void vmi_insl(VMI_UINT32 *addr, const VMI_UINT16 port, VMI_UINT32 count)
+{
+	vmi_wrap_call(
+		INS, "rep; insl",
+		VMI_NO_OUTPUT,
+		3, XCONC("D"(addr), "c"(count), "d"(port)), 
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "edi", "ecx", "memory"));
+}
+
+static inline void vmi_insb(VMI_UINT8 *addr, const VMI_UINT16 port, VMI_UINT32 count)
+{
+	vmi_wrap_call(
+		INSB, "rep; insb",
+		VMI_NO_OUTPUT,
+		3, XCONC("D"(addr), "c"(count), "d"(port)), 
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "edi", "ecx", "memory"));
+}
+
+static inline void vmi_insw(VMI_UINT16 *addr, const VMI_UINT16 port, VMI_UINT32 count)
+{
+	vmi_wrap_call(
+		INSW, "rep; insw",
+		VMI_NO_OUTPUT,
+		3, XCONC("D"(addr), "c"(count), "d"(port)), 
+		VMI_CLOBBER_EXTENDED(ZERO_RETURNS, "edi", "ecx", "memory"));
+}
+
+
+/*
+ * Slow down port I/O by issuing a write to a chipset scratch
+ * register.  This is an efficient and easy way to slow down
+ * I/O regardless of processor speed, but useless in a virtual
+ * machine.
+ */
+static inline void vmi_iodelay(void)
+{
+	vmi_wrap_call(
+		IODelay, "outb %%al, $0x80",
+		VMI_NO_OUTPUT,
+		0, VMI_NO_INPUT,
+		VMI_CLOBBER(ZERO_RETURNS));
+}
+
+#define __SLOW_DOWN_IO vmi_iodelay()
+
+#define __BUILDOUTINST(bwl,bw,value,port) \
+	vmi_out##bwl(value, port)
+#define	__BUILDININST(bwl,bw,value,port) \
+	do { value = vmi_in##bwl(port); } while (0)
+#define	__BUILDOUTSINST(bwl,addr,count,port) \
+	vmi_outs##bwl(addr, port, count)
+#define	__BUILDINSINST(bwl,addr,count,port) \
+	vmi_ins##bwl(addr, port, count)
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_io.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_io.h	2006-03-08 10:09:24.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_io.h	2006-03-08 10:09:24.000000000 -0800
@@ -0,0 +1,22 @@
+#ifndef _MACH_ASM_IO_H
+#define _MACH_ASM_IO_H
+
+#ifdef SLOW_IO_BY_JUMPING
+#define __SLOW_DOWN_IO asm volatile("jmp 1f; 1: jmp 1f; 1:")
+#else
+#define __SLOW_DOWN_IO asm volatile("outb %al, $0x80")
+#endif
+
+#define __BUILDOUTINST(bwl,bw,value,port) \
+	__asm__ __volatile__("out" #bwl " %" #bw "0, %w1" : : "a"(value), "Nd"(port))
+#define	__BUILDININST(bwl,bw,value,port) \
+	__asm__ __volatile__("in" #bwl " %w1, %" #bw "0" : "=a"(value) : "Nd"(port))
+#define	__BUILDOUTSINST(bwl,addr,count,port) \
+	__asm__ __volatile__("rep; outs" #bwl : "+S"(addr), "+c"(count) : "d"(port))
+#define	__BUILDINSINST(bwl,addr,count,port) \
+	__asm__ __volatile__("rep; ins" #bwl \
+			     : "+D"(addr), "+c"(count) \
+			     : "d"(port) \
+			     : "memory")
+
+#endif
