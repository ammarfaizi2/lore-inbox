Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290816AbSARUwS>; Fri, 18 Jan 2002 15:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290817AbSARUwJ>; Fri, 18 Jan 2002 15:52:09 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:40495 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S290816AbSARUv4> convert rfc822-to-8bit; Fri, 18 Jan 2002 15:51:56 -0500
Date: Fri, 18 Jan 2002 21:50:14 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Dan Malek <dan@embeddededge.com>
cc: Troy Benjegerdes <hozer@drgw.net>, "David S. Miller" <davem@redhat.com>,
        <linux-kernel@vger.kernel.org>, <mattl@mvista.com>
Subject: Re: pci_alloc_consistent from interrupt == BAD
In-Reply-To: <3C4875DB.9080402@embeddededge.com>
Message-ID: <20020118213313.R1937-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Jan 2002, Dan Malek wrote:

> Troy Benjegerdes wrote:
>
> > Somehow the docs in DMA-mappings.txt say pci_alloc_consistent is allowed from
> > interrupt, but this is a "bad thing" on at least arm and PPC non-cache
> > coherent cpus.
>
> This isn't unique to PowerPC or ARM, and has nothing to do with allocating
> page tables.
>
> I don't understand how pci_alloc_consistent could ever be claimed to work
> from an interrupt function because it actually allocates pages of memory
> for all architectures.  Anytime you call alloc_pages() (or friends) you could
> potentially block or return an error (out of memory) condition.
>
> Either option is undesirable for an interrupt function.  If your software can
> handle the case of not being able to allocate memory, then why not remove the
> complexity and do it that way all of the time?

I donnot see your point. Any software that tries to allocate from
interrupt context must be ready to handle failure, but when the allocation
does not require more than a single page, the failure should not happen
very often.

Not allocating under interrupt requires to pool everything that may be
ever needed. Speaking about Linux SCSI, you can:

1) Allocate all data structures at initialisation.
   A driver that can support 1022 IOs per HBA  for example with 2K CCB
   will allocate 2 MB even if user just uses a single CD/ROM without tagged
   commands supported.

2) Resize the CCB pool on select_queue_depth() call.
   This will allocate far less memory when only few devices will be
   attached to the BUS.

No need to say that 'sym' will never implement #1. At most I may add this
inside some #ifdef/#endif pair.

For example, on my personnal machine #1 scenario will allocate 8 MB but
actual need will be about 1 MB.

For now, I am not sure about #2 being cleanly implementable, but it looks
smarter to me. Note that I would prefer to also be able to free CCBs that
are no more needed. This will require a driver entry to be called when a
device goes away.

  Gérard.

