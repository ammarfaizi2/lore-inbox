Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261565AbVEJGUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261565AbVEJGUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 02:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbVEJGUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 02:20:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:23769 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261552AbVEJGTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 02:19:01 -0400
Date: Tue, 10 May 2005 08:18:58 +0200
From: Jens Axboe <axboe@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG][Resend] 2.6.12-rc3-mm3: Kernel BUG at "mm/slab.c":1219
Message-ID: <20050510061858.GB21649@suse.de>
References: <200505092239.37834.rjw@sisk.pl> <20050509205251.GK25167@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050509205251.GK25167@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09 2005, Andi Kleen wrote:
> On Mon, May 09, 2005 at 10:39:37PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > I get this from 2.6.12-rc3-mm3 on a UP AMD64 box (Asus L5D), 100% of the time:
> 
> Probably a generic bug. Block layer is passing some slab flag slab
> doesn't like.

Some slab change, perhaps? There's nothing special about the init_bio()
slab call:

        bio_slab = kmem_cache_create("bio", sizeof(struct bio), 0,
                            SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL, NULL);


Hmm, this looks strange. That bug happens if:

        if ((!name) ||
                in_interrupt() ||
                (size < BYTES_PER_WORD) ||
                (size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
                (dtor && !ctor)) {
                        printk(KERN_ERR "%s: Early error in slab %s\n",
                                        __FUNCTION__, name);
                        BUG();
                }

It must be in_interrupt() triggering, perhaps something change in the
boot sequence?

-- 
Jens Axboe

