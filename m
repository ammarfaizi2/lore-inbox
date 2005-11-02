Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965265AbVKBVgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965265AbVKBVgw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 16:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965264AbVKBVgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 16:36:52 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:58005 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S965267AbVKBVgv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 16:36:51 -0500
Subject: Re: New bug in patch and existing Linux code - race with
	install_page() (was: Re: [PATCH] 2.6.14 patch for supporting
	madvise(MADV_REMOVE))
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, dvhltc@us.ibm.com,
       linux-mm <linux-mm@kvack.org>, Jeff Dike <jdike@addtoit.com>
In-Reply-To: <200511022054.15119.blaisorblade@yahoo.it>
References: <1130366995.23729.38.camel@localhost.localdomain>
	 <20051102014321.GG24051@opteron.random>
	 <1130947957.24503.70.camel@localhost.localdomain>
	 <200511022054.15119.blaisorblade@yahoo.it>
Content-Type: text/plain
Date: Wed, 02 Nov 2005 13:36:23 -0800
Message-Id: <1130967383.24503.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-02 at 20:54 +0100, Blaisorblade wrote:
> On Wednesday 02 November 2005 17:12, Badari Pulavarty wrote:
> > Hi Andrew & Andrea,
> >
> > Here is the updated patch with name change again :(
> > Hopefully this would be final. (MADV_REMOVE).
> >
> > BTW, I am not sure if we need to hold i_sem and i_allocsem
> > all the way ? I wanted to be safe - but this may be overkill ?
> While looking into this, I probably found another problem, a race with 
> install_page(), which doesn't use the seqlock-style check we use for 
> everything else (aka do_no_page) but simply assumes a page is valid if its 
> index is below the current file size.
> 
> This is clearly "truncate" specific, and is already racy. Suppose I truncate a 
> file and reduce its size, and then re-extend it, the page which I previously 
> fetched from the cache is invalid. The current install_page code generates 
> corruption.
> 
> In fact the page is fetched from the caller of install_page and passed to it.
> 
> This affects anybody using MAP_POPULATE or using remap_file_pages.
> 
> > +       /* XXX - Do we need both i_sem and i_allocsem all the way ? */
> > +       down(&inode->i_sem);
> > +       down_write(&inode->i_alloc_sem);
> > +       unmap_mapping_range(mapping, offset, (end - offset), 1);
> In my opinion, as already said, unmap_mapping_range can be called without 
> these two locks, as it operates only on mappings for the file.
> 
> However currently it's called with these locks held in vmtruncate, but I think 
> the locks are held in that case only because we need to truncate the file, 
> and are hold in excess also across this call.

I agree, I can push down the locking only for ->truncate_range - if
no one has objections. (But again, it so special case - no one really
cares about the performance of this interface ?).

Thanks,
Badari

