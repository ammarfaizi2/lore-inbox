Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264522AbUHBXxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbUHBXxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUHBXxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:53:47 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:58520 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264522AbUHBXxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:53:43 -0400
Message-ID: <410ED3F7.7090809@us.ibm.com>
Date: Mon, 02 Aug 2004 16:53:27 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com> <410E81C3.2070804@us.ibm.com> <20040802185746.GA12724@redhat.com> <410E9FEE.60108@us.ibm.com> <20040802204553.GC12724@redhat.com>
In-Reply-To: <20040802204553.GC12724@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Mon, Aug 02, 2004 at 01:11:26PM -0700, Ian Romanick wrote:
> 
>  > > > This would be *very* non-trivial to do.  Doing the DRM like this has 
>  > > > come up probably a dozen times (or more) over the last 3 years.
>  > >Which should ring alarm bells that something might not be quite right.
>  > And that it hasn't been done all those times should be a sign of 
>  > *something*. ;)
> 
> heh. I'd attribute it to the fact that it's tedious monotonous work
> doing cleanup work like this, as opposed to 'sexy' work, like hacking
> on something new.  Personally, I've always found something more important
> to be doing.  Maybe I can find some more time to look into it soon.

If you're like me and most of the other developers, you've already got a 
to-do list a mile long.  For me hitting myself on the head with a hammer 
is pretty low. ;)

>  > 1. There is a lot more variability among graphics cards that there is 
>  > among, say, network cards.  Look at the output of 'grep __HAVE_ | grep 
>  > define' on any two <card>.h files to see what I mean.  The output for 
>  > tdfx.h and radeon.h, or mga.h and savage.h is *very* different.  That, 
>  > by itself, makes a huge difference on what code is needed.
> 
> The __HAVE_ stuff is another pet gripe of mine.
> In particular, the mish-mash of __HAVE_AGP , __REALLY_HAVE_AGP, __MUST_HAVE_AGP
> flags have bugged me for a long time.

The problem is that __REALLY_HAVE_FOO is usually just (__HAVE_FOO && 
CONFIG_FOO) on Linux.  They appear to be derived slightly differently on 
NetBSD and FreeBSD.  'grep __REALLY_HAVE drm_os_*bsd.h | grep define' in 
the bsd directory in the DRM tree.  Since there's just the three 
(__REALLY_HAVE_AGP, __REALLY_HAVE_SG, and __REALLY_HAVE_MTRR), I think 
we can live with them.

It shouldn't be too hard to get rid of __MUST_HAVE_AGP, though.

I think this is the right place to start.  A couple of these look easier 
to get rid of than others.  __HAVE_MTRR and __HAVE_AGP are enabled in 
every driver except ffb.  It should be easy enough to get rid of them. 
It looks like __HAVE_RELEASE, __HAVE_DMA_READY, __HAVE_DMA_FLUSH, 
__HAVE_DMA_QUIESCENT, and __HAVE_MULTIPLE_DMA_QUEUES (which looks broken 
anyway) should also be low-hanging fruit.

If we get that far, I think the next step would be to replace the 
DRIVER_* macros with a table of function pointers that would get passed 
around.  Since I doubt any of those uses are performance critical, that 
should be fine.

Then we can start looking at data structure refactoring.

>  > >If this kind of abuse wasn't so widespread, abstracting this code
>  > >out into shared sections and driver specific parts would be a lot
>  > >simpler. Sadly, this is the tip of the iceberg.
>  > 
>  > I think it comes down to the fact that the original DRM developers 
>  > wanted templates.  C doesn't have them, so they did the "next best" thing.
> 
> I vaguelly recall the code at one point not looking quite 'so bad',
> it just grew and grew into this monster.  I'm sure it was done originally
> with the best of intentions, but it seems someone along the line got
> a bit carried away.

There was a point when a *lot* of the device-dependent code was still in 
the OS-dependent directories.  This is how the i810 and i830 drivers 
still are.  I think as more of the code got moved into the 
OS-independent directory, it got less pleasant to read.


