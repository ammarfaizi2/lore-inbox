Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266275AbUHGGUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266275AbUHGGUk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 02:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUHGGUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 02:20:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:35715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266275AbUHGGUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 02:20:38 -0400
Date: Fri, 6 Aug 2004 23:20:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Shoemaker <c.shoemaker@cox.net>
cc: Gene Heskett <gene.heskett@verizon.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       vda@port.imtp.ilyichevsk.odessa.ua, ak@suse.de,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Possible dcache BUG
In-Reply-To: <20040806230924.GA15493@cox.net>
Message-ID: <Pine.LNX.4.58.0408062304580.24588@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
 <20040806073739.GA6617@elte.hu> <20040806004231.143c8bd2.akpm@osdl.org>
 <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org>
 <20040806230924.GA15493@cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 6 Aug 2004, Chris Shoemaker wrote:
> 
> I _was_ able to find the attached oops, but I don't think I have the
> corresponding object files, so I hope the decoding it contains is
> good enough. 

It's fine.

It oopses on

	inode->i_sb->s_op

where "i_sb" is bad and contains the pointer "0x0b7eebf8" which is 
definitely not a valid kernel pointer.

There's a few other strange details in your oops report too. One being 
that the inode pointer (in %ebx, apparently) doesn't show on the stack 
where I'd expect it to show. Hmm. That might be just a different compiler 
issue, though.

Anyway, this does look somewhat like the ones Gene is seeing. If I had to 
guess, I'd guess that either the inode pointer is bad, or it's just stale 
from an inode that has already been free'd. Most likely because of 
prune_dcache() having had a corrupt LRU list with a stale/corrupt entry.

That would blow the prefetch theory out of the water. 

		Linus
