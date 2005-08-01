Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVHAJHf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVHAJHf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 05:07:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVHAJHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 05:07:35 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:17643
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S261723AbVHAJHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 05:07:33 -0400
Date: Mon, 1 Aug 2005 05:06:33 -0400
From: Sonny Rao <sonny@burdell.org>
To: vojtech@suse.cz
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: amd74xx (nforce) driver problem ?
Message-ID: <20050801090633.GA12320@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a system based on the Nforce2 chipset which uses the amd7xx
driver for it's IDE support, and I noticed that one of the drives was
performing very slowly.  I looked into it a bit more and it seems the
drive was operating as UDMA33 instead of UDMA100 for some reason.

The affected drive was getting about 20-25Mb/sec sequential read (dumb
hdparm test) while a similar drive on the other channel was getting
about 45-50 Mb/sec.  The drive on the other channel was operating at
UDMA100.  Both drives are attached using the proper 80-wire cable.

Kernel is 2.6.13-rc4 

If I go into the bios and twiddle an "IDE Master" setting from the
"none" to the "auto" setting then the driver operates at the expected
speed. 


I'm confused though why the driver never correctly set up that IDE
channel?  It claims in the kernel log that it detected the BIOS
borkage: 

NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA


Shouldn't the driver set the channel to UDMA100 after it detects the BIOS
set up the chip improperly, or am I mistaken about this behavior?  Isn't
that the "workaround" or does that mean something else?

Here is the output of /proc/ide/amd74xx:

----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.13
South Bridge:                       0000:00:09.0
Revision:                           IDE 0xa2
Highest DMA rate:                   UDMA133
BM-DMA base:                        0xf000
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 80w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       DMA      UDMA       DMA
Address Setup:       30ns      90ns      30ns      90ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:          60ns     600ns      20ns     600ns
Transfer Rate:   33.3MB/s   3.3MB/s  99.9MB/s   3.3MB/s

If I change all of my BIOS settings to "auto" then the drive operates
at UDMA100 as expected and /proc/ide/amd74xx reports the 80-wire cable
correctly and reports the transfer rates for drive0 correctly. 

This isn't a major issue since I can fix it in the BIOS, but I just
wanted to alert the maintainers.

Thanks in advance,

Sonny
