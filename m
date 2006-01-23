Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964941AbWAWVJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWAWVJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 16:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWAWVJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 16:09:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44181 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964941AbWAWVJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 16:09:13 -0500
Date: Mon, 23 Jan 2006 21:09:01 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 2/9] device-mapper log bitset: fix endian
Message-ID: <20060123210901.GL4280@agk.surrey.redhat.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20060120211300.GC4724@agk.surrey.redhat.com> <20060122213741.7d2ed8ef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122213741.7d2ed8ef.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 09:37:41PM -0800, Andrew Morton wrote:
> Alasdair G Kergon <agk@redhat.com> wrote:
> >
> >  -	set_bit(bit, (unsigned long *) bs);
> >  +	ext2_set_bit(bit, (unsigned long *) bs);
 
> ext2_set_bit() is non-atomic, so the above code must provide its own
> locking against other CPUs (and threads, if preempt) performing
> modification of this memory.
> 
> Is such locking present?  If not, we should use ext2_set_bit_atomic(). 
> (And if so, the old code could have used __set_bit)

As far as I can tell, all the sets and clears happen from the same 
single-threaded workqueue, but one mirror_map() could run alongside:

        r = ms->rh.log->type->in_sync(ms->rh.log,
                                      bio_to_region(&ms->rh, bio), 0);

which uses:
        ext2_test_bit(bit, (unsigned long *) bs) ? 1 : 0;

So far I haven't found any races here that would cause problems.
(And if there are any, they're probably wider than just making
those operations atomic.)

And it also looks like this code doesn't handle barriers correctly...

Alasdair
-- 
agk@redhat.com
