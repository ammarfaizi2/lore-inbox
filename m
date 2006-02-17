Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751710AbWBQUYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbWBQUYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbWBQUYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:24:05 -0500
Received: from usbb-lacimss3.unisys.com ([192.63.108.53]:31500 "EHLO
	usbb-lacimss3.unisys.com") by vger.kernel.org with ESMTP
	id S1751708AbWBQUYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:24:04 -0500
Subject: [patch] i386 need to pass virtual address to smp_read_mpc()
From: Daniel Yeisley <dan.yeisley@unisys.com>
Reply-To: dan.yeisley@unisys.com
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
Content-Type: text/plain
Date: Fri, 17 Feb 2006 15:24:40 -0500
Message-Id: <1140207880.2910.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 20:23:47.0559 (UTC) FILETIME=[0E8FD770:01C63400]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a kernel panic on an ES7000-600 when booting in virtual wire
mode.  The panic happens because smp_read_mpc() is passed a physical
address, and it should be virtual.  I tested the attached patch on the
ES7000-600 and on a 2 cpu Dell box, and saw no problems on either.

Signed-off-by:  Dan Yeisley <dan.yeisley@unisys.com>
---

diff -Naur -p linux-2.6.16-rc1-git3-7/arch/i386/kernel/mpparse.c linux-2.6.16-rc1-git3-7-a/arch/i386/kernel/mpparse.c
--- linux-2.6.16-rc1-git3-7/arch/i386/kernel/mpparse.c  2006-01-30 18:38:18.000000000 -0500
+++ linux-2.6.16-rc1-git3-7-a/arch/i386/kernel/mpparse.c        2006-02-16 04:51:35.551014272 -0500
@@ -710,7 +710,7 @@ void __init get_smp_config (void)
                 * Read the physical hardware table.  Anything here will
                 * override the defaults.
                 */
-               if (!smp_read_mpc((void *)mpf->mpf_physptr)) {
+               if (!smp_read_mpc(phys_to_virt(mpf->mpf_physptr)))
                        smp_found_config = 0;
                        printk(KERN_ERR "BIOS bug, MP table errors detected!...\n");
                        printk(KERN_ERR "... disabling SMP support. (tell your hw vendor)\n");


