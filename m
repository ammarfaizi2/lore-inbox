Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbULKPXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbULKPXh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbULKPXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:23:37 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7132 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261941AbULKPXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:23:34 -0500
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
	series
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.58.0412102020190.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz>
	 <1102712732.3264.73.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
	 <1102723114.4774.9.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412101722010.31040@ppc970.osdl.org>
	 <1102726628.4948.1.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412102020190.31040@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102774756.7267.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Dec 2004 14:19:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-12-11 at 04:21, Linus Torvalds wrote:
> Alan, what _are_ you arguing about? That "disable_irq()" is absolutely 
> rquired, because:
>  - not having it locks up the machine if the irq happens to be level.
>  - not having it means that the "enable_irq()" that happens when the irq 
>    is reported to user space is unbalanced.

That part I missed. 

> > Putting a single disable_irq in doesn't change the fact it doesn't work
> > because the IRQ is never re-enabled.
> 
> Did you actually test the code? Did you ever _look_ at it?

Yes I tested it. It worked in my test code, unfortunately the enable_irq
part of it didn't show up because the other patches in that test set
included ones for dynamically detecting interrupt routing errors and
they hid it.

Alan

ps: Pavel - the X folks played with several ideas for handling
interrupts
from user space that could be shared, forwarded to user space and
handled and it always came back to either a small kernel module or an
interpretable set of
descriptions of how to test for and mask the IRQ, and in some cases to
save
several values. Something like

struct descriptor {
	u8  type:2; /* 0 PCI cfg, 1 mem, 2 I/O */
	u8  width:2;
	u32 offset;
	u32 mask;
	u32 value;
}

struct irq_descriptor {
	char name[16];			/* For request irq */
	struct descriptor test;
	struct descriptor mask;
	struct descriptor save[4];
};

although nobody ever implemented it. This would also have been outside
of just vm86 as the main user would be X.


