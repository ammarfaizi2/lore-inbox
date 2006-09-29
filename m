Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422823AbWI2VlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422823AbWI2VlQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWI2VlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:41:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46281 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964851AbWI2VlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:41:14 -0400
Date: Fri, 29 Sep 2006 14:41:10 -0700
From: Bryce Harrington <bryce@osdl.org>
To: "Moore, Eric" <Eric.Moore@lsil.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [OOPS] -git8,9:  NULL pointer dereference in mptspi_dv_renegotiate_work
Message-ID: <20060929214110.GH12968@osdl.org>
References: <664A4EBB07F29743873A87CF62C26D7035039A@NAMAIL4.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <664A4EBB07F29743873A87CF62C26D7035039A@NAMAIL4.ad.lsil.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 12:29:55PM -0600, Moore, Eric wrote:
> On Friday, September 29, 2006 11:18 AM, Bryce Harrington wrote:  
> 
> > [<ffffffff80484f94>] mpt_HardResetHandler+0xb4/0x12c
> > [<ffffffff8048500c>] mpt_timer_expired+0x0/0x24
> 
> mpt_timer_expired means most likely we timed out sending 
> request for config page from firmware.  The timeout results
> in host reset, which results in domain validation being called.
> Perhaps the config pages failed before we allocated memory for hd.
> 
> Can you enable debug messages in the driver Makefile, for
> the line called MPT_DEBUG_CONFIG; that way we can find out which
> config page failed.  

Sure; not sure what the interesting part is, but here's the full log
from this:

   http://crucible.osdl.org/runs/2265/sysinfo/amd01.2.console

> There were some changes in scsi_transort_spi.c, that occured
> between 2.6.18-git1 and 2.6.18-git2.  I doubt these changes
> would of effected this.   Can you determine between which
> git version releases did this problem begin occuring?

I found that the problem did not occur with -git7, but did occur with
-git8, 9, 10, 11, and 12.  I didn't check kernels prior to that but
could if you think it would help.
 
> Also, can you describe your configuration?  Such as which
> kind of devices are you usign, and whether if they are U320 devices,
> or are their older ones, such as U160.

Sure.  Yes, there are two U320 SCSI hd's.

    Host:               amd01
    Kernel:             2.6.12-gentoo-r10
    Distribution:       gentoo 1.6.14
    Memory:             2053852 kB
    Arch:               x86_64
    CPU(s):             2x AMD Opteron(tm) Processor 242

SCSI:
     *-pci:1
          description: PCI bridge
          product: AMD-8131 PCI-X Bridge
          vendor: Advanced Micro Devices [AMD]
          physical id: 2
          bus info: pci@00:02.0
          version: 12
          width: 32 bits
          clock: 66MHz
          capabilities: pci normal_decode bus_master cap_list
        *-scsi:0
             description: SCSI storage controller
             product: 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI
             vendor: LSI Logic / Symbios Logic
             physical id: 1
             bus info: pci@02:01.0
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: scsi bus_master cap_list
             configuration: driver=mptbase
             resources: ioport:c400-c4ff iomemory:fe980000-fe98ffff iomemory:fe970000-fe97ffff irq:185
        *-scsi:1
             description: SCSI storage controller
             product: 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI
             vendor: LSI Logic / Symbios Logic
             physical id: 1.1
             bus info: pci@02:01.1
             version: 07
             width: 64 bits
             clock: 33MHz
             capabilities: scsi bus_master cap_list
             configuration: driver=mptbase
             resources: ioport:c800-c8ff iomemory:fe9f0000-fe9fffff iomemory:fe9e0000-fe9effff irq:193


PCI:

    00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
    00:01.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
    00:02.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
    00:02.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01) (prog-if 10 [IO-APIC])
    00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
    00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
    00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
    00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
    00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
    00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
    00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
    00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
    00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] HyperTransport Technology Configuration
    00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Address Map
    00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM Controller
    00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] Miscellaneous Control
    01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
    01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
    01:04.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
    02:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
    02:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)
    02:03.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
    02:03.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)

More info about this machine can be found here (for a different testrun).
The INFO directory has the full output from lshw:

    http://crucible.osdl.org/runs/2284/sysinfo/amd01.1/

Bryce
