Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269999AbTGVKBa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 06:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270493AbTGVKBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 06:01:30 -0400
Received: from [213.39.233.138] ([213.39.233.138]:57046 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269999AbTGVKB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 06:01:28 -0400
Date: Tue, 22 Jul 2003 12:16:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: junkio@cox.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Port SquashFS to 2.6
Message-ID: <20030722101623.GB29430@wohnheim.fh-wedel.de>
References: <fa.k0do8p6.ch6pps@ifi.uio.no> <fa.hre90bn.e6k5pf@ifi.uio.no> <7vd6g3uvbc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7vd6g3uvbc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 July 2003 19:52:39 -0700, junkio@cox.net wrote:
> >>>>> "JE" == JörnEngel  <joern@wohnheim.fh-wedel.de> writes:
>
> JE> Depending on where and what you do,...
> 
> Well, isn't asking about address_space_operations.readpage
> specific enough?

Not for someone as lazy as me.  If you want to know for sure:
- Figure out all possible path leading to that function.
- Figure out all possible path called by that function.
- Sum up all the stack allocated variable size for both.
- Add the architecture-specific function call overhead, multiplied
  by the number of functions on both paths.

Now you have the stack consumption that you were not responsible for,
which depends on the architecture.  Substract that number from the
total stack size, which is also architecture-specific and you know how
much is left.  It is a lot of work and the hard part is finding all
the possible paths.  If you have a good idea how to automate that,
please tell me.  Else, we have to live with rules of thumb.

> JE> ... also depends a bit on the architecture.  s390 has
> JE> giant stacks because function call overhead is huge, ...
> 
> The discussion was about putting variables (or arrays or large
> structs) the kernel programmer defines on the stack, and I do
> not think architecture calling convention has much to do with
> this.
> 
> If an architecture has a big stack usage per call that is
> imposed by the ABI, and larger kernel stack is allocated
> compared to other architectures because of this reason,
> shouldn't there be about the same amount of usable space left
> for the kernel programs within the allocated per-process kernel
> stack space to use?  If that is not the case then the port to
> that particular architecture would not be optimal, wouldn't it?

You end up with all sorts of architecture dependent stuff when
allocating stack.  A long is 4 or 8 bytes, same for pointers, the
amount and size of saved registers differs, the size of the stack
differs, some architectures have a seperate interrupt stack.

If you look closely at the kernel, there is currently no way of
telling whether it contains stack overflows waiting to happen, or not.
We live with lots of hope and the comforting feeling that there were
not many stack overflows in the past.  I wish we had better tools, but
we don't.

Jörn

-- 
The cheapest, fastest and most reliable components of a computer
system are those that aren't there.
-- Gordon Bell, DEC labratories
