Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTLVLdC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 06:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLVLdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 06:33:02 -0500
Received: from mail.zmailer.org ([62.78.96.67]:41352 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S264411AbTLVLc7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 06:32:59 -0500
Date: Mon, 22 Dec 2003 13:32:58 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: James Lamanna <jlamanna@ugcs.caltech.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [OT] use of patented algorithms in the kernel ok or not?
Message-ID: <20031222113258.GM1343@mea-ext.zmailer.org>
References: <opr0j63dxpz4tciz@192.168.1.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr0j63dxpz4tciz@192.168.1.1>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 05:43:51PM -0800, James Lamanna wrote:
> On Sun, 21 Dec 2003 14:40:40 -0500 Lennert Buytenhek wrote:
> >There is one already, and it's suboptimal, to say it mildly.
> 
> What algorithm does the kernel currently use for prefix-matching? I'm 
> interested now...
> And when you say suboptimal, what kind of difference are we talking?
> O(n) vs. O(1) lookups?

(I am reading 2.6.0 kernel source)

It used to be PATRICIA -- where you have binary-searchable sub-tables,
and you look from longest mask table first to see matches. If longer
mask table does not have a match, you move up to larger entries entries.

Now things are somewhat different, and murky underneath FIB-rules.
( net/ipv4/fib_*.c )   The lowest level has fib_hash.c doing lookups
thru  fn_hash_lookup()  function.

It does use hashes, which can, perhaps, do things in speedier, if not
all that cache friendly way.   Still, when you have multiple different
size prefixes, they are all processed the same way as PATRICIA does.

Original question was aiming to run with _full_ internet routing tables
in Linux kernel.  Now _that_ can be somewhat slow, and the patented
algorithm in question is able to handle it under 12 memory lookups in
all cases, while present hash-patricia chunks away a lot more time in
pessimal case.

In normal single interface IPv4 end-node usage we have 4 route entries.
(eth0, loopback, multicast, and default -routes.)  Those should be very
quick to go thru in linear search order and be processor cache friendly.

Even with a handfull of routes (and interfaces), but relying on default-
route to handle most things, I do claim that linear (ordered by mask
specifity!) search table is fastest.(*)

*) It depends on your machine hardware details, but CPU and its associated
   caches are these days factor 100 faster, than main memory random access.
   (And the gap is growing...)

> James Lamanna

/Matti Aarnio
