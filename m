Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264313AbUEMRTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUEMRTW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 13:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUEMRTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 13:19:22 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:42250
	"EHLO muru.com") by vger.kernel.org with ESMTP id S264313AbUEMRTT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 13:19:19 -0400
Date: Thu, 13 May 2004 10:19:21 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH] Powernow-k8 buggy BIOS override for 2.6.6
Message-ID: <20040513171921.GB28678@atomide.com>
References: <20040512235623.GA9234@atomide.com> <20040513162643.GA4506@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20040513162643.GA4506@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Pavel Machek <pavel@ucw.cz> [040513 09:26]:
> Hi!
> 
> > Following is the updated patch to make the powernow-k8 driver work on 
> > machines with buggy BIOS, such as emachines m6805.
> > 
> > The patch overrides the PST table only if check_pst_table() fails.
> > 
> > The minimum value for the override is 800MHz, which is the lowest value 
> > on all x86_64 systems AFAIK. The max value is the current running value.
> > 
> > This patch should be safe to apply, even if Pavel's ACPI table check is
> > added to the driver. Or does anybody see a problem with it?
> 
> Well, there may be problems with that.

That works good now, see my recent posting to the thread on the cpufreq list
for more details. I had ACPI processor as module, and that made the
powernow-k8 ACPI detection to fail. I fixed it with the following little
patch, attaching it here too for reference.

> BIOSen sometimes run cpu at too high voltage. Plus, for changing
> frequency you need to run at even higher voltage... and that may be
> too high.
> 
> Is there some problem with ACPI on your system?

Works now, from cpufreq point of view. As of 2.6.6 the ACPI processor 
module hangs the system if compiled in. Loading it as module after init 
does not hang.

Regards,

Tony


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="patch-2.6.6-powernow-acpi-module"

diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Thu May 13 09:58:24 2004
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	Thu May 13 09:58:24 2004
@@ -32,7 +32,7 @@
 #include <asm/io.h>
 #include <asm/delay.h>
 
-#ifdef CONFIG_ACPI_PROCESSOR
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 #endif
@@ -666,7 +696,7 @@
 	return -ENODEV;
 }
 
-#ifdef CONFIG_ACPI_PROCESSOR
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 static void powernow_k8_acpi_pst_values(struct powernow_k8_data *data, unsigned int index)
 {
 	if (!data->acpi_data.state_count)
diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.h b/arch/i386/kernel/cpu/cpufreq/powernow-k8.h
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	Thu May 13 09:58:24 2004
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	Thu May 13 09:58:24 2004
@@ -29,7 +29,7 @@
 	 * frequency is in kHz */
 	struct cpufreq_frequency_table  *powernow_table;
 
-#ifdef CONFIG_ACPI_PROCESSOR
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 	/* the acpi table needs to be kept. it's only available if ACPI was
 	 * used to determine valid frequency/vid/fid states */
 	struct acpi_processor_performance acpi_data;

--dTy3Mrz/UPE2dbVg--
