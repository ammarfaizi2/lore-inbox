Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWDQTuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWDQTuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 15:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWDQTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 15:50:15 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:40328 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750808AbWDQTuN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 15:50:13 -0400
Date: Mon, 17 Apr 2006 15:49:14 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kdump: x86_64 add crashdump trigger points
Message-ID: <20060417194914.GC6576@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am reposting this patch as there was no response after I modified the
patch based on feedback. Is there a problem with the patch? If yes please
let me know, I shall rectify that.

We need this patch to trigger the booting of capture kernel if system is
hung and die_nmi() hits or some thread oopses and panic_on_oops is set.

System starts booting into capture kernel only if it is pre-loaded otherwise
normal operation continues and existing functionality is not impacted. 

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
---

 arch/x86_64/kernel/traps.c |    5 +++++
 1 file changed, 5 insertions(+)

diff -puN arch/x86_64/kernel/traps.c~kdump-x86_64-add-crashdump-trigger-points arch/x86_64/kernel/traps.c
--- linux-2.6.17-rc1-1M/arch/x86_64/kernel/traps.c~kdump-x86_64-add-crashdump-trigger-points	2006-04-11 08:37:08.000000000 -0400
+++ linux-2.6.17-rc1-1M-root/arch/x86_64/kernel/traps.c	2006-04-11 09:03:26.000000000 -0400
@@ -30,6 +30,7 @@
 #include <linux/moduleparam.h>
 #include <linux/nmi.h>
 #include <linux/kprobes.h>
+#include <linux/kexec.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -433,6 +434,8 @@ void __kprobes __die(const char * str, s
 	printk(KERN_ALERT "RIP ");
 	printk_address(regs->rip); 
 	printk(" RSP <%016lx>\n", regs->rsp); 
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 }
 
 void die(const char * str, struct pt_regs * regs, long err)
@@ -455,6 +458,8 @@ void __kprobes die_nmi(char *str, struct
 	 */
 	printk(str, safe_smp_processor_id());
 	show_registers(regs);
+	if (kexec_should_crash(current))
+		crash_kexec(regs);
 	if (panic_on_timeout || panic_on_oops)
 		panic("nmi watchdog");
 	printk("console shuts up ...\n");
_
