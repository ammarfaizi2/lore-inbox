Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVJQWlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVJQWlt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 18:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVJQWlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 18:41:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:46985 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbVJQWlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 18:41:00 -0400
Date: Mon, 17 Oct 2005 15:40:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: dipankar@in.ibm.com, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
In-Reply-To: <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0510171530040.3369@g5.osdl.org>
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org>
 <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com>
 <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com>
 <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org> <4353CADB.8050709@cosmosbay.com>
 <Pine.LNX.4.64.0510170911370.23590@g5.osdl.org> <20051017162930.GC13665@in.ibm.com>
 <4353E6F1.8030206@cosmosbay.com> <Pine.LNX.4.64.0510171112040.3369@g5.osdl.org>
 <4353F7B5.1040101@cosmosbay.com> <Pine.LNX.4.64.0510171218490.3369@g5.osdl.org>
 <4353FDE8.8070909@cosmosbay.com> <Pine.LNX.4.64.0510171304580.3369@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Oct 2005, Linus Torvalds wrote:
> On Mon, 17 Oct 2005, Eric Dumazet wrote:
> > 
> > What about call_rcu_bh() which I left unchanged ? At least one of my
> > production machine cannot live very long unless I have maxbatch = 300, because
> > of an insane large tcp route cache (and one of its CPU almost filled by
> > softirq NIC processing)
> 
> I think we'll have to release 2.6.14 with maxbatch at the high value 
> (10000).

Btw, I'm going to apply your patch in _addition_ to the bigger maxbatch 
value.

It might help latency a bit, but more importantly, on one of my machines 
(but only one - it probably depends on how much memory you have etc), I 
can re-create the out-of-file-descriptors thing even with a maxbatch of a 
million.

Probably what happens is that the rcu callbacks just grow fast enough 
without any quiescent period that the maxbatch thing just never matters: 
we simply run out of file descriptors because we haven't even gotten 
around to trying to free them yet.

I'm compiling with your patch on that machine to verify that it does 
actually help keep the queues down. Just doing a

	while : ; do cat /proc/slabinfo | grep filp; sleep 1; done

while running the test programs gives some alarming numbers as-is.

Your patch keeps the numbers _much_ more stable.

Regardless, keeping track of the number of rcu callback events we have 
will almost inevitably be part of whatever future strategy we take, so 
your patch is definitely a step in the right direction, even if we have to 
tweak it later.

			Linus
