Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268722AbUIQMwz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268722AbUIQMwz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 08:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUIQMwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 08:52:55 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:50912 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S268722AbUIQMww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 08:52:52 -0400
Date: Fri, 17 Sep 2004 08:52:46 -0400 (EDT)
From: James R Bruce <bruce@andrew.cmu.edu>
To: Andrew Morton <akpm@osdl.org>
cc: Stelian Pop <stelian@popies.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC, 2.6] a simple FIFO implementation
In-Reply-To: <20040916000438.46d91e94.akpm@osdl.org>
Message-ID: <Pine.LNX.4.60-041.0409170823140.1298@unix48.andrew.cmu.edu>
References: <20040913135253.GA3118@crusoe.alcove-fr> <20040915153013.32e797c8.akpm@osdl.org>
 <20040916064320.GA9886@deep-space-9.dsnet> <20040916000438.46d91e94.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Sep 2004, Andrew Morton wrote:
> My point is that there is no need to store the "number of bytes currently
> in the buffer", because that is always equal to `head - tail' if you allow
> those indices to freely wrap.
>
> All the struct needs is `head', `tail' and `number_of_bytes_at_buf', all
> unsigned.
>
> add(char c)
> {
> 	p->buf[p->head++ % p->number_of_bytes_at_buf] = c;
> }
>
> get()
> {
> 	return p->buf[p->tail++ %  p->number_of_bytes_at_buf];
> }

The "just let it wrap" approach will only work if number_of_bytes_at_buf 
is a power of two.  If it isn't, then the FIFO will skip back to zero at 
the wrong place after correctly storing 2^32 bytes.  I'll explain:

S = size of storage buffer
N = 1<<32 (or whatever size int is on a platform)

The hidden assumption is:
   a % S == (a % N) % S

But this is only true if:
   N % S == 0

Or in other words, that S is a power of two less than N.

> free_space()
> {
> 	return p->head - p->tail;
> }

This will of course always work fine, since S is not involved.

> pretty simple...

"Things should be made as simple as possible -- but no simpler."
  - Albert Einstein

IMHO restricting it to powers of two may not be so bad, and allows us to 
get away with using faster bitwise ANDs instead of modulus operations. 
Most FIFOs are probably power-of-two sizes anyway.  However, if the 
interface exports using any size, it'd better work that way, and not fail 
after working correctly for the first 4GB.

This is a perfect example of why we need a common, well tested 
implementation that all the drivers, etc. can use.  Keep up the excellent 
work :)

  - Jim Bruce
