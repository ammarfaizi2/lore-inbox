Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVAGLhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVAGLhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 06:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVAGLhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 06:37:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:34813 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261344AbVAGLgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 06:36:49 -0500
Date: Fri, 7 Jan 2005 17:07:32 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
Message-ID: <20050107113732.GB16906@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru> <20041207055348.GA1305@in.ibm.com> <41B5FA1B.9090507@aknet.ru> <20041209124738.GB5528@in.ibm.com> <41B8A759.80806@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B8A759.80806@aknet.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stas,

On Thu, Dec 09, 2004 at 10:28:25PM +0300, Stas Sergeev wrote:

> OK, but if you need another test-case,
> here it is. Much simpler than the vm86 one.
> It can work in 2 modes: started without args,
> it will print the diagnostic (passed or
> failed) and exit. If started with any arg,
> it will Oops the kernel.
> This happens both with your latest patch
> and without it. This doesn't happen with
> your previous patch (no Oops), but then fixing
> problems by exploiting the gcc optimization
> was not the best idea I think.
> 

The patch below fixes this problem.
Please let me know your comments.

Thanks
Prasanna



The address used by the kprobes handler was not correct if the application
was using LDT entries for code segment. This patch fixes the above problem by
calculating the address using base address of the current code segment.
Also this patch removes the inline prefix of kprobe_handler() .

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.10-prasanna/arch/i386/kernel/kprobes.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-corrupt-eip arch/i386/kernel/kprobes.c
--- linux-2.6.10/arch/i386/kernel/kprobes.c~kprobes-corrupt-eip	2005-01-07 17:01:37.000000000 +0530
+++ linux-2.6.10-prasanna/arch/i386/kernel/kprobes.c	2005-01-07 17:01:49.000000000 +0530
@@ -86,15 +86,28 @@ static inline void prepare_singlestep(st
  * Interrupts are disabled on entry as trap3 is an interrupt gate and they
  * remain disabled thorough out this function.
  */
-static inline int kprobe_handler(struct pt_regs *regs)
+static int kprobe_handler(struct pt_regs *regs)
 {
 	struct kprobe *p;
 	int ret = 0;
-	u8 *addr = (u8 *) (regs->eip - 1);
+	kprobe_opcode_t *addr = NULL;
+	unsigned long *lp;
 
 	/* We're in an interrupt, but this is clear and BUG()-safe. */
 	preempt_disable();
-
+	/* Check if the application is using LDT entry for its code segment and
+	 * calculate the address by reading the base address from the LDT entry.
+	 */
+	if ((regs->xcs & 4) && (current->mm)) {
+		lp = (unsigned long *) ((unsigned long)((regs->xcs >> 3) * 8)
+					+ (char *) current->mm->context.ldt);
+		addr = (kprobe_opcode_t *) ((((*lp) >> 16 &  0x0000ffff)
+				| (*(lp +1) & 0xff000000)
+				| ((*(lp +1) << 16) & 0x00ff0000))
+				+ regs->eip - sizeof(kprobe_opcode_t));
+	} else {
+		addr = (kprobe_opcode_t *)(regs->eip - sizeof(kprobe_opcode_t));
+	}
 	/* Check we're not actually recursing */
 	if (kprobe_running()) {
 		/* We *are* holding lock here, so this is safe.

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
