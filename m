Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUAFDGs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265934AbUAFDGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:06:48 -0500
Received: from ns.suse.de ([195.135.220.2]:59309 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265907AbUAFDGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:06:43 -0500
Date: Tue, 6 Jan 2004 04:06:40 +0100
From: Andi Kleen <ak@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       gibbs@scsiguy.com
Subject: Re: [BUG] x86_64 pci_map_sg modifies sg list - fails multiple 
 map/unmaps
Message-Id: <20040106040640.1d2bcbd8.ak@suse.de>
In-Reply-To: <1073347548.2439.33.camel@mulgrave>
References: <200401051929.i05JTsM0000014248@mudpuddle.cs.wustl.edu.suse.lists.linux.kern
	el>
	<20040105112800.7a9f240b.davem@redhat.com.suse.lists.linux.kernel>
	<p73brpi1544.fsf@verdi.suse.de>
	<20040105130118.0cb404b8.davem@redhat.com>
	<20040105223158.3364a676.ak@suse.de>
	<1073347548.2439.33.camel@mulgrave>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 05 Jan 2004 18:05:47 -0600
James Bottomley <James.Bottomley@steeleye.com> wrote:

> On Mon, 2004-01-05 at 15:31, Andi Kleen wrote:
> > For the sake of bug-to-bug compatibility to the SCSI layer this patch may
> > work. I haven't tested it so no guarantees if it won't eat your file systems.
> > Feedback welcome anyways.
> 
> This isn't a bug in SCSI, it's a deliberate design feature.  SCSI has
> certain events, like QUEUE full that cause us to re-queue the pending
> I/O.  Other block layer drivers that can get these EAGAIN type queueing
> problems from the device also follow this model.

It's ok. I fixed the code now[1] If you have other undocumented requirements
you should document them though, otherwise there may be more problems.
Since merging is disabled by default now it won't trigger anyways.

[1] will be in next merge after testing, the last patch i posted still
had one bug.

> As to the idempotence of map/unmap: I'm ambivalent.  If it's going to be
> a performance hit to return the sg list to its prior state in unmap,
> then it does seem a waste given that for most of our I/O transactions we
> simply free the sg list after the unmap.

With the evil dma_length trick it is actually near zero cost.

> 1. Fix the x86_64 mapping layer as your patch proposes (how much of a
> performance hit on every transaction will this be)?

I don't expect a significant performance hit.

-Andi
