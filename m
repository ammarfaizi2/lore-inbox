Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755334AbWKNBhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755334AbWKNBhq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 20:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbWKNBhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 20:37:46 -0500
Received: from mga05.intel.com ([192.55.52.89]:60178 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1755334AbWKNBhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 20:37:45 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,419,1157353200"; 
   d="scan'208"; a="163234336:sNHT28569716"
Subject: [PATCH] Use platform_device_add instead of
	platform_device_register to register device allocated dynamically
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1163468296.4311.21.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 14 Nov 2006 09:38:16 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got below warning when running 2.6.19-rc5-mm1 on my ia64 machine.

WARNING at lib/kobject.c:172 kobject_init()

Call Trace:
 [<a0000001000137c0>] show_stack+0x40/0xa0
                                sp=e0000002ff9f7bc0 bsp=e0000002ff9f0d10
 [<a000000100013850>] dump_stack+0x30/0x60
                                sp=e0000002ff9f7d90 bsp=e0000002ff9f0cf8
 [<a000000100407bb0>] kobject_init+0x90/0x160
                                sp=e0000002ff9f7d90 bsp=e0000002ff9f0cd0
 [<a0000001005ae080>] device_initialize+0x40/0x1c0
                                sp=e0000002ff9f7da0 bsp=e0000002ff9f0cb0
 [<a0000001005b88c0>] platform_device_register+0x20/0x60
                                sp=e0000002ff9f7dd0 bsp=e0000002ff9f0c90
 [<a000000100592560>] try_smi_init+0xbc0/0x11e0
                                sp=e0000002ff9f7dd0 bsp=e0000002ff9f0c50
 [<a000000100594900>] init_ipmi_si+0xaa0/0x12e0
                                sp=e0000002ff9f7de0 bsp=e0000002ff9f0bd8
 [<a000000100009910>] init+0x350/0x780
                                sp=e0000002ff9f7e00 bsp=e0000002ff9f0ba8
 [<a000000100011d30>] kernel_thread_helper+0x30/0x60
                                sp=e0000002ff9f7e30 bsp=e0000002ff9f0b80
 [<a0000001000090c0>] start_kernel_thread+0x20/0x40
                                sp=e0000002ff9f7e30 bsp=e0000002ff9f0b80
WARNING at lib/kobject.c:172 kobject_init()

Call Trace:
 [<a0000001000137c0>] show_stack+0x40/0xa0
                                sp=e0000002ff9f7b40 bsp=e0000002ff9f0db0
 [<a000000100013850>] dump_stack+0x30/0x60
                                sp=e0000002ff9f7d10 bsp=e0000002ff9f0d98
 [<a000000100407bb0>] kobject_init+0x90/0x160
                                sp=e0000002ff9f7d10 bsp=e0000002ff9f0d70
 [<a0000001005ae080>] device_initialize+0x40/0x1c0
                                sp=e0000002ff9f7d20 bsp=e0000002ff9f0d50
 [<a0000001005b88c0>] platform_device_register+0x20/0x60
                                sp=e0000002ff9f7d50 bsp=e0000002ff9f0d30
 [<a00000010058ac00>] ipmi_register_smi+0xcc0/0x18e0
                                sp=e0000002ff9f7d50 bsp=e0000002ff9f0c90
 [<a000000100592600>] try_smi_init+0xc60/0x11e0
                                sp=e0000002ff9f7dd0 bsp=e0000002ff9f0c50
 [<a000000100594900>] init_ipmi_si+0xaa0/0x12e0
                                sp=e0000002ff9f7de0 bsp=e0000002ff9f0bd8
 [<a000000100009910>] init+0x350/0x780
                                sp=e0000002ff9f7e00 bsp=e0000002ff9f0ba8
 [<a000000100011d30>] kernel_thread_helper+0x30/0x60
                                sp=e0000002ff9f7e30 bsp=e0000002ff9f0b80
 [<a0000001000090c0>] start_kernel_thread+0x20/0x40
                                sp=e0000002ff9f7e30 bsp=e0000002ff9f0b80


The root cause is the device struct is initialized twice.

If the device is allocated dynamically by platform_device_alloc,
platform_device_alloc will initialize struct device, then,
platform_device_add should be used to register the device.

The difference between platform_device_register and platform_device_add
is platform_device_register will initiate the device while platform_device_add
won't.

Below patch against 2.6.19-rc5-mm1 fixes it.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

--- linux-2.6.19-rc5-mm1/drivers/char/ipmi/ipmi_si_intf.c	2006-11-13 16:35:50.000000000 +0800
+++ linux-2.6.19-rc5-mm1_fix/drivers/char/ipmi/ipmi_si_intf.c	2006-11-13 16:58:48.000000000 +0800
@@ -2346,7 +2346,7 @@ static int try_smi_init(struct smi_info 
 		new_smi->dev = &new_smi->pdev->dev;
 		new_smi->dev->driver = &ipmi_driver;
 
-		rv = platform_device_register(new_smi->pdev);
+		rv = platform_device_add(new_smi->pdev);
 		if (rv) {
 			printk(KERN_ERR
 			       "ipmi_si_intf:"
--- linux-2.6.19-rc5-mm1/drivers/char/ipmi/ipmi_msghandler.c	2006-11-13 16:35:50.000000000 +0800
+++ linux-2.6.19-rc5-mm1_fix/drivers/char/ipmi/ipmi_msghandler.c	2006-11-13 17:18:05.000000000 +0800
@@ -2108,7 +2108,7 @@ static int ipmi_bmc_register(ipmi_smi_t 
 		dev_set_drvdata(&bmc->dev->dev, bmc);
 		kref_init(&bmc->refcount);
 
-		rv = platform_device_register(bmc->dev);
+		rv = platform_device_add(bmc->dev);
 		mutex_unlock(&ipmidriver_mutex);
 		if (rv) {
 			printk(KERN_ERR
