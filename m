Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWGYA0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWGYA0y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWGYA0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:26:54 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:21473 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932355AbWGYA0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:26:53 -0400
Date: Mon, 24 Jul 2006 20:21:09 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless
  current->personality permits it
To: Al Boldi <a1426z@gawab.com>
Cc: Paulo Marques <pmarques@grupopie.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Frank van Maarseveen <frankvm@frankvm.com>
Message-ID: <200607242023_MC3-1-C5FE-CADA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200607241857.46594.a1426z@gawab.com>

On Mon, 24 Jul 2006 18:57:46 +0300, Al Boldi wrote:
>
> > With your changes on:
> >
> > stock kernel, randomize_va_space=0, gcc.322 -Os tstExec.c,
> > while :; do ./a.out; done
> > &x = 0xbffff874, &y = 0xbffff86c   28   28
> > &x = 0xbffff874, &y = 0xbffff86c   27   27  
> > &x = 0xbffff874, &y = 0xbffff86c   27   27
> > &x = 0xbffff874, &y = 0xbffff86c   28   27
> > &x = 0xbffff874, &y = 0xbffff86c   27   30
> > &x = 0xbffff874, &y = 0xbffff86c   27   29
> >
> > stock kernel, randomize_va_space=1, gcc.322 -Os tstExec.c,
> > while :; do ./a.out; done
> > &x = 0xbfe2e614, &y = 0xbfe2e60c   29   28
> > &x = 0xbfd6a104, &y = 0xbfd6a0fc   55   56  
> > &x = 0xbf91d454, &y = 0xbf91d44c   27   27
> > &x = 0xbf941e84, &y = 0xbf941e7c   55   56
> > &x = 0xbfa75834, &y = 0xbfa7582c   28   27
> > &x = 0xbfb58634, &y = 0xbfb5862c   27   30
>
> After closer inspection, it looks like addresses ending with 3c,7c,bc,fc 
> cause a slowdown on P4, while addresses ending with 1c,3c,5c,7c,9c,bc,dc,fc 
> cause a slowdown on P2.
>

Those addresses cause 'y' to span a cacheline (P4 = 64 bytes, P2 = 32.)
Even when the kernel aligns to 128 bytes this could happen depending
on how deeply you nest functions.

> Any easy way to instruct the kernel to skip those addresses?

First, I think you need to define locals in order of decreasing size.
IOW 'x' and 'y' need to be first inside fn(), but that may not work
when things get inlined.  So using the '-malign-double' GCC option,
or forcing alignment with '__attribute__ ((aligned(8)))' for each variable
might be better.

Then you have to make sure the stack is aligned. See
'-mpreferred-stack-boundary'.

I still think the kernel should be aligning the stack to 128 bytes anyway.

-- 
Chuck

