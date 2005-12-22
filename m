Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbVLVX6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbVLVX6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 18:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVLVX6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 18:58:14 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20401 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751145AbVLVX6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 18:58:13 -0500
Date: Thu, 22 Dec 2005 15:56:32 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>, Nicolas Pitre <nico@cam.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2/8] mutex subsystem, add asm-generic/mutex-[dec|xchg].h
 implementations
In-Reply-To: <20051222230451.GC13302@elte.hu>
Message-ID: <Pine.LNX.4.64.0512221550290.14098@g5.osdl.org>
References: <20051222230451.GC13302@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Dec 2005, Ingo Molnar wrote:
>
> add the two generic mutex fastpath implementations.

Now this looks more like it. This is readable code without any #ifdef's in 
the middle.

Now the only #ifdef's seem to be for mutex debugging. Might it be 
worthwhile to have a generic debugging, that just uses spinlocks and just 
accept that it's going to be slow, but shared across absolutely all 
architectures?

Then you could have <linux/mutex.h> just doing a single

	#ifdef CONFIG_MUTEX_DEBUG
	# include <asm-generic/mutex-dbg.h>
	#else
	# include <asm/mutex.h>
	#endif

and have muted-dbg.h just contain prototypes (no point in inlining them, 
they're going to be big anyway) and then have a 

	obj$(CONFIG_MUTEX_DEBUG) += mutex-debug.c

in the kernel/ subdirectory? That way you could _really_ have a clean 
separation, with absolutely zero pollution of any architecture mess or 
debugging #ifdef's in any implementation code.

At that point I'd like to switch to mutexes just because the code is 
cleaner!

		Linus
