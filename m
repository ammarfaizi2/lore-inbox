Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbULIMqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbULIMqR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 07:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbULIMqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 07:46:17 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:62155 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261515AbULIMqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 07:46:09 -0500
Date: Thu, 9 Dec 2004 18:17:38 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
Message-ID: <20041209124738.GB5528@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru> <20041207055348.GA1305@in.ibm.com> <41B5FA1B.9090507@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B5FA1B.9090507@aknet.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
> Now the comments (that you just altered)
> suggest that the break-point can be
> removed by another CPU. I don't think
> delivering the fault to the user-space
> in this case is wise (but that's what
> I'd care least, as I am not using the
> kprobes myself yet). Maybe instead
> it would be better to return 1 when

The patch below takes both the cases into 
consideration. 

> Also, you still use the completely
> invalid addrress and pass it to several
> functions like get_kprobe() (addr is
> invalid in either v86 case or when the
> segmentation is used). Since the
> deref is now optimized away by gcc, I
> can't write an Oops test-case for this,
> but why you do not perform the sanity
> checks to see whether or not the address
> is valid? (the checks like I suggested
> in previous posting)
> 
I am not able to think of a case, where 
address is invalid when it enters int3 handler.
I would appreciate if you can provide such a
test case.

Your comments are welcome.

Thanks
Prasanna


Stas reported that kprobes steals int3 exceptions when not in 
virtual-8086 mode. If processor  executes int 3 INT n type instruction, it
will end up executing int3 handler. This patch fixes the problem by returning 0,
if the int3 exceptions does not belong to kprobes and allowing the kernel to 
handle it.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.10-rc3-prasanna/arch/i386/kernel/kprobes.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-steals-int3 arch/i386/kernel/kprobes.c
--- linux-2.6.10-rc3/arch/i386/kernel/kprobes.c~kprobes-steals-int3	2004-12-09 17:09:08.000000000 +0530
+++ linux-2.6.10-rc3-prasanna/arch/i386/kernel/kprobes.c	2004-12-09 17:09:36.000000000 +0530
@@ -117,8 +117,12 @@ static inline int kprobe_handler(struct 
 	p = get_kprobe(addr);
 	if (!p) {
 		unlock_kprobes();
-		if (regs->eflags & VM_MASK) {
-			/* We are in virtual-8086 mode. Return 0 */
+		if ((regs->eflags & VM_MASK) ||
+				((*addr == 0x3) && (*(addr - 1) == 0xcd))) {
+			/* Either we are in virtual-8086 mode, or we executed
+			 * int 3 INT n type instruction. Let kernel handle
+			 * it, return 0.
+			 */
 			goto no_kprobe;
 		}
 

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
