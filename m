Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbUKTKcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUKTKcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 05:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUKTKcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 05:32:13 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:36267
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261546AbUKTKcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 05:32:07 -0500
Subject: Re: [PATCH] fix spurious OOM kills
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Martin =?iso-8859-2?Q?MOKREJ=A9?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: Andrew Morton <akpm@osdl.org>, piggin@cyberone.com.au, chris@tebibyte.org,
       marcelo.tosatti@cyclades.com, andrea@novell.com,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Rik van Riel <riel@redhat.com>
In-Reply-To: <419E821F.7010601@ribosome.natur.cuni.cz>
References: <20041111112922.GA15948@logos.cnet>
	 <4193E056.6070100@tebibyte.org>	<4194EA45.90800@tebibyte.org>
	 <20041113233740.GA4121@x30.random>	<20041114094417.GC29267@logos.cnet>
	 <20041114170339.GB13733@dualathlon.random>
	 <20041114202155.GB2764@logos.cnet>	<419A2B3A.80702@tebibyte.org>
	 <419B14F9.7080204@tebibyte.org>	<20041117012346.5bfdf7bc.akpm@osdl.org>
	 <419CD8C1.4030506@ribosome.natur.cuni.cz>
	 <20041118131655.6782108e.akpm@osdl.org>
	 <419D25B5.1060504@ribosome.natur.cuni.cz>
	 <419D2987.8010305@cyberone.com.au>
	 <419D383D.4000901@ribosome.natur.cuni.cz>
	 <20041118160824.3bfc961c.akpm@osdl.org>
	 <419E821F.7010601@ribosome.natur.cuni.cz>
Content-Type: text/plain; charset=iso-8859-2
Organization: linutronix
Date: Sat, 20 Nov 2004 11:23:26 +0100
Message-Id: <1100946207.2635.202.camel@thomas>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 00:30 +0100, Martin MOKREJ© wrote:
> OK, I can say kernel 2.6.7, 2.6.8.1, 2.6.9-rc1 kill just the RNAsubopt
> application in my test.
> 
> 2.6.9-rc2 kills RNAsubopt and also two xterms, one running vmstat,
> the other is parent of RNAsubopt program I used to eat memory with.
> 
> 2.6.9 has killed just those 2 xterms, as a sideeffect the RNAsubopt
> got killed as parent shell got killed.
> 
> 2.6.10-rc1 killed all three.
> 
> I conclude the major problem got introduced between
> 2.6.9-rc1 and 2.6.9-rc2.

Can you please try 2.6.10-rc2-mm2 + the patch I posted yesterday night ?
It will still kill RNAsubopt, but it should not longer touch the xterm,
which runs vmstat.

> Second problem with 2.6 tree is that I think application should receive 
> some errocode when asking for more memory, so it can exit itself.
> This used to work well under 2.4 tree and was demostrated in my
> previous reports where you see application exist with "not enough memory"
> rather than with "Killed". ;-)

One good reason might be that in the out of memory situation the system
has no idea, whether the requester will gracefully shutdown when
recieving ENOMEM or keep trying to get some more memory. 

The decision to return ENOMEM or finally calling the oom-killer depends
on the flags for this allocation request. The criteria are __GFP_FS set
and not __GFP_NORETRY set.

So all allocations GFP_KERNEL, GFP_USER and GFP_HIGHUSER are candidates
to end up in the oom_killer. The only caller which ever sets the
__GFP_NORETRY flag is fs/xfs. 

tglx


