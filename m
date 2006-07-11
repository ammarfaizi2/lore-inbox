Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWGKLPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWGKLPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWGKLPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:15:49 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:60177 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751037AbWGKLPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:15:48 -0400
Date: Tue, 11 Jul 2006 21:15:25 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: nagar@watson.ibm.com, linux-kernel@vger.kernel.org, jlan@sgi.com,
       csturtiv@sgi.com, pj@sgi.com, balbir@in.ibm.com, sekharan@us.ibm.com,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [Patch 6/6] per task delay accounting taskstats interface: fix clone skbs for each listener
Message-ID: <20060711111525.GA11175@gondor.apana.org.au>
References: <20060711030524.39abc3d5.akpm@osdl.org> <E1G0FU2-0002oE-00@gondolin.me.apana.org.au> <20060711035731.63c087b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711035731.63c087b3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 03:57:31AM -0700, Andrew Morton wrote:
>
> > >>       down_write(&listeners->sem);
> > >>       list_for_each_entry_safe(s, tmp, &listeners->list, list) {
> > >> -             ret = genlmsg_unicast(skb, s->pid);
> > >> +             skb_next = NULL;
> > >> +             if (!list_islast(&s->list, &listeners->list)) {
> > >> +                     skb_next = skb_clone(skb_cur, GFP_KERNEL);
> > > 
> > > If we do a GFP_KERNEL allocation with this semaphore held, and the
> > > oom-killer tries to kill something to satisfy the allocation, and the
> > > killed task gets stuck on that semaphore, I wonder of the box locks up.
> > 
> > We do GFP_KERNEL inside semaphores/mutexes in lots of places.  So if this
> > can deadlock with the oom-killer we probably should fix that, preferably
> > by having GFP_KERNEL fail in that case.
> 
> This lock is special, in that it's taken on the exit() path (I think).  So
> it can block tasks which are trying to exit.

Sorry, missed the context.

If there is a deadlock then it's not just this allocation that you
need worry about.  There is also an allocation within genlmsg_uniast
that would be GFP_KERNEL.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
