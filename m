Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265664AbTIJU3P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265665AbTIJU3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:29:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:22914 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265664AbTIJU3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:29:08 -0400
Date: Wed, 10 Sep 2003 16:32:02 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jamie Lokier <jamie@shareable.org>
cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
In-Reply-To: <20030910201240.GB24424@mail.jlokier.co.uk>
Message-ID: <Pine.LNX.4.53.0309101619020.18924@chaos>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com>
 <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com>
 <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos>
 <20030910183138.GA23783@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101439390.18459@chaos>
 <20030910201240.GB24424@mail.jlokier.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003, Jamie Lokier wrote:

> Richard B. Johnson wrote:
> > 		cmpl	$1, %eax
> > 		jz	1f
> > 		jc	2f
> > 		call	do_default
> > 		jmp	more_code
> > 	1:	call	do_something_if_equal
> > 		jmp	more_code
> > 	2:	call	do_something_if_less
> > 	more_code:
> >
> > In every case, one has to jump around code for other execution paths
> > except the last, where you have to jump on condition anyway. There
> > is no free liunch, and the straight-through route, do_default
> > uas just as many jumps as the last.
>
> Here is your code optimised for no jumps in the "do_default" case:
>
> 		cmpl	$1,%eax
> 		jbe	1f
> 		call	do_default
> 	more_code:
> 		.subsection 1
> 	1:	jnz	2f
> 		call	do_something_if_equal
> 		jmp	more_code
> 	2:	call	do_something_if_less
> 		jmp	more_code
> 		.previous
>

You are a magician! Putting in a .subsection to hide the jump
is absolute bullshit. The built-in macros, ".subsection", and
".previous" just made the damn linker do the fixup. You just
did a long jump, out of the current code-stream, into some
other section. Then you jumped back. Hell of an optimization!
Might even reload the cache if you are lucky! Linker tricks
won't work for me. Also, putting some address on the stack
and executing 'ret' emulate a jump won't impress me either.

In any real code, only the last instruction in a procedure
gets to have a jump optimized away. Most of the times you
can't even do that because you need to restore different
stack-levels from different code paths (one reason to use
a frame-pointer, but still not good enough).

> > > How would you optimise it, if you were writing assembly language yourself?
>
> > I did. And I do this for a living. And, after 30 years of this shit
> > they still haven't fired me. Learn something. I'm pissed.
>
> It's ok to be pissed.  I'd be pissed too :)
>
> *ducks*
>
> Enjoy :)
> -- Jame
>

Sure do. I love it. I even get paid for this kind of stuff!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


