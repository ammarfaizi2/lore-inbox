Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbWGKK6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbWGKK6b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWGKK6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:58:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58775 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751013AbWGKK6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:58:30 -0400
Date: Tue, 11 Jul 2006 03:57:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: nagar@watson.ibm.com, linux-kernel@vger.kernel.org, jlan@sgi.com,
       csturtiv@sgi.com, pj@sgi.com, balbir@in.ibm.com, sekharan@us.ibm.com,
       hadi@cyberus.ca, netdev@vger.kernel.org
Subject: Re: [Patch 6/6] per task delay accounting taskstats interface: fix
 clone skbs for each listener
Message-Id: <20060711035731.63c087b3.akpm@osdl.org>
In-Reply-To: <E1G0FU2-0002oE-00@gondolin.me.apana.org.au>
References: <20060711030524.39abc3d5.akpm@osdl.org>
	<E1G0FU2-0002oE-00@gondolin.me.apana.org.au>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 20:28:50 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> > On Tue, 11 Jul 2006 00:36:39 -0400
> > Shailabh Nagar <nagar@watson.ibm.com> wrote:
> > 
> >>       down_write(&listeners->sem);
> >>       list_for_each_entry_safe(s, tmp, &listeners->list, list) {
> >> -             ret = genlmsg_unicast(skb, s->pid);
> >> +             skb_next = NULL;
> >> +             if (!list_islast(&s->list, &listeners->list)) {
> >> +                     skb_next = skb_clone(skb_cur, GFP_KERNEL);
> > 
> > If we do a GFP_KERNEL allocation with this semaphore held, and the
> > oom-killer tries to kill something to satisfy the allocation, and the
> > killed task gets stuck on that semaphore, I wonder of the box locks up.
> 
> We do GFP_KERNEL inside semaphores/mutexes in lots of places.  So if this
> can deadlock with the oom-killer we probably should fix that, preferably
> by having GFP_KERNEL fail in that case.

This lock is special, in that it's taken on the exit() path (I think).  So
it can block tasks which are trying to exit.

But yes.  Reliable, deadlock-free oom-killing is, err, a matter of ongoing
research.

