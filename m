Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbVJGMTK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVJGMTK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVJGMTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:19:10 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:30690 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932399AbVJGMTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:19:08 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] vm - swap_prefetch-15
Date: Fri, 7 Oct 2005 22:18:57 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org
References: <200510070001.01418.kernel@kolivas.org> <4d8e3fd30510070446gb6d469bn4502b30d1e14c7e8@mail.gmail.com>
In-Reply-To: <4d8e3fd30510070446gb6d469bn4502b30d1e14c7e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510072218.57864.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2005 21:46, Paolo Ciarrocchi wrote:
> On 10/6/05, Con Kolivas <kernel@kolivas.org> wrote:
> > The last known bugs were addressed in this latest version of the swap
> > prefetching patch. Thanks to the testers out there who helped it get this
> > far.
> >
> > -Prefetched pages weren't handled properly by the lru lists.
> > -Prefetch groups are now 10 times larger when laptop_mode is enabled thus
> > decreasing the amount of time spent prefetching and thus the disk
> > spinning. -Documentation as suggested by Ingo Oeser
> >
> > Incremental patches and latest available here:
> > http://ck.kolivas.org/patches/swap-prefetch/
>
> Ciao Con,
> i downloading right now kernel 2.6.14-rc3 and your latest patch (v15),
> in the weekend I'll update my Ubuntu platform and I'll like to compare
> performance of vanilla vs vm-swap_prefetch.

Great!

> Any hint about what kind of instrumentation I could use in order to
> get interesting and useful numbers ?

To get some useful advantage from it you have to have a workload that swaps on 
your hardware in the first place. I have a simple mechanism to induce it 
reliably where I open a few large applications concurrently - browser and 
office suite come to mind, then create my swap load:

tail -f /dev/zero

works real nice. Either let it run to completion and hope that tail gets 
oom-killed or ctrl-c it after you've used up half your swapspace.
Then I usually let vmstat 1 run in the background. Leave the machine for 5 or 
10 minutes and do simple wallclock time from the moment you click on the 
application till it is available. Try changing swap_prefetch from 2 to 0 
in /proc/sys/vm/swap_prefetch to compare the difference. This is a very 
coarse and somewhat contrived example, but even in real world settings where 
you hit swapspace during normal usage it is slowly trickling in in the 
background and I find it makes a noticeable difference.

If you watch vmstat with swap_prefetch enabled, you'll notice it doing SI of 
256KB (at default setting of swap_prefetch==2) every second when the machine 
is very idle. Then after all the pages have been prefetched, when you click 
on the application you shouldn't see anything in SI at all implying no swap 
in. You can see how many entries are currently in the prefetch swaplist 
easily enough with
cat /proc/slabinfo | grep swapped_entry

where the first numeric column of active objects shows the number of pages in 
the list (not all of them will result in a swapped in page).

Cheers,
Con
