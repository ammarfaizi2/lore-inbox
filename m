Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932445AbWHTCUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWHTCUI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 22:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWHTCUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 22:20:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20656 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932445AbWHTCUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 22:20:06 -0400
Date: Sat, 19 Aug 2006 22:19:35 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>, greg@kroah.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [CPUFREQ] acpi-cpufreq: Ignore failure from acpi_cpufreq_early_init_acpi
Message-ID: <20060820021935.GA21026@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, greg@kroah.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore the return value of early_init_acpi(), as it can give false error
messages. If there is something really wrong, then register_driver will fail
cleanly with EINVAL later.

[ background: modprobe acpi-cpufreq on systems not capable of speed-scaling
  started failing with 'invalid argument', where previously it would only
  ever -ENODEV

  I'm not 100% happy with the solution. It'd be better to handle
  failure properly, but this is a low-impact change for 2.6.18
  We can always revisit doing this better in .19   --davej.]

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Dave Jones <davej@redhat.com>

Index: linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -567,16 +567,11 @@ static struct cpufreq_driver acpi_cpufre
 static int __init
 acpi_cpufreq_init (void)
 {
-	int                     result = 0;
-
 	dprintk("acpi_cpufreq_init\n");
 
-	result = acpi_cpufreq_early_init_acpi();
+	acpi_cpufreq_early_init_acpi();
 
-	if (!result)
- 		result = cpufreq_register_driver(&acpi_cpufreq_driver);
-	
-	return (result);
+ 	return cpufreq_register_driver(&acpi_cpufreq_driver);
 }
 
-- 
http://www.codemonkey.org.uk
