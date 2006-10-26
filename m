Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423435AbWJZFys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423435AbWJZFys (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 01:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423437AbWJZFys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 01:54:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:23201 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1423435AbWJZFys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 01:54:48 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: i386: Enable NMI watchdog by default does not work as intended
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 26 Oct 2006 15:54:33 +1000
Message-ID: <29986.1161842073@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not work as intended.

commit 1de84979dfc527c422abf63f27beabe43892989b
Author: Andi Kleen <ak@suse.de>
Date:   Tue Sep 26 10:52:27 2006 +0200

    [PATCH] i386: Enable NMI watchdog by default

diff --git a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
index 8e4ed93..6e5085d 100644
--- a/arch/i386/kernel/nmi.c
+++ b/arch/i386/kernel/nmi.c
@@ -21,6 +21,7 @@ #include <linux/nmi.h>
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
 
It attempts to change NMI_DEFAULT to NMI_LOCAL_APIC for recent BIOS
versions, even when the user does _not_ specify nmi_watchdog= on the
command line.  However a few lines further down is this test which
fails because nmi_active is 0.

	if (!atomic_read(&nmi_active))
		return 0;

The calling sequence is setup_local_APIC() -> setup_apic_nmi_watchdog()
-> atomic_inc(nmi_active), but only if nmi_watchdog contains
NMI_LOCAL_APIC or NMI_IO_APIC.  Without a command line option,
setup_apic_nmi_watchdog() does nothing, nmi_active is still 0 and
check_nmi_watchdog() exits early.  Only if you specify nmi_watchdog= on
the command line so nmi_active is non-zero before check_nmi_watchdog()
is called do you get an NMI handler.  IOW, the automatic activation of
the NMI handler is too late.

