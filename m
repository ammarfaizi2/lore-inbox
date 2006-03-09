Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWCINCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWCINCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWCINCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:02:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:39384 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751865AbWCINCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:02:22 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1141907339.16745.2.camel@localhost.localdomain> 
References: <1141907339.16745.2.camel@localhost.localdomain>  <1141855305.10606.6.camel@localhost.localdomain> <20060308161829.GC3669@elf.ucw.cz> <31492.1141753245@warthog.cambridge.redhat.com> <24309.1141848971@warthog.cambridge.redhat.com> <24280.1141904462@warthog.cambridge.redhat.com> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com,
       linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Thu, 09 Mar 2006 13:02:01 +0000
Message-ID: <26313.1141909321@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > So, you're saying that the LOCK and UNLOCK primitives don't actually modify
> > memory, but rather simply pin the cacheline into the CPU's cache and refuse to
> > let anyone else touch it?
> 
> Basically yes

What you said is incomplete: the cacheline is wangled into the Exclusive
state, and there it sits until modified (at which point it shifts to the
Modified state) or stolen (when it shifts to the Shared state). Whilst the x86
CPU might pin it there for the duration of the execution of the locked
instruction, it can't leave it there until it detects a spin_unlock() or
equivalent.

I guess LL/SC and LWARX/STWCX work by the reserved load wangling the cacheline
into the Exclusive state, and then the conditional store only doing the store
if the cacheline is still in that state. I don't know whether the conditional
store may modify a cacheline that's in the Modified state, but I'd guess you'd
need more state than that, because you have to pair it with a load reserved.


With inter-CPU memory barriers I think you have to consider the cache part of
the memory, not part of the CPU. The CPU _does_ make a memory modification;
it's just that it doesn't proceed any further than the cache, until the cache
coherency mechanisms transfer the change to another CPU, or until the cache
becomes full and the lock's line gets ejected.

> > No... it can't work like that. It *must* make a memory modification 
> 
> Then you'll have to argue with the chip designers because it doesn't.
> 
> Its all built around the cache coherency. To make a write to a cache
> line I must be the sole owner of the line. Look up "MESI cache" in a
> good book on the subject.

http://en.wikipedia.org/wiki/MESI_protocol

And a picture of the state machine may be found here:

https://www.cs.tcd.ie/Jeremy.Jones/vivio/caches/MESIHelp.htm

David
