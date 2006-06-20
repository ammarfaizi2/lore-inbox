Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932556AbWFTJ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWFTJ4o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFTJ4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:56:43 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59857 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932556AbWFTJ4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:56:43 -0400
Date: Tue, 20 Jun 2006 11:51:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       ccb@acm.org, linux-kernel@vger.kernel.org,
       Peter Chubb <peter@chubb.wattle.id.au>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch] increase spinlock-debug looping timeouts (write_lock and NMI)
Message-ID: <20060620095135.GC11037@elte.hu>
References: <fa.VT2rwoX1M/2O/aO5crhlRDNx4YA@ifi.uio.no> <fa.Zp589GPrIISmAAheRowfRgZ1jgs@ifi.uio.no> <Pine.LNX.4.61.0606192231380.25413@osa.unixfolk.com> <20060619233947.94f7e644.akpm@osdl.org> <4497A5BC.4070005@yahoo.com.au> <20060620083305.GB7899@elte.hu> <4497C1BC.9090601@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4497C1BC.9090601@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Ingo Molnar wrote:
> >curious, do you have any (relatively-) simple to run testcase that 
> >clearly shows the "scalability issues" you mention above, when going 
> >from rwlocks to spinlocks? I'd like to give it a try on an 8-way box.
> 
> Arjan van de Ven wrote:
> > I'm curious what scalability advantage you see for rw spinlocks vs real
> > spinlocks ... since for any kind of moderate hold time the opposite is
> > expected ;)
> 
> It actually surprised me too, but Peter Chubb (who IIRC provided the 
> motivation to merge the patch) showed some fairly significant 
> improvement at 12-way.
> 
> https://www.gelato.unsw.edu.au/archives/scalability/2005-March/000069.html

i think that workload wasnt analyzed well enough (by us, not by Peter, 
who sent a reasonable analysis and suggested a reasonable change), and 
we went with whatever magic change appeared to make a difference, 
without fully understanding the underlying reasons. Quote:

  "I'm not sure what's happening in the 4-processor case."

Now history appears to be repeating itself, just in the other direction 
;) And we didnt get one inch closer to understanding the situation for 
real. I'd vote for putting a change-moratorium on tree-lock and only 
allow a patch that tweaks it that fully analyzes the workload :-)

one thing off the top of my mind: doesnt lockstat introduce significant 
overhead? Is this reproducable with lockstat turned off too? Is the same 
scalability problem visible if all read_lock()s are changed to 
write_lock()? [like i did in my patch] I.e. can other explanations (like 
unlucky alignment of certain rwlock data structures / functions) be 
excluded.

another thing: average hold times in the spinlock case on that workload 
are below 1 microsecond - probably on the range of cachemiss bounce 
costs on such a system. I.e. it's the worst possible case for a 
spinlock->rwlock conversion! The only reason i can believe this to make 
a difference are cycle level races and small random micro-differences 
that cause heavier bouncing in the spinlock workload but happen to avoid 
it in the read-lock case. Not due to any fundamental advantage of 
rwlocks.

	Ingo
