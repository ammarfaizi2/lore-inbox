Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVLVHJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVLVHJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVLVHJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:09:24 -0500
Received: from smtp109.plus.mail.mud.yahoo.com ([68.142.206.242]:33110 "HELO
	smtp109.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932406AbVLVHJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:09:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lbAnnUeKRyro48ufVS0e5NW7/RwASpGcBmheX0Oxrqitf9chEDz3/VTeOKHvYULURvj/fha1ZjuSolQ2NrkRV4WtQhee5ZgJtHJndyj+NZ1/jME1YLssZa/AdXzA3U4UwHiOSSgM0tR9q0YGo0SOOsdmWOMlwk1aKQHBcDHTm3U=  ;
Message-ID: <43AA511B.9040400@yahoo.com.au>
Date: Thu, 22 Dec 2005 18:09:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nicolas Pitre <nico@cam.org>
CC: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix race with preempt_enable()
References: <Pine.LNX.4.64.0512211135550.26663@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512211135550.26663@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Pitre wrote:
> Currently a simple
> 
> 	void foo(void) { preempt_enable(); }
> 
> produces the following code on ARM:
> 
> foo:
> 	bic	r3, sp, #8128
> 	bic	r3, r3, #63
> 	ldr	r2, [r3, #4]
> 	ldr	r1, [r3, #0]
> 	sub	r2, r2, #1
> 	tst	r1, #4
> 	str	r2, [r3, #4]
> 	blne	preempt_schedule
> 	mov	pc, lr
> 
> The problem is that the TIF_NEED_RESCHED flag is loaded _before_ the 
> preemption count is stored back, hence any interrupt coming within that 
> 3 instruction window causing TIF_NEED_RESCHED to be set won't be 
> seen and scheduling won't happen as it should.
> 
> Nothing currently prevents gcc from performing that reordering.  There 
> is already a barrier() before the decrement of the preemption count, but 
> another one is needed between this and the TIF_NEED_RESCHED flag test 
> for proper code ordering.
> 

Nice catch, this is not ARM specific either of course.

kernel/sched.c:preempt_schedule() has an equivalent barrier after
subtracting the preempt count and before checking TIF_NEED_RESCHED,
so I think this is the correct fix.

Linus will you apply?

> Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> ---
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index d9a2f52..5769d14 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -48,6 +48,7 @@ do { \
>  #define preempt_enable() \
>  do { \
>  	preempt_enable_no_resched(); \
> +	barrier(); \
>  	preempt_check_resched(); \
>  } while (0)
>  

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
