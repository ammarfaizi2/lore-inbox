Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVLEOCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVLEOCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 09:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVLEOCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 09:02:09 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:62941 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1751118AbVLEOCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 09:02:08 -0500
Subject: Re: swsusp performance problems in 2.6.15-rc3-mm1
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Andy Isaacson <adi@hexapodia.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <20051205121728.GF5509@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org>
	 <20051205121728.GF5509@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1133791084.3872.53.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 05 Dec 2005 23:58:05 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-12-05 at 22:17, Pavel Machek wrote:
> Hi!
> 
> > On recent kernels such as 2.6.14-rc2-mm1, a swsusp of my laptop (1.25
> > GB, P4M 1.4 GHz) was a pretty fast process; freeing memory took about 3
> > seconds or less, and writing out the swap image took less than 5
> > seconds, so within 15 seconds of running my suspend script power was
> > off.
> 
> So suspend took 15 second, and boot another 5 to read the image + 20
> first time desktops are switched. ... ~40 second total.

Plus what is mentioned in the next paragraph.

> > The downside was that after suspend, *everything* needed to be paged
> > back in, so all my apps were *very* slow for the first few interactions.
> > It would take about 15 or 20 seconds for Firefox to repaint the first
> > time I switched to its virtual desktop, and it was perceptibly slower
> > than normal for the next 5 or 10 minutes of use.
> > 
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
> 
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
> 
> > Or keep a lazy list of pages that need re-reading and page them in
> > asynchronously after restarting userland?
> 
> This would be fine if you can do it in userspace, but it is not going
> to be so easy... ... actually, there's one entry in FAQ:
> 
> Q: After resuming, system is paging heavilly, leading to very bad
> interactivity.
> 
> A: Try running
> 
> cat `cat /proc/[0-9]*/maps | grep / | sed 's:.* /:/:' | sort -u` >
> /dev/null
> 
> after resume. swapoff -a; swapon -a may also be usefull.
> 
> ...does that help for you?
> 
> Other possible ideas are:
> 
> * get suspend to RAM working if you want it *really* fast :-)

That's not apples with apples though. If you have a hopeless battery, as
many do, suspend to ram is only good if you're moving from one power
point to another.

> * compress the image. Needs to be done in userspace, so it needs
> uswsusp to be merged, first. Patches for that are available. Should
> speed it up about twice.

That's not true at all. You have cryptoapi in kernel space and can
easily use it - it's very similar code to what you already have for
encryption. You won't get double the speed with with the deflate
compressor - more like 2 or 3MB/s :(. Suspend2 gets double the speed
because we use lzf, which is a logically distinction addition
(implemented now as another cryptoapi plugin).

> * and of course you can apply one very big patch and do all of the
> above :-).

Could you stop being nasty, please?

Yes, suspend2 is bigger, but let's keep things in perspective. Including
comments and so on, it's about 12000 lines. fs/ext3 contains 15000 lines
and fs/xfs is just below 115000 lines. For those 12000 lines you get a
clean internal api, support for compression, encryption, swap
partitions, swap files and ordinary files. You get asynchronous I/O and
read ahead where I/O needs to be synchronous. You get saving a full
image of memory and support for a nice user interface (mostly in
userspace). It's not 12000 lines of bloat, but real functionality that
people are using right now.

Talking about suspend2 like it's just bloatware is unfair and does
nothing to help provide users of Linux with a suspend to disk that's as
good as it can be.

Nigel

