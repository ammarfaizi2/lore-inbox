Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVHVT4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVHVT4F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVHVT4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:56:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:13018 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750774AbVHVT4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:56:04 -0400
Date: Mon, 22 Aug 2005 14:30:06 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: suspicious behaviour in pcwd driver.
Message-ID: <20050822183006.GB27344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/watchdog/pcwd.c does this if it detects
a temperature out of range..

            if (temp_panic) {
                printk (KERN_INFO PFX "Temperature overheat trip!\n");
                machine_power_off();
            }

Two problems here are..

1. machine_power_off() isn't exported on ppc64. (patch below)
2. that printk will never hit the logs, so the admin will just find
a powered off box with no idea what happened.
Should we at least sync block devices before doing the power off ?

		Dave



Export machine_power_off() on ppc64, as the pcwd watchdog driver needs it.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.12/arch/ppc64/kernel/setup.c~	2005-08-09 17:37:36.000000000 -0400
+++ linux-2.6.12/arch/ppc64/kernel/setup.c	2005-08-09 17:37:53.000000000 -0400
@@ -706,6 +706,7 @@ void machine_power_off(void)
 	local_irq_disable();
 	while (1) ;
 }
+EXPORT_SYMBOL(machine_power_off);
 
 void machine_halt(void)
 {


