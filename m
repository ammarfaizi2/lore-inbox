Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbULKBDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbULKBDK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 20:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbULKBDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 20:03:10 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:59098 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261896AbULKBDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 20:03:07 -0500
Subject: Re: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel
	series
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>, Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trivial@rustcorp.com.au
In-Reply-To: <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
References: <200412091459.51583.pisa@cmp.felk.cvut.cz>
	 <1102712732.3264.73.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0412101454510.31040@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102723114.4774.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Dec 2004 23:58:35 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-10 at 22:55, Linus Torvalds wrote:
> On Fri, 10 Dec 2004, Alan Cox wrote:
> The vm86 interrupt does not allow sharing. And it really _has_ to be 
> disabled until user mode has cleared the irq source, or you'll have a very 
> dead machine.

Until the 10,000th event it actually seems to work rather happily
without
that change. The interrupt has already occurred at this point and it was
edge triggered so the interrupt will be cleared down by the kernel on
the irq handler return path. Nothing expects that interrupt to get
re-enabled, or deals with refcounting in his patch, or with races. It
doesn't need disable_irq except for level triggered and vm86 has never
handled that. In fact right now it can't because multiple signals are
merged and you never know how many IRQ events occurred.

That limit works because the old vm86 irq hack only works with the edge
triggered old style PC ISA interrupts.

