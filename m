Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263275AbTCNItz>; Fri, 14 Mar 2003 03:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbTCNItz>; Fri, 14 Mar 2003 03:49:55 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:15289 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S263275AbTCNIty>;
	Fri, 14 Mar 2003 03:49:54 -0500
Date: Fri, 14 Mar 2003 10:00:37 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Zoltan Hidvegi <amd_80w@hzoli.2y.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH 2.4.21-pre4-ac4] nForce/AMD 80 wire IDE cable detection
Message-ID: <20030314100037.B28232@ucw.cz>
References: <E18njc2-0005mU-00@hzoli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E18njc2-0005mU-00@hzoli.home>; from amd_80w@hzoli.2y.net on Tue, Feb 25, 2003 at 12:15:30PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 12:15:30PM -0600, Zoltan Hidvegi wrote:
> amd74xx.c in 2.4.21-pre4-ac4 uses an uninitialized variable to set the
> cable type.  I have made a simple fix that I have tried it with an MSI
> K7N2G-ILSR nForce2 board.  With this patch the 80 wire cable on my
> primary IDE is detected by the workaround, but the secondary IDE is
> still incorrectly reported as 40 wire, so something may still be
> wrong.  See below some IDE boot messages and the small patch.
> 
> I am not subscribed to the list, so please CC me any reply.  The
> return e-mail address is temporary to prevent spam, if the mail
> bounces, resend it to hzoli instead of amd_80w.

Thanks, applied.

> 
> Zoli
> 
> 
> NFORCE2: IDE controller at PCI slot 00:09.0
> NFORCE2: chipset revision 162
> NFORCE2: not 100% native mode: will probe irqs later
> AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.
> AMD_IDE: PCI device 10de:0065 (nVidia Corporation) (rev a2) UDMA100 controller o
> n pci00:09.0
>     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: WDC WD1200JB-75CRA0, ATA DISK drive
> hdc: RIDATA DVD+RW DRIVE, ATAPI CD/DVD-ROM drive
> 
> ----------AMD BusMastering IDE Configuration----------------
> Driver Version:                     2.9
> South Bridge:                       PCI device 10de:0065 (nVidia Corporation)
> Revision:                           IDE 0xa2
> Highest DMA rate:                   UDMA100
> BM-DMA base:                        0xf000
> PCI clock:                          33.3MHz
> -----------------------Primary IDE-------Secondary IDE------
> Prefetch Buffer:              yes                 yes
> Post Write Buffer:            yes                 yes
> Enabled:                      yes                 yes
> Simplex only:                  no                  no
> Cable Type:                   80w                 40w
> -------------------drive0----drive1----drive2----drive3-----
> Transfer Mode:       UDMA       DMA      UDMA       DMA
> Address Setup:       30ns      90ns      30ns      90ns
> Cmd Active:          90ns      90ns      90ns      90ns
> Cmd Recovery:        30ns      30ns      30ns      30ns
> Data Active:         90ns     330ns      90ns     330ns
> Data Recovery:       30ns     270ns      30ns     270ns
> Cycle Time:          20ns     600ns      60ns     600ns
> Transfer Rate:   99.9MB/s   3.3MB/s  33.3MB/s   3.3MB/s
> 
> 
>  --- drivers/ide/pci/amd74xx.c~	Fri Feb 14 10:22:25 2003
>  +++ drivers/ide/pci/amd74xx.c	Tue Feb 25 11:31:53 2003
>  @@ -309,7 +309,8 @@
>   
>   		case AMD_UDMA_100:
>   			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
>  -			amd_80w = ((u & 0x3) ? 1 : 0) | ((u & 0xc) ? 2 : 0);
>  +			amd_80w = ((t & 0x3) ? 1 : 0) | ((t & 0xc) ? 2 : 0);
>  +			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
>   			for (i = 24; i >= 0; i -= 8)
>   				if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
>   					printk(KERN_WARNING "AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.\n");

-- 
Vojtech Pavlik
SuSE Labs
