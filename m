Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTIHUBO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTIHUBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:01:14 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:52879 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263573AbTIHUBK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:01:10 -0400
Date: Mon, 8 Sep 2003 21:00:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make futex waiters take an mm or inode reference
Message-ID: <20030908200030.GG27097@mail.jlokier.co.uk>
References: <20030908183416.GF27097@mail.jlokier.co.uk> <Pine.LNX.4.44.0309081144390.3202-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309081144390.3202-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> So is there any reason to really having "private.mm" AT ALL? From what I
> can tell, it is not actually ever used (all "mm" users are "current->mm"),
> so I don't see the point of incrementing a count for it either.
> 
> Or did I miss something?

Yes.  The hash table is global to all processes, so "mm" is needed as
a hash key whether it is user-visible or not.

A process can do FUTEX_FD and then pass that fd to another mm, in
numerous ways (fork, exec, socket).  Although that does have a
well-defined behaviour at present, I agree it's absolutely fine to
declare that "programmer error" and say it doesn't do anything useful.

But the implemenation is a security problem: a broken program will
cause _other_ unrelated programs to fail, by stealing their wakeups.

That is very bad.  A userspace error should never cause random
unrelated programs to fail.

Possible fixes include:
	- destroying futexes of an mm when the mm is destroyed
	- marking the fds in a special way to prevent them being passed on
	- taking an mm reference

Taking an mm reference is the simplest.

-- Jamie

