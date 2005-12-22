Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVLVPU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVLVPU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 10:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbVLVPU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 10:20:26 -0500
Received: from mail.ccur.com ([66.10.65.12]:6591 "EHLO mail.ccur.com")
	by vger.kernel.org with ESMTP id S1751092AbVLVPUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 10:20:25 -0500
Message-ID: <43AAC435.2090702@ccur.com>
Date: Thu, 22 Dec 2005 10:20:21 -0500
From: John Blackwood <john.blackwood@ccur.com>
Reply-To: john.blackwood@ccur.com
Organization: Concurrent Computer Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andi Kleen <ak@suse.de>, bugsy@ccur.com
Subject: [PATCH] arch/x86_64/kernel/ptrace.c linux-2.6.14.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Dec 2005 15:20:22.0768 (UTC) FILETIME=[3A1D6F00:01C6070B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

Our debugger guys noticed that the fs_base and/or gs_base values that
are returned on a ptrace(PTRACE_GETREGS, ...) call on x86_64 systems
don't always seem to be accurate.

It seems that some applications, and also the pthread library, may modify
the fs_base or gs_base values via the modify_ldt() or arch_prctl() system
service calls.  In these cases, the fs_base/gs_base value is saved off
in a different location than in the usual thread.fs or thread.gs fields.

After looking at the process.c and ldt.c source code, I came up with a
attempt at a patch below that seems to figure out the right location to
get the fs/gs base values from.

The read_tls_array() routine below is based off of the read_32bit_tls()
routine in process.c, and the read_ldt() routine below is based off of
the read_ldt() routine in ldt.c.

I suppose that the read_32bit_tls() code could be instead pulled into
a header file such as asm-x86_64/desc.h and shared between process.c
and ptrace.c instead of having the read_tls_array() code below, but I
didn't do that in this version of the patch.

Thank you for your time and considerations in this matter.



--- linux-2.6.14.4/arch/x86_64/kernel/ptrace.c	2005-12-14 
18:50:41.000000000 -0500
+++ new/arch/x86_64/kernel/ptrace.c	2005-12-21 16:32:25.000000000 -0500
@@ -287,6 +287,35 @@ static int putreg(struct task_struct *ch
  	return 0;
  }

+static inline unsigned long read_tls_array(struct task_struct *child, 
int idx)
+{
+	struct desc_struct *desc = (void *)child->thread.tls_array;
+	desc += idx;
+	return (unsigned long)((u32)desc->base0 |
+		(((u32)desc->base1) << 16) | (((u32)desc->base2) << 24));
+}
+
+static unsigned long read_ldt(struct task_struct *child)
+{
+	struct desc_struct *desc;
+	unsigned short index = child->thread.gsindex >> 3;
+	struct mm_struct *mm = child->mm;
+	unsigned long val;
+
+	if (!mm)
+		return 0;
+	down(&mm->context.sem);
+	if (index >= mm->context.size) {
+		up(&mm->context.sem);
+		return 0;
+	}
+	desc = mm->context.ldt;
+	desc += index;
+	val = desc->base0|((u32)desc->base1 << 16)|((u32)desc->base2 << 16);
+	up(&mm->context.sem);
+	return val;
+}
+
  static unsigned long getreg(struct task_struct *child, unsigned long 
regno)
  {
  	unsigned long val;
@@ -300,9 +329,17 @@ static unsigned long getreg(struct task_
  		case offsetof(struct user_regs_struct, es):
  			return child->thread.es;
  		case offsetof(struct user_regs_struct, fs_base):
-			return child->thread.fs;
+			if (!child->thread.fsindex)
+				return child->thread.fs;
+			if (child->thread.fsindex == FS_TLS_SEL)
+				return read_tls_array(child, FS_TLS);
+			return read_ldt(child);
  		case offsetof(struct user_regs_struct, gs_base):
-			return child->thread.gs;
+			if (!child->thread.gsindex)
+				return child->thread.gs;
+			if (child->thread.gsindex == GS_TLS_SEL)
+				return read_tls_array(child, GS_TLS);
+			return read_ldt(child);
  		default:
  			regno = regno - sizeof(struct pt_regs);
  			val = get_stack_long(child, regno);

