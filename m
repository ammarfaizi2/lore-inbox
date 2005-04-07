Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262484AbVDGPLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262484AbVDGPLJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVDGPLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:11:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:30625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262484AbVDGPI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:08:26 -0400
Date: Thu, 7 Apr 2005 08:10:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Paul Mackerras wrote:
> 
> Are you happy with processing patches + descriptions, one per mail?

Yes. That's going to be my interim, I was just hoping that with 2.6.12-rc2 
out the door, and us in a "calming down" period, I could afford to not 
even do that for a while.

The real problem with the email thing is that it ends up piling up: what 
BK did in this respect was that anythign that piled up in a BK repository 
ended up still being there, and a single "bk pull" got it anyway - so if 
somebody got ignored because I was busy with something else, it didn't add 
any overhead. The queue didn't get "congested".

And that's a big thing. It comes from the "Linus pulls" model where people 
just told me that they were ready, instead of the "everybody pushes to 
Linus" model, where the destination gets congested at times.

So I do not want the "send Linus email patches" (whether mboxes or a 
single patch per email) to be a very long-term strategy. We can handle it 
for a while (in particular, I'm counting on it working up to the real 
release of 2.6.12, since we _should_ be in the calm period for the next 
month anyway), but it doesn't work in the long run.

> Do you have it automated to the point where processing emailed patches
> involves little more overhead than doing a bk pull?

It's more overhead, but not a lot. Especially nice numbered sequences like
Andrew sends (where I don't have to manually try to get the dependencies
right by trying to figure them out and hope I'm right, but instead just
sort by Subject: line) is not a lot of overhead. I can process a hundred
emails almost as easily as one, as long as I trust the maintainer (which,
when it's used as a BK replacement, I obviously do).

However, the SCM's I've looked at make this hard. One of the things (the
main thing, in fact) I've been working at is to make that process really
_efficient_. If it takes half a minute to apply a patch and remember the
changeset boundary etc (and quite frankly, that's _fast_ for most SCM's
around for a project the size of Linux), then a series of 250 emails
(which is not unheard of at all when I sync with Andrew, for example)  
takes two hours. If one of the patches in the middle doesn't apply, things
are bad bad bad.

Now, BK wasn't a speed deamon either (actually, compared to everything
else, BK _is_ a speed deamon, often by one or two orders of magnitude),
and took about 10-15 seconds per email when I merged with Andrew. HOWEVER,
with BK that wasn't as big of an issue, since the BK<->BK merges were so
easy, so I never had the slow email merges with any of the other main
developers. So a patch-application-based SCM "merger" actually would need
to be _faster_ than BK is. Which is really really really hard.

So I'm writing some scripts to try to track things a whole lot faster.  
Initial indications are that I should be able to do it almost as quickly
as I can just apply the patch, but quite frankly, I'm at most half done,
and if I hit a snag maybe that's not true at all. Anyway, the reason I can
do it quickly is that my scripts will _not_ be an SCM, they'll be a very
specific "log Linus' state" kind of thing. That will make the linear patch
merge a lot more time-efficient, and thus possible.

(If a patch apply takes three seconds, even a big series of patches is not
a problem: if I get notified within a minute or two that it failed
half-way, that's fine, I can then just fix it up manually. That's why 
latency is critical - if I'd have to do things effectively "offline", 
I'd by definition not be able to fix it up when problems happen).

> If so, then your mailbox (or patch queue) becomes a natural
> serialization point for the changes, and the need for a tool that can
> handle a complex graph of changes is much reduced.

Yes. In the short term. See above why I think the congestion issue will 
really mean that we want to have parallell merging in the not _too_ 
distant future.

NOTE! I detest the centralized SCM model, but if push comes to shove, and
we just _can't_ get a reasonable parallell merge thing going in the short
timeframe (ie month or two), I'll use something like SVN on a trusted site
with just a few committers, and at least try to distribute the merging out
over a few people rather than making _me_ be the throttle.

The reason I don't really want to do that is once we start doing it that
way, I suspect we'll have a _really_ hard time stopping. I think it's a
broken model. So I'd much rather try to have some pain in the short run 
and get a better model running, but I just wanted to let people know that 
I'm pragmatic enough that I realize that we may not have much choice.

> * Visibility into what you had accepted and committed to your
>   repository
> * Lower latency of patches going into your repository
> * Much reduced rate of patches being dropped

Yes. 

		Linus
