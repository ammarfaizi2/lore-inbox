Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272822AbRIGSvg>; Fri, 7 Sep 2001 14:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272824AbRIGSv0>; Fri, 7 Sep 2001 14:51:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57613 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S272822AbRIGSvM>; Fri, 7 Sep 2001 14:51:12 -0400
Date: Fri, 7 Sep 2001 11:47:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: expand_stack fix [was Re: 2.4.9aa3]
In-Reply-To: <20010903172445.N699@athlon.random>
Message-ID: <Pine.LNX.4.33.0109071142060.10472-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Sep 2001, Andrea Arcangeli wrote:
>
> Linus please include the attached patch to the next kernel, expand_stack
> is totally broken at the moment, we cannot mess with the mm vma layout
> if we don't hold the mmap_sem in write mode.

I disagree with the diagnosis..

expand_stack() has _never_ messed with the vma layout, and never should.
As such, from a vma list integrity standpoint it is fine.

Do we mess with the contents? Yes. But I'd much rather see a much more
minimal approach to the problem, on the order of:
 - make sure we only accept GROWSDOWN for anonymous areas (which don't
   care about the offset)
 - make the vm_start update atomic (possibly by just getting the pagetable
   spinlock).

> I considered implementing a read->write semaphore upgrade primitive but
> it cannot be reliable

There is no such thing. Never has been. It's a fundamentally impossible
operation. We may, at some point, decide to have a "read_for_write()" and
then "upgrade()" operations on the semaphore, but those inherently imply
some level of single-threading (ie only one read-for-writer accepted at
one time, with many pure readers), which makes it useless for this
particular case anyway.

However, having a finer-granularity spinlock _inside_ the semaphore (see
above suggestion) is a perfectly valid approach.

			Linus

