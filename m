Return-Path: <linux-kernel-owner+w=401wt.eu-S965161AbXAJXfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbXAJXfX (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 18:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbXAJXfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 18:35:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:44737 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975AbXAJXfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 18:35:22 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,169,1167638400"; 
   d="scan'208"; a="34994437:sNHT20075337"
Date: Wed, 10 Jan 2007 15:05:10 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, dzickus@redhat.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert nmi_known_cpu() check during boot option parsing
Message-ID: <20070110150510.A28311@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=f2802e7f571c05f9a901b1f5bd144aa730ccc88e
and another subsequent patch adds nmi_known_cpu() check while parsing boot
options in x86_64 and i386. With that, "nmi_watchdog=2" stops working for me
on Intel Core 2 CPU based system.

The problem is, setup_nmi_watchdog is called while parsing the boot option
and identify_cpu is not done yet. So, the return value of nmi_known_cpu()
is not valid at this point.

Revert that check. Should not have any adverse effect as nmi_known_cpu() check
is done again later in enable_lapic_nmi_watchdog().

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.20-rc-mm/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.20-rc-mm.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.20-rc-mm/arch/i386/kernel/nmi.c
@@ -325,13 +325,7 @@ static int __init setup_nmi_watchdog(cha
 
 	if ((nmi >= NMI_INVALID) || (nmi < NMI_NONE))
 		return 0;
-	/*
-	 * If any other x86 CPU has a local APIC, then
-	 * please test the NMI stuff there and send me the
-	 * missing bits. Right now Intel P6/P4 and AMD K7 only.
-	 */
-	if ((nmi == NMI_LOCAL_APIC) && (nmi_known_cpu() == 0))
-		return 0;  /* no lapic support */
+
 	nmi_watchdog = nmi;
 	return 1;
 }
Index: linux-2.6.20-rc-mm/arch/x86_64/kernel/nmi.c
===================================================================
--- linux-2.6.20-rc-mm.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.20-rc-mm/arch/x86_64/kernel/nmi.c
@@ -310,8 +310,6 @@ int __init setup_nmi_watchdog(char *str)
 	if ((nmi >= NMI_INVALID) || (nmi < NMI_NONE))
 		return 0;
 
-	if ((nmi == NMI_LOCAL_APIC) && (nmi_known_cpu() == 0))
-		return 0;  /* no lapic support */
 	nmi_watchdog = nmi;
 	return 1;
 }
