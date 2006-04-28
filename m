Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751458AbWD1Wjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWD1Wjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 18:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWD1Wjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 18:39:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:26847 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751458AbWD1Wjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 18:39:40 -0400
Date: Fri, 28 Apr 2006 17:39:38 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: powerpc/pseries: Increment fail counter in PCI recovery
Message-ID: <20060428223938.GD22621@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

A small medium-priority patch; please send upstream as appropriate.

--linas

[PATCH]: powerpc/pseries: Increment fail counter in PCI recovery

When a PCI device driver does not support PCI error recovery,
the powerpc/pseries code takes a walk through a branch of code 
that resets the failure counter. Because of this, if a broken
PCI card is present, the kernel will attempt to reset it an
infinite number of times. (This is annoying but mostly harmless:
each reset takes about 10-20 seconds, and uses almost no CPU time).

This patch preserves the failure count across resets.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh_driver.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.17-rc1.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-28 17:30:21.000000000 -0500
+++ linux-2.6.17-rc1/arch/powerpc/platforms/pseries/eeh_driver.c	2006-04-28 17:31:31.000000000 -0500
@@ -201,7 +201,11 @@ static void eeh_report_failure(struct pc
 
 static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 {
-	int rc;
+	int cnt, rc;
+
+	/* pcibios will clear the counter; save the value */
+	cnt = pe_dn->eeh_freeze_count;
+
 	if (bus)
 		pcibios_remove_pci_devices(bus);
 
@@ -240,6 +244,7 @@ static int eeh_reset_device (struct pci_
 		ssleep (5);
 		pcibios_add_pci_devices(bus);
 	}
+	pe_dn->eeh_freeze_count = cnt;
 
 	return 0;
 }
