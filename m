Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUDGOh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 10:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263694AbUDGOhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 10:37:54 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:61948 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263684AbUDGOhk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 10:37:40 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Subject: Re: kernel stack challenge
Date: Wed, 7 Apr 2004 09:36:37 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <20040405234957.69998.qmail@web40509.mail.yahoo.com> <20040406132750$3d4e@grapevine.lcs.mit.edu> <s5gisgd9ipj.fsf@patl=users.sf.net>
In-Reply-To: <s5gisgd9ipj.fsf@patl=users.sf.net>
MIME-Version: 1.0
Message-Id: <04040709363701.02184@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 April 2004 11:40, Patrick J. LoPresti wrote:
> Jesse Pollard <jesse@cats-chateau.net> writes:
> > To prevent the memory leaks you have to have a mark and sweep GC.
> > Which still doesn't prevent circular loop leaks.
>
> What are you talking about?  A mark/sweep GC certainly DOES collect
> circular data structures.
>
> Perhaps you are thinking of reference counting GCs?

Ummm. I wasn't precise, sorry. some of the structures I was
thinking of must be imported from outside the LISP vm. Think
inode data, skb structures, parts of the security context. These
are not allocated by the LISP vm, and are not supported by it.
And these may be lost by it. I say may, since some security
aspects of these structures must be allocated by it (the VM),
and then passed externally to provid tracking capabilities.

Deallocation via mark/sweep would cause dangling pointers in these
external structures. And if you don't pass allocated structures to
these kernel objects then you must search for the corresponding
structures to the objects when a security decision must be made
(more overhead - which was why the LSM added security blob pointers
to the various structures).

The pure LISP structures are recovered - I was actually thinking
about the overhead of the mark/sweep causing significant amounts
of fragmentation until the mark/sweep is completed, which can still
leave a LOT of fragmentation behind.

> > Then you need a memory pool allocator to relocate all valid
> > references.
>
> Now you seem to talking about stop and copy, which is something else
> again.  And it is not required to avoid memory leaks, although it does
> fix fragmentation.

Yup. And it is hard. But even mark/sweep algorithms require that the
LISP interpreter stop. This was one of the problems with early LISP
machines - they would stop for 3-10 seconds during the mark/sweep - their
solution: two processors, and memory pools.

> > The combination is NOT small. BTW, the JVM suffers from circular
> > loop leaks too, since all it uses is reference counting (for speed).
>
> Which JVM are you talking about?  Every JVM I know of uses a real
> garbage collector, not some reference counting hack.

Most JVM used (at least the ones I've run across) are not designed for server 
use. These are very small JVMs, and they use reference counting. Once
the applet terminates, so does the JVM, and when restarted, it resets
memory allocations (aka memory pool).

> Perhaps you are thinking of Perl?

Nope. I have seen some small LISP interpreters use reference counting
- even wrote one of my own.

> Sergiy is right: A Lisp interpreter and runtime can be quite small and
> efficient.  And it can provide a secure "sandbox" for running
> questionable code safely.

Provided you don't depend on a GC, and have a way to prevent failure
(aborts) from causing system wide failure - which is a problem with
security reference monitors.

> Whether it is a good idea in this context is another question.  My
> concern is that it is hard (impossible?) to bound the memory
> consumption, both stack AND heap, of a Lisp program statically.  I
> would expect such bounds to be important for an implementation of a
> security model.  With a Lisp program, you cannot be sure under what
> conditions it will exceed whatever space you have alloted for it.
> Which means that, although it cannot crash the kernel, it cannot be
> used to build a reliable system, either...

It is impossible to guarantee memory bounds without eliminating most
of the capability of LISP (specific applications + data can be proven
bounded, but the general case cannot). The inherent recursive structure 
forces the memory to be unbound (especially the stack) in presence of
multiple function interactions. Sometimes (many times?) the recursive
structure can be eliminated by a very good optimizer, but this takes
both time and overhead - and is aimed at generating "just in time"
machine code, not LISP pcode.
