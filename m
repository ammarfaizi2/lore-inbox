Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263258AbUDUPzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbUDUPzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263252AbUDUPzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:55:07 -0400
Received: from jericho.provo.novell.com ([137.65.81.173]:53790 "EHLO
	jericho.provo.novell.com") by vger.kernel.org with ESMTP
	id S263258AbUDUPzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 11:55:03 -0400
From: Charles Coffing <ccoffing@novell.com>
Organization: Novell, Inc.
To: linux-kernel@vger.kernel.org
Subject: [PATCH] unbalanced try_get_module/put_module in cpufreq
Date: Wed, 21 Apr 2004 10:47:02 -0600
User-Agent: KMail/1.5.4
Cc: Dominik Brodowski <linux@brodo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404211047.02906.ccoffing@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch is against 2.6.5.  There's a small bug in cpufreq_add_dev:  If kmalloc fails, try_get_module() is not balanced by a module_put().

Thanks,
Charles


diff -pu linux-2.6.5.orig/drivers/cpufreq/cpufreq.c linux-2.6.5/drivers/cpufreq/cpufreq.c
--- linux-2.6.5.orig/drivers/cpufreq/cpufreq.c	2004-04-03 20:36:26.000000000 -0700
+++ linux-2.6.5/drivers/cpufreq/cpufreq.c	2004-04-20 12:38:53.110191544 -0600
@@ -361,7 +361,10 @@ static int cpufreq_add_dev (struct sys_d
 
 	policy = kmalloc(sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!policy)
+	{
+		module_put(cpufreq_driver->owner);
 		return -ENOMEM;
+	}
 	memset(policy, 0, sizeof(struct cpufreq_policy));
 
 	policy->cpu = cpu;

