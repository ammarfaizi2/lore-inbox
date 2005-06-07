Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261877AbVFGStr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVFGStr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVFGStr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 14:49:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9131 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261877AbVFGStn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 14:49:43 -0400
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Morton Andrew Morton <akpm@osdl.org>, awilliam@fc.hp.com, greg@kroah.com,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Bodo Eggert <7eggert@gmx.de>, stern@rowland.harvard.edu,
       bjorn.helgaas@hp.com
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
References: <1118113637.42a50f65773eb@imap.linux.ibm.com>
	<20050607050727.GB12781@colo.lackof.org>
	<m1slzuwkqx.fsf@ebiederm.dsl.xmission.com>
	<20050607162143.GE29220@colo.lackof.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2005 12:42:42 -0600
In-Reply-To: <20050607162143.GE29220@colo.lackof.org>
Message-ID: <m1acm2vwil.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler <grundler@parisc-linux.org> writes:

> On Tue, Jun 07, 2005 at 03:59:18AM -0600, Eric W. Biederman wrote:
> > > *lots* of PCI devices predate PCI2.3. Possibly even the majority.
> > 
> > In general generic hardware bits for disabling DMA, disabling interrupts
> > and the like are all advisory.  With the current architecture things
> > will work properly even if you don't manage to disable DMA (assuming
> > you don't reassign IOMMU entries at least).
> 
> ISTR, pSeries (IBM), some alpha, some sparc64, and parisc (64-bit) require
> use of the IOMMU for *any* DMA. ie IOMMU entries need to be programmed.
> Probably want to make a choice to ignore those arches for now
> or sort out how to deal with an IOMMU.

The howto deal with an IOMMU has been sorted out but so far no one 
has actually done it.  What has been discussed previously is simply
reserving a handful of IOMMU entries, and then only using those
in the crash recover kernel.  This is essentially what we do with DMA
on architectures that don't have an IOMMU and it seems quite safe
enough there.

> > Shared interrupts are an interesting case.  The simplest solution I can
> > think of for a crash dump capture kernel is to periodically poll
> > the hardware, as if all interrupts are shared.  At that level
> > I think we could get away with ignoring all hardware interrupt sources.
> 
> Yes, that's perfectly ok. We are no longer in a multitasking env.

Well we are at least capable of multitasking but that is no longer the
primary focus.  Having polling as at least an option should make
debugging easier.  Last I looked Andrews kernel hand an irqpoll option
to do something very like this.

> > Does anyone know of a anything that would break by always polling
> > the hardware?  I guess there could be a problem with drivers
> > that don't understand shared interrupts, are there enough of those
> > to be an issue.
> 
> PCI requires drivers support Shared IRQs.
> A few oddballs might be broken but I expect networking/mass storage
> drivers get this right.

Agreed.  Which means any drivers we really need for dumping the system
should be fine.  If the drivers don't work in that mode at least the
concept of fixing it won't be controversial.


Eric
