Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWJFFu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWJFFu0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 01:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932604AbWJFFu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 01:50:26 -0400
Received: from smtp107.rog.mail.re2.yahoo.com ([68.142.225.205]:17339 "HELO
	smtp107.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932212AbWJFFuZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 01:50:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:From:Organization:To:Subject:Date:User-Agent:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=br+K4mhQ89L4+MSkt6ojN0QFUvPmNCxiKLmMQCx8rJWpe14M8mY8IpKLIwCWUzB9CG9rQIb8I6kSgZE9qIlNcFRm0irW1NivyslAP++NRfww5sgn3PDz7hglsnSWm/vklMVYeWF+2JxyNHSDSSCiu48IAT7JWIaFLNIrCPnbeLs=  ;
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [2.6.19-rc1][AGP] Regression -  amd_k7_agp  no longer detected
Date: Fri, 6 Oct 2006 01:50:19 -0400
User-Agent: KMail/1.9.4
Cc: davej@codemonkey.org.uk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610060150.20415.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

I noticed that my AGP chipset is no longer detected with 2.6.18/19-rc1.
The last known kernel this worked was 2.6.15-rc5 (see end of email)

I checked the BIOS and the settings are fine. The aperture is set to 128MB (manually) for the video card is only 64MB video ram.

Here's the information:

The Motherboard is a A7M266-D board from Asus.

AGP/PCI information:
===================
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge

PCI IDs:
=======
00:00.0 0600: 1022:700c (rev 11)
00:01.0 0604: 1022:700d

Problem: 
========
When loading amd_k7_agp nothing appears from kernel, no information about the AGP chipset/aptreture size etc. 
Even putting kprints inside the probe() function of the driver does not get called. So it seems core agpart is aborting silently. 
In the specific agp chipset driver, the PCI ID bridge is matched but I see no further checks being done.

When the X Window System starts I get the following:

[ 1084.678461] Linux agpgart interface v0.101 (c) Dave Jones
[ 1301.755691] [drm] Initialized drm 1.0.1 20051102
[ 1301.761525] ACPI: PCI Interrupt 0000:01:05.0[A] -> GSI 16 (level, low) -> IRQ 20
[ 1301.762563] [drm] Initialized radeon 1.25.0 20060524 on minor 0
[ 1303.005775] [drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[ 1303.005988] [drm:drm_unlock] *ERROR* Process 5215 using kernel context 0

>From Xorg log:

(WW) RADEON(0): [agp] AGP not available
(EE) RADEON(0): [agp] AGP failed to initialize. Disabling the DRI.
(II) RADEON(0): [agp] You may want to make sure the agpgart kernel module is loaded before the radeon kernel module.

What should be expected
>From 2.6.15-rc5:

[   62.814823] Linux agpgart interface v0.101 (c) Dave Jones
[   62.841388] agpgart: Detected AMD 760MP chipset
[   62.870371] agpgart: AGP aperture is 128M @ 0xf0000000

Looking at the differences, I noticed some changes in generic.c for determing the AGP speed. I don't know
 if this has anything to do with this breaking. This video card is a Radeon 7500 AiW 64MB DDR and can do
 AGP4x and BIOS has AGP4x turned on by default. But this all would fail even before X is started if agpgart finds no chipset.

Thanks, 
Shawn.
