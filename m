Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWHJUO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWHJUO2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbWHJTgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:05 -0400
Received: from mx1.suse.de ([195.135.220.2]:17040 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932348AbWHJTfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:35:37 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [23/145] i386: Enable NMI watchdog by default
Message-Id: <20060810193536.52EFC13B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:35:36 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

I've had good experiences with having this on by default on x86-64.
It turns nasty hangs into easier to debug oopses.

Enable the local APIC wdog by default for systems newer than 2004.

This comes from a strange compromise: according to arjan the reason
it was off by default was some old IBM systems that corrupted
registered when NMI happened in SMI. Can't remember more specific,
but >= 2004 should avoid these. It's probably overly broad
because most older systems should be ok (and the really old systems
won't be supported by the local apic watchdog anyways) 

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/nmi.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c
+++ linux/arch/i386/kernel/nmi.c
@@ -21,6 +21,7 @@
 #include <linux/sysdev.h>
 #include <linux/sysctl.h>
 #include <linux/percpu.h>
+#include <linux/dmi.h>
 
 #include <asm/smp.h>
 #include <asm/nmi.h>
@@ -204,6 +205,14 @@ static int __init check_nmi_watchdog(voi
 	unsigned int *prev_nmi_count;
 	int cpu;
 
+	/* Enable NMI watchdog for newer systems.
+           Actually it should be safe for most systems before 2004 too except
+	   for some IBM systems that corrupt registers when NMI happens
+	   during SMM. Unfortunately we don't have more exact information
+ 	   on these and use this coarse check. */
+	if (nmi_watchdog == NMI_DEFAULT && dmi_get_year(DMI_BIOS_DATE) >= 2004)
+		nmi_watchdog = NMI_LOCAL_APIC;
+
 	if ((nmi_watchdog == NMI_NONE) || (nmi_watchdog == NMI_DEFAULT))
 		return 0;
 
