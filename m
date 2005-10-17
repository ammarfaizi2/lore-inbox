Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbVJQPms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbVJQPms (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbVJQPms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:42:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751400AbVJQPmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:42:47 -0400
Date: Mon, 17 Oct 2005 08:42:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Eric Dumazet <dada1@cosmosbay.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <20051017103244.GB6257@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Dipankar Sarma wrote:
> 
> Agreed. It is not designed to work that way, so there must be
> a bug somewhere and I am trying to track it down. It could very well
> be that at maxbatch=10 we are just queueing at a rate far too high
> compared to processing.

That sounds sane.

I suspect that the real fix for 2.6.14 might be to update maxbatch to be 
much higher by default.

The thing is, that batching really is fundamentally wrong. If we have a 
thousand thing to free, we can't just free ten of them, and leave the 990 
others to wait for next time. I realize people want real-time, but 
if it's INCORRECT, then real-time isn't real-time.

I just checked: increasing "maxbatch" from 10 to 10000 does fix the 
problem.

> This I am not sure, it is Linus' call. I am just trying to do the
> right thing - fix the real problem.

It sure looks like the batch limiter is the fundamental problem.

Instead of limiting the batching, we should likely try to avoid the RCU 
lists getting huge in the first place - ie do the RCU callback processing 
more often if the list is getting longer.

So I suspect that the _real_ fix is:

 - for 2.6.14: remove the batching limig (or just make it much higher for 
   now)

 - post-14: work on making sure rcu callbacks are done in a more timely 
   manner when the rcu queue gets long. This would involve TIF_RCUPENDING 
   and whatever else to make sure that we have timely quiescent periods, 
   and we do the RCU callback tasklet more often if the queue is long.

Hmm?

		Linus
