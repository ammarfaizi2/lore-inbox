Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318229AbSHMRlm>; Tue, 13 Aug 2002 13:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318966AbSHMRku>; Tue, 13 Aug 2002 13:40:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7691 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318229AbSHMRj7>;
	Tue, 13 Aug 2002 13:39:59 -0400
Message-ID: <3D5947B7.EDE01C2E@zip.com.au>
Date: Tue, 13 Aug 2002 10:53:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: [patch 2/21] reduced locking in buffer.c
References: <3D561473.40A53C0D@zip.com.au> <Pine.LNX.4.44.0208131032210.7411-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 11 Aug 2002, Andrew Morton wrote:
> >
> > Resend.  Replace the buffer lru spinlock protection with
> > local_irq_disable and a cross-CPU call to invalidate them.
> 
> This almost certainly breaks on sparc, where CPU cross-calls are
> non-maskable, so local_irq_disable doesn't do anything for them.
> 
> Talk to Davem about this - there may be some workaround.

I have discussed it with David - he said it's OK in 2.5, but
not in 2.4, and he has eyeballed the diff.

However there's another thing to think about:

	local_irq_disable();
	atomic_inc();

If the architecture implements atomic_inc with spinlocks, this will
schedule with interrupts off with CONFIG_PREEMPT=y, I expect.

I can fix that with a preempt_disable() in there, but ick.
