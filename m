Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUFQOkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUFQOkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 10:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUFQOkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 10:40:14 -0400
Received: from magic.adaptec.com ([216.52.22.17]:46984 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S266514AbUFQOjv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 10:39:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH: Further aacraid work
Date: Thu, 17 Jun 2004 10:39:49 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189FD2402C@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: Further aacraid work
Thread-Index: AcRUb5Gu0wCaJ4S/TCqW1YXwSuYiOAAAnHcw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Christoph Hellwig" <hch@infradead.org>
Cc: "Alan Cox" <alan@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We make sure that the dma mask is 32 bit when we `guess' that the memory
size is < 4GB.

But it would be `nice' to know if the system preference is to send back
64 bit or 32 bit DMA addresses (also making the performance tradeoff
decision that although they have *some* 64 bit addresses, that they will
function at or near top performance with 32 bit addresses and a periodic
bounce buffering when required).

This would not be such an issue if Linux provided large SG elements
rather than the fubar descending page order ones they issue today. If
this could be fixed, I'd not even be interested in the optimization of
the SG.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Thursday, June 17, 2004 9:33 AM
To: Salyzyn, Mark
Cc: Alan Cox; Christoph Hellwig; linux-kernel@vger.kernel.org;
linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work

On Thu, Jun 17, 2004 at 08:53:36AM -0400, Salyzyn, Mark wrote:
> I *must* admit that the driver functions perfectly in other systems
with
> more than 4G of memory; however we *are* having troubles specifically
> with AMD64 systems with more than 4G of memory in 2.6 kernels (the
issue
> does not occur on 2.4 kernels). I have yet to investigate why this
> specific problem exists.

So what exactly is the firmware doing with this information?  What I
expected is that if the memory is smaller 4GB it's just use 32bit
descriptors.  If you want to keep that heck do the check _before_
setting
the dma_mask.  If you have a > 32bit dma mask but the firmware can't
deal
with the high bits in the dma address actually set it's a bug.  It won't
show up on PCs but pretty much on any complex architecture with an iommu
(like AMD64)

> One would expect that if we erroneously got the memory model wrong
(ie,
> <4GB of memory, one slice at 0-2G, another slice at 4G-6G) that the 32
> dma limit would protect us from functional problems in this delicate
> area but with a performance hit resulting from the scsi layer
providing
> bounce buffers. Ideally we would like to have a mechanism to know if
the
> DMAable area is limited to a 32 bit address space in order to take
> advantage of the more efficient FIB utilization.

Again, memory model doesn't matter.  For many plattforms dma address
aren't memory addresses.

