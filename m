Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbVJQQCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbVJQQCT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 12:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbVJQQCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 12:02:18 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:34962 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932309AbVJQQCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 12:02:17 -0400
Message-ID: <4353CADB.8050709@cosmosbay.com>
Date: Mon, 17 Oct 2005 18:01:31 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dipankar Sarma <dipankar@in.ibm.com>, Jean Delvare <khali@linux-fr.org>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510170829000.23590@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 17 Oct 2005 18:01:34 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds a écrit :

> So I suspect that the _real_ fix is:
> 
>  - for 2.6.14: remove the batching limig (or just make it much higher for 
>    now)

I would just remove it. If the limit is wrong, we crash again. And the 
realtime guys already are pissed off by batch=10000 anyway.

> 
>  - post-14: work on making sure rcu callbacks are done in a more timely 
>    manner when the rcu queue gets long. This would involve TIF_RCUPENDING 
>    and whatever else to make sure that we have timely quiescent periods, 
>    and we do the RCU callback tasklet more often if the queue is long.
> 

Absolutely. Keeping a count of (percpu) queued items is basically free if kept 
in the cache line used by list head, so the 'queue length on this cpu' is a 
cheap metric.

A 'realtime refinement' would be to use a different maxbatch limit depending 
on the caller's priority : Let a softirq thread have a lower batch count than 
a regular user thread.

Eric
