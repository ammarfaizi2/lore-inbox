Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUHBUMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUHBUMi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 16:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUHBUMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 16:12:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:48021 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262906AbUHBUL4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 16:11:56 -0400
Message-ID: <410E9FEE.60108@us.ibm.com>
Date: Mon, 02 Aug 2004 13:11:26 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com> <410E81C3.2070804@us.ibm.com> <20040802185746.GA12724@redhat.com>
In-Reply-To: <20040802185746.GA12724@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Mon, Aug 02, 2004 at 11:02:43AM -0700, Ian Romanick wrote:
> 
>  > This would be *very* non-trivial to do.  Doing the DRM like this has 
>  > come up probably a dozen times (or more) over the last 3 years.
> 
> Which should ring alarm bells that something might not be quite right.

And that it hasn't been done all those times should be a sign of 
*something*. ;)

>  > The problem is that each driver has different needs based on hardware 
>  > functionality.
> 
> How does this differ from any other subsystem that supports
> cards with features that may not be present in another model ?
> Other subsystems have dealt with this problem without the need
> to introduce horrors like the abstractions in DRM.

There are a couple of other things to consider.

1. There is a lot more variability among graphics cards that there is 
among, say, network cards.  Look at the output of 'grep __HAVE_ | grep 
define' on any two <card>.h files to see what I mean.  The output for 
tdfx.h and radeon.h, or mga.h and savage.h is *very* different.  That, 
by itself, makes a huge difference on what code is needed.

2. We have an extra dimension to our matrix.  Most other drivers don't 
need to worry about working on BSD.

3. The ever classic....It seemed like a good idea at the time.

>  > We've managed to classify these needs into a few groups, 
>  > and drivers can select which functionality they need via a set of 
>  > defines.  These per-driver defines determine what code gets compiled 
>  > into the different routines (as well as which routines even get built).
> 
> And among other horrors, crap like typedef's that magically change their
> type completely depending on which file they are #include'd into.
> Overuse of typedefs is one thing, but what goes on with stuff like
> DRIVER_BUF_PRIV_T is bordering on obscene.
> 
> If this kind of abuse wasn't so widespread, abstracting this code
> out into shared sections and driver specific parts would be a lot
> simpler. Sadly, this is the tip of the iceberg.

I think it comes down to the fact that the original DRM developers 
wanted templates.  C doesn't have them, so they did the "next best" thing.

>  > Trying to make this into a library would just be a mess.
> 
> Depends on which direction you're looking at things.
>>From the view of many kernel developers, anything would be
> better than the trainwreck of wrappers/macros/preprocessor abuse
> that's there right now.  I'd put money on a lot more people being
> prepared to hack on DRM's kernel code if it were more readable.
> 
> To give an example of just how bad some folks view on this code is:
> An actual conversation at OLS last week..
> "I found it easier to look at the C preprocessor output than the
>  actual source code to find the types of the variables I was looking at".

That's not surprising.

>  > If this is something that we really want to pursue, someone needs to dig 
>  > in and figure out:
>  > 
>  > 1. How much / which code can be "trivially" shared?
>  > 2. How much / which code can be shared with very little work?
>  > 3. How much / which code would we rather get a root-canal than try to 
>  > make shared?
>  > 
>  > The concern has been that, by making a "generic" library layer, we'd 
>  > actually make the DRM more difficult to maintain.
> 
> I don't maintain upstream DRM, but I have a fair amount of responsibility
> regarding the Fedora kernel, and I'll state publically that looking at
> bugs in drivers/char/drm is right up there on my list of
> "things I'd rather not do after lunch". Maintainability goes much
> further than 'the guy that wrote the code can grok it'.
> 
> People trying to pick up 3d driver programming on Linux have a huge
> hurdle in their place, as that code resembles *NO OTHER* driver code
> in the tree.

In all fairness, what's in the kernel does not constitute the guts of 
the 3D driver.  Few people that do 3D driver development ever need touch 
anything in the kernel.  That's by design.  I've been working on the 
open-source 3D drivers for 3 years, and I've made *maybe* 4 changes to 
the kernel code.

In this case that's a two edged sword.  The kernel parts have gotten to 
be like a container pushed too far to the back of the refridgerator for 
too long...

>  > Nobody has really had 
>  > the time to do the research required to either substantiate or refute 
>  > those claims.  Based on the little experience I have in the DRM, I tend 
>  > to believe them.
> 
> I spent 2-3 days a few months back attempting to clean up some of the
> goo, by peeling away the layers of abstraction.  After the 3rd day,
> I'd estimate I wasn't even a fraction of the way through, and I lost
> the will to keep fighting.

That's the core question.  Everyone *knows* that the current DRM code is 
an ugly mess, but is it worth the effort at this point to fix it?  You 
seem to have come to the same conclusion that everyone else that's 
looked at the problem over the last 2 years has.

Just to reiterate.  I am *NOT* saying that it's not a problem.  Nor am I 
saying that nothing should be done.  What I am saying is that it's a 
really big problem, and fixing it may not be worth the effort required.

I think the only realistic approach is to attack the problem bit by bit, 
rather than en masse.  Gradual elimination of the '#if __HAVE_FOO' and 
gradual datatype refactoring is really the only way to attack it.  The 
problem is just too big and there are just too few interested developers.

