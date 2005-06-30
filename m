Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262822AbVF3HxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262822AbVF3HxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 03:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVF3HxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 03:53:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:50385 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262822AbVF3HxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 03:53:11 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: kmalloc without GFP_xxx?
Date: Thu, 30 Jun 2005 10:52:54 +0300
User-Agent: KMail/1.5.4
Cc: rostedt@goodmis.org, Arjan van de Ven <arjan@infradead.org>,
       Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
References: <200506291402.18064.vda@ilport.com.ua> <200506291714.32990.vda@ilport.com.ua> <42C2D0C1.4030500@ammasso.com>
In-Reply-To: <42C2D0C1.4030500@ammasso.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506301052.54570.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 19:48, Timur Tabi wrote:
> Denis Vlasenko wrote:
> 
> > This is why I always use _irqsave. Less error prone.
> 
> No, it's just bad programming.  How hard can it be to see which spinlocks are being used 
> by your ISR and which ones aren't?  Only the ones that your ISR touches should have 
> _irqsave.  It's really quite simple.

Given that I do not touch core kernel and most of spinlocks I ever
did were in drivers - yes, they are there to protect me from IRQ
handler races.

> > This is more or less what I meant. Why think about each kmalloc and when you
> > eventually did get it right: "Aha, we _sometimes_ get called from spinlocked code,
> > GFP_ATOMIC then" - you still do atomic alloc even if cases when you
> > were _not_ called from locked code! Thus you needed to think longer and got
> > code which is worse.
> 
> So you're saying that you're the kind of programmer who makes more mistakes the longer you 
> think about something?????

No.

I say that writing kmalloc(size, GFP_ATOMIC) takes more time to verify
that it is needed compared to hypothetical kmalloc_auto(size),
and yet kmalloc(size, GFP_ATOMIC) is worse in a sense thet it won't sleep
even if it happens to be called outside locks.

Think about this:

/* may be called under spinlock */
void do_something() {
	/* we need to alloc here */
}

> Using GFP_ATOMIC increases the probability that you won't be able to allocate the memory 
> you need, and it also increases the probability that some other module that really needs 
> GFP_ATOMIC will also be unable to allocate the memory it needs.  Please tell me, how is 
> this considered good programming?

Where did I say "let's use GFP_ATOMIC everywhere" ?
--
vda

