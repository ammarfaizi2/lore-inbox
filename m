Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267191AbUFZQyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267191AbUFZQyk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUFZQyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:54:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:30099 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267191AbUFZQy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:54:28 -0400
Date: Sat, 26 Jun 2004 09:54:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix the cpumask rewrite
In-Reply-To: <1088268405.1942.25.camel@mulgrave>
Message-ID: <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave>  <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
 <1088268405.1942.25.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 Jun 2004, James Bottomley wrote:
>
> On Sat, 2004-06-26 at 11:32, Linus Torvalds wrote:
> > Why not? The thing is, the bitmap operators are supposed to work on 
> > volatile data, ie people are literally using them for things like
> > 
> > 	while (test_bit(TASKLET_STATE_SCHED, &t->state));
> > 
> > and the thing is supposed to work.
> 
> Well, I agree it's supposed to work, what I don't agree about is that
> generic code gets to designate critical data as volatile.

I agree in the sense that I don't think the _data_ should be volatile.

But I think the functions to access various pieces of data should be able 
to take volatiles without warning.

See the difference? Same way "memcpy()" takes a "const" argument for the 
source. That doesn't mean that the source _has_ to be const, it just means 
that it won't complain if it is.

And the same is true of "volatile" for the bitop functions. They are 
volatile not because they require the data to be volatile, but because 
they have at least traditionally been used for various cases, _including_ 
volatile.

Now, we could say that we don't do that any more, and decide that the 
regular bitop functions really cannot be used on volatile stuff. But 
that's a BIG decision. And it's certainly not a decision that parisc 
users should make.

> Our current set bit functions are *coded* to operate on volatile data,
> we just don't use the volatile keyword to persuade gcc to generate
> better code.

Well, at least judging by your "test_bit()", the function literally is 
_not_ coded to work with volatile data.

If the above loop had been a real case, gcc on parisc would have optimized 
it away, and done the wrong thing.

		Linus
