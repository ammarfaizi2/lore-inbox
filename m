Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSJUTRs>; Mon, 21 Oct 2002 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261586AbSJUTRs>; Mon, 21 Oct 2002 15:17:48 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:34714 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261571AbSJUTRp>;
	Mon, 21 Oct 2002 15:17:45 -0400
Message-ID: <3DB4544B.806@colorfullife.com>
Date: Mon, 21 Oct 2002 21:23:55 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: mingming cao <cmm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]IPC locks breaking down with RCU
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh wrote:

>I had toyed with the idea of never
>freeing entries once allocated, which is a similarly simple solution;
>

Not possible, the structure size for ipc sem depends on the number of 
semaphores in the semaphore set.

Probably the best approach is to add a "deleted" flag into the ipc_id 
structure, and to check that flag after acquiring the spinlock. And 
perform the actual free operations for the ipc element in a rcu callback.
At which context do the rcu callbacks run? The semaphore sets are 
allocated with vmalloc for large sets, and that function is only 
permitted from process context, not from bh or irq context. According to 
a comment in rcupdate.c, rcu_process_callbacks runs in a tasklet, i.e. 
at bh context.

>I'm happy to be overruled by someone who understands these cacheline
>bounce issues better than we do, but nobody else has spoken up yet.
>  
>
Are there any good documents about cacheline bouncing, or rules how to 
reduce it?

For example, should a spinlock and the data it protects be in the same 
cacheline, or in different cachelines?
I guess that "same cacheline" means that only one cacheline is 
transfered if a cpu acquires the spinlock and touches the data.
But OTHO a spinning cpu would probably force the cacheline into shared 
state, and that'll slow down the data access for the cpu that owns the 
spinlock.

--
    Manfred

