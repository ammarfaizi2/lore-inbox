Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWGCQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWGCQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGCQ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 12:56:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750992AbWGCQ4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 12:56:44 -0400
Date: Mon, 3 Jul 2006 09:56:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, tglx@linutronix.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
In-Reply-To: <20060703005542.62df5673.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607030952440.12404@g5.osdl.org>
References: <1151885928.24611.24.camel@localhost.localdomain>
 <20060702173527.cbdbf0e1.akpm@osdl.org> <20060703074155.GA28235@flint.arm.linux.org.uk>
 <20060703005542.62df5673.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 3 Jul 2006, Andrew Morton wrote:
> 
> void handle_dynamic_tick(struct irqaction *action)
> {
> }
> 
> consumes one byte, doesn't it?  That's not very far overboard ;)

Nope, it consumes - very fundamentally - about 64 bytes.

Even in the absense of alignment (which means that it generally takes up a 
minimum of 16 bytes of real memory), it takes up what would tend to be a 
much more critical resource: a cache line.

So an empty macro is a _lot_ more efficient than an empty function call. 

For interrupt handlers, the L1 I$ miss rate is basically 100%. Even the L2 
I$ miss rate is quite noticeable, _especially_ for things that are not 
easy to prefetch (ie stuff that is out-of-line). Which means that it also 
likely takes an inordinate amount of cycles, for doing zero work.

		Linus
