Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVAWF7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVAWF7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 00:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVAWF7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 00:59:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:14864 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261230AbVAWF7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 00:59:42 -0500
Date: Sun, 23 Jan 2005 06:44:07 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Felipe Alfaro Solana <lkml@mac.com>
Cc: vlobanov <vlobanov@speakeasy.net>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, Buck Huppmann <buchk@pobox.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Andreas Gruenbacher <agruen@suse.de>,
       "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>, Olaf Kirch <okir@suse.de>
Subject: Re: [patch 1/13] Qsort
Message-ID: <20050123054407.GQ7048@alpha.home.local>
References: <20050122203326.402087000@blunzn.suse.de> <20050122203618.962749000@blunzn.suse.de> <Pine.LNX.4.58.0501221257440.1982@shell3.speakeasy.net> <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FB9BAC88-6CE2-11D9-86B4-000D9352858E@mac.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 23, 2005 at 03:03:32AM +0100, Felipe Alfaro Solana wrote:
> On 22 Jan 2005, at 22:00, vlobanov wrote:
> >#define SWAP(a, b, size)			\
> >    do {					\
> >	register size_t __size = (size);	\
> >	register char * __a = (a), * __b = (b);	\
> >	do {					\
> >	    *__a ^= *__b;			\
> >	    *__b ^= *__a;			\
> >	    *__a ^= *__b;			\
> >	    __a++;				\
> >	    __b++;				\
> >	} while ((--__size) > 0);		\
> >    } while (0)
> >
> >What do you think? :)
> 
> AFAIK, XOR is quite expensive on IA32 when compared to simple MOV 
> operatings. Also, since the original patch uses 3 MOVs to perform the 
> swapping, and your version uses 3 XOR operations, I don't see any 
> gains.

It will even be worse because we are accessing memory, and most architectures
will not be able to use a memory reference for both operands of the XOR.
Basically, what will be generated will look like this :

  tmp = *b
  *a ^= tmp
  tmp ^= *a
  *b = tmp
  *a ^= tmp

which is 5 cycles, or 4 if the two last instructions get merged. And there's
3 memory reads + 3 memory writes (assuming that the CPU will be smart enough
to reuse *a without accessing memory at instruction 3).

The move is quite faster :

   tmp1 = *a
   tmp2 = *b
   *a = tmp2
   *b = tmp1

This is 4 cycles on simple CPUs, or even 2 cycles on most of todays CPUs
which can do the first two fetches at once, and the last two writes at once.
And there are only two reads and two writes.

Clearly this one is better.

Regards,
Willy

