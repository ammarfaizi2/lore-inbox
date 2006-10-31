Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423795AbWJaTCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423795AbWJaTCy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423799AbWJaTCx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:02:53 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:52285 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1423795AbWJaTCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:02:52 -0500
To: linux-kernel@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, matthew@wil.cx, jeff@garzik.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       openib-general@openib.org, johnip@sgi.com
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <20061024214724.GS25210@parisc-linux.org>
	<adar6wxbcwt.fsf@cisco.com> <20061024223631.GT25210@parisc-linux.org>
	<20061024.154347.77057163.davem@davemloft.net>
	<aday7r4a3d7.fsf@cisco.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 31 Oct 2006 11:02:49 -0800
In-Reply-To: <aday7r4a3d7.fsf@cisco.com> (Roland Dreier's message of "Wed, 25 Oct 2006 07:15:16 -0700")
Message-ID: <adad588tijq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 31 Oct 2006 19:02:50.0533 (UTC) FILETIME=[294C7D50:01C6FD1F]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The discussion fizzled out without really reaching a definitive
answer, so I'm going to apply the original patch (below), since I
pretty much convinced myself that only the driver doing the config
access has enough information to fix this reliably.

 - R.

Author: John Partridge <johnip@sgi.com>
Date:   Tue Oct 31 11:00:04 2006 -0800

    IB/mthca: Make sure all PCI config writes reach device before doing MMIO
    
    During initialization, mthca writes some PCI config space registers
    and then does an MMIO read from one of the BARs it just enabled.  This
    MMIO read sometimes failed and caused a crash on SGI Altix machines,
    because the PCI-X host bridge (legitimately, according to the PCI
    spec) allowed the MMIO read to start before the config write completed.
    
    To fix this, add a config read after all config writes to make sure
    they are all done before starting the MMIO read.
    
    Signed-off-by: John Partridge <johnip@sgi.com>
    Signed-off-by: Roland Dreier <rolandd@cisco.com>

diff --git a/drivers/infiniband/hw/mthca/mthca_reset.c b/drivers/infiniband/hw/mthca/mthca_reset.c
index 91934f2..578dc7c 100644
--- a/drivers/infiniband/hw/mthca/mthca_reset.c
+++ b/drivers/infiniband/hw/mthca/mthca_reset.c
@@ -281,6 +281,20 @@ good:
 		goto out;
 	}
 
+	/*
+	 * Perform a "flush" of the PCI config writes here by reading
+	 * the PCI_COMMAND register.  This is needed to make sure that
+	 * we don't try to touch other PCI BARs before the config
+	 * writes are done -- otherwise an MMIO cycle could start
+	 * before the config writes are done and reach the HCA before
+	 * the BAR is actually enabled.
+	 */
+	if (pci_read_config_dword(mdev->pdev, PCI_COMMAND, hca_header)) {
+		err = -ENODEV;
+		mthca_err(mdev, "Couldn't access HCA memory after restoring, "
+			  "aborting.\n");
+	}
+
 out:
 	if (bridge)
 		pci_dev_put(bridge);
