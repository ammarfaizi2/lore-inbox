Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261750AbVC0PBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261750AbVC0PBR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 10:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVC0PBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 10:01:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:10128 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261750AbVC0O7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 09:59:43 -0500
Date: Sun, 27 Mar 2005 06:56:55 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: rlrevell@joe-job.com, juhl-lkml@dif.dk, linux-os@analogic.com,
       arjan@infradead.org, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no need to check for NULL before calling kfree()
 -fs/ext2/
Message-Id: <20050327065655.6474d5d6.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
	<Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
	<1111825958.6293.28.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
	<Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
	<1111881955.957.11.camel@mindpipe>
	<Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I added likely() and unlikely() to all tests, here are the results from 3 
> runs on my box : 

Any chance you could summarize what these results are, for those
of us too lazy to parse it all out?  The time spent by one author
to summarize in English what the numbers state can save the time of
a hundred readers each individually having to parse the numbers.

Just looking at the third run, it seems to me that "if (likely(p))
kfree(p);" beats a naked "kfree(p);" everytime, whether p is half
NULL's, or very few NULL's, or almost all NULL's.

If I'm reading this right, and if these results are valid, then we are
going about this optimization all wrong, at least if your CPU is an
AMD Athlon (T-bird). Weird.  Instead of stripping the "if (p)" test, we
should be changing it to "if (likely(p))", regardless of whether it
is very likely, or unlikely, or in between.  That is not what I would
call intuitive.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
