Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbVJQQ0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbVJQQ0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVJQQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:26:32 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15017 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932263AbVJQQ0S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:26:18 -0400
Date: Mon, 17 Oct 2005 21:50:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Eric Dumazet <dada1@cosmosbay.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
Message-ID: <20051017162002.GA13665@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 08:42:05AM -0700, Linus Torvalds wrote:
> 
> On Mon, 17 Oct 2005, Dipankar Sarma wrote:
> 
> > This I am not sure, it is Linus' call. I am just trying to do the
> > right thing - fix the real problem.
> 
> It sure looks like the batch limiter is the fundamental problem.
> 
> Instead of limiting the batching, we should likely try to avoid the RCU 
> lists getting huge in the first place - ie do the RCU callback processing 
> more often if the list is getting longer.
> 
> So I suspect that the _real_ fix is:
> 
>  - for 2.6.14: remove the batching limig (or just make it much higher for 
>    now)

You can remove the batching limit by making maxbatch = 0 by default.
Just a one line patch.

>  - post-14: work on making sure rcu callbacks are done in a more timely 
>    manner when the rcu queue gets long. This would involve TIF_RCUPENDING 
>    and whatever else to make sure that we have timely quiescent periods, 
>    and we do the RCU callback tasklet more often if the queue is long.

Yes, I am already looking at this. There are a number approaches
to this include adaptive algorithm to cater to naughty corner
cases and/or adding different ways to handle RCU as in 
tree. I hope to experiment with these incrementally after 2.6.14 over 
a period of time and see what works best for most people.

Thanks
Dipankar
