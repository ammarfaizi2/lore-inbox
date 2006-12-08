Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947551AbWLIAEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947551AbWLIAEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 19:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947557AbWLIADi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 19:03:38 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37669 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1947543AbWLIACH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 19:02:07 -0500
Message-Id: <20061209000328.188464000@sous-sol.org>
References: <20061208235751.890503000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 08 Dec 2006 15:58:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, ak@muc.de
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, shai@scalex86.org, kiran@scalex86.org
Subject: [patch 31/32] x86_64: fix boot hang due to nmi watchdog init code
Content-Disposition: inline; filename=x86_64-fix-boot-hang-due-to-nmi-watchdog-init-code.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Ravikiran G Thirumalai <kiran@scalex86.org>

2.6.19 stopped booting (or booted based on build/config) on our x86_64
systems due to a bug introduced in 2.6.19.  check_nmi_watchdog schedules an
IPI on all cpus to busy wait on a flag, but fails to set the busywait flag
if NMI functionality is disabled.

This causes the secondary cpus to spin in an endless loop, causing the
kernel bootup to hang.

Depending upon the build, the busywait flag got overwritten (stack
variable) and caused the kernel to bootup on certain builds.  Following
patch fixes the bug by setting the busywait flag before returning from
check_nmi_watchdog.

I guess using a stack variable is not good here as the calling function
could potentially return while the busy wait loop is still spinning on the
flag.  I would think this is a good candidate for 2.6.19 stable as well.

[akpm@osdl.org: cleanups]
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>
Cc: Andi Kleen <ak@muc.de>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/x86_64/kernel/nmi.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.19/arch/x86_64/kernel/nmi.c
@@ -212,7 +212,7 @@ static __init void nmi_cpu_busy(void *da
 
 int __init check_nmi_watchdog (void)
 {
-	volatile int endflag = 0;
+	static int __initdata endflag;
 	int *counts;
 	int cpu;
 
@@ -253,6 +253,7 @@ int __init check_nmi_watchdog (void)
 	if (!atomic_read(&nmi_active)) {
 		kfree(counts);
 		atomic_set(&nmi_active, -1);
+		endflag = 1;
 		return -1;
 	}
 	endflag = 1;

--
