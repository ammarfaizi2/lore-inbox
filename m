Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266478AbUFQMxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266478AbUFQMxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 08:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266476AbUFQMxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 08:53:46 -0400
Received: from magic.adaptec.com ([216.52.22.17]:33200 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S266475AbUFQMxj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 08:53:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PATCH: Further aacraid work
Date: Thu, 17 Jun 2004 08:53:36 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189FD23FF9@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH: Further aacraid work
Thread-Index: AcRT7w0XfYUkRvixSj6RhkxA1dLpvAAeRysw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Alan Cox" <alan@redhat.com>, "Christoph Hellwig" <hch@infradead.org>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the 32 bit dma descriptors was used to optimize the transfer size
and performance. There is a small performance hit by switching to a
resultant larger FIB (adapter command packet) with 64 bit SG elements,
and an accompanied reduced limit on the number of total SG elements
available. Since the scsi layer has a propensity to provide sequentially
decreasing pages (sequentially increasing would permit coalescing of SG
elements) for the SG elements, we find that there is an average SG
element size of 4K.

The performance hit is up to 15% when the request has to be split to fit
into the available SG element slots.

An increase in performance of the scsi layer could occur if the
allocator provided sequentially increasing pages to permit a larger SG
element to be sent down to the adapter, and thus a larger request down
to the adapter.

I *must* admit that the driver functions perfectly in other systems with
more than 4G of memory; however we *are* having troubles specifically
with AMD64 systems with more than 4G of memory in 2.6 kernels (the issue
does not occur on 2.4 kernels). I have yet to investigate why this
specific problem exists.

One would expect that if we erroneously got the memory model wrong (ie,
<4GB of memory, one slice at 0-2G, another slice at 4G-6G) that the 32
dma limit would protect us from functional problems in this delicate
area but with a performance hit resulting from the scsi layer providing
bounce buffers. Ideally we would like to have a mechanism to know if the
DMAable area is limited to a 32 bit address space in order to take
advantage of the more efficient FIB utilization.

Sincerely -- Mark Salyzyn

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Alan Cox
Sent: Wednesday, June 16, 2004 6:06 PM
To: Christoph Hellwig; Alan Cox; linux-kernel@vger.kernel.org;
linux-scsi@vger.kernel.org
Subject: Re: PATCH: Further aacraid work

On Wed, Jun 16, 2004 at 10:58:34PM +0100, Christoph Hellwig wrote:
> Yikes.  This looked like they usual use 32bit dma descriptors if not
> enough memory hacks to me.  If aacraid is that royally fucked we
should
> probably add CONFIG_X86 to it.

Its working on x86-32, x86-64 and I believe (Mark can confirm this)
IA-64.
I'm fairly sure there are some platforms that aren't going to fit the
hardware's view of the world which seems to be

0[DMAable area..................]defined limit   [4Gb+.. PAE mode on
some]

The later cards also have a 2Gb limit for the ring buffers, but not for
the
I/O you want to target


-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
