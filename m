Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbVIOV5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVIOV5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 17:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbVIOV5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 17:57:54 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52539
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S965229AbVIOV5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 17:57:53 -0400
Date: Thu, 15 Sep 2005 23:58:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <npiggin@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>
Subject: Re: ptrace can't be transparent on readonly MAP_SHARED
Message-ID: <20050915215804.GN4122@opteron.random>
References: <Pine.LNX.4.61.0509151337260.16231@goblin.wat.veritas.com> <Pine.LNX.4.58.0509150805150.26803@g5.osdl.org> <20050915154702.GA4122@opteron.random> <Pine.LNX.4.58.0509150911180.26803@g5.osdl.org> <20050915162347.GC4122@opteron.random> <Pine.LNX.4.58.0509150928030.26803@g5.osdl.org> <20050915165117.GE4122@opteron.random> <Pine.LNX.4.58.0509151043370.26803@g5.osdl.org> <20050915180928.GI4122@opteron.random> <20050915210931.GA14521@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915210931.GA14521@nevyn.them.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 05:09:31PM -0400, Daniel Jacobowitz wrote:
> Well, you won't like this example any better, then, but this was a
> frequently reported GDB bug for a while:
> 
> const int x;
> int main()
> {
>   *x = 1;
>   return 0;
> }
> 
> x goes in rodata -> text segment -> on the same page as main.  If you
> run to main in GDB, the page becomes writable.  The store doesn't
> crash.  If you run it out of GDB, it crashes.
> 
> Sure, the trivial example's uninteresting.  But you can construct a
> larger example with, say, *foo() = x replaced by *foo = x.  That's not
> legal in C for a function foo, of course.  But you could probably
> manage it in some other language, or in asm.  So you debug right around
> where you're getting a crash in your application, and it doesn't crash.
> 
> Ptrace needs to be as unintrusive as possible.  Having the page COW
> unexpectedly is a lot less bad than having it COW _and_ remain
> writable.

Well this is the first real life example that explains why having
the pte marked readonly might actually make a difference in practice
(debugging a segfault when overwriting .rodata makes sense), so I like
it a lot better and infact I now for the first time can see why it can
help.

.text is not going to change on-disk, so the coherency loss for the
pagecache is not significant but losing the readonly protection would
prevent the segfault to trigger and so it makes debugging more fancy.

It certainly wasn't related to any PROT_NONE.

Thanks.
