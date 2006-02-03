Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030244AbWBCVP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbWBCVP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWBCVP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:15:58 -0500
Received: from silver.veritas.com ([143.127.12.111]:21070 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030245AbWBCVP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:15:56 -0500
Date: Fri, 3 Feb 2006 21:16:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Mike Christie <michaelc@cs.wisc.edu>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Doug Gilbert <dougg@torque.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] st: don't doublefree pages from scatterlist
In-Reply-To: <43E3BF33.6050705@cs.wisc.edu>
Message-ID: <Pine.LNX.4.61.0602032100400.15678@goblin.wat.veritas.com>
References: <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net> <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
 <Pine.LNX.4.61.0601090933160.7632@goblin.wat.veritas.com>
 <20060109185350.GG283@tau.solarneutrino.net> <Pine.LNX.4.61.0601091922550.15426@goblin.wat.veritas.com>
 <20060118001252.GB821@tau.solarneutrino.net> <Pine.LNX.4.61.0601181556050.9110@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031842290.14065@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0602031951280.14829@goblin.wat.veritas.com> <43E3BF33.6050705@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 03 Feb 2006 21:15:56.0370 (UTC) FILETIME=[05B20320:01C62907]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Mike Christie wrote:
> Hugh Dickins wrote:
> > On some architectures, mapping the scatterlist may coalesce entries:
> > if that coalesced list is then used for freeing the pages afterwards,
> > there's a danger that pages may be doubly freed (and others leaked).
> > 
> > Fix SCSI Tape's sgl_unmap_user_pages by freeing from the pagelist used
> > in sgl_map_user_pages.  Fixes Ryan Richter's crash on x86_64, with Bad
> > page state mapcount 2 from sgl_unmap_user_pages, and consequent mayhem.
> 
> Is this crash occuring with 2.6.16-rc1?

I do believe 2.6.15 is the latest release that Ryan has tried (and,
strangely, nobody else has ever reported it - identifiably, anyway).
Interested in trying unpatched 2.6.16-rc2, Ryan?

> I ask becuase in that kernel the scatterlist passed into scsi_execute_async
> 
> if (scsi_execute_async(STp->device, cmd, direction,
> &((STp->buffer)->sg[0]), bytes,
> 
> is not the same one that gets send down to the device/HBA.

Wow, great info, thanks.

> scsi_execute_async takes the scatterlist passed to it from st or sg, uses it
> as a hint to build a request + bios, then later when the request is sent to
> the device a new scatterlist is sent to the device and the device does the
> pci/dma operation on that scatterlist from the block/scsi layer.

Very interesting.  James can confirm, but I think that means everybody
can ignore my drivers/scsi/st.c patch for 2.6.16-rc, and the unposted
sg.c patches for the same issue that I was going to send Doug.

But the Infiniband, ipr and osst patches still look to be necessary -
unless maintainers can point to a similar intervening layer.

Hugh
