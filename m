Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVLPMtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVLPMtd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVLPMtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:49:32 -0500
Received: from science.horizon.com ([192.35.100.1]:14633 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S932235AbVLPMtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:49:31 -0500
Date: 16 Dec 2005 07:49:24 -0500
Message-ID: <20051216124924.23264.qmail@science.horizon.com>
From: linux@horizon.com
To: dhowells@redhat.com
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now my point about using LL/SC is that:
> 
> 	1,C,A	cmpxchg(0,1) [failed]
> 	1,C,A	cmpxchg(1,3) [success]
> 	3,C,A	...
> 
> Can be turned into:
> 
> 	1,C,A	x = LL()
> 	1,C,A	x |= 2;
> 	1,C,A	SC(3) [success]
> 	3,C,A	...

... which can be turned back into

 	1,C,A	x = load()
 	1,C,A	x' = x | 2;
 	1,C,A	cmpxchg(x,x') [success]
 	3,C,A	...

which will fail and retry in exactly the same contention cases as the
LL/SC.  The only thing that LL gives you that's nice is a hint that
an SC is due very soon and so resisting a cache eviction for a couple
of cycles might be a good idea.

The reason that we tend to do the former is optimism that the lock
won't be held.  If that's a bad assumption, make it more pessimistic.

LL/SC can detect double changes during the critical section, but it's
very similar in expressive power to load + CMPXCHG.
