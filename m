Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030503AbVIOVJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbVIOVJg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030506AbVIOVJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:09:36 -0400
Received: from nevyn.them.org ([66.93.172.17]:27537 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1030503AbVIOVJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:09:35 -0400
Date: Thu, 15 Sep 2005 17:09:31 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <npiggin@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
Message-ID: <20050915210931.GA14521@nevyn.them.org>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
	Nick Piggin <npiggin@novell.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>
References: <20050914212405.GD4966@opteron.random> <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com> <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random> <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org> <20050915162347.GC4122@opteron.random> <Pine.LNX.4.58.0509150928030.26803@g5.osdl.org> <20050915165117.GE4122@opteron.random> <Pine.LNX.4.58.0509151043370.26803@g5.osdl.org> <20050915180928.GI4122@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915180928.GI4122@opteron.random>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 08:09:28PM +0200, Andrea Arcangeli wrote:
> On Thu, Sep 15, 2005 at 10:52:14AM -0700, Linus Torvalds wrote:
> > And the PTRACE_POKE is _exactly_ the same thing. There's _zero_ 
> > difference. The fact that PTRACE_POKE _changes_ the data instead of just 
> > reading it doesn't change anything at all - the fact that data got changed 
> > in NO WAY invalidates the fact that processes might still depend on 
> > getting a SIGSEGV.
> 
> And this process may as well depend to see the on-disk changes that
> other threads are doing on the shared memory, and that will break
> regardless of what Linus changes in the kernel.
> 
> You also didn't make up any useful example where _writing_ (not reading
> like in your example) was involved. Your example is totally offtopic,
> since it only involved reading as far as I can tell.
> 
> I can't imagine where writing to a PROT_NONE is actually useful.

Well, you won't like this example any better, then, but this was a
frequently reported GDB bug for a while:

const int x;
int main()
{
  *x = 1;
  return 0;
}

x goes in rodata -> text segment -> on the same page as main.  If you
run to main in GDB, the page becomes writable.  The store doesn't
crash.  If you run it out of GDB, it crashes.

Sure, the trivial example's uninteresting.  But you can construct a
larger example with, say, *foo() = x replaced by *foo = x.  That's not
legal in C for a function foo, of course.  But you could probably
manage it in some other language, or in asm.  So you debug right around
where you're getting a crash in your application, and it doesn't crash.

Ptrace needs to be as unintrusive as possible.  Having the page COW
unexpectedly is a lot less bad than having it COW _and_ remain
writable.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
