Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278829AbRJaBNa>; Tue, 30 Oct 2001 20:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278818AbRJaBNX>; Tue, 30 Oct 2001 20:13:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18088 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278815AbRJaBNQ>;
	Tue, 30 Oct 2001 20:13:16 -0500
Date: Tue, 30 Oct 2001 20:13:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: airlied@csn.ul.ie, linux-kernel@vger.kernel.org
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
In-Reply-To: <200110310054.f9V0sEf01836@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0110302009430.3707-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Oct 2001, Linus Torvalds wrote:

> It's almost certainly _supposed_ to be a NULL pointer, but has bit 6
> set. 
> 
> So we do
> 
> 	if (dentry->d_op && dentry->d_op->d_iput)
> 
> and because dentry->d_op isn't NULL, we oops on the d_op->d_iput
> dereference.
> 
> Something is setting a bit in your dentry. Either RAM errors (do you
> have ECC memory or a history of SIGSEGV's to give any indication either
> way?) or a wild "set_bit()" pointer or similar.

... or corrupted pointer in the list, in which case we are at the address
that had never been a dentry.

Frankly, it looks like adding magic to struct dentry and struct inode
might be a good idea.  Both icache and dcache lists tend to be long,
so any memory corruption is very likely to show up in the code that
walks them.

