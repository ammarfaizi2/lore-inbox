Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVLSUMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVLSUMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 15:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbVLSUME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 15:12:04 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:10927 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964939AbVLSUMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 15:12:03 -0500
Date: Mon, 19 Dec 2005 21:11:18 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [patch 00/15] Generic Mutex Subsystem
Message-ID: <20051219201118.GA22198@elte.hu>
References: <20051219013415.GA27658@elte.hu> <20051219042248.GG23384@wotan.suse.de> <Pine.LNX.4.64.0512182214400.4827@g5.osdl.org> <20051219155010.GA7790@elte.hu> <Pine.LNX.4.64.0512191053400.4827@g5.osdl.org> <20051219192537.GC15277@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051219192537.GC15277@kvack.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin LaHaise <bcrl@kvack.org> wrote:

> > [ Oh.  I'm looking at the semaphore code, and I realize that we have a 
> >   "wake_up(&sem->wait)" in the __down() path because we had some race long 
> >   ago that we fixed by band-aiding over it. Which means that we wake up 
> >   sleepers that shouldn't be woken up. THAT may well be part of the 
> >   performance problem.. The semaphores are really meant to wake up just 
> >   one at a time, but because of that race hack they'll wake up _two_ at a 
> >   time - once by up(), once by down().
> > 
> >   That also destroys the fairness. Does anybody remember why it's that 
> >   way? ]
> 
> History?  I think that code is very close to what was done in the 
> pre-SMP version of semaphores.  It is certainly possible to get rid of 
> the separate sleepers -- parisc seems to have such an implementation.  
> It updates sem->count in the wakeup path of __down().

i think we also need to look at the larger picture. If this really is a 
bug that hid for years, it shows that the semaphore code is too complex 
to be properly reviewed and improved. Hence even assuming that the mutex 
code does not bring direct code advantages (which i'm disputing :-), the 
mutex code is far simpler and thus easier to improve. We humans have a 
given number of neurons, which form a hard limit :) In fact it's the 
mutex code that made it apparent that there's something wrong with 
semaphores.

we saw that with the genirq code, with the spinlock code, with the 
preempt code. Consolidation did not add anything drastiically new, but 
code consolidation _did_ make things more hackable, and improved the end 
result far more than a splintered set of implementations would have 
looked like.

Just look at the semaphore implementations of various architectures, 
it's a quite colorful and inconsistent mix. Can you imagine adding 
deadlock debugging to each of them?

	Ingo
