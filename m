Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288689AbSANCuF>; Sun, 13 Jan 2002 21:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288703AbSANCt4>; Sun, 13 Jan 2002 21:49:56 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:36624 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S288689AbSANCtu>; Sun, 13 Jan 2002 21:49:50 -0500
Date: Sun, 13 Jan 2002 18:55:35 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jeff Dike <jdike@karaya.com>
cc: mingo@elte.hu, <linux-kernel@vger.kernel.org>
Subject: Re: The O(1) scheduler breaks UML
In-Reply-To: <200201140239.VAA05307@ccure.karaya.com>
Message-ID: <Pine.LNX.4.40.0201131853550.937-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Jan 2002, Jeff Dike wrote:

> The new scheduler holds IRQs off across the call to context_switch.  UML's
> _switch_to expects them to be enabled when it is called, and things go
> badly wrong when they are not.
>
> Because UML has a host process for each UML thread, SIGIO needs to be
> forwarded from one process to the next during a context switch.  A SIGIO
> arriving during the window between the disabling of IRQs and forwarding of
> IRQs to the next process will be trapped on the process going out of
> context.  This happens fairly regularly and causes hangs because some process
> is waiting for disk IO which never arrives because the process that was notified
> of the completion is switched out.
>
> So, is it possible to enable IRQs across the call to _switch_to?

Yes, this should work :


    if (likely(prev != next)) {
        rq->nr_switches++;
        rq->curr = next;
        next->cpu = prev->cpu;
        spin_unlock_irq(&rq->lock);
        context_switch(prev, next);
    } else
        spin_unlock_irq(&rq->lock);

and there's no need for barrier() and rq reload in this way.




- Davide


