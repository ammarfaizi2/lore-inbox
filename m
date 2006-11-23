Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757326AbWKWKS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326AbWKWKS7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757335AbWKWKS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:18:59 -0500
Received: from smtp-out.google.com ([216.239.45.12]:28690 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1757326AbWKWKS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:18:57 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=TG701y+2b+KITqHUTqQqug4ezjWiPNSYzATDE0+gM3RxO0zbq0SQc4qazCM0IO33q
	STwtUtvKQYQbIhsh0FnVA==
Message-ID: <6599ad830611230218w7a6c0c0el9479b497037b0be6@mail.gmail.com>
Date: Thu, 23 Nov 2006 02:18:46 -0800
From: "Paul Menage" <menage@google.com>
To: "Pavel Emelianov" <xemul@openvz.org>
Subject: Re: [ckrm-tech] [PATCH 4/13] BC: context handling
Cc: "Kirill Korotaev" <dev@sw.ru>, "Andrew Morton" <akpm@osdl.org>,
       ckrm-tech@lists.sourceforge.net,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       matthltc@us.ibm.com, hch@infradead.org,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, oleg@tv-sign.ru,
       devel@openvz.org
In-Reply-To: <45657030.7050009@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45535C18.4040000@sw.ru> <45535E11.20207@sw.ru>
	 <6599ad830611222348o1203357tea64fff91edca4f3@mail.gmail.com>
	 <45655D3E.5020702@openvz.org>
	 <6599ad830611230053m7182698cu897abe5d19471aff@mail.gmail.com>
	 <456567DD.6090703@openvz.org>
	 <6599ad830611230131w1bf63dc1m1998b55b61579509@mail.gmail.com>
	 <45657030.7050009@openvz.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/06, Pavel Emelianov <xemul@openvz.org> wrote:
> Paul Menage wrote:
> > On 11/23/06, Pavel Emelianov <xemul@openvz.org> wrote:
> >> You mean moving is like this:
> >>
> >> old_bc = task->real_bc;
> >> task->real_bc = new_bc;
> >> cmpxchg(&tsk->exec_bc, old_bc, new_bc);
> >>
> >> ? Then this won't work:
> >>
> >> Initialisation:
> >> current->exec_bc = init_bc;
> >> current->real_bc = init_bc;
> >> ...
> >> IRQ:
> >> current->exec_bc = init_bc;
> >> ...
> >>                              old_bc = tsk->real_bc; /* init_bc */
> >>                              tsk->real_bc = bc1;
> >>                              cx(tsk->exec_bc, init_bc, bc1); /* ok */
> >> ...
> >> Here at the middle of an interrupt
> >> we have bc1 set as exec_bc on task
> >> which IS wrong!
> >
> > You could get round that by having a separate "irq_bc" that's never
> > valid for a task not in an interrupt.
>
> No no no. This is not what is needed. You see, we do have to
> set exec_bc as temporary (and atomic) context. Having temporary
> context is 1. flexible 2. needed by beancounters' network accountig.

I don't see why having an irq_bc wouldn't solve this. At the start of
the interrupt handler, set current->exec_bc to &irq_bc; at the end set
it to current->real_bc; use the cmpxchg() that I suggested to ensure
that you never update task->exec_bc from another task if it's not
equal to task->real_bc; use RCU to ensure that a beancounter is never
freed while someone might be accessing it.

>
> Maybe we can make smth similar to wait_task_inactive and change
> it's beancounter before unlocking the runqueue?

That could work too.

Paul
