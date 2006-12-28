Return-Path: <linux-kernel-owner+w=401wt.eu-S1754888AbWL1R0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbWL1R0j (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 12:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbWL1R0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 12:26:39 -0500
Received: from kanga.kvack.org ([66.96.29.28]:48216 "EHLO kanga.kvack.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754888AbWL1R0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 12:26:38 -0500
X-Greylist: delayed 970 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Dec 2006 12:26:38 EST
Date: Thu, 28 Dec 2006 15:03:02 -0200
From: Marcelo Tosatti <marcelo@kvack.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, olpc-devel@laptop.org
Subject: [PATCH] introduce config option to disable DMA zone on i386
Message-ID: <20061228170302.GA4335@dmt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch adds a config option to get rid of the DMA zone on i386.

Architectures with devices that have no addressing limitations (eg. PPC)
already work this way.

This is useful for custom kernel builds where the developer is certain that 
there are no address limitations.

For example, the OLPC machine contains:

- USB devices
- no floppy
- no address limited PCI devices
- no floppy

A unified zone simplifies VM reclaiming work, and also simplifies OOM
killer heuristics (no need to deal with OOM on the DMA zone).

Comments?

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 0d67a0a..8d4dd5e 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -547,6 +547,18 @@ choice
 		bool "1G/3G user/kernel split"
 endchoice
 
+config NO_DMA_ZONE
+	bool "DMA zone support"
+	default n
+	help
+	 This disables support for the 16MiB DMA zone. Only enable this 
+	 option if you are certain that your devices contain no DMA
+	 addressing limitations. A few of them which do: 
+	 	- floppy
+	 	- ISA devices
+	 	- some PCI devices (soundcards, etc)
+
+
 config PAGE_OFFSET
 	hex
 	default 0xB0000000 if VMSPLIT_3G_OPT
diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 79df6e6..3078019 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -371,9 +371,13 @@ void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES];
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
+#ifndef CONFIG_NO_DMA_ZONE
 	max_zone_pfns[ZONE_DMA] =
 		virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+#else
+	max_zone_pfns[ZONE_DMA] = max_low_pfn;
+#endif
 #ifdef CONFIG_HIGHMEM
 	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
 	add_active_range(0, 0, highend_pfn);

