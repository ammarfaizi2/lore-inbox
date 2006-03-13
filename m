Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWCMSmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWCMSmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbWCMSl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:41:59 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:40465 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751451AbWCMSl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:41:56 -0500
Date: Mon, 13 Mar 2006 10:41:54 -0800
Message-Id: <200603131841.k2DIfsBA005883@zach-dev.vmware.com>
Subject: [RFC, PATCH 3/24] i386 Vmi interface definition
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
X-OriginalArrivalTime: 13 Mar 2006 18:41:54.0813 (UTC) FILETIME=[CCFED2D0:01C646CD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Master definition of VMI interface, including calls, constants, and
interface version.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/paravirtualInterface.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/paravirtualInterface.h	2006-03-08 10:08:45.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/paravirtualInterface.h	2006-03-08 10:08:45.000000000 -0800
@@ -0,0 +1,188 @@
+/*
+ * paravirtualInterface.h --
+ *
+ *      Header file for paravirtualization interface and definitions
+ *      for the hypervisor option ROM tables.
+ *
+ *      Copyright (C) 2005, VMWare, Inc.
+ *
+ */
+
+#ifndef _PARAVIRTUAL_INTERFACE_H_
+#define _PARAVIRTUAL_INTERFACE_H_
+
+#include "vmiCalls.h"
+
+/*
+ *---------------------------------------------------------------------
+ *
+ *  VMI Option ROM API
+ *
+ *---------------------------------------------------------------------
+ */
+#define VDEF(call) VMI_CALL_##call,
+typedef enum VMICall {
+   VMI_CALLS
+   NUM_VMI_CALLS
+} VMICall;
+#undef VDEF
+
+#define VMI_SIGNATURE 0x696d5663   /* "cVmi" */
+
+#define VMI_API_REV_MAJOR          13
+#define VMI_API_REV_MINOR          0
+
+/* Flags used by VMI_Reboot call */
+#define VMI_REBOOT_SOFT          0x0
+#define VMI_REBOOT_HARD          0x1
+
+/* Flags used by VMI_{Notify|Release}Page call */
+#define VMI_PAGE_PT              0x01
+#define VMI_PAGE_PD              0x02
+#define VMI_PAGE_PAE             0x04
+#define VMI_PAGE_PDP             0x04
+#define VMI_PAGE_PML4            0x08
+
+/* Flags used by VMI_FlushTLB call */
+#define VMI_FLUSH_TLB            0x01
+#define VMI_FLUSH_GLOBAL         0x02
+
+/* Flags used by VMI_FlushSync call */
+#define VMI_FLUSH_PT_UPDATES     0x80
+
+/* The number of VMI address translation slot */
+#define VMI_LINEAR_MAP_SLOTS    4
+
+/* The cycle counters. */
+#define VMI_CYCLES_REAL         0
+#define VMI_CYCLES_AVAILABLE    1
+#define VMI_CYCLES_STOLEN       2
+
+/* The alarm interface 'flags' bits. [TBD: exact format of 'flags'] */
+#define VMI_ALARM_COUNTERS      2
+
+#define VMI_ALARM_COUNTER_MASK  0x000000ff
+
+#define VMI_ALARM_WIRED_IRQ0    0x00000000
+#define VMI_ALARM_WIRED_LVTT    0x00010000
+
+#define VMI_ALARM_IS_ONESHOT    0x00000000
+#define VMI_ALARM_IS_PERIODIC   0x00000100
+
+
+/*
+ *---------------------------------------------------------------------
+ *
+ *  Generic VROM structures and definitions
+ *
+ *---------------------------------------------------------------------
+ */
+
+/* VROM call table definitions */
+#define VROM_CALL_LEN             32
+
+typedef struct VROMCallEntry {
+   char f[VROM_CALL_LEN];
+} VROMCallEntry;
+
+typedef struct VROMHeader {
+   VMI_UINT16          romSignature;             // option ROM signature
+   VMI_INT8            romLength;                // ROM length in 512 byte chunks
+   unsigned char       romEntry[4];              // 16-bit code entry point
+   VMI_UINT8           romPad0;                  // 4-byte align pad
+   VMI_UINT32          vRomSignature;            // VROM identification signature
+   VMI_UINT8           APIVersionMinor;          // Minor version of API
+   VMI_UINT8           APIVersionMajor;          // Major version of API
+   VMI_UINT8           reserved0;                // Reserved for expansion
+   VMI_UINT8           reserved1;                // Reserved for expansion
+   VMI_UINT32          reserved2;                // Reserved for expansion
+   VMI_UINT32          reserved3;                // Reserved for private use
+   VMI_UINT16          pciHeaderOffset;          // Offset to PCI OPROM header
+   VMI_UINT16          pnpHeaderOffset;          // Offset to PnP OPROM header
+   VMI_UINT32          romPad3;                  // PnP reserverd / VMI reserved
+   VROMCallEntry       romCallReserved[3];       // Reserved call slots
+} VROMHeader;
+
+typedef struct VROMCallTable {
+   VROMCallEntry    vromCall[128];           // @ 0x80: ROM calls 4-127
+} VROMCallTable;
+
+/* State needed to start an application processor in an SMP system. */
+typedef struct APState {
+   VMI_UINT32 cr0;
+   VMI_UINT32 cr2;
+   VMI_UINT32 cr3;
+   VMI_UINT32 cr4;
+
+   VMI_UINT64 efer;
+
+   VMI_UINT32 eip;
+   VMI_UINT32 eflags;
+   VMI_UINT32 eax;
+   VMI_UINT32 ebx;
+   VMI_UINT32 ecx;
+   VMI_UINT32 edx;
+   VMI_UINT32 esp;
+   VMI_UINT32 ebp;
+   VMI_UINT32 esi;
+   VMI_UINT32 edi;
+   VMI_UINT16 cs;
+   VMI_UINT16 ss;
+   VMI_UINT16 ds;
+   VMI_UINT16 es;
+   VMI_UINT16 fs;
+   VMI_UINT16 gs;
+   VMI_UINT16 ldtr;
+
+   VMI_UINT16 gdtr_limit;
+   VMI_UINT32 gdtr_base;
+   VMI_UINT32 idtr_base;
+   VMI_UINT16 idtr_limit;
+} APState;
+
+// Historical 3.X revisions
+//#define MIN_VMI_API_REV_MINOR	        1 /* GetFlags_CLI is used */
+//#define MIN_VMI_API_REV_MINOR	        2 /* STI_SYSEXIT is used */
+//#define MIN_VMI_API_REV_MINOR	        3 /* IN/OUT are used */
+//#define MIN_VMI_API_REV_MINOR         4 /* Deferred calls used */
+//#define MIN_VMI_API_REV_MINOR		5 /* SetIOPLMask is used */
+
+// 4.X revisions
+//#define MIN_VMI_API_REV_MINOR		0 /* IN/OUT binary compat */
+
+// 5.X revisions
+//#define MIN_VMI_API_REV_MINOR		0
+//#define MIN_VMI_API_REV_MINOR		1 /* APIC read/write */
+//#define MIN_VMI_API_REV_MINOR         2 /* Send IPI */
+//#define MIN_VMI_API_REV_MINOR         3 /* IO Delay */
+//#define MIN_VMI_API_REV_MINOR         4 /* Timer API */
+//#define MIN_VMI_API_REV_MINOR         5 /* SMP VMI-Timer */
+
+// 6.X revisions
+//#define MIN_VMI_API_REV_MINOR         0 /* VMI Timer periodic alarms */
+
+// 7.X revisions
+//#define MIN_VMI_API_REV_MINOR         0 /* Dropped 6 VMI calls */
+//#define MIN_VMI_API_REV_MINOR         1 /* Wallclock */
+//#define MIN_VMI_API_REV_MINOR         2 /* RDTSC compatiblity */
+
+// 8.X revisions			
+//#define MIN_VMI_API_REV_MINOR         0 /* Xen compatible DT */
+//#define MIN_VMI_API_REV_MINOR         1 /* WallclockUpdated */
+
+// 9.X revisions
+//#define MIN_VMI_API_REV_MINOR		0 /* Removed HookCallback */
+
+// 10.X revisions
+//#define MIN_VMI_API_REV_MINOR		0 /* UpdateIDT -> WriteIDTEntry */
+
+// 11.X revisions
+//#define MIN_VMI_API_REV_MINOR		0 /* UpdateTSS -> UpdateKernelStack */
+
+// 12.X revisions
+//#define MIN_VMI_API_REV_MINOR		0 /* Drop APICSendIPI */
+
+// 13.X revisions
+#define MIN_VMI_API_REV_MINOR		0 /* Remove shared area allocation */
+
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/vmiCalls.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/vmiCalls.h	2006-03-08 10:08:45.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/vmiCalls.h	2006-03-08 10:15:30.000000000 -0800
@@ -0,0 +1,98 @@
+/*
+ * vmiCalls.h --
+ *
+ *   List of 32-bit VMI interface calls and parameters
+ *
+ *   Copyright (C) 2005, VMware, Inc.
+ *
+ */
+
+#define VMI_CALLS \
+   VDEF(RESERVED0) \
+   VDEF(RESERVED1) \
+   VDEF(RESERVED2) \
+   VDEF(RESERVED3) \
+   VDEF(Init) \
+   VDEF(CPUID) \
+   VDEF(WRMSR) \
+   VDEF(RDMSR) \
+   VDEF(SetGDT) \
+   VDEF(SetLDT) \
+   VDEF(SetIDT) \
+   VDEF(SetTR) \
+   VDEF(GetGDT) \
+   VDEF(GetLDT) \
+   VDEF(GetIDT) \
+   VDEF(GetTR) \
+   VDEF(WriteGDTEntry) \
+   VDEF(WriteLDTEntry) \
+   VDEF(WriteIDTEntry) \
+   VDEF(UpdateKernelStack) \
+   VDEF(SetCR0) \
+   VDEF(SetCR2) \
+   VDEF(SetCR3) \
+   VDEF(SetCR4) \
+   VDEF(GetCR0) \
+   VDEF(GetCR2) \
+   VDEF(GetCR3) \
+   VDEF(GetCR4) \
+   VDEF(INVD) \
+   VDEF(WBINVD) \
+   VDEF(SetDR) \
+   VDEF(GetDR) \
+   VDEF(RDPMC) \
+   VDEF(RDTSC) \
+   VDEF(CLTS) \
+   VDEF(EnableInterrupts) \
+   VDEF(DisableInterrupts) \
+   VDEF(GetInterruptMask) \
+   VDEF(SetInterruptMask) \
+   VDEF(IRET) \
+   VDEF(SYSEXIT) \
+   VDEF(Pause) \
+   VDEF(Halt) \
+   VDEF(Reboot) \
+   VDEF(Shutdown) \
+   VDEF(SetPxE) \
+   VDEF(GetPxE) \
+   VDEF(SwapPxE) \
+   /* Reserved for PAE / long mode */ \
+   VDEF(SetPxELong) \
+   VDEF(GetPxELong) \
+   VDEF(SwapPxELongAtomic) \
+   VDEF(TestAndSetPxEBit) \
+   VDEF(TestAndClearPxEBit) \
+   /* Notify the hypervisor how a page should be shadowed */ \
+   VDEF(AllocatePage) \
+   /* Release shadowed parts of a page */ \
+   VDEF(ReleasePage) \
+   VDEF(InvalPage) \
+   VDEF(FlushTLB) \
+   VDEF(FlushDeferredCalls) \
+   VDEF(SetLinearMapping) \
+   VDEF(IN) \
+   VDEF(INB) \
+   VDEF(INW) \
+   VDEF(INS) \
+   VDEF(INSB) \
+   VDEF(INSW) \
+   VDEF(OUT) \
+   VDEF(OUTB) \
+   VDEF(OUTW) \
+   VDEF(OUTS) \
+   VDEF(OUTSB) \
+   VDEF(OUTSW) \
+   VDEF(SetIOPLMask) \
+   VDEF(DeactivatePxELongAtomic) \
+   VDEF(TestAndSetPxELongBit) \
+   VDEF(TestAndClearPxELongBit) \
+   VDEF(SetInitialAPState) \
+   VDEF(APICWrite) \
+   VDEF(APICRead) \
+   VDEF(IODelay) \
+   VDEF(GetCycleFrequency) \
+   VDEF(GetCycleCounter) \
+   VDEF(SetAlarm) \
+   VDEF(CancelAlarm) \
+   VDEF(GetWallclockTime) \
+   VDEF(WallclockUpdated)
