Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135326AbRDLVU7>; Thu, 12 Apr 2001 17:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135329AbRDLVUl>; Thu, 12 Apr 2001 17:20:41 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:51416 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S135327AbRDLVUf>;
	Thu, 12 Apr 2001 17:20:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: andrewm@uow.edu.au
Subject: Re: [PATCH] 4th try: i386 rw_semaphores fix
Date: Thu, 12 Apr 2001 22:18:54 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com
MIME-Version: 1.0
Message-Id: <01041222185400.01072@orion.ddi.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Andrew Morton wrote:
> It still doesn't compile with gcc-2.91.66 because of the "#define
> rwsemdebug(FMT, ...)" thing. What can we do about this? 

Hmmm... It probably needs to be made conditional on the version of the 
compiler by means of the macros that hold the version numbers.

> I cooked up a few more tests, generally beat the thing 
> up. This code works. Good stuff. I'll do some more testing 
> later this week - put some delays inside the semaphore code 
> itself to stretch the timing windows, but I don't see how 
> it can break it. 

Excellent. I tried to keep it as simple as possible to make it easier to test 
and follow.

> Manfred says the rep;nop should come *before* the memory 
> operation, but I don't know if he's been heard... 

Probably... It's copied directly out of the spinlock stuff. I noticed it at 
the time, but it didn't stick in my memory.

> The spin_lock_irqsave() in up_read/up_write shouldn't be 
> necessary plus it puts the readers onto the 
> waitqueue with add_wait_queue_exclusive, so an up_write 
> will only release one reader.

Not so... have you looked at the new __wait_ctx_common() function? It 
actually ignores the exclusive flag since it uses other criteria as to whom 
to wake. All the add_wait_queue_exclusive() function does is put the process 
on the _back_ of the queue as far as rwsems are concerned.

> Other architectures need work. 
> If they can live with a spinlock in the fastpath, then 
> the code at http://www.uow.edu.au/~andrewm/linux/rw_semaphore.tar.gz 
> is bog-simple and works.

Sorry to pre-empt you, but have you seen my "advanced" patch? I sent it to 
the list in an email with the subject:

	[PATCH] i386 rw_semaphores, general abstraction patch

I added a general fallback implementation with the inline implementation 
functions written wholly in C and using spinlocks.

> Now I think we should specify the API a bit: 

Agreed... I'll think more in it on Tuesday, though... after Easter.

Your points, however, look fairly reasonable.

> Perhaps the writer-wakes-multiple 
> readers stuff isn't happening

It does. Using my test program & module, try:

	driver -5 & sleep 1; driver 100 &

Keep doing "ps", and you'll see all the reader processes jump into the S 
state at the same time, once all the writers have finished. You may need to 
increase the delay between the ups and downs in the module to see it clearly.

David Howells
