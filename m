Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQLFRyC>; Wed, 6 Dec 2000 12:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbQLFRxw>; Wed, 6 Dec 2000 12:53:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3090 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129408AbQLFRxk>;
	Wed, 6 Dec 2000 12:53:40 -0500
Subject: Re: Looping Oops
To: christian.gennerat@vz.cit.alcatel.fr (Christian Gennerat)
Date: Wed, 6 Dec 2000 17:23:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        chmouel@mandrakesoft.com (Chmouel Boudjnah)
Reply-To: rmk@arm.linux.org.uk
In-Reply-To: <3A2E34EF.CADF15EC@vz.cit.alcatel.fr> from "Christian Gennerat" at Dec 06, 2000 01:45:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143iHg-0007a8-00@www.linux.org.uk>
From: rmk@www.linux.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Aiee, killing interrupt handler
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0113b13>]
> EFLAGS: 00010292
>...
> Aiee, killing interrupt handler
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0113b13>]
> EFLAGS: 00010286

You are not the only one to find this.  On the ARM kernels, I have had to
change the printk("Aiee, killing interrupt handler") to be a panic to
prevent this problem.  (Note, this is a quick fix, and will catch more
than the case it is meant to).

However, the real question is:

If we enter schedule() from interrupt context due to a bug, we call BUG().
BUG() then causes an oops to be printed, and eventually do_exit() is called.
We then hit the printk("Aiee, killing interrupt handler") in kernel/exit.c
and then re-enter schedule() still in interrupt context.  Virtual cookie to
anyone who can guess what happens next ;)

We do need some way of stopping this endless loop - the first occurance
of schedule being called in interrupt context is interesting, the rest
are not, and they just end up causing the real problem to be lost off the
screen.

	Russell K. (from elsewhere)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
