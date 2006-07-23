Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWGWMlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWGWMlp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 08:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWGWMlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 08:41:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751200AbWGWMlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 08:41:44 -0400
Date: Sun, 23 Jul 2006 05:37:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com, torvalds@osdl.org,
       bunk@stusta.de, lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: Re: REGRESSION: the new i386 timer code fails to sync CPUs
Message-Id: <20060723053755.0aaf9ce0.akpm@osdl.org>
In-Reply-To: <20060723120829.GA7776@kiste.smurf.noris.de>
References: <20060722233638.GC27566@kiste.smurf.noris.de>
	<20060722173649.952f909f.akpm@osdl.org>
	<20060723081604.GD27566@kiste.smurf.noris.de>
	<20060723044637.3857d428.akpm@osdl.org>
	<20060723120829.GA7776@kiste.smurf.noris.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jul 2006 14:08:29 +0200
Matthias Urlichs <smurf@smurf.noris.de> wrote:

> Hi,
> 
> Andrew Morton:
> > - CPU0 and CPU1 share a TSC and CPU2 and CPU3 share another TSC.
> > 
> That mmakes sense, since they're one dual-core Xeon each.

OK.

> > - Earlier kernels didn't use the TSC as a time source whereas this one
> >   does, hence the problems which you're observing.
> > 
> Correct; see below.
> 
> > I assume that booting with clock=pit or clock=pmtmr fixes it?
> > 
> Testing... yes, both.
> 
> > It would be useful to check your 2.6.17 boot logs, see if we can work out
> > what 2.6.17 was using for a clock source.
> > 
> That's easy:
> 
> 2.6.17    -Using pmtmr for high-res timesource
> 2.6.18git +Time: tsc clocksource has been installed.
> 
> I missed those two lines, as in the boot logs they're not really
> adjacent, so they got lost in the jumble of other differences.

OK, thanks.  Marking the TSC as bad in this case is simple to do - let us
let John work out the best way.

We must have lost a TSC sanity check somewhere along the way.  I wonder
what it was?

> Interestingly, CPU0/1 gets 6000 bogomips while CPU2/3 only reaches 5600 ..?
> (That happens with both kernels.) I do wonder why, and whether this has any
> bearing on the current problem.

I wouldn't expect it to matter, unless the TSCs are running at different
speeds or something.

Also the sched-domain migration costs are grossly different between the two
kernels.  Maybe we changed the migration-cost-estimation code; I forget.

I'll see if we can get an expert opinion on the write_tsc() failure.
