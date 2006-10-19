Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161416AbWJSNro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161416AbWJSNro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 09:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWJSNro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 09:47:44 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:15764 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1161416AbWJSNrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 09:47:43 -0400
Message-ID: <453781F9.3050703@qumranet.com>
Date: Thu, 19 Oct 2006 15:47:37 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] KVM: userspace interface
References: <4537818D.4060204@qumranet.com>
In-Reply-To: <4537818D.4060204@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Oct 2006 13:47:42.0705 (UTC) FILETIME=[2665E610:01C6F385]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines a bunch of ioctl()s on /dev/kvm.  The ioctl()s allow
adding
memory to a virtual machine, adding a virtual cpu to a virtual machine (at
most one at this time), transferring control to the virtual cpu, and
querying
about guest pages changed by the virtual machine.

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/include/linux/kvm.h
===================================================================
--- /dev/null
+++ linux-2.6/include/linux/kvm.h
@@ -0,0 +1,202 @@
+#ifndef __LINUX_KVM_H
+#define __LINUX_KVM_H
+
+/*
+ * Userspace interface for /dev/kvm - kernel based virtual machine
+ *
+ * Note: this interface is considered experimental and may change without
+ *       notice.
+ */
+
+#include <asm/types.h>
+#include <linux/ioctl.h>
+
+#ifndef __user
+#define __user
+#endif
+
+/* for KVM_CREATE_MEMORY_REGION */
+struct kvm_memory_region {
+    __u32 slot;
+    __u32 flags;
+    __u64 guest_phys_addr;
+    __u64 memory_size; /* bytes */
+};
+
+/* for kvm_memory_region::flags */
+#define KVM_MEM_LOG_DIRTY_PAGES  1UL
+
+
+#define KVM_EXIT_TYPE_FAIL_ENTRY 1
+#define KVM_EXIT_TYPE_VM_EXIT    2
+
+enum kvm_exit_reason {
+    KVM_EXIT_UNKNOWN,
+    KVM_EXIT_EXCEPTION,
+    KVM_EXIT_IO,
+    KVM_EXIT_CPUID,
+    KVM_EXIT_DEBUG,
+    KVM_EXIT_HLT,
+    KVM_EXIT_MMIO,
+};
+
+/* for KVM_RUN */
+struct kvm_run {
+    /* in */
+    __u32 vcpu;
+    __u32 emulated;  /* skip current instruction */
+    __u32 mmio_completed; /* mmio request completed */
+
+    /* out */
+    __u32 exit_type;
+    __u32 exit_reason;
+    __u32 instruction_length;
+    union {
+        /* KVM_EXIT_UNKNOWN */
+        struct {
+            __u32 hardware_exit_reason;
+        } hw;
+        /* KVM_EXIT_EXCEPTION */
+        struct {
+            __u32 exception;
+            __u32 error_code;
+        } ex;
+        /* KVM_EXIT_IO */
+        struct {
+#define KVM_EXIT_IO_IN  0
+#define KVM_EXIT_IO_OUT 1
+            __u8 direction;
+            __u8 size; /* bytes */
+            __u8 string;
+            __u8 string_down;
+            __u8 rep;
+            __u8 pad;
+            __u16 port;
+            __u64 count;
+            union {
+                __u64 address;
+                __u32 value;
+            };
+        } io;
+        struct {
+        } debug;
+        /* KVM_EXIT_MMIO */
+        struct {
+            __u64 phys_addr;
+            __u8  data[8];
+            __u32 len;
+            __u8  is_write;
+        } mmio;
+    };
+};
+
+/* for KVM_GET_REGS and KVM_SET_REGS */
+struct kvm_regs {
+    /* in */
+    __u32 vcpu;
+    __u32 padding;
+
+    /* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
+    __u64 rax, rbx, rcx, rdx;
+    __u64 rsi, rdi, rsp, rbp;
+    __u64 r8,  r9,  r10, r11;
+    __u64 r12, r13, r14, r15;
+    __u64 rip, rflags;
+};
+
+struct kvm_segment {
+    __u64 base;
+    __u32 limit;
+    __u16 selector;
+    __u8  type;
+    __u8  present, dpl, db, s, l, g, avl;
+    __u8  unusable;
+    __u8  padding;
+};
+
+struct kvm_dtable {
+    __u64 base;
+    __u16 limit;
+    __u16 padding[3];
+};
+
+/* for KVM_GET_SREGS and KVM_SET_SREGS */
+struct kvm_sregs {
+    /* in */
+    __u32 vcpu;
+    __u32 padding;
+
+    /* out (KVM_GET_SREGS) / in (KVM_SET_SREGS) */
+    struct kvm_segment cs, ds, es, fs, gs, ss;
+    struct kvm_segment tr, ldt;
+    struct kvm_dtable gdt, idt;
+    __u64 cr0, cr2, cr3, cr4, cr8;
+    __u64 efer;
+    __u64 apic_base;
+
+    /* out (KVM_GET_SREGS) */
+    __u32 pending_int;
+    __u32 padding2;
+};
+
+/* for KVM_TRANSLATE */
+struct kvm_translation {
+    /* in */
+    __u64 linear_address;
+    __u32 vcpu;
+    __u32 padding;
+
+    /* out */
+    __u64 physical_address;
+    __u8  valid;
+    __u8  writeable;
+    __u8  usermode;
+};
+
+/* for KVM_INTERRUPT */
+struct kvm_interrupt {
+    /* in */
+    __u32 vcpu;
+    __u32 irq;
+};
+
+struct kvm_breakpoint {
+    __u32 enabled;
+    __u32 padding;
+    __u64 address;
+};
+
+/* for KVM_DEBUG_GUEST */
+struct kvm_debug_guest {
+    /* int */
+    __u32 vcpu;
+    __u32 enabled;
+    struct kvm_breakpoint breakpoints[4];
+    __u32 singlestep;
+};
+
+/* for KVM_GET_DIRTY_LOG */
+struct kvm_dirty_log {
+    __u32 slot;
+    __u32 padding;
+    union {
+        void __user *dirty_bitmap; /* one bit per page */
+        __u64 padding;
+    };
+};
+
+#define KVMIO 0xAE
+
+#define KVM_RUN                   _IOWR(KVMIO, 2, struct kvm_run)
+#define KVM_GET_REGS              _IOWR(KVMIO, 3, struct kvm_regs)
+#define KVM_SET_REGS              _IOW(KVMIO, 4, struct kvm_regs)
+#define KVM_GET_SREGS             _IOWR(KVMIO, 5, struct kvm_sregs)
+#define KVM_SET_SREGS             _IOW(KVMIO, 6, struct kvm_sregs)
+#define KVM_TRANSLATE             _IOWR(KVMIO, 7, struct kvm_translation)
+#define KVM_INTERRUPT             _IOW(KVMIO, 8, struct kvm_interrupt)
+#define KVM_DEBUG_GUEST           _IOW(KVMIO, 9, struct kvm_debug_guest)
+#define KVM_SET_MEMORY_REGION     _IOW(KVMIO, 10, struct kvm_memory_region)
+#define KVM_CREATE_VCPU           _IOW(KVMIO, 11, int /* vcpu_slot */)
+#define KVM_GET_DIRTY_LOG         _IOW(KVMIO, 12, struct kvm_dirty_log)
+
+#endif

-- 
error compiling committee.c: too many arguments to function

