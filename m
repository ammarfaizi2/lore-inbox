Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131631AbRC0VxH>; Tue, 27 Mar 2001 16:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbRC0Vw5>; Tue, 27 Mar 2001 16:52:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41733 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131631AbRC0Vws>; Tue, 27 Mar 2001 16:52:48 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] mm/memory.c, 2.4.1 : memory leak with swap cache (updated)
Date: 27 Mar 2001 13:51:58 -0800
Organization: Transmeta Corporation
Message-ID: <99r21u$ogg$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0103271624520.1989-200000@jerrell.lowell.mclinux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2001, Richard Jerrell wrote:
>
> Instead of removing the swap cache page at process exit and possibly
> expending time doing disk IO as you have pointed out, we check during
> refill_inactive_scan and page_launder for a page that is

I think this patch looks pretty good.  However, I don't think you can
safely do a "is_shared()" query without holding the page lock. 

I'd be happy to be shown otherwise, of course.  I'm just generally very
wary of "is_shared()", and that function makes me nervous.  I'd almost
prefer to get rid of it, and test for the stuff it tests for directly
(most places that test this are likely to not need all the tests
anyway). 

I also have this suspicion that most of the advantage of this patch
could easily be gotten by just testing for the exclusive "no longer
used" case in the swap-cache "writepage()" function.  That would have
the advantage of localizing the test more, and minimizing special-case
swap-cache tests in the general VM codepaths. 

Comments?

                Linus


