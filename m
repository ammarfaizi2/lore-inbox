Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbTIKOlO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbTIKOif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:38:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:13565 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261162AbTIKOhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:37:46 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Thu, 11 Sep 2003 09:37:29 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200309102155.16407.habanero@us.ibm.com> <200309110805.02334.habanero@us.ibm.com> <3F607E4F.8070200@cyberone.com.au>
In-Reply-To: <3F607E4F.8070200@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309110937.29165.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>I see Nick's balance patch as somewhat harmless, at least combined with
> >>> A3 patch.  However, one concern is that the "ping-pong" steal interval
> >>> is not really 200ms, but 200ms/(nr_cpus-1), which without A3, could
> >>> show up as a problem, especially on an 8 way box.  In addition, I do
> >>> think there's a problem with num tasks we steal.  It should not be
> >>> imbalance/2, it should be: max_load - (node_nr_running /
> >>> num_cpus_node).  If we steal any more than this, which is quite
> >>> possible with imbalance/2, then it's likely this_cpu now has too many
> >>> tasks, and some other cpu will steal again. Using *imbalance/2 works
> >>> fine on 2-way smp, but I'm pretty sure we "over steal" tasks on 4 way
> >>> and up.  Anyway, I'm getting off topic here...
> >>
> >>IIRC max_load is supposed to be the number of tasks on the runqueue
> >>being stolen from, isn't it?
> >
> >Yes, but I think I still got this wrong.  Ideally, once we finish
> > stealing, the busiest runqueue should not have more than
> > node_nr_runing/nr_cpus_node, but more importantly, this_cpu should not
> > have more than
> >node_nr_running/nr_cpus_node, so maybe it should be:
> >
> >min(a,b) where
> >a = max_load - load_average	How much we are over the load_average
> >b = load_average - this_load	How much we are under the load_average
> >load_average = node_nr_runing / nr_cpus_node.
> >node_nr_running can be summed as we look for the busiest queue, so it
> > should not be too costly.
> >if min(a,b) is neagtive (this_cpu's runqueue length was greater than
> >load_average) we don't steal at all.
>
> Oh OK you're thinking about balancing across the entire NUMA. I was just
> thinking it will eventually settle down, but you're right: its probably
> better to overdampen the balancing than to underdampen it.

Actually this is really geared towards within the node.  The goal for each cpu 
in the node (or just a non NUMA system) should be to steal just enough to 
have rq->nr_running to be nr_running()/nr_cpus.  I'm still not sure how many 
tasks we should really steal from internode balance.  

