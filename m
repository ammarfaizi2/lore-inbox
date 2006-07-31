Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWGaRgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWGaRgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 13:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbWGaRge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 13:36:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:23055 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030283AbWGaRgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 13:36:33 -0400
X-IronPort-AV: i="4.07,199,1151910000"; 
   d="scan'208"; a="99302126:sNHT19456290"
Message-ID: <44CE3F5E.4010305@intel.com>
Date: Mon, 31 Jul 2006 10:35:26 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       Auke Kok <auke-jan.h.kok@intel.com>, NetDev <netdev@vger.kernel.org>,
       Arjan van de Ven <arjan@linux.intel.com>
Subject: [RFC] irqbalance: Mark in-kernel irqbalance as obsolete, set to N
 by default
Content-Type: multipart/mixed;
 boundary="------------060404080901020204030504"
X-OriginalArrivalTime: 31 Jul 2006 17:36:32.0958 (UTC) FILETIME=[DD383DE0:01C6B4C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060404080901020204030504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


We've recently seen a number of user bug reports against e1000 that the 
in-kernel irqbalance code is detrimental to network latency. The algorithm 
keeps swapping irq's for NICs from cpu to cpu causing extremely high network 
latency (>1000ms). Another NIC driver (cxgb) already has severe warnings in 
their documentation file against using CONFIG_IRQBALANCE, but this is a 
general problem for all NIC drivers and other subsystems. This is especially 
so with cpufreq scaling where the system is slowed down and the migrations 
take much longer.

I suggest that the in-kernel irqbalance is phased out, by marking it OBSOLETE 
first and (perhaps) removing the code later. The userspace irqbalance daemon 
written by Arjan van de Ven does a wonderful job and should be used instead.

Signed-off-by: Auke Kok <auke-jan.h.kok@intel.com>

---

  Kconfig |   15 +++++++++++----
  1 file changed, 11 insertions(+), 4 deletions(-)
---

--------------060404080901020204030504
Content-Type: text/x-patch;
 name="mark_CONFIG_IRQBALANCE_as_obsolete.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mark_CONFIG_IRQBALANCE_as_obsolete.patch"

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index daa75ce..5a40cfe 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -690,12 +690,19 @@ config EFI
 	kernel should continue to boot on existing non-EFI platforms.
 
 config IRQBALANCE
- 	bool "Enable kernel irq balancing"
+	bool "Enable kernel irq balancing (obsolete)"
 	depends on SMP && X86_IO_APIC
-	default y
+	default n
 	help
- 	  The default yes will allow the kernel to do irq load balancing.
-	  Saying no will keep the kernel from doing irq load balancing.
+	  The kernel irq balance will migrate interrupts between cpu's
+	  constantly, which may help reduce load in some cases. It is not
+	  beneficial for latency however, and a user-space daemon is available
+	  that does a much better job.
+
+	  The default no will keep the kernel from doing irq load balancing.
+	  Say yes will allow the kernel to do irq load balancing.
+
+	  If unsure, say N.
 
 # turning this on wastes a bunch of space.
 # Summit needs it only when NUMA is on

--------------060404080901020204030504--
