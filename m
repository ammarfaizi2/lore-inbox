Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263206AbRFEEYA>; Tue, 5 Jun 2001 00:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbRFEEXu>; Tue, 5 Jun 2001 00:23:50 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:62219 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S263206AbRFEEXe>;
	Tue, 5 Jun 2001 00:23:34 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15132.24313.192723.285372@argo.ozlabs.ibm.com>
Date: Tue, 5 Jun 2001 14:24:25 +1000 (EST)
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Akash Jain <aki.jain@stanford.edu>, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, su.class.cs99q@nntp.stanford.edu
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <01060422150505.08443@starship>
In-Reply-To: <Pine.LNX.4.21.0106031652090.32451-100000@penguin.transmeta.com>
	<01060422150505.08443@starship>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:

> We'd better know the upper bound of interrupt allocations or we have an 
> accident waiting to happen.  How much of the kernel stack is reserved 
> for interrupts?

Since interrupt handlers generally run with other interrupts enabled,
and only their own interrupt disabled, it seems to me that the bound
on how much stack space you need to leave for interrupt handlers
depends on how many different interrupts you have in the system.  On a
large system there could easily be tens or even hundreds of active
devices, all with different IRQs.  It would be possible (although
unlikely) for them to all to interrupt at just the right time to get
all their handlers stacked, and that could easily overflow the stack.

One solution would be to start running interrupt handlers with
interrupts disabled (__cli) when they are getting close to being too
deeply nested - it would not be hard to check the stack pointer and if
there is less than some defined amount of stack space left then we
don't do the __sti before calling the handler.

Paul.
