Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267923AbRG2Kmd>; Sun, 29 Jul 2001 06:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267928AbRG2KmX>; Sun, 29 Jul 2001 06:42:23 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:7177 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S267923AbRG2KmL>; Sun, 29 Jul 2001 06:42:11 -0400
Message-ID: <3B63E9F3.3BEAA025@zip.com.au>
Date: Sun, 29 Jul 2001 20:48:19 +1000
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Thomas Kotzian <thomasko321k@gmx.at>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: missing symbols in 2.4.7-ac2
In-Reply-To: <3B636CA1.337A9C1A@zip.com.au> <Pine.LNX.4.21.0107291111440.16551-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hugh Dickins wrote:
> 
> On Sun, 29 Jul 2001, Andrew Morton wrote:
> > Thomas Kotzian wrote:
> > > when compiling with highmem = 4GB
> > > problem in 3c59x - module:
> > > unresolved symbol nr_free_highpages ...
> >
> > Ah.  Sorry.
> > Alan, is it OK to export this symbol?
> 
> Laconic version: "Probably not: si_meminfo() is your friend".

:)

> Verbose version:
> I don't think you really want nr_free_highpages(), that's transient
> info - it won't usually fall so low as 0 if there is highmem, but do
> you want to rely on that?

Prefer not to.  We want to know "does the system have any highmem
pages".  I didn't know about sysinfo.totalhigh, so I used
nr_free_highpages(), which answers the question "does the system
have any free high pages right now".

It's good enough - if we get it wrong (system was very low on memory
when the driver was initialised) the driver will work - it just won't
perform zerocopy optimisations.

>  And nr_free_highpages() is CONFIG_HIGHMEM
> only, so you'd need #ifdef CONFIG_HIGHMEM around its call in 3c59x.c.

That's OK actually - nr_free_highpages() evaluates to constant zero if
CONFIG_HIGHMEM isn't defined.


--- linux-2.4.7-ac2/drivers/net/3c59x.c Sat Jul 28 07:12:03 2001
+++ linux/drivers/net/3c59x.c   Sun Jul 29 10:53:31 2001
@@ -1299,8 +1299,11 @@
        /* The 3c59x-specific entries in the device structure. */
        dev->open = vortex_open;
        if (vp->full_bus_master_tx) {
+               struct sysinfo sysinfo;
+
                dev->hard_start_xmit = boomerang_start_xmit;
-               if (nr_free_highpages() == 0) {
+               si_meminfo(&sysinfo);
+               if (sysinfo.totalhigh == 0) {
                        /* Actually, it still should work with iommu. */
                        dev->features |= NETIF_F_SG;
                }

Much preferable!  Thanks.

I've checked all the architectures.  Looks fine, works OK.  Alan, please
apply this one.

-
