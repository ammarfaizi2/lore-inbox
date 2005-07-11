Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVGKPah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVGKPah (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVGKPaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:30:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:8136 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261998AbVGKPaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:30:24 -0400
Date: Mon, 11 Jul 2005 08:30:53 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, zwane@arm.linux.org.uk, ak@muc.de
Subject: [PATCH 1/2] NMI: Update NMI users of RCU to use new API
Message-ID: <20050711153052.GA1615@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uses of RCU for dynamically changeable NMI handlers need to use the
new rcu_dereference() and rcu_assign_pointer() facilities.  This change
makes it clear that these uses are safe from a memory-barrier viewpoint,
but the main purpose is to document exactly what operations are being
protected by RCU.  This has been tested on x86 and x86-64, which are
the only architectures affected by this change.

Signed-off-by: <paulmck@us.ibm.com>
---

 i386/kernel/traps.c |    4 ++--
 x86_64/kernel/nmi.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff -urpN -X dontdiff linux-2.6.12-rc6/arch/i386/kernel/traps.c linux-2.6.12-rc6-NMIRCUfix/arch/i386/kernel/traps.c
--- linux-2.6.12-rc6/arch/i386/kernel/traps.c	2005-06-17 16:34:17.000000000 -0700
+++ linux-2.6.12-rc6-NMIRCUfix/arch/i386/kernel/traps.c	2005-07-01 15:16:24.000000000 -0700
@@ -626,7 +626,7 @@ fastcall void do_nmi(struct pt_regs * re
 	cpu = smp_processor_id();
 	++nmi_count(cpu);
 
-	if (!nmi_callback(regs, cpu))
+	if (!rcu_dereference(nmi_callback)(regs, cpu))
 		default_do_nmi(regs);
 
 	nmi_exit();
@@ -634,7 +634,7 @@ fastcall void do_nmi(struct pt_regs * re
 
 void set_nmi_callback(nmi_callback_t callback)
 {
-	nmi_callback = callback;
+	rcu_assign_pointer(nmi_callback, callback);
 }
 
 void unset_nmi_callback(void)
diff -urpN -X dontdiff linux-2.6.12-rc6/arch/x86_64/kernel/nmi.c linux-2.6.12-rc6-NMIRCUfix/arch/x86_64/kernel/nmi.c
--- linux-2.6.12-rc6/arch/x86_64/kernel/nmi.c	2005-06-17 16:34:24.000000000 -0700
+++ linux-2.6.12-rc6-NMIRCUfix/arch/x86_64/kernel/nmi.c	2005-07-01 15:15:21.000000000 -0700
@@ -522,14 +522,14 @@ asmlinkage void do_nmi(struct pt_regs * 
 
 	nmi_enter();
 	add_pda(__nmi_count,1);
-	if (!nmi_callback(regs, cpu))
+	if (!rcu_dereference(nmi_callback)(regs, cpu))
 		default_do_nmi(regs);
 	nmi_exit();
 }
 
 void set_nmi_callback(nmi_callback_t callback)
 {
-	nmi_callback = callback;
+	rcu_assign_pointer(nmi_callback, callback);
 }
 
 void unset_nmi_callback(void)
