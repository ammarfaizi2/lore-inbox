Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRJJGWP>; Wed, 10 Oct 2001 02:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274920AbRJJGWE>; Wed, 10 Oct 2001 02:22:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:40976 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S274875AbRJJGVw>;
	Wed, 10 Oct 2001 02:21:52 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15299.59317.38687.588368@cargo.ozlabs.ibm.com>
Date: Wed, 10 Oct 2001 16:16:21 +1000 (EST)
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <9q0ku6$175$1@penguin.transmeta.com>
In-Reply-To: <OF296D0EDC.4D1AE07A-ON88256AE0.00568638@boulder.ibm.com>
	<20011010040502.A726@athlon.random>
	<9q0ku6$175$1@penguin.transmeta.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> And THAT is the hard part. Doing lookup without locks ends up being
> pretty much worthless, because you need the locks for the removal
> anyway, at which point the whole thing looks pretty moot.
> 
> Did I miss something?

I believe this all becomes (much more) useful when you are doing
read-copy-update.

There is an assumption that anyone modifying the list (inserting or
deleting) would take a lock first, so the deletion is just a pointer
assignment.  Any reader traversing the list (without a lock) sees
either the old pointer or the new, which is fine.

The difficulty is in making sure that no reader is still inspecting
the list element you just removed before you free it, or modify any
field that the reader would be looking at (particularly the `next'
field :).  One way of doing that is to defer the free or modification
to a quiescent point.  If you have a separate `next_free' field, you
could safely put the element on a list of elements to be freed at the
next quiescent point.

Paul.
