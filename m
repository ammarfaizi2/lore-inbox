Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275183AbRJAQFV>; Mon, 1 Oct 2001 12:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275197AbRJAQFL>; Mon, 1 Oct 2001 12:05:11 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:40972 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S275183AbRJAQFC>; Mon, 1 Oct 2001 12:05:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Load control  (was: Re: 2.4.9-ac16 good perfomer?)
Date: Mon, 1 Oct 2001 18:05:17 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
In-Reply-To: <Pine.LNX.4.33L.0110011031050.4835-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0110011031050.4835-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011001160524Z16518-2757+2654@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 1, 2001 03:57 pm, Rik van Riel wrote:
> On Mon, 1 Oct 2001, Daniel Phillips wrote:
> 
> > Nice.  With this under control, another feature of his memory manager
> > you could look at is the variable deactivation threshold, which makes
> > a whole lot more sense now that the aging is linear.
> 
> Actually, when we get to the point where deactivating enough
> pages is hard, we know the working set is large and we should
> be _more careful_ in chosing what to page out...

Naturally.  However, this is orthogonal.  Consider the case where you've hit 
the wall and the inactive list has suffered sudden depletion.  At this point 
you have to deactivate a large number of pages and you will have few or no 
intervening age-up events (because you hit the wall and nobody's moving).  
It's a useless waste of CPU and real time to cycle through the active list 5 
times to deactivate enough pages.  You should cycle through at most twice, 
once to age up any pages with Ref set and the second time to deactivate the 
required number of pages according to a threshold you estimated on the first 
pass.

This is just the first common example that came to mind where a variable 
deactivation threshold is obviously desirable, I'm sure there are others.

> When we go one step further, where the working set approaches
> the size of physical memory, we should probably start doing
> load control FreeBSD-style ... pick a process and deactivate
> as many of its pages as possible. By introducing unfairness
> like this we'll be sure that only one or two processes will
> slow down on the next VM load spike, instead of all processes.
> 
> Once we reach permanent heavy overload, we should start doing
> process scheduling, restricting the active processes to a
> subset of all processes in such a way that the active processes
> are able to make progress. After a while, give other processes
> their chance to run.

No question about the need for higher level process control, but the low 
level machinery could still be improved, don't you think?

--
Daniel
