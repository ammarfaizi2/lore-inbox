Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVHKVbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVHKVbJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 17:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751009AbVHKVbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 17:31:09 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:45864 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750989AbVHKVbI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 17:31:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RI5QXXYls+98aKZCAzF1xqHe7Lgl1tVVCbw/9n8NVhuyKDnSAdsOOPX/nAN20PiN5x1I42dIBSHnCCkbnPMiFlEI4db+Z8RTEW3JM5aDNVxN8cTxgCKg/XIYyVp2dKBJ8aLnbe5D5kyrFp/70lDvdsS5LAAyvMkTRViOJWzfKgg=
Message-ID: <29495f1d05081114312e3dc2fa@mail.gmail.com>
Date: Thu, 11 Aug 2005 14:31:07 -0700
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: "John M. King" <jmking1@uiuc.edu>
Subject: Re: Possible race in sound/oss/forte.c ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42FB8522.7080605@uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42FB8522.7080605@uiuc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, John M. King <jmking1@uiuc.edu> wrote:
> I know the OSS drivers are deprecated, but I'm trying to figure this out
> for my own understanding.
> 
> Here's code from sound/oss/forte.c, in the write system call handler.  A
> test has already been performed (under the protection of the lock) and
> the driver has decided to sleep.
> 
>     add_wait_queue (&channel->wait, &wait);
> 
>     for (;;) {
>         spin_unlock_irqrestore (&chip->lock, flags);
> 
>         set_current_state (TASK_INTERRUPTIBLE);
>         schedule();
> 
>         spin_lock_irqsave (&chip->lock, flags);
> 
>         if (channel->frag_num - channel->filled_frags)
>             break;
>     }
> 
>     remove_wait_queue (&channel->wait, &wait);
>     set_current_state (TASK_RUNNING);
> 
> The driver's interrupt handler calls wake_up_all().  What if an
> interrupt occurs just after the spin_unlock_irqrestore() but before
> setting TASK_INTERRUPTIBLE (and the interrupt handler does stuff that
> causes the tested conditional to be true as well)?  The interrupt calls
> wake_up_all(), but then when control returns here, the process will mark
> itself TASK_INTERRUPTIBLE right away and sleep, effectively missing the
> wake_up_all().
> 
> Is this a race condition?  If not, can someone point out the error(s) in
> my reasoning?  Please CC me as I'm not subscribed to the list.

This is broken code. You are supposed to set the state before adding
oneself to the wait-queue, if you are going to unconditionally sleep,
I believe.

So, the loop probably should be:

prepare_to_wait(&channel->wait, &wait, TASK_INTERRUPTIBLE);

for (;;) {
         spin_unlock_irqrestore (&chip->lock, flags);
 
         set_current_state (TASK_INTERRUPTIBLE); // redundant in the
first iteration
         schedule();
 
         spin_lock_irqsave (&chip->lock, flags);
 
         if (channel->frag_num - channel->filled_frags)
             break;
}
 
finish_wait(&channel->wait, &wait);

Thanks,
Nish
