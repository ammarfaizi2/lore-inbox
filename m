Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275511AbRJJLyi>; Wed, 10 Oct 2001 07:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275527AbRJJLy3>; Wed, 10 Oct 2001 07:54:29 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25616 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S275511AbRJJLyV>;
	Wed, 10 Oct 2001 07:54:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion 
In-Reply-To: Your message of "Wed, 10 Oct 2001 05:05:10 GMT."
             <9q0ku6$175$1@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 21:54:39 +1000
Message-ID: <12638.1002714879@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Oct 2001 05:05:10 +0000 (UTC), 
torvalds@transmeta.com (Linus Torvalds) wrote:
>Now, before people get all excited, what is this particular code
>actually _good_ for?
>
>Creating a lock-free list that allows insertion concurrently with lookup
>is _easy_.
>
>But what's the point? If you insert stuff, you eventually have to remove
>it. What goes up must come down. Insert-inane-quote-here.
>
>And THAT is the hard part. Doing lookup without locks ends up being
>pretty much worthless, because you need the locks for the removal
>anyway, at which point the whole thing looks pretty moot.

<pedantic>

It is possible to do completely lock free queue management, I have done
it (once).  There are several major requirements :-

* Storage must never change its type (type stable storage).  Once a
  block has been assigned as struct foo, it must always contain struct
  foo.  This can be relaxed slightly as long as the data types have a
  common header format.

  The biggest problem this causes is that storage can never be released
  and unmapped.  You never know if somebody is going to follow an old
  pointer to access storage that you freed.  You must put the storage
  on a free list for struct foo instead of unmapping it, to maintain
  the type stable storage.

* Every piece of code that traverses the data tree for structure foo
  must take a copy of each struct foo into local storage.  After taking
  a copy it must verify that its local copy is self consistent, via
  validity indicators in each struct.  The validity indicators are
  typically generation numbers, whatever you use, the indicators must
  be atomically updated and atomically read, with suitable wmb and rmb
  barriers for machines with weak memory ordering.

* After following a pointer in your local copy of struct foo to access
  another data area, you must verify that the master version of your
  local copy has not been changed.  If the master copy has changed then
  the pointer you just followed is no longer reliable.  In almost every
  case you have to start the traversal from the beginning.  It makes
  for very convoluted reader and updater code.

</pedantic>

The only reason I used lock free read and update was to hook into an
existing system that mandated sub second responses.  Some of the new
operations that were performed during list traversal and update were
subject to unbounded delays that were completely outside my control.  I
could not afford to lock the data structures during traversal because
any delay in the new operations would completely stall the existing
system, also the existing system had to be able to retrieve and delete
data for the new operations at any time.

I don't recommend doing lock free unless you have absolutely no
alternative.  It requires convoluted code, it is difficult to debug, it
is expensive on memory bandwidth (forget zero copy) and tends to be
expensive on storage as well.

If you are interested in lock free work, take a look at
http://www.cs.pitt.edu/~moir/papers.html, particularly Practical
Implementations of Non-Blocking Synchronization Primitives.  But
beware, that paper has an error which caused intermittent bugs that
took me 5 months to track down.  Section 3.3, proc Copy, line 6 should
be

6:     y := addr->data[i];

