Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263530AbTDGQRe (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 12:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263531AbTDGQRe (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 12:17:34 -0400
Received: from maila.telia.com ([194.22.194.231]:61945 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id S263530AbTDGQRb (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 12:17:31 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Mon, 07 Apr 2003 18:30:06 +0200 (CEST)
Message-Id: <20030407.183006.25160342.cfmd@swipnet.se>
To: kernel@kolivas.org
Cc: schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org
Subject: Re: An idea for prefetching swapped memory...
From: Magnus Danielson <cfmd@swipnet.se>
In-Reply-To: <200304072021.17080.kernel@kolivas.org>
References: <200304071026.47557.schlicht@uni-mannheim.de>
	<200304072021.17080.kernel@kolivas.org>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Con Kolivas <kernel@kolivas.org>
Subject: Re: An idea for prefetching swapped memory...
Date: Mon, 7 Apr 2003 20:21:16 +1000

> This has been argued before. Why would the last swapped out pages be the best 
> to swap in? The vm subsystem has (somehow) decided they're the least likely 
> to be used again so why swap them in? Alternatively how would it know which 
> to swap in instead?

I have been fooling around with similar thoughts, i.e. prefetching of swapped
out pages, but under a different condition.

Consider that you have a system plauged by a set of fat (i.e. having a large
memory footprint) batch-running processes such that when they are running they
get swapped in (traditional deferred swapp-in on page-misses) and other
processes gets swapped out for each run. The idea is to separate out fat batch
processes so that they get scheduled in a separate queue but in a slower pace
than normal batch processes such that when a fat batch is scheduled to run it
gets to run longer, but it is also out of schedule longer. The effect would be
to cause fewer swappings. The topping of this cake would be to prefetch pages
for the next fat-process in the scheduling queue. A "fat" process requires
effectively much more than average number of pages swapped in for each time it
runs.

However, the benefit of deferred swapp-in is that only pages actually needed is
tossed into the tight memory. This benefit can be missed with some processes
in a inferred system, since a process which is constantly shifting its set of
pages would only use part of the pages that got swapped in again. Other
processes might have a large core of pages which is used throughout its
processing. Some statistical analysis could aid (by keeping track of which
pages where not actually used the last time(s) and not swapp it in again) but
this naturally takes additional overheads (you need to trapp the page as if it
where not available and then just page it in, since it was prefetched into
physical memory and naturally also attend to the statistics).

After that I became more doubtfull that prefetching pages would be of interest,
but somebody might convince me otherwise. The scheduling idea might be enought,
but I'm sure it's gonna bit chopped into pieces by scheduling experts.

The idea really started with the question if the scheduler could make a better
scheduling if it where aware of the additional processing cost caused by
swapping in the VM. It might be that this is still a good question to ask.

Before you ask or requests it:
There is no code or numbers to show, this is armwaving around an idea.

Cheers,
Magnus
