Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbTGDLxK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 07:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266005AbTGDLxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 07:53:10 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:55434 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S266004AbTGDLxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 07:53:07 -0400
Date: Fri, 4 Jul 2003 13:07:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Zack Weinberg <zack@codesourcery.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Garbage collectors and VM (was Re: What to expect with the 2.6 VM)
Message-ID: <20030704120732.GD22105@mail.jlokier.co.uk>
References: <20030703184825.GA17090@mail.jlokier.co.uk> <87u1a2srwl.fsf@egil.codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u1a2srwl.fsf@egil.codesourcery.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zack Weinberg wrote:
> Thus, a new pseudo-device, with the semantics:

I like it!  I'd use it, too.

>  * mmapping it creates anonymous pages, just like /dev/zero.
>  * Data written to the file descriptor is interpreted as a list of
>    user-space pointers to pages.  All the pages pointed to, that
>    are anonymous pages created by mmapping that same descriptor,
>    become read-only.
>  * But when the program takes a write fault to such a page, the
>    kernel simply records the user-space address of that page,
>    resets it to read-write, and restarts the faulting instruction.
>    The user space process doesn't get a signal.
>  * Reading from the descriptor produces a list of user-space pointers
>    to all the pages that have been reset to read-write since the last
>    read.

Would it be appropriate to have a limit on the number of pages which
become writable before a signal is delivered instead of continuing to
make more pages writable?  Just like the kernel, sometimes its good to
limit the number of dirty pages in flight in userspace, too.

>  * I never decided what to do if the program forks.  The application I
>    personally care about doesn't do that, but for a general GC like
>    Boehm it matters.

It should clone the state, obviously, and COW should be invisible to
the application :)

Btw, are these pages swappable?

On a different but related topic, it would be most cool if there were
a way for the kernel to request memory to be released from a userspace
GC, prior to swapping the GC's memory.  Currently the best strategy is
for each GC to guess how much of the machine's RAM it can use, however
this is not a good strategy if you wish to launch multiple programs
each of which has its own GC, nor is it a particularly good balance
between GC application pages and other page-cache pages.

-- Jamie
