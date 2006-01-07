Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932288AbWAGEZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbWAGEZy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 23:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWAGEZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 23:25:54 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:36742 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S932288AbWAGEZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 23:25:53 -0500
Date: Sat, 7 Jan 2006 05:25:47 +0100
From: Petr Vandrovec <petr@vmware.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Pass proper device from BusLogic to SCSI layer
Message-ID: <20060107042547.GA4255@vana.vc.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
  
While trying to get SUSE's SLES9 working on system with more than 4GB
we've noticed that SCSI layer happilly passes addresses over 4GB to
the buslogic driver, which is quite a big problem as buslogic can
generate only 32bit busmastering cycles.

Fortunately in the current kernels this problem does not exist anymore
as SCSI layer now assumes 4GB capable device by default, but it is
still good idea to pass correct device structure to the SCSI layer.
If nothing else, /sys/block/sda/device now points to
/sys/devices/pci0000:00/0000:00:10.0/host0/... instead of
/sys/devices/platform/host0/... like it did in the past.

Change does nothing for ISA based BusLogic adapters, they'll still
end under platform (and they are probably broken for long time as
I do not see anything forcing ISA 16MB limit for them).

					Thanks,
						Petr Vandrovec


diff -urdN linux/drivers/scsi/BusLogic.c linux/drivers/scsi/BusLogic.c
--- linux/drivers/scsi/BusLogic.c	2006-01-01 16:22:50.000000000 +0100
+++ linux/drivers/scsi/BusLogic.c	2006-01-01 16:34:43.000000000 +0100
@@ -2216,6 +2216,7 @@
 		HostAdapter->PCI_Address = ProbeInfo->PCI_Address;
 		HostAdapter->Bus = ProbeInfo->Bus;
 		HostAdapter->Device = ProbeInfo->Device;
+		HostAdapter->PCI_Device = ProbeInfo->PCI_Device;
 		HostAdapter->IRQ_Channel = ProbeInfo->IRQ_Channel;
 		HostAdapter->AddressCount = BusLogic_HostAdapterAddressCount[HostAdapter->HostAdapterType];
 		/*
@@ -2296,7 +2297,7 @@
 				scsi_host_put(Host);
 			} else {
 				BusLogic_InitializeHostStructure(HostAdapter, Host);
-				scsi_add_host(Host, NULL);
+				scsi_add_host(Host, HostAdapter->PCI_Device ? &HostAdapter->PCI_Device->dev : NULL);
 				scsi_scan_host(Host);
 				BusLogicHostAdapterCount++;
 			}
