Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279912AbRKIOy3>; Fri, 9 Nov 2001 09:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279906AbRKIOyT>; Fri, 9 Nov 2001 09:54:19 -0500
Received: from colorfullife.com ([216.156.138.34]:13837 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S279912AbRKIOyD>;
	Fri, 9 Nov 2001 09:54:03 -0500
Message-ID: <3BEBEE0B.BA1FD7EE@colorfullife.com>
Date: Fri, 09 Nov 2001 15:54:03 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jakub Jelinek <jakub@redhat.com>
CC: Benjamin LaHaise <bcrl@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Arjan Van de Ven <arjanv@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] take 2 of the tr-based current
In-Reply-To: <20011108190546.A29741@redhat.com> <20011108211143.A4797@redhat.com> <20011109041327.T4087@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub Jelinek wrote:
> 
> On Thu, Nov 08, 2001 at 09:11:43PM -0500, Benjamin LaHaise wrote:
> > -static unsigned get_TR(void) __attribute__ ((pure))
> > +static unsigned get_TR(void) __attribute__ ((pure));
> > +static unsigned get_TR(void)
> >  {
> >       unsigned tr;
> >       __asm__("str %w0" : "=g" (tr));
> 
> Why not
> static inline unsigned __attribute__ ((const)) get_TR(void)
> {
> }
> ?
> If TR register only ever changes during cpu_init, I don't see why you
> cannot use const.

The task register is only pure, not const. It's true that it's only
initialized during cpu_init(), but different cpus in the system have
different task register values.
	get_TR();
	schedule();
	get_TR();
must reload the task register.

But the value of "current" can be considered as const: It never changes
for a running thread. The exception are fork() and clone(), but both
functions directly call asm code and run on a fresh stack after forking.

> Using pure would mean if you do get_TR, then store
> something into global memory and do get_TR again, it will be done twice.
> Also, I wonder why you don't inline it.
>

ben?
I think get_current should be inline, const. get_TR() and
smp_processor_id would be inline, pure.

--
	Manfred
