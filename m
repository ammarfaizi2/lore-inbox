Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbULGFwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbULGFwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 00:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbULGFwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 00:52:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:46831 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261760AbULGFwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 00:52:10 -0500
Date: Tue, 7 Dec 2004 11:23:48 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
Message-ID: <20041207055348.GA1305@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru> <20041117131552.GA11053@in.ibm.com> <41B1FD4B.9000208@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B1FD4B.9000208@aknet.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stas,

> I've found yet another bug in this
> very same piece of code. Now I can
> reproduce the interrupt theft without
> using either vm86() or modify_ldt().

The patch below should fix this problem. Please
let me know if you any issues.

Regards
Prasanna



Stas repoted that kprobes steals int3 exceptions when not in 
virtual-8086 mode. This patch fixes the problem by returning 0,
if the int3 exceptions does not belong to kprobes.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


---

 linux-2.6.10-rc3-prasanna/arch/i386/kernel/kprobes.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN arch/i386/kernel/kprobes.c~kprobes-steals-int3 arch/i386/kernel/kprobes.c
--- linux-2.6.10-rc3/arch/i386/kernel/kprobes.c~kprobes-steals-int3	2004-12-07 11:20:33.000000000 +0530
+++ linux-2.6.10-rc3-prasanna/arch/i386/kernel/kprobes.c	2004-12-07 11:20:34.000000000 +0530
@@ -127,10 +127,10 @@ static inline int kprobe_handler(struct 
 			 * The breakpoint instruction was removed right
 			 * after we hit it.  Another cpu has removed
 			 * either a probepoint or a debugger breakpoint
-			 * at this address.  In either case, no further
-			 * handling of this interrupt is appropriate.
+			 * at this address. In either case, kprobes
+			 * need not handle it.
 			 */
-			ret = 1;
+			ret = 0;
 		}
 		/* Not one of ours: let kernel handle it */
 		goto no_kprobe;

_
-- 

Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>
