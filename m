Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVAMIIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVAMIIb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbVAMIIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:08:31 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:43959 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261198AbVAMIHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:07:43 -0500
Date: Thu, 13 Jan 2005 13:40:37 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com, stsp@aknet.ru
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
Message-ID: <20050113081037.GE4965@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru> <20041207055348.GA1305@in.ibm.com> <41B5FA1B.9090507@aknet.ru> <20041209124738.GB5528@in.ibm.com> <41B8A759.80806@aknet.ru> <20050107113732.GB16906@in.ibm.com> <m1ekgxv1h4.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ekgxv1h4.fsf@muc.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

> > +		addr = (kprobe_opcode_t *) ((((*lp) >> 16 &  0x0000ffff)
> > +				| (*(lp +1) & 0xff000000)
> > +				| ((*(lp +1) << 16) & 0x00ff0000))

> With that patch we would have LDT reading code three times in the kernel
> now (ptrace, prefetch workaround and now this). How about you factor
> this out into a common helper function? This stuff is tricky enough
> that there are likely bugs in there anyways and it would be best 
> to only fix them at one place then.

The patch below moves this tricky code to a common place, please let
me know your comments. Ptrace uses a structure instead of unsigned long *.

Thanks
Prasanna


Calculating the base address of the segment is tricky and
is used in several places as well. This patch moves this tricky part
in a common place as suggested by Andi Kleen.

Signed-of-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.11-rc1-prasanna/arch/i386/kernel/kprobes.c |    7 +++----
 linux-2.6.11-rc1-prasanna/arch/i386/mm/fault.c       |    4 +---
 linux-2.6.11-rc1-prasanna/include/asm-i386/desc.h    |    9 +++++++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff -puN arch/i386/mm/fault.c~kprobes-desc-common-routine arch/i386/mm/fault.c
--- linux-2.6.11-rc1/arch/i386/mm/fault.c~kprobes-desc-common-routine	2005-01-13 11:29:49.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/arch/i386/mm/fault.c	2005-01-13 11:36:08.000000000 +0530
@@ -112,9 +112,7 @@ static inline unsigned long get_segment_
 	}
 
 	/* Decode the code segment base from the descriptor */
-	base =   (desc[0] >> 16) |
-		((desc[1] & 0xff) << 16) |
-		 (desc[1] & 0xff000000);
+	base = get_desc_base((unsigned long *)desc);
 
 	if (seg & (1<<2)) { 
 		up(&current->mm->context.sem);
diff -puN arch/i386/kernel/kprobes.c~kprobes-desc-common-routine arch/i386/kernel/kprobes.c
--- linux-2.6.11-rc1/arch/i386/kernel/kprobes.c~kprobes-desc-common-routine	2005-01-13 11:30:01.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/arch/i386/kernel/kprobes.c	2005-01-13 11:44:43.000000000 +0530
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/preempt.h>
 #include <asm/kdebug.h>
+#include <asm/desc.h>
 
 /* kprobe_status settings */
 #define KPROBE_HIT_ACTIVE	0x00000001
@@ -101,10 +102,8 @@ static int kprobe_handler(struct pt_regs
 	if ((regs->xcs & 4) && (current->mm)) {
 		lp = (unsigned long *) ((unsigned long)((regs->xcs >> 3) * 8)
 					+ (char *) current->mm->context.ldt);
-		addr = (kprobe_opcode_t *) ((((*lp) >> 16 &  0x0000ffff)
-				| (*(lp +1) & 0xff000000)
-				| ((*(lp +1) << 16) & 0x00ff0000))
-				+ regs->eip - sizeof(kprobe_opcode_t));
+		addr = (kprobe_opcode_t *) (get_desc_base(lp) + regs->eip -
+						sizeof(kprobe_opcode_t));
 	} else {
 		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
 	}
diff -puN include/asm-i386/desc.h~kprobes-desc-common-routine include/asm-i386/desc.h
--- linux-2.6.11-rc1/include/asm-i386/desc.h~kprobes-desc-common-routine	2005-01-13 11:30:11.000000000 +0530
+++ linux-2.6.11-rc1-prasanna/include/asm-i386/desc.h	2005-01-13 11:31:36.000000000 +0530
@@ -126,6 +126,15 @@ static inline void load_LDT(mm_context_t
 	put_cpu();
 }
 
+static inline unsigned long get_desc_base(unsigned long *desc)
+{
+	unsigned long base;
+	base = ((desc[0] >> 16)  & 0x0000ffff) |
+		((desc[1] << 16) & 0x00ff0000) |
+		(desc[1] & 0xff000000);
+	return base;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
