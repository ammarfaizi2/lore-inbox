Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbTI3SVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 14:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbTI3SVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 14:21:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4316
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S261498AbTI3SVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 14:21:49 -0400
Date: Tue, 30 Sep 2003 20:22:55 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [BUG] 2.4.x RT signal leak with kupdated (and maybe others)
Message-ID: <20030930182255.GX17274@velociraptor.random>
References: <1064939275.673.42.camel@gaston> <20030930173651.GU17274@velociraptor.random> <1064944028.5634.49.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1064944028.5634.49.camel@gaston>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 07:47:09PM +0200, Benjamin Herrenschmidt wrote:
> > When I wrote the kupdate code, only the real time signals could be
> > queued. Now things have changed to carry the siginfo for non-RT too. The
> > fact we clear the pending by hand is what allows more than a RT signal
> > to be stacked, we shouldn't clear the bitflag unless we dequeue the
> > signal too. That's definitely a bug (though a minor one ;)
> 
> "Minor" but leads to interesting results in the end when coupled
> with something like noflushd that regulary send those signals ;)
> 
> Not only we leak them, but we also get nr_queued_signals reaching
> nr_max_signals. This has the side effect of making do_notify_parent()
> silently fail when a pthread is dead (libpthread use an RT signal).
> 
> The end result is that after a few days, a machine running noflushd
> and thread intensive apps like evolution and gkrellm will have dozens
> (or even hundreds) of zombies as the child threads are never reclaimed
> by libpthread "manager" thread since it never gets the signal...

for noflushd users it's major (for everybody else is minor)

> Interesting... though hopefully, I didn't see anybody else causing
> such a constant increase of nr_queued_signals so far on this laptop...

That's because nobody else sends signals to the daemons I guess. And
even if they do the daemon won't clear the pending bitflag, so there's
no risk to queue more than 1 non-RT entry per signal per daemon like it
happened with kupdate.

Andrea - If you prefer relying on open source software, check these links:
	    rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.[45]/
	    http://www.cobite.com/cvsps/
