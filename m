Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274224AbRITHTv>; Thu, 20 Sep 2001 03:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274261AbRITHTl>; Thu, 20 Sep 2001 03:19:41 -0400
Received: from [195.223.140.107] ([195.223.140.107]:17150 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274224AbRITHTc>;
	Thu, 20 Sep 2001 03:19:32 -0400
Date: Thu, 20 Sep 2001 09:19:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Howells <dhowells@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Linus Torvalds <torvalds@transmeta.com>, Ulrich.Weigand@de.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: Deadlock on the mm->mmap_sem
Message-ID: <20010920091954.B4332@athlon.random>
In-Reply-To: <andrea@suse.de> <8353.1000969557@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8353.1000969557@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Thu, Sep 20, 2001 at 08:05:57AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 08:05:57AM +0100, David Howells wrote:
> 
> Andrea Arcangeli <andrea@suse.de> wrote:
> > yes, one solution to the latency problem without writing the
> > ugly code would be simply to add a per-process counter to pass to a
> > modified rwsem api, then to hide the trickery in a mm_down_read macro.
> > such way it will be recursive _and_ fair.
> 
> You'd need a counter per-process per-mm_struct. Otherwise you couldn't do a
> recursive read lock simultaneously in two or more different processes, and
> also allow any one process to lock multiple mm_structs.

the process doesn't need to lock multiple mm_structs at the same time.

I mean, we just need to allow a single task to go through, doesn't
matter if the other tasks/threads are stuck, they will wait the write to
finish. that's exactly where the fairness cames from.

The only thing that matters is that if a certain task passes the first
read lock of its mmstruct semaphore, it will also pass any other
further recursive lock again of its own _same_ mmstruct. So a
per-process recursor is all what we need.

Must not be per-mm, per-mm would work but it would simply introduce the
unfairness again.

Andrea
