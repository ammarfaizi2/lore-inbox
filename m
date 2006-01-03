Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWACXFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWACXFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWACXFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:05:08 -0500
Received: from ns2.suse.de ([195.135.220.15]:43683 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964787AbWACXFH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:05:07 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Date: Wed, 4 Jan 2006 00:05:50 +0100
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200601032158.14057.ak@suse.de> <43BAF72C.2030608@cosmosbay.com>
In-Reply-To: <43BAF72C.2030608@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601040005.50504.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 January 2006 23:14, Eric Dumazet wrote:
> Andi Kleen a écrit :
> > This is a RFC for now. I would be interested in testing
> > feedback. Patch is for 2.6.15.
> >
> > Optimize select and poll by a using stack space for small fd sets
> >
> > This brings back an old optimization from Linux 2.0. Using
> > the stack is faster than kmalloc. On a Intel P4 system
> > it speeds up a select of a single pty fd by about 13%
> > (~4000 cycles -> ~3500)
>
> Was this result on UP or SMP kernel ? Preempt or not ?

SMP kernel, non preempt, on a uniprocessor hyperthreaded CPU.

>
> I think we might play in do_pollfd() and use fget_light()/fput_light()
> instead of fget()/fput() that are somewhat expensive because of atomic
> inc/dec on SMP.

One idea was to just cache the file references over multiple syscalls and only
free them using a timer or when some thread calls close().
This would also avoid taking the spinlocks to set up the wait queues.

Then a new select or poll would just check if the input set matches
the caches and only fix up what changed.

But i didn't implement this because I would be quite a bit more complicated
instead of this simple patch.

>
> (I believe that select()/poll() based daemons are mostly non
> multi-threaded, since high performance multi-threaded programs should be
> using epoll...)

Yes, epoll should have a similar effect.

-Andi

