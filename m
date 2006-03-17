Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752533AbWCQGGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbWCQGGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbWCQGGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:06:07 -0500
Received: from ns2.suse.de ([195.135.220.15]:2194 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752533AbWCQGGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:06:05 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 17:04:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17434.20864.926514.729680@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 005 of 13] md: Allow stripes to be expanded in
 preparation for expanding an array.
In-Reply-To: message from Andrew Morton on Thursday March 16
References: <20060317154017.15880.patches@notabene>
	<1060317044745.16072@suse.de>
	<20060316215047.65f411d4.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 16, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> > +static int resize_stripes(raid5_conf_t *conf, int newsize)
> >  +{
> >  +	/* make all the stripes able to hold 'newsize' devices.
> >  +	 * New slots in each stripe get 'page' set to a new page.
> >  +	 * We allocate all the new stripes first, then if that succeeds,
> >  +	 * copy everything across.
> >  +	 * Finally we add new pages.  This could fail, but we leave
> >  +	 * the stripe cache at it's new size, just with some pages empty.
> >  +	 *
> >  +	 * We use GFP_NOIO allocations as IO to the raid5 is blocked
> >  +	 * at some points in this operation.
> >  +	 */
> >  +	struct stripe_head *osh, *nsh;
> >  +	struct list_head newstripes, oldstripes;
> 
> You can use LIST_HEAD() here, avoid the separate INIT_LIST_HEAD().
> 

I guess.....
I have to have the declaration "miles" from where I use the variable.
Do I have to have the initialisation equally far?  Ok, I'll do that..


> 
> >  +	struct disk_info *ndisks;
> >  +	int err = 0;
> >  +	kmem_cache_t *sc;
> >  +	int i;
> >  +
> >  +	if (newsize <= conf->pool_size)
> >  +		return 0; /* never bother to shrink */
> >  +
> >  +	sc = kmem_cache_create(conf->cache_name[1-conf->active_name],
> >  +			       sizeof(struct stripe_head)+(newsize-1)*sizeof(struct r5dev),
> >  +			       0, 0, NULL, NULL);
> 
> kmem_cache_create() internally does a GFP_KERNEL allocation.
> 
> >  +	if (!sc)
> >  +		return -ENOMEM;
> >  +	INIT_LIST_HEAD(&newstripes);
> >  +	for (i = conf->max_nr_stripes; i; i--) {
> >  +		nsh = kmem_cache_alloc(sc, GFP_NOIO);
> 
> So either this can use GFP_KERNEL, or we have a problem.

Good point....  Maybe the comment about GFP_NOIO just needs to be
improved. 
We cannot risk waiting on IO after the 
	/* OK, we have enough stripes, start collecting inactive
	 * stripes and copying them over
	 */

comment, up to the second last while loop, that starts
	while(!list_empty(&newstripes)) {

Before the comment, which where the kmem_cache_create is, is OK.

Thanks!

NeilBrown

