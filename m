Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272328AbTHEBIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272342AbTHEBIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:08:55 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:25616 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S272328AbTHEBIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 21:08:51 -0400
Date: Tue, 5 Aug 2003 03:08:48 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: george anzinger <george@mvista.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Patrick Moor <pmoor@netpeople.ch>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: time jumps (again)
Message-ID: <20030805010848.GA4697@win.tue.nl>
References: <Pine.LNX.4.33.0308042347300.12309-100000@gans.physik3.uni-rostock.de> <3F2EE053.1020600@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2EE053.1020600@mvista.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tim Schmielau wrote:

> >>What happens: when doing a
> >> $ while true; do date; done
> >>I'm noticing time jumps _exactly_ at the beginning of a "new" second (or
> >>at the end of an "old" one). the jump is exactly 4294 (4295) seconds
> >>into the future. Example:
> >>...
> >>Mon Aug  4 18:11:06 CEST 2003
> >>Mon Aug  4 19:22:41 CEST 2003
> >>Mon Aug  4 18:11:07 CEST 2003
> >>...

> >--- linux-2.4.20/arch/i386/kernel/time.c.orig	Mon Aug  4 23:38:47 2003
> >+++ linux-2.4.20/arch/i386/kernel/time.c	Mon Aug  4 23:40:53 2003
> >@@ -274,8 +274,8 @@
> > 	read_lock_irqsave(&xtime_lock, flags);
> > 	usec = do_gettimeoffset();
> > 	{
> >-		unsigned long lost = jiffies - wall_jiffies;
> >-		if (lost)
> >+		long lost = jiffies - wall_jiffies;
> >+		if (lost>0)
> > 			usec += lost * (1000000 / HZ);
> > 	}
> > 	sec = xtime.tv_sec;

At first sight jiffies and wall_jiffies increase monotonically, and
wall_jiffies always has a value jiffies had a moment earlier, so the
difference jiffies - wall_jiffies ought to be nonnegative.

On the other hand, do_gettimeoffset() is a much more obscure function,
and the jumps are also explained if that can return a negative value.

Depending on CONFIG_X86_TSC it does do_slow_gettimeoffset or
do_fast_gettimeoffset. Both offer plenty of opportunities to
return a negative value. Things depend on hardware details.

So, instead of adding a test inside { } I would propose to catch
problems after the {}, e.g. by
	if (usec < 0)
		usec = 0;

There should be a clue in the fact that the jump happens at the
start of a new second. I don't know what it is.

Andries

