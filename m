Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267782AbTAMDm4>; Sun, 12 Jan 2003 22:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267793AbTAMDm4>; Sun, 12 Jan 2003 22:42:56 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:12422 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S267782AbTAMDmn>; Sun, 12 Jan 2003 22:42:43 -0500
Date: Sun, 12 Jan 2003 19:51:28 -0800
Message-Id: <200301130351.h0D3pSh02563@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: PTRACE_GET_THREAD_AREA
In-Reply-To: Linus Torvalds's message of  Friday, 20 December 2002 17:42:36 +0000 <atvkqc$6kr$1@penguin.transmeta.com>
Emacs: resistance is futile; you will be assimilated and byte-compiled.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.  I didn't get your reply until just recently when someone
forwarded it to me, because I'm not on the mailing list.  Please be sure to
include <roland@redhat.com> directly on any replies you make.

> Looks fine, except I'd ask you to split up the get/set logic as separate
> functions, instead of making that case-statement thing horribly big.

No problem.  Here is a new version of the patch.  Please let me know if
there is any reason this can't go in ASAP.


Thanks,
Roland


--- linux-2.5.54/include/asm-i386/ptrace.h.orig	Mon Dec  9 18:45:43 2002
+++ linux-2.5.54/include/asm-i386/ptrace.h	Fri Jan 10 16:39:44 2003
@@ -51,6 +51,9 @@ struct pt_regs {
 
 #define PTRACE_OLDSETOPTIONS         21
 
+#define PTRACE_GET_THREAD_AREA    25
+#define PTRACE_SET_THREAD_AREA    26
+
 #ifdef __KERNEL__
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
[Exit 1]
--- linux-2.5.54/arch/i386/kernel/ptrace.c.orig	Fri Jan 10 16:40:18 2003
+++ linux-2.5.54/arch/i386/kernel/ptrace.c	Fri Jan 10 12:38:30 2003
@@ -21,6 +21,8 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/debugreg.h>
+#include <asm/ldt.h>
+#include <asm/desc.h>
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -148,6 +150,85 @@ void ptrace_disable(struct task_struct *
 	put_stack_long(child, EFL_OFFSET, tmp);
 }
 
+/*
+ * Perform get_thread_area on behalf of the traced child.
+ */
+static int
+ptrace_get_thread_area(struct task_struct *child,
+		       int idx, struct user_desc *user_desc)
+{
+	struct user_desc info;
+	struct desc_struct *desc;
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
+	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+		return -EINVAL;
+
+	desc = child->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
+
+	info.entry_number = idx;
+	info.base_addr = GET_BASE(desc);
+	info.limit = GET_LIMIT(desc);
+	info.seg_32bit = GET_32BIT(desc);
+	info.contents = GET_CONTENTS(desc);
+	info.read_exec_only = !GET_WRITABLE(desc);
+	info.limit_in_pages = GET_LIMIT_PAGES(desc);
+	info.seg_not_present = !GET_PRESENT(desc);
+	info.useable = GET_USEABLE(desc);
+
+	if (copy_to_user(user_desc, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * Perform set_thread_area on behalf of the traced child.
+ */
+static int
+ptrace_set_thread_area(struct task_struct *child,
+		       int idx, struct user_desc *user_desc)
+{
+	struct user_desc info;
+	struct desc_struct *desc;
+
+	if (copy_from_user(&info, user_desc, sizeof(info)))
+		return -EFAULT;
+
+	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+		return -EINVAL;
+
+	desc = child->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
+	if (LDT_empty(&info)) {
+		desc->a = 0;
+		desc->b = 0;
+	} else {
+		desc->a = LDT_entry_a(&info);
+		desc->b = LDT_entry_b(&info);
+	}
+
+	return 0;
+}
+
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -416,6 +497,16 @@ asmlinkage int sys_ptrace(long request, 
 		break;
 	}
 
+	case PTRACE_GET_THREAD_AREA:
+		ret = ptrace_get_thread_area(child,
+					     addr, (struct user_desc *) data);
+		break;
+
+	case PTRACE_SET_THREAD_AREA:
+		ret = ptrace_set_thread_area(child,
+					     addr, (struct user_desc *) data);
+		break;
+
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
