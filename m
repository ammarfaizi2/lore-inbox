Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTICTlC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbTICTjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:39:32 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:12904 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S264324AbTICTix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:38:53 -0400
Date: Wed, 3 Sep 2003 20:40:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309031201170.31853-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309032016550.2555-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Sep 2003, Linus Torvalds wrote:
> On Wed, 3 Sep 2003, Hugh Dickins wrote:
> > 
> > Of course (not).  That's the point, they do work on private mappings, but
> > the semantics are different on private mappings from on shared mappings:
> > on private mappings they're private to the mm, on shared mappings they're
> > shared with other mms (via the shared file).
> 
> That's not true. It never has been true in Linux.
> 
> Private mappings that haven't been broken by COW (and a read-only mapping
> never will be) will see updates as they happen on the file that backs it.
> That's the fundamental difference between "mmap(MAP_PRIVATE)" and
> "read()".
> 
> You may not like it, and others too have not liked it (Hurd and Mach do 
> this big dance about MAP_COPY that really creates a static _copy_ of the 
> state at the time of the mmap), but it's just a fact.

I like the way Linux does that fine, it's the right way.  We have
a misunderstanding.  You're talking about the behaviour of mmaps,
I was talking about the behaviour of futexes placed within mmaps.

I'm not sure whether you've read this thread from the beginning,
Jamie started CCing you today.  The background is that Rusty's been
working on unpinning futex pages, Jamie discovered inconsistency with
current futex COW behaviour, that pushed me into realizing that the
whole physical-page-based futex implementation has been misguided
(adding more problems than it solves), Jamie has now made a patch
to implement sys_futex the simpler way, we're discussing the test
to distinguish a "private futex" from a "shared futex".

> Repeat after me: private read-only mappings are 100% equivalent to shared
> read-only mappings. No ifs, buts, or maybes. This is a FACT. It's a fact 
> codified in many years of Linux implementation, but it's a fact outside of 
> that too.

Maybe, but, if the file was opened for writing as well as reading, the
shared read-only mapping can be mprotected to read-write at any point,
which does lead to differences: which is why Linux is very careful
about deciding VM_SHARED, and it's quite difficult to explain.

If we document how sys_futex (which does not dirty a page, doesn't
even need a page there) behaves when placed within different kinds
of mmaps, it's easier for the reader to understand if we don't get
into such sophistications - hence choice of VM_MAYSHARE equivalent
to MAP_SHARED, never mind the readwriteness.

We'd both do better to be reading Jamie's patch.

Hugh

