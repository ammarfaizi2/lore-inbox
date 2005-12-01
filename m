Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbVLAR4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbVLAR4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 12:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbVLAR4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 12:56:41 -0500
Received: from havoc.gtf.org ([69.61.125.42]:34181 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S932370AbVLAR4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 12:56:40 -0500
Date: Thu, 1 Dec 2005 12:56:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Christoph Hellwig <hch@infradead.org>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Luvella McFadden <luvella@us.ibm.com>, AJ Johnson <blujuice@us.ibm.com>,
       Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, Mauelshagen@redhat.com
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Message-ID: <20051201175634.GA9283@havoc.gtf.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01E3E318@otce2k03.adaptec.com> <20051201174411.GA13002@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051201174411.GA13002@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2005 at 05:44:12PM +0000, Christoph Hellwig wrote:
> On Thu, Dec 01, 2005 at 08:44:15AM -0500, Salyzyn, Mark wrote:
> > The HostRAID driver has a specialized (ok, yes, also proprietary) CHIM
> > and sequencer where attention can be focused on techniques of
> > performance improvement and OS agnostics. In addition, the RAID code in
> > that driver understands the hardware, CHIM & sequencer and takes
> > advantage of features that just can not be performed by an abstracted dm
> > or an LLD. RAID1 is handled under some conditions, for instance, with
> > one DMA operation over the PCI bus rather than two duplicated for each
> > target, greatly increasing the performance.
> 
> If you contributed that sequencer code and sent me a card I'm pretty sure
> I'd love into adding support for this to a special DM module.  In fact we'd
> need somthing similar for Certain SATA boards aswell.
> 
> OTOH the raid flag would be useless aswell there, because we'd of course
> support this on identical cards without the raid bios aswell :)

I'd love to see a hardware-aware DM RAID module, since I want to do the
same thing for sata_sx4 (Promise SX4).

SX4 has four ATA engines, an on-card ECC-capable DIMM, and an on-card
XOR engine.  The OS driver has complete control over these facilities.
Unfortunately, driving the card in "dumb mode" means that performance
takes a major hit, since each transaction looks like:

	submit DMA memcpy to HDMA engine
	get HDMA interrupt
		# now, the data is on the card
	submit ATA write command
	get ATA interrupt

All data must be copied to/from the DIMM, before the ATA engine can do
anything.  Further, there is only one HDMA engine, but 4 ATA engines.

Ideally, RAID1 would copy the data to the card ONCE, then start 2 ATA
engines.  Ideally, RAID5 would copy the data to the card ONCE, XOR it,
then start the ATA engines.  And the rest of the DIMM should be used as
write-through cache.

I'm sure DM can do that, but I haven't researched how.

I'll supply a card (and engineering help, but no docs, alas) to anyone
interested in trying out this stuff.

	Jeff



