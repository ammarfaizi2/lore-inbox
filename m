Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317506AbSHCT0t>; Sat, 3 Aug 2002 15:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317525AbSHCT0s>; Sat, 3 Aug 2002 15:26:48 -0400
Received: from phobos.hpl.hp.com ([192.6.19.124]:65513 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S317506AbSHCT0m>;
	Sat, 3 Aug 2002 15:26:42 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15692.12093.514064.496253@napali.hpl.hp.com>
Date: Sat, 3 Aug 2002 12:30:05 -0700
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "David S. Miller" <davem@redhat.com>, davidm@hpl.hp.com,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <frankeh@watson.ibm.com>,
       <Martin.Bligh@us.ibm.com>, <wli@holomorpy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd) 
In-Reply-To: <Pine.LNX.4.44.0208031027330.3981-100000@home.transmeta.com>
References: <20020802.222024.21061449.davem@redhat.com>
	<Pine.LNX.4.44.0208031027330.3981-100000@home.transmeta.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sat, 3 Aug 2002 10:35:00 -0700 (PDT), Linus Torvalds <torvalds@transmeta.com> said:

  Linus> How well do you think something like your old patches would
  Linus> work if

  Linus>  - you _require_ 1024 colors in order to get the TLB speedup
  Linus> on some hypothetical machine (the same hypothetical machine
  Linus> that might hypothetically run on 95% of all hardware ;)

  Linus>  - the machine is under heavy load, and heavy load is exactly
  Linus> when you want this optimization to trigger.

Your point about wanting databases have access to giant pages even
under memory pressure is a good one.  I had not considered that
before.  However, what we really are talking about then is a security
or resource policy as to who gets to allocate from a reserved and
pinned pool of giant physical pages.  You don't need separate system
calls for that: with a transparent superpage framework and a
privileged & reserved giant-page pool, it's trivial to set up things
such that your favorite data base will always be able to get the giant
pages (and hence the giant TLB mappings) it wants.  The only thing you
lose in the transparent case is control over _which_ pages need to use
the pinned giant pages.  I can certainly imagine cases where this
would be an issue, but I kind of doubt it would be an issue for
databases.

As Dave Miller justly pointed out, it's stupid for a task not to ask
for giant pages for anonymous memory.  The only reason this is not a
smart thing overall is that globally it's not optimal (it is optimal
only locally, from the task's point of view).  So if the only barrier
to getting the giant pinned pages is needing to know about the new
system calls, I'll predict that very soon we'll have EVERY task in the
system allocating such pages (and LD_PRELOAD tricks make that pretty
much trivial).  Then we're back to square one, because the favorite
database may not even be able to start up, because all the "reserved"
memory is already used up by the other tasks.

Clearly there needs to be some additional policies in effect, no
matter what the implementation is (the normal VM policies don't work,
because, by definition, the pinned giant pages are not pageable).

In my opinion, the primary benefit of the separate syscalls is still
ease-of-implementation (which isn't unimportant, of course).

	--david
