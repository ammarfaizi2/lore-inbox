Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261582AbVEJI2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbVEJI2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 04:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVEJI2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 04:28:16 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:43193 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261582AbVEJI2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 04:28:09 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
From: Alexander Nyberg <alexn@dsv.su.se>
To: Jens Axboe <axboe@suse.de>
Cc: Andi Kleen <ak@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050510061858.GB21649@suse.de>
References: <200505092239.37834.rjw@sisk.pl>
	 <20050509205251.GK25167@wotan.suse.de>  <20050510061858.GB21649@suse.de>
Content-Type: text/plain
Date: Tue, 10 May 2005 10:28:06 +0200
Message-Id: <1115713686.918.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tis 2005-05-10 klockan 08:18 +0200 skrev Jens Axboe:
> On Mon, May 09 2005, Andi Kleen wrote:
> > On Mon, May 09, 2005 at 10:39:37PM +0200, Rafael J. Wysocki wrote:
> > > Hi,
> > > 
> > > I get this from 2.6.12-rc3-mm3 on a UP AMD64 box (Asus L5D), 100% of the time:
> > 
> > Probably a generic bug. Block layer is passing some slab flag slab
> > doesn't like.
> 
> Some slab change, perhaps? There's nothing special about the init_bio()
> slab call:
> 
>         bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
>                             SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);
> 
> 
> Hmm, this looks strange. That bug happens if:
> 
>         if ((!name) ||
>                 in_interrupt() ||
>                 (size < BYTES_PER_WORD) ||
>                 (size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
>                 (dtor && !ctor)) {
>                         printk(KERN_ERR "%s: Early error in slab %s\n",
>                                         __FUNCTION__, name);
>                         BUG();
>                 }
> 
> It must be in_interrupt() triggering, perhaps something change in the
> boot sequence?
> 

The funny thing is that it seems to be the name being NULL, from the
original post:
kmem_cache_create: Early error in slab <NULL>

When looking at the code I really can't see how that can be. Rafael,
what setup is this compiled under?

