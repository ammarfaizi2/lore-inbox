Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVLTQkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVLTQkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 11:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVLTQkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 11:40:05 -0500
Received: from cpe-24-94-57-164.stny.res.rr.com ([24.94.57.164]:59060 "EHLO
	gandalf.stny.rr.com") by vger.kernel.org with ESMTP
	id S1751125AbVLTQkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 11:40:04 -0500
Subject: Re: [PATCH RT 00/02] SLOB optimizations
From: Steven Rostedt <rostedt@kihontech.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0512201123580.26851@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
	 <1135093460.13138.302.camel@localhost.localdomain>
	 <20051220161337.GA10343@elte.hu>
	 <Pine.LNX.4.58.0512201123580.26851@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 11:39:31 -0500
Message-Id: <1135096771.13138.312.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 11:29 -0500, Steven Rostedt wrote:
> On Tue, 20 Dec 2005, Ingo Molnar wrote:
> > > Tests:
> > > =====
> >
> > could you also post the output of 'size mm/slob.o', with and without
> > these patches, with CONFIG_EMBEDDED and CONFIG_CC_OPTIMIZE_FOR_SIZE
> > enabled? (and with all debugging options disabled) Both the UP and the
> > SMP overhead would be interesting to see.
> >

> Well, there is definitely a hit there:

There's also crap that can be removed in my patch.  Like I started a
cache_chain algorithm.  For example by adding just:

#if 0
static void test_slob(slob_t *s)
{

[...]

}

void print_slobs(void)
{

[...]

}
#endif

I get:
rt:
size mm/slob.o
   text    data     bss     dec     hex filename
   1889     112     233    2234     8ba mm/slob.o

rt smp:
size mm/slob.o
   text    data     bss     dec     hex filename
   2135     120     233    2488     9b8 mm/slob.o

So, I probably need to add stuff for CONFIG_OPTIMIZE_FOR_SIZE.

-- Steve

> 
> rt (slob new):
> size mm/slob.o
>    text    data     bss     dec     hex filename
>    2051     112     233    2396     95c mm/slob.o
> 
> without
> size mm/slob.o
>    text    data     bss     dec     hex filename
>    1331     120       8    1459     5b3 mm/slob.o
> 
> rt smp (slob new)
> size mm/slob.o
>    text    data     bss     dec     hex filename
>    2297     120     233    2650     a5a mm/slob.o
> 
> without
> size mm/slob.o
>    text    data     bss     dec     hex filename
>    1573     140       8    1721     6b9 mm/slob.o
> 
> 
> So, should this be a third memory managment system?  A fast_slob?
> 
> 
> Just for kicks here's slab.o:
> 
> rt:
> size mm/slab.o
>    text    data     bss     dec     hex filename
>    8896     556     144    9596    257c mm/slab.o
> 
> rt smp:
> size mm/slab.o
>    text    data     bss     dec     hex filename
>    9679     640      84   10403    28a3 mm/slab.o
> 
> So there's still a great improvement on that (maybe not the bss though).
> 
> -- Steve
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Steven Rostedt
Senior Programmer
Kihon Technologies
(607)786-4830

