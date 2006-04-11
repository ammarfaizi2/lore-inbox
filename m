Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWDKPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWDKPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWDKPp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:45:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:8938 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750706AbWDKPp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:45:58 -0400
Date: Tue, 11 Apr 2006 11:45:46 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W.Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] kdump: x86_64 add crashdump trigger points
Message-ID: <20060411154545.GA5359@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060410220511.GB24711@in.ibm.com> <20060411024439.GB52164@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411024439.GB52164@muc.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 04:44:39AM +0200, Andi Kleen wrote:
> On Mon, Apr 10, 2006 at 06:05:11PM -0400, Vivek Goyal wrote:
> > 
> > 
> > o Start booting into the capture kernel after an Oops if system is in a
> >   unrecoverable state. System will boot into the capture kernel, if one is
> >   pre-loaded by the user, and capture the kernel core dump.
> > 
> > o One of the following conditions should be true to trigger the booting of
> >   capture kernel.
> > 	- panic_on_oops is set.
> > 	- pid of current thread is 0
> > 	- pid of current thread is 1
> > 	- Oops happened inside interrupt context.  
> 
> I would rather put it into die(). Then the patch will be much smaller
> too.

Not everybody calls die(), instead they call __die() directly. For example
do_page_fault(), pgtable_bad(). Hence I am putting this call inside __die().

Anyway, if capture kernel is loaded, after displaying the registers and
backtrace, we probably don't want to do anything else and just boot into
capture kernel. Please find attached the modified patch.



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
