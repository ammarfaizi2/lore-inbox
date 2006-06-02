Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbWFBTrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbWFBTrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 15:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWFBTqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 15:46:43 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26497 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751450AbWFBTqQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 15:46:16 -0400
Message-Id: <20060602194745.224132000@sous-sol.org>
References: <20060602194618.482948000@sous-sol.org>
Date: Fri, 02 Jun 2006 00:00:09 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgewood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Vivek Goyal <vgoyal@in.ibm.com>, Andi Kleen <ak@suse.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/11] x86_64: x86_64 add crashdump trigger points
Content-Disposition: inline; filename=x86_64-add-crashdump-trigger-points.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Vivek Goyal <vgoyal@in.ibm.com>

o Start booting into the capture kernel after an Oops if system is in a
  unrecoverable state. System will boot into the capture kernel, if one is
  pre-loaded by the user, and capture the kernel core dump.

o One of the following conditions should be true to trigger the booting of
  capture kernel.
        - panic_on_oops is set.
        - pid of current thread is 0
        - pid of current thread is 1
        - Oops happened inside interrupt context.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/x86_64/kernel/traps.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.16.19.orig/arch/x86_64/kernel/traps.c
+++ linux-2.6.16.19/arch/x86_64/kernel/traps.c
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
+#include <linux/kexec.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -434,6 +435,8 @@ void __kprobes __die(const char * str, s
 	printk(KERN_ALERT "RIP ");
 	printk_address(regs->rip); 
 	printk(" RSP <%016lx>\n", regs->rsp); 
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 }
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -456,6 +459,8 @@ void __kprobes die_nmi(char *str, struct
 	 */
 	printk(str, safe_smp_processor_id());
 	show_registers(regs);
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 	if (panic_on_timeout || panic_on_oops)
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");

--
