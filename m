Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVJVWOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVJVWOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 18:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVJVWOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 18:14:41 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:49794 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751135AbVJVWOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 18:14:40 -0400
To: gregkh@suse.de, mst@mellanox.co.il
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: AMD 8131 and MSI quirk
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <rolandd@cisco.com>
Date: Sat, 22 Oct 2005 15:14:34 -0700
Message-ID: <524q799p2t.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 22 Oct 2005 22:14:35.0395 (UTC) FILETIME=[FC3C9D30:01C5D755]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current quirk_amd_8131_ioapic() function sets a global
pci_msi_quirk flag, which disables MSI/MSI-X for all devices in the
system.  This is safe but suboptimal, because there may be devices on
other buses not related to the AMD 8131 bridge, for which MSI would
work fine.  As an example, see the end of this email for a lspci -t
from a real Opteron system that has PCI-X buses coming from an AMD
8131 and PCI Express buses coming from an Nforce4 bridge -- MSI works
fine for the Mellanox InfiniBand adapter on the PCIe bus, if we allow
it to be enabled.

I guess what we really should be doing is setting the dev->no_msi flag
for all devices below the AMD 8131 PCI-X bridge rather than turning
off MSI globally.  Of course this is somewhat tricky, since a device
could be hotplugged onto a bus below the AMD 8131.  Greg, any thoughts
about the proper way to use the driver model infrastructure to handle
this?

The other place that pci_msi_quirk is set is quirk_svw_msi().  I don't
know why MSI is turned off for that Serverworks chipset, but perhaps
the same change could be made, and the global pci_msi_quirk flag
killed off entirely.

Thanks,
  Roland

-+-[80]-+-00.0  nVidia Corporation CK804 Memory Controller
 |      +-01.0  nVidia Corporation CK804 Memory Controller
 |      +-0a.0  nVidia Corporation CK804 Ethernet Controller
 |      \-0e.0-[81]----00.0  Mellanox Technologies MT25208 InfiniHost III Ex (Tavor compatibility mode)
 +-[08]-+-0a.0-[09]--
 |      +-0a.1  Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
 |      +-0b.0-[0a]--+-04.0  Intel Corporation 82546EB Gigabit Ethernet Controller (Copper)
 |      |            +-04.1  Intel Corporation 82546EB Gigabit Ethernet Controller (Copper)
 |      |            \-09.0  Chelsio Communications Inc: Unknown device 000b
 |      \-0b.1  Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
 \-[00]-+-00.0  nVidia Corporation CK804 Memory Controller
        +-01.0  nVidia Corporation CK804 ISA Bridge
        +-01.1  nVidia Corporation CK804 SMBus
        +-02.0  nVidia Corporation CK804 USB Controller
        +-02.1  nVidia Corporation CK804 USB Controller
        +-04.0  nVidia Corporation CK804 AC'97 Audio Controller
        +-06.0  nVidia Corporation CK804 IDE
        +-07.0  nVidia Corporation CK804 Serial ATA Controller
        +-08.0  nVidia Corporation CK804 Serial ATA Controller
        +-09.0-[01]----05.0  Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
        +-0a.0  nVidia Corporation CK804 Ethernet Controller
        +-0e.0-[02]--+-00.0  ATI Technologies Inc RV370 5B60 [Radeon X300 (PCIE)]
        |            \-00.1  ATI Technologies Inc: Unknown device 5b70
        +-18.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        +-18.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        +-18.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        +-18.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
        +-19.0  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
        +-19.1  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
        +-19.2  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
        \-19.3  Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
