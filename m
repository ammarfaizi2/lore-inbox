Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbRG2KVb>; Sun, 29 Jul 2001 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267915AbRG2KVU>; Sun, 29 Jul 2001 06:21:20 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:10898 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S267843AbRG2KVC>; Sun, 29 Jul 2001 06:21:02 -0400
Date: Sun, 29 Jul 2001 11:21:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Thomas Kotzian <thomasko321k@gmx.at>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: missing symbols in 2.4.7-ac2
In-Reply-To: <3B636CA1.337A9C1A@zip.com.au>
Message-ID: <Pine.LNX.4.21.0107291111440.16551-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001, Andrew Morton wrote:
> Thomas Kotzian wrote:
> > when compiling with highmem = 4GB
> > problem in 3c59x - module:
> > unresolved symbol nr_free_highpages ...
> 
> Ah.  Sorry.
> Alan, is it OK to export this symbol?

Laconic version: "Probably not: si_meminfo() is your friend".

Verbose version:
I don't think you really want nr_free_highpages(), that's transient
info - it won't usually fall so low as 0 if there is highmem, but do
you want to rely on that?  And nr_free_highpages() is CONFIG_HIGHMEM
only, so you'd need #ifdef CONFIG_HIGHMEM around its call in 3c59x.c.

But si_meminfo() is already exported: I think sysinfo.totalhigh is
what you want to check; if I'm wrong, and you really are interested
in whether there are currently free highpages, sysinfo.freehigh
gives you that too without needing a new export.

(I think there probably will be a need for new interfaces
to export more per-zone memory info, but not for this.)

Hugh

--- linux-2.4.7-ac2/drivers/net/3c59x.c	Sat Jul 28 07:12:03 2001
+++ linux/drivers/net/3c59x.c	Sun Jul 29 10:53:31 2001
@@ -1299,8 +1299,11 @@
 	/* The 3c59x-specific entries in the device structure. */
 	dev->open = vortex_open;
 	if (vp->full_bus_master_tx) {
+		struct sysinfo sysinfo;
+
 		dev->hard_start_xmit = boomerang_start_xmit;
-		if (nr_free_highpages() == 0) {
+		si_meminfo(&sysinfo);
+		if (sysinfo.totalhigh == 0) {
 			/* Actually, it still should work with iommu. */
 			dev->features |= NETIF_F_SG;
 		}

