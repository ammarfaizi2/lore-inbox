Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966031AbWKIOYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966031AbWKIOYT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966030AbWKIOYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:24:19 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:36110 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S966031AbWKIOYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:24:18 -0500
Date: Thu, 9 Nov 2006 09:21:59 -0500
From: Neil Horman <nhorman@tuxdriver.com>
To: linux-kernel@vger.kernel.org, alan@redhat.com, davej@codemonkey.org.uk,
       akpm@osdl.org
Cc: nhorman@tuxdriver.com
Subject: [PATCH] i386: Fix machine_check entry point in entry.S to not dereference kernel memory from user space context
Message-ID: <20061109142159.GA4200@hmsreliant.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey-
        It appears that when the i386 arch traps on a machine check, the code in 
entry.S loads the vector pointed to by the machine_check_vector kernel varialbe.  
Since this happens before the switch to the kernel context in error_code, the 
result is an oops, if the reverenced address is unmapped, or silent memory 
corruption if the address is mapped.  This patch corrects that, by jumping 
instead to a statically allocated kernel function instead, allowing us to load a 
static value, rather than the contents of a memory address before the switch to 
kernel context, like all of our other entry points do.

Thanks & Regards
Neil

Signed-off-by: Neil Horman <nhorman@tuxdriver.com>


 cpu/mcheck/mce.c |    5 +++++
 cpu/mcheck/mce.h |    1 +
 entry.S          |    2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)


diff --git a/arch/i386/kernel/cpu/mcheck/mce.c b/arch/i386/kernel/cpu/mcheck/mce.c
index d555bec..a8e8e80 100644
--- a/arch/i386/kernel/cpu/mcheck/mce.c
+++ b/arch/i386/kernel/cpu/mcheck/mce.c
@@ -29,6 +29,11 @@ static fastcall void unexpected_machine_
 /* Call the installed machine check handler for this CPU setup. */
 void fastcall (*machine_check_vector)(struct pt_regs *, long error_code) = unexpected_machine_check;
 
+asmlinkage void do_machine_check(struct pt_regs *regs, long error_code)
+{
+	machine_check_vector(regs, error_code);
+}
+
 /* This has to be run for each processor */
 void mcheck_init(struct cpuinfo_x86 *c)
 {
diff --git a/arch/i386/kernel/cpu/mcheck/mce.h b/arch/i386/kernel/cpu/mcheck/mce.h
index 84fd4cf..0e7003f 100644
--- a/arch/i386/kernel/cpu/mcheck/mce.h
+++ b/arch/i386/kernel/cpu/mcheck/mce.h
@@ -8,6 +8,7 @@ void winchip_mcheck_init(struct cpuinfo_
 
 /* Call the installed machine check handler for this CPU setup. */
 extern fastcall void (*machine_check_vector)(struct pt_regs *, long error_code);
+extern asmlinkage void do_machine_check(struct pt_regs *, long error_code);
 
 extern int mce_disabled;
 extern int nr_mce_banks;
diff --git a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
index 5a63d6f..19a2929 100644
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -928,7 +928,7 @@ ENTRY(machine_check)
 	RING0_INT_FRAME
 	pushl $0
 	CFI_ADJUST_CFA_OFFSET 4
-	pushl machine_check_vector
+	pushl $do_machine_check
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *gpg keyid: 1024D / 0x92A74FA1 - http://pgp.mit.edu
 ***************************************************/
