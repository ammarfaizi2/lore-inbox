Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUDCN1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 08:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUDCN1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 08:27:38 -0500
Received: from mail.shareable.org ([81.29.64.88]:43670 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261744AbUDCN1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 08:27:36 -0500
Date: Sat, 3 Apr 2004 14:27:25 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@suse.cz>
Cc: andersen@codepoet.org,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, mj@ucw.cz,
       jack@ucw.cz, "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cowlinks v2
Message-ID: <20040403132725.GB4706@mail.shareable.org>
References: <20040402165440.GB24861@wohnheim.fh-wedel.de> <20040402180128.GA363@elf.ucw.cz> <20040402181707.GA28112@wohnheim.fh-wedel.de> <20040402182357.GB410@elf.ucw.cz> <20040402200921.GC653@mail.shareable.org> <20040402213933.GB246@elf.ucw.cz> <20040403010425.GJ653@mail.shareable.org> <20040403012112.GA6499@codepoet.org> <20040403015920.GA2857@mail.shareable.org> <20040403090917.GD1316@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040403090917.GD1316@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> > > > Here's a tricky situation:
> > > > 
> > > >    1. A file is cowlinked.  Then each cowlink is mmap()'d, one per process.
> > > > 
> > > >    2. At this point both mappings share the same pages in RAM.
> > > > 
> > > >    3. Then one of the cowlinks is written to...
> > > 
> > > Using mmap with PROT_WRITE on a cowlink must preemptively
> > > break the link.
> > 
> > I forget to mention, they are PROT_READ shared mappings.
> 
> I'm not mm guru, but... with rmap, we should be able to find all the
> users of that shared memory, and unmap their pages, right?

Yes.  I bring it up only because it's tricky, and the simple cowlink
implementations so far don't deal with it.

A page can only exist in one address_space.  So if pages are shared
before the cow is broken, the address_space must be of the shared
cowid object, not an individual address_space per cowlink.
Afterwards, the copied pages are in the non-shared cowlink object's
address_space.

> Until copy is done, we don't do anything, because write is not allowed
> to progress until copy is done. When copy is done we should unmap all
> the pages that still point to "old" copy, let write progress, and make
> users fault in.

I agree.

(Ross suggested using COW pages.  While technically possible, that
would be pretty complicated to implemented as it implies pages shared
among more than one address_space, and the facility for write() to
break COW sharing in the page cache, and update page tables when that
happens.)

-- Jamie
