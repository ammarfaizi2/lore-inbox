Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267188AbUFZQsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267188AbUFZQsR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 12:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUFZQsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 12:48:17 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:43397 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267188AbUFZQsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 12:48:07 -0400
Subject: Re: [PATCH] Fix the cpumask rewrite
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> 
	<Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Jun 2004 11:46:43 -0500
Message-Id: <1088268405.1942.25.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 11:32, Linus Torvalds wrote:
> Why not? The thing is, the bitmap operators are supposed to work on 
> volatile data, ie people are literally using them for things like
> 
> 	while (test_bit(TASKLET_STATE_SCHED, &t->state));
> 
> and the thing is supposed to work.

Well, I agree it's supposed to work, what I don't agree about is that
generic code gets to designate critical data as volatile.

> Now, I personally am not a big believer in the "volatile" keyword itself, 
> since I believe that anybody who expects the compiler to generate 
> different code for volatiles and non-volatiles is pretty much waiting for 
> a bug to happen, but there are two cases where I think it's ok:
> 
>  - in function prototypes to show that the function can take volatile data 
>    (and not complain).

This is a real problem for us on parisc though.  By designating the
function prototype as volatile, you force the function implementation
*also* to be volatile.  Unfortunately, in our case, gcc seems to
generate worse code than a pigs arse when it sees volatile data lurking
anywhere in a function.

Our current set bit functions are *coded* to operate on volatile data,
we just don't use the volatile keyword to persuade gcc to generate
better code.

I realise we could hand code in assembly to get around this problem, but
our implementation actually has to use hashed spinlocks for the
volatility, so we'd rather not if we really don't have to.

The kernel has survived this far with no other bit operator data being
volatile.

>  - as an arch-specific low-level implementation detail to avoid having to 
>    use inline assembly just to load a value. Ie a _data_structure_ should 
>    never be volatile, but it's ok to use a volatile pointer for a single 
>    access.

Definitely agree here ... the arch code is really the place we know the
compiler penalty of being volatile.

James


