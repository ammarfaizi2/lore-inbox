Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUCaHiQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 02:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUCaHiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 02:38:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48073 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261797AbUCaHiO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 02:38:14 -0500
Date: Wed, 31 Mar 2004 13:06:30 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dave Miller <davem@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040331073630.GA3681@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329184550.GA4540@in.ibm.com> <20040329222926.GF3808@dualathlon.random> <20040330144324.GA3778@in.ibm.com> <20040330195315.GB3773@in.ibm.com> <20040330204731.GG3808@dualathlon.random> <16489.59080.303710.986410@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16489.59080.303710.986410@robur.slu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2004 at 11:29:44PM +0200, Robert Olsson wrote:
> Andrea Arcangeli writes:
>  > I see what's going on now, yes my patch cannot help. the workload is
>  > simply generating too much hardirq load, and it's like if we don't use
>  > softirq at all but that we process the packet inside the hardirq for
>  > this matter. As far as RCU is concerned it's like if there a no softirq
>  > at all but that we process everything in the hardirq.
>  > 
>  > so what you're looking after is a new feature then:
>  > 
>  > 1) rate limit the hardirqs
>  > 2) rate limit only part of the irq load (i.e. the softirq, that's handy
>  >    since it's already splitted out) to scheduler-aware context (not
>  >    inside irq context anymore)
>  > 3) stop processing packets in irqs in the first place (NAPI or similar)
> 
>  No Andrea it pure softirq workload. Interfaces runs with irq disabled 
>  at this load w. NAPI. Softirq's are run from spin_unlock_bh etc when 
>  doing route lookup and GC. And the more fine-grained locking we do the 
>  the more do_softirq's are run.

Not lookup, we don't take the lock in lookup. Probably route 
insertions which will happen very frequently in this case.

Thanks
Dipankar
