Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261774AbVC1NrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261774AbVC1NrA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 08:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbVC1No0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:44:26 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:49593 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261774AbVC1N0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:26:39 -0500
Subject: [RFC/PATCH 6/17][Kdump] NMI handler segment selector, stack
	pointer fix
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-5K+jwJ8cbuQ2fF/wjgbF"
Date: Mon, 28 Mar 2005 18:56:34 +0530
Message-Id: <1112016394.4001.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5K+jwJ8cbuQ2fF/wjgbF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-5K+jwJ8cbuQ2fF/wjgbF
Content-Disposition: attachment; filename=x86-nmi-handler-ss-esp-fix.patch
Content-Type: message/rfc822; name=x86-nmi-handler-ss-esp-fix.patch

From: 
Date: Mon, 28 Mar 2005 17:35:11 +0530
Subject: No Subject
Message-Id: <1112011511.4001.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: "Vivek Goyal" <vgoyal@in.ibm.com>

o CPU does not save ss and esp on stack if execution was already in kernel 
  mode at the time of NMI occurrence. This leads to saving of erractic values
  for ss and esp. This patch fixes the issue.  

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm3-1M-root/arch/i386/kernel/crash.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff -puN arch/i386/kernel/crash.c~x86-nmi-handler-ss-esp-fix arch/i386/kernel/crash.c
--- linux-2.6.12-rc1-mm3-1M/arch/i386/kernel/crash.c~x86-nmi-handler-ss-esp-fix	2005-03-27 18:50:50.000000000 +0530
+++ linux-2.6.12-rc1-mm3-1M-root/arch/i386/kernel/crash.c	2005-03-27 18:56:16.000000000 +0530
@@ -112,7 +112,20 @@ static atomic_t waiting_for_crash_ipi;
 
 static int crash_nmi_callback(struct pt_regs *regs, int cpu)
 {
+	struct pt_regs fixed_regs;
 	local_irq_disable();
+
+	/* CPU does not save ss and esp on stack if execution is already
+	 * running in kernel mode at the time of NMI occurrence. This code
+	 * fixes it.
+	 */
+	if (!user_mode(regs)) {
+		memcpy(&fixed_regs, regs, sizeof(*regs));
+		fixed_regs.esp = (unsigned long)&(regs->esp);
+		__asm__ __volatile__("xorl %eax, %eax;");
+		__asm__ __volatile__ ("movw %%ss, %%ax;" :"=a"(fixed_regs.xss));
+		regs = &fixed_regs;
+	}
 	crash_save_this_cpu(regs, cpu);
 	disable_local_APIC();
 	atomic_dec(&waiting_for_crash_ipi);
_

--=-5K+jwJ8cbuQ2fF/wjgbF--

