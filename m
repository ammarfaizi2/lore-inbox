Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277333AbRJJR0P>; Wed, 10 Oct 2001 13:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277331AbRJJR0F>; Wed, 10 Oct 2001 13:26:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22803 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277330AbRJJRZv>; Wed, 10 Oct 2001 13:25:51 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Date: Wed, 10 Oct 2001 17:25:22 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9q20a2$2cg$1@penguin.transmeta.com>
In-Reply-To: <OF206EE8AA.7A83A16B-ON88256AE1.005467E3@boulder.ibm.com> <20011010185848.D726@athlon.random>
X-Trace: palladium.transmeta.com 1002734779 8510 127.0.0.1 (10 Oct 2001 17:26:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Oct 2001 17:26:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011010185848.D726@athlon.random>,
Andrea Arcangeli  <andrea@suse.de> wrote:
>
>However the more I think about it the more I suspect we'd better use
>rmb() in all readers in the common code

Absolutely.  It's not that expensive an operation on sane hardware.  And
it's definitely conceptually the only right thing to do - we're saying
that we're doing a read that depends on a previous read having seen
previous memory.  Ergo, "rmb()". 

Of course, right now Linux only exports a subset of the potential memory
barriers, and maybe we should export a fuller set - allowing CPU's that
have stricter ordering to possibly make it a no-op.  But thinking about
even something like x86, I don't see where Intel would guarantee that
two reads (data-dependent or not) would have some implicit memory
ordering. 

Re-ordering reads with data dependencies is hard, but it happens quite
naturally in a CPU that does address speculation. I don't know of
anybody who does that, but I bet _somebody_ will. Maybe even the P4?

			Linus
