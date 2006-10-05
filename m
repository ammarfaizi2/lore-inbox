Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWJEWkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWJEWkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWJEWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:40:10 -0400
Received: from gw.goop.org ([64.81.55.164]:58507 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932397AbWJEWkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:40:08 -0400
Message-ID: <452589C3.8000705@goop.org>
Date: Thu, 05 Oct 2006 15:40:03 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Andrew Morton <akpm@osdl.org>,
       "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       tim.c.chen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
References: <B41635854730A14CA71C92B36EC22AAC3F3FBA@mssmsx411> <20061005143748.2f6594a2.akpm@osdl.org> <45257C65.3030600@goop.org> <20061005145213.f3eaaf7d.akpm@osdl.org> <20061005220259.GA26202@gondor.apana.org.au>
In-Reply-To: <20061005220259.GA26202@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> The original reason for the return value is so you can do
>
> if (WARN_ON(impossible_condition)) {
> 	attempt_to_continue;
> }
>
> instead of 
>
> if (unlikely(impossible_condition)) {
> 	WARN_ON(1);
> 	attempt_to_continue;
> }
>   

(Hm, WARN_ON(1) is pretty ugly; we should probably have a WARN() as well.)

Why is the second one any better than the first?  It's a line less code, 
but that doesn't seem like a big deal.  It's not like passing the actual 
condition into WARN_ON is useful, because it doesn't try to print it 
out. And "if (WARN_ON_ONCE(cond)) ..." is arguably more useful (since it 
encapsulates the printing once logic), but also very unclear (does it 
evaluate true once or every time?).

There are certainly lots of places in the kernel which could use 
if(WARN_ON(...)), but I haven't found any places which actually do.  I 
just don't see what benefit you would gain in converting things to using 
if(WARN_ON(...)) anyway.

> Oh and yes the unlikely does make a difference in a statement
> expression.
>   

I was thinking something like

	unlikely(({
		...
	}))

is a bit more obvious in terms of imagining how it would get expanded 
and evaluated.

    J
