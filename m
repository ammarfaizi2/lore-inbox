Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTDVWlS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 18:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263884AbTDVWlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 18:41:18 -0400
Received: from fmr05.intel.com ([134.134.136.6]:50671 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263888AbTDVWlP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 18:41:15 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C263B3E@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Tom Zanussi'" <zanussi@us.ibm.com>
Cc: "'karim@opersys.com'" <karim@opersys.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [patch] printk subsystems
Date: Tue, 22 Apr 2003 15:53:04 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Tom Zanussi [mailto:zanussi@us.ibm.com]
> Perez-Gonzalez, Inaky writes:
>  > > From: Tom Zanussi [mailto:zanussi@us.ibm.com]
>  > >
>  > > In relayfs, the event can be generated directly into the space
>  > > reserved for it - in fact this is exactly what LTT does.  There
aren't
>  > > two separate steps, one 'generating' the event and another copying it
>  > > to the relayfs buffer, if that's what you mean.
>  >
>  > In this case, what happens if the user space, through mmap, copies
>  > while the message is half-baked (ie, from another CPU) ... won't it
>  > be inconsistent?
> 
> There's a count kept, per sub-buffer, that's updated after each write.
> If this count doesn't match the expected size of the sub-buffer, the
> reader can ignore the incomplete buffer and come back to it later.
> The count is maintained automatically by relay_write(); if you're
> writing directly into the channel as LTT does though, part of the task
> is to call relay_commit() after the write, which updates the count and
> maintains consistency.

Hmmm, scratch, scratch ... there is something I still don't get here. 
I am in lockless_commit() - for what you say, and what I read, I would 
then expect the length of the sub-buffer would be mapped to user space, 
so I can memcpy out of the mmaped area and then take only the part that
is guaranteed to be consistent. But the atomic_add() is done on the 
rchan->scheme.lockless.fillcount[buffer_number]. So, I don't see how
that count pops out to user space, as rchan->buf to rchan->buf + rchan->
alloc_size is what is mapped, and rchan is a kernel-only struct that
is not exposed through mmap().

Where is the Easter bunny I am missing? Would you mind to give a little bit
of pseudocode? I am trying to understand how to do this:

/* in userspace */

char *buf;
int fd; /* for the channel */
int log_fd; /* for permanent storage */

/* open, blah ... */

buf = mmap (... fd ... 1M ...);

if (new stuff is ready /* how to detect, select() on fd? */) {
	/* bring the data to safety, copy only what is consistent */
	real_size = /* or where do I get this from? */
	write (log_fd, buf, real_size);
}

And then, once I have this, next time I read I don't want to read
what I already did; I guess I can advance my buf pointer to 
buf+real_size, but then how do I wrap around - meaning, how do I
detect when do I have to wrap?

>  > Yes, you have to guarantee the existence of the event data structures
>  > (the 'struct kue', the embedded 'struct kue_user' and the event data
>  > itself); if they are embedded into another structure that will dissa-
>  > pear, you can choose to:
>  > ...
> 
> Well, kmalloc() seems like the most straightforward and convenient way
> of managing space for all these individual events, if not the most
> efficient.  Are you thinking that sub-allocating them out of a larger
> buffer might make more sense, for instance?  If so, I'd suggest
> relayfs for that. ;-) Just kidding, ...

Good try :) As I said somewhere else, that'd be up to the client. Wanna
use kmalloc()? or kmem_cache_alloc()? or something else? I guess it'd 
be convenient to provide a pre-implemented circular buffer thingie ready
to use.

I guess the suballocation makes sense when you have a fixed message size
and you want to optimize the allocation; for that matter, kmalloc is no
different to any other pool, as they are just pools of base-2 sizes. In
some other sense, you are doing the same in relayfs, managing kind of
an allocation pool, but not as flexible (and thus probably faster) because
the usage model doesn't pose as many requirements as the memory pools have.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)

