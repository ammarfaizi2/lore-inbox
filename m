Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbTJAOoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJAOoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:44:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14764
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S262182AbTJAOn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:43:56 -0400
Date: Wed, 1 Oct 2003 16:45:27 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [BUG] 2.4.x RT signal leak with kupdated (and maybe others)
Message-ID: <20031001144527.GM17274@velociraptor.random>
References: <1064939275.673.42.camel@gaston> <20030930173651.GU17274@velociraptor.random> <1064944028.5634.49.camel@gaston> <20030930182255.GX17274@velociraptor.random> <1065000241.5636.53.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065000241.5636.53.camel@gaston>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 11:24:01AM +0200, Benjamin Herrenschmidt wrote:
> 
> > That's because nobody else sends signals to the daemons I guess. And
> > even if they do the daemon won't clear the pending bitflag, so there's
> > no risk to queue more than 1 non-RT entry per signal per daemon like it
> > happened with kupdate.
> 
> And any daemon can cause the same leak by sending it RT signals... I just
> verified sending for example a bunch of 33's (SIGRTMIN) to khubd, that
> increased the count permanently.

Yes I know. I was only talking about non-RT, I was concerned about
sigterm/sigkill primarly, that is the only realistic scenario. If you
send SIGRTMIN that is a pilot error, the system will never attempt to do
that, while it's not so obvious for sigterm. That's why I said at least
not more than 1 signal will be queued.

> I agree this should not happen normally, and I suppose only root can do
> that and we aren't here to prevent root from shooting itself in the
> foot, are we ?
> 
> The question is should I spend some time adding some flush_signals() to
> the loop of those various kernel daemons I can find or that isn't worth ?

It's up to you, I believe what we have to fix is the kupdate, the
SIGRTMIN can't matter. At most we can care about the sigterm, but even
the sigterm if it happens, it happens at shutdown time, so at the end it
doesn't matter much either for most systems (and that one isn't a leak,
only some minor memory lost).

So I guess you can fix only kupdate, and care to add the flush_signals
only in 2.6 that has the very same problem.

> Regarding kupated, dequeue_signal is a better option as we actually care
> about the signal, I'm testing a patch it will be there in a few minutes.

thanks

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
