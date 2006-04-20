Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWDTCTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWDTCTY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 22:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWDTCTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 22:19:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41875 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750731AbWDTCTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 22:19:23 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
cc: Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Keith Owens <kaos@sgi.com>, Dean Nelson <dcn@sgi.com>,
       Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>
Subject: Re: [(resend)patch 3/7] Notify page fault call chain for ia64 
In-reply-to: Your message of "Wed, 19 Apr 2006 15:14:22 MST."
             <20060419221948.015059242@csdlinux-2.jf.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 20 Apr 2006 12:18:25 +1000
Message-ID: <7375.1145499505@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anil S Keshavamurthy (on Wed, 19 Apr 2006 15:14:22 -0700) wrote:
>Overloading of page fault notification with the
>notify_die() has performance issues(since the
>only interested components for page fault is
>kprobes and/or kdb) and hence this patch introduces 
>the new notifier call chain exclusively for page 
>fault notifications their by avoiding notifying
>unnecessary components in the do_page_fault() code
>path.
>
>Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
>---
> arch/ia64/kernel/traps.c  |   11 +++++++++++
>===================================================================
>--- linux-2.6.17-rc1-mm3.orig/arch/ia64/kernel/traps.c
>+++ linux-2.6.17-rc1-mm3/arch/ia64/kernel/traps.c
>@@ -31,6 +31,7 @@ fpswa_interface_t *fpswa_interface;
> EXPORT_SYMBOL(fpswa_interface);
> 
> ATOMIC_NOTIFIER_HEAD(ia64die_chain);
>+ATOMIC_NOTIFIER_HEAD(notify_page_fault_chain);
> 
> int
> register_die_notifier(struct notifier_block *nb)
>@@ -46,6 +47,16 @@ unregister_die_notifier(struct notifier_
> }
> EXPORT_SYMBOL_GPL(unregister_die_notifier);
> 
>+int register_page_fault_notifier(struct notifier_block *nb)
>+{
>+	return atomic_notifier_chain_register(&notify_page_fault_chain, nb);
>+}
>+
>+int unregister_page_fault_notifier(struct notifier_block *nb)
>+{
>+	return atomic_notifier_chain_unregister(&notify_page_fault_chain, nb);
>+}
>+

Why is register_page_fault_notifier defined in traps.c?  Surely it
should be in mm/fault.c, which is the only place that uses the chain.

> trap_init (void)
> {
>Index: linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
>===================================================================
>--- linux-2.6.17-rc1-mm3.orig/arch/ia64/mm/fault.c
>+++ linux-2.6.17-rc1-mm3/arch/ia64/mm/fault.c
>@@ -84,7 +84,7 @@ ia64_do_page_fault (unsigned long addres
> 	/*
> 	 * This is to handle the kprobes on user space access instructions
> 	 */
>-	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, code, TRAP_BRKPT,
>+	if (notify_page_fault(DIE_PAGE_FAULT, "page fault", regs, code, TRAP_BRKPT,
> 					SIGSEGV) == NOTIFY_STOP)
> 		return;

Since this is a critical path, please remove all references to
notify_page_fault() and its register functions when CONFIG_KPROBES=n.

