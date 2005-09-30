Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbVI3WYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbVI3WYM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbVI3WYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:24:11 -0400
Received: from fmr16.intel.com ([192.55.52.70]:38314 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030476AbVI3WYK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:24:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] cpufreq: honor cpu_sibling_map in speedstep-centrino.c
Date: Fri, 30 Sep 2005 15:24:02 -0700
Message-ID: <88056F38E9E48644A0F562A38C64FB6005DED44E@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] cpufreq: honor cpu_sibling_map in speedstep-centrino.c
Thread-Index: AcXFyGwgcH+oGrsIRya267GJgaX4awAREqMQ
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Alexey Dobriyan" <adobriyan@gmail.com>, <linux-kernel@vger.kernel.org>
Cc: "Aaron M. Ucko" <ucko@debian.org>
X-OriginalArrivalTime: 30 Sep 2005 22:24:05.0394 (UTC) FILETIME=[AAE50F20:01C5C60D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org 
>[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
>Alexey Dobriyan
>Sent: Friday, September 30, 2005 7:16 AM
>To: linux-kernel@vger.kernel.org
>Cc: Aaron M. Ucko
>Subject: Fwd: [PATCH] cpufreq: honor cpu_sibling_map in 
>speedstep-centrino.c
>
>To: kernel-janitors@lists.osdl.org
>
>speedstep-centrino.c should honor cpu_sibling_map for the sake of
>recent Intel processors, which support both Centrino-style Enhanced
>SpeedStep and hyperthreading; even newer dual-core chips may need the
>same fix.
>

Just this patch is not enough for Enhanced speedstep processors to use 
Centrino style driver.

- ACPI 3.0 has interfaces that says which all CPUs share a common 
frequency. Using that will help us avoid assumptions in OS about HT 
siblings share a freq or cores share a freq or anything like that.
- OS also should tell BIOS that it understands about multiple CPUs 
Sharing freq. Otherwise BIOS may try to do the coordination across 
the CPUs sharing freq and OS also will try to do something similar 
inside OS. Actually, speedstep-centrino driver will not work on such 
CPUs until BIOS is made aware of this fact.
- All this based on ACPI helps in general to make less assumptions 
about the actual processor itself inside the kernel. It will also 
help the current kernel to work on newer processors without specific 
changes like this.

The patch to support this whole software coordination is here 
http://sourceforge.net/mailarchive/forum.php?forum_id=6102&max_rows=100&
style=threaded&viewmonth=200509&viewday=13

Thanks,
Venki




>--- 
>linux-source-2.6.13.2/arch/i386/kernel/cpu/cpufreq/speedstep-ce
>ntrino.c~	2005-08-28 19:41:01.000000000 -0400
>+++ 
>linux-source-2.6.13.2/arch/i386/kernel/cpu/cpufreq/speedstep-ce
>ntrino.c	2005-09-28 17:23:37.000000000 -0400
>@@ -498,6 +498,10 @@
> 	if (cpu->x86_vendor != X86_VENDOR_INTEL || 
>!cpu_has(cpu, X86_FEATURE_EST))
> 		return -ENODEV;
> 
>+#ifdef CONFIG_SMP
>+	policy->cpus = cpu_sibling_map[policy->cpu];
>+#endif
>+
> 	for (i = 0; i < N_IDS; i++)
> 		if (centrino_verify_cpu_id(cpu, &cpu_ids[i]))
> 			break;
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe 
>linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
