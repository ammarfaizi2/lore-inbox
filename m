Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbUAFAGu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 19:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbUAFAGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 19:06:46 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:51942 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266015AbUAFAF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 19:05:58 -0500
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple 
	map/unmaps
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, gibbs@scsiguy.com
In-Reply-To: <20040105223158.3364a676.ak@suse.de>
References: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu.suse.lists.linux.kern
	el> <20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
	<p73brpi1544.fsf@verdi.suse.de> <20040105130118.0cb404b8.davem@redhat.com> 
	<20040105223158.3364a676.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 05 Jan 2004 18:05:47 -0600
Message-Id: <1073347548.2439.33.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-01-05 at 15:31, Andi Kleen wrote:
> For the sake of bug-to-bug compatibility to the SCSI layer this patch may
> work. I haven't tested it so no guarantees if it won't eat your file systems.
> Feedback welcome anyways.

This isn't a bug in SCSI, it's a deliberate design feature.  SCSI has
certain events, like QUEUE full that cause us to re-queue the pending
I/O.  Other block layer drivers that can get these EAGAIN type queueing
problems from the device also follow this model.

The reason for doing this is the prep/request model for block drivers
(although the behaviour pre-dates the bio model).  As part of the prep
function, we prepare the mapping list that is later passed to
dma_map_sg().  Requeueing is done from the request function; by design,
we don't re-prepare the requests (and hence don't free and rebuild the
sg list).

Like Dave says, we rely on the sequence map/unmap/map to produce a
correct SG list.  This does give you slightly more leeway, since we
never look at the sg list after the unmap, for SCSI it doesn't have to
be returned to the pre-map state as long as re-mapping it is correct.

As to the idempotence of map/unmap: I'm ambivalent.  If it's going to be
a performance hit to return the sg list to its prior state in unmap,
then it does seem a waste given that for most of our I/O transactions we
simply free the sg list after the unmap.

It looks like we're down to a choice of three

1. Fix the x86_64 mapping layer as your patch proposes (how much of a
performance hit on every transaction will this be)?
2. Change SCSI (and every other block driver) to re-prepare requeued
I/O.  This will incur a free/setup overhead penalty, but only in the
requeue path.
3. Don't unmap the I/O in the requeue case.  I like this least because
the LLD is responsible for map/unmap and the mid-layer is responsible
for requeueing, so it's a layering violation (as well as a waste of
potentially valuable mapping resources).

On the whole, I prefer 1. Partly because it doesn't involve extra work
for me ;-) but also because idempotence is an appealing property from a
layering point of view.

If we're agreed on this, I can add it to the DMA docs.

James


