Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262845AbVA2Bet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbVA2Bet (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262842AbVA2Bes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:34:48 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:55714 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S262839AbVA2Bcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:32:35 -0500
Date: Fri, 28 Jan 2005 17:32:31 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why does the kernel need a gig of VM?
Message-ID: <20050129013231.GA12446@hexapodia.org>
References: <41FA9B37.1020100@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA9B37.1020100@comcast.net>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 03:06:15PM -0500, John Richard Moser wrote:
> Can someone give me a layout of what exactly is up there?  I got the
> basic idea
> 
> K 4G
> A 3G
> A 2G
> A 1G
> 
> App has 3G, kernel has 1G at the top of VM on x86 (dunno about x86_64).
> 
> So what's the layout of that top 1G?  What's it all used for?  Is there
> some obscene restriction of 1G of shared memory or something that gets
> mapped up there?

By default, the bottom 1G of physical memory is mapped into the 1G of
KVA.  (If you have less than 1G, it's all mapped.)  Thus, the TLB
remains valid across the user/kernel switch, which makes system calls
much faster.

The 4G/4G patches (google for the lwn.net overview) change this,
introducing a TLB flush on every syscall.  Better for some things
because you get more VA space, worse for most things because it's
slower.  (But it's "lots better for a few" versus "a little worse for
everybody", so the tradeoff is often worthwhile.) [1]

So the answer to your question is, "What's up there?  Memory.  All of it."
(Until you get to highmem.)

[1] The 4G/4G patch's *primary* goal is to increase the amount of KVA
    available to allow more "struct page" entries without exhausting
    lowmem.  Trying to manage 32GB or 64GB of physical memory with only
    896MB of lowmem is very difficult.  It has the additional advantage
    of allowing userland to mmap almost 4GB of stuff (as compared to
    almost 3GB without 4G/4G) which can be a nice win for database-type
    apps.

-andy
