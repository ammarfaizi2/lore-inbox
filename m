Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964859AbVLEXZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVLEXZa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVLEXZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:25:30 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:16304 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964859AbVLEXZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:25:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
Date: Mon, 5 Dec 2005 22:18:18 +0100
User-Agent: KMail/1.9
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz>
In-Reply-To: <20051205121728.GF5509@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512052218.18769.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 5 December 2005 13:17, Pavel Machek wrote:
> > On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> > GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> > seconds or less,

That is strange.  Without the recent patches It takes _much_ more time on my
box, and I have "only" 768 MB or RAM.

> > and writing out the swap image took less than 5 
> > seconds, so within 15 seconds of running my suspend script power was
> > off.
> 
> So suspend took 15 second, and boot another 5 to read the image + 20
> first time desktops are switched. ... ~40 second total.
> 
> > The downside was that after suspend, *everything* needed to be paged
> > back in, so all my apps were *very* slow for the first few interactions.
> > It would take about 15 or 20 seconds for Firefox to repaint the first
> > time I switched to its virtual desktop, and it was perceptibly slower
> > than normal for the next 5 or 10 minutes of use.

That's much, IMHO.

> > Now that I'm running 2.6.15-rc3-mm1, the page-in problem seems to be
> > largely gone; I don't notice a significant lagginess after resuming from
> > swsusp.
> > 
> > But the suspend process is *slow*.  It takes a good 20 or 30 seconds to
> > write out the image, which makes the overall suspend process take close
> > to a minute; it's writing about 400 MB, and my disk seems to only be
> > good for about 18 MB/sec according to hdparm -t.
> 
> Lets say 20 seconds suspend, plus 20 seconds resume, and no time
> needed to switch the desktops. So it is ~40 seconds total, again ;-).

I think there's no point in doing such calculations.  In fact, above certain
critical RAM size (call it X), the more RAM in the box, the _worse_ it gets when
we try to free as little memory as possible (let alone trying to save _all_
of it).  The only question is how great is X.

The Andy's numbers suggest X \approx 1.5 GB, if I correctly remeber his dmesg
outputs.  Therefore, even if the current code is as effective for him as the old
one, it _will_ _not_ be so for someone who has, say, 2 GB of RAM or more.
IOW, there is a point at which it gets reasonable to free memory before
suspend for performance reasons and it only remains uncertain where
that point actually is and how much memory should be freed for given
RAM size.

> > And, the resume is about the same amount slower, too.
> > 
> > Certainly there's a tradeoff to be made, and I'm glad to lose the slow
> > re-paging after resume, but I'm hoping that some kind of improvement can
> > be made in the suspend/resume time.
> 
> Of course, there are many ways to improve suspend. Some are easy, some
> are hard, some can be merged, and some can not.
> 
> > Could we perhaps throw away *half* the cached memory rather than all of
> > it?  
> 
> Should be easy, mergeable and possibly very effective. Relevant code
> is in kernel/power/disk.c.

For this purpose we'll need to tamper with mm, I think, and that won't be
easy.

OTOH, we can get similar result by just making the kernel free some
more memory _after_ we are sure we have enough memory to suspend.
IOW, after the code that's currently in swsusp_shrink_memory() has finished,
we can try to free some "extra" memory to improve performance, if
needed.  The question is how much "extra" memory should be freed and
I'm afraid it will have to be tuned on the per-system, or at least
per-RAM-size, basis.

I think I can write an experimental patch for that, if Andy agrees to test
it. ;-)

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin

