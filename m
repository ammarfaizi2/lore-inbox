Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbTL1AEX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 19:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTL1AEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 19:04:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:32476 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264902AbTL1AEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 19:04:21 -0500
Date: Sat, 27 Dec 2003 16:04:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roger Luethi <rl@hellgate.ch>
Cc: riel@surriel.com, torvalds@osdl.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Page aging broken in 2.6
Message-Id: <20031227160410.754c5ce1.akpm@osdl.org>
In-Reply-To: <20031227230757.GA25229@k3.hellgate.ch>
References: <1072423739.15458.62.camel@gaston>
	<Pine.LNX.4.58.0312260957100.14874@home.osdl.org>
	<1072482941.15458.90.camel@gaston>
	<Pine.LNX.4.58.0312261626260.14874@home.osdl.org>
	<1072485899.15456.96.camel@gaston>
	<Pine.LNX.4.58.0312261649070.14874@home.osdl.org>
	<Pine.LNX.4.55L.0312262147030.7686@imladris.surriel.com>
	<20031226190045.0f4651f3.akpm@osdl.org>
	<20031227230757.GA25229@k3.hellgate.ch>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi <rl@hellgate.ch> wrote:
>
> On Fri, 26 Dec 2003 19:00:45 -0800, Andrew Morton wrote:
> > The current behaviour seems better from a theoretical point of view.  All
> > we want to know is the reference pattern - whether it is one process
> > referencing the page frequently or 100 processes referencing it
> > infrequently shouldn't matter.  And if we want to give mapped pages more
> 
> It can matter. Evicting a page that is infrequently referenced by many
> processes increases the chance that all runnable processes block waiting
> for that same page later. The likelihood of that happening grows under
> memory pressure, when "infrequently" may actually be "quite often" and
> when disk I/O is congested (resulting in higher disk access times).
> 
> You won't have the same effect when evicting a page that is referenced
> by one process only, no matter how frequently.
> 
> Having all processes blocked is indeed one problem of 2.6 under memory
> pressure. I don't know what the cause is, though.
> 

I usually work this sort of thing out by "random sampling".  When
everything is in steady state, break into kgdb and start looking at task
backtraces, see where they are all sleeping.

If it's in the pagefault handler, go up to do_page_fault() and work out the
faulting address.  Compare that with /proc/pid/maps to see if it's libc or
whatever.

Repeat the above N times until you have a decent feel for what's happening
in there.  It doesn't take long.

