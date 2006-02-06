Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWBFRBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWBFRBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 12:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWBFRBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 12:01:12 -0500
Received: from gold.veritas.com ([143.127.12.110]:60563 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S932230AbWBFRBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 12:01:10 -0500
Date: Mon, 6 Feb 2006 17:01:53 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: "David S. Miller" <davem@davemloft.net>, brking@us.ibm.com, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ipr: don't doublefree pages from scatterlist
In-Reply-To: <1139238179.3022.2.camel@mulgrave.il.steeleye.com>
Message-ID: <Pine.LNX.4.61.0602061646230.3560@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602040004020.5406@goblin.wat.veritas.com> 
 <43E66FB6.6070303@us.ibm.com>  <Pine.LNX.4.61.0602060909180.6827@goblin.wat.veritas.com>
  <20060206.014608.22328385.davem@davemloft.net> <1139238179.3022.2.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 06 Feb 2006 17:01:09.0059 (UTC) FILETIME=[ECFCB930:01C62B3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, James Bottomley wrote:
> On Mon, 2006-02-06 at 01:46 -0800, David S. Miller wrote:
> > That's a bug, frankly.  Sparc64 doesn't need to do anything like
> > that.  Spamming the page pointers is really really bogus and I'm
> > surprised this doesn't make more stuff explode.
> > 
> > It was never the intention to allow the DMA mapping support code
> > to modify the page, offset, and length members of the scatterlist.
> > Only the DMA components.
> > 
> > I'd really prefer that those assignments get fixed and an explicit
> > note added to Documentation/DMA-mapping.txt about this.
> > 
> > It's rediculious that these generic subsystem drivers need to
> > know about this. :)
> 
> I complained about this x86_64 behaviour ages ago.

While I agree with you, David and Brian that this would be much nicer
for driver writers to know that the page,offset,length in the sg list
would not be touched by map_sg, I am surprised that you didn't say so
in DMA-API.txt, and said only that map_sg would destroy information
there.  x86_64 seems to conform to that destruction!

> Andi claimed it was
> the only way they could get there merging algorithm to work.  It
> actually triggered a bug in SCSI because in-flight I/O that was rejected
> gets unmapped and then remapped (which was, originally, not working).
> They finally fixed it by making the unmap put back the original
> scatterlist.

I don't quite get that, but whatever, it would be a good idea to cc Andi.

> Perhaps this should go to linux-arch just in case anyone
> else copied x86_64?

Okay, cc'd to linux-arch also.  The one thing I have checked is that the
coalescing architectures (if I actually got them right) do all declare
a dma_length (perhaps differently named) distinct from input length,
so wouldn't need that added.  Although I can see that x86_64 does
modify the page,offset,length fields we'd prefer it not to, I didn't
find any of the architecture's coalescing routines easy to follow,
and would hesitate to declare any of them safe in this regard.

I'd better also forward my original mail on the fix to Ryan's bug
to Andi and linux-arch also.

Hugh
