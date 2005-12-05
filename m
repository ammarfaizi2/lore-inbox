Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVLEMTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVLEMTk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 07:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLEMTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 07:19:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55478 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932381AbVLEMTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 07:19:39 -0500
Date: Mon, 5 Dec 2005 13:17:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Message-ID: <20051205121728.GF5509@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051205081935.GI22168@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> seconds or less, and writing out the swap image took less than 5
> seconds, so within 15 seconds of running my suspend script power was
> off.

So suspend took 15 second, and boot another 5 to read the image + 20
first time desktops are switched. ... ~40 second total.

> The downside was that after suspend, *everything* needed to be paged
> back in, so all my apps were *very* slow for the first few interactions.
> It would take about 15 or 20 seconds for Firefox to repaint the first
> time I switched to its virtual desktop, and it was perceptibly slower
> than normal for the next 5 or 10 minutes of use.
> 
> Now that I'm running 2.6.15-rc3-mm1, the page-in problem seems to be
> largely gone; I don't notice a significant lagginess after resuming from
> swsusp.
> 
> But the suspend process is *slow*.  It takes a good 20 or 30 seconds to
> write out the image, which makes the overall suspend process take close
> to a minute; it's writing about 400 MB, and my disk seems to only be
> good for about 18 MB/sec according to hdparm -t.

Lets say 20 seconds suspend, plus 20 seconds resume, and no time
needed to switch the desktops. So it is ~40 seconds total, again ;-).

> And, the resume is about the same amount slower, too.
> 
> Certainly there's a tradeoff to be made, and I'm glad to lose the slow
> re-paging after resume, but I'm hoping that some kind of improvement can
> be made in the suspend/resume time.

Of course, there are many ways to improve suspend. Some are easy, some
are hard, some can be merged, and some can not.

> Could we perhaps throw away *half* the cached memory rather than all of
> it?  

Should be easy, mergeable and possibly very effective. Relevant code
is in kernel/power/disk.c.

> Or keep a lazy list of pages that need re-reading and page them in
> asynchronously after restarting userland?

This would be fine if you can do it in userspace, but it is not going
to be so easy... ... actually, there's one entry in FAQ:

Q: After resuming, system is paging heavilly, leading to very bad
interactivity.

A: Try running

cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` >
/dev/null

after resume. swapoff -a; swapon -a may also be usefull.

...does that help for you?

Other possible ideas are:

* get suspend to RAM working if you want it *really* fast :-)

* compress the image. Needs to be done in userspace, so it needs
uswsusp to be merged, first. Patches for that are available. Should
speed it up about twice.

* and of course you can apply one very big patch and do all of the
above :-).

							Pavel
-- 
Thanks, Sharp!
