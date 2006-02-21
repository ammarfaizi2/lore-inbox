Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWBUXXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWBUXXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:23:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWBUXXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:23:06 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:51924 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750759AbWBUXXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:23:05 -0500
Date: Tue, 21 Feb 2006 18:19:58 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc4-mm1
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200602211822_MC3-1-B8F6-689@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060221134139.11b8668b.akpm@osdl.org>

On Tue, 21 Feb 2006 at 13:41:39 -0800, Andrew Morton wrote:

> None of these are must-have fixes, are they?   I had them queued for 2.6.17.

Well i386-allow-disabling-x86_feature_sep-at-boot.patch is for me.
I had to backport it to -rc4 for testing differences between sysenter
and int80 syscall paths.  I could live without it (I once forgot to apply
it and wondered why it wasn't working), but anyway here's the backport:


From: Chuck Ebbert <76306.1226@compuserve.com>

Allow the x86 "sep" feature to be disabled at bootup.  This forces use of the
int80 vsyscall.  Mainly for testing or benchmarking the int80 vsyscall code.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>

---

 Documentation/kernel-parameters.txt |    6 +++++-
 arch/i386/kernel/cpu/common.c       |   15 ++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

--- 2.6.16-rc3-nb.orig/Documentation/kernel-parameters.txt
+++ 2.6.16-rc3-nb/Documentation/kernel-parameters.txt
@@ -1002,7 +1002,9 @@ running once the system is up.
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable nn-executable mappings
 
-	nofxsr		[BUGS=IA-32]
+	nofxsr		[BUGS=IA-32] Disables x86 floating point extended
+			register save and restore. The kernel will only save
+			legacy floating-point registers on task switch.
 
 	nohlt		[BUGS=ARM]
 
@@ -1045,6 +1047,8 @@ running once the system is up.
 
 	nosbagart	[IA-64]
 
+	nosep		[BUGS=IA-32] Disables x86 SYSENTER/SYSEXIT support.
+
 	nosmp		[SMP] Tells an SMP kernel to act as a UP kernel.
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
--- 2.6.16-rc3-nb.orig/arch/i386/kernel/cpu/common.c
+++ 2.6.16-rc3-nb/arch/i386/kernel/cpu/common.c
@@ -22,8 +22,9 @@ DEFINE_PER_CPU(unsigned char, cpu_16bit_
 EXPORT_PER_CPU_SYMBOL(cpu_16bit_stack);
 
 static int cachesize_override __devinitdata = -1;
-static int disable_x86_fxsr __devinitdata = 0;
+static int disable_x86_fxsr __devinitdata;
 static int disable_x86_serial_nr __devinitdata = 1;
+static int disable_x86_sep __devinitdata;
 
 struct cpu_dev * cpu_devs[X86_VENDOR_NUM] = {};
 
@@ -183,6 +184,14 @@ static int __init x86_fxsr_setup(char * 
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
@@ -401,6 +410,10 @@ void __devinit identify_cpu(struct cpuin
 		clear_bit(X86_FEATURE_XMM, c->x86_capability);
 	}
 
+	/* SEP disabled? */
+	if (disable_x86_sep)
+		clear_bit(X86_FEATURE_SEP, c->x86_capability);
+
 	if (disable_pse)
 		clear_bit(X86_FEATURE_PSE, c->x86_capability);
 
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
