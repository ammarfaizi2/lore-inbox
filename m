Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265499AbUABK7Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 05:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265505AbUABK7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 05:59:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12480 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265499AbUABK7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 05:59:22 -0500
Date: Fri, 2 Jan 2004 11:59:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: arjanv@redhat.com, Andrew Morton <akpm@osdl.org>, packet-writing@suse.com,
       linux-kernel@vger.kernel.org
Subject: Re: ext2 on a CD-RW
Message-ID: <20040102105915.GO5523@suse.de>
References: <Pine.LNX.4.44.0401020022060.2407-100000@telia.com> <20040101162427.4c6c020b.akpm@osdl.org> <m2llorkuhn.fsf@telia.com> <1073034412.4429.1.camel@laptop.fenrus.com> <m2k74a8vyr.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2k74a8vyr.fsf@telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02 2004, Peter Osterlund wrote:
> Arjan van de Ven <arjanv@redhat.com> writes:
> 
> > On Fri, 2004-01-02 at 02:30, Peter Osterlund wrote:
> > 
> > > The packet writing code has the restriction that a bio must not span a
> > > packet boundary. (A packet is 32*2048 bytes.) If the page when mapped
> > > to disk starts 2kb before a packet boundary, merge_bvec_fn therefore
> > > returns 2048, which is less than len, which is 4096 if the whole page
> > > is mapped, so the bio_add_page() call fails.
> > 
> > devicemapper has similar restrictions for raid0 format; in that case
> > it's device-mappers job to split the page/bio. Just as it is UDF's task
> > to do the same I suspect...
> 
> Old versions of the packet writing code did just that, but Jens told
> me that bio splitting was evil, so when the merge_bvec_fn
> functionality was added to the kernel, I started to use it.
> 
>         http://lists.suse.com/archive/packet-writing/2002-Aug/0044.html

Splitting is evil, but unfortunately it's a necessary evil... There are
a few kernel helpers to make supporting it easier (see bio_split()). Not
so sure how well that'll work for you, you may have to do the grunt work
yourself.

> If merge_bvec_fn is not supposed to be able to handle the need of the
> packet writing code, I can certainly resurrect my bio splitting code.

Only partially. Read my email: you _must_ accept a page addition to an
empty bio. You can refuse others. For the single page case, you may need
to split.

> Btw, for some reason, this bug is not triggered when using the UDF
> filesystem on a CDRW. I've only seen it with the ext2 filesystem.

Does UDF use mpage? The fact that it doesn't trigger on UDF doesn't mean
that packet writing isn't breaking the API :)

-- 
Jens Axboe

