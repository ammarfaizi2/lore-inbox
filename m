Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265098AbUIWOxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265098AbUIWOxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUIWOxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:53:40 -0400
Received: from sccimhc92.asp.att.net ([63.240.76.166]:14568 "EHLO
	sccimhc92.asp.att.net") by vger.kernel.org with ESMTP
	id S265098AbUIWOxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:53:36 -0400
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Sub-optimal MTRR config in kernel 2.6.x
Date: Thu, 23 Sep 2004 09:53:36 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409230953.36618.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The last few revisions of the kernel (the only 2.6 kernels I've used) 
are setting up my MTRR ranges sub-optimally.  

This is on a notebook machine which "features" the use of system RAM 
in place of dedicated video memory.  Currently a 32MB portion of the 
system memory is carved out for the display.  The system memory 
consists of 2 512MB SODIMM modules.  These are my system devices:

# lspci
00:00.0 Host bridge: ATI Technologies Inc RS200/RS200M AGP Bridge [IGP 340M] (rev 02)
00:01.0 PCI bridge: ATI Technologies Inc PCI Bridge [IGP 340M]
00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Controller Audio Device (rev 02)
00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge [Aladdin IV]
00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller
00:09.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless LAN Controller (rev 02)
00:0a.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller
00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50)
00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 50)
00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394a-2000 Controller (PHY/Link)
00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
00:11.0 Bridge: ALi Corporation M7101 Power Management Controller [PMU]
00:12.0 Ethernet controller: National Semiconductor Corporation DP83815 (MacPhyter) Ethernet Controller
01:05.0 VGA compatible controller: ATI Technologies Inc Radeon IGP 340M

And this is how the MTRRs are set up after booting the 2.6.8 kernel:

# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
reg05: base=0x3df80000 ( 991MB), size= 512KB: uncachable, count=1
reg06: base=0x4df80000 (1247MB), size= 512KB: uncachable, count=1
reg07: base=0xdc000000 (3520MB), size=   1MB: write-combining, count=1

With this configuration, Xorg (v6.8.1) logs this complaint at startup: 

(WW) RADEON(0): Failed to set up write-combining range (0xdc000000,0x2000000)

I can satisfy this complaint by manually adjusting the MTRR config 
prior to starting Xorg like this:

echo "disable=7" >| /proc/mtrr
echo "base=0xdc000000 size=0x2000000 type=write-combining" > /proc/mtrr

This gets me the following config:

# cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0x30000000 ( 768MB), size= 128MB: write-back, count=1
reg03: base=0x38000000 ( 896MB), size=  64MB: write-back, count=1
reg04: base=0x3c000000 ( 960MB), size=  32MB: write-back, count=1
reg05: base=0x3df80000 ( 991MB), size= 512KB: uncachable, count=1
reg06: base=0x4df80000 (1247MB), size= 512KB: uncachable, count=1
reg07: base=0xdc000000 (3520MB), size=  32MB: write-combining, count=1

My BIOS allows me to configure the amount of system memory reserved 
for video use.  I've tried various values (trying to balance the size 
and location of the reserved area) but in the end only manually 
adjusting the MTRR values will prevent the Xorg complaint.

Look at that the default MTRR config again.  Register 7 is configured 
for a 1MB area.  One megabyte?  That strikes me as being sub-optimal.

What, if anything, can I do have the kernel configure my MTRRs more 
effectively?

Thanks.

