Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVFVJhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVFVJhF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:37:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVFVJej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:34:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:44494 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262828AbVFVJdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:33:17 -0400
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17081.12364.233751.561472@alkaid.it.uu.se>
Date: Wed, 22 Jun 2005 11:33:00 +0200
To: akpm@osdl.org
Subject: [PATCH 2.6.12-mm1] perfctr: handle non-OF ppc32 platforms
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ppc32 kernels configured without Open Firmware support
(typical for embedded systems), perfctr causes a linkage
error due to unconditional references to OF querying functions.

This patch fixes that by stubbing out the offending code
when OF is absent. There are already fallbacks in place in
case OF fails, so things (core frequency detection) still work,
at least for supported CPU types.

Fixes a problem originally reported for perfctr-2.6.x by
Jean-Christophe Dubois.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -rupN linux-2.6.12-mm1/drivers/perfctr/ppc.c linux-2.6.12-mm1.perfctr-ppc32-no-of-fix/drivers/perfctr/ppc.c
--- linux-2.6.12-mm1/drivers/perfctr/ppc.c	2005-06-22 00:35:44.000000000 +0200
+++ linux-2.6.12-mm1.perfctr-ppc32-no-of-fix/drivers/perfctr/ppc.c	2005-06-22 01:32:09.000000000 +0200
@@ -888,6 +888,7 @@ static unsigned int __init pll_to_core_k
 
 /* Extract core and timebase frequencies from Open Firmware. */
 
+#ifdef CONFIG_PPC_OF
 static unsigned int __init of_to_core_khz(void)
 {
 	struct device_node *cpu;
@@ -905,6 +906,9 @@ static unsigned int __init of_to_core_kh
 	perfctr_info.tsc_to_cpu_mult = core / tb;
 	return core / 1000;
 }
+#else
+static inline unsigned int of_to_core_khz(void) { return 0; }
+#endif
 
 static unsigned int __init detect_cpu_khz(enum pll_type pll_type)
 {
