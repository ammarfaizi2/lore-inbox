Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWABStR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWABStR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 13:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWABStR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 13:49:17 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:13510 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750945AbWABStQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 13:49:16 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, mingo@elte.hu, tim@physik3.uni-rostock.de,
       torvalds@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com
In-Reply-To: <20060102102824.4c7ff9ad.akpm@osdl.org>
References: <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org>
	 <20051229224839.GA12247@elte.hu>
	 <1135897092.2935.81.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de>
	 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	 <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de>
	 <20060102102824.4c7ff9ad.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 Jan 2006 19:49:06 +0100
Message-Id: <1136227746.2936.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd be reluctant to trust gcc-4 to do the right thing in all cases.  If the
> compiler fails to inline functions in certain critical cases we'll suffer
> some performance loss and the source of that performance loss will be
> utterly obscure.

yet.. turning inline into a hint (which causes gcc to greatly bias
towards inlining without making it absolute) was also opposed by either
you or Linus. Forcing is ALSO wrong. For example it causes gcc to do
inlining even for functions that use variable sized arrays ;(

the performance loss potential should not be overstated; unless the code
can get a real advantage in optimizing due to constant arguments (eg the
kmalloc example), there is not much to gain from inlining. A "call" is 1
cycle at most normally, unless the code inside the inline is highly
trivial/small that's negligible. (eg anything that does port or mmio is
already 100x more expensive, as is anything that gets a cache-miss or a
branch predictor miss such as a loop). 

> All those squillions of bogus inlines which you've identified are probably
> mainly in code we just don't care about much.  We shouldn't penalise
> well-maintained code because of legacy problems in less well-maintained
> code.

this is not a correct assumption as far as I can see. Especially for
drivers, but also even for kernel/. I sent you a patch to fix the
biggest offenders, and I can do more of that of course. But to some
degree the end isn't in sight, esp if new code keeps introducing new
bogus inlines.

Maybe the right approach is to start rejecting in reviews new code that
uses inline inappropriately. (where "inappropriate" sort of is "more
than 3 lines of C unless there is some constant-optimizes-away trick")


