Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbVLVVnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbVLVVnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 16:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030323AbVLVVnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 16:43:14 -0500
Received: from ozlabs.org ([203.10.76.45]:21141 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030315AbVLVVnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 16:43:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17323.7659.745878.823890@cargo.ozlabs.ibm.com>
Date: Fri, 23 Dec 2005 08:43:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, alan@lxorguk.ukuu.org.uk, bcrl@kvack.org,
       rostedt@goodmis.org, hch@infradead.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-Reply-To: <20051222050701.41b308f9.akpm@osdl.org>
References: <20051222114147.GA18878@elte.hu>
	<20051222035443.19a4b24e.akpm@osdl.org>
	<20051222122011.GA20789@elte.hu>
	<20051222050701.41b308f9.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Ingo Molnar <mingo@elte.hu> wrote:
> >  - 'struct mutex' is smaller: on x86, 'struct semaphore' is 20 bytes, 
> >    'struct mutex' is 16 bytes. A smaller structure size means less RAM 
> >    footprint, and better CPU-cache utilization.
> 
> Because of the .sleepers thing.  Perhaps a revamped semaphore wouldn't need
> thsat field?

Note that semaphores on 32-bit PPC are only 16 bytes already, since I
got rid of the sleepers field ages ago.  The fast path is just
atomic_dec/inc, and the slow path needs an atomic op that does

	x = max(x, 0) + inc

atomically and returns the old value of x.  That's easy to do with
lwarx/stwcx (just two more instructions than an atomic inc), and can
also be done quite straightforwardly with cmpxchg.  Alpha, mips, s390
and sparc64 also use this scheme.

In fact I would go so far as to say that I cannot see how it would be
possible to do a mutex any smaller or faster than a counting semaphore
on these architectures.

Regards,
Paul.
