Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVDOQOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVDOQOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 12:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVDOQOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 12:14:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52908 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261854AbVDOQOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 12:14:02 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050408223927.GA22217@kvack.org> 
References: <20050408223927.GA22217@kvack.org>  <1112224663.18019.39.camel@lade.trondhjem.org> <1112309586.27458.19.camel@lade.trondhjem.org> <20050331161350.0dc7d376.akpm@osdl.org> <1112318537.11284.10.camel@lade.trondhjem.org> <20050401141225.GA3707@in.ibm.com> <20050404155245.GA4659@in.ibm.com> <20050404162216.GA18469@kvack.org> <1112637395.10602.95.camel@lade.trondhjem.org> <20050405154641.GA27279@kvack.org> <20050407114302.GA13363@infradead.org> 
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-aio@kvack.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for asynchronous I/O 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 15 Apr 2005 17:13:44 +0100
Message-ID: <29082.1113581624@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin LaHaise <bcrl@kvack.org> wrote:

> Oh dear, this is going to take a while.  In any case, here is such a 
> first step in creating such a sequence of patches.  Located at 
> http://www.kvack.org/~bcrl/patches/mutex-A0/ are the following patches:
> ...
> 	10_new_mutex.diff - Replaces the semphore mutex with a new mutex 
> 			    derrived from Trond's iosem patch.  Note that 
> 			    this fixes a serious bug in iosems: see the 
> 			    change in mutex_lock_wake_function that ignores 
> 			    the return value of default_wake_function, as 
> 			    on SMP a process might still be running while 
> 			    we actually made progress.

Can I suggest you don't use a wait_queue_t in your mutex? The way you've
implemented your mutex you appear to have to take spinlocks and disable
interrupts a lot more than is necessary.

You might want to look at how I've implemented semaphores for the frv arch:

	include/asm-frv/semaphore.h
	arch/frv/kernel/semaphore.c

On FRV disabling interrupts is quite expensive, so I've made my own simple
semaphores that don't need to take spinlocks and disable interrupts in the
down() path once the sleeping task has been queued[*]. These work in exactly
the same way as rwsems.

  [*] except for the case where down_interruptible() is interrupted.

The point being that since up() needs to take the semaphore's spinlock anyway
so that it can access the list, up() does all the necessary dequeuing of tasks
before waking them up.

David
