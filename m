Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWFMIh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWFMIh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 04:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWFMIh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 04:37:29 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:17029 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750772AbWFMIh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 04:37:28 -0400
Message-ID: <448E79DA.8050704@bull.net>
Date: Tue, 13 Jun 2006 10:39:54 +0200
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: =?ISO-8859-15?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
Cc: Jakub Jelinek <jakub@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: NPTL mutex and the scheduling priority
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>	 <1150115008.3131.106.camel@laptopd505.fenrus.org>	 <20060612124406.GZ3115@devserv.devel.redhat.com> <1150125869.3835.12.camel@frecb000686>
In-Reply-To: <1150125869.3835.12.camel@frecb000686>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/06/2006 10:41:10,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 13/06/2006 10:41:11,
	Serialize complete at 13/06/2006 10:41:11
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sébastien Dugué a écrit :
>   But maybe a better solution for condvars would be to implement
> something like a futex_requeue_pi() to handle the broadcast and
> only use PI futexes all along in glibc.
> 
>   Any ideas?

I'm currently thinking about it, and as far as I can see, it should be
technically feasible but not obvious.
In fact, PI-futex adds a rt-mutex behind each futex, when there are some
waiters. Each waiter is then queued two times: once in the chain list of
the hash-bucket, once in the (ordered) wait_list of the rt-mutex.

What we want, with a futex_requeue_pi, is a requeue of some tasks from
(futex1, rt_mutex1) to (futex2, rt_mutex2), respecting the wait_list
order of rt_mutex1.wait-list.
=> this needs something like a rt_mutex_requeue, and given an element of
rt_mutex1.wait_list, we need to retrieve its futex_q to requeue it to
the second hash-bucket chain (of futex2).

Moreover, we must take care of the case where the futex2 is not yet
locked (i.e. has no owner): there is not yet a pi_state nor a rt_mutex
associated with the futex2 ...

And during all of this, we must take care of several race conditions in
several places.

I'll continue my investigation, but I really wonder if futex_requeue_pi
will still be an "optimization" as it should be.

So comments from the experts are welcome ;-)

-- 
Pierre

