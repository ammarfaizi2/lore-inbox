Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751345AbWDWF4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWDWF4j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 01:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWDWF4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 01:56:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:5290
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751333AbWDWF4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 01:56:38 -0400
Date: Sat, 22 Apr 2006 22:56:39 -0700 (PDT)
Message-Id: <20060422.225639.93889487.davem@davemloft.net>
To: netdev@axxeo.de
Cc: simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org, ioe-lkml@rameria.de
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200604211852.47335.netdev@axxeo.de>
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
	<20060420.120955.28255828.davem@davemloft.net>
	<200604211852.47335.netdev@axxeo.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <netdev@axxeo.de>
Date: Fri, 21 Apr 2006 18:52:47 +0200

> nice to see you getting started with it.

Thanks for reviewing.

> I'm not sure about the queue logic there.
> 
> 1867 /* Caller must have exclusive producer access to the netchannel. */
> 1868 int netchannel_enqueue(struct netchannel *np, struct netchannel_buftrailer *bp)
> 1869 {
> 1870 	unsigned long tail;
> 1871
> 1872 	tail = np->netchan_tail;
> 1873 	if (tail == np->netchan_head)
> 1874 		return -ENOMEM;
> 
> This looks wrong, since empty and full are the same condition in your
> case.

Thanks, that's obviously wrong.  I'll try to fix this up.

> What about sth. like
> 
> struct netchannel {
>    /* This is only read/written by the writer (producer) */
>    unsigned long write_ptr;
>   struct netchannel_buftrailer *netchan_queue[NET_CHANNEL_ENTRIES];
> 
>    /* This is modified by both */
>   atomic_t filled_entries; /* cache_line_align this? */
> 
>    /* This is only read/written by the reader (consumer) */
>    unsigned long read_ptr;
> }

As stated elsewhere, if you add atomic operations you break the entire
idea of net channels.  They are meant to be SMP efficient data structures
where the producer has one cache line that only it dirties and the
consumer has one cache line that likewise only it dirties.

> If cacheline bouncing because of the shared filled_entries becomes an issue,
> you are receiving or sending a lot.

Cacheline bouncing is the core issue being addressed by this
data structure, so we really can't consider your idea seriously.

I've just got an off-by-one error, no need to wreck the entire
data structure just to solve that :-)
