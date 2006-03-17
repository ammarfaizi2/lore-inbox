Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752549AbWCQGZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752549AbWCQGZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbWCQGZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:25:29 -0500
Received: from cantor.suse.de ([195.135.220.2]:35459 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752541AbWCQGZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:25:28 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 17:24:11 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17434.22027.100178.665781@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 005 of 13] md: Allow stripes to be expanded in
 preparation for expanding an array.
In-Reply-To: message from Andrew Morton on Thursday March 16
References: <20060317154017.15880.patches@notabene>
	<1060317044745.16072@suse.de>
	<20060316215739.2b11cb82.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 16, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> > +	/* Got them all.
> >  +	 * Return the new ones and free the old ones.
> >  +	 * At this point, we are holding all the stripes so the array
> >  +	 * is completely stalled, so now is a good time to resize
> >  +	 * conf->disks.
> >  +	 */
> >  +	ndisks = kzalloc(newsize * sizeof(struct disk_info), GFP_NOIO);
> >  +	if (ndisks) {
> >  +		for (i=0; i<conf->raid_disks; i++)
> >  +			ndisks[i] = conf->disks[i];
> >  +		kfree(conf->disks);
> >  +		conf->disks = ndisks;
> >  +	} else
> >  +		err = -ENOMEM;
> >  +	while(!list_empty(&newstripes)) {
> >  +		nsh = list_entry(newstripes.next, struct stripe_head, lru);
> >  +		list_del_init(&nsh->lru);
> >  +		for (i=conf->raid_disks; i < newsize; i++)
> >  +			if (nsh->dev[i].page == NULL) {
> >  +				struct page *p = alloc_page(GFP_NOIO);
> >  +				nsh->dev[i].page = p;
> >  +				if (!p)
> >  +					err = -ENOMEM;
> >  +			}
> >  +		release_stripe(nsh);
> >  +	}
> >  +	while(!list_empty(&oldstripes)) {
> >  +		osh = list_entry(oldstripes.next, struct stripe_head, lru);
> >  +		list_del(&osh->lru);
> >  +		kmem_cache_free(conf->slab_cache, osh);
> >  +	}
> >  +	kmem_cache_destroy(conf->slab_cache);
> >  +	conf->slab_cache = sc;
> >  +	conf->active_name = 1-conf->active_name;
> >  +	conf->pool_size = newsize;
> >  +	return err;
> >  +}
> 
> Are you sure the -ENOMEM handling here is solid?  It
> looks.... strange.

The philosophy of the -ENOMEM handling is (awkwardly?) embodied in the
comment
	 * Finally we add new pages.  This could fail, but we leave
	 * the stripe cache at it's new size, just with some pages empty.

at the top of the function.  The core function here is making some
data structures bigger.  In each case, having a bigger data structure
than required is no big deal.  So we try to increase the size of each
of them (the stripe_head cache, the 'disks' array, and the pages
allocated to each stripe.
If any of there fail we return -ENOMEM, but may allow others to
succeed.

Does that help?

NeilBrown
