Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVDAIg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVDAIg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 03:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVDAIg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 03:36:28 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:4503 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261752AbVDAIgD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 03:36:03 -0500
Date: Fri, 1 Apr 2005 14:07:10 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: SystemTAP <systemtap@sources.redhat.com>, akpm@osdl.org,
       Andi Kleen <ak@muc.de>, davem@davemloft.net, ananth@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Kprobes: Incorrect handling of probes on ret/lret instruction
Message-ID: <20050401083710.GA1681@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kprobes could not handle the insertion of a probe on the ret/lret instruction
and used to oops after single stepping since kprobes was modifying eip/rip 
incorrectly. Adjustment of eip/rip is not required after single stepping in 
case of ret/lret instruction, because eip/rip points to the correct location 
after execution of the ret/lret instruction. This patch fixes the above problem.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>

---



---

 linux-2.6.12-rc1-prasanna/arch/i386/kernel/kprobes.c   |    7 +++++++
 linux-2.6.12-rc1-prasanna/arch/x86_64/kernel/kprobes.c |    7 +++++++
 2 files changed, 14 insertions(+)

diff -puN arch/i386/kernel/kprobes.c~kprobes-ret-address-fix arch/i386/kernel/kprobes.c
--- linux-2.6.12-rc1/arch/i386/kernel/kprobes.c~kprobes-ret-address-fix	2005-03-31 14:32:56.000000000 +0530
+++ linux-2.6.12-rc1-prasanna/arch/i386/kernel/kprobes.c	2005-03-31 14:37:24.000000000 +0530
@@ -218,6 +218,13 @@ static void resume_execution(struct kpro
 		*tos &= ~(TF_MASK | IF_MASK);
 		*tos |= kprobe_old_eflags;
 		break;
+	case 0xc3:		/* ret/lret */
+	case 0xcb:
+	case 0xc2:
+	case 0xca:
+		regs->eflags &= ~TF_MASK;
+		/* eip is already adjusted, no more changes required*/
+		return;
 	case 0xe8:		/* call relative - Fix return addr */
 		*tos = orig_eip + (*tos - copy_eip);
 		break;
diff -puN arch/x86_64/kernel/kprobes.c~kprobes-ret-address-fix arch/x86_64/kernel/kprobes.c
--- linux-2.6.12-rc1/arch/x86_64/kernel/kprobes.c~kprobes-ret-address-fix	2005-03-31 14:33:31.000000000 +0530
+++ linux-2.6.12-rc1-prasanna/arch/x86_64/kernel/kprobes.c	2005-03-31 14:37:08.000000000 +0530
@@ -231,6 +231,13 @@ static void resume_execution(struct kpro
 		*tos &= ~(TF_MASK | IF_MASK);
 		*tos |= kprobe_old_rflags;
 		break;
+	case 0xc3:		/* ret/lret */
+	case 0xcb:
+	case 0xc2:
+	case 0xca:
+		regs->eflags &= ~TF_MASK;
+		/* rip is already adjusted, no more changes required*/
+		return;
 	case 0xe8:		/* call relative - Fix return addr */
 		*tos = orig_rip + (*tos - copy_rip);
 		break;

_

Thanks
Prasanna
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
