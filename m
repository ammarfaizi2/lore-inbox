Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263745AbTLDX6L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 18:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbTLDX6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 18:58:11 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:57006
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263745AbTLDX6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 18:58:07 -0500
Date: Fri, 5 Dec 2003 00:58:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Bergmann <bergmann.peter@gmx.net>
Cc: Jens Axboe <axboe@suse.de>, maze@cela.pl, linux-kernel@vger.kernel.org
Subject: Re: oom killer in 2.4.23
Message-ID: <20031204235824.GC22517@dualathlon.random>
References: <20031204184248.GJ1086@suse.de> <956.1070570308@www27.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <956.1070570308@www27.gmx.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 09:38:28PM +0100, Peter Bergmann wrote:
> > > effect is still unchanged. 
> > > processes get killed by VM and not oom_kikll.c
> > > 
> > > any hints ??
> > 
> > You probably want to look at the change to
> > vmscan.c:try_to_free_pages_zone().
> > 
> > -- 
> > Jens Axboe
> 
> I did, but my vm knolege is rather limited.
> I don't really know really know _where_ to place 
> out_of_memory() in the new try_to_free_pages_zone()...
> and what  other changes would be necessary in vmscan.c.
> 
> My try & error approach did not succeed.
> 
> I would be really glad if someone (aa may be :) could
> provide the information where/how to place the call for a custom
> (or the old) oom killer -  if it's really that simple ...

it's that simple to reenable it in 2.4.22 status, so if you're ok to
deadlock. 2.4.23 can't deadlock, it can live lock if you're unlucky with
timings yes (think if you add 32G of swap and your ram runs at 1k/sec
instead of 1G/sec), but not deadlock and it won't random kill tasks even
if it shouldn't to.  deadlock is a bug, killing task despite there's ram
free is a bug, livelock is something you can avoid by dropping all swap.
if you drop all swap with 2.4.22 it'll go nuts killing tasks (see the
bugreports).

Since doing it right wasn't possible in 2.4, I dropped it years ago, -aa
users are w/o an oom killer for years and I never heard a single
complain. somebody asked why yes, but they were happy afterwards. I
don't think I asked Marcelo to merge it, I explained why I dropped it,
people sent him bugreports about the oom killer going nuts, and he
agreed my solution was the best short term w/o adding lots of effort to
make the oom killer right. Note the oom killer goes nuts in 2.6 too,
nobody did it right yet, that's why I don't think it's a 2.4 issue.

Marcelo asked me to to make it configurable at runtime so you could go
in the deadlock prone stautus of 2.4.22 on demand, but I'm not going to
add more features to 2.4 today unless they're blocker bugs (even if that
would be simple to implement), actually it's not even my choice so don't
ask me for that sorry.
