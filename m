Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUC3V1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbUC3V1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:27:38 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26060
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261258AbUC3V1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:27:37 -0500
Date: Tue, 30 Mar 2004 23:27:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040330212735.GJ3808@dualathlon.random>
References: <20040329184550.GA4540@in.ibm.com> <20040329222926.GF3808@dualathlon.random> <20040330144324.GA3778@in.ibm.com> <20040330195315.GB3773@in.ibm.com> <20040330204731.GG3808@dualathlon.random> <20040330210648.GB3956@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040330210648.GB3956@in.ibm.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 02:36:48AM +0530, Dipankar Sarma wrote:
> Not necessarily, we can do a call_rcu_bh() just for softirqs with 
> softirq handler completion as a quiescent state. That will likely
> help with the route cache overflow problem atleast.

cute, I like this. You're right all we care about is a quiscient point
against softirq context (this should work fine against regular kernel
context under local_bh_disable too).  This really sounds a smart and
optimal and finegriend solution to me.  The only thing I'm concerned
about is if it slowdown further the fast paths, but I can imagine that
you can implement it purerly with tasklets and no change to the fast
paths (I mean, I wouldn't enjoy further instrumentations like the stuff
you had to add to the scheduler especially in the preempt case). I mean,
you've just to run 1 magic takklet per cpu then you declare the
quiscient point. The only annoyance will be the queueing of these
tasklets in every cpu, that may need IPIs or some nasty locking. Of
course we should use the higher prio tasklets, so they run before the
other softirqs.

Is this the suggestion from Alexey or did he suggest something else? the
details of his suggestion weren't clear to me.

after call_rcu_bh everything else w.r.t. softirq/scheduler will return
low prio. I mean, the everything else will return a "irq load
(hardirq+softirq) runs on top of kernel context and they're not
accounted by the scheduler" like it has always been in the last thousand
kernel releases ;) that may need solving eventually, but still the
routing cache sounds optimal with the call_rcu_bh.
