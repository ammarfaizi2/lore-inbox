Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbVBCKsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbVBCKsn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVBCKok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:44:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36482 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262927AbVBCKlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:41:45 -0500
To: Hirokazu Takahashi <taka@valinux.co.jp>
Cc: vgoyal@in.ibm.com, akpm@osdl.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com, hari@in.ibm.com,
       suparna@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<20050203.160252.104031714.taka@valinux.co.jp>
	<m1zmym6m6z.fsf@ebiederm.dsl.xmission.com>
	<20050203.191039.39155205.taka@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 03:39:37 -0700
In-Reply-To: <20050203.191039.39155205.taka@valinux.co.jp>
Message-ID: <m18y666i6u.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hirokazu Takahashi <taka@valinux.co.jp> writes:

> Hi Eric,
> 
> > > Hi Vivek and Eric,
> > > 
> > > IMHO, why don't we swap not only the contents of the top 640K
> > > but also kernel working memory for kdump kernel?
> > > 
> > > I guess this approach has some good points.
> > > 
> > >  1.Preallocating reserved area is not mandatory at boot time.
> > >    And the reserved area can be distributed in small pieces
> > >    like original kexec does.
> > > 
> > >  2.Special linking is not required for kdump kernel.
> > >    Each kdump kernel can be linked in the same way,
> > >    where the original kernel exists.
> > > 
> > > Am I missing something?
> > 
> > Preallocating the reserved area is largely to keep it from
> > being the target of DMA accesses.  Since we are not able
> > to shutdown any of the drivers in the primary kernel running
> > in a normal swath of memory sounds like a good way to get
> > yourself stomped at the worst possible time.
> 
> So what do you think my another idea?

I have proposed it.  I think ia64 already does that.
It has been pointed that the PowerPC kernel occasionally runs
with the mmu turned off. So it is not a technique the is 100%
portable.
 
> I think we can always make a kdump kernel mapped to the same virtual
> address. So we will be free from caring about the physical address
> where the kdump kernel is loaded.
> 
> I believe the memsection functionality which LHMS project is working
> on would help this.

You don't need anything fancy except to build the page tables
during bootup.  However there are a few potential gotchas
with respect to using large pages, that can give 4MiB or
greater alignment restrictions on the kernel.  Code wise
the gotcha is moving the kernel's .text section into what
is essentially the vmalloc portion of the address space.
For x86_64 the kernels virtual address is already decoupled from the
physical addresses, so it is probably easier.

Most of this just results in easier management between the pieces.
Which is a good thing.  However at the moment I don't think it
simplifies any of the core problems.  I still need to reserve
a large hunk of physical address space early on before any
DMA transactions are setup to hold the new kernel.

So while I am happy to see patches that improve this I don't
actually care right now.

Eric
