Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269799AbUJMTCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269799AbUJMTCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 15:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269790AbUJMTAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 15:00:42 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:22412 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S269787AbUJMS6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:58:36 -0400
Subject: Re: waiting on a condition
From: Martijn Sipkema <martijn@entmoot.nl>
To: "Peter W. Morreale" <morreale@radiantdata.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <416D49FF.10003@radiantdata.com>
References: <02bb01c4b138$8a786f10$161b14ac@boromir>
	 <416D49FF.10003@radiantdata.com>
Content-Type: text/plain
Message-Id: <1097701123.4648.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 13 Oct 2004 22:58:53 +0200
Content-Transfer-Encoding: 7bit
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 17:30, Peter W. Morreale wrote:
> Have you looked at the wait_event() family yet?       Adapting that 
> methodolgy might
> suit your needs.

wait_event() seems to be what I was looking for; I don't really like the
condition being an argument.

> I don't know much about preemption yet, however I suspect it would be a 
> bug to allow
> preemption while the spinlock was held.  In other words, you might need 
> to do something like
> 
> disable preemption
> spinlock
> rc = condition
> spin_unlock
> enable preemption
> if (rc)
> ...
> 
> In other words, perform the test on the condition outside of the 
> critical region protected by the spin lock.

Well, that wasn't what I meant exactly. I was looking for a standard
way to wait on a condition so that it would still work when spinlocks
are converted to mutexes such as these new RT patches seem to do;
wait_event() seens to provide this, although I like to POSIX mutex/cond
semantics better.


--ms


P.S. I seem to have been removed from the LKML right after posting
my question (it was the last message I received). Is there something
terribly stupid I may have done? Was the question _that_ stupid?



> -PWM
> 
> 
> Martijn Sipkema wrote:
> 
> >L.S.
> >
> >I'd like to do something similar as can be done using a POSIX condition
> >variable in the kernel, i.e. wait for some condition to become true. The
> >pthread_cond_wait() function allows atomically unlocking a mutex and
> >waiting on a condition. I think I should do something like:
> >(the condition is updated from an interrupt handler)
> >
> >disable interrupts
> >acquire spinlock
> >if condition not satisfied
> >    add task to wait queue
> >    set task to sleep
> >release spinlock
> >restore interrupts
> >schedule
> >
> >Now, this will only work with preemption disabled within the critical
> >section. How would something like this be done whith preemption
> >enabled?
> >
> >
> >--ms
> >
> >
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >  
> >

