Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWHFWB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWHFWB4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWHFWB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:01:56 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44813 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750731AbWHFWBz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:01:55 -0400
Date: Sat, 5 Aug 2006 11:45:47 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Zed 0xff <zed.0xff@gmail.com>
Cc: kernel-janitors@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix common mistake in polling loops
Message-ID: <20060805114547.GA5386@ucw.cz>
References: <710c0ee0607280128g2d968c49ycff3bac9e073e7fa@mail.gmail.com> <20060805114052.GE4506@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805114052.GE4506@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > task taken from http://kerneljanitors.org/TODO:
> > 
> > A _lot_ of drivers end up caring about absolute time, 
> > because a _lot_ of
> > drivers have a very simple issue like:
> > 
> > - poll this port every 10ms until it returns "ready", or 
> > until we time
> >   out after 500ms.
> > 
> > And the thing is, you can do it the stupid way:
> > 
> > 	for (i = 0; i < 50; i++) {
> > 		if (ready())
> > 			return 0;
> > 		msleep(10);
> > 	}
> > 	.. timeout ..
> > 
> > or you can do it the _right_ way. The stupid way is 
> > simpler, but anybody
> > who doesn't see what the problem is has some serious 
> > problems in kernel
> > programming. Hint: it might not be polling for half a 
> 
> Well, whoever wrote thi has some serious problems (in attitude
> department). *Any* loop you design may take half a minute under
> streange circumstances.
> 
> > second, it might be
> > polling for half a _minute_ for all you know.
> > 
> > In other words, the _right_ way to do this is literally
> > 
> > 	unsigned long timeout = jiffies + 
> > 	msecs_to_jiffies(500);
> > 	for (;;) {
> > 		if (ready())
> > 			return 0;
> > 		if (time_after(timeout, jiffies))
> > 			break;
> > 		msleep(10);
> > 	}
> > 
> > which is unquestionably more complex, yes, but it's more 
> > complex because
> > it is CORRECT!

Actually it may be broken, depending on use. In some cases this loop
may want to poll the hardware 50 times, 10msec appart... and your loop
can poll it only once in extreme conditions.

Actually your loop is totally broken, and may poll only once (without
any delay) and then directly timeout :-P -- that will break _any_
user.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
