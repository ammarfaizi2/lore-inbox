Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWIGIdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWIGIdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 04:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWIGIdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 04:33:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:31377 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751125AbWIGIdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 04:33:07 -0400
Date: Thu, 7 Sep 2006 04:32:44 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: sebastien.dugue@bull.net, arjan@infradead.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org, pierre.peiffer@bull.net,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: NPTL mutex and the scheduling priority
Message-ID: <20060907083244.GA12531@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060612124406.GZ3115@devserv.devel.redhat.com> <1150125869.3835.12.camel@frecb000686> <20060613.010628.41632745.anemo@mba.ocn.ne.jp> <20060907.171158.130239448.nemoto@toshiba-tops.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907.171158.130239448.nemoto@toshiba-tops.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 05:11:58PM +0900, Atsushi Nemoto wrote:
> Three months after, I have tried kernel 2.6.18 with recent glibc.  I
> got desired results for pthread_mutex_unlock and
> pthread_cond_broadcast, with PI-mutex.
> 
> But pthread_cond_signal and sem_post still wakeup a thread in FIFO
> order, as you can guess.
> 
> With the plist patch (applied by hand), I can get desired behavior.
> Thank you.  But It seems the patch lacks reordering on priority
> changes.

Yes, either something like the plist patch for FUTEX_WAKE etc. or, if that
proves to be too slow for the usual case (non-RT threads), FIFO wakeup
initially and conversion to plist wakeup whenever first waiter with realtime
priority is added, is still needed.  That will cure e.g. non-PI
pthread_mutex_unlock and sem_post.  For pthread_cond_{signal,broadcast} we
need further kernel changes, so that the condvar's internal lock can be
always a PI lock.

> <off_topic>
> BTW, If I tried to create a PI mutex on a kernel without PI futex
> support, pthread_mutexattr_setprotocol(PTHREAD_PRIO_INHERIT) returned
> 0 and pthread_mutex_init() returned ENOTSUP.  This is not a right
> behavior according to the manual ...
> </off_topic>

Why?
POSIX doesn't forbid ENOTSUP in pthread_mutex_init to my knowledge.

	Jakub
