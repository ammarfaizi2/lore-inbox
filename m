Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbULJVLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbULJVLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 16:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbULJVLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 16:11:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:6052 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261198AbULJVKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 16:10:54 -0500
Date: Fri, 10 Dec 2004 13:09:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Robin Holt <holt@sgi.com>
Cc: davem@davemloft.net, holt@sgi.com, yoshfuji@linux-ipv6.org,
       hirofumi@parknet.co.jp, torvalds@osdl.org, dipankar@ibm.com,
       laforge@gnumonks.org, bunk@stusta.de, herbert@apana.org.au,
       paulmck@ibm.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       gnb@sgi.com
Subject: Re: [RFC] Limit the size of the IPV4 route hash.
Message-Id: <20041210130947.1d945422.akpm@osdl.org>
In-Reply-To: <20041210210006.GB23222@lnx-holt.americas.sgi.com>
References: <20041210190025.GA21116@lnx-holt.americas.sgi.com>
	<20041210114829.034e02eb.davem@davemloft.net>
	<20041210210006.GB23222@lnx-holt.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt <holt@sgi.com> wrote:
>
> I realize I have a special case which highlighted the problem.  My case
>  shows that not putting an upper limit or at least a drastically aggressive
>  non-linear growth cap does cause issues.  For the really large system,
>  we were seeing a size of 512MB for the hash which was limited because
>  that was the largest amount of memory available on a single node.  I can
>  not ever imagine this being a reasonable limit.  Not with 512 cpus and
>  1024 network adapters could I envision that this level of hashing would
>  actually be advantageous given all the other lock contention that will
>  be seen.

Half a gig for the hashtable does seems a bit nutty.

>  Can we agree that a linear calculation based on num_physpages is probably
>  not the best algorithm.  If so, should we make it a linear to a limit or
>  a logarithmically decreasing size to a limit?  How do we determine that
>  limit point?

An initial default of N + M * log2(num_physpages) would probably give a
saner result.

The big risk is that someone has a too-small table for some specific
application and their machine runs more slowly than it should, but they
never notice.  I wonder if it would be possible to put a little once-only
printk into the routing code: "warning route-cache chain exceeded 100
entries: consider using the rhash_entries boot option".

