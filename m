Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752532AbWCQGE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbWCQGE0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbWCQGE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:04:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752531AbWCQGEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:04:24 -0500
Date: Thu, 16 Mar 2006 22:01:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 006 of 13] md: Infrastructure to allow normal IO to
 continue while array is expanding.
Message-Id: <20060316220137.5820ab09.akpm@osdl.org>
In-Reply-To: <1060317044750.16084@suse.de>
References: <20060317154017.15880.patches@notabene>
	<1060317044750.16084@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
>  -	retry:
>   		prepare_to_wait(&conf->wait_for_overlap, &w, TASK_UNINTERRUPTIBLE);
>  -		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
>  +		sh = get_active_stripe(conf, new_sector, disks, pd_idx, (bi->bi_rw&RWA_MASK));
>   		if (sh) {
>  -			if (!add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK))) {
>  -				/* Add failed due to overlap.  Flush everything
>  +			if (unlikely(conf->expand_progress != MaxSector)) {
>  +				/* expansion might have moved on while waiting for a
>  +				 * stripe, so we much do the range check again.
>  +				 */
>  +				int must_retry = 0;
>  +				spin_lock_irq(&conf->device_lock);
>  +				if (logical_sector <  conf->expand_progress &&
>  +				    disks == conf->previous_raid_disks)
>  +					/* mismatch, need to try again */
>  +					must_retry = 1;
>  +				spin_unlock_irq(&conf->device_lock);
>  +				if (must_retry) {
>  +					release_stripe(sh);
>  +					goto retry;
>  +				}
>  +			}

The locking in here looks strange.  We take the lock, do some arithmetic
and some tests and then drop the lock again.  Is it not possible that the
result of those tests now becomes invalid?

