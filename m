Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267746AbSLTIYn>; Fri, 20 Dec 2002 03:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267747AbSLTIYn>; Fri, 20 Dec 2002 03:24:43 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:47258 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267746AbSLTIYl>; Fri, 20 Dec 2002 03:24:41 -0500
Date: Fri, 20 Dec 2002 00:32:41 -0800
Message-Id: <200212200832.gBK8Wfg29816@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Subject: PTRACE_GET_THREAD_AREA
X-Zippy-Says: Maybe we could paint GOLDIE HAWN a rich PRUSSIAN BLUE--
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch vs 2.5.51 (should apply fine to 2.5.52) adds two new ptrace
requests for i386, PTRACE_GET_THREAD_AREA and PTRACE_SET_THREAD_AREA.
These let another process using ptrace do the equivalent of performing
get_thread_area and set_thread_area system calls for another thread.

We are working on gdb support for the new threading code in the kernel
using the new NPTL library, and use PTRACE_GET_THREAD_AREA for that.
This patch has been working fine for that.

I added PTRACE_SET_THREAD_AREA just for completeness, so that you can
change all the state via ptrace that you can read via ptrace as has
previously been the case.  It doesn't have an equivalent of set_thread_area
with .entry_number = -1, but is otherwise the same.

Both requests use the ptrace `addr' argument for the entry number rather
than the entry_number field in the struct.  The `data' parameter gives the
address of a struct user_desc as used by the set/get_thread_area syscalls.

The code is quite simple, and doesn't need any special synchronization
because in the ptrace context the thread must be stopped already.

I chose the new request numbers arbitrarily from ones not used on i386.
I have no opinion on what values should be used.

People I talked to preferred adding this interface over putting an array of
struct user_desc in struct user as accessed by PTRACE_PEEKUSR/POKEUSR
(which would be a bit unnatural since those calls access one word at a time).


Thanks,
Roland



--- linux-2.5.51/include/asm-i386/ptrace.h.orig	Mon Dec  9 18:45:43 2002
+++ linux-2.5.51/include/asm-i386/ptrace.h	Thu Dec 12 04:42:06 2002
@@ -51,6 +51,10 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS         21
 
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
+
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
--- linux-2.5.51/arch/i386/kernel/ptrace.c.orig	Mon Dec  9 18:45:52 2002
+++ linux-2.5.51/arch/i386/kernel/ptrace.c	Thu Dec 12 04:42:12 2002
@@ -21,6 +21,8 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/debugreg.h>
+#include <asm/ldt.h>
+#include <asm/desc.h>
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -416,6 +418,80 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 	}
 
+	case PTRACE_GET_THREAD_AREA: {
+		int idx = addr;
+		struct user_desc info;
+		struct desc_struct *desc;
+
+/*
+ * Get the current Thread-Local Storage area:
+ */
+
+#define GET_BASE(desc) ( \
+	(((desc)->a >> 16) & 0x0000ffff) | \
+	(((desc)->b << 16) & 0x00ff0000) | \
+	( (desc)->b        & 0xff000000)   )
+
+#define GET_LIMIT(desc) ( \
+	((desc)->a & 0x0ffff) | \
+	 ((desc)->b & 0xf0000) )
+
+#define GET_32BIT(desc)		(((desc)->b >> 23) & 1)
+#define GET_CONTENTS(desc)	(((desc)->b >> 10) & 3)
+#define GET_WRITABLE(desc)	(((desc)->b >>  9) & 1)
+#define GET_LIMIT_PAGES(desc)	(((desc)->b >> 23) & 1)
+#define GET_PRESENT(desc)	(((desc)->b >> 15) & 1)
+#define GET_USEABLE(desc)	(((desc)->b >> 20) & 1)
+
+		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX) {
+			ret = -EINVAL;
+			break;
+		}
+
+		desc = child->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
+
+		info.entry_number = idx;
+		info.base_addr = GET_BASE(desc);
+		info.limit = GET_LIMIT(desc);
+		info.seg_32bit = GET_32BIT(desc);
+		info.contents = GET_CONTENTS(desc);
+		info.read_exec_only = !GET_WRITABLE(desc);
+		info.limit_in_pages = GET_LIMIT_PAGES(desc);
+		info.seg_not_present = !GET_PRESENT(desc);
+		info.useable = GET_USEABLE(desc);
+
+		if (copy_to_user((struct user_desc *) data,
+				 &info, sizeof(info)))
+			ret = -EFAULT;
+		break;
+	}
+
+	case PTRACE_SET_THREAD_AREA: {
+		int idx = addr;
+		struct user_desc info;
+		struct desc_struct *desc;
+
+		if (copy_from_user(&info,
+				   (struct user_desc *) data, sizeof(info))) {
+			ret = -EFAULT;
+			break;
+		}
+		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX) {
+			ret = -EINVAL;
+			break;
+		}
+		desc = current->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
+		if (LDT_empty(&info)) {
+			desc->a = 0;
+			desc->b = 0;
+		} else {
+			desc->a = LDT_entry_a(&info);
+			desc->b = LDT_entry_b(&info);
+		}
+		ret = 0;
+		break;
+	}
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
