Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752542AbWCQGS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbWCQGS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbWCQGS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:18:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:47506 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752538AbWCQGS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:18:26 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 17 Mar 2006 17:17:08 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17434.21604.687323.519646@cse.unsw.edu.au>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 006 of 13] md: Infrastructure to allow normal IO to
 continue while array is expanding.
In-Reply-To: message from Andrew Morton on Thursday March 16
References: <20060317154017.15880.patches@notabene>
	<1060317044750.16084@suse.de>
	<20060316220137.5820ab09.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 16, akpm@osdl.org wrote:
> NeilBrown <neilb@suse.de> wrote:
> >
> >  -	retry:
> >   		prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
> >  -		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
> >  +		sh = get_active_stripe(conf, new_sector, disks, pd_idx, (bi->bi_rw&RWA_MASK));
> >   		if (sh) {
> >  -			if (!add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK))) {
> >  -				/* Add failed due to overlap.  Flush everything
> >  +			if (unlikely(conf->expand_progress != MaxSector)) {
> >  +				/* expansion might have moved on while waiting for a
> >  +				 * stripe, so we much do the range check again.
> >  +				 */
> >  +				int must_retry = 0;
> >  +				spin_lock_irq(&conf->device_lock);
> >  +				if (logical_sector <  conf->expand_progress &&
> >  +				    disks == conf->previous_raid_disks)
> >  +					/* mismatch, need to try again */
> >  +					must_retry = 1;
> >  +				spin_unlock_irq(&conf->device_lock);
> >  +				if (must_retry) {
> >  +					release_stripe(sh);
> >  +					goto retry;
> >  +				}
> >  +			}
> 
> The locking in here looks strange.  We take the lock, do some arithmetic
> and some tests and then drop the lock again.  Is it not possible that the
> result of those tests now becomes invalid?

Obviously another comment missing.
 conf->expand_progress is sector_t and so could be 64bits on a 32 bit
 platform, and so I cannot be sure it is updated atomically.  So I
 always access it within a lock (unless I am comparing for equality with ~0).
 
 Yes, the result can become invalid, but only in one direction:  As
 expand_progress always increases, it is possible that it will pass
 logical_sector.  When that happens, STRIPE_EXPANDING gets set on the
 stripe_head at logical_sector.
 So because we took a reference to logical_sector *before* this test,
 and check for stripe_expanding *after* the test, we can easily catch
 that transition.

 Putting it another way, this test is to catch cases where
 logical_sector is a long way from expand_progress, the subsequent
 test of STRIPE_EXPANDING catches cases where they are close together,
 and the ordering wrt get_stripe_active ensures there are no holes.

Now to put that into a few short-but-clear comments.

Thanks again!

NeilBrown
