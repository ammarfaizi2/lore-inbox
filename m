Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbTIDSkp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbTIDSjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:39:49 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52876 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265491AbTIDSik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:38:40 -0400
Date: Thu, 4 Sep 2003 19:38:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
Message-ID: <20030904183819.GF30394@mail.jlokier.co.uk>
References: <Pine.LNX.4.44.0309031924430.2462-100000@localhost.localdomain> <Pine.LNX.4.44.0309031201170.31853-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309031201170.31853-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > Of course (not).  That's the point, they do work on private mappings, but
> > the semantics are different on private mappings from on shared mappings:
> > on private mappings they're private to the mm, on shared mappings they're
> > shared with other mms (via the shared file).
> 
> Repeat after me: private read-only mappings are 100% equivalent to shared
> read-only mappings. No ifs, buts, or maybes. This is a FACT. It's a fact 
> codified in many years of Linux implementation, but it's a fact outside of 
> that too.

Thanks Linus.  I already knew this, I was in the audience of the old
thread about MAP_COPY, remember? :)

Please read below and think about it, because I'm convinced from your
3 emails later in this thread that you haven't thought about how COW
should interact with futexes.

If you don't have time, skip to the last paragraph.


The new futexes key off (mm,address) for a private mapping, and
(file,offset) for a shared mapping.  That is actually a user-visible
distinction, so I have to explain and justify it.

Private writable mapping: futex must be mm-local, obviously.  This is
a bug in the old futex code, which could be fixed as you say by
forcibly COWing the page.  But that's unnecessary: (mm,address) is fine.

Shared writable mapping: futex must be shared, obviously.

Read-only mapping: as yous say, private and shared are the same for a
read-only mapping, until you call mprotect() if you're permitted.
Anything which breaks that is wrong.

So what shall a futex do on a read-only mapping.  First, does it even
make sense?  A: Yes it does.  If I hand you a scoreboard file and tell
you to wait for changes to words in it, it's a legitimate use of
futexes on a read-only mapping.

Ok, now we understand that _this_ read-only mapping should not be mm-local.

But Linux does something weird at this point, if the new futex code's
hash keys on VM_SHARED.

If I hand you a scoreboard file opened O_RDWR, your futexes are keyed
on file pages.  But if I open it O_RDONLY, your futexes are mm-local.

  * I contend that the user-visible behaviour of a mapping should
  * _not_ depend on whether the file was opened with O_RDWR or O_RDONLY.

Thanks,
-- Jamie
