Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264356AbRFGHqE>; Thu, 7 Jun 2001 03:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264355AbRFGHpy>; Thu, 7 Jun 2001 03:45:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50220 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264354AbRFGHps>; Thu, 7 Jun 2001 03:45:48 -0400
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<9fm4t7$412$1@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Jun 2001 01:42:06 -0600
In-Reply-To: <9fm4t7$412$1@penguin.transmeta.com>
Message-ID: <m13d9c68j5.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds) writes:
> 
> Somebody interested in trying the above add? And looking for other more
> obvious bandaid fixes.  It won't "fix" swapoff per se, but it might make
> it bearable and bring it to the 2.2.x levels. 

At little bit.  The one really bad behavior of not letting any other
processes run seems to be fixed with an explicit:
if (need_resched) {
        schedule();
}

What I can't figure out is why this is necessary.  Because we should
be sleeping in alloc_pages if nowhere else.

I suppose if the bulk of our effort really is freeing dead swap cache
pages we can spin without sleeping, and never let another process run
because we are busily recycling dead swap cache pages. Does this sound
right? 

If this is going on I think we need to look at our delayed
deallocation policy a little more carefully.   I suspect we should
have code in kswapd actively removing these dead swap cache pages. 
After we get the latency improvements in exit these pages do
absolutely nothing for us except clog up the whole system, and
generally give the 2.4 VM a bad name.

Anyone care to check my analysis? 

> Is anybody interested in making "swapoff()" better? Please speak up..

Interested.   But finding the time...

Eric
