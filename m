Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWIGJab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWIGJab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 05:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWIGJab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 05:30:31 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:31409 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1751326AbWIGJaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 05:30:30 -0400
Date: Thu, 07 Sep 2006 18:30:13 +0900 (JST)
Message-Id: <20060907.183013.55145698.nemoto@toshiba-tops.co.jp>
To: jakub@redhat.com
Cc: sebastien.dugue@bull.net, arjan@infradead.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org, pierre.peiffer@bull.net,
       drepper@redhat.com
Subject: Re: NPTL mutex and the scheduling priority
From: Atsushi Nemoto <nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060907083244.GA12531@devserv.devel.redhat.com>
References: <20060613.010628.41632745.anemo@mba.ocn.ne.jp>
	<20060907.171158.130239448.nemoto@toshiba-tops.co.jp>
	<20060907083244.GA12531@devserv.devel.redhat.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
Organization: TOSHIBA Personal Computer System Corporation
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006 04:32:44 -0400, Jakub Jelinek <jakub@redhat.com> wrote:
> > But pthread_cond_signal and sem_post still wakeup a thread in FIFO
> > order, as you can guess.
> > 
> > With the plist patch (applied by hand), I can get desired behavior.
> > Thank you.  But It seems the patch lacks reordering on priority
> > changes.
> 
> Yes, either something like the plist patch for FUTEX_WAKE etc. or, if that
> proves to be too slow for the usual case (non-RT threads), FIFO wakeup
> initially and conversion to plist wakeup whenever first waiter with realtime
> priority is added, is still needed.  That will cure e.g. non-PI
> pthread_mutex_unlock and sem_post.  For pthread_cond_{signal,broadcast} we
> need further kernel changes, so that the condvar's internal lock can be
> always a PI lock.

Thank you, I'll stay tuned.

> > <off_topic>
> > BTW, If I tried to create a PI mutex on a kernel without PI futex
> > support, pthread_mutexattr_setprotocol(PTHREAD_PRIO_INHERIT) returned
> > 0 and pthread_mutex_init() returned ENOTSUP.  This is not a right
> > behavior according to the manual ...
> > </off_topic>
> 
> Why?
> POSIX doesn't forbid ENOTSUP in pthread_mutex_init to my knowledge.

http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutexattr_setprotocol.html
http://www.opengroup.org/onlinepubs/009695399/functions/pthread_mutex_init.html

>From ERRORS section of pthread_mutexattr_setprotocol:

	The pthread_mutexattr_setprotocol() function shall fail if:
	[ENOTSUP]
	    The value specified by protocol is an unsupported value. 

And ENOTSUP is not enumerated in ERRORS section of pthread_mutex_init.

---
Atsushi Nemoto
