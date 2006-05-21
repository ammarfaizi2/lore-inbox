Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWEUKPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWEUKPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 06:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWEUKPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 06:15:46 -0400
Received: from [194.90.237.34] ([194.90.237.34]:54655 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S932385AbWEUKPq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 06:15:46 -0400
Date: Sun, 21 May 2006 13:16:56 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>
Cc: Brice Goglin <brice@myri.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060521101656.GM30211@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <4468EE85.4000500@myri.com> <20060518155441.GB13334@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518155441.GB13334@suse.de>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 21 May 2006 10:19:42.0421 (UTC) FILETIME=[13317050:01C67CC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
> 
> On Mon, May 15, 2006 at 11:11:33PM +0200, Brice Goglin wrote:
> > Hi Greg,
> > 
> > While looking at the MSI detection, I noticed that the AMD 8131 quirk
> > (quirk_amd_8131_ioapic) is defined as FINAL and thus executed after the
> > PCI hierarchy is scanned. So it looks like the bus_flags won't be
> > inherited at all. If there's a bridge behind the 8131, then the devices
> > behind this bridge won't see the bus flags and thus might try to enable
> > MSI anyway.
> > I tried to change the AMD 8131 quirk to HEADER so that it is executed
> > during PCI scanning. But, I don't get its message in dmesg anymore. Any
> > idea?
> 
> Michael is the one who added that change, perhaps he can explain how he
> tested it?

Well, I just re-tested with 2.6.17-rc4 and it does not seem to work.  No idea
what did I do wrong when testing this patch before posting it :(. Oops.
I'm sorry.

Given that its late in -rc series, that its a clear regression from 2.6.16, that
disabling MSI is always safe, and that the patch was intended to enable MSI on
Tyan motherboard which Roland used to have but doesn't anymore and which no one
else seems to be bothered to test on either - it seems the best thing is to just
revert the patch, and go back to using a global flag for now.
I'll try to revisit this for 2.6.18 if I can get my hands on such a system.
Greg, what do you think?

It's 6e325a62a0a228cd0222783802b53cce04551776 in Linus' tree:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=6e325a62a0a228cd0222783802b53cce04551776

Here's a minimal patch against 2.6.17-rc4 - I tested it by loading mthca with
msi_x=1.

---

Revert MSI quirk change in 6e325a62a0a228cd0222783802b53cce04551776 - it breaks 
regular AMD-8131 systems, and no one seems to care enough to test on Tyan
systems where it's supposed to improve performance.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

Index: linux-2.6.17-rc4/drivers/pci/quirks.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/pci/quirks.c	2006-05-21 12:49:52.000000000 +0300
+++ linux-2.6.17-rc4/drivers/pci/quirks.c	2006-05-21 13:04:37.000000000 +0300
@@ -575,11 +575,8 @@ static void __init quirk_amd_8131_ioapic
 { 
         unsigned char revid, tmp;
         
-	if (dev->subordinate) {
-		printk(KERN_WARNING "PCI: MSI quirk detected. "
-		       "PCI_BUS_FLAGS_NO_MSI set for subordinate bus.\n");
-		dev->subordinate->bus_flags |= PCI_BUS_FLAGS_NO_MSI;
-	}
+	pci_msi_quirk = 1;
+	printk(KERN_WARNING "PCI: MSI quirk detected. pci_msi_quirk set.\n");
 
         if (nr_ioapics == 0) 
                 return;

-- 
MST
