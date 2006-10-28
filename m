Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbWJ2Cpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbWJ2Cpn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 22:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWJ2Cpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 22:45:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:425 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964948AbWJ2Cpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 22:45:34 -0400
Message-Id: <20061029024606.496399000@sous-sol.org>
References: <20061029024504.760769000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Sat, 28 Oct 2006 00:00:04 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: akpm@osdl.org, ak@muc.de
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>, Zachary Amsden <zach@vmware.com>,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org
Subject: [PATCH 4/7] Allow selected bug checks to be skipped by paravirt kernels
Content-Disposition: inline; filename=015-disable-bug-checking.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow selected bug checks to be skipped by paravirt kernels.  The two most
important are the F00F workaround (which is either done by the hypervisor,
or not required), and the 'hlt' instruction check, which can break under
some hypervisors.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>

---
 arch/i386/kernel/cpu/intel.c |    2 +-
 include/asm-i386/bugs.h      |    4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6-pv.orig/arch/i386/kernel/cpu/intel.c
+++ linux-2.6-pv/arch/i386/kernel/cpu/intel.c
@@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct 
 	 * Note that the workaround only should be initialized once...
 	 */
 	c->f00f_bug = 0;
-	if ( c->x86 == 5 ) {
+	if (!paravirt_enabled() && c->x86 == 5) {
 		static int f00f_workaround_enabled = 0;
 
 		c->f00f_bug = 1;
--- linux-2.6-pv.orig/include/asm-i386/bugs.h
+++ linux-2.6-pv/include/asm-i386/bugs.h
@@ -21,6 +21,7 @@
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/msr.h>
+#include <asm/paravirt.h>
 
 static int __init no_halt(char *s)
 {
@@ -91,6 +92,9 @@ static void __init check_fpu(void)
 
 static void __init check_hlt(void)
 {
+	if (paravirt_enabled())
+		return;
+
 	printk(KERN_INFO "Checking 'hlt' instruction... ");
 	if (!boot_cpu_data.hlt_works_ok) {
 		printk("disabled\n");

--
