Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWAZSjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWAZSjv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWAZSjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:39:51 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:10729 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751358AbWAZSju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:39:50 -0500
Date: Thu, 26 Jan 2006 13:36:18 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.15] i386: allow disabling X86_FEATURE_SEP at boot
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       Daniel fernandez <ergot86@gmail.com>
Message-ID: <200601261339_MC3-1-B6C3-2E03@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow the x86 "sep" feature to be disabled at bootup.  This
forces use of the int80 vsyscall.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 Documentation/kernel-parameters.txt |    6 +++++-
 arch/i386/kernel/cpu/common.c       |   13 +++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

--- 2.6.15a.orig/arch/i386/kernel/cpu/common.c
+++ 2.6.15a/arch/i386/kernel/cpu/common.c
@@ -27,6 +27,7 @@ EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 static int cachesize_override __devinitdata = -1;
 static int disable_x86_fxsr __devinitdata = 0;
 static int disable_x86_serial_nr __devinitdata = 1;
+static int disable_x86_sep __devinitdata = 0;
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
@@ -177,6 +178,14 @@ static int __init x86_fxsr_setup(char * 
 __setup("nofxsr", x86_fxsr_setup);
 
 
+static int __init x86_sep_setup(char * s)
+{
+	disable_x86_sep = 1;
+	return 1;
+}
+__setup("nosep", x86_sep_setup);
+
+
 /* Standard macro to see if a specific flag is changeable */
 static inline int flag_is_changeable_p(u32 flag)
 {
@@ -392,6 +401,10 @@ void __devinit identify_cpu(struct cpuin
 		clear_bit(X86_FEATURE_XMM, c->x86_capability);
 	}
 
+	/* SEP disabled? */
+	if (disable_x86_sep)
+		clear_bit(X86_FEATURE_SEP, c->x86_capability);
+
 	if (disable_pse)
 		clear_bit(X86_FEATURE_PSE, c->x86_capability);
 
--- 2.6.15a.orig/Documentation/kernel-parameters.txt
+++ 2.6.15a/Documentation/kernel-parameters.txt
@@ -929,7 +929,9 @@ running once the system is up.
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable nn-executable mappings
 
-	nofxsr		[BUGS=IA-32]
+	nofxsr		[BUGS=IA-32] Disables x86 floating point extended
+			register save and restore. The kernel will only save
+			legacy floating-point registers on task switch.
 
 	nohlt		[BUGS=ARM]
 
@@ -972,6 +974,8 @@ running once the system is up.
 
 	nosbagart	[IA-64]
 
+	nosep		[BUGS=IA-32] Disables x86 SYSENTER/SYSEXIT support.
+
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel.
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
-- 
Chuck
Currently reading: _The Atrocity Archives_ by Charles Stross
