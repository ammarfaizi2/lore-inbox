Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbVLEXzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbVLEXzV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVLEXzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:55:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29894 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751497AbVLEXzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:55:20 -0500
Date: Tue, 6 Dec 2005 00:55:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andy Isaacson <adi@hexapodia.org>, linux-kernel@vger.kernel.org
Subject: swsusp: how much memory to free? [was Re: swsusp performance problems in 2.6.15-rc3-mm1]
Message-ID: <20051205235501.GC1770@elf.ucw.cz>
References: <20051205081935.GI22168@hexapodia.org> <20051205121728.GF5509@elf.ucw.cz> <200512052218.18769.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512052218.18769.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Now that I'm running 2.6.15-rc3-mm1, the page-in problem seems to be
> > > largely gone; I don't notice a significant lagginess after resuming from
> > > swsusp.
> > > 
> > > But the suspend process is *slow*.  It takes a good 20 or 30 seconds to
> > > write out the image, which makes the overall suspend process take close
> > > to a minute; it's writing about 400 MB, and my disk seems to only be
> > > good for about 18 MB/sec according to hdparm -t.
> > 
> > Lets say 20 seconds suspend, plus 20 seconds resume, and no time
> > needed to switch the desktops. So it is ~40 seconds total, again ;-).
> 
> I think there's no point in doing such calculations.  In fact, above certain
> critical RAM size (call it X), the more RAM in the box, the _worse_ it gets when
> we try to free as little memory as possible (let alone trying to save _all_
> of it).  The only question is how great is X.

Agreed. And X depends on workload.

Several approaches make sense.

(Y is size of image. Obviously Y < half of ram and Y > some minimum
ammount of kernel data. My approach is Y as low as possible, your
approach is Y as high as possible.).

1) Try to make Y as much as possible, but 500MB max. Common user
workloads fit into 500MB, so user should get responsive system after
resume, but we'll not write excessive ammounts of data.

2) Only free memory that was not used in last 10 minutes. That should
keep system responsive enough after resume. 

> > Should be easy, mergeable and possibly very effective. Relevant code
> > is in kernel/power/disk.c.
> 
> For this purpose we'll need to tamper with mm, I think, and that won't be
> easy.
> 
> OTOH, we can get similar result by just making the kernel free some
> more memory _after_ we are sure we have enough memory to suspend.
> IOW, after the code that's currently in swsusp_shrink_memory() has finished,
> we can try to free some "extra" memory to improve performance, if
> needed.  The question is how much "extra" memory should be freed and
> I'm afraid it will have to be tuned on the per-system, or at least
> per-RAM-size, basis.

I'd prefer not to have extra tunables. "Write only 500MB" will work
okay for common desktop users -- as long as common desktop fits into
500MB, that is. "Free not used in last 10 minutes" should work okay
for everyone, but may be slightly harder to implement.
								Pavel
-- 
Thanks, Sharp!
