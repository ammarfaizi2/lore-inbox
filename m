Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTIHAPV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 20:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbTIHAPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 20:15:21 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:7296
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S261732AbTIHAPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 20:15:17 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "John Yau" <jyau_kernel_dev@hotmail.com>,
       "Nick Piggin" <piggin@cyberone.com.au>
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Mon, 8 Sep 2003 10:22:59 +1000
User-Agent: KMail/1.5.3
Cc: <linux-kernel@vger.kernel.org>
References: <000201c374c8$1124ee20$f40a0a0a@Aria> <3F5AF9D9.3070206@cyberone.com.au> <Law10-OE54gbLYluLCT0003a61e@hotmail.com>
In-Reply-To: <Law10-OE54gbLYluLCT0003a61e@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081022.59850.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003 03:30, John Yau wrote:
> > Its actually more important when you have smaller timeslices, because
> > the interactive task is more likely to use all of its timeslice in a
> > burst of activity, then getting stuck behind all the cpu hogs.
>
> Well, I didn't claim it'd be optimal, I just said that it's not worth the
> extra effort.  The interactive task will still finish in
> O((interactive_time / timeslice) * #hogs + interative_time) ms.  As long as
> the cpu time interactive tasks require are very short, they still should
> finish within a reasonable amount of time.
>
> > Yes. Also, say 5 hogs running, an interactive task needs to do something
> > taking 2ms. At a 2ms timeslice, it will take 2ms. At a 1ms timeslice it
> > will take 6ms.
>
> That's assuming that the interactive task gets scheduled first.  In the
> worst case scenario where it gets scheduled last, at 2 ms, it takes 12 ms
> and at 1 ms it also takes 12 ms.  Not much difference there.

Ultra short timeslices would dissolve a lot of the interactivity issues but 
come with a serious problem - most cpu caches these days, which are 
incredibly valuable to cpu performance, take time to be filled and emptied, 
and 1ms timeslices are just too short to use their benefits. The time 
required to derive useful benefit depends on the cpu type but can be up to 
20ms. In my patches, the most interactive tasks round robin every 10ms which 
can cause some detriment to performance, but fortunately interactive tasks 
tend not to be as cpu bound as other tasks. What also happens is that if an 
interactive task decides to use a burst of cpu it will always be dropped by 
at least one priority so the tasks that only ever use small amounts of cpu 
(read audio apps) will always go first.

Also O1int as of vO20 round robins them with less frequency as their 
interactivity drops, which corresponds quite nicely with how cpu bound they 
are, and this maintaints throughput of cpu bound tasks.

Con

