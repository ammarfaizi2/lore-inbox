Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTJHSoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbTJHSoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:44:12 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:9607 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261753AbTJHSoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:44:09 -0400
Subject: Re: [PATCH] Time precision, adjtime(x) vs. gettimeofday
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, john stultz <johnstul@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031008112510.06ae1ebd.shemminger@osdl.org>
References: <1065619951.25818.15.camel@gaston>
	 <20031008112510.06ae1ebd.shemminger@osdl.org>
Content-Type: text/plain
Message-Id: <1065638582.895.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 08 Oct 2003 20:43:02 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The following will prevent adjtime from causing time regression.
> It delays starting the adjtime mechanism for one tick, and 
> keeps gettimeofday inside the window.
> 
> Only fixes i386, but changes to other arch would be similar.
> 
> Running a simple clock test program and playing with adjtime demonstrates
> that this fixes the problem (and 2.6.0-test6 is broken). 
> But given the fragile nature of the timer code, it should go through some
> more testing before inclusion.  Andrew could you put this in the next
> -mm tree?

I like that solution. There is still a possible small issue
in 2.4 but I don't think we need to care about it (see below)

Note about the 2.4 SMP race I talked about, x86 is indeed safe,
as it also uses (jiffies - wall_jiffies) to adjust the offset,
I missed it at first as it's not done from the do_gettimeoffset()
function where I was looking for it.

However, that that means we may apply more than one jiffie to
xtime at once, thus the above workaround would still have a small
hole. But since that happens only with insane interrupt latencies
that I don't expect to see in real life, it's probably a non-issue.

2.6 should always have jiffies and wall_jiffies in perfect sync
as they are manipulated within the same write_lock block.

Ben.


