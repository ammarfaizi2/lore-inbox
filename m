Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbSJZMec>; Sat, 26 Oct 2002 08:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262128AbSJZMec>; Sat, 26 Oct 2002 08:34:32 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6817 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262112AbSJZMea>;
	Sat, 26 Oct 2002 08:34:30 -0400
Date: Sat, 26 Oct 2002 13:42:28 +0100
Message-Id: <200210261242.g9QCgSqp030280@noodles.internal>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
From: davej@codemonkey.org.uk
Subject: [PATCH] Double x86 initialise fix.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For many moons, we've been executing identify_cpu()
on the boot processor twice on SMP kernels.
This is harmless, but has a few downsides..
- Extra cruft in bootlog/dmesg
- Spawns one too many timers for the mcheck handler
- possibly other wasteful things..

This seems to do the right thing here..

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/smpboot.c linux-2.5/arch/i386/kernel/smpboot.c
--- bk-linus/arch/i386/kernel/smpboot.c	2002-10-20 20:21:24.000000000 -0100
+++ linux-2.5/arch/i386/kernel/smpboot.c	2002-10-25 15:39:26.000000000 -0100
@@ -118,7 +118,8 @@ static void __init smp_store_cpu_info(in
 	struct cpuinfo_x86 *c = cpu_data + id;
 
 	*c = boot_cpu_data;
-	identify_cpu(c);
+	if (id!=0)
+		identify_cpu(c);
 	/*
 	 * Mask B, Pentium, but not Pentium MMX
 	 */
