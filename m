Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262974AbTCKXjF>; Tue, 11 Mar 2003 18:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262975AbTCKXjD>; Tue, 11 Mar 2003 18:39:03 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:17024 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S262974AbTCKXi7>; Tue, 11 Mar 2003 18:38:59 -0500
Date: Tue, 11 Mar 2003 23:49:38 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Daniel Phillips <phillips@arcor.de>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: atomic kernel operations are very tricky to export to user space (was  [RFC] Improved inode number allocation for HTree )
Message-ID: <20030311234938.GB16507@bjl1.jlokier.co.uk>
References: <11490000.1046367063@[10.10.2.4]> <3E6DBE3B.8030007@namesys.com> <3E6DDDD2.3050709@aitel.hist.no> <20030311133705.2157A102100@mx12.arcor-online.net> <3E6E545F.5060608@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E6E545F.5060608@namesys.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Allowing arbitrary filesystem operations to be 
> combined into one atomic transaction seems problematic for either user 
> space or the kernel, depending on what you do.
> 
> In general, allowing user space to lock things means that you trust user 
> space  to unlock.  This creates all sorts of trust troubles, and if you 
> force the unlock after some timeout, then the user space application 
> becomes vulnerable to DOS from other processes causing it to exceed the 
> timeout.
>
> Ideas on this are welcome.

You can allow user space to begin a transaction, do some operations
and end a transaction, possibly returning an "abort" result which
means userspace should assume the transaction did not commit any
results and/or whatever was read in the transaction was not reliable.

On the face of it this leaves userspace susceptible to DOS or indeed
fairness/livelock problems.  For example if another program is always
changing a directory entry, how can you read that whole directory
in a transaction?

Fairness/livelock problems are hard to avoid with any kinds of lock.
Even the kernel's internal locks have these problems in corner cases
(for example, remember when gettimeofday()'s clock access had to be
converted from using a spinlock to a sequence lock - and that still
doesn't _guarantee_ there is no problem in principle, it just reduces
the probability in all reasonable scenarios).

However, some remedies can be applied to filesystem transactions.  If
an operation would cause some other task's transaction to eventually
return an abort code, consider sleeping for a short duration.
Randomise that duration.  If the other transaction(s) have been
aborting repeatedly, consider lengthening the sleep duration and/or
specifically waiting for the other transaction to complete, to boost
the other task(s) likilihood of transaction success.  Randomise this
decision too.  If you know something about the type of other
transactions (such as it is trying to implement a read-write lock by
doing atomic operations on bytes in a file), consider exactly what
policy you hope to offer (writer preference?  reader preference?
something in between?)

By which point it has remarkable similarities to the problems of
fairness in the task scheduler, and fairness/livelock in locks.

-- Jamie
