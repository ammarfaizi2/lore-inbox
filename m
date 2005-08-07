Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752259AbVHGQSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259AbVHGQSb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 12:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752260AbVHGQSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 12:18:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:55508 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1752258AbVHGQSa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 12:18:30 -0400
Subject: Re: Regression: radeonfb: No synchronisation on CRT with
	linux-2.6.13-rc5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Bodo Eggert <7eggert@gmx.de>, LKML <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
In-Reply-To: <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
References: <Pine.LNX.4.58.0508040103100.2220@be1.lrz>
	 <1123195493.30257.75.camel@gaston>
	 <Pine.LNX.4.58.0508051935570.2326@be1.lrz>
	 <1123401069.30257.102.camel@gaston>
	 <3EF2003B-12DF-4EBB-B304-59614AEFAA09@mac.com>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 18:13:38 +0200
Message-Id: <1123431219.30257.115.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm having a similar issue with my shiny new 17" Powerbook G4.  The
> radeon chip works fine with framebuffer in 2.6.12.4 _with_ PREEMPT,
> but not in 2.6.13-rc5 _with_ PREEMPT (configs are virtually identical).
> I'll try your idea this afternoon when I get the chance.

Note that PREEMPT is known to cause problems on ppc32 ... I'm not sure
what's up yet.  (Random SIGILLs/SEGVs in userland typically)

> I wonder if perhaps some code in radeonfb is used under the BKL, which
> is now preemptable (Or maybe an ordinary spinlock changed or went
> away?), because I also set PREEMPT_BKL.

radeonfb should only rely on the console semaphore....

>   I've got an LCD, and on mine
> it looks like every third pixel-line gets shifted about 32-64 pixels to
> the left, and they move with display refresh.  My guess is that
> something is interrupting radeonfb during a critical time in display
> syncing and forcing the video card to wait too far into the next line
> before sending pixels.

radeonfb is mostly inactive after it has setup the framebuffer and
unless you actually draw something, in which case, accel code is called.

_However_ there is an unrelated problem with some panels, including some
of the 17": The panel doesn't always "sync" properly. This seem to be
related to some subtle timing issue in the LVDS code but I don't know
exactly what yet. You can usually get it back by repeately turning the
backlight all the way down (which shuts the panel off) and back up until
it "catches".

> One other data point, I've seen something like this, except not nearly
> as bad, is stock debian 2.6.8 vs. stock debian 2.6.11 on powerpc.  The
> former exhibits some similar (but not nearly as bad) symptoms.  (Same
> Powerbook), whereas 2.6.11 doesn't.  In that case, neither has PREEMPT.
> I'll run more tests this afternoon/evening, to try to track it down.
> 
> Cheers,
> Kyle Moffett
> 
> --
> There are two ways of constructing a software design. One way is to  
> make it so
> simple that there are obviously no deficiencies. And the other way is  
> to make
> it so complicated that there are no obvious deficiencies.  The first  
> method is
> far more difficult.
>    -- C.A.R. Hoare
> 

