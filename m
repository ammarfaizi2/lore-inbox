Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTJGVXO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 17:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbTJGVXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 17:23:14 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:3056 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262940AbTJGVXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 17:23:11 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16259.11962.872427.626426@gargle.gargle.HOWL>
Date: Tue, 7 Oct 2003 23:23:06 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: perfctr-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: perfctr-2.6.1 build fix for amd64 in 2.6 SMP kernels
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for perfctr-2.6.1 fixes a problem which causes a
compilation error for amd64 (aka x86-64) in 2.6 SMP kernels.

The problem is that cpu_isset(cpu,mask) requires that mask
is an lvalue (it uses test_bit()), but on amd64 I want to
pass in a constant (the mask is always empty). Oops.

Thanks to Bryan O'Sullivan for reporting the build error.

/Mikael

--- perfctr-2.6.1/linux/drivers/perfctr/cpumask.h.~1~	2003-09-07 22:15:38.000000000 +0200
+++ perfctr-2.6.1/linux/drivers/perfctr/cpumask.h	2003-10-07 20:19:52.000000000 +0200
@@ -38,6 +38,8 @@
    but cpumask_t compatibility issues forced it to be moved here. */
 #if PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
 extern cpumask_t perfctr_cpus_forbidden_mask;
+#define perfctr_cpu_is_forbidden(cpu)	cpu_isset((cpu), perfctr_cpus_forbidden_mask)
 #else
 #define perfctr_cpus_forbidden_mask	CPU_MASK_NONE
+#define perfctr_cpu_is_forbidden(cpu)	0 /* cpu_isset() needs an lvalue :-( */
 #endif
--- perfctr-2.6.1/linux/drivers/perfctr/global.c.~1~	2003-10-02 22:04:35.000000000 +0200
+++ perfctr-2.6.1/linux/drivers/perfctr/global.c	2003-10-07 20:19:52.000000000 +0200
@@ -138,7 +138,7 @@
 		return ret;
 	if( cpu_control.cpu >= NR_CPUS ||
 	    !cpu_online(cpu_control.cpu) ||
-	    cpu_isset(cpu_control.cpu, perfctr_cpus_forbidden_mask) )
+	    perfctr_cpu_is_forbidden(cpu_control.cpu) )
 		return -EINVAL;
 	/* we don't permit i-mode counters */
 	if( cpu_control.cpu_control.nrictrs != 0 )
