Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUHTVpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUHTVpT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 17:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268766AbUHTVpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 17:45:19 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:31250 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268765AbUHTVoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 17:44:55 -0400
To: cramerj@intel.com, john.ronciak@intel.com, ganesh.venkatesan@intel.com,
       tom.l.nguyen@intel.com
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [broken?] Add MSI support to e1000
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Fri, 20 Aug 2004 14:37:49 -0700
Message-ID: <52k6vttrrm.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 20 Aug 2004 21:37:49.0175 (UTC) FILETIME=[F06D2870:01C486FD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently tried to add MSI support to the e1000 driver, since on my
box, several interrupts seem to be wired together with the e1000:

     18:    1028608   IO-APIC-level  uhci_hcd, libata, eth0

I came up with the patch at the end of this email.

However, on my Dell box with 865 chipset (lspci below), loading e1000
(from kernel 2.6.8.1 with this patch applied) with MSI=1 only works
for a short time (maybe ~1000 e1000 interrupts) before network traffic
stops.  I often get the following as well:

    CPU 0: Machine Check Exception: 0000000000000000
    CPU 0: EIP: 00000000 EFLAGS: 00000000
            eax: 00000000 ebx: 00000000 ecx: 00000000 edx: 00000000
            esi: 00000000 edi: 00000000 ebp: 00000000 esp: 00000000

I also tried the same patch on a dual 3.4 GHz Xeon system with
Lindenhurst chipset with the same results.

Is there something wrong with the patch?  Something wrong with the
kernel MSI support?  Something wrong with the hardware?

I'm glad to provide any further information required to debug this.

Thanks,
  Roland

Here's the lspci output:

    0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM Controller/Host-Hub Interface (rev 02)
    0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller (rev 02)
    0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 02)
    0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 02)
    0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 02)
    0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 02)
    0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI Controller (rev 02)
    0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
    0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
    0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 Storage Controller (rev 02)
    0000:00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage Controller (rev 02)
    0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
    0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
    0000:01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1)
    0000:02:0c.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)

Here's the patch I tried:

Index: linux-2.6.8.1/drivers/net/e1000/e1000.h
===================================================================
--- linux-2.6.8.1.orig/drivers/net/e1000/e1000.h	2004-08-14 03:54:47.000000000 -0700
+++ linux-2.6.8.1/drivers/net/e1000/e1000.h	2004-08-20 13:10:55.000000000 -0700
@@ -251,8 +251,10 @@
 	struct e1000_desc_ring test_tx_ring;
 	struct e1000_desc_ring test_rx_ring;
 
-
 	uint32_t pci_state[16];
 	int msg_enable;
+
+	int use_msi;
+	int msi_enabled;
 };
 #endif /* _E1000_H_ */
Index: linux-2.6.8.1/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.8.1.orig/drivers/net/e1000/e1000_main.c	2004-08-14 03:55:10.000000000 -0700
+++ linux-2.6.8.1/drivers/net/e1000/e1000_main.c	2004-08-20 13:22:28.000000000 -0700
@@ -541,6 +541,10 @@
 	DPRINTK(PROBE, INFO, "Intel(R) PRO/1000 Network Connection\n");
 	e1000_check_options(adapter);
 
+	/* Message Signaled Interrupts */
+	if (adapter->use_msi && !pci_enable_msi(pdev))
+		adapter->msi_enabled = 1;
+
 	/* Initial Wake on LAN setting
 	 * If APM wake is enabled in the EEPROM,
 	 * enable the ACPI Magic Packet filter
@@ -624,6 +628,8 @@
 	e1000_phy_hw_reset(&adapter->hw);
 
 	iounmap(adapter->hw.hw_addr);
+	if (adapter->msi_enabled)
+		pci_disable_msi(pdev);
 	pci_release_regions(pdev);
 
 	free_netdev(netdev);
Index: linux-2.6.8.1/drivers/net/e1000/e1000_param.c
===================================================================
--- linux-2.6.8.1.orig/drivers/net/e1000/e1000_param.c	2004-08-20 13:06:34.000000000 -0700
+++ linux-2.6.8.1/drivers/net/e1000/e1000_param.c	2004-08-20 13:32:22.000000000 -0700
@@ -194,6 +194,15 @@
 
 E1000_PARAM(InterruptThrottleRate, "Interrupt Throttling Rate");
 
+/* Message Signaled Interrupts
+ *
+ * Valid Range: 0-1 (0=off, 1=on)
+ *
+ * Default Value: 0
+ */
+
+E1000_PARAM(MSI, "Message Signaled Interrupts");
+
 #define AUTONEG_ADV_DEFAULT  0x2F
 #define AUTONEG_ADV_MASK     0x2F
 #define FLOW_CONTROL_DEFAULT FLOW_CONTROL_FULL
@@ -459,6 +468,18 @@
 			break;
 		}
 	}
+	{ /* Message Signaled Interrupts */
+		struct e1000_option opt = {
+			.type = enable_option,
+			.name = "Message Signaled Interrupts",
+			.err  = "defaulting to Disabled",
+			.def  = OPTION_DISABLED
+		};
+
+		int use_msi = MSI[bd];
+		e1000_validate_option(&use_msi, &opt, adapter);
+		adapter->use_msi = use_msi;
+	}
 
 	switch(adapter->hw.media_type) {
 	case e1000_media_type_fiber:
