Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262149AbSI0Q6h>; Fri, 27 Sep 2002 12:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262153AbSI0Q6h>; Fri, 27 Sep 2002 12:58:37 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9229 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262149AbSI0Q6g>; Fri, 27 Sep 2002 12:58:36 -0400
Date: Fri, 27 Sep 2002 10:05:17 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@zip.com.au>, Rusty Russell <rusty@rustcorp.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 'virtual => physical page mapping cache', vcache-2.5.38-B8
In-Reply-To: <Pine.LNX.4.44.0209271856480.15791-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209271001030.2013-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Ingo Molnar wrote:
> 
> i agree, first hashing the vcache should work. There are some details:  
> if we first hash the vcache then we have to set up the queue in a way for
> the callback function to notice that this queue is not futex-hashed (ie.  
> not live) yet. Otherwise the callback function might attempt to rehash it.  
> This means one more branch in the callback function, not a problem.

Not necessarily. You can solve _this_ problem by just holding the futex 
lock over the whole operation. If the COW happens "early" on another CPU, 
it will then be serialized by the futex lock in the callback function.

The futex lock itself is hopefully not going to be contended very much,
making the "get it early" approach acceptable. Although if it later _does_
get contended, we'll need to split it up some way: it cannot be hashed
sanely with the above approach, since there are no unique sub-indexes to
hash off as the physical page and offset have zero correlation with the VM
/ virtual address.

		Linus

