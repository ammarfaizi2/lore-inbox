Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266566AbUH0QnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266566AbUH0QnP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 12:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUH0QnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 12:43:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49796 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266566AbUH0QnF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 12:43:05 -0400
Date: Fri, 27 Aug 2004 17:43:03 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Greg KH <greg@kroah.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040827164303.GW16196@parcelfarce.linux.theplanet.co.uk>
References: <20040826131346.GK16196@parcelfarce.linux.theplanet.co.uk> <20040826154049.69769.qmail@web14923.mail.yahoo.com> <20040826155803.GN16196@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826155803.GN16196@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 04:58:03PM +0100, Matthew Wilcox wrote:
> I'm just tracking down another bug with the current code -- it maps the
> ROMs into the wrong address range on my ia64 zx1 box.  I'll send more
> mail once I've fixed that.

I fixed it in the ia64 code by ensuring that the ROM resource has a parent
and thus skipping the call to pci_assign_resource().

Of the 15 pci devfns on my system, 6 of them have ROMs:

/sys/devices/pci0000:80/0000:80:00.0/rom
/sys/devices/pci0000:60/0000:60:01.1/rom
/sys/devices/pci0000:60/0000:60:01.0/rom
/sys/devices/pci0000:40/0000:40:01.0/rom
/sys/devices/pci0000:20/0000:20:01.1/rom
/sys/devices/pci0000:20/0000:20:01.0/rom

0000:20:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 03)
0000:20:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 03)
0000:40:01.0 Token ring network controller: IBM 16/4 Token ring UTP/STP controller (rev 04)
0000:60:01.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
0000:60:01.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 66MHz  Ultra3 SCSI Adapter (rev 01)
0000:80:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 04)

The only one that doesn't work is the pair of 1030 chips (these are on the
motherboard, so possibly there's something funky going on).  The contents of
these roms are:

00000000  2e 2e 2e 2e 2e 2e 2e 2e  3e 2e 2e 2e 3e 3e 2e 2e  |........>...>>..|
00000010  2e 2e 2e 2e 2e 2e 2e 2e  2e 2e 2e 2e 2e 2e 2e 2e  |................|
00000020  1e 1e 1e 1e 1e 1e 1e 1e  1e 1e 1e 1e 1e 1e 1e 1e  |................|
00000030  0e 0e 0e 0e 0e 0e 0e 0e  0e 0e 0e 0e 0e 0e 0e 0e  |................|
00000040  3e 2e 2e 2e 3e 2e 2e 2e  3e 3e 2e 2e 3e 3e 3e 2e  |>...>...>>..>>>.|
00000050  2e 2e 2e 2e 2e 2e 2e 2e  2e 2e 2e 2e 2e 2e 2e 2e  |................|
00000060  1e 1e 1e 1e 1e 1e 1e 1e  1e 1e 1e 1e 1e 1e 1e 1e  |................|
00000070  0e 0e 0e 0e 0e 0e 0e 0e  0e 0e 0e 0e 0e 0e 0e 0e  |................|
00000080  2e 2e 2e 2e 2e 2e 2e 2e  3e 3e 2e 2e 2e 2e 2e 2e  |........>>......|
00000090  2e 2e 2e 2e 2e 2e 2e 2e  2e 2e 2e 2e 2e 2e 2e 2e  |................|
000000a0  1e 1e 1e 1e 1e 1e 1e 1e  1e 1e 1e 1e 1e 1e 1e 1e  |................|
000000b0  0e 0e 0e 0e 0e 0e 0e 0e  0e 0e 0e 0e 0e 0e 0e 0e  |................|
000000c0  3e 3e 2e 2e 3e 2e 2e 2e  3e 3e 3e 3e 3e 3e 3e 3e  |>>..>...>>>>>>>>|
000000d0  2e 2e 2e 2e 2e 2e 2e 2e  2e 2e 2e 2e 2e 2e 2e 2e  |................|
000000e0  1e 1e 1e 1e 1e 1e 1e 1e  1e 1e 1e 1e 1e 1e 1e 1e  |................|
000000f0  0e 0e 0e 0e 0e 0e 0e 0e  0e 0e 0e 0e 0e 0e 0e 0e  |................|

The expansion rom PCI region claims to be 4MB in size, but if we try to
read past 1MB, the machine reboots.  This won't be a problem with the latest
patch because it'll return a size of 0.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
