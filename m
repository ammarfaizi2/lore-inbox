Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVCGFBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVCGFBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 00:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVCGFBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 00:01:15 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:19499 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261620AbVCGFBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 00:01:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ZdrdK5cpdzzTsrsVRp/xGGY3IEk+MIhT67e0j6EX0fw0IUy8/U0gXpTQcjkvT9ikrXGOqJ51EDg4yBmMxBysaxXN8JRjhL74sdlwZa3XyKUV/jvV8isDf0roVvyRGNBv74c4u9B3ha9nB6Z2cYgdPb1xvFglt86OFNsB8gUAfdI=
Message-ID: <29495f1d0503062101549b14e8@mail.gmail.com>
Date: Sun, 6 Mar 2005 21:01:11 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 12/14] drivers/dmapool: use TASK_UNINTERRUPTIBLE instead of TASK_INTERRUPTIBLE
Cc: domen@coderock.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com,
       Patrick Mochel <mochel@digitalimplant.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20050306194414.68239e90.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050306223654.3EE871EC90@trashy.coderock.org>
	 <20050306194414.68239e90.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Mar 2005 19:44:14 -0800, Andrew Morton <akpm@osdl.org> wrote:
> domen@coderock.org wrote:
> >
> >  use TASK_UNINTERRUPTIBLE  instead of TASK_INTERRUPTIBLE
> >
> >  Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> >  Signed-off-by: Domen Puncer <domen@coderock.org>
> >  ---
> >
> >
> >   kj-domen/drivers/base/dmapool.c |    2 +-
> >   1 files changed, 1 insertion(+), 1 deletion(-)
> >
> >  diff -puN drivers/base/dmapool.c~task_unint-drivers_base_dmapool drivers/base/dmapool.c
> >  --- kj/drivers/base/dmapool.c~task_unint-drivers_base_dmapool        2005-03-05 16:11:21.000000000 +0100
> >  +++ kj-domen/drivers/base/dmapool.c  2005-03-05 16:11:21.000000000 +0100
> >  @@ -293,7 +293,7 @@ restart:
> >               if (mem_flags & __GFP_WAIT) {
> >                       DECLARE_WAITQUEUE (wait, current);
> >
> >  -                    current->state = TASK_INTERRUPTIBLE;
> >  +                    set_current_state(TASK_UNINTERRUPTIBLE);
> >                       add_wait_queue (&pool->waitq, &wait);
> >                       spin_unlock_irqrestore (&pool->lock, flags);
> 
> This code is alread a bit odd.  If we're prepared to sleep in there, then
> why use GFP_ATOMIC?
> 
> If it is so that we can dig a bit deeper into the free page pools then
> something like __GFP_WAIT|__GFP_HIGH would be preferable.
> 
> And why isn't mem_flags passed into pool_alloc_page() verbatim?

Sorry, far beyond my abilities :(
 
> I agree on the TASK_UNINTERRUPTIBLE change: if the calling task happens to
> have signal_pending() then the schedule_timeout() will fall right through.
> Why should we change kernel memory allocation strategy if the user hit ^C?

Yup, didn't make much sense to me.
 
> Also, __set_current_state() can be user here: the add_wait_queue() contains
> the necessary barriers.  (Grubby, but we do that in quite a few places with
> this particular code sequence (we should have an add_wait_queue() variant
> which does the add_wait_queue+__set_current_state all in one hit (but let's
> not, else I'll be buried in another 1000 cleanuplets))).

Ok, I will re-spin this patch. Or would you prefer an incremental one?

Thanks,
Nish
