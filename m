Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVFHPzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFHPzT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 11:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVFHPyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 11:54:08 -0400
Received: from webmail.topspin.com ([12.162.17.3]:25947 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261331AbVFHPw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 11:52:27 -0400
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>, Greg KH <gregkh@suse.de>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
X-Message-Flag: Warning: May contain useful information
References: <20050607002045.GA12849@suse.de>
	<20050607202129.GB18039@kroah.com>
	<20050608050212.GD21060@colo.lackof.org>
	<20050608133226.GR23831@wotan.suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 08 Jun 2005 08:52:26 -0700
In-Reply-To: <20050608133226.GR23831@wotan.suse.de> (Andi Kleen's message of
 "Wed, 8 Jun 2005 15:32:26 +0200")
Message-ID: <52oeagethh.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 08 Jun 2005 15:52:26.0644 (UTC) FILETIME=[1174DD40:01C56C42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> x86-64 will eventually too, I definitely plan for it at some
    Andi> point.  We need it for very big machines where 255 interrupt
    Andi> vectors are not enough. And as you say with MSI-X it becomes
    Andi> even more important.

MSI-X already works fine on x86-64.  For example, on the machine I'm
sending this from, an Athlon64 system with Nforce 4 (and yes I am
using IP-over-InfiniBand as the only network connection on my workstation):

    $ arch
    x86_64

    $ cat /proc/interrupts 
               CPU0       
      0: 1340159746    IO-APIC-edge  timer
      7:          2    IO-APIC-edge  parport0
      8:          0    IO-APIC-edge  rtc
      9:          0   IO-APIC-level  acpi
     15:   13333990    IO-APIC-edge  ide1
     50:          3       PCI-MSI-X  ib_mthca (async)
     58:     480844       PCI-MSI-X  ib_mthca (cmd)
    177:    7975072   IO-APIC-level  libata, NVidia CK804
    185:    2093654   IO-APIC-level  libata
    193:   14304257   IO-APIC-level  nvidia
    201:     769996   IO-APIC-level  ohci_hcd
    209:          2   IO-APIC-level  ehci_hcd
    217:          3   IO-APIC-level  ohci1394
    233:   37917879       PCI-MSI-X  ib_mthca (comp)
    NMI:     148617 
    LOC: 1340049308 
    ERR:          0
    MIS:          0

    $ lspci
    0000:00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
    0000:00:01.0 ISA bridge: nVidia Corporation: Unknown device 0050 (rev a3)
    0000:00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
    0000:00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)
    0000:00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)
    0000:00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio Controller (rev a2)
    0000:00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
    0000:00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)
    0000:00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)
    0000:00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2)
    0000:00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
    0000:00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
    0000:00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
    0000:00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
    0000:00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
    0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
    0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
    0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
    0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
    0000:01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0140 (rev a2)
    0000:03:00.0 InfiniBand: Mellanox Technologies MT25208 InfiniHost III Ex (rev a0)
    0000:05:0b.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link)
    0000:05:0c.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Ethernet Controller (rev 13)

    $ cat /proc/cpuinfo 
    processor	: 0
    vendor_id	: AuthenticAMD
    cpu family	: 15
    model		: 31
    model name	: AMD Athlon(tm) 64 Processor 3500+
    stepping	: 0
    cpu MHz		: 1005.169
    cache size	: 512 KB
    fpu		: yes
    fpu_exception	: yes
    cpuid level	: 1
    wp		: yes
    flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 pni syscall nx mmxext fxsr_opt lm 3dnowext 3dnow lahf_lm
    bogomips	: 1988.42
    TLB size	: 1088 4K pages
    clflush size	: 64
    cache_alignment	: 64
    address sizes	: 40 bits physical, 48 bits virtual
    power management: ts fid vid ttp

