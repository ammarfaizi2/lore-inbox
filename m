Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318102AbSFTCfn>; Wed, 19 Jun 2002 22:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318103AbSFTCfm>; Wed, 19 Jun 2002 22:35:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:12279 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318102AbSFTCfl>; Wed, 19 Jun 2002 22:35:41 -0400
Subject: Re: [patch] (resend) credentials for 2.5.23
From: Robert Love <rml@tech9.net>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020619212909.A3468@redhat.com>
References: <20020619212909.A3468@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 19 Jun 2002 19:30:35 -0700
Message-Id: <1024540235.917.127.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-19 at 18:29, Benjamin LaHaise wrote:

> This message didn't seem to get through the first time, so here it is 
> again.  The patch is available for review at:
> 
> 	http://www.kvack.org/~blah/v2.5.23-cred.diff

Yow, big patch... that is why it did not make it through.  Vger
(silently) rejects email over ~20KB.

> Several parts of the kernel need to obtain a reference to the 
> credentials of a process: aio, nfs, dirty mmap writebacks to 
> name a few.  Additionally, POSIX threads need to be able to share 
> credentials between clones.  The patch below moves the credentials 
> out of task_struct and into struct cred, which is reference 
> counted.  It also adds support for CLONE_CRED which shares the 
> credentials between threads.  Comments?

Looks good.  I am running it now in my 2.5 tree with no apparent issues
and I looked over the patch and it looked snazzy.

Question: what semantics would be broken if CLONE_CRED was implied by
CLONE_THREAD?  Regardless of code that needs this, it would be nice to
just save the memory when using threads.  Hell,  as far as I am
concerned as long as the tasks still share a VM they could share
credentials - but I am sure that breaks something.

Next, now that all this data no longer belongs solely to current... you
need to be explicit about locking rules.  There is a capability_lock
spinlock but the long semantics are not 100% respected.  I tried to firm
them up in my capability.c cleanup one or two kernels ago... it should
be good enough and not be highly contended.

I guess the only downside would be the extra overhead in our
preciously-fast do_fork... another slab allocation etc. but that is
countered if enough stuff starts using CLONE_CRED.

Oh, and what is with the #if 0 over the set and getaffinity syscalls???
That needs to go!

	Robert Love

