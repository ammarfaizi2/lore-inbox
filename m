Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSKKVeX>; Mon, 11 Nov 2002 16:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbSKKVeX>; Mon, 11 Nov 2002 16:34:23 -0500
Received: from mark.mielke.cc ([216.209.85.42]:60426 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261416AbSKKVeW>;
	Mon, 11 Nov 2002 16:34:22 -0500
Date: Mon, 11 Nov 2002 16:46:24 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROT_SEM + FUTEX
Message-ID: <20021111214624.GA610@mark.mielke.cc>
References: <A46BBDB345A7D5118EC90002A5072C7806CAC917@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CAC917@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 12:28:32PM -0800, Perez-Gonzalez, Inaky wrote:
> > I am beginning to play with the FUTEX system call. I am hoping that
> > PROT_SEM is not required, as I intend to scatter the words throughout
> > memory, and it would be a real pain to mprotect(PROT_SEM) each page
> > that contains a FUTEX word.
> Still you want to group them as much as possible - each time you lock
> a futex you are pinning the containing page into physical memory, that
> would cause that if you have, for example, 4000 futexes locked in 4000 
> different pages, there is going to be 4 MB of memory locked in ... it
> helps to have an allocator that ties them together.

This is not necessarily correct for a high-capacity, low-latency
application (i.e. a poorly designed thread architecture might suffer
from this problem -- but a poorly designed thread architecture suffers
from more problems than pinned pages).

As long as the person attempting to manipulate the FUTEX word succeeds
(i.e. 0 -> 1, or 0 -> -1, or whatever), futex_wait() need not be issued.
futex_wake() only pins the page for a brief period of time.

On IA-32, especially for PIII + P4, my understanding is that memory
words used for the purpose of thread synchronization, on an SMP
machine, should not allow two independent memory words to occupy the
same cache line. Also, if the memory word is used to synchronize
access to a smaller data structure (<128 bytes), it is actually
optimal to include the memory word used to synchronize access to the
data, and the data itself, in the same cache line.

Since the synchronization memory + data for a data structure may be
128 bytes or more (to at least put the synchronization memory words on
separate cache lines), 4000 such data structures would use up 100+
pages whether or not the memory was scattered. The real benefit of the
FUTEX concept is that spinlocks are 'cheap' and can be used with such
a granularity that the possibility of contention is extremely low.

As far as I understand - PROT_SEM has no effect on the behaviour of
FUTEX operations. I think it should be removed.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

