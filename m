Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWD2SaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWD2SaQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 14:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWD2SaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 14:30:15 -0400
Received: from aun.it.uu.se ([130.238.12.36]:17361 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750777AbWD2SaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 14:30:15 -0400
Date: Sat, 29 Apr 2006 20:30:10 +0200 (MEST)
Message-Id: <200604291830.k3TIUA23009336@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: discuss@x86-64.org
Subject: [RFC] make PC Speaker driver work on x86-64
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a pair of Athlon64 machines that dual-boot 32-bit and
64-bit kernels. One annoying difference between the kernels
is that the PC Speaker driver (CONFIG_INPUT_PCSPKR=y) only
works in the 32-bit kernels. In the 64-bit kernels it remains
inactive and doesn't even generate any boot-time initialisation
or error messages.

Today I debugged that issue, and found that the PC Speaker
driver's ->probe() routine doesn't even get called in the
64-bit kernels. The reason for that is that the arch code
apparently has to explictly add a "pcspkr" platform device
in order for the driver core to call the ->probe() routine.
arch/i386/kernel/setup.c unconditionally adds a "pcspkr"
device, but the x86_64 kernel has no code at all related to
the PC Speaker.

The patch below copies the relevant code from i386 to x86_64,
which makes the PC Speaker work for me on x86_64.

Is there a better way to do this? ACPI?

/Mikael

diff -rupN linux-2.6.17-rc3/arch/x86_64/kernel/setup.c linux-2.6.17-rc3.x86_64-pcspkr/arch/x86_64/kernel/setup.c
--- linux-2.6.17-rc3/arch/x86_64/kernel/setup.c	2006-04-28 20:54:10.000000000 +0200
+++ linux-2.6.17-rc3.x86_64-pcspkr/arch/x86_64/kernel/setup.c	2006-04-29 18:42:08.000000000 +0200
@@ -1426,3 +1426,22 @@ struct seq_operations cpuinfo_op = {
 	.show =	show_cpuinfo,
 };
 
+#ifdef CONFIG_INPUT_PCSPKR
+#include <linux/platform_device.h>
+static __init int add_pcspkr(void)
+{
+	struct platform_device *pd;
+	int ret;
+
+	pd = platform_device_alloc("pcspkr", -1);
+	if (!pd)
+		return -ENOMEM;
+
+	ret = platform_device_add(pd);
+	if (ret)
+		platform_device_put(pd);
+
+	return ret;
+}
+device_initcall(add_pcspkr);
+#endif
