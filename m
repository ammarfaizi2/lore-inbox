Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbVJQSiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVJQSiZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 14:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVJQSiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 14:38:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932214AbVJQSiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 14:38:24 -0400
Date: Mon, 17 Oct 2005 11:37:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <4353E6F1.8030206@cosmosbay.com>
Message-ID: <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
 <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
 <4353E6F1.8030206@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Eric Dumazet wrote:
> 
> <lazy_mode=ON>
> Do we really need a TIF_RCUUPDATE flag, or could we just ask for a resched ?
> </lazy_mode>

Hmm.. Your patch looks very much like one I tried already, but the big 
difference being that I just cleared the count when doing the rcu 
callback. That was because I hadn't realized the importance of the 
maxbatch thing (so it didn't work for me, like it did for you).

Still - the actual RCU callback will only be called at the next timer tick 
or whatever as far as I can tell, so the first time you'll still have a 
_long_ RCU queue (and thus bad latency).

I guess that's inevitable - and TIF_RCUUPDATE wouldn't even help, because 
we still need to wait for the _other_ CPU's to get to their RCU quiescent 
event.

However, that leaves us with the nasty situation that we'll ve very 
inefficient: we'll do "maxbatch" RCU entries, and then return, and then 
force a whole re-schedule. That just can't be good.

How about instead of depending on "maxbatch", we'd depend on 
"need_resched()"? Mabe the "maxbatch" be a _minbatch_ thing, and then once 
we've done the minimum amount we _need_ to do (or emptied the RCU queue) 
we start honoring need_resched(), and return early if we do? 

That, together with your patch, should work, without causing ludicrous 
"reschedule every ten system calls" behaviour..

Hmm?

		Linus
