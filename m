Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWAEVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWAEVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 16:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbWAEVj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 16:39:59 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:25068 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750967AbWAEVj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 16:39:58 -0500
Date: Thu, 5 Jan 2006 13:39:48 -0800 (PST)
From: hawkes@sgi.com
To: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>, hawkes@sgi.com,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
Message-Id: <20060105213948.11412.45463.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] ia64: change defconfig to NR_CPUS==1024
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the generic ia64 config from its current max of 512 CPUs to a
new max of 1024 CPUs.

The principal file change that implements this is arch/ia64/defconfig,
which currently defines CONFIG_NR_CPUS=512.  The change to
arch/ia64/Kconfig brings that file's declaration of the NR_CPUS default
up to the new reality of 1024.  That Kconfig currently says
    default "64"
which is bogus -- it is currently 512.

The recent change to arch/ia64/configs/sn2_defconfig just raised that
platform-specific defconfig to ==1024.

The rationale for increasing the generic ia64 defconfig to 1024 is that
the generic config needs to support the new upcoming max CPU count for
ia64 platforms, which for ia64/sn ("Altix") platform is 1024, just as
the current max of 512 supports the current max CPU count.

The downside is that the ia64 cpumask increases from 8 words to 16.
I have tried various heavy workloads and have seen no significant
measurable performance regression from this increase.  The potential
extra cachemiss seems to be lost in the noise.  The for_each_*cpu()
macros are relatively efficient in skipping past zeroed cpumask bits.
Workloads that impose higher loads on the CPU Scheduler tend to
bottleneck on non-Scheduler parts of the kernel, and it's the Scheduler
which makes the principal use of the cpumask_t, so these extra
cachemiss inefficiencies and extra CPU cycles to scan zero mask words
just get lost in the general system overhead.

Signed-off-by: John Hawkes <hawkes@sgi.com>
Acked-by: Jack Steiner <steiner@sgi.com>
Acked-by: Greg Edwards <edwardsg@sgi.com>

Index: linux/arch/ia64/Kconfig
===================================================================
--- linux.orig/arch/ia64/Kconfig	2006-01-02 19:21:10.000000000 -0800
+++ linux/arch/ia64/Kconfig	2006-01-04 10:32:50.000000000 -0800
@@ -245,7 +245,7 @@
 	int "Maximum number of CPUs (2-1024)"
 	range 2 1024
 	depends on SMP
-	default "64"
+	default "1024"
 	help
 	  You should set this to the number of CPUs in your system, but
 	  keep in mind that a kernel compiled for, e.g., 2 CPUs will boot but
Index: linux/arch/ia64/defconfig
===================================================================
--- linux.orig/arch/ia64/defconfig	2006-01-02 19:21:10.000000000 -0800
+++ linux/arch/ia64/defconfig	2006-01-04 10:32:50.000000000 -0800
@@ -98,7 +98,7 @@
 # CONFIG_IA64_SGI_SN_XP is not set
 CONFIG_FORCE_MAX_ZONEORDER=18
 CONFIG_SMP=y
-CONFIG_NR_CPUS=512
+CONFIG_NR_CPUS=1024
 CONFIG_HOTPLUG_CPU=y
 # CONFIG_SCHED_SMT is not set
 # CONFIG_PREEMPT is not set
