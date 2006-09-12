Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbWILFr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWILFr0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWILFrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:47:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:61482 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751254AbWILFrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:47:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MSpXL/kdrwajf2fXBVxc4hpkRgojCCgtbBUX6SdSWWskdh+OaSv1GWh96oVVsFcWXT91KXLfFVdAFv2CPvsmU2rQWnx4g3Xed/kgyUPgy1Q7KkGIEg8ofEu5GhzfaMc7kE5dJTCxiqqtWUgUocH0Ay+z+pmeYpVz7J6wipJ+MAo=
Message-ID: <e9c3a7c20609112247u30685133kc84f094ce7854776@mail.gmail.com>
Date: Mon, 11 Sep 2006 22:47:23 -0700
From: "Dan Williams" <dan.j.williams@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: [PATCH 00/19] Hardware Accelerated MD RAID5: Introduction
Cc: NeilBrown <neilb@suse.de>, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
In-Reply-To: <45061E63.6010901@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	 <4505F358.3040204@garzik.org>
	 <e9c3a7c20609111653v29cd4609hd0584ae300b735b7@mail.gmail.com>
	 <45061E63.6010901@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/06, Jeff Garzik <jeff@garzik.org> wrote:
> Dan Williams wrote:
> > This is a frequently asked question, Alan Cox had the same one at OLS.
> > The answer is "probably."  The only complication I currently see is
> > where/how the stripe cache is maintained.  With the IOPs its easy
> > because the DMA engines operate directly on kernel memory.  With the
> > Promise card I believe they have memory on the card and it's not clear
> > to me if the XOR engines on the card can deal with host memory.  Also,
> > MD would need to be modified to handle a stripe cache located on a
> > device, or somehow synchronize its local cache with card in a manner
> > that is still able to beat software only MD.
>
> sata_sx4 operates through [standard PC] memory on the card, and you use
> a DMA engine to copy memory to/from the card.
>
> [select chipsets supported by] sata_promise operates directly on host
> memory.
>
> So, while sata_sx4 is farther away from your direct-host-memory model,
> it also has much more potential for RAID acceleration:  ideally, RAID1
> just copies data to the card once, then copies the data to multiple
> drives from there.  Similarly with RAID5, you can eliminate copies and
> offload XOR, presuming the drives are all connected to the same card.
In the sata_promise case its straight forward, all that is needed is
dmaengine drivers for the xor and memcpy engines.  This would be
similar to the current I/OAT model where dma resources are provided by
a PCI function.  The sata_sx4 case would need a different flavor of
the dma_do_raid5_block_ops routine, one that understands where the
cache is located.  MD would also need the capability to bypass the
block layer since the data will have already been transferred to the
card by a stripe cache operation

The RAID1 case give me pause because it seems any work along these
lines requires that the implementation work for both MD and DM, which
then eventually leads to being tasked with merging the two.

>         Jeff

Dan
