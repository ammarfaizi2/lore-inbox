Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262611AbRFGOAm>; Thu, 7 Jun 2001 10:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262588AbRFGOA0>; Thu, 7 Jun 2001 10:00:26 -0400
Received: from zeus.kernel.org ([209.10.41.242]:62886 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262615AbRFGOAB>;
	Thu, 7 Jun 2001 10:00:01 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed in the
In-Reply-To: <Pine.GSO.4.21.0106070042280.11086-100000@weyl.math.psu.edu>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 07 Jun 2001 14:25:37 +0200
In-Reply-To: <Pine.GSO.4.21.0106070042280.11086-100000@weyl.math.psu.edu> (Alexander Viro's message of "Thu, 7 Jun 2001 00:43:41 -0400 (EDT)")
Message-ID: <tgk82obhoe.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On 7 Jun 2001, Florian Weimer wrote:
> 
> > Matthias Urlichs <smurf@noris.de> writes:
> > 
> > > Select is defined as to return, with the appropriate bit set, if/when
> > > a nonblocking read/write on the file descriptor won't block. You'd get
> > > EBADF in this case, therefore causing the select to return would be a
> > > Good Thing.
> > 
> > How do you avoid race conditions if more than one thread is creating
> > file descriptors?  I think you can only do that under very special
> > circumstances, and it definitely requires some synchronization.
> 
> The same way as you do it for many threads doing any allocations.

There's a subtle difference: For malloc(), libc has a mutex (or
whatever), but for open(), socket() etc., no locking is performed, and
many libc functions create (and destroy) descriptors imlicitely.  

I still don't see how you can write maintainable and reliable software
with asynchronous close().  For example, if some select() call returns
EBADF after an asynchronous close(), you would have to scan the
descriptors to find the offending one, but in the meantime, it has
been reused by another thread.  What do you do in this case?

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
