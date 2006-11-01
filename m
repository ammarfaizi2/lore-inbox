Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946756AbWKAKar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946756AbWKAKar (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 05:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946757AbWKAKaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 05:30:46 -0500
Received: from ozlabs.org ([203.10.76.45]:58050 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1946756AbWKAKap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 05:30:45 -0500
Subject: [PATCH 4/7] paravirtualization: Allow selected bug checks to be
	skipped by paravirt kernels
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org,
       Chris Wright <chrisw@sous-sol.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1162376981.23462.10.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
	 <1162376981.23462.10.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 21:30:43 +1100
Message-Id: <1162377043.23462.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
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

===================================================================
--- a/arch/i386/kernel/cpu/intel.c
+++ b/arch/i386/kernel/cpu/intel.c
@@ -107,7 +107,7 @@ static void __cpuinit init_intel(struct 
 	 * Note that the workaround only should be initialized once...
 	 */
 	c->f00f_bug = 0;
-	if ( c->x86 == 5 ) {
+	if (!paravirt_enabled() && c->x86 == 5) {
 		static int f00f_workaround_enabled = 0;
 
 		c->f00f_bug = 1;
===================================================================
--- a/include/asm-i386/bugs.h
+++ b/include/asm-i386/bugs.h
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


