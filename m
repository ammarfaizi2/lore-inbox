Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVDDHw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVDDHw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 03:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVDDHw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 03:52:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:5297 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261154AbVDDHwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 03:52:22 -0400
Subject: Re: iomapping a big endian area
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Matthew Wilcox <matthew@wil.cx>, "David S. Miller" <davem@davemloft.net>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1112499639.5786.34.camel@mulgrave>
References: <1112475134.5786.29.camel@mulgrave>
	 <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
	 <20050402183805.20a0cf49.davem@davemloft.net>
	 <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
	 <1112499639.5786.34.camel@mulgrave>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 17:49:12 +1000
Message-Id: <1112600953.19004.46.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-02 at 21:40 -0600, James Bottomley wrote:

> Actually, ioread8be is unnecessary, but I was planning to add
> ioread16/ioread32 and iowritexx be on be variants (equivalent to
> _raw_readw et al.)
> 
> After all, the driver must know the card is BE, so the routines that
> make use of the feature are easily coded into the card, so there's no
> real need to add it to the iomem cookie.
> 
> Did anyone have a preference for the API?  I was thinking
> ioread32_native, but ioread32be is fine too.

I think we want "be" since obviously, the "ioread32" one is "le", that
makes sense to provide both and let the implementation bother with what
has to swap or not. With "native", x86 would do what ? swap or not
swap ? unclear ... with "be", at least it's clear.

The problem ? Hehe, well ... there is at least one little problem: The
way iomap "fixes" the issue of mem vs. io space in a driver could have
been used to also fix le vs. be issues. For example, an USB OHCI
controller is normally little endian. But some too-stupid-for-words HW
folks tried to be too smart on a number of embedded chips, and put a big
endian version of it. Thus the driver ends up having to support both.
Most embedded vendors just butcher the driver with #ifdef's which is
fine by me ... until you end up having _also_ a PCI bus with an
EHCI/OHCI pair on it on the same board... then you are toast.

But, I wouldn't bother too much about this case. The driver has other
issues than just IO to deal with (the DMA data structures in memory are
also endian- swapped) so I suppose the entire driver need to be somewhat
#included from a wrapper an compiled twice for different endians to get
that right...

Ben.


