Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbTI3Rsa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 13:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbTI3Rs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 13:48:29 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:39911 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261664AbTI3RsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 13:48:23 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
In-Reply-To: <20030930173651.GU17274@velociraptor.random>
References: <1064939275.673.42.camel@gaston>
	 <20030930173651.GU17274@velociraptor.random>
Message-Id: <1064944028.5634.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Sep 2003 19:47:09 +0200
X-SA-Exim-Mail-From: benh@kernel.crashing.org
Subject: Re: [BUG] 2.4.x RT signal leak with kupdated (and maybe others)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 3.0+cvs (built Mon Aug 18 15:53:30 BST 2003)
X-SA-Exim-Scanned: Yes
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> When I wrote the kupdate code, only the real time signals could be
> queued. Now things have changed to carry the siginfo for non-RT too. The
> fact we clear the pending by hand is what allows more than a RT signal
> to be stacked, we shouldn't clear the bitflag unless we dequeue the
> signal too. That's definitely a bug (though a minor one ;)

"Minor" but leads to interesting results in the end when coupled
with something like noflushd that regulary send those signals ;)

Not only we leak them, but we also get nr_queued_signals reaching
nr_max_signals. This has the side effect of making do_notify_parent()
silently fail when a pthread is dead (libpthread use an RT signal).

The end result is that after a few days, a machine running noflushd
and thread intensive apps like evolution and gkrellm will have dozens
(or even hundreds) of zombies as the child threads are never reclaimed
by libpthread "manager" thread since it never gets the signal...

> I sure agree it should be fixed with a dequeue_signal in kupdate.

I'll cook something tomorrow (I'm away from any 2.4 machine tonight).

> BTW, things like this in daemonize don't protect against allocating
> signals (the kernel deamon should flush_signals once in a while in the
> main loop to do that):
> 
> 	/* Block and flush all signals */
> 	sigfillset(&blocked);
> 	sigprocmask(SIG_BLOCK, &blocked, NULL);
> 	flush_signals(current);
> 
> But it's not a big problem you shouldn't send signals to daemons
> anyways, only kupdate gives a semantic to signals.

Interesting... though hopefully, I didn't see anybody else causing
such a constant increase of nr_queued_signals so far on this laptop...

Ben.


