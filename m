Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266708AbUHDEwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266708AbUHDEwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 00:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266691AbUHDEwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 00:52:18 -0400
Received: from zimbo.cs.wm.edu ([128.239.2.64]:32394 "EHLO zimbo.cs.wm.edu")
	by vger.kernel.org with ESMTP id S266758AbUHDEwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 00:52:14 -0400
Date: Wed, 4 Aug 2004 00:51:54 -0400 (EDT)
From: Song Jiang <sjiang@CS.WM.EDU>
To: Rik van Riel <riel@redhat.com>
cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       <fchen@CS.WM.EDU>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] token based thrashing control
In-Reply-To: <Pine.LNX.4.44.0408022106560.5948-100000@dhcp83-102.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0408040016200.24835-100000@th139-4.cs.wm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Rik van Riel wrote:

> On Mon, 2 Aug 2004, Song Jiang wrote:
> 
> > When there is memory competition among multiple processes,
> > Which process grabs the token first is important.
> > A process with its memory demand exceeding the total
> > ram gets the token first and finally has to give it up 
> > due to a time-out would have little performance gain from token,
> > It could also hurt others. Ideally we could make small processes
> > more easily grab the token first and enjoy the benifis from
> > token. That is, we want to protect those that are deserved to be
> > protected. Can we take the rss or other available memory demand
> > information for each process into the consideration of whether 
> > a token should be taken, or given up and how long a token is held.  
> 
> I like this idea.  I'm trying to think of a way to skew
> the "lottery" so small processes get an advantage, but
> the only thing I can come up with is as follows:
> 
> 1) when a process tries to grab the token, it "registers"
>    itself
> 
> 2) a subsequent process can "register" itself to get the
>    token, but only if it has a better score than the
>    process that already has it b
> 
> 3) the score can be calculated based on a few factors,
>    like (a) size of the process (b) time since it last
>    had the token
> 
> 4) a simple formula could be (time / size), giving big
>    processes the token every once in a blue moon and
>    letting small processes have the token all the time

So the score of each registered process, with or without 
token, is calculated periodically. After each calculation,
a registered process with the highest score will take the token.
So a process gives up its token in these 4 cases:
(1) its page fault rate below a threshold (2) its score below
a threshold; (3) it holds a token for too long time (4) it is 
done. 

However, we have to avoid "token thrashing": a token is transfered
among processes too frequently, which could actually create unnecessarily
addtional page faults. So once a process gets the token, we can let
it hold the token for at least a minimal period of time. 
The intention behind the score = time/size is very sound, but
I am not sure how sensitive the performance is to the formula.
We may need to tune it carefully to make it valid.    

Which process will register itself? In my original design,
I allow a process with any major page faults to take the token.
However, I think now we should only allow the processes with their
page fault rate higher than a threshold to register themselves.
In this way we can limit the queue size.



> 
> 5) the token would be grabbed in pretty much the same way
>    we do currently, except the token can be handed to
>    another process instead of the current process, if there
>    is a better candidate registered - all the locking is there
> 
> 6) since there is only one candidate, we won't have any
>    queueing complexities and the algorithm should be just
>    as cheap as it is currently
> 

Do we need to periodically compare the scores of registered processes?
If yes, that would take queueing complexity.

> What do you think ?
> 
> 

