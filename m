Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTAXHBu>; Fri, 24 Jan 2003 02:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbTAXHBt>; Fri, 24 Jan 2003 02:01:49 -0500
Received: from packet.digeo.com ([12.110.80.53]:29378 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267573AbTAXHBs>;
	Fri, 24 Jan 2003 02:01:48 -0500
Date: Thu, 23 Jan 2003 23:11:17 -0800
From: Andrew Morton <akpm@digeo.com>
To: rwhron@earthlink.net
Cc: piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: big ext3 sequential write improvement in 2.5.51-mm1 gone in
 2.5.53-mm1
Message-Id: <20030123231117.29c8eb98.akpm@digeo.com>
In-Reply-To: <20030124044119.GA15252@rushmore>
References: <20030124044119.GA15252@rushmore>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2003 07:10:54.0071 (UTC) FILETIME=[BBE5A870:01C2C377]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
>
> qsbench creates heavy swap load and simultaneous ed build. (small gnu package 
> "tar xzf/configure/make/make check").

qsbench isn't really a thing which should be optimised for.  It's just a mad
swapstorm, and as far as I can tell, its memory access patterns do not follow
normal locality-of-reference patterns.

The one thing we do learn from it is that to handle mad swapstorms, the 2.5
kernel needs load control.  When you run multiple qsbench instances, they all
make equal progress and there is a tremendous amount of swapping.

In 2.4, individual instances of qsbench are able to hammer all the others
into the deck so they race ahead and exit, leaving more memory for the rest. 
So 2.4 completes multithreaded qsbench in much less time than 2.5.

2.5 will complete single-instance qsbench in maybe 5% less time than 2.4,
which indicates that there's nothing fundamentally wrong or different, apart
from the fairness artifact.

(Well, 2.5 _used_ to run it faster.  The anticipatory scheduling patch makes
2.5's qsbench a little slower than 2.4.  `qsbench -m 350' on `mem=256m').

> Good numbers for this benchmark are open to interpretation, but more
> ed builds in less time is better.  The "secs" column is how long it took
> for qsbench to do it's thing. 

It is important to specify how much memory you have, and how you are
invoking qsbench.
