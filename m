Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTA2P3P>; Wed, 29 Jan 2003 10:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbTA2P3P>; Wed, 29 Jan 2003 10:29:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54947 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261963AbTA2P3O>;
	Wed, 29 Jan 2003 10:29:14 -0500
Date: Wed, 29 Jan 2003 16:38:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE: Do not call bh_phys() on buffers with invalid b_page.
Message-ID: <20030129153820.GF31566@suse.de>
References: <1043852266.1690.63.camel@zion.wanadoo.fr> <20030129150000.GD31566@suse.de> <1043853614.1668.70.camel@zion.wanadoo.fr> <20030129152214.GE31566@suse.de> <1043853975.1668.74.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043853975.1668.74.camel@zion.wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29 2003, Benjamin Herrenschmidt wrote:
> On Wed, 2003-01-29 at 16:22, Jens Axboe wrote:
> 
> > Ehm no, if b_data is < PAGE_SIZE, it's probably an offset and not a
> > valid address. So it should be exactly where it is -- for b_page, it's
> > _not_ buggy for b_data to be < PAGE_SIZE. That's expected. Submitter
> > would have to be buggy for it to trigger, though, so you can just remove
> > it if you want.
> 
> Ah, I see what you wanted to check now :) Ok, I won't remove it, though
> it would still make sense to extend the test to PAGE_OFFSET I beleive,
> any b_data < PAGE_OFFSET is wrong.

No, any b_data < PAGE_OFFSET is not wrong, that's the point. For highmem
b_page, b_data will be the offset into the page. So it could be 2048,
for instance.

The test is meant to catch an invalid buffer_head, where b_page is not
set but b_data isn't valid either. So to make it complete, you could do:

	if (bh->b_page) {
		...
		if (bh->b_data >= PAGE_SIZE)
			BUG();
	} else {
		...
		if (bh->b_data < PAGE_SIZE)
			BUG();
		if (bh->b_data < PAGE_OFFSET)
			BUG();
	}

as they are two different bugs.

> Anyway, let's leave 2.4 as it is now.

:-)

-- 
Jens Axboe

