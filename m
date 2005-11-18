Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161021AbVKRWov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbVKRWov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbVKRWov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:44:51 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:12512 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161021AbVKRWou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:44:50 -0500
Subject: Re: [Question] spin_lock in interrupt handler.
From: Steven Rostedt <rostedt@goodmis.org>
To: liyu@ccoss.com.cn
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <437D92C5.1060902@ccoss.com.cn>
References: <4379B5EB.40709@ccoss.com.cn> <437A8867.8080809@ccoss.com.cn>
	 <437C2133.2030103@ccoss.com.cn> <200511172057.33131.kernel@kolivas.org>
	 <437D92C5.1060902@ccoss.com.cn>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 17:44:44 -0500
Message-Id: <1132353884.14048.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 16:37 +0800, liyu wrote:
> Hi, every one in LKML.
> 
>     I have one question about how to use spin_lock.
> 
>     I read Documentation/spinlocks.txt wrote by Linus. The Lesson 1 and 
> 2 are simple for me.
> But I confused in Lesson 3. The most doublt is why we can not use 
> spin_lock_irq*() version in
> interrupt handler?
> 
>     At i386, I known the interrupt is disabled in interrupt handler. I 
> think this feature is
> supplied in handware-level. The spin_lock_irqrestore() will use  'sti'  
> instruction internal, it will change interrupt mask bit in FLAGS 
> register, do this have re-enable interrupt, even in interrput handler? I 
> can not sure this.

Hello once again Liyu ;-)

I don't see where he says you can't use spin_lock_irq* in interrupt
handlers.  He only says that you are safe to use the non-irq* versions
IFF (if and only if) the locks are not used in interrupts.

So, (copied from the text itself):

---
The reasons you mustn't use these versions if you have interrupts that
play with the spinlock is that you can get deadlocks:

        spin_lock(&lock);
        ...
                <- interrupt comes in:
                        spin_lock(&lock);
---

If you hold a spin lock without interrupts disabled, and an interrupt
happens on the same CPU that holds the lock, and that interrupt handler
tries to grab the lock it will just spin until that lock is released,
which will _never_ happen, since the lock is held by the process that
was interrupted, and will not run until the interrupt (that's spinning)
is done. So you have a deadlock.

Clear?

-- Steve




